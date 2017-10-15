Received: from eggs.gnu.org ([2001:4830:134:3::10]:39218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3mFk-0005mZ-4i
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3mFg-0001Sb-VZ
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:59:04 -0400
Received: from hermes.schrodt.org ([2a01:488:66:1000:b24d:49f5:0:1]:50304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3mFg-0001SA-Mq
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:59:00 -0400
From: Martin Schrodt <martin@schrodt.org>
Date: Sun, 15 Oct 2017 18:58:58 +0200
Message-Id: <20171015165858.19937-3-martin@schrodt.org>
In-Reply-To: <20171015165858.19937-1-martin@schrodt.org>
References: <20171015165858.19937-1-martin@schrodt.org>
Subject: [Qemu-devel] [PATCH v3 2/2] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Currently, the HDA device tries to sync itself with the QEMU audio
backend by waiting for the guest driver to handle buffer completion
interrupts. This causes the backend to often read too much data from the
device, as well as running out of data whenever the guest takes too long
to handle the interrupt.

According to the HDA specification, the guest is also not required to
use interrupts, but can also sync itself by polling the LPIB registers.

This patch will introduce high frequency (1000Hz) timers that interface
with the device and allow for much smoother emulation of the LPIB
registers. Since the timing is now provided by these timers, the need
to wait for buffer completion interrupts also ceases.

Together with change of the Pulse Audio Driver, this allows for
crackle free, clean playback using the HDA device. I have not yet tested
this, but this should also improve the output with other backends
(for example Alsa).

Signed-off-by: Martin Schrodt <martin@schrodt.org>
---
 hw/audio/hda-codec.c | 193 ++++++++++++++++++++++++++++++++++++++++-----------
 hw/audio/intel-hda.c |   7 --
 2 files changed, 154 insertions(+), 46 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 5402cd196c..ab89158bfc 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
@@ -126,6 +127,11 @@ static void hda_codec_parse_fmt(uint32_t format, struct audsettings *as)
 #define   PARAM nomixemu
 #include  "hda-codec-common.h"
 
+#define HDA_TIMER_TICKS (SCALE_MS)
+#define MAX_CORR (SCALE_US * 100)
+#define B_SIZE sizeof(st->buf)
+#define B_MASK (sizeof(st->buf) - 1)
+
 /* -------------------------------------------------------------------------- */
 
 static const char *fmt2name[] = {
@@ -154,8 +160,13 @@ struct HDAAudioStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    uint8_t buf[HDA_BUFFER_SIZE];
-    uint32_t bpos;
+    uint8_t compat_buf[HDA_BUFFER_SIZE];
+    uint32_t compat_bpos;
+    uint8_t buf[8192]; /* size must be power of two */
+    int64_t rpos;
+    int64_t wpos;
+    QEMUTimer *buft;
+    int64_t buft_start;
 };
 
 #define TYPE_HDA_AUDIO "hda-audio"
@@ -176,53 +187,146 @@ struct HDAAudioState {
     bool     mixer;
 };
 
+static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
+{
+    return 2 * st->as.nchannels * st->as.freq;
+}
+
+static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
+{
+    int64_t corr =
+        NANOSECONDS_PER_SECOND * target_pos / hda_bytes_per_second(st);
+    if (corr > MAX_CORR) {
+        corr = MAX_CORR;
+    } else if (corr < -MAX_CORR) {
+        corr = -MAX_CORR;
+    }
+    atomic_fetch_add(&st->buft_start, corr);
+}
+
+static void hda_audio_input_timer(void *opaque)
+{
+    HDAAudioStream *st = opaque;
+
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
+                          / NANOSECONDS_PER_SECOND;
+    wanted_rpos &= -4; /* IMPORTANT! clip to frames */
+
+    if (wanted_rpos <= rpos) {
+        /* we already transmitted the data */
+        goto out_timer;
+    }
+
+    int64_t to_transfer = audio_MIN(wpos - rpos, wanted_rpos - rpos);
+    while (to_transfer) {
+        uint32_t start = (rpos & B_MASK);
+        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        int rc = hda_codec_xfer(
+                &st->state->hda, st->stream, false, st->buf + start, chunk);
+        if (!rc) {
+            break;
+        }
+        rpos += chunk;
+        to_transfer -= chunk;
+        atomic_fetch_add(&st->rpos, chunk);
+    }
+
+out_timer:
+
+    if (st->running) {
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    }
+}
+
 static void hda_audio_input_cb(void *opaque, int avail)
 {
     HDAAudioStream *st = opaque;
-    int recv = 0;
-    int len;
-    bool rc;
-
-    while (avail - recv >= sizeof(st->buf)) {
-        if (st->bpos != sizeof(st->buf)) {
-            len = AUD_read(st->voice.in, st->buf + st->bpos,
-                           sizeof(st->buf) - st->bpos);
-            st->bpos += len;
-            recv += len;
-            if (st->bpos != sizeof(st->buf)) {
-                break;
-            }
+
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), avail);
+
+    hda_timer_sync_adjust(st, -((wpos - rpos) + to_transfer - (B_SIZE >> 1)));
+
+    while (to_transfer) {
+        uint32_t start = (uint32_t) (wpos & B_MASK);
+        uint32_t chunk = (uint32_t) audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t read = AUD_read(st->voice.in, st->buf + start, chunk);
+        wpos += read;
+        to_transfer -= read;
+        atomic_fetch_add(&st->wpos, read);
+        if (chunk != read) {
+            break;
         }
-        rc = hda_codec_xfer(&st->state->hda, st->stream, false,
-                            st->buf, sizeof(st->buf));
+    }
+}
+
+static void hda_audio_output_timer(void *opaque)
+{
+    HDAAudioStream *st = opaque;
+
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
+                          / NANOSECONDS_PER_SECOND;
+    wanted_wpos &= -4; /* IMPORTANT! clip to frames */
+
+    if (wanted_wpos <= wpos) {
+        /* we already received the data */
+        goto out_timer;
+    }
+
+    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
+    while (to_transfer) {
+        uint32_t start = (wpos & B_MASK);
+        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        int rc = hda_codec_xfer(
+                &st->state->hda, st->stream, true, st->buf + start, chunk);
         if (!rc) {
             break;
         }
-        st->bpos = 0;
+        wpos += chunk;
+        to_transfer -= chunk;
+        atomic_fetch_add(&st->wpos, chunk);
+    }
+
+out_timer:
+
+    if (st->running) {
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
     }
 }
 
 static void hda_audio_output_cb(void *opaque, int avail)
 {
     HDAAudioStream *st = opaque;
-    int sent = 0;
-    int len;
-    bool rc;
-
-    while (avail - sent >= sizeof(st->buf)) {
-        if (st->bpos == sizeof(st->buf)) {
-            rc = hda_codec_xfer(&st->state->hda, st->stream, true,
-                                st->buf, sizeof(st->buf));
-            if (!rc) {
-                break;
-            }
-            st->bpos = 0;
-        }
-        len = AUD_write(st->voice.out, st->buf + st->bpos,
-                        sizeof(st->buf) - st->bpos);
-        st->bpos += len;
-        sent += len;
-        if (st->bpos != sizeof(st->buf)) {
+
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t to_transfer = audio_MIN(wpos - rpos, avail);
+
+    hda_timer_sync_adjust(st, (wpos - rpos) - to_transfer - (B_SIZE >> 1));
+
+    while (to_transfer) {
+        uint32_t start = (uint32_t) (rpos & B_MASK);
+        uint32_t chunk = (uint32_t) audio_MIN(B_SIZE - start, to_transfer);
+        uint32_t written = AUD_write(st->voice.out, st->buf + start, chunk);
+        rpos += written;
+        to_transfer -= written;
+        atomic_fetch_add(&st->rpos, written);
+        if (chunk != written) {
             break;
         }
     }
@@ -239,6 +343,15 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
     st->running = running;
     dprint(st->state, 1, "%s: %s (stream %d)\n", st->node->name,
            st->running ? "on" : "off", st->stream);
+    if (running) {
+        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        st->rpos = 0;
+        st->wpos = 0;
+        st->buft_start = now;
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    } else {
+        timer_del(st->buft);
+    }
     if (st->output) {
         AUD_set_active_out(st->voice.out, st->running);
     } else {
@@ -286,10 +399,12 @@ static void hda_audio_setup(HDAAudioStream *st)
         st->voice.out = AUD_open_out(&st->state->card, st->voice.out,
                                      st->node->name, st,
                                      hda_audio_output_cb, &st->as);
+        st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL, hda_audio_output_timer, st);
     } else {
         st->voice.in = AUD_open_in(&st->state->card, st->voice.in,
                                    st->node->name, st,
                                    hda_audio_input_cb, &st->as);
+        st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL, hda_audio_input_timer, st);
     }
 }
 
@@ -505,7 +620,6 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
                 /* unmute output by default */
                 st->gain_left = QEMU_HDA_AMP_STEPS;
                 st->gain_right = QEMU_HDA_AMP_STEPS;
-                st->bpos = sizeof(st->buf);
                 st->output = true;
             } else {
                 st->output = false;
@@ -532,6 +646,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
         if (st->node == NULL) {
             continue;
         }
+        timer_del(st->buft);
         if (st->output) {
             AUD_close_out(&a->card, st->voice.out);
         } else {
@@ -592,8 +707,8 @@ static const VMStateDescription vmstate_hda_audio_stream = {
         VMSTATE_UINT32(gain_right, HDAAudioStream),
         VMSTATE_BOOL(mute_left, HDAAudioStream),
         VMSTATE_BOOL(mute_right, HDAAudioStream),
-        VMSTATE_UINT32(bpos, HDAAudioStream),
-        VMSTATE_BUFFER(buf, HDAAudioStream),
+        VMSTATE_UINT32(compat_bpos, HDAAudioStream),
+        VMSTATE_BUFFER(compat_buf, HDAAudioStream),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 18a50a8f83..721eba792d 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -407,13 +407,6 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
     if (st->bpl == NULL) {
         return false;
     }
-    if (st->ctl & (1 << 26)) {
-        /*
-         * Wait with the next DMA xfer until the guest
-         * has acked the buffer completion interrupt
-         */
-        return false;
-    }
 
     left = len;
     s = st->bentries;
-- 
2.14.2
