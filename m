Received: from eggs.gnu.org ([209.51.188.92]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdA-0007oK-Qa
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd7-0003Pd-1A
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:52 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFd6-0003Ny-Mh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so19893289wrt.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:45 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:29 +0100
Message-Id: <cb9801ff642400b8817cf455b4ce8f0d097b6bd3.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 06/14] coreaudio: port to -audiodev config
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
 audio/audio_legacy.c | 24 ++++++++++++++++++++++
 audio/coreaudio.c    | 48 +++++++++-----------------------------------
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 8319dc5240..301934bf0c 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -109,6 +109,17 @@ static uint32_t frames_to_usecs(uint32_t frames,
     return (frames * 1000000 + freq / 2) / freq;
 }
 
+
+static void get_frames_to_usecs(const char *env, uint32_t *dst, bool *has_dst,
+                                AudiodevPerDirectionOptions *pdo)
+{
+    const char *val = getenv(env);
+    if (val) {
+        *dst = frames_to_usecs(toui32(val), pdo);
+        *has_dst = true;
+    }
+}
+
 /* backend specific functions */
 /* ALSA */
 static void handle_alsa_per_direction(
@@ -166,6 +177,15 @@ static void handle_alsa(Audiodev *dev)
                         &aopt->threshold, &aopt->has_threshold);
 }
 
+/* coreaudio */
+static void handle_coreaudio(Audiodev *dev)
+{
+    get_frames_to_usecs("QEMU_COREAUDIO_BUFFER_SIZE", &dev->out->buffer_len,
+                        &dev->out->has_buffer_len, dev->out);
+    get_int("QEMU_COREAUDIO_BUFFER_COUNT",
+            &dev->out->buffer_count, &dev->out->has_buffer_count);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -213,6 +233,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
         handle_alsa(e->dev);
         break;
 
+    case AUDIODEV_DRIVER_COREAUDIO:
+        handle_coreaudio(e->dev);
+        break;
+
     default:
         break;
     }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 7d4225dbee..a7c1e418b6 100644
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
@@ -538,16 +535,16 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
         return -1;
     }
 
-    if (frameRange.mMinimum > conf->buffer_frames) {
+    frames = audio_buffer_frames(pdo, as, 11610);
+    if (frameRange.mMinimum > frames) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
         dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
-    }
-    else if (frameRange.mMaximum < conf->buffer_frames) {
+    } else if (frameRange.mMaximum < frames) {
         core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
         dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
     }
     else {
-        core->audioDevicePropertyBufferFrameSize = conf->buffer_frames;
+        core->audioDevicePropertyBufferFrameSize = frames;
     }
 
     /* set Buffer Frame Size */
@@ -568,7 +565,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                            "Could not get device buffer frame size\n");
         return -1;
     }
-    hw->samples = conf->nbuffers * core->audioDevicePropertyBufferFrameSize;
+    hw->samples = (pdo->has_buffer_count ? pdo->buffer_count : 4) *
+        core->audioDevicePropertyBufferFrameSize;
 
     /* get StreamFormat */
     status = coreaudio_get_streamformat(core->outputDeviceID,
@@ -680,40 +678,15 @@ static int coreaudio_ctl_out (HWVoiceOut *hw, int cmd, ...)
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
@@ -725,7 +698,6 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
 static struct audio_driver coreaudio_audio_driver = {
     .name           = "coreaudio",
     .descr          = "CoreAudio http://developer.apple.com/audio/coreaudio.html",
-    .options        = coreaudio_options,
     .init           = coreaudio_audio_init,
     .fini           = coreaudio_audio_fini,
     .pcm_ops        = &coreaudio_pcm_ops,
-- 
2.20.1
