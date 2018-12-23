Received: from eggs.gnu.org ([208.118.235.92]:52650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkH-0008O3-Dx
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAkG-0003df-27
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAkF-0003WH-OC
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:53:07 -0500
Received: by mail-wr1-x441.google.com with SMTP id t6so10091170wrr.12
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:53:06 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:52:20 +0100
Message-Id: <03189c11f5216339f472d06925582a8e20e7b21b.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 44/52] audio: make mixeng optional
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

Implementation of the previously added mixeng option.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c          | 70 ++++++++++++++++++++++++++++++++++++++----
 audio/audio_template.h | 46 ++++++++++++++++-----------
 2 files changed, 92 insertions(+), 24 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7ba939560a..26ce25989f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -840,32 +840,46 @@ static void audio_timer (void *opaque)
  */
 size_t AUD_write(SWVoiceOut *sw, void *buf, size_t size)
 {
+    HWVoiceOut *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw = sw->hw;
 
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Writing to disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
 
-    return audio_pcm_sw_write(sw, buf, size);
+    if (hw->s->dev->out->mixeng) {
+        return audio_pcm_sw_write(sw, buf, size);
+    } else {
+        return hw->pcm_ops->write(hw, buf, size);
+    }
 }
 
 size_t AUD_read(SWVoiceIn *sw, void *buf, size_t size)
 {
+    HWVoiceIn *hw;
+
     if (!sw) {
         /* XXX: Consider options */
         return size;
     }
+    hw = sw->hw;
 
-    if (!sw->hw->enabled) {
+    if (!hw->enabled) {
         dolog ("Reading from disabled voice %s\n", SW_NAME (sw));
         return 0;
     }
 
-    return audio_pcm_sw_read(sw, buf, size);
+    if (hw->s->dev->in->mixeng) {
+        return audio_pcm_sw_read(sw, buf, size);
+    } else {
+        return hw->pcm_ops->read(hw, buf, size);
+    }
 }
 
 int AUD_get_buffer_size_out (SWVoiceOut *sw)
@@ -1087,6 +1101,26 @@ static void audio_run_out (AudioState *s)
     HWVoiceOut *hw = NULL;
     SWVoiceOut *sw;
 
+    if (!s->dev->out->mixeng) {
+        while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            sw = hw->sw_head.lh_first;
+
+            if (hw->pending_disable) {
+                hw->enabled = 0;
+                hw->pending_disable = 0;
+                if (hw->pcm_ops->enable_out) {
+                    hw->pcm_ops->enable_out(hw, false);
+                }
+            }
+
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
         size_t played, live, prev_rpos, free;
         int nb_live, cleanup_required;
@@ -1224,6 +1258,17 @@ static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
 
+    if (!s->dev->in->mixeng) {
+        while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
+            /* there is exactly 1 sw for each hw with no mixeng */
+            SWVoiceIn *sw = hw->sw_head.lh_first;
+            if (sw->active) {
+                sw->callback.fn(sw->callback.opaque, INT_MAX);
+            }
+        }
+        return;
+    }
+
     while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
         SWVoiceIn *sw;
         size_t captured = 0, min;
@@ -1717,6 +1762,11 @@ CaptureVoiceOut *AUD_add_capture(
         s = audio_init(NULL, NULL);
     }
 
+    if (!s->dev->out->mixeng) {
+        dolog("Can't capture with mixeng disabled\n");
+        goto err0;
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
@@ -1875,9 +1925,13 @@ QemuOptsList qemu_audiodev_opts = {
 static void validate_per_direction_opts(AudiodevPerDirectionOptions *pdo,
                                         Error **errp)
 {
+    if (!pdo->has_mixeng) {
+        pdo->has_mixeng = true;
+        pdo->mixeng = true;
+    }
     if (!pdo->has_fixed_settings) {
         pdo->has_fixed_settings = true;
-        pdo->fixed_settings = true;
+        pdo->fixed_settings = pdo->mixeng;
     }
     if (!pdo->fixed_settings &&
         (pdo->has_frequency || pdo->has_channels || pdo->has_format)) {
@@ -1885,6 +1939,10 @@ static void validate_per_direction_opts(AudiodevPerDirectionOptions *pdo,
                    "You can't use frequency, channels or format with fixed-settings=off");
         return;
     }
+    if (!pdo->mixeng && pdo->fixed_settings) {
+        error_setg(errp, "You can't use fixed-settings without mixeng");
+        return;
+    }
 
     if (!pdo->has_frequency) {
         pdo->has_frequency = true;
@@ -1896,7 +1954,7 @@ static void validate_per_direction_opts(AudiodevPerDirectionOptions *pdo,
     }
     if (!pdo->has_voices) {
         pdo->has_voices = true;
-        pdo->voices = 1;
+        pdo->voices = pdo->mixeng ? 1 : INT_MAX;
     }
     if (!pdo->has_format) {
         pdo->has_format = true;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 9ec565fc48..e5a4d6fa40 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -78,26 +78,32 @@ static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 
 static void glue(audio_pcm_hw_alloc_resources_, TYPE)(HW *hw)
 {
-    size_t samples;
-    if (!hw->pcm_ops) {
-        /*
-         * We should only end up here when using wavcapture hmp command (and not
-         * the wavcapture audio backend).
-         * It needs a lot of samples, otherwise you'll end up with "Could not
-         * mix X bytes into a capture buffer" warnings and a garbled capture.
-         */
-        samples = 4096 * 4;
-    } else if (hw->pcm_ops->glue(buffer_size_, TYPE)) {
-        samples = hw->pcm_ops->glue(buffer_size_, TYPE)(hw);
+    if (hw->s->dev->TYPE->mixeng) {
+        size_t samples;
+        if (!hw->pcm_ops) {
+            /*
+             * We should only end up here when using wavcapture hmp command (and
+             * not the wavcapture audio backend).
+             * It needs a lot of samples, otherwise you'll end up with "Could
+             * not mix X bytes into a capture buffer" warnings and a garbled
+             * capture.
+             */
+            samples = 4096 * 4;
+        } else if (hw->pcm_ops->glue(buffer_size_, TYPE)) {
+            samples = hw->pcm_ops->glue(buffer_size_, TYPE)(hw);
+        } else {
+            samples = 1024; /* todo better default */
+        }
+
+        if (audio_bug(__func__, samples == 0)) {
+            dolog("Attempted to allocate empty buffer\n");
+        }
+
+        HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
+        HWBUF->size = samples;
     } else {
-        samples = 1024; /* todo better default */
+        HWBUF = NULL;
     }
-    if (audio_bug(__func__, samples == 0)) {
-        dolog("Attempted to allocate empty buffer\n");
-    }
-
-    HWBUF = g_malloc0(sizeof(STSampleBuffer) + sizeof(st_sample) * samples);
-    HWBUF->size = samples;
 }
 
 static void glue (audio_pcm_sw_free_resources_, TYPE) (SW *sw)
@@ -116,6 +122,10 @@ static int glue (audio_pcm_sw_alloc_resources_, TYPE) (SW *sw)
 {
     int samples;
 
+    if (!sw->s->dev->TYPE->mixeng) {
+        return 0;
+    }
+
     samples = ((int64_t) sw->HWBUF->size << 32) / sw->ratio;
 
     sw->buf = audio_calloc(__func__, samples, sizeof(struct st_sample));
-- 
2.20.1
