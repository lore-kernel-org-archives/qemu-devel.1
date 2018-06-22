Received: from eggs.gnu.org ([2001:4830:134:3::10]:55775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz4-0005w0-Vs
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fWJz1-0001er-MI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fWJz1-0001ej-GR
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:12:03 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 22 Jun 2018 13:11:56 +0200
Message-Id: <20180622111200.30561-2-kraxel@redhat.com>
In-Reply-To: <20180622111200.30561-1-kraxel@redhat.com>
References: <20180622111200.30561-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/5] audio/hda: create millisecond timers
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
Cc: martin@schrodt.org, maxehr@umiacs.umd.edu, Gerd Hoffmann <kraxel@redhat.com>

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

Signed-off-by: Martin Schrodt <martin@schrodt.org>
Message-id: 20171015184033.2951-3-martin@schrodt.org

[ kraxel: keep old code for compatibility with older qemu versions,
          add property to switch code paths at runtime ]
[ kraxel: new code is disabled by default, use-timer=on enables it ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/hda-codec.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/audio/intel-hda.c |   7 --
 2 files changed, 237 insertions(+), 33 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index e8aa7842e6..c62e78c859 100644
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
@@ -174,55 +185,201 @@ struct HDAAudioState {
     /* properties */
     uint32_t debug;
     bool     mixer;
+    bool     use_timer;
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
+        }
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
+        if (!rc) {
+            break;
+        }
+        wpos += chunk;
+        to_transfer -= chunk;
+        atomic_fetch_add(&st->wpos, chunk);
+    }
+
+out_timer:
+
+    if (st->running) {
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    }
+}
+
+static void hda_audio_output_cb(void *opaque, int avail)
+{
+    HDAAudioStream *st = opaque;
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
+            break;
+        }
+    }
+}
+
+static void hda_audio_compat_input_cb(void *opaque, int avail)
+{
+    HDAAudioStream *st = opaque;
     int recv = 0;
     int len;
     bool rc;
 
-    while (avail - recv >= sizeof(st->buf)) {
-        if (st->bpos != sizeof(st->buf)) {
-            len = AUD_read(st->voice.in, st->buf + st->bpos,
-                           sizeof(st->buf) - st->bpos);
-            st->bpos += len;
+    while (avail - recv >= sizeof(st->compat_buf)) {
+        if (st->compat_bpos != sizeof(st->compat_buf)) {
+            len = AUD_read(st->voice.in, st->compat_buf + st->compat_bpos,
+                           sizeof(st->compat_buf) - st->compat_bpos);
+            st->compat_bpos += len;
             recv += len;
-            if (st->bpos != sizeof(st->buf)) {
+            if (st->compat_bpos != sizeof(st->compat_buf)) {
                 break;
             }
         }
         rc = hda_codec_xfer(&st->state->hda, st->stream, false,
-                            st->buf, sizeof(st->buf));
+                            st->compat_buf, sizeof(st->compat_buf));
         if (!rc) {
             break;
         }
-        st->bpos = 0;
+        st->compat_bpos = 0;
     }
 }
 
-static void hda_audio_output_cb(void *opaque, int avail)
+static void hda_audio_compat_output_cb(void *opaque, int avail)
 {
     HDAAudioStream *st = opaque;
     int sent = 0;
     int len;
     bool rc;
 
-    while (avail - sent >= sizeof(st->buf)) {
-        if (st->bpos == sizeof(st->buf)) {
+    while (avail - sent >= sizeof(st->compat_buf)) {
+        if (st->compat_bpos == sizeof(st->compat_buf)) {
             rc = hda_codec_xfer(&st->state->hda, st->stream, true,
-                                st->buf, sizeof(st->buf));
+                                st->compat_buf, sizeof(st->compat_buf));
             if (!rc) {
                 break;
             }
-            st->bpos = 0;
+            st->compat_bpos = 0;
         }
-        len = AUD_write(st->voice.out, st->buf + st->bpos,
-                        sizeof(st->buf) - st->bpos);
-        st->bpos += len;
+        len = AUD_write(st->voice.out, st->compat_buf + st->compat_bpos,
+                        sizeof(st->compat_buf) - st->compat_bpos);
+        st->compat_bpos += len;
         sent += len;
-        if (st->bpos != sizeof(st->buf)) {
+        if (st->compat_bpos != sizeof(st->compat_buf)) {
             break;
         }
     }
@@ -239,6 +396,17 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
     st->running = running;
     dprint(st->state, 1, "%s: %s (stream %d)\n", st->node->name,
            st->running ? "on" : "off", st->stream);
+    if (st->state->use_timer) {
+        if (running) {
+            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+            st->rpos = 0;
+            st->wpos = 0;
+            st->buft_start = now;
+            timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+        } else {
+            timer_del(st->buft);
+        }
+    }
     if (st->output) {
         AUD_set_active_out(st->voice.out, st->running);
     } else {
@@ -274,6 +442,9 @@ static void hda_audio_set_amp(HDAAudioStream *st)
 
 static void hda_audio_setup(HDAAudioStream *st)
 {
+    bool use_timer = st->state->use_timer;
+    audio_callback_fn cb;
+
     if (st->node == NULL) {
         return;
     }
@@ -283,13 +454,25 @@ static void hda_audio_setup(HDAAudioStream *st)
            fmt2name[st->as.fmt], st->as.freq);
 
     if (st->output) {
+        if (use_timer) {
+            cb = hda_audio_output_cb;
+            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                    hda_audio_output_timer, st);
+        } else {
+            cb = hda_audio_compat_output_cb;
+        }
         st->voice.out = AUD_open_out(&st->state->card, st->voice.out,
-                                     st->node->name, st,
-                                     hda_audio_output_cb, &st->as);
+                                     st->node->name, st, cb, &st->as);
     } else {
+        if (use_timer) {
+            cb = hda_audio_input_cb;
+            st->buft = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                    hda_audio_input_timer, st);
+        } else {
+            cb = hda_audio_compat_input_cb;
+        }
         st->voice.in = AUD_open_in(&st->state->card, st->voice.in,
-                                   st->node->name, st,
-                                   hda_audio_input_cb, &st->as);
+                                   st->node->name, st, cb, &st->as);
     }
 }
 
@@ -505,7 +688,7 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
                 /* unmute output by default */
                 st->gain_left = QEMU_HDA_AMP_STEPS;
                 st->gain_right = QEMU_HDA_AMP_STEPS;
-                st->bpos = sizeof(st->buf);
+                st->compat_bpos = sizeof(st->compat_buf);
                 st->output = true;
             } else {
                 st->output = false;
@@ -532,6 +715,9 @@ static void hda_audio_exit(HDACodecDevice *hda)
         if (st->node == NULL) {
             continue;
         }
+        if (a->use_timer) {
+            timer_del(st->buft);
+        }
         if (st->output) {
             AUD_close_out(&a->card, st->voice.out);
         } else {
@@ -581,6 +767,26 @@ static void hda_audio_reset(DeviceState *dev)
     }
 }
 
+static bool vmstate_hda_audio_stream_buf_needed(void *opaque)
+{
+    HDAAudioStream *st = opaque;
+    return st->state->use_timer;
+}
+
+static const VMStateDescription vmstate_hda_audio_stream_buf = {
+    .name = "hda-audio-stream/buffer",
+    .version_id = 1,
+    .needed = vmstate_hda_audio_stream_buf_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER(buf, HDAAudioStream),
+        VMSTATE_INT64(rpos, HDAAudioStream),
+        VMSTATE_INT64(wpos, HDAAudioStream),
+        VMSTATE_TIMER_PTR(buft, HDAAudioStream),
+        VMSTATE_INT64(buft_start, HDAAudioStream),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_hda_audio_stream = {
     .name = "hda-audio-stream",
     .version_id = 1,
@@ -592,9 +798,13 @@ static const VMStateDescription vmstate_hda_audio_stream = {
         VMSTATE_UINT32(gain_right, HDAAudioStream),
         VMSTATE_BOOL(mute_left, HDAAudioStream),
         VMSTATE_BOOL(mute_right, HDAAudioStream),
-        VMSTATE_UINT32(bpos, HDAAudioStream),
-        VMSTATE_BUFFER(buf, HDAAudioStream),
+        VMSTATE_UINT32(compat_bpos, HDAAudioStream),
+        VMSTATE_BUFFER(compat_buf, HDAAudioStream),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_hda_audio_stream_buf,
+        NULL
     }
 };
 
@@ -615,6 +825,7 @@ static const VMStateDescription vmstate_hda_audio = {
 static Property hda_audio_properties[] = {
     DEFINE_PROP_UINT32("debug", HDAAudioState, debug,   0),
     DEFINE_PROP_BOOL("mixer", HDAAudioState, mixer,  true),
+    DEFINE_PROP_BOOL("use-timer", HDAAudioState, use_timer, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 948268afd8..23a2cf6484 100644
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
2.9.3
