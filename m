Received: from eggs.gnu.org ([209.51.188.92]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIco-00031n-N3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcm-0000xU-Pk
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIck-0000qX-QB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F06B43144D98
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:57 +0100
Message-Id: <20190228100858.28397-5-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
References: <20190228100858.28397-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] audio/sdlaudio: Remove the semaphore code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The semaphore code was only working with SDL1.2 - with SDL2, it causes
a deadlock. Since we've removed support for SDL1.2 recently, we can
now completely remove the semaphore code from sdlaudio.c.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 1549336101-17623-2-git-send-email-thuth@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/sdlaudio.c | 145 ++-----------------------------------------------=
------
 1 file changed, 5 insertions(+), 140 deletions(-)

diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 9db5ac92bcc0..53bfdbf72439 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -38,14 +38,9 @@
 #define AUDIO_CAP "sdl"
 #include "audio_int.h"
=20
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
=20
@@ -57,10 +52,6 @@ static struct {
=20
 static struct SDLAudioState {
     int exit;
-#if USE_SEMAPHORE
-    SDL_mutex *mutex;
-    SDL_sem *sem;
-#endif
     int initialized;
     bool driver_created;
 } glob_sdl;
@@ -77,66 +68,6 @@ static void GCC_FMT_ATTR (1, 2) sdl_logerr (const char=
 *fmt, ...)
     AUD_log (AUDIO_CAP, "Reason: %s\n", SDL_GetError ());
 }
=20
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
@@ -243,9 +174,9 @@ static int sdl_open (SDL_AudioSpec *req, SDL_AudioSpe=
c *obt)
 static void sdl_close (SDLAudioState *s)
 {
     if (s->initialized) {
-        sdl_lock (s, "sdl_close");
+        SDL_LockAudio();
         s->exit =3D 1;
-        sdl_unlock_and_post (s, "sdl_close");
+        SDL_UnlockAudio();
         SDL_PauseAudio (1);
         SDL_CloseAudio ();
         s->initialized =3D 0;
@@ -267,30 +198,10 @@ static void sdl_callback (void *opaque, Uint8 *buf,=
 int len)
         int to_mix, decr;
=20
         /* dolog ("in callback samples=3D%d\n", samples); */
-#if USE_SEMAPHORE
-        sdl_wait (s, "sdl_callback");
-        if (s->exit) {
-            return;
-        }
=20
-        if (sdl_lock (s, "sdl_callback")) {
-            return;
-        }
-
-        if (audio_bug(__func__, sdl->live < 0 || sdl->live > hw->samples=
)) {
-            dolog ("sdl->live=3D%d hw->samples=3D%d\n",
-                   sdl->live, hw->samples);
-            return;
-        }
-
-        if (!sdl->live) {
-            goto again;
-        }
-#else
         if (s->exit || !sdl->live) {
             break;
         }
-#endif
=20
         /* dolog ("in callback live=3D%d\n", live); */
         to_mix =3D audio_MIN (samples, sdl->live);
@@ -301,33 +212,20 @@ static void sdl_callback (void *opaque, Uint8 *buf,=
 int len)
=20
             /* dolog ("in callback to_mix %d, chunk %d\n", to_mix, chunk=
); */
             hw->clip (buf, src, chunk);
-#if USE_SEMAPHORE
-            sdl->rpos =3D (sdl->rpos + chunk) % hw->samples;
-#else
             hw->rpos =3D (hw->rpos + chunk) % hw->samples;
-#endif
             to_mix -=3D chunk;
             buf +=3D chunk << hw->info.shift;
         }
         samples -=3D decr;
         sdl->live -=3D decr;
         sdl->decr +=3D decr;
-
-#if USE_SEMAPHORE
-    again:
-        if (sdl_unlock (s, "sdl_callback")) {
-            return;
-        }
-#endif
     }
     /* dolog ("done len=3D%d\n", len); */
=20
-#if (SDL_MAJOR_VERSION >=3D 2)
     /* SDL2 does not clear the remaining buffer for us, so do it on our =
own */
     if (samples) {
         memset(buf, 0, samples << hw->info.shift);
     }
-#endif
 }
=20
 static int sdl_write_out (SWVoiceOut *sw, void *buf, int len)
@@ -339,11 +237,8 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
 {
     int decr;
     SDLVoiceOut *sdl =3D (SDLVoiceOut *) hw;
-    SDLAudioState *s =3D &glob_sdl;
=20
-    if (sdl_lock (s, "sdl_run_out")) {
-        return 0;
-    }
+    SDL_LockAudio();
=20
     if (sdl->decr > live) {
         ldebug ("sdl->decr %d live %d sdl->live %d\n",
@@ -355,19 +250,10 @@ static int sdl_run_out (HWVoiceOut *hw, int live)
     decr =3D audio_MIN (sdl->decr, live);
     sdl->decr -=3D decr;
=20
-#if USE_SEMAPHORE
-    sdl->live =3D live - decr;
-    hw->rpos =3D sdl->rpos;
-#else
     sdl->live =3D live;
-#endif
=20
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
=20
@@ -449,23 +335,6 @@ static void *sdl_audio_init (void)
         return NULL;
     }
=20
-#if USE_SEMAPHORE
-    s->mutex =3D SDL_CreateMutex ();
-    if (!s->mutex) {
-        sdl_logerr ("Failed to create SDL mutex\n");
-        SDL_QuitSubSystem (SDL_INIT_AUDIO);
-        return NULL;
-    }
-
-    s->sem =3D SDL_CreateSemaphore (0);
-    if (!s->sem) {
-        sdl_logerr ("Failed to create SDL semaphore\n");
-        SDL_DestroyMutex (s->mutex);
-        SDL_QuitSubSystem (SDL_INIT_AUDIO);
-        return NULL;
-    }
-#endif
-
     s->driver_created =3D true;
     return s;
 }
@@ -474,10 +343,6 @@ static void sdl_audio_fini (void *opaque)
 {
     SDLAudioState *s =3D opaque;
     sdl_close (s);
-#if USE_SEMAPHORE
-    SDL_DestroySemaphore (s->sem);
-    SDL_DestroyMutex (s->mutex);
-#endif
     SDL_QuitSubSystem (SDL_INIT_AUDIO);
     s->driver_created =3D false;
 }
--=20
2.9.3
