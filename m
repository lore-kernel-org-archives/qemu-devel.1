Received: from eggs.gnu.org ([2001:4830:134:3::10]:34372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnV-0005AR-Bq
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnQ-0000Lw-Eq
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:53 -0400
Received: from hermes.schrodt.org ([2a01:488:66:1000:b24d:49f5:0:1]:40592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <spheenik@zoidberg.machine.schrodt.org>)
	id 1e3lnQ-0000Kr-1V
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:29:48 -0400
From: Martin Schrodt <martin@schrodt.org>
Date: Sun, 15 Oct 2017 18:29:43 +0200
Message-Id: <20171015162944.4538-2-martin@schrodt.org>
In-Reply-To: <20171015162944.4538-1-martin@schrodt.org>
References: <20171015162944.4538-1-martin@schrodt.org>
Subject: [Qemu-devel] [PATCH v2 1/2] audio/paaudio: remove separate PA
 feeder threads
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

Reduce latency when playing back via Pulse Audio, by removing the
separate threads that feed PA. These are not needed, since feeding
can be done in a non blocking way directly from the audio timer.

This also exposes several new configuration settings that make it
easier for the user to tune the behaviour:

QEMU_PA_BUFFER_SIZE_OUT: integer, default = 0
  "internal buffer size in frames for playback device"
  This equals the previous QEMU_PA_SAMPLES, but is only for the
  playback device.When no value is given, this will be calculated
  as 2.5 times the audio timer interval.

QEMU_PA_BUFFER_SIZE_IN: integer, default = 0
  "internal buffer size in frames for recording device"
  This equals the previous QEMU_PA_SAMPLES, but is only for the
  recording device. When no value is given, this will be calculated
  as 2.5 times the audio timer interval.

QEMU_PA_TLENGTH: integer, default = 0
  "playback buffer target length in frames"
  The server tries to assure that at least tlength bytes are always
  available in the per-stream server-side playback buffer.
  When no value is given, this will be calculated as 2.5 times
  the audio timer interval.

QEMU_PA_FRAGSIZE: integer, default = 0
  "fragment length of recording device in frames"
  When recording, the server sends data in blocks of fragsize bytes
  size. Large values diminish interactivity with other operations on
  the connection context but decrease control overhead.
  When no value is given, this will be calculated as 0.25 times
  the audio timer interval.

QEMU_PA_MAXLENGTH_IN: integer, default = 0
  "maximum length of PA recording buffer in frames"
  Maximum length of the server side buffer in bytes.
  When no value is given, this will be calculated as 4 times
  the audio timer interval.

QEMU_PA_ADJUST_LATENCY_OUT: boolean, default = 0
  "instruct PA to adjust latency for playback device"
  When this is enabled, PA will try to set the overall latency of the
  sink to the value given by TLENGTH.

QEMU_PA_ADJUST_LATENCY_IN: boolean, default = 1
  "instruct PA to adjust latency for recording device"
  When this is enabled, PA will try to set the overall latency of the
  source to the value given by FRAGSIZE.

Signed-off-by: Martin Schrodt <martin@schrodt.org>
---
 audio/audio.c     |   5 +
 audio/audio_int.h |   2 +
 audio/paaudio.c   | 862 +++++++++++++++++++++++-------------------------------
 3 files changed, 377 insertions(+), 492 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index beafed209b..6f42a019b0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2066,3 +2066,8 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         }
     }
 }
+
+int64_t audio_get_timer_ticks(void)
+{
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
index 65beb6f010..fbc30fd08e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -1,16 +1,21 @@
 /* public domain */
 #include "qemu/osdep.h"
-#include "qemu-common.h"
+#include "qemu/timer.h"
 #include "audio.h"
 
 #include <pulse/pulseaudio.h>
 
 #define AUDIO_CAP "pulseaudio"
 #include "audio_int.h"
-#include "audio_pt_int.h"
 
 typedef struct {
-    int samples;
+    int buffer_size_out;
+    int buffer_size_in;
+    int tlength;
+    int fragsize;
+    int maxlength_in;
+    int adjust_latency_out;
+    int adjust_latency_in;
     char *server;
     char *sink;
     char *source;
@@ -24,28 +29,18 @@ typedef struct {
 
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
 
 static void qpa_audio_fini(void *opaque);
@@ -109,182 +104,59 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
         }                                                               \
     } while (0);
 
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
-
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
+static int qpa_run_out(HWVoiceOut *hw, int live)
 {
-    PAVoiceOut *pa = arg;
-    HWVoiceOut *hw = &pa->hw;
-
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return NULL;
-    }
-
-    for (;;) {
-        int decr, to_mix, rpos;
-
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
+    PAVoiceOut *pa = (PAVoiceOut *) hw;
+    int rpos, decr, samples;
+    size_t avail_bytes, max_bytes;
+    struct st_sample *src;
+    void *pa_dst;
+    int error = 0;
+    int *rerror = &error;
+    int r;
 
-            if (pa->live > 0) {
-                break;
-            }
+    decr = 0;
+    rpos = hw->rpos;
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
-                goto exit;
-            }
-        }
+    pa_threaded_mainloop_lock(pa->g->mainloop);
+    CHECK_DEAD_GOTO(pa->g, pa->stream, rerror, fail);
 
-        decr = to_mix = audio_MIN (pa->live, pa->g->conf.samples >> 2);
-        rpos = pa->rpos;
+    avail_bytes = (size_t) live << hw->info.shift;
 
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
-        }
+    max_bytes = pa_stream_writable_size(pa->stream);
+    CHECK_SUCCESS_GOTO(pa->g, rerror, max_bytes != -1, fail);
 
-        while (to_mix) {
-            int error;
-            int chunk = audio_MIN (to_mix, hw->samples - rpos);
-            struct st_sample *src = hw->mix_buf + rpos;
+    samples = (int)(audio_MIN(avail_bytes, max_bytes)) >> hw->info.shift;
+    while (samples) {
+        int convert_samples = audio_MIN(samples, hw->samples - rpos);
+        size_t b_wanted = (size_t) convert_samples << hw->info.shift;
+        size_t b_effective = b_wanted;
 
-            hw->clip (pa->pcm_buf, src, chunk);
+        r = pa_stream_begin_write(pa->stream, &pa_dst, &b_effective);
+        CHECK_SUCCESS_GOTO(pa->g, rerror, r == 0, fail);
+        CHECK_SUCCESS_GOTO(pa->g, (int *)0, b_effective == b_wanted, fail);
 
-            if (qpa_simple_write (pa, pa->pcm_buf,
-                                  chunk << hw->info.shift, &error) < 0) {
-                qpa_logerr (error, "pa_simple_write failed\n");
-                return NULL;
-            }
+        src = hw->mix_buf + rpos;
+        hw->clip(pa_dst, src, convert_samples);
 
-            rpos = (rpos + chunk) % hw->samples;
-            to_mix -= chunk;
-        }
-
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
-        }
+        r = pa_stream_write(pa->stream, pa_dst, b_effective,
+                            NULL, 0LL, PA_SEEK_RELATIVE);
+        CHECK_SUCCESS_GOTO(pa->g, rerror, r >= 0, fail);
 
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
+    pa_threaded_mainloop_unlock(pa->g->mainloop);
 
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
+    qpa_logerr(error, "qpa_run_out failed\n");
+    goto bail;
 }
 
 static int qpa_write (SWVoiceOut *sw, void *buf, int len)
@@ -292,92 +164,68 @@ static int qpa_write (SWVoiceOut *sw, void *buf, int len)
     return audio_pcm_sw_write (sw, buf, len);
 }
 
-/* capture */
-static void *qpa_thread_in (void *arg)
+static int qpa_run_in(HWVoiceIn *hw)
 {
-    PAVoiceIn *pa = arg;
-    HWVoiceIn *hw = &pa->hw;
+    PAVoiceIn *pa = (PAVoiceIn *) hw;
+    int wpos, incr;
+    char *pa_src;
+    int error = 0;
+    int *rerror = &error;
+    int r;
+    size_t pa_avail;
+    incr = 0;
+    wpos = hw->wpos;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return NULL;
-    }
+    pa_threaded_mainloop_lock(pa->g->mainloop);
+    CHECK_DEAD_GOTO(pa->g, pa->stream, rerror, fail);
 
-    for (;;) {
-        int incr, to_grab, wpos;
+    size_t bytes_wanted = ((unsigned int)
+            (hw->samples - audio_pcm_hw_get_live_in(hw)) << hw->info.shift);
 
-        for (;;) {
-            if (pa->done) {
-                goto exit;
-            }
+    if (bytes_wanted == 0) {
+        /* no room */
+        goto bail;
+    }
 
-            if (pa->dead > 0) {
-                break;
-            }
+    size_t bytes_avail = pa_stream_readable_size(pa->stream);
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
-                goto exit;
-            }
-        }
+    if (bytes_wanted > bytes_avail) {
+        bytes_wanted = bytes_avail;
+    }
 
-        incr = to_grab = audio_MIN (pa->dead, pa->g->conf.samples >> 2);
-        wpos = pa->wpos;
+    while (bytes_wanted) {
+        r = pa_stream_peek(pa->stream, (const void **)&pa_src, &pa_avail);
+        CHECK_SUCCESS_GOTO(pa->g, rerror, r == 0, fail);
 
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
-            return NULL;
+        if (pa_avail == 0 || pa_avail > bytes_wanted) {
+            break;
         }
 
-        while (to_grab) {
-            int error;
-            int chunk = audio_MIN (to_grab, hw->samples - wpos);
-            void *buf = advance (pa->pcm_buf, wpos);
+        bytes_wanted -= pa_avail;
 
-            if (qpa_simple_read (pa, buf,
-                                 chunk << hw->info.shift, &error) < 0) {
-                qpa_logerr (error, "pa_simple_read failed\n");
-                return NULL;
-            }
-
-            hw->conv (hw->conv_buf + wpos, buf, chunk);
+        while (pa_avail) {
+            int chunk = audio_MIN(
+                    (int)(pa_avail >> hw->info.shift), hw->samples - wpos);
+            hw->conv(hw->conv_buf + wpos, pa_src, chunk);
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
+        CHECK_SUCCESS_GOTO(pa->g, rerror, r == 0, fail);
     }
 
- exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
-    return NULL;
-}
-
-static int qpa_run_in (HWVoiceIn *hw)
-{
-    int live, incr, dead;
-    PAVoiceIn *pa = (PAVoiceIn *) hw;
-
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
-        return 0;
-    }
+    bail:
+    pa_threaded_mainloop_unlock(pa->g->mainloop);
 
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
+    hw->wpos = wpos;
     return incr;
+
+    fail:
+    qpa_logerr(error, "qpa_run_in failed\n");
+    goto bail;
 }
 
 static int qpa_read (SWVoiceIn *sw, void *buf, int len)
@@ -390,22 +238,22 @@ static pa_sample_format_t audfmt_to_pa (audfmt_e afmt, int endianness)
     int format;
 
     switch (afmt) {
-    case AUD_FMT_S8:
-    case AUD_FMT_U8:
-        format = PA_SAMPLE_U8;
-        break;
-    case AUD_FMT_S16:
-    case AUD_FMT_U16:
-        format = endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
-        break;
-    case AUD_FMT_S32:
-    case AUD_FMT_U32:
-        format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
-        break;
-    default:
-        dolog ("Internal logic error: Bad audio format %d\n", afmt);
-        format = PA_SAMPLE_U8;
-        break;
+        case AUD_FMT_S8:
+        case AUD_FMT_U8:
+            format = PA_SAMPLE_U8;
+            break;
+        case AUD_FMT_S16:
+        case AUD_FMT_U16:
+            format = endianness ? PA_SAMPLE_S16BE : PA_SAMPLE_S16LE;
+            break;
+        case AUD_FMT_S32:
+        case AUD_FMT_U32:
+            format = endianness ? PA_SAMPLE_S32BE : PA_SAMPLE_S32LE;
+            break;
+        default:
+            dolog ("Internal logic error: Bad audio format %d\n", afmt);
+            format = PA_SAMPLE_U8;
+            break;
     }
     return format;
 }
@@ -413,23 +261,23 @@ static pa_sample_format_t audfmt_to_pa (audfmt_e afmt, int endianness)
 static audfmt_e pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
 {
     switch (fmt) {
-    case PA_SAMPLE_U8:
-        return AUD_FMT_U8;
-    case PA_SAMPLE_S16BE:
-        *endianness = 1;
-        return AUD_FMT_S16;
-    case PA_SAMPLE_S16LE:
-        *endianness = 0;
-        return AUD_FMT_S16;
-    case PA_SAMPLE_S32BE:
-        *endianness = 1;
-        return AUD_FMT_S32;
-    case PA_SAMPLE_S32LE:
-        *endianness = 0;
-        return AUD_FMT_S32;
-    default:
-        dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
-        return AUD_FMT_U8;
+        case PA_SAMPLE_U8:
+            return AUD_FMT_U8;
+        case PA_SAMPLE_S16BE:
+            *endianness = 1;
+            return AUD_FMT_S16;
+        case PA_SAMPLE_S16LE:
+            *endianness = 0;
+            return AUD_FMT_S16;
+        case PA_SAMPLE_S32BE:
+            *endianness = 1;
+            return AUD_FMT_S32;
+        case PA_SAMPLE_S32LE:
+            *endianness = 0;
+            return AUD_FMT_S32;
+        default:
+            dolog ("Internal logic error: Bad pa_sample_format %d\n", fmt);
+            return AUD_FMT_U8;
     }
 }
 
@@ -438,17 +286,17 @@ static void context_state_cb (pa_context *c, void *userdata)
     paaudio *g = userdata;
 
     switch (pa_context_get_state(c)) {
-    case PA_CONTEXT_READY:
-    case PA_CONTEXT_TERMINATED:
-    case PA_CONTEXT_FAILED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
-        break;
-
-    case PA_CONTEXT_UNCONNECTED:
-    case PA_CONTEXT_CONNECTING:
-    case PA_CONTEXT_AUTHORIZING:
-    case PA_CONTEXT_SETTING_NAME:
-        break;
+        case PA_CONTEXT_READY:
+        case PA_CONTEXT_TERMINATED:
+        case PA_CONTEXT_FAILED:
+            pa_threaded_mainloop_signal (g->mainloop, 0);
+            break;
+
+        case PA_CONTEXT_UNCONNECTED:
+        case PA_CONTEXT_CONNECTING:
+        case PA_CONTEXT_AUTHORIZING:
+        case PA_CONTEXT_SETTING_NAME:
+            break;
     }
 }
 
@@ -458,25 +306,18 @@ static void stream_state_cb (pa_stream *s, void * userdata)
 
     switch (pa_stream_get_state (s)) {
 
-    case PA_STREAM_READY:
-    case PA_STREAM_FAILED:
-    case PA_STREAM_TERMINATED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
-        break;
+        case PA_STREAM_READY:
+        case PA_STREAM_FAILED:
+        case PA_STREAM_TERMINATED:
+            pa_threaded_mainloop_signal (g->mainloop, 0);
+            break;
 
-    case PA_STREAM_UNCONNECTED:
-    case PA_STREAM_CREATING:
-        break;
+        case PA_STREAM_UNCONNECTED:
+        case PA_STREAM_CREATING:
+            break;
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
@@ -498,34 +339,28 @@ static pa_stream *qpa_simple_new (
     }
 
     pa_stream_set_state_callback (stream, stream_state_cb, g);
-    pa_stream_set_read_callback (stream, stream_request_cb, g);
-    pa_stream_set_write_callback (stream, stream_request_cb, g);
 
     if (dir == PA_STREAM_PLAYBACK) {
-        r = pa_stream_connect_playback (stream, dev, attr,
-                                        PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                        |PA_STREAM_ADJUST_LATENCY
-#endif
-                                        |PA_STREAM_AUTO_TIMING_UPDATE, NULL, NULL);
+        r = pa_stream_connect_playback(stream, dev, attr,
+                PA_STREAM_INTERPOLATE_TIMING
+                | (g->conf.adjust_latency_out ? PA_STREAM_ADJUST_LATENCY : 0)
+                |PA_STREAM_AUTO_TIMING_UPDATE, NULL, NULL);
     } else {
-        r = pa_stream_connect_record (stream, dev, attr,
-                                      PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                      |PA_STREAM_ADJUST_LATENCY
-#endif
-                                      |PA_STREAM_AUTO_TIMING_UPDATE);
+        r = pa_stream_connect_record(stream, dev, attr,
+                PA_STREAM_INTERPOLATE_TIMING
+                | (g->conf.adjust_latency_in ? PA_STREAM_ADJUST_LATENCY : 0)
+                |PA_STREAM_AUTO_TIMING_UPDATE);
     }
 
     if (r < 0) {
-      goto fail;
+        goto fail;
     }
 
     pa_threaded_mainloop_unlock (g->mainloop);
 
     return stream;
 
-fail:
+    fail:
     pa_threaded_mainloop_unlock (g->mainloop);
 
     if (stream) {
@@ -541,165 +376,169 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
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
-
-    /*
-     * qemu audio tick runs at 100 Hz (by default), so processing
-     * data chunks worth 10 ms of sound should be a good fit.
-     */
-    ba.tlength = pa_usec_to_bytes (10 * 1000, &ss);
-    ba.minreq = pa_usec_to_bytes (5 * 1000, &ss);
-    ba.maxlength = -1;
-    ba.prebuf = -1;
-
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
-
-    pa->stream = qpa_simple_new (
-        g,
-        "qemu",
-        PA_STREAM_PLAYBACK,
-        g->conf.sink,
-        &ss,
-        NULL,                   /* channel map */
-        &ba,                    /* buffering attributes */
-        &error
-        );
+    int64_t timer_tick_duration =
+        audio_MAX(audio_get_timer_ticks(), 1 * SCALE_MS);
+    int64_t frames_per_tick_x1000 =
+        ((timer_tick_duration * as->freq * 1000LL) / NANOSECONDS_PER_SECOND);
+
+    int64_t tlength = g->conf.tlength;
+    if (tlength == 0) {
+        tlength = (frames_per_tick_x1000) / 400;
+    }
+    int64_t buflen = g->conf.buffer_size_out;
+    if (buflen == 0) {
+        buflen = frames_per_tick_x1000  / 400;
+    }
+
+    ldebug("tick duration: %.2f ms (%.3f frames)\n",
+           ((float)timer_tick_duration) / SCALE_MS,
+           (float)frames_per_tick_x1000 / 1000.0f);
+
+    ldebug("OUT internal buffer: %.2f ms (%"PRId64" frames)\n",
+           buflen * (1000.0f / as->freq),
+           buflen);
+
+    ldebug("OUT tlength: %.2f ms (%"PRId64" frames)\n",
+           tlength * (1000.0f / as->freq),
+           tlength);
+
+    ldebug("OUT adjust latency: %s\n",
+           g->conf.adjust_latency_out ? "yes" : "no");
+
+    pa->ss.format = audfmt_to_pa(as->fmt, as->endianness);
+    pa->ss.channels = as->nchannels;
+    pa->ss.rate = as->freq;
+
+    pa->ba.tlength = tlength * pa_frame_size (&pa->ss);
+    pa->ba.maxlength = -1;
+    pa->ba.minreq = -1;
+    pa->ba.prebuf = -1;
+
+    obt_as.fmt = pa_to_audfmt(pa->ss.format, &obt_as.endianness);
+
+    pa->stream = qpa_simple_new(
+            g,
+            "qemu",
+            PA_STREAM_PLAYBACK,
+            g->conf.sink,
+            &pa->ss,
+            NULL,                   /* channel map */
+            &pa->ba,                /* buffering attributes */
+            &error
+    );
     if (!pa->stream) {
         qpa_logerr (error, "pa_simple_new for playback failed\n");
         goto fail1;
     }
 
-    audio_pcm_init_info (&hw->info, &obt_as);
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
+    audio_pcm_init_info(&hw->info, &obt_as);
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
 
-static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
+
+static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as,
+                       void *drv_opaque)
 {
     int error;
-    pa_sample_spec ss;
     struct audsettings obt_as = *as;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     paaudio *g = pa->g = drv_opaque;
 
-    ss.format = audfmt_to_pa (as->fmt, as->endianness);
-    ss.channels = as->nchannels;
-    ss.rate = as->freq;
-
-    obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
-
-    pa->stream = qpa_simple_new (
-        g,
-        "qemu",
-        PA_STREAM_RECORD,
-        g->conf.source,
-        &ss,
-        NULL,                   /* channel map */
-        NULL,                   /* buffering attributes */
-        &error
-        );
+    int64_t timer_tick_duration =
+        audio_MAX(audio_get_timer_ticks(), 1 * SCALE_MS);
+    int64_t frames_per_tick_x1000 =
+        ((timer_tick_duration * as->freq * 1000LL) / NANOSECONDS_PER_SECOND);
+
+    int64_t fragsize = g->conf.fragsize;
+    if (fragsize == 0) {
+        fragsize = frames_per_tick_x1000  / 2500;
+    }
+    int64_t buflen = g->conf.buffer_size_in;
+    if (buflen == 0) {
+        buflen = frames_per_tick_x1000  / 400;
+    }
+    int64_t maxlength = g->conf.maxlength_in;
+    if (maxlength == 0) {
+        maxlength = fragsize * 4;
+    }
+
+    ldebug("IN internal buffer: %.2f ms (%"PRId64" frames)\n",
+           buflen * (1000.0f / as->freq),
+           buflen);
+
+    ldebug("IN fragsize: %.2f ms (%"PRId64" frames)\n",
+           fragsize * (1000.0f / as->freq),
+           fragsize);
+
+    ldebug("IN maxlength: %.2f ms (%"PRId64" frames)\n",
+           maxlength * (1000.0f / as->freq),
+           maxlength);
+
+    ldebug("IN adjust latency: %s\n",
+           g->conf.adjust_latency_in ? "yes" : "no");
+
+    pa->ss.format = audfmt_to_pa(as->fmt, as->endianness);
+    pa->ss.channels = as->nchannels;
+    pa->ss.rate = as->freq;
+
+    pa->ba.fragsize = fragsize * pa_frame_size(&pa->ss);
+    pa->ba.maxlength = maxlength * pa_frame_size(&pa->ss);
+    pa->ba.minreq = -1;
+    pa->ba.prebuf = -1;
+
+    obt_as.fmt = pa_to_audfmt(pa->ss.format, &obt_as.endianness);
+
+    pa->stream = qpa_simple_new(
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
         qpa_logerr (error, "pa_simple_new for capture failed\n");
         goto fail1;
     }
 
-    audio_pcm_init_info (&hw->info, &obt_as);
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
+    audio_pcm_init_info(&hw->info, &obt_as);
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
@@ -714,7 +553,7 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
 #endif
 
     switch (cmd) {
-    case VOICE_VOLUME:
+        case VOICE_VOLUME:
         {
             SWVoiceOut *sw;
             va_list ap;
@@ -730,8 +569,8 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
             pa_threaded_mainloop_lock (g->mainloop);
 
             op = pa_context_set_sink_input_volume (g->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
+                                                   pa_stream_get_index (pa->stream),
+                                                   &v, NULL, NULL);
             if (!op)
                 qpa_logerr (pa_context_errno (g->context),
                             "set_sink_input_volume() failed\n");
@@ -739,8 +578,8 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
                 pa_operation_unref (op);
 
             op = pa_context_set_sink_input_mute (g->context,
-                pa_stream_get_index (pa->stream),
-               sw->vol.mute, NULL, NULL);
+                                                 pa_stream_get_index (pa->stream),
+                                                 sw->vol.mute, NULL, NULL);
             if (!op) {
                 qpa_logerr (pa_context_errno (g->context),
                             "set_sink_input_mute() failed\n");
@@ -766,7 +605,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 #endif
 
     switch (cmd) {
-    case VOICE_VOLUME:
+        case VOICE_VOLUME:
         {
             SWVoiceIn *sw;
             va_list ap;
@@ -782,8 +621,8 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             pa_threaded_mainloop_lock (g->mainloop);
 
             op = pa_context_set_source_output_volume (g->context,
-                pa_stream_get_index (pa->stream),
-                &v, NULL, NULL);
+                                                      pa_stream_get_index (pa->stream),
+                                                      &v, NULL, NULL);
             if (!op) {
                 qpa_logerr (pa_context_errno (g->context),
                             "set_source_output_volume() failed\n");
@@ -792,8 +631,8 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             }
 
             op = pa_context_set_source_output_mute (g->context,
-                pa_stream_get_index (pa->stream),
-                sw->vol.mute, NULL, NULL);
+                                                    pa_stream_get_index (pa->stream),
+                                                    sw->vol.mute, NULL, NULL);
             if (!op) {
                 qpa_logerr (pa_context_errno (g->context),
                             "set_source_output_mute() failed\n");
@@ -809,7 +648,10 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 
 /* common */
 static PAConf glob_conf = {
-    .samples = 4096,
+#ifdef PA_STREAM_ADJUST_LATENCY
+        .adjust_latency_out = 0,
+        .adjust_latency_in = 1,
+#endif
 };
 
 static void *qpa_audio_init (void)
@@ -867,9 +709,9 @@ static void *qpa_audio_init (void)
 
     return g;
 
-unlock_and_fail:
+    unlock_and_fail:
     pa_threaded_mainloop_unlock (g->mainloop);
-fail:
+    fail:
     AUD_log (AUDIO_CAP, "Failed to initialize PA context");
     qpa_audio_fini(g);
     return NULL;
@@ -896,58 +738,94 @@ static void qpa_audio_fini (void *opaque)
 }
 
 struct audio_option qpa_options[] = {
-    {
-        .name  = "SAMPLES",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.samples,
-        .descr = "buffer size in samples"
-    },
-    {
-        .name  = "SERVER",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.server,
-        .descr = "server address"
-    },
-    {
-        .name  = "SINK",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.sink,
-        .descr = "sink device name"
-    },
-    {
-        .name  = "SOURCE",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.source,
-        .descr = "source device name"
-    },
-    { /* End of list */ }
+        {
+                .name  = "BUFFER_SIZE_OUT",
+                .tag   = AUD_OPT_INT,
+                .valp  = &glob_conf.buffer_size_out,
+                .descr = "internal buffer size in frames for playback device"
+        },
+        {
+                .name  = "BUFFER_SIZE_IN",
+                .tag   = AUD_OPT_INT,
+                .valp  = &glob_conf.buffer_size_in,
+                .descr = "internal buffer size in frames for recording device"
+        },
+        {
+                .name  = "TLENGTH",
+                .tag   = AUD_OPT_INT,
+                .valp  = &glob_conf.tlength,
+                .descr = "playback buffer target length in frames"
+        },
+        {
+                .name  = "FRAGSIZE",
+                .tag   = AUD_OPT_INT,
+                .valp  = &glob_conf.fragsize,
+                .descr = "fragment length of recording device in frames"
+        },
+        {
+                .name  = "MAXLENGTH_IN",
+                .tag   = AUD_OPT_INT,
+                .valp  = &glob_conf.maxlength_in,
+                .descr = "maximum length of PA recording buffer in frames"
+        },
+        {
+                .name  = "ADJUST_LATENCY_OUT",
+                .tag   = AUD_OPT_BOOL,
+                .valp  = &glob_conf.adjust_latency_out,
+                .descr = "instruct PA to adjust latency for playback device"
+        },
+        {
+                .name  = "ADJUST_LATENCY_IN",
+                .tag   = AUD_OPT_BOOL,
+                .valp  = &glob_conf.adjust_latency_in,
+                .descr = "instruct PA to adjust latency for recording device"
+        },
+        {
+                .name  = "SERVER",
+                .tag   = AUD_OPT_STR,
+                .valp  = &glob_conf.server,
+                .descr = "server address"
+        },
+        {
+                .name  = "SINK",
+                .tag   = AUD_OPT_STR,
+                .valp  = &glob_conf.sink,
+                .descr = "sink device name"
+        },
+        {
+                .name  = "SOURCE",
+                .tag   = AUD_OPT_STR,
+                .valp  = &glob_conf.source,
+                .descr = "source device name"
+        },
+        { /* End of list */ }
 };
 
 static struct audio_pcm_ops qpa_pcm_ops = {
-    .init_out = qpa_init_out,
-    .fini_out = qpa_fini_out,
-    .run_out  = qpa_run_out,
-    .write    = qpa_write,
-    .ctl_out  = qpa_ctl_out,
-
-    .init_in  = qpa_init_in,
-    .fini_in  = qpa_fini_in,
-    .run_in   = qpa_run_in,
-    .read     = qpa_read,
-    .ctl_in   = qpa_ctl_in
+        .init_out = qpa_init_out,
+        .fini_out = qpa_fini_out,
+        .run_out  = qpa_run_out,
+        .write    = qpa_write,
+        .ctl_out  = qpa_ctl_out,
+
+        .init_in  = qpa_init_in,
+        .fini_in  = qpa_fini_in,
+        .run_in   = qpa_run_in,
+        .read     = qpa_read,
+        .ctl_in   = qpa_ctl_in
 };
 
 struct audio_driver pa_audio_driver = {
-    .name           = "pa",
-    .descr          = "http://www.pulseaudio.org/",
-    .options        = qpa_options,
-    .init           = qpa_audio_init,
-    .fini           = qpa_audio_fini,
-    .pcm_ops        = &qpa_pcm_ops,
-    .can_be_default = 1,
-    .max_voices_out = INT_MAX,
-    .max_voices_in  = INT_MAX,
-    .voice_size_out = sizeof (PAVoiceOut),
-    .voice_size_in  = sizeof (PAVoiceIn),
-    .ctl_caps       = VOICE_VOLUME_CAP
+        .name           = "pa",
+        .descr          = "http://www.pulseaudio.org/",
+        .options        = qpa_options,
+        .init           = qpa_audio_init,
+        .fini           = qpa_audio_fini,
+        .pcm_ops        = &qpa_pcm_ops,
+        .can_be_default = 1,
+        .max_voices_out = INT_MAX,
+        .max_voices_in  = INT_MAX,
+        .voice_size_out = sizeof (PAVoiceOut),
+        .voice_size_in  = sizeof (PAVoiceIn),
+        .ctl_caps       = VOICE_VOLUME_CAP
 };
-- 
2.14.2
