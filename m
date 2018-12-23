Received: from eggs.gnu.org ([208.118.235.92]:52130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjp-0007SE-Vs
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjo-0001tg-E3
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjo-0001n7-7P
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id j2so10134010wrw.1
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:38 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:44 +0100
Message-Id: <017477fdfa5850f2fe1ebfd99fc6e2cca58ce004.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/52] coreaudio: port to -audiodev config
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
 audio/audio_legacy.c | 10 ++++++++++
 audio/coreaudio.c    | 47 ++++++++++----------------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index f91ce0c3e2..42b55035e3 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -63,6 +63,14 @@ SimpleEnvMap alsa_map[] = {
     { /* End of list */ }
 };
 
+SimpleEnvMap coreaudio_map[] = {
+    { "QEMU_COREAUDIO_BUFFER_SIZE", "buffer-len",
+      ENV_TRANSFORM_FRAMES_TO_USECS_OUT },
+    { "QEMU_COREAUDIO_BUFFER_COUNT", "buffer-count" },
+
+    { /* End of list */ }
+};
+
 static unsigned long long toull(const char *str)
 {
     unsigned long long ret;
@@ -233,6 +241,8 @@ static void legacy_opt(const char *drv)
     if (strcmp(drv, "alsa") == 0) {
         handle_env_opts(opts, alsa_map);
         handle_alsa(opts);
+    } else if (strcmp(drv, "coreaudio") == 0) {
+        handle_env_opts(opts, coreaudio_map);
     }
 }
 
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 7d4225dbee..e00b8847d7 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -36,11 +36,6 @@
 #define MAC_OS_X_VERSION_10_6 1060
 #endif
 
-typedef struct {
-    int buffer_frames;
-    int nbuffers;
-} CoreaudioConf;
-
 typedef struct coreaudioVoiceOut {
     HWVoiceOut hw;
     pthread_mutex_t mutex;
@@ -507,7 +502,9 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
     int err;
     const char *typ = "playback";
     AudioValueRange frameRange;
-    CoreaudioConf *conf = drv_opaque;
+    Audiodev *dev = drv_opaque;
+    AudiodevPerDirectionOptions *pdo = dev->out;
+    int frames;
 
     /* create mutex */
     err = pthread_mutex_init(&core->mutex, NULL);
@@ -538,16 +535,17 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
-    if (frameRange.mMinimum > conf->buffer_frames) {
+    frames = audio_buffer_frames(pdo, as, 11610);
+    if (frameRange.mMinimum > frames) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
     }
-    else if (frameRange.mMaximum < conf->buffer_frames) {
+    else if (frameRange.mMaximum < frames) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     }
     else {
-        core->audioDevicePropertyBufferFrameSize = conf->buffer_frames;
+        core->audioDevicePropertyBufferFrameSize = frames;
     }
 
     /* set Buffer Frame Size */
@@ -568,7 +566,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                            "Could not get device buffer frame size\n");
         return -1;
     }
-    hw->samples = conf->nbuffers * core->audioDevicePropertyBufferFrameSize;
+    hw->samples = (pdo->has_buffer_count ? pdo->buffer_count : 4) *
+        core->audioDevicePropertyBufferFrameSize;
 
     /* get StreamFormat */
     status = coreaudio_get_streamformat(core->outputDeviceID,
@@ -680,40 +679,15 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static CoreaudioConf glob_conf = {
-    .buffer_frames = 512,
-    .nbuffers = 4,
-};
-
 static void *coreaudio_audio_init(Audiodev *dev)
 {
-    CoreaudioConf *conf = g_malloc(sizeof(CoreaudioConf));
-    *conf = glob_conf;
-
-    return conf;
+    return dev;
 }
 
 static void coreaudio_audio_fini (void *opaque)
 {
-    g_free(opaque);
 }
 
-static struct audio_option coreaudio_options[] = {
-    {
-        .name  = "BUFFER_SIZE",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.buffer_frames,
-        .descr = "Size of the buffer in frames"
-    },
-    {
-        .name  = "BUFFER_COUNT",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.nbuffers,
-        .descr = "Number of buffers"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops coreaudio_pcm_ops = {
     .init_out = coreaudio_init_out,
     .fini_out = coreaudio_fini_out,
@@ -725,7 +699,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
 static struct audio_driver coreaudio_audio_driver = {
     .name           = "coreaudio",
     .descr          = "CoreAudio http://developer.apple.com/audio/coreaudio.html",
-    .options        = coreaudio_options,
     .init           = coreaudio_audio_init,
     .fini           = coreaudio_audio_fini,
     .pcm_ops        = &coreaudio_pcm_ops,
-- 
2.20.1
