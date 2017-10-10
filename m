Received: from eggs.gnu.org ([2001:4830:134:3::10]:57623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e1ybA-0001ra-Kn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e1yb6-0006h0-IU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:45:44 -0400
Received: from hermes.schrodt.org ([2a01:488:66:1000:b24d:49f5:0:1]:46268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e1yb6-0006gJ-39
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:45:40 -0400
From: qemu@martin.schrodt.org
Date: Tue, 10 Oct 2017 19:45:38 +0200
Message-Id: <20171010174538.25074-1-qemu@martin.schrodt.org>
Subject: [Qemu-devel] [PATCH] Several fixes for the Pulse Audio driver,
 and the HDA device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Martin Schrodt <martin@schrodt.org>

From: Martin Schrodt <martin@schrodt.org>

Please see

https://www.reddit.com/r/VFIO/comments/74vokw/improved_pulse_audio_driver_for_qemu/

for motivation, and more coverage.

Changes:

- Remove PA reader/writer threads from paaudio.c, and do IO from the audio timer directly.
- Add 1 millisecond timers which interface with the HDA device, pulling and pushing data
  to and from it, to enable the guest driver to measure DMA timing by just looking the
  LPIB registers.
- Expose new configurable settings, such as TLENGTH and FRAGSIZE, plus settings to
  enable PA_STREAM_ADJUST_LATENCY for input and output device separately.
- Fix the input delay when first using the input device.

Signed-off-by: Martin Schrodt <martin@schrodt.org>
---
 audio/audio.c             |   4 +
 audio/audio_int.h         |   2 +
 audio/paaudio.c           | 640 ++++++++++++++++++++--------------------------
 hw/audio/hda-codec.c      | 218 +++++++++++++---
 hw/audio/intel-hda-defs.h |   1 +
 hw/audio/intel-hda.c      |  14 +-
 6 files changed, 468 insertions(+), 411 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index beafed209b..fba1604c34 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2066,3 +2066,7 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         }
     }
 }
+
+int64_t audio_get_timer_ticks(void) {
+    return conf.period.ticks;
+}
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5bcb1c60e1..2f7fc4f8ac 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -214,6 +214,8 @@ extern struct audio_driver pa_audio_driver;
 extern struct audio_driver spice_audio_driver;
 extern const struct mixeng_volume nominal_volume;
 
+int64_t audio_get_timer_ticks(void);
+
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 65beb6f010..089af32e4d 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -1,16 +1,44 @@
-/* public domain */
+/*
+ * QEMU ALSA audio driver
+ *
+ * Copyright (c) 2017 Martin Schrodt (spheenik)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
 #include "audio.h"
 
+
 #include <pulse/pulseaudio.h>
+#include <include/qemu/timer.h>
 
 #define AUDIO_CAP "pulseaudio"
 #include "audio_int.h"
-#include "audio_pt_int.h"
 
 typedef struct {
-    int samples;
+    int buffer_size;
+    int tlength;
+    int fragsize;
+#ifdef PA_STREAM_ADJUST_LATENCY
+    int adjust_latency_out;
+    int adjust_latency_in;
+#endif
     char *server;
     char *sink;
     char *source;
@@ -24,30 +52,21 @@ typedef struct {
 
 typedef struct {
     HWVoiceOut hw;
-    int done;
-    int live;
-    int decr;
-    int rpos;
     pa_stream *stream;
-    void *pcm_buf;
-    struct audio_pt pt;
     paaudio *g;
+    pa_sample_spec ss;
+    pa_buffer_attr ba;
 } PAVoiceOut;
 
 typedef struct {
     HWVoiceIn hw;
-    int done;
-    int dead;
-    int incr;
-    int wpos;
     pa_stream *stream;
-    void *pcm_buf;
-    struct audio_pt pt;
-    const void *read_data;
-    size_t read_index, read_length;
     paaudio *g;
+    pa_sample_spec ss;
+    pa_buffer_attr ba;
 } PAVoiceIn;
 
+
 static void qpa_audio_fini(void *opaque);
 
 static void GCC_FMT_ATTR (2, 3) qpa_logerr (int err, const char *fmt, ...)
@@ -84,207 +103,85 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
 #define CHECK_SUCCESS_GOTO(c, rerror, expression, label)        \
     do {                                                        \
         if (!(expression)) {                                    \
-            if (rerror) {                                       \
-                *(rerror) = pa_context_errno ((c)->context);    \
-            }                                                   \
+            *(rerror) = pa_context_errno ((c)->context);        \
             goto label;                                         \
         }                                                       \
     } while (0);
 
+
 #define CHECK_DEAD_GOTO(c, stream, rerror, label)                       \
     do {                                                                \
         if (!(c)->context || !PA_CONTEXT_IS_GOOD (pa_context_get_state((c)->context)) || \
             !(stream) || !PA_STREAM_IS_GOOD (pa_stream_get_state ((stream)))) { \
             if (((c)->context && pa_context_get_state ((c)->context) == PA_CONTEXT_FAILED) || \
                 ((stream) && pa_stream_get_state ((stream)) == PA_STREAM_FAILED)) { \
-                if (rerror) {                                           \
-                    *(rerror) = pa_context_errno ((c)->context);        \
-                }                                                       \
+                *(rerror) = pa_context_errno ((c)->context);            \
             } else {                                                    \
-                if (rerror) {                                           \
-                    *(rerror) = PA_ERR_BADSTATE;                        \
-                }                                                       \
+                *(rerror) = PA_ERR_BADSTATE;                            \
             }                                                           \
             goto label;                                                 \
         }                                                               \
-    } while (0);
-
-static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror)
-{
-    paaudio *g = p->g;
-
-    pa_threaded_mainloop_lock (g->mainloop);
-
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
-
-    while (length > 0) {
-        size_t l;
-
-        while (!p->read_data) {
-            int r;
-
-            r = pa_stream_peek (p->stream, &p->read_data, &p->read_length);
-            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
-
-            if (!p->read_data) {
-                pa_threaded_mainloop_wait (g->mainloop);
-                CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
-            } else {
-                p->read_index = 0;
-            }
-        }
-
-        l = p->read_length < length ? p->read_length : length;
-        memcpy (data, (const uint8_t *) p->read_data+p->read_index, l);
-
-        data = (uint8_t *) data + l;
-        length -= l;
+} while (0);
 
-        p->read_index += l;
-        p->read_length -= l;
-
-        if (!p->read_length) {
-            int r;
-
-            r = pa_stream_drop (p->stream);
-            p->read_data = NULL;
-            p->read_length = 0;
-            p->read_index = 0;
-
-            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
-        }
-    }
-
-    pa_threaded_mainloop_unlock (g->mainloop);
-    return 0;
-
-unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
-    return -1;
-}
-
-static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t length, int *rerror)
-{
-    paaudio *g = p->g;
-
-    pa_threaded_mainloop_lock (g->mainloop);
-
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
-
-    while (length > 0) {
-        size_t l;
-        int r;
-
-        while (!(l = pa_stream_writable_size (p->stream))) {
-            pa_threaded_mainloop_wait (g->mainloop);
-            CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
-        }
-
-        CHECK_SUCCESS_GOTO (g, rerror, l != (size_t) -1, unlock_and_fail);
-
-        if (l > length) {
-            l = length;
-        }
-
-        r = pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIVE);
-        CHECK_SUCCESS_GOTO (g, rerror, r >= 0, unlock_and_fail);
-
-        data = (const uint8_t *) data + l;
-        length -= l;
-    }
-
-    pa_threaded_mainloop_unlock (g->mainloop);
-    return 0;
-
-unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
-    return -1;
-}
-
-static void *qpa_thread_out (void *arg)
+static int qpa_run_out (HWVoiceOut *hw, int live)
 {
-    PAVoiceOut *pa = arg;
-    HWVoiceOut *hw = &pa->hw;
+    PAVoiceOut *pa = (PAVoiceOut *) hw;
+    int rpos, decr, samples;
+    size_t avail_bytes, max_bytes;
+    struct st_sample *src;
+    void *pa_dst;
+    int error = 0;
+    int r;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return NULL;
-    }
+    decr = 0;
+    rpos = hw->rpos;
 
-    for (;;) {
-        int decr, to_mix, rpos;
+    pa_threaded_mainloop_lock (pa->g->mainloop);
+    CHECK_DEAD_GOTO (pa->g, pa->stream, &error, fail);
 
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
+    avail_bytes = (size_t) live << hw->info.shift;
+    max_bytes = pa_stream_writable_size(pa->stream);
+    CHECK_SUCCESS_GOTO(pa->g, &error, max_bytes != -1, fail);
 
-            if (pa->live > 0) {
-                break;
-            }
+    samples = (int)(audio_MIN (avail_bytes, max_bytes)) >> hw->info.shift;
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
-                goto exit;
-            }
-        }
+//    if (avail_bytes < max_bytes) {
+//        dolog("avail: %d, wanted: %d \n", (int)avail_bytes, (int)max_bytes);
+//    }
 
-        decr = to_mix = audio_MIN (pa->live, pa->g->conf.samples >> 2);
-        rpos = pa->rpos;
+//    dolog("TRANSFER avail: %d bytes, max %d bytes -> %d samples from %d\n", (int)avail_bytes, (int)max_bytes, samples, rpos);
 
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
-        }
+    while (samples) {
+        int left_till_end_samples = hw->samples - rpos;
 
-        while (to_mix) {
-            int error;
-            int chunk = audio_MIN (to_mix, hw->samples - rpos);
-            struct st_sample *src = hw->mix_buf + rpos;
+        int convert_samples = audio_MIN (samples, left_till_end_samples);
+        size_t convert_bytes_wanted = (size_t) convert_samples << hw->info.shift;
+        size_t convert_bytes = convert_bytes_wanted;
 
-            hw->clip (pa->pcm_buf, src, chunk);
+        r = pa_stream_begin_write(pa->stream, &pa_dst, &convert_bytes);
+        CHECK_SUCCESS_GOTO(pa->g, &error, r == 0, fail);
+        CHECK_SUCCESS_GOTO(pa->g, &error, convert_bytes == convert_bytes_wanted, fail);
 
-            if (qpa_simple_write (pa, pa->pcm_buf,
-                                  chunk << hw->info.shift, &error) < 0) {
-                qpa_logerr (error, "pa_simple_write failed\n");
-                return NULL;
-            }
+        src = hw->mix_buf + rpos;
+        hw->clip (pa_dst, src, convert_samples);
 
-            rpos = (rpos + chunk) % hw->samples;
-            to_mix -= chunk;
-        }
-
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
-        }
+        r = pa_stream_write (pa->stream, pa_dst, convert_bytes, NULL, 0LL, PA_SEEK_RELATIVE);
+        CHECK_SUCCESS_GOTO(pa->g, &error, r >= 0, fail);
 
-        pa->rpos = rpos;
-        pa->live -= decr;
-        pa->decr += decr;
+        rpos = (rpos + convert_samples) % hw->samples;
+        samples -= convert_samples;
+        decr += convert_samples;
     }
 
- exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
-    return NULL;
-}
-
-static int qpa_run_out (HWVoiceOut *hw, int live)
-{
-    int decr;
-    PAVoiceOut *pa = (PAVoiceOut *) hw;
+    bail:
+    pa_threaded_mainloop_unlock (pa->g->mainloop);
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return 0;
-    }
-
-    decr = audio_MIN (live, pa->decr);
-    pa->decr -= decr;
-    pa->live = live - decr;
-    hw->rpos = pa->rpos;
-    if (pa->live > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    }
-    else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
-    }
+    hw->rpos = rpos;
     return decr;
+
+    fail:
+    qpa_logerr (error, "qpa_run_out failed\n");
+    goto bail;
 }
 
 static int qpa_write (SWVoiceOut *sw, void *buf, int len)
@@ -292,92 +189,86 @@ static int qpa_write (SWVoiceOut *sw, void *buf, int len)
     return audio_pcm_sw_write (sw, buf, len);
 }
 
-/* capture */
-static void *qpa_thread_in (void *arg)
+static int qpa_run_in (HWVoiceIn *hw)
 {
-    PAVoiceIn *pa = arg;
-    HWVoiceIn *hw = &pa->hw;
+    PAVoiceIn *pa = (PAVoiceIn *) hw;
+    int wpos, incr;
+    char *pa_src;
+    int error = 0;
+    int r;
+
+    incr = 0;
+    wpos = hw->wpos;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return NULL;
+    pa_threaded_mainloop_lock (pa->g->mainloop);
+    CHECK_DEAD_GOTO (pa->g, pa->stream, &error, fail);
+
+    size_t bytes_wanted = ((unsigned int)(hw->samples - audio_pcm_hw_get_live_in(hw)) << hw->info.shift);
+    if (bytes_wanted == 0) {
+        // no room
+        goto bail;
     }
 
-    for (;;) {
-        int incr, to_grab, wpos;
+    size_t bytes_avail = pa_stream_readable_size(pa->stream);
 
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
+    //dolog("WANT %d, HAVE %d\n", (int)bytes_wanted, (int) bytes_avail);
 
-            if (pa->dead > 0) {
-                break;
-            }
+    size_t pa_avail;
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
-                goto exit;
+    if (bytes_avail > bytes_wanted) {
+#if 0
+        size_t to_drop = bytes_avail - bytes_wanted;
+        while (to_drop) {
+            r = pa_stream_peek(pa->stream, (const void **)&pa_src, &pa_avail);
+            CHECK_SUCCESS_GOTO(pa->g, &error, r == 0, fail);
+            if (to_drop < pa_avail) {
+                break;
             }
+            r = pa_stream_drop(pa->stream);
+            CHECK_SUCCESS_GOTO(pa->g, &error, r == 0, fail);
+            to_drop -= pa_avail;
         }
-
-        incr = to_grab = audio_MIN (pa->dead, pa->g->conf.samples >> 2);
-        wpos = pa->wpos;
-
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
+        int n_dropped = (int)(bytes_avail - bytes_wanted - to_drop);
+        if(n_dropped) {
+            dolog("dropped %d bytes\n", n_dropped);
         }
+#endif
+    } else if (bytes_wanted < bytes_avail) {
+        bytes_wanted = bytes_avail;
+    }
 
-        while (to_grab) {
-            int error;
-            int chunk = audio_MIN (to_grab, hw->samples - wpos);
-            void *buf = advance (pa->pcm_buf, wpos);
+    while (bytes_wanted) {
+        r = pa_stream_peek(pa->stream, (const void **)&pa_src, &pa_avail);
+        CHECK_SUCCESS_GOTO(pa->g, &error, r == 0, fail);
+        if (pa_avail == 0 || pa_avail > bytes_wanted) {
+            break;
+        }
 
-            if (qpa_simple_read (pa, buf,
-                                 chunk << hw->info.shift, &error) < 0) {
-                qpa_logerr (error, "pa_simple_read failed\n");
-                return NULL;
-            }
+        bytes_wanted -= pa_avail;
 
-            hw->conv (hw->conv_buf + wpos, buf, chunk);
+        while (pa_avail) {
+            int chunk = audio_MIN ((int)(pa_avail >> hw->info.shift), hw->samples - wpos);
+            hw->conv (hw->conv_buf + wpos, pa_src, chunk);
             wpos = (wpos + chunk) % hw->samples;
-            to_grab -= chunk;
-        }
-
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
+            pa_src += chunk << hw->info.shift;
+            pa_avail -= chunk << hw->info.shift;
+            incr += chunk;
         }
 
-        pa->wpos = wpos;
-        pa->dead -= incr;
-        pa->incr += incr;
+        r = pa_stream_drop(pa->stream);
+        CHECK_SUCCESS_GOTO(pa->g, &error, r == 0, fail);
     }
 
- exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
-    return NULL;
-}
+    bail:
+    pa_threaded_mainloop_unlock (pa->g->mainloop);
 
-static int qpa_run_in (HWVoiceIn *hw)
-{
-    int live, incr, dead;
-    PAVoiceIn *pa = (PAVoiceIn *) hw;
+    hw->wpos = wpos;
+    return incr;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return 0;
-    }
+    fail:
+    qpa_logerr (error, "qpa_run_in failed\n");
+    goto bail;
 
-    live = audio_pcm_hw_get_live_in (hw);
-    dead = hw->samples - live;
-    incr = audio_MIN (dead, pa->incr);
-    pa->incr -= incr;
-    pa->dead = dead - incr;
-    hw->wpos = pa->wpos;
-    if (pa->dead > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    }
-    else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
-    }
-    return incr;
 }
 
 static int qpa_read (SWVoiceIn *sw, void *buf, int len)
@@ -387,7 +278,7 @@ static int qpa_read (SWVoiceIn *sw, void *buf, int len)
 
 static pa_sample_format_t audfmt_to_pa (audfmt_e afmt, int endianness)
 {
-    int format;
+    pa_sample_format_t format;
 
     switch (afmt) {
     case AUD_FMT_S8:
@@ -470,13 +361,6 @@ static void stream_state_cb (pa_stream *s, void * userdata)
     }
 }
 
-static void stream_request_cb (pa_stream *s, size_t length, void *userdata)
-{
-    paaudio *g = userdata;
-
-    pa_threaded_mainloop_signal (g->mainloop, 0);
-}
-
 static pa_stream *qpa_simple_new (
         paaudio *g,
         const char *name,
@@ -498,21 +382,19 @@ static pa_stream *qpa_simple_new (
     }
 
     pa_stream_set_state_callback (stream, stream_state_cb, g);
-    pa_stream_set_read_callback (stream, stream_request_cb, g);
-    pa_stream_set_write_callback (stream, stream_request_cb, g);
 
     if (dir == PA_STREAM_PLAYBACK) {
         r = pa_stream_connect_playback (stream, dev, attr,
                                         PA_STREAM_INTERPOLATE_TIMING
 #ifdef PA_STREAM_ADJUST_LATENCY
-                                        |PA_STREAM_ADJUST_LATENCY
+                                        | (g->conf.adjust_latency_out ? PA_STREAM_ADJUST_LATENCY : 0)
 #endif
                                         |PA_STREAM_AUTO_TIMING_UPDATE, NULL, NULL);
     } else {
         r = pa_stream_connect_record (stream, dev, attr,
                                       PA_STREAM_INTERPOLATE_TIMING
 #ifdef PA_STREAM_ADJUST_LATENCY
-                                      |PA_STREAM_ADJUST_LATENCY
+                                      | (g->conf.adjust_latency_in ? PA_STREAM_ADJUST_LATENCY : 0)
 #endif
                                       |PA_STREAM_AUTO_TIMING_UPDATE);
     }
@@ -537,39 +419,62 @@ fail:
     return NULL;
 }
 
+
 static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
                         void *drv_opaque)
 {
     int error;
-    pa_sample_spec ss;
-    pa_buffer_attr ba;
     struct audsettings obt_as = *as;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     paaudio *g = pa->g = drv_opaque;
 
-    ss.format = audfmt_to_pa (as->fmt, as->endianness);
-    ss.channels = as->nchannels;
-    ss.rate = as->freq;
+    int64_t timer_tick_duration = audio_MAX(audio_get_timer_ticks(), 1 * SCALE_MS);
+    int64_t frames_per_tick_x1000 = ((timer_tick_duration * as->freq * 1000LL) / NANOSECONDS_PER_SECOND);
+
+    int64_t tlength = g->conf.tlength;
+    if (tlength == 0) {
+        tlength = (frames_per_tick_x1000) / 400;
+    }
+    int64_t buflen = g->conf.buffer_size;
+    if (buflen == 0) {
+        buflen = frames_per_tick_x1000  / 400;
+    }
+
+    float ms_per_frame = 1000.0f / as->freq;
+
+    dolog("tick duration: %.2f ms (%.3f frames)\n",
+          ((float) timer_tick_duration) / SCALE_MS,
+          (float)frames_per_tick_x1000 / 1000.0f);
+
+    dolog("OUT internal buffer: %.2f ms (%"PRId64" frames)\n",
+          buflen * ms_per_frame,
+          buflen);
+
+    dolog("OUT tlength: %.2f ms (%"PRId64" frames)\n",
+          tlength * ms_per_frame,
+          tlength);
+
+    dolog("OUT adjust latency: %s\n", g->conf.adjust_latency_out ? "yes" : "no");
 
-    /*
-     * qemu audio tick runs at 100 Hz (by default), so processing
-     * data chunks worth 10 ms of sound should be a good fit.
-     */
-    ba.tlength = pa_usec_to_bytes (10 * 1000, &ss);
-    ba.minreq = pa_usec_to_bytes (5 * 1000, &ss);
-    ba.maxlength = -1;
-    ba.prebuf = -1;
+    pa->ss.format = audfmt_to_pa (as->fmt, as->endianness);
+    pa->ss.channels = as->nchannels;
+    pa->ss.rate = as->freq;
 
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
+    pa->ba.tlength = tlength * pa_frame_size (&pa->ss);
+    pa->ba.maxlength = -1;
+    pa->ba.minreq = -1;
+    pa->ba.prebuf = -1;
+
+    obt_as.fmt = pa_to_audfmt (pa->ss.format, &obt_as.endianness);
 
     pa->stream = qpa_simple_new (
         g,
         "qemu",
         PA_STREAM_PLAYBACK,
         g->conf.sink,
-        &ss,
+        &pa->ss,
         NULL,                   /* channel map */
-        &ba,                    /* buffering attributes */
+        &pa->ba,                /* buffering attributes */
         &error
         );
     if (!pa->stream) {
@@ -578,128 +483,101 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = g->conf.samples;
-    pa->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
-    pa->rpos = hw->rpos;
-    if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
-        goto fail2;
-    }
-
-    if (audio_pt_init (&pa->pt, qpa_thread_out, hw, AUDIO_CAP, AUDIO_FUNC)) {
-        goto fail3;
-    }
+    hw->samples = buflen;
 
     return 0;
 
- fail3:
-    g_free (pa->pcm_buf);
-    pa->pcm_buf = NULL;
- fail2:
-    if (pa->stream) {
-        pa_stream_unref (pa->stream);
-        pa->stream = NULL;
-    }
  fail1:
     return -1;
 }
 
-static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+
+static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as,
+                        void *drv_opaque)
 {
     int error;
-    pa_sample_spec ss;
     struct audsettings obt_as = *as;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     paaudio *g = pa->g = drv_opaque;
 
-    ss.format = audfmt_to_pa (as->fmt, as->endianness);
-    ss.channels = as->nchannels;
-    ss.rate = as->freq;
+    int64_t timer_tick_duration = audio_MAX(audio_get_timer_ticks(), 1 * SCALE_MS);
+    int64_t frames_per_tick_x1000 = ((timer_tick_duration * as->freq * 1000LL) / NANOSECONDS_PER_SECOND);
 
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
+    int64_t fragsize = g->conf.fragsize;
+    if (fragsize == 0) {
+        fragsize = frames_per_tick_x1000  / 2500;
+    }
+    int64_t buflen = g->conf.buffer_size;
+    if (buflen == 0) {
+        buflen = frames_per_tick_x1000  / 400;
+    }
+
+    float ms_per_frame = 1000.0f / as->freq;
+
+    dolog("IN internal buffer: %.2f ms (%"PRId64" frames)\n",
+          buflen * ms_per_frame,
+          buflen);
+
+    dolog("IN fragsize: %.2f ms (%"PRId64" frames)\n",
+          fragsize * ms_per_frame,
+          fragsize);
+
+    dolog("IN adjust latency: %s\n", g->conf.adjust_latency_in ? "yes" : "no");
+
+    pa->ss.format = audfmt_to_pa (as->fmt, as->endianness);
+    pa->ss.channels = as->nchannels;
+    pa->ss.rate = as->freq;
+
+    pa->ba.fragsize = fragsize * pa_frame_size (&pa->ss);
+    pa->ba.maxlength = pa->ba.fragsize * 10;
+    pa->ba.minreq = -1;
+    pa->ba.prebuf = -1;
+
+    obt_as.fmt = pa_to_audfmt (pa->ss.format, &obt_as.endianness);
 
     pa->stream = qpa_simple_new (
-        g,
-        "qemu",
-        PA_STREAM_RECORD,
-        g->conf.source,
-        &ss,
-        NULL,                   /* channel map */
-        NULL,                   /* buffering attributes */
-        &error
-        );
+            g,
+            "qemu",
+            PA_STREAM_RECORD,
+            g->conf.source,
+            &pa->ss,
+            NULL,                   /* channel map */
+            &pa->ba,                /* buffering attributes */
+            &error
+    );
     if (!pa->stream) {
-        qpa_logerr (error, "pa_simple_new for capture failed\n");
+        qpa_logerr (error, "pa_simple_new for playback failed\n");
         goto fail1;
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = g->conf.samples;
-    pa->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
-    pa->wpos = hw->wpos;
-    if (!pa->pcm_buf) {
-        dolog ("Could not allocate buffer (%d bytes)\n",
-               hw->samples << hw->info.shift);
-        goto fail2;
-    }
-
-    if (audio_pt_init (&pa->pt, qpa_thread_in, hw, AUDIO_CAP, AUDIO_FUNC)) {
-        goto fail3;
-    }
+    hw->samples = buflen;
 
     return 0;
 
- fail3:
-    g_free (pa->pcm_buf);
-    pa->pcm_buf = NULL;
- fail2:
-    if (pa->stream) {
-        pa_stream_unref (pa->stream);
-        pa->stream = NULL;
-    }
- fail1:
+    fail1:
     return -1;
 }
 
+
 static void qpa_fini_out (HWVoiceOut *hw)
 {
-    void *ret;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
 
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
-    pa->done = 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
-
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream = NULL;
     }
-
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
-    g_free (pa->pcm_buf);
-    pa->pcm_buf = NULL;
 }
 
 static void qpa_fini_in (HWVoiceIn *hw)
 {
-    void *ret;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
 
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
-    pa->done = 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
-
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream = NULL;
     }
-
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
-    g_free (pa->pcm_buf);
-    pa->pcm_buf = NULL;
 }
 
 static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
@@ -766,7 +644,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 #endif
 
     switch (cmd) {
-    case VOICE_VOLUME:
+        case VOICE_VOLUME:
         {
             SWVoiceIn *sw;
             va_list ap;
@@ -782,8 +660,8 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             pa_threaded_mainloop_lock (g->mainloop);
 
             op = pa_context_set_source_output_volume (g->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
+                                                      pa_stream_get_index (pa->stream),
+                                                      &v, NULL, NULL);
             if (!op) {
                 qpa_logerr (pa_context_errno (g->context),
                             "set_source_output_volume() failed\n");
@@ -792,8 +670,8 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             }
 
             op = pa_context_set_source_output_mute (g->context,
-                pa_stream_get_index (pa->stream),
-                sw->vol.mute, NULL, NULL);
+                                                    pa_stream_get_index (pa->stream),
+                                                    sw->vol.mute, NULL, NULL);
             if (!op) {
                 qpa_logerr (pa_context_errno (g->context),
                             "set_source_output_mute() failed\n");
@@ -809,9 +687,13 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 
 /* common */
 static PAConf glob_conf = {
-    .samples = 4096,
+#ifdef PA_STREAM_ADJUST_LATENCY
+        .adjust_latency_out = 0,
+        .adjust_latency_in = 1,
+#endif
 };
 
+
 static void *qpa_audio_init (void)
 {
     paaudio *g = g_malloc(sizeof(paaudio));
@@ -897,11 +779,37 @@ static void qpa_audio_fini (void *opaque)
 
 struct audio_option qpa_options[] = {
     {
-        .name  = "SAMPLES",
+        .name  = "INT_BUF_SIZE",
         .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.samples,
-        .descr = "buffer size in samples"
+        .valp  = &glob_conf.buffer_size,
+        .descr = "internal buffer size in frames"
     },
+    {
+        .name  = "TLENGTH",
+        .tag   = AUD_OPT_INT,
+        .valp  = &glob_conf.tlength,
+        .descr = "playback buffer target length in frames"
+    },
+    {
+        .name  = "FRAGSIZE",
+        .tag   = AUD_OPT_INT,
+        .valp  = &glob_conf.fragsize,
+        .descr = "fragment length of recording device in frames"
+    },
+#ifdef PA_STREAM_ADJUST_LATENCY
+    {
+        .name  = "ADJUST_LATENCY_OUT",
+        .tag   = AUD_OPT_BOOL,
+        .valp  = &glob_conf.adjust_latency_out,
+        .descr = "let PA adjust latency for playback device"
+    },
+    {
+        .name  = "ADJUST_LATENCY_IN",
+        .tag   = AUD_OPT_BOOL,
+        .valp  = &glob_conf.adjust_latency_in,
+        .descr = "let PA adjust latency for recording device"
+    },
+#endif
     {
         .name  = "SERVER",
         .tag   = AUD_OPT_STR,
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 5402cd196c..760bfe40d4 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "intel-hda.h"
@@ -154,8 +155,11 @@ struct HDAAudioStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    uint8_t buf[HDA_BUFFER_SIZE];
-    uint32_t bpos;
+    uint8_t buf[8192];
+    int64_t rpos;
+    int64_t wpos;
+    QEMUTimer *buft;
+    int64_t buft_start;
 };
 
 #define TYPE_HDA_AUDIO "hda-audio"
@@ -176,56 +180,180 @@ struct HDAAudioState {
     bool     mixer;
 };
 
+static void hda_audio_input_timer(void *opaque) {
+
+#define B_SIZE sizeof(st->buf)
+#define B_MASK (sizeof(st->buf) - 1)
+
+    HDAAudioStream *st = opaque;
+
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t wanted_rpos = (st->as.freq * 4 * (now - buft_start)) / NANOSECONDS_PER_SECOND;
+    wanted_rpos &= -4; // IMPORTANT! clip to frames
+
+    if (wanted_rpos <= rpos) {
+        // we already transmitted the data
+        goto out_timer;
+    }
+
+    if (wpos - rpos >= B_SIZE) {
+        goto out_timer;
+    }
+
+    //dolog("%"PRId64"\n", wpos - rpos);
+
+    //dolog("rpos: %"PRId64", wpos: %"PRId64", wanted: %"PRId64"\n", rpos, wpos, wanted_wpos);
+    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), wanted_rpos - rpos);
+    while (to_transfer) {
+        uint32_t start = (rpos & B_MASK);
+        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        int rc = hda_codec_xfer(&st->state->hda, st->stream, false, st->buf + start, chunk);
+        if (!rc) {
+            break;
+        }
+        rpos += chunk;
+        to_transfer -= chunk;
+        atomic_fetch_add(&st->rpos, chunk);
+    }
+
+#undef B_MASK
+#undef B_SIZE
+
+    out_timer:
+
+    if (st->running) {
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    }
+}
+
+
 static void hda_audio_input_cb(void *opaque, int avail)
 {
+#define B_SIZE sizeof(st->buf)
+#define B_MASK (sizeof(st->buf) - 1)
+
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
+    int64_t to_transfer = audio_MIN(wpos - rpos, avail);
+
+//    int64_t overflow = wpos - rpos - to_transfer - (B_SIZE >> 3);
+//    if (overflow > 0) {
+//        int64_t corr = NANOSECONDS_PER_SECOND * overflow / (4 * st->as.freq);
+//        //dolog("CORR %"PRId64"\n", corr);
+//        atomic_fetch_add(&st->buft_start, corr);
+//    }
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
+
+#undef B_MASK
+#undef B_SIZE
+}
+
+
+#define dolog(fmt, ...) AUD_log("XX", fmt, ## __VA_ARGS__)
+
+static void hda_audio_output_timer(void *opaque) {
+
+#define B_SIZE sizeof(st->buf)
+#define B_MASK (sizeof(st->buf) - 1)
+
+    HDAAudioStream *st = opaque;
+
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    int64_t buft_start = atomic_fetch_add(&st->buft_start, 0);
+    int64_t wpos = atomic_fetch_add(&st->wpos, 0);
+    int64_t rpos = atomic_fetch_add(&st->rpos, 0);
+
+    int64_t wanted_wpos = (st->as.freq * 4 * (now - buft_start)) / NANOSECONDS_PER_SECOND;
+    wanted_wpos &= -4; // IMPORTANT! clip to frames
+
+    if (wanted_wpos <= wpos) {
+        // we already received the data
+        goto out_timer;
+    }
+
+    if (wpos - rpos >= B_SIZE) {
+        goto out_timer;
+    }
+
+    //dolog("%"PRId64"\n", wpos - rpos);
+
+    //dolog("rpos: %"PRId64", wpos: %"PRId64", wanted: %"PRId64"\n", rpos, wpos, wanted_wpos);
+    int64_t to_transfer = audio_MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
+    while (to_transfer) {
+        uint32_t start = (wpos & B_MASK);
+        uint32_t chunk = audio_MIN(B_SIZE - start, to_transfer);
+        int rc = hda_codec_xfer(&st->state->hda, st->stream, true, st->buf + start, chunk);
         if (!rc) {
             break;
         }
-        st->bpos = 0;
+        wpos += chunk;
+        to_transfer -= chunk;
+        atomic_fetch_add(&st->wpos, chunk);
+    }
+
+#undef B_MASK
+#undef B_SIZE
+
+    out_timer:
+
+    if (st->running) {
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
     }
 }
 
 static void hda_audio_output_cb(void *opaque, int avail)
 {
+#define B_SIZE sizeof(st->buf)
+#define B_MASK (sizeof(st->buf) - 1)
+
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
+    int64_t overflow = wpos - rpos - to_transfer - (B_SIZE >> 3);
+    if (overflow > 0) {
+        int64_t corr = NANOSECONDS_PER_SECOND * overflow / (4 * st->as.freq);
+        //dolog("CORR %"PRId64"\n", corr);
+        atomic_fetch_add(&st->buft_start, corr);
+    }
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
+
+#undef B_MASK
+#undef B_SIZE
 }
 
 static void hda_audio_set_running(HDAAudioStream *st, bool running)
@@ -237,6 +365,17 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
         return;
     }
     st->running = running;
+
+    if (running) {
+        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        st->rpos = 0;
+        st->wpos = 0;
+        st->buft_start = now;
+        timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
+    } else {
+        timer_del (st->buft);
+    }
+
     dprint(st->state, 1, "%s: %s (stream %d)\n", st->node->name,
            st->running ? "on" : "off", st->stream);
     if (st->output) {
@@ -286,10 +425,12 @@ static void hda_audio_setup(HDAAudioStream *st)
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
 
@@ -505,7 +646,6 @@ static int hda_audio_init(HDACodecDevice *hda, const struct desc_codec *desc)
                 /* unmute output by default */
                 st->gain_left = QEMU_HDA_AMP_STEPS;
                 st->gain_right = QEMU_HDA_AMP_STEPS;
-                st->bpos = sizeof(st->buf);
                 st->output = true;
             } else {
                 st->output = false;
@@ -533,6 +673,7 @@ static void hda_audio_exit(HDACodecDevice *hda)
             continue;
         }
         if (st->output) {
+            timer_del (st->buft);
             AUD_close_out(&a->card, st->voice.out);
         } else {
             AUD_close_in(&a->card, st->voice.in);
@@ -592,8 +733,9 @@ static const VMStateDescription vmstate_hda_audio_stream = {
         VMSTATE_UINT32(gain_right, HDAAudioStream),
         VMSTATE_BOOL(mute_left, HDAAudioStream),
         VMSTATE_BOOL(mute_right, HDAAudioStream),
-        VMSTATE_UINT32(bpos, HDAAudioStream),
         VMSTATE_BUFFER(buf, HDAAudioStream),
+        VMSTATE_INT64(rpos, HDAAudioStream),
+        VMSTATE_INT64(wpos, HDAAudioStream),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/audio/intel-hda-defs.h b/hw/audio/intel-hda-defs.h
index 2e37e5b874..900a2695ec 100644
--- a/hw/audio/intel-hda-defs.h
+++ b/hw/audio/intel-hda-defs.h
@@ -3,6 +3,7 @@
 
 /* qemu */
 #define HDA_BUFFER_SIZE 256
+#define HDA_TIMER_TICKS (SCALE_MS)
 
 /* --------------------------------------------------------------------- */
 /* from linux/sound/pci/hda/hda_intel.c                                  */
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 18a50a8f83..9d3da3185b 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -407,13 +407,13 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
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
+//    if (st->ctl & (1 << 26)) {
+//        /*
+//         * Wait with the next DMA xfer until the guest
+//         * has acked the buffer completion interrupt
+//         */
+//        return false;
+//    }
 
     left = len;
     s = st->bentries;
-- 
2.14.2
