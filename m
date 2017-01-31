Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYU5N-0004Bk-MD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYU5K-0000hN-KD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:46:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cYU5K-0000hH-Bt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 03:46:42 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D3BC7E9F3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:46:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 31 Jan 2017 09:46:38 +0100
Message-Id: <1485852398-2327-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH] audio/sdlaudio: Allow audio playback with
 SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

When compiling with SDL2, the semaphore trick used in sdlaudio.c
does not work - QEMU locks up completely in this case. To avoid
the hang and get at least some audio playback up and running (it's
a little bit crackling, but better than nothing), we can use the
SDL locking functions SDL_LockAudio() and SDL_UnlockAudio() to sync
with the sound playback thread instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 audio/sdlaudio.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index db69fe1..e8d91d2 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -38,10 +38,14 @@
 #define AUDIO_CAP "sdl"
 #include "audio_int.h"
 
+#define USE_SEMAPHORE (SDL_MAJOR_VERSION < 2)
+
 typedef struct SDLVoiceOut {
     HWVoiceOut hw;
     int live;
+#if USE_SEMAPHORE
     int rpos;
+#endif
     int decr;
 } SDLVoiceOut;
 
@@ -53,8 +57,10 @@ static struct {
 
 static struct SDLAudioState {
     int exit;
+#if USE_SEMAPHORE
     SDL_mutex *mutex;
     SDL_sem *sem;
+#endif
     int initialized;
     bool driver_created;
 } glob_sdl;
@@ -73,31 +79,45 @@ static void GCC_FMT_ATTR (1, 2) sdl_logerr (const char *fmt, ...)
 
 static int sdl_lock (SDLAudioState *s, const char *forfn)
 {
+#if USE_SEMAPHORE
     if (SDL_LockMutex (s->mutex)) {
         sdl_logerr ("SDL_LockMutex for %s failed\n", forfn);
         return -1;
     }
+#else
+    SDL_LockAudio();
+#endif
+
     return 0;
 }
 
 static int sdl_unlock (SDLAudioState *s, const char *forfn)
 {
+#if USE_SEMAPHORE
     if (SDL_UnlockMutex (s->mutex)) {
         sdl_logerr ("SDL_UnlockMutex for %s failed\n", forfn);
         return -1;
     }
+#else
+    SDL_UnlockAudio();
+#endif
+
     return 0;
 }
 
 static int sdl_post (SDLAudioState *s, const char *forfn)
 {
+#if USE_SEMAPHORE
     if (SDL_SemPost (s->sem)) {
         sdl_logerr ("SDL_SemPost for %s failed\n", forfn);
         return -1;
     }
+#endif
+
     return 0;
 }
 
+#if USE_SEMAPHORE
 static int sdl_wait (SDLAudioState *s, const char *forfn)
 {
     if (SDL_SemWait (s->sem)) {
@@ -106,6 +126,7 @@ static int sdl_wait (SDLAudioState *s, const char *forfn)
     }
     return 0;
 }
+#endif
 
 static int sdl_unlock_and_post (SDLAudioState *s, const char *forfn)
 {
@@ -246,6 +267,7 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         int to_mix, decr;
 
         /* dolog ("in callback samples=%d\n", samples); */
+#if USE_SEMAPHORE
         sdl_wait (s, "sdl_callback");
         if (s->exit) {
             return;
@@ -264,6 +286,11 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         if (!sdl->live) {
             goto again;
         }
+#else
+        if (s->exit || !sdl->live) {
+            break;
+        }
+#endif
 
         /* dolog ("in callback live=%d\n", live); */
         to_mix = audio_MIN (samples, sdl->live);
@@ -274,7 +301,11 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
 
             /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk); */
             hw->clip (buf, src, chunk);
+#if USE_SEMAPHORE
             sdl->rpos = (sdl->rpos + chunk) % hw->samples;
+#else
+            hw->rpos = (hw->rpos + chunk) % hw->samples;
+#endif
             to_mix -= chunk;
             buf += chunk << hw->info.shift;
         }
@@ -282,12 +313,21 @@ static void sdl_callback (void *opaque, Uint8 *buf, int len)
         sdl->live -= decr;
         sdl->decr += decr;
 
+#if USE_SEMAPHORE
     again:
         if (sdl_unlock (s, "sdl_callback")) {
             return;
         }
+#endif
     }
     /* dolog ("done len=%d\n", len); */
+
+#if (SDL_MAJOR_VERSION >= 2)
+    /* SDL2 does not clear the remaining buffer for us, so do it on our own */
+    if (samples) {
+        memset(buf, 0, samples << hw->info.shift);
+    }
+#endif
 }
 
 static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
@@ -315,8 +355,12 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
     decr = audio_MIN (sdl->decr, live);
     sdl->decr -= decr;
 
+#if USE_SEMAPHORE
     sdl->live = live - decr;
     hw->rpos = sdl->rpos;
+#else
+    sdl->live = live;
+#endif
 
     if (sdl->live > 0) {
         sdl_unlock_and_post (s, "sdl_run_out");
@@ -405,6 +449,7 @@ static void *sdl_audio_init (void)
         return NULL;
     }
 
+#if USE_SEMAPHORE
     s->mutex = SDL_CreateMutex ();
     if (!s->mutex) {
         sdl_logerr ("Failed to create SDL mutex\n");
@@ -419,6 +464,7 @@ static void *sdl_audio_init (void)
         SDL_QuitSubSystem (SDL_INIT_AUDIO);
         return NULL;
     }
+#endif
 
     s->driver_created = true;
     return s;
@@ -428,8 +474,10 @@ static void sdl_audio_fini (void *opaque)
 {
     SDLAudioState *s = opaque;
     sdl_close (s);
+#if USE_SEMAPHORE
     SDL_DestroySemaphore (s->sem);
     SDL_DestroyMutex (s->mutex);
+#endif
     SDL_QuitSubSystem (SDL_INIT_AUDIO);
     s->driver_created = false;
 }
-- 
1.8.3.1
