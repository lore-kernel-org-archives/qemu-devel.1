Received: from eggs.gnu.org ([208.118.235.92]:52455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAk6-00086z-Di
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAk4-0002wP-Or
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:58 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAk3-0002oe-E1
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id a62so9861769wmh.4
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:55 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:05 +0100
Message-Id: <fc264e84d88cc525a6435c340e7f882428631521.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 29/52] alsaaudio: port to the new audio
 backend api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/alsaaudio.c | 306 ++++++++++++----------------------------------
 1 file changed, 81 insertions(+), 225 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 69e7a3868c..56271b1174 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -44,9 +44,6 @@ struct pollhlp {
 
 typedef struct ALSAVoiceOut {
     HWVoiceOut hw;
-    int wpos;
-    int pending;
-    void *pcm_buf;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
     Audiodev *dev;
@@ -55,7 +52,6 @@ typedef struct ALSAVoiceOut {
 typedef struct ALSAVoiceIn {
     HWVoiceIn hw;
     snd_pcm_t *handle;
-    void *pcm_buf;
     struct pollhlp pollhlp;
     Audiodev *dev;
 } ALSAVoiceIn;
@@ -610,102 +606,62 @@ static int alsa_open(bool in, struct alsa_params_req *req,
     return -1;
 }
 
-static snd_pcm_sframes_t alsa_get_avail (snd_pcm_t *handle)
-{
-    snd_pcm_sframes_t avail;
-
-    avail = snd_pcm_avail_update (handle);
-    if (avail < 0) {
-        if (avail == -EPIPE) {
-            if (!alsa_recover (handle)) {
-                avail = snd_pcm_avail_update (handle);
-            }
-        }
-
-        if (avail < 0) {
-            alsa_logerr (avail,
-                         "Could not obtain number of available frames\n");
-            return -1;
-        }
-    }
-
-    return avail;
-}
-
-static void alsa_write_pending (ALSAVoiceOut *alsa)
-{
-    HWVoiceOut *hw = &alsa->hw;
-
-    while (alsa->pending) {
-        int left_till_end_samples = hw->samples - alsa->wpos;
-        int len = MIN (alsa->pending, left_till_end_samples);
-        char *src = advance (alsa->pcm_buf, alsa->wpos << hw->info.shift);
-
-        while (len) {
-            snd_pcm_sframes_t written;
-
-            written = snd_pcm_writei (alsa->handle, src, len);
-
-            if (written <= 0) {
-                switch (written) {
-                case 0:
-                    trace_alsa_wrote_zero(len);
-                    return;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_xrun_out();
-                    continue;
-
-                case -ESTRPIPE:
-                    /* stream is suspended and waiting for an
-                       application recovery */
-                    if (alsa_resume (alsa->handle)) {
-                        alsa_logerr (written, "Failed to write %d frames\n",
-                                     len);
-                        return;
-                    }
-                    trace_alsa_resume_out();
-                    continue;
-
-                case -EAGAIN:
-                    return;
-
-                default:
-                    alsa_logerr (written, "Failed to write %d frames from %p\n",
-                                 len, src);
-                    return;
-                }
-            }
-
-            alsa->wpos = (alsa->wpos + written) % hw->samples;
-            alsa->pending -= written;
-            len -= written;
-        }
-    }
-}
-
-static int alsa_run_out (HWVoiceOut *hw, int live)
+static size_t alsa_write(HWVoiceOut *hw, void *buf, size_t len)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
-    int decr;
-    snd_pcm_sframes_t avail;
+    size_t pos = 0;
+    size_t len_frames = len >> hw->info.shift;
 
-    avail = alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of available playback frames\n");
-        return 0;
+    while (len_frames) {
+        char *src = advance(buf, pos);
+        snd_pcm_sframes_t written;
+
+        written = snd_pcm_writei(alsa->handle, src, len_frames);
+
+        if (written <= 0) {
+            switch (written) {
+            case 0:
+                trace_alsa_wrote_zero(len_frames);
+                return pos;
+
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_xrun_out();
+                continue;
+
+            case -ESTRPIPE:
+                /* stream is suspended and waiting for an
+                   application recovery */
+                if (alsa_resume(alsa->handle)) {
+                    alsa_logerr(written, "Failed to write %zu frames\n",
+                                len_frames);
+                    return pos;
+                }
+                trace_alsa_resume_out();
+                continue;
+
+            case -EAGAIN:
+                return pos;
+
+            default:
+                alsa_logerr(written, "Failed to write %zu frames from %p\n",
+                            len, src);
+                return pos;
+            }
+        }
+
+        pos += written << hw->info.shift;
+        if (written < len_frames) {
+            break;
+        }
+        len_frames -= written;
     }
 
-    decr = MIN (live, avail);
-    decr = audio_pcm_hw_clip_out (hw, alsa->pcm_buf, decr, alsa->pending);
-    alsa->pending += decr;
-    alsa_write_pending (alsa);
-    return decr;
+    return pos;
 }
 
 static void alsa_fini_out (HWVoiceOut *hw)
@@ -714,9 +670,6 @@ static void alsa_fini_out (HWVoiceOut *hw)
 
     ldebug ("alsa_fini\n");
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf = NULL;
 }
 
 static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
@@ -745,14 +698,6 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc(__func__, obt.samples, 1 << hw->info.shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate DAC buffer (%zu samples, each %d bytes)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
@@ -847,14 +792,6 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
-    if (!alsa->pcm_buf) {
-        dolog("Could not allocate ADC buffer (%zu samples, each %d bytes)\n",
-              hw->samples, 1 << hw->info.shift);
-        alsa_anal_close1 (&handle);
-        return -1;
-    }
-
     alsa->pollhlp.s = hw->s;
     alsa->handle = handle;
     alsa->dev = dev;
@@ -866,129 +803,48 @@ static void alsa_fini_in (HWVoiceIn *hw)
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
 
     alsa_anal_close (&alsa->handle, &alsa->pollhlp);
-
-    g_free(alsa->pcm_buf);
-    alsa->pcm_buf = NULL;
 }
 
-static int alsa_run_in (HWVoiceIn *hw)
+static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
-    int hwshift = hw->info.shift;
-    int i;
-    int live = audio_pcm_hw_get_live_in (hw);
-    int dead = hw->samples - live;
-    int decr;
-    struct {
-        int add;
-        int len;
-    } bufs[2] = {
-        { .add = hw->wpos, .len = 0 },
-        { .add = 0,        .len = 0 }
-    };
-    snd_pcm_sframes_t avail;
-    snd_pcm_uframes_t read_samples = 0;
+    size_t pos = 0;
 
-    if (!dead) {
-        return 0;
-    }
-
-    avail = alsa_get_avail (alsa->handle);
-    if (avail < 0) {
-        dolog ("Could not get number of captured frames\n");
-        return 0;
-    }
-
-    if (!avail) {
-        snd_pcm_state_t state;
-
-        state = snd_pcm_state (alsa->handle);
-        switch (state) {
-        case SND_PCM_STATE_PREPARED:
-            avail = hw->samples;
-            break;
-        case SND_PCM_STATE_SUSPENDED:
-            /* stream is suspended and waiting for an application recovery */
-            if (alsa_resume (alsa->handle)) {
-                dolog ("Failed to resume suspended input stream\n");
-                return 0;
-            }
-            trace_alsa_resume_in();
-            break;
-        default:
-            trace_alsa_no_frames(state);
-            return 0;
-        }
-    }
-
-    decr = MIN (dead, avail);
-    if (!decr) {
-        return 0;
-    }
-
-    if (hw->wpos + decr > hw->samples) {
-        bufs[0].len = (hw->samples - hw->wpos);
-        bufs[1].len = (decr - (hw->samples - hw->wpos));
-    }
-    else {
-        bufs[0].len = decr;
-    }
-
-    for (i = 0; i < 2; ++i) {
-        void *src;
-        struct st_sample *dst;
+    while (len) {
+        void *dst = advance(buf, pos);
         snd_pcm_sframes_t nread;
-        snd_pcm_uframes_t len;
 
-        len = bufs[i].len;
+        nread = snd_pcm_readi(alsa->handle, dst, len >> hw->info.shift);
 
-        src = advance (alsa->pcm_buf, bufs[i].add << hwshift);
-        dst = hw->conv_buf + bufs[i].add;
+        if (nread <= 0) {
+            switch (nread) {
+            case 0:
+                trace_alsa_read_zero(len);
+                return pos;;
 
-        while (len) {
-            nread = snd_pcm_readi (alsa->handle, src, len);
-
-            if (nread <= 0) {
-                switch (nread) {
-                case 0:
-                    trace_alsa_read_zero(len);
-                    goto exit;
-
-                case -EPIPE:
-                    if (alsa_recover (alsa->handle)) {
-                        alsa_logerr (nread, "Failed to read %ld frames\n", len);
-                        goto exit;
-                    }
-                    trace_alsa_xrun_in();
-                    continue;
-
-                case -EAGAIN:
-                    goto exit;
-
-                default:
-                    alsa_logerr (
-                        nread,
-                        "Failed to read %ld frames from %p\n",
-                        len,
-                        src
-                        );
-                    goto exit;
+            case -EPIPE:
+                if (alsa_recover(alsa->handle)) {
+                    alsa_logerr(nread, "Failed to read %zu frames\n", len);
+                    return pos;
                 }
+                trace_alsa_xrun_in();
+                continue;
+
+            case -EAGAIN:
+                return pos;
+
+            default:
+                alsa_logerr(nread, "Failed to read %zu frames to %p\n",
+                            len, dst);
+                return pos;;
             }
-
-            hw->conv (dst, src, nread);
-
-            src = advance (src, nread << hwshift);
-            dst += nread;
-
-            read_samples += nread;
-            len -= nread;
         }
+
+        pos += nread << hw->info.shift;
+        len -= nread << hw->info.shift;
     }
 
- exit:
-    hw->wpos = (hw->wpos + read_samples) % hw->samples;
-    return read_samples;
+    return pos;
 }
 
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
@@ -1059,12 +915,12 @@ static void alsa_audio_fini (void *opaque)
 static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
-    .run_out  = alsa_run_out,
+    .write    = alsa_write,
     .ctl_out  = alsa_ctl_out,
 
     .init_in  = alsa_init_in,
     .fini_in  = alsa_fini_in,
-    .run_in   = alsa_run_in,
+    .read     = alsa_read,
     .ctl_in   = alsa_ctl_in,
 };
 
-- 
2.20.1
