Received: from eggs.gnu.org ([209.51.188.92]:58285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul7-0004OE-CX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Q0-19
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul3-00033b-J5
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so9004784wrr.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:50 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:59 +0100
Message-Id: <c1e7f511d4fd8757e3583b9f27c4b903b481b50e.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 26/50] audio: api for mixeng code free
 backends
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
 audio/audio_int.h      |  41 ++++++--
 audio/audio_template.h |   1 +
 audio/audio.c          | 211 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 245 insertions(+), 8 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 9dcdf541fb..056c63d45c 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -64,6 +64,8 @@ typedef struct HWVoiceOut {
     uint64_t ts_helper;
 
     struct st_sample *mix_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
 
     size_t samples;
     QLIST_HEAD (sw_out_listhead, SWVoiceOut) sw_head;
@@ -86,6 +88,8 @@ typedef struct HWVoiceIn {
     uint64_t ts_helper;
 
     struct st_sample *conv_buf;
+    void *buf_emul;
+    size_t pos_emul, pending_emul, size_emul;
 
     size_t samples;
     QLIST_HEAD (sw_in_listhead, SWVoiceIn) sw_head;
@@ -146,17 +150,42 @@ struct audio_driver {
 };
 
 struct audio_pcm_ops {
-    int  (*init_out)(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque);
-    void (*fini_out)(HWVoiceOut *hw);
+    int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
+    void   (*fini_out)(HWVoiceOut *hw);
     size_t (*run_out)(HWVoiceOut *hw, size_t live);
-    int  (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
+    size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
+    /*
+     * get a buffer that after later can be passed to put_buffer_out; optional
+     * returns the buffer, and writes it's size to size (in bytes)
+     * this is unrelated to the above buffer_size_out function
+     */
+    void  *(*get_buffer_out)(HWVoiceOut *hw, size_t *size);
+    /*
+     * put back the buffer returned by get_buffer_out; optional
+     * buf must be equal the pointer returned by get_buffer_out,
+     * size may be smaller
+     */
+    size_t (*put_buffer_out)(HWVoiceOut *hw, void *buf, size_t size);
+    int    (*ctl_out) (HWVoiceOut *hw, int cmd, ...);
 
-    int  (*init_in) (HWVoiceIn *hw, struct audsettings *as, void *drv_opaque);
-    void (*fini_in) (HWVoiceIn *hw);
+    int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
+    void   (*fini_in) (HWVoiceIn *hw);
     size_t (*run_in)(HWVoiceIn *hw);
-    int  (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
+    size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
+    void  *(*get_buffer_in)(HWVoiceIn *hw, size_t *size);
+    void   (*put_buffer_in)(HWVoiceIn *hw, void *buf, size_t size);
+    int    (*ctl_in)  (HWVoiceIn *hw, int cmd, ...);
 };
 
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size);
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size);
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size);
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size);
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size);
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size);
+
 struct capture_callback {
     struct audio_capture_ops ops;
     void *opaque;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 9a8aa1eebf..fcab583cfc 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -71,6 +71,7 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioState *s,
 
 static void glue (audio_pcm_hw_free_resources_, TYPE) (HW *hw)
 {
+    g_free(hw->buf_emul);
     g_free (HWBUF);
     HWBUF = NULL;
 }
diff --git a/audio/audio.c b/audio/audio.c
index 33b11e4feb..f4d538618f 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -574,6 +574,25 @@ size_t audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf,
     return clipped;
 }
 
+static void audio_pcm_hw_clip_out2(HWVoiceOut *hw, void *pcm_buf, size_t len)
+{
+    size_t clipped = 0;
+    size_t pos = hw->rpos;
+
+    while (len) {
+        st_sample *src = hw->mix_buf + pos;
+        uint8_t *dst = advance (pcm_buf, clipped << hw->info.shift);
+        size_t samples_till_end_of_buf = hw->samples - pos;
+        size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
+
+        hw->clip (dst, src, samples_to_clip);
+
+        pos = (pos + samples_to_clip) % hw->samples;
+        len -= samples_to_clip;
+        clipped += samples_to_clip;
+    }
+}
+
 /*
  * Soft voice (capture)
  */
@@ -1051,6 +1070,31 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
     mixeng_clear(hw->mix_buf, samples - n);
 }
 
+static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
+{
+    size_t clipped = 0;
+
+    while (live) {
+        size_t size, decr, proc;
+        void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
+
+        decr = MIN(size >> hw->info.shift, live);
+        audio_pcm_hw_clip_out2(hw, buf, decr);
+        proc = hw->pcm_ops->put_buffer_out(hw, buf, decr << hw->info.shift) >>
+            hw->info.shift;
+
+        live -= proc;
+        clipped += proc;
+        hw->rpos = (hw->rpos + proc) % hw->samples;
+
+        if (proc == 0 || proc < decr) {
+            break;
+        }
+    }
+
+    return clipped;
+}
+
 static void audio_run_out (AudioState *s)
 {
     HWVoiceOut *hw = NULL;
@@ -1098,7 +1142,11 @@ static void audio_run_out (AudioState *s)
         }
 
         prev_rpos = hw->rpos;
-        played = hw->pcm_ops->run_out (hw, live);
+        if (hw->pcm_ops->run_out) {
+            played = hw->pcm_ops->run_out(hw, live);
+        } else {
+            played = audio_pcm_hw_run_out(hw, live);
+        }
         replay_audio_out(&played);
         if (audio_bug(__func__, hw->rpos >= hw->samples)) {
             dolog("hw->rpos=%zu hw->samples=%zu played=%zu\n",
@@ -1157,6 +1205,35 @@ static void audio_run_out (AudioState *s)
     }
 }
 
+static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
+{
+    size_t conv = 0;
+
+    while (samples) {
+        size_t proc;
+        size_t size = samples << hw->info.shift;
+        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
+
+        assert((size & hw->info.align) == 0);
+        if (size == 0) {
+            hw->pcm_ops->put_buffer_in(hw, buf, size);
+            break;
+        }
+
+        proc = MIN(size >> hw->info.shift,
+                   hw->samples - hw->wpos);
+
+        hw->conv(hw->conv_buf + hw->wpos, buf, proc);
+        hw->wpos = (hw->wpos + proc) % hw->samples;
+
+        samples -= proc;
+        conv += proc;
+        hw->pcm_ops->put_buffer_in(hw, buf, proc << hw->info.shift);
+    }
+
+    return conv;
+}
+
 static void audio_run_in (AudioState *s)
 {
     HWVoiceIn *hw = NULL;
@@ -1166,7 +1243,12 @@ static void audio_run_in (AudioState *s)
         size_t captured = 0, min;
 
         if (replay_mode != REPLAY_MODE_PLAY) {
-            captured = hw->pcm_ops->run_in(hw);
+            if (hw->pcm_ops->run_in) {
+                captured = hw->pcm_ops->run_in(hw);
+            } else {
+                captured = audio_pcm_hw_run_in(
+                    hw, hw->samples - audio_pcm_hw_get_live_in(hw));
+            }
         }
         replay_audio_in(&captured, hw->conv_buf, &hw->wpos, hw->samples);
 
@@ -1260,12 +1342,137 @@ void audio_run(AudioState *s, const char *msg)
 #endif
 }
 
+void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    ssize_t start;
+
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size = hw->samples << hw->info.shift;
+        hw->buf_emul = g_malloc(calc_size);
+        hw->size_emul = calc_size;
+        hw->pos_emul = hw->pending_emul = 0;
+    }
+
+    while (hw->pending_emul < hw->size_emul) {
+        size_t read_len = MIN(hw->size_emul - hw->pos_emul,
+                              hw->size_emul - hw->pending_emul);
+        size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
+                                        read_len);
+        hw->pending_emul += read;
+        if (read < read_len) {
+            break;
+        }
+    }
+
+    start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+    if (start < 0) {
+        start += hw->size_emul;
+    }
+    assert(start >= 0 && start < hw->size_emul);
+
+    *size = MIN(hw->pending_emul, hw->size_emul - start);
+    return hw->buf_emul + start;
+}
+
+void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    assert(size <= hw->pending_emul);
+    hw->pending_emul -= size;
+}
+
+void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    if (unlikely(!hw->buf_emul)) {
+        size_t calc_size = hw->samples << hw->info.shift;
+
+        hw->buf_emul = g_malloc(calc_size);
+        hw->size_emul = calc_size;
+        hw->pos_emul = hw->pending_emul = 0;
+    }
+
+    *size = MIN(hw->size_emul - hw->pending_emul,
+                hw->size_emul - hw->pos_emul);
+    return hw->buf_emul + hw->pos_emul;
+}
+
+size_t audio_generic_put_buffer_out_nowrite(HWVoiceOut *hw, void *buf,
+                                            size_t size)
+{
+    assert(buf == hw->buf_emul + hw->pos_emul &&
+           size + hw->pending_emul <= hw->size_emul);
+
+    hw->pending_emul += size;
+    hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
+
+    return size;
+}
+
+size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
+{
+    audio_generic_put_buffer_out_nowrite(hw, buf, size);
+
+    while (hw->pending_emul) {
+        size_t write_len, written;
+        ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+        if (start < 0) {
+            start += hw->size_emul;
+        }
+        assert(start >= 0 && start < hw->size_emul);
+
+        write_len = MIN(hw->pending_emul, hw->size_emul - start);
+
+        written = hw->pcm_ops->write(hw, hw->buf_emul + start, write_len);
+        hw->pending_emul -= written;
+
+        if (written < write_len) {
+            break;
+        }
+    }
+
+    /*
+     * fake we have written everything. non-written data remain in pending_emul,
+     * so we do not have to clip them multiple times
+     */
+    return size;
+}
+
+size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
+    copy_size = MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    return hw->pcm_ops->put_buffer_out(hw, buf, copy_size);
+}
+
+size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
+{
+    size_t dst_size, copy_size;
+    void *dst = hw->pcm_ops->get_buffer_in(hw, &dst_size);
+    copy_size = MIN(size, dst_size);
+
+    memcpy(dst, buf, copy_size);
+    hw->pcm_ops->put_buffer_in(hw, buf, copy_size);
+    return copy_size;
+}
+
+
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              Audiodev *dev)
 {
     s->drv_opaque = drv->init(dev);
 
     if (s->drv_opaque) {
+        if (!drv->pcm_ops->get_buffer_in) {
+            drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
+            drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
+        }
+        if (!drv->pcm_ops->get_buffer_out) {
+            drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
+            drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
+        }
+
         audio_init_nb_voices_out(s, drv);
         audio_init_nb_voices_in(s, drv);
         s->drv = drv;
-- 
2.20.1
