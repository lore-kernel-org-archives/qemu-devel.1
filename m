Received: from eggs.gnu.org ([208.118.235.92]:52183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjs-0007XS-8q
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjr-000233-2K
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:44 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjq-00020G-PL
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:42 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so10090931wrt.4
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:42 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:49 +0100
Message-Id: <f67f17a62407ca5e6616ce1a4c66dcec9dbbd845.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 13/52] sdlaudio: port to -audiodev config
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
 audio/audio_legacy.c |  7 +++++++
 audio/sdlaudio.c     | 22 ++++------------------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 1f99d21803..6d95b761b8 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -105,6 +105,11 @@ SimpleEnvMap pa_map[] = {
     { /* End of list */ }
 };
 
+SimpleEnvMap sdl_map[] = {
+    { "QEMU_SDL_SAMPLES", "buffer-len", ENV_TRANSFORM_SAMPLES_TO_USECS_OUT },
+    { /* End of list */ }
+};
+
 static unsigned long long toull(const char *str)
 {
     unsigned long long ret;
@@ -283,6 +288,8 @@ static void legacy_opt(const char *drv)
         handle_env_opts(opts, oss_map);
     } else if (strcmp(drv, "pa") == 0) {
         handle_env_opts(opts, pa_map);
+    } else if (strcmp(drv, "sdl") == 0) {
+        handle_env_opts(opts, sdl_map);
     }
 }
 
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 097841fde1..cf6ac19927 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -49,12 +49,6 @@ typedef struct SDLVoiceOut {
     int decr;
 } SDLVoiceOut;
 
-static struct {
-    int nb_samples;
-} conf = {
-    .nb_samples = 1024
-};
-
 static struct SDLAudioState {
     int exit;
 #if USE_SEMAPHORE
@@ -63,6 +57,7 @@ static struct SDLAudioState {
 #endif
     int initialized;
     bool driver_created;
+    Audiodev *dev;
 } glob_sdl;
 typedef struct SDLAudioState SDLAudioState;
 
@@ -392,7 +387,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     req.freq = as->freq;
     req.format = aud_to_sdlfmt (as->fmt);
     req.channels = as->nchannels;
-    req.samples = conf.nb_samples;
+    req.samples = audio_buffer_samples(s->dev->out, as, 11610);
     req.callback = sdl_callback;
     req.userdata = sdl;
 
@@ -467,6 +462,7 @@ static void *sdl_audio_init(Audiodev *dev)
 #endif
 
     s->driver_created = true;
+    s->dev = dev;
     return s;
 }
 
@@ -480,18 +476,9 @@ static void sdl_audio_fini (void *opaque)
 #endif
     SDL_QuitSubSystem (SDL_INIT_AUDIO);
     s->driver_created = false;
+    s->dev = NULL;
 }
 
-static struct audio_option sdl_options[] = {
-    {
-        .name  = "SAMPLES",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.nb_samples,
-        .descr = "Size of SDL buffer in samples"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops sdl_pcm_ops = {
     .init_out = sdl_init_out,
     .fini_out = sdl_fini_out,
@@ -503,7 +490,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
 static struct audio_driver sdl_audio_driver = {
     .name           = "sdl",
     .descr          = "SDL http://www.libsdl.org",
-    .options        = sdl_options,
     .init           = sdl_audio_init,
     .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
-- 
2.20.1
