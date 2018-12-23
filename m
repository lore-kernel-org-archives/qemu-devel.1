Received: from eggs.gnu.org ([208.118.235.92]:52559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkB-0008E9-Ff
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkA-0003Iy-BF
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAkA-0003Fp-3M
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:02 -0500
Received: by mail-wm1-x344.google.com with SMTP id y185so18070806wmd.1
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:53:02 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:14 +0100
Message-Id: <8627649dea93ec22ccc713ce7f8ba1ea72d14098.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 38/52] audio: remove remains of the old
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
 audio/audio.c     | 42 ++++++------------------------------------
 audio/audio_int.h |  7 -------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 1897e22444..4c33e057d7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -543,7 +543,7 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
+static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
     if (audio_bug(__func__, live > hw->samples)) {
@@ -553,29 +553,7 @@ size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
     return live;
 }
 
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending)
-{
-    size_t left = hw->samples - pending;
-    size_t len = MIN (left, live);
-    size_t clipped = 0;
-
-    while (len) {
-        struct st_sample *src = hw->mix_buf + hw->rpos;
-        uint8_t *dst = advance (pcm_buf, hw->rpos << hw->info.shift);
-        size_t samples_till_end_of_buf = hw->samples - hw->rpos;
-        size_t samples_to_clip = MIN (len, samples_till_end_of_buf);
-
-        hw->clip (dst, src, samples_to_clip);
-
-        hw->rpos = (hw->rpos + samples_to_clip) % hw->samples;
-        len -= samples_to_clip;
-        clipped += samples_to_clip;
-    }
-    return clipped;
-}
-
-static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t len)
+static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
 {
     size_t clipped = 0;
     size_t pos = hw->rpos;
@@ -1080,7 +1058,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
 
         decr = MIN(size >> hw->info.shift, live);
-        audio_pcm_hw_clip_out2(hw, buf, decr);
+        audio_pcm_hw_clip_out(hw, buf, decr);
         proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
             hw->info.shift;
 
@@ -1143,11 +1121,7 @@ static void audio_run_out (AudioState *s)
         }
 
         prev_rpos = hw->rpos;
-        if (hw->pcm_ops->run_out) {
-            played = hw->pcm_ops->run_out(hw, live);
-        } else {
-            played = audio_pcm_hw_run_out(hw, live);
-        }
+        played = audio_pcm_hw_run_out(hw, live);
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
@@ -1244,12 +1218,8 @@ static void audio_run_in (AudioState *s)
         size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
-            if (hw->pcm_ops->run_in) {
-                captured = hw->pcm_ops->run_in(hw);
-            } else {
-                captured = audio_pcm_hw_run_in(
-                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
-            }
+            captured = audio_pcm_hw_run_in(
+                hw, hw->samples - audio_pcm_hw_get_live_in(hw));
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 5c361d9451..cca7efaa05 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -152,7 +152,6 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
-    int    (*run_out) (HWVoiceOut *hw, int live);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
@@ -170,7 +169,6 @@ struct audio_pcm_ops {
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
-    int    (*run_in)  (HWVoiceIn *hw);
     size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
     void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
     void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
@@ -236,11 +234,6 @@ audio_driver *audio_driver_lookup(const char *name);
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw);
-
-size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
-                             size_t live, size_t pending);
-
 int audio_bug (const char *funcname, int cond);
 void *audio_calloc (const char *funcname, int nmemb, size_t size);
 
-- 
2.20.1
