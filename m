Received: from eggs.gnu.org ([209.51.188.92]:58207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0004MD-Rx
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul3-0003Od-IH
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukz-0003Dw-Kj
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id y8so3854222wmi.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:58 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:09 +0100
Message-Id: <145498a842625fd7e025660dafce06db2edaf196.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 36/50] audio: remove remains of the old
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
 audio/audio_int.h |  7 -------
 audio/audio.c     | 42 ++++++------------------------------------
 2 files changed, 6 insertions(+), 43 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 056c63d45c..1f6ec15e18 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -152,7 +152,6 @@ struct audio_driver {
 struct audio_pcm_ops {
     int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
     void   (*fini_out)(HWVoiceOut *hw);
-    size_t (*run_out)(HWVoiceOut *hw, size_t live);
     size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
     /*
      * get a buffer that after later can be passed to put_buffer_out; optional
@@ -170,7 +169,6 @@ struct audio_pcm_ops {
 
     int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
     void   (*fini_in) (HWVoiceIn *hw);
-    size_t (*run_in)(HWVoiceIn *hw);
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
 
diff --git a/audio/audio.c b/audio/audio.c
index f4d538618f..8bfc122e60 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -542,7 +542,7 @@ static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
     return m;
 }
 
-size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
+static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
 {
     size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
     if (audio_bug(__func__, live > hw->samples)) {
@@ -552,29 +552,7 @@ size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
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
@@ -1079,7 +1057,7 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
 
         decr = MIN(size >> hw->info.shift, live);
-        audio_pcm_hw_clip_out2(hw, buf, decr);
+        audio_pcm_hw_clip_out(hw, buf, decr);
         proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
             hw->info.shift;
 
@@ -1142,11 +1120,7 @@ static void audio_run_out (AudioState *s)
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
@@ -1243,12 +1217,8 @@ static void audio_run_in (AudioState *s)
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
 
-- 
2.20.1
