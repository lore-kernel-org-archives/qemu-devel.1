Received: from eggs.gnu.org ([209.51.188.92]:42714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqrEM-0007a6-PF
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqr6F-0002bL-Bm
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 22:08:43 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Feb 2019 04:08:20 +0100
Message-Id: <1549336101-17623-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1549336101-17623-1-git-send-email-thuth@redhat.com>
References: <1549336101-17623-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] audio/sdlaudio: Remove the semaphore code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=20Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>

The semaphore code was only working with SDL1.2 - with SDL2, it causes
a deadlock. Since we've removed support for SDL1.2 recently, we can
now completely remove the semaphore code from sdlaudio.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/sdlaudio.c | 145 ++-----------------------------------------------------
 1 file changed, 5 insertions(+), 140 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 9db5ac9..53bfdbf 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -38,14 +38,9 @@
 #define AUDIO_CAP "sdl"
 #include "audio_int.h"
 
-#define USE_SEMAPHORE (SDL_MAJOR_VERSION < 2)
-
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
     int live;
-#if USE_SEMAPHORE
-    int rpos;
-#endif
     int decr;
 } SDLVoiceOut;
 
@@ -57,10 +52,6 @@ static struct {
 
 static struct SDLAudioState {
     int exit;
-#if USE_SEMAPHORE
-    SDL_mutex *mutex;
-    SDL_sem *sem;
-#endif
     int initialized;
     bool driver_created;
 } glob_sdl;
@@ -77,66 +68,6 @@ static void GCC_FMT_ATTR (1, 2) sdl_logerr (const char *fmt, ...)
     AUD_log (AUDIO_CAP, "Reason: %s\n", SDL_GetError ());
 }
 
-static int sdl_lock (SDLAudioState *s, const char *forfn)
-{
-#if USE_SEMAPHORE
-    if (SDL_LockMutex (s->mutex)) {
-        sdl_logerr ("SDL_LockMutex for %s failed\n", forfn);
-        return -1;
-    }
-#else
-    SDL_LockAudio();
-#endif
-
-    return 0;
-}
-
-static int sdl_unlock (SDLAudioState *s, const char *forfn)
-{
-#if USE_SEMAPHORE
-    if (SDL_UnlockMutex (s->mutex)) {
-        sdl_logerr ("SDL_UnlockMutex for %s failed\n", forfn);
-        return -1;
-    }
-#else
-    SDL_UnlockAudio();
-#endif
-
-    return 0;
-}
-
-static int sdl_post (SDLAudioState *s, const char *forfn)
-{
-#if USE_SEMAPHORE
-    if (SDL_SemPost (s->sem)) {
-        sdl_logerr ("SDL_SemPost for %s failed\n", forfn);
-        return -1;
-    }
-#endif
-
-    return 0;
-}
-
-#if USE_SEMAPHORE
-static int sdl_wait (SDLAudioState *s, const char *forfn)
-{
-    if (SDL_SemWait (s->sem)) {
-        sdl_logerr ("SDL_SemWait for %s failed\n", forfn);
-        return -1;
-    }
-    return 0;
-}
-#endif
-
-static int sdl_unlock_and_post (SDLAudioState *s, const char *forfn)
-{
-    if (sdl_unlock (s, forfn)) {
-        return -1;
-    }
-
-    return sdl_post (s, forfn);
-}
-
 static int aud_to_sdlfmt (audfmt_e fmt)
 {
     switch (fmt) {
@@ -243,9 +174,9 @@ static int sdl_open (SDL_AudioSpec *req, SDL_AudioSpec *obt)
 static void sdl_close (SDLAudioState *s)
 {
     if (s->initialized) {
-        sdl_lock (s, "sdl_close");
+        SDL_LockAudio();
         s->exit = 1;
-        sdl_unlock_and_post (s, "sdl_close");
+        SDL_UnlockAudio();
         SDL_PauseAudio (1);
         SDL_CloseAudio ();
         s->initialized = 0;
@@ -267,30 +198,10 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         int to_mix, decr;
 
         /* dolog ("in callback samples=%d\n", samples); */
-#if USE_SEMAPHORE
-        sdl_wait (s, "sdl_callback");
-        if (s->exit) {
-            return;
-        }
-
-        if (sdl_lock (s, "sdl_callback")) {
-            return;
-        }
-
-        if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples)) {
-            dolog ("sdl->live=%d hw->samples=%d\n",
-                   sdl->live, hw->samples);
-            return;
-        }
 
-        if (!sdl->live) {
-            goto again;
-        }
-#else
         if (s->exit || !sdl->live) {
             break;
         }
-#endif
 
         /* dolog ("in callback live=%d\n", live); */
         to_mix = audio_MIN (samples, sdl->live);
@@ -301,33 +212,20 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 
             /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
             hw->clip (buf, src, chunk);
-#if USE_SEMAPHORE
-            sdl->rpos = (sdl->rpos + chunk) % hw->samples;
-#else
             hw->rpos = (hw->rpos + chunk) % hw->samples;
-#endif
             to_mix -= chunk;
             buf += chunk << hw->info.shift;
         }
         samples -= decr;
         sdl->live -= decr;
         sdl->decr += decr;
-
-#if USE_SEMAPHORE
-    again:
-        if (sdl_unlock (s, "sdl_callback")) {
-            return;
-        }
-#endif
     }
     /* dolog ("done len=%d\n", len); */
 
-#if (SDL_MAJOR_VERSION >= 2)
     /* SDL2 does not clear the remaining buffer for us, so do it on our own */
     if (samples) {
         memset(buf, 0, samples << hw->info.shift);
     }
-#endif
 }
 
 static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
@@ -339,11 +237,8 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
 {
     int decr;
     SDLVoiceOut *sdl = (SDLVoiceOut *) hw;
-    SDLAudioState *s = &glob_sdl;
 
-    if (sdl_lock (s, "sdl_run_out")) {
-        return 0;
-    }
+    SDL_LockAudio();
 
     if (sdl->decr > live) {
         ldebug ("sdl->decr %d live %d sdl->live %d\n",
@@ -355,19 +250,10 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
     decr = audio_MIN (sdl->decr, live);
     sdl->decr -= decr;
 
-#if USE_SEMAPHORE
-    sdl->live = live - decr;
-    hw->rpos = sdl->rpos;
-#else
     sdl->live = live;
-#endif
 
-    if (sdl->live > 0) {
-        sdl_unlock_and_post (s, "sdl_run_out");
-    }
-    else {
-        sdl_unlock (s, "sdl_run_out");
-    }
+    SDL_UnlockAudio();
+
     return decr;
 }
 
@@ -449,23 +335,6 @@ static void *sdl_audio_init (void)
         return NULL;
     }
 
-#if USE_SEMAPHORE
-    s->mutex = SDL_CreateMutex ();
-    if (!s->mutex) {
-        sdl_logerr ("Failed to create SDL mutex\n");
-        SDL_QuitSubSystem (SDL_INIT_AUDIO);
-        return NULL;
-    }
-
-    s->sem = SDL_CreateSemaphore (0);
-    if (!s->sem) {
-        sdl_logerr ("Failed to create SDL semaphore\n");
-        SDL_DestroyMutex (s->mutex);
-        SDL_QuitSubSystem (SDL_INIT_AUDIO);
-        return NULL;
-    }
-#endif
-
     s->driver_created = true;
     return s;
 }
@@ -474,10 +343,6 @@ static void sdl_audio_fini (void *opaque)
 {
     SDLAudioState *s = opaque;
     sdl_close (s);
-#if USE_SEMAPHORE
-    SDL_DestroySemaphore (s->sem);
-    SDL_DestroyMutex (s->mutex);
-#endif
     SDL_QuitSubSystem (SDL_INIT_AUDIO);
     s->driver_created = false;
 }
-- 
1.8.3.1
