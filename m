Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZKy-0007SL-6z
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZKu-0002rh-RJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:48 -0500
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com
	([104.47.32.86]:48096
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZKu-0002qB-G9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:44 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:28 -0800
Message-ID: <093ec04176290ed7bf8279b669b15ff71465d21d.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 01/45] audio: Replace AUDIO_FUNC with
 __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Apparently we don't use __MSC_VER as a compiler anymore and we always
require a C99 compiler (which means we always have __func__) so we don't
need a special AUDIO_FUNC macro. We can just replace AUDIO_FUNC with
__func__ instead.

Checkpatch failures were manually fixed.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

 audio/alsaaudio.c      |  4 ++--
 audio/audio.c          | 40 ++++++++++++++++++------------------
 audio/audio_int.h      |  6 ------
 audio/audio_pt_int.c   | 28 ++++++++++++-------------
 audio/audio_template.h | 26 +++++++++++------------
 audio/dsoundaudio.c    |  2 +-
 audio/mixeng.c         |  2 +-
 audio/ossaudio.c       | 10 ++++-----
 audio/paaudio.c        | 56 +++++++++++++++++++++++++-------------------------
 audio/sdlaudio.c       |  2 +-
 audio/wavaudio.c       |  2 +-
 11 files changed, 85 insertions(+), 93 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3652a7b5fa..92a96f8b2b 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -823,7 +823,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc (AUDIO_FUNC, obt.samples, 1 << hw->info.shift);
+    alsa->pcm_buf = audio_calloc(__func__, obt.samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
         dolog ("Could not allocate DAC buffer (%d samples, each %d bytes)\n",
                hw->samples, 1 << hw->info.shift);
@@ -934,7 +934,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = obt.samples;
 
-    alsa->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+    alsa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!alsa->pcm_buf) {
         dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
                hw->samples, 1 << hw->info.shift);
diff --git a/audio/audio.c b/audio/audio.c
index beafed209b..7658d2af66 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -424,12 +424,12 @@ static void audio_process_options (const char *prefix,
     const char qemu_prefix[] = "QEMU_";
     size_t preflen, optlen;
 
-    if (audio_bug (AUDIO_FUNC, !prefix)) {
+    if (audio_bug(__func__, !prefix)) {
         dolog ("prefix = NULL\n");
         return;
     }
 
-    if (audio_bug (AUDIO_FUNC, !opt)) {
+    if (audio_bug(__func__, !opt)) {
         dolog ("opt = NULL\n");
         return;
     }
@@ -792,7 +792,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         SWVoiceOut *sw;
         HWVoiceOut *hw_cap = &cap->hw;
 
-        sc = audio_calloc (AUDIO_FUNC, 1, sizeof (*sc));
+        sc = audio_calloc(__func__, 1, sizeof(*sc));
         if (!sc) {
             dolog ("Could not allocate soft capture voice (%zu bytes)\n",
                    sizeof (*sc));
@@ -848,7 +848,7 @@ static int audio_pcm_hw_find_min_in (HWVoiceIn *hw)
 int audio_pcm_hw_get_live_in (HWVoiceIn *hw)
 {
     int live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live=%d hw->samples=%d\n", live, hw->samples);
         return 0;
     }
@@ -886,7 +886,7 @@ static int audio_pcm_sw_get_rpos_in (SWVoiceIn *sw)
     int live = hw->total_samples_captured - sw->total_hw_samples_acquired;
     int rpos;
 
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live=%d hw->samples=%d\n", live, hw->samples);
         return 0;
     }
@@ -909,7 +909,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
     rpos = audio_pcm_sw_get_rpos_in (sw) % hw->samples;
 
     live = hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > hw->samples)) {
         dolog ("live_in=%d hw->samples=%d\n", live, hw->samples);
         return 0;
     }
@@ -935,7 +935,7 @@ int audio_pcm_sw_read (SWVoiceIn *sw, void *buf, int size)
         }
         osamp = swlim;
 
-        if (audio_bug (AUDIO_FUNC, osamp < 0)) {
+        if (audio_bug(__func__, osamp < 0)) {
             dolog ("osamp=%d\n", osamp);
             return 0;
         }
@@ -990,7 +990,7 @@ static int audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
     if (nb_live1) {
         int live = smin;
 
-        if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
             dolog ("live=%d hw->samples=%d\n", live, hw->samples);
             return 0;
         }
@@ -1014,7 +1014,7 @@ int audio_pcm_sw_write (SWVoiceOut *sw, void *buf, int size)
     hwsamples = sw->hw->samples;
 
     live = sw->total_hw_samples_mixed;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > hwsamples)){
+    if (audio_bug(__func__, live < 0 || live > hwsamples)) {
         dolog ("live=%d hw->samples=%d\n", live, hwsamples);
         return 0;
     }
@@ -1263,7 +1263,7 @@ static int audio_get_avail (SWVoiceIn *sw)
     }
 
     live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > sw->hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
         dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
         return 0;
     }
@@ -1287,7 +1287,7 @@ static int audio_get_free (SWVoiceOut *sw)
 
     live = sw->total_hw_samples_mixed;
 
-    if (audio_bug (AUDIO_FUNC, live < 0 || live > sw->hw->samples)) {
+    if (audio_bug(__func__, live < 0 || live > sw->hw->samples)) {
         dolog ("live=%d sw->hw->samples=%d\n", live, sw->hw->samples);
         return 0;
     }
@@ -1354,7 +1354,7 @@ static void audio_run_out (AudioState *s)
             live = 0;
         }
 
-        if (audio_bug (AUDIO_FUNC, live < 0 || live > hw->samples)) {
+        if (audio_bug(__func__, live < 0 || live > hw->samples)) {
             dolog ("live=%d hw->samples=%d\n", live, hw->samples);
             continue;
         }
@@ -1389,7 +1389,7 @@ static void audio_run_out (AudioState *s)
         prev_rpos = hw->rpos;
         played = hw->pcm_ops->run_out (hw, live);
         replay_audio_out(&played);
-        if (audio_bug (AUDIO_FUNC, hw->rpos >= hw->samples)) {
+        if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog ("hw->rpos=%d hw->samples=%d played=%d\n",
                    hw->rpos, hw->samples, played);
             hw->rpos = 0;
@@ -1410,7 +1410,7 @@ static void audio_run_out (AudioState *s)
                 continue;
             }
 
-            if (audio_bug (AUDIO_FUNC, played > sw->total_hw_samples_mixed)) {
+            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
                 dolog ("played=%d sw->total_hw_samples_mixed=%d\n",
                        played, sw->total_hw_samples_mixed);
                 played = sw->total_hw_samples_mixed;
@@ -1513,7 +1513,7 @@ static void audio_run_capture (AudioState *s)
                 continue;
             }
 
-            if (audio_bug (AUDIO_FUNC, captured > sw->total_hw_samples_mixed)) {
+            if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
                 dolog ("captured=%d sw->total_hw_samples_mixed=%d\n",
                        captured, sw->total_hw_samples_mixed);
                 captured = sw->total_hw_samples_mixed;
@@ -1924,7 +1924,7 @@ CaptureVoiceOut *AUD_add_capture (
         goto err0;
     }
 
-    cb = audio_calloc (AUDIO_FUNC, 1, sizeof (*cb));
+    cb = audio_calloc(__func__, 1, sizeof(*cb));
     if (!cb) {
         dolog ("Could not allocate capture callback information, size %zu\n",
                sizeof (*cb));
@@ -1942,7 +1942,7 @@ CaptureVoiceOut *AUD_add_capture (
         HWVoiceOut *hw;
         CaptureVoiceOut *cap;
 
-        cap = audio_calloc (AUDIO_FUNC, 1, sizeof (*cap));
+        cap = audio_calloc(__func__, 1, sizeof(*cap));
         if (!cap) {
             dolog ("Could not allocate capture voice, size %zu\n",
                    sizeof (*cap));
@@ -1955,8 +1955,8 @@ CaptureVoiceOut *AUD_add_capture (
 
         /* XXX find a more elegant way */
         hw->samples = 4096 * 4;
-        hw->mix_buf = audio_calloc (AUDIO_FUNC, hw->samples,
-                                    sizeof (struct st_sample));
+        hw->mix_buf = audio_calloc(__func__, hw->samples,
+                                   sizeof(struct st_sample));
         if (!hw->mix_buf) {
             dolog ("Could not allocate capture mix buffer (%d samples)\n",
                    hw->samples);
@@ -1965,7 +1965,7 @@ CaptureVoiceOut *AUD_add_capture (
 
         audio_pcm_init_info (&hw->info, as);
 
-        cap->buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+        cap->buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
         if (!cap->buf) {
             dolog ("Could not allocate capture buffer "
                    "(%d samples, each %d bytes)\n",
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5bcb1c60e1..5b25da0a37 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -252,10 +252,4 @@ static inline int audio_ring_dist (int dst, int src, int len)
 #define AUDIO_STRINGIFY_(n) #n
 #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
 
-#if defined _MSC_VER || defined __GNUC__
-#define AUDIO_FUNC __FUNCTION__
-#else
-#define AUDIO_FUNC __FILE__ ":" AUDIO_STRINGIFY (__LINE__)
-#endif
-
 #endif /* QEMU_AUDIO_INT_H */
diff --git a/audio/audio_pt_int.c b/audio/audio_pt_int.c
index 21ff9c5803..3fe56d8514 100644
--- a/audio/audio_pt_int.c
+++ b/audio/audio_pt_int.c
@@ -31,7 +31,7 @@ int audio_pt_init (struct audio_pt *p, void *(*func) (void *),
 
     err = sigfillset (&set);
     if (err) {
-        logerr (p, errno, "%s(%s): sigfillset failed", cap, AUDIO_FUNC);
+        logerr(p, errno, "%s(%s): sigfillset failed", cap, __func__);
         return -1;
     }
 
@@ -57,8 +57,8 @@ int audio_pt_init (struct audio_pt *p, void *(*func) (void *),
 
     err2 = pthread_sigmask (SIG_SETMASK, &old_set, NULL);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_sigmask (restore) failed",
-                cap, AUDIO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_sigmask (restore) failed",
+               cap, __func__);
         /* We have failed to restore original signal mask, all bets are off,
            so terminate the process */
         exit (EXIT_FAILURE);
@@ -74,17 +74,17 @@ int audio_pt_init (struct audio_pt *p, void *(*func) (void *),
  err2:
     err2 = pthread_cond_destroy (&p->cond);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_cond_destroy failed", cap, AUDIO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_cond_destroy failed", cap, __func__);
     }
 
  err1:
     err2 = pthread_mutex_destroy (&p->mutex);
     if (err2) {
-        logerr (p, err2, "%s(%s): pthread_mutex_destroy failed", cap, AUDIO_FUNC);
+        logerr(p, err2, "%s(%s): pthread_mutex_destroy failed", cap, __func__);
     }
 
  err0:
-    logerr (p, err, "%s(%s): %s failed", cap, AUDIO_FUNC, efunc);
+    logerr(p, err, "%s(%s): %s failed", cap, __func__, efunc);
     return -1;
 }
 
@@ -94,13 +94,13 @@ int audio_pt_fini (struct audio_pt *p, const char *cap)
 
     err = pthread_cond_destroy (&p->cond);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_destroy failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_cond_destroy failed", cap, __func__);
         ret = -1;
     }
 
     err = pthread_mutex_destroy (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_destroy failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_destroy failed", cap, __func__);
         ret = -1;
     }
     return ret;
@@ -112,7 +112,7 @@ int audio_pt_lock (struct audio_pt *p, const char *cap)
 
     err = pthread_mutex_lock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_lock failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_lock failed", cap, __func__);
         return -1;
     }
     return 0;
@@ -124,7 +124,7 @@ int audio_pt_unlock (struct audio_pt *p, const char *cap)
 
     err = pthread_mutex_unlock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_unlock failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __func__);
         return -1;
     }
     return 0;
@@ -136,7 +136,7 @@ int audio_pt_wait (struct audio_pt *p, const char *cap)
 
     err = pthread_cond_wait (&p->cond, &p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_wait failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_cond_wait failed", cap, __func__);
         return -1;
     }
     return 0;
@@ -148,12 +148,12 @@ int audio_pt_unlock_and_signal (struct audio_pt *p, const char *cap)
 
     err = pthread_mutex_unlock (&p->mutex);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_mutex_unlock failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_mutex_unlock failed", cap, __func__);
         return -1;
     }
     err = pthread_cond_signal (&p->cond);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_cond_signal failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_cond_signal failed", cap, __func__);
         return -1;
     }
     return 0;
@@ -166,7 +166,7 @@ int audio_pt_join (struct audio_pt *p, void **arg, const char *cap)
 
     err = pthread_join (p->thread, &ret);
     if (err) {
-        logerr (p, err, "%s(%s): pthread_join failed", cap, AUDIO_FUNC);
+        logerr(p, err, "%s(%s): pthread_join failed", cap, __func__);
         return -1;
     }
     *arg = ret;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 99b27b285e..7de227d2d1 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -57,13 +57,13 @@ static void glue (audio_init_nb_voices_, TYPE) (struct audio_driver *drv)
         glue (s->nb_hw_voices_, TYPE) = max_voices;
     }
 
-    if (audio_bug (AUDIO_FUNC, !voice_size && max_voices)) {
+    if (audio_bug(__func__, !voice_size && max_voices)) {
         dolog ("drv=`%s' voice_size=0 max_voices=%d\n",
                drv->name, max_voices);
         glue (s->nb_hw_voices_, TYPE) = 0;
     }
 
-    if (audio_bug (AUDIO_FUNC, voice_size && !max_voices)) {
+    if (audio_bug(__func__, voice_size && !max_voices)) {
         dolog ("drv=`%s' voice_size=%d max_voices=0\n",
                drv->name, voice_size);
     }
@@ -77,7 +77,7 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 
 static int glue (audio_pcm_hw_alloc_resources_, TYPE) (HW *hw)
 {
-    HWBUF = audio_calloc (AUDIO_FUNC, hw->samples, sizeof (struct st_sample));
+    HWBUF = audio_calloc(__func__, hw->samples, sizeof(struct st_sample));
     if (!HWBUF) {
         dolog ("Could not allocate " NAME " buffer (%d samples)\n",
                hw->samples);
@@ -105,7 +105,7 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
 
     samples = ((int64_t) sw->hw->samples << 32) / sw->ratio;
 
-    sw->buf = audio_calloc (AUDIO_FUNC, samples, sizeof (struct st_sample));
+    sw->buf = audio_calloc(__func__, samples, sizeof(struct st_sample));
     if (!sw->buf) {
         dolog ("Could not allocate buffer for `%s' (%d samples)\n",
                SW_NAME (sw), samples);
@@ -238,17 +238,17 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
         return NULL;
     }
 
-    if (audio_bug (AUDIO_FUNC, !drv)) {
+    if (audio_bug(__func__, !drv)) {
         dolog ("No host audio driver\n");
         return NULL;
     }
 
-    if (audio_bug (AUDIO_FUNC, !drv->pcm_ops)) {
+    if (audio_bug(__func__, !drv->pcm_ops)) {
         dolog ("Host audio driver without pcm_ops\n");
         return NULL;
     }
 
-    hw = audio_calloc (AUDIO_FUNC, 1, glue (drv->voice_size_, TYPE));
+    hw = audio_calloc(__func__, 1, glue(drv->voice_size_, TYPE));
     if (!hw) {
         dolog ("Can not allocate voice `%s' size %d\n",
                drv->name, glue (drv->voice_size_, TYPE));
@@ -266,7 +266,7 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
         goto err0;
     }
 
-    if (audio_bug (AUDIO_FUNC, hw->samples <= 0)) {
+    if (audio_bug(__func__, hw->samples <= 0)) {
         dolog ("hw->samples=%d\n", hw->samples);
         goto err1;
     }
@@ -339,7 +339,7 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
         hw_as = *as;
     }
 
-    sw = audio_calloc (AUDIO_FUNC, 1, sizeof (*sw));
+    sw = audio_calloc(__func__, 1, sizeof(*sw));
     if (!sw) {
         dolog ("Could not allocate soft voice `%s' (%zu bytes)\n",
                sw_name ? sw_name : "unknown", sizeof (*sw));
@@ -379,7 +379,7 @@ static void glue (audio_close_, TYPE) (SW *sw)
 void glue (AUD_close_, TYPE) (QEMUSoundCard *card, SW *sw)
 {
     if (sw) {
-        if (audio_bug (AUDIO_FUNC, !card)) {
+        if (audio_bug(__func__, !card)) {
             dolog ("card=%p\n", card);
             return;
         }
@@ -399,7 +399,7 @@ SW *glue (AUD_open_, TYPE) (
 {
     AudioState *s = &glob_audio_state;
 
-    if (audio_bug (AUDIO_FUNC, !card || !name || !callback_fn || !as)) {
+    if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
         dolog ("card=%p name=%p callback_fn=%p as=%p\n",
                card, name, callback_fn, as);
         goto fail;
@@ -408,12 +408,12 @@ SW *glue (AUD_open_, TYPE) (
     ldebug ("open %s, freq %d, nchannels %d, fmt %d\n",
             name, as->freq, as->nchannels, as->fmt);
 
-    if (audio_bug (AUDIO_FUNC, audio_validate_settings (as))) {
+    if (audio_bug(__func__, audio_validate_settings(as))) {
         audio_print_settings (as);
         goto fail;
     }
 
-    if (audio_bug (AUDIO_FUNC, !s->drv)) {
+    if (audio_bug(__func__, !s->drv)) {
         dolog ("Can not open `%s' (no host audio driver)\n", name);
         goto fail;
     }
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 516846eb80..bc39cb9b4d 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -543,7 +543,7 @@ static int dsound_run_out (HWVoiceOut *hw, int live)
         }
     }
 
-    if (audio_bug (AUDIO_FUNC, len < 0 || len > bufsize)) {
+    if (audio_bug(__func__, len < 0 || len > bufsize)) {
         dolog ("len=%d bufsize=%d old_pos=%ld ppos=%ld\n",
                len, bufsize, old_pos, ppos);
         return 0;
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 0bf9b5360f..2ab22df2aa 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -344,7 +344,7 @@ struct rate {
  */
 void *st_rate_start (int inrate, int outrate)
 {
-    struct rate *rate = audio_calloc (AUDIO_FUNC, 1, sizeof (*rate));
+    struct rate *rate = audio_calloc(__func__, 1, sizeof(*rate));
 
     if (!rate) {
         dolog ("Could not allocate resampler (%zu bytes)\n", sizeof (*rate));
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0edd7ea5fe..a0428881c2 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -582,11 +582,9 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     if (!oss->mmapped) {
-        oss->pcm_buf = audio_calloc (
-            AUDIO_FUNC,
-            hw->samples,
-            1 << hw->info.shift
-            );
+        oss->pcm_buf = audio_calloc(__func__,
+                                    hw->samples,
+                                    1 << hw->info.shift);
         if (!oss->pcm_buf) {
             dolog (
                 "Could not allocate DAC buffer (%d samples, each %d bytes)\n",
@@ -705,7 +703,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
-    oss->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+    oss->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!oss->pcm_buf) {
         dolog ("Could not allocate ADC buffer (%d samples, each %d bytes)\n",
                hw->samples, 1 << hw->info.shift);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 65beb6f010..8cf19c51d0 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -206,7 +206,7 @@ static void *qpa_thread_out (void *arg)
     PAVoiceOut *pa = arg;
     HWVoiceOut *hw = &pa->hw;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return NULL;
     }
 
@@ -222,7 +222,7 @@ static void *qpa_thread_out (void *arg)
                 break;
             }
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
+            if (audio_pt_wait(&pa->pt, __func__)) {
                 goto exit;
             }
         }
@@ -230,7 +230,7 @@ static void *qpa_thread_out (void *arg)
         decr = to_mix = audio_MIN (pa->live, pa->g->conf.samples >> 2);
         rpos = pa->rpos;
 
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_unlock(&pa->pt, __func__)) {
             return NULL;
         }
 
@@ -251,7 +251,7 @@ static void *qpa_thread_out (void *arg)
             to_mix -= chunk;
         }
 
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_lock(&pa->pt, __func__)) {
             return NULL;
         }
 
@@ -261,7 +261,7 @@ static void *qpa_thread_out (void *arg)
     }
 
  exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+    audio_pt_unlock(&pa->pt, __func__);
     return NULL;
 }
 
@@ -270,7 +270,7 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     int decr;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return 0;
     }
 
@@ -279,10 +279,10 @@ static int qpa_run_out (HWVoiceOut *hw, int live)
     pa->live = live - decr;
     hw->rpos = pa->rpos;
     if (pa->live > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock_and_signal(&pa->pt, __func__);
     }
     else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock(&pa->pt, __func__);
     }
     return decr;
 }
@@ -298,7 +298,7 @@ static void *qpa_thread_in (void *arg)
     PAVoiceIn *pa = arg;
     HWVoiceIn *hw = &pa->hw;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return NULL;
     }
 
@@ -314,7 +314,7 @@ static void *qpa_thread_in (void *arg)
                 break;
             }
 
-            if (audio_pt_wait (&pa->pt, AUDIO_FUNC)) {
+            if (audio_pt_wait(&pa->pt, __func__)) {
                 goto exit;
             }
         }
@@ -322,7 +322,7 @@ static void *qpa_thread_in (void *arg)
         incr = to_grab = audio_MIN (pa->dead, pa->g->conf.samples >> 2);
         wpos = pa->wpos;
 
-        if (audio_pt_unlock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_unlock(&pa->pt, __func__)) {
             return NULL;
         }
 
@@ -342,7 +342,7 @@ static void *qpa_thread_in (void *arg)
             to_grab -= chunk;
         }
 
-        if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+        if (audio_pt_lock(&pa->pt, __func__)) {
             return NULL;
         }
 
@@ -352,7 +352,7 @@ static void *qpa_thread_in (void *arg)
     }
 
  exit:
-    audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+    audio_pt_unlock(&pa->pt, __func__);
     return NULL;
 }
 
@@ -361,7 +361,7 @@ static int qpa_run_in (HWVoiceIn *hw)
     int live, incr, dead;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
 
-    if (audio_pt_lock (&pa->pt, AUDIO_FUNC)) {
+    if (audio_pt_lock(&pa->pt, __func__)) {
         return 0;
     }
 
@@ -372,10 +372,10 @@ static int qpa_run_in (HWVoiceIn *hw)
     pa->dead = dead - incr;
     hw->wpos = pa->wpos;
     if (pa->dead > 0) {
-        audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock_and_signal(&pa->pt, __func__);
     }
     else {
-        audio_pt_unlock (&pa->pt, AUDIO_FUNC);
+        audio_pt_unlock(&pa->pt, __func__);
     }
     return incr;
 }
@@ -579,7 +579,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = g->conf.samples;
-    pa->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+    pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->rpos = hw->rpos;
     if (!pa->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
@@ -587,7 +587,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         goto fail2;
     }
 
-    if (audio_pt_init (&pa->pt, qpa_thread_out, hw, AUDIO_CAP, AUDIO_FUNC)) {
+    if (audio_pt_init(&pa->pt, qpa_thread_out, hw, AUDIO_CAP, __func__)) {
         goto fail3;
     }
 
@@ -636,7 +636,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     audio_pcm_init_info (&hw->info, &obt_as);
     hw->samples = g->conf.samples;
-    pa->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+    pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->wpos = hw->wpos;
     if (!pa->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
@@ -644,7 +644,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         goto fail2;
     }
 
-    if (audio_pt_init (&pa->pt, qpa_thread_in, hw, AUDIO_CAP, AUDIO_FUNC)) {
+    if (audio_pt_init(&pa->pt, qpa_thread_in, hw, AUDIO_CAP, __func__)) {
         goto fail3;
     }
 
@@ -667,17 +667,17 @@ static void qpa_fini_out (HWVoiceOut *hw)
     void *ret;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
 
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
+    audio_pt_lock(&pa->pt, __func__);
     pa->done = 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
+    audio_pt_unlock_and_signal(&pa->pt, __func__);
+    audio_pt_join(&pa->pt, &ret, __func__);
 
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream = NULL;
     }
 
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
+    audio_pt_fini(&pa->pt, __func__);
     g_free (pa->pcm_buf);
     pa->pcm_buf = NULL;
 }
@@ -687,17 +687,17 @@ static void qpa_fini_in (HWVoiceIn *hw)
     void *ret;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
 
-    audio_pt_lock (&pa->pt, AUDIO_FUNC);
+    audio_pt_lock(&pa->pt, __func__);
     pa->done = 1;
-    audio_pt_unlock_and_signal (&pa->pt, AUDIO_FUNC);
-    audio_pt_join (&pa->pt, &ret, AUDIO_FUNC);
+    audio_pt_unlock_and_signal(&pa->pt, __func__);
+    audio_pt_join(&pa->pt, &ret, __func__);
 
     if (pa->stream) {
         pa_stream_unref (pa->stream);
         pa->stream = NULL;
     }
 
-    audio_pt_fini (&pa->pt, AUDIO_FUNC);
+    audio_pt_fini(&pa->pt, __func__);
     g_free (pa->pcm_buf);
     pa->pcm_buf = NULL;
 }
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index e8d91d22af..e92135bd2f 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -277,7 +277,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
             return;
         }
 
-        if (audio_bug (AUDIO_FUNC, sdl->live < 0 || sdl->live > hw->samples)) {
+        if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples)) {
             dolog ("sdl->live=%d hw->samples=%d\n",
                    sdl->live, hw->samples);
             return;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 341eec3121..068a595732 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -139,7 +139,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     audio_pcm_init_info (&hw->info, &wav_as);
 
     hw->samples = 1024;
-    wav->pcm_buf = audio_calloc (AUDIO_FUNC, hw->samples, 1 << hw->info.shift);
+    wav->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     if (!wav->pcm_buf) {
         dolog ("Could not allocate buffer (%d bytes)\n",
                hw->samples << hw->info.shift);
-- 
2.14.1
