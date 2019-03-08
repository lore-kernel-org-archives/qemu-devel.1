Received: from eggs.gnu.org ([209.51.188.92]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4h-0007lV-L5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4f-0002gB-O6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h2O4d-0002eb-Qq
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id g12so22947698wrm.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 14:34:38 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Fri,  8 Mar 2019 23:34:22 +0100
Message-Id: <1dc596cba39378df862582a0b952e497a16c6c31.1552083282.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 11/14] sdlaudio: port to -audiodev config
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
index 8d7f1475b5..478cf76d5f 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -281,6 +281,14 @@ static void handle_pa(Audiodev *dev)
     get_str("QEMU_PA_SERVER", &dev->u.pa.server, &dev->u.pa.has_server);
 }
 
+/* SDL */
+static void handle_sdl(Audiodev *dev)
+{
+    /* SDL is output only */
+    get_samples_to_usecs("QEMU_SDL_SAMPLES", &dev->u.sdl.out->buffer_length,
+                         &dev->u.sdl.out->has_buffer_length, dev->u.sdl.out);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -342,6 +350,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
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
index b9ae506a56..ff9248ba68 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -44,16 +44,11 @@ typedef struct SDLVoiceOut {
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
     int initialized;
     bool driver_created;
+    Audiodev *dev;
 } glob_sdl;
 typedef struct SDLAudioState SDLAudioState;
 
@@ -271,7 +266,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
     req.freq = as->freq;
     req.format = aud_to_sdlfmt (as->fmt);
     req.channels = as->nchannels;
-    req.samples = conf.nb_samples;
+    req.samples = audio_buffer_samples(s->dev->u.sdl.out, as, 11610);
     req.callback = sdl_callback;
     req.userdata = sdl;
 
@@ -329,6 +324,7 @@ static void *sdl_audio_init(Audiodev *dev)
     }
 
     s->driver_created = true;
+    s->dev = dev;
     return s;
 }
 
@@ -338,18 +334,9 @@ static void sdl_audio_fini (void *opaque)
     sdl_close (s);
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
@@ -361,7 +348,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
 static struct audio_driver sdl_audio_driver = {
     .name           = "sdl",
     .descr          = "SDL http://www.libsdl.org",
-    .options        = sdl_options,
     .init           = sdl_audio_init,
     .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
-- 
2.20.1
