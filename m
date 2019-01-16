Received: from eggs.gnu.org ([209.51.188.92]:57998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuks-00046w-4h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukk-0002v9-5o
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:52 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukj-0002ik-Qy
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id q18so8927777wrx.9
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:36 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:44 +0100
Message-Id: <a3874aba823fb0bce622a3e1323d29aed7e57452.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 11/50] sdlaudio: port to -audiodev config
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
 audio/audio_legacy.c | 12 ++++++++++++
 audio/sdlaudio.c     | 22 ++++------------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index d173ff042e..aa6c789096 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -285,6 +285,14 @@ static void handle_pa(Audiodev *dev)
     get_str("QEMU_PA_SERVER", &dev->u.pa.server, &dev->u.pa.has_server);
 }
 
+/* SDL */
+static void handle_sdl(Audiodev *dev)
+{
+    /* SDL is output only */
+    get_samples_to_usecs("QEMU_SDL_SAMPLES", &dev->out->buffer_len,
+                         &dev->out->has_buffer_len, dev->out);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -348,6 +356,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
         handle_pa(e->dev);
         break;
 
+    case AUDIODEV_DRIVER_SDL:
+        handle_sdl(e->dev);
+        break;
+
     default:
         break;
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
