Received: from eggs.gnu.org ([209.51.188.92]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul7-0004OF-Cw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjul4-0003Re-FV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjul4-0003BD-0h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:38:06 -0500
Received: by mail-wr1-x441.google.com with SMTP id c14so9004973wrr.0
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:56 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:37:06 +0100
Message-Id: <0a16695365c4b7694b47ca5d7c6c286c560bbd44.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 33/50] sdlaudio: port to the new audio
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

SDL2 is still a big mess, but it's probably not worse than the current
version.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/sdlaudio.c | 136 +++++++++++++++++------------------------------
 1 file changed, 50 insertions(+), 86 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index ff19484430..685cbc83b8 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -42,11 +42,6 @@
 
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
-    size_t live;
-#if USE_SEMAPHORE
-    size_t rpos;
-#endif
-    size_t decr;
 } SDLVoiceOut;
 
 static struct SDLAudioState {
@@ -252,17 +247,13 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
     SDLVoiceOut *sdl = opaque;
     SDLAudioState *s = &glob_sdl;
     HWVoiceOut *hw = &sdl->hw;
-    size_t samples = len >> hw->info.shift;
 
     if (s->exit) {
         return;
     }
 
-    while (samples) {
-        size_t to_mix, decr;
-
-        /* dolog ("in callback samples=%d\n", samples); */
 #if USE_SEMAPHORE
+    while (len) {
         sdl_wait (s, "sdl_callback");
         if (s->exit) {
             return;
@@ -271,95 +262,66 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         if (sdl_lock (s, "sdl_callback")) {
             return;
         }
-
-        if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples)) {
-            dolog("sdl->live=%d hw->samples=%zu\n", sdl->live, hw->samples);
-            return;
-        }
-
-        if (!sdl->live) {
-            goto again;
-        }
-#else
-        if (s->exit || !sdl->live) {
-            break;
-        }
 #endif
 
-        /* dolog ("in callback live=%d\n", live); */
-        to_mix = MIN (samples, sdl->live);
-        decr = to_mix;
-        while (to_mix) {
-            size_t chunk = MIN(to_mix, hw->samples - hw->rpos);
-            struct st_sample *src = hw->mix_buf + hw->rpos;
+        while (hw->pending_emul && len) {
+            size_t write_len;
+            ssize_t start = ((ssize_t) hw->pos_emul) - hw->pending_emul;
+            if (start < 0) {
+                start += hw->size_emul;
+            }
+            assert(start >= 0 && start < hw->size_emul);
 
-            /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
-            hw->clip (buf, src, chunk);
-#if USE_SEMAPHORE
-            sdl->rpos = (sdl->rpos + chunk) % hw->samples;
-#else
-            hw->rpos = (hw->rpos + chunk) % hw->samples;
-#endif
-            to_mix -= chunk;
-            buf += chunk << hw->info.shift;
+            write_len = MIN(MIN(hw->pending_emul, len),
+                            hw->size_emul - start);
+
+            memcpy(buf, hw->buf_emul + start, write_len);
+            hw->pending_emul -= write_len;
+            len -= write_len;
+            buf += write_len;
         }
-        samples -= decr;
-        sdl->live -= decr;
-        sdl->decr += decr;
 
 #if USE_SEMAPHORE
-    again:
         if (sdl_unlock (s, "sdl_callback")) {
             return;
         }
-#endif
     }
-    /* dolog ("done len=%d\n", len); */
-
-#if (SDL_MAJOR_VERSION >= 2)
-    /* SDL2 does not clear the remaining buffer for us, so do it on our own */
-    if (samples) {
-        memset(buf, 0, samples << hw->info.shift);
-    }
-#endif
-}
-
-static size_t sdl_run_out(HWVoiceOut *hw, size_t live)
-{
-    size_t decr;
-    SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
-    SDLAudioState *s = &glob_sdl;
-
-    if (sdl_lock (s, "sdl_run_out")) {
-        return 0;
-    }
-
-    if (sdl->decr > live) {
-        ldebug ("sdl->decr %d live %d sdl->live %d\n",
-                sdl->decr,
-                live,
-                sdl->live);
-    }
-
-    decr = MIN (sdl->decr, live);
-    sdl->decr -= decr;
-
-#if USE_SEMAPHORE
-    sdl->live = live - decr;
-    hw->rpos = sdl->rpos;
 #else
-    sdl->live = live;
+    /* clear remaining buffer that we couldn't fill with data */
+    if (len) {
+        memset(buf, 0, len);
+    }
 #endif
-
-    if (sdl->live > 0) {
-        sdl_unlock_and_post (s, "sdl_run_out");
-    }
-    else {
-        sdl_unlock (s, "sdl_run_out");
-    }
-    return decr;
 }
 
+#define SDL_WRAPPER_FUNC(name, ret_type, args_decl, args, fail, unlock) \
+    static ret_type glue(sdl_, name)args_decl                           \
+    {                                                                   \
+        SDLAudioState *s = &glob_sdl;                                   \
+        ret_type ret;                                                   \
+                                                                        \
+        if (sdl_lock(s, "sdl_" #name)) {                                \
+            fail;                                                       \
+            return 0; /* implicitly casts to NULL */                    \
+        }                                                               \
+                                                                        \
+        ret = glue(audio_generic_, name)args;                           \
+                                                                        \
+        unlock(s, "sdl_" #name);                                        \
+        return ret;                                                     \
+    }
+
+SDL_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *size),
+                 (hw, size), *size = 0, sdl_unlock)
+SDL_WRAPPER_FUNC(put_buffer_out_nowrite, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 /*nothing*/, sdl_unlock_and_post)
+SDL_WRAPPER_FUNC(write, size_t,
+                 (HWVoiceOut *hw, void *buf, size_t size), (hw, buf, size),
+                 /* nothing */, sdl_unlock_and_post)
+
+#undef SDL_WRAPPER_FUNC
+
 static void sdl_fini_out (HWVoiceOut *hw)
 {
     (void) hw;
@@ -476,7 +438,9 @@ static void sdl_audio_fini (void *opaque)
 static struct audio_pcm_ops sdl_pcm_ops = {
     .init_out = sdl_init_out,
     .fini_out = sdl_fini_out,
-    .run_out  = sdl_run_out,
+    .write    = sdl_write,
+    .get_buffer_out = sdl_get_buffer_out,
+    .put_buffer_out = sdl_put_buffer_out_nowrite,
     .ctl_out  = sdl_ctl_out,
 };
 
-- 
2.20.1
