Received: from eggs.gnu.org ([209.51.188.92]:47773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdE-0007sv-O7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdA-0003Tt-Jn
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFdA-0003T7-Ax
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:52 -0500
Received: by mail-wr1-x443.google.com with SMTP id f7so20038907wrp.1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:52 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:36 +0100
Message-Id: <07ff0a573156785125eeed6fa88e7e4982f9443a.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 13/14] wavaudio: port to -audiodev config
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
 audio/audio_legacy.c | 15 ++++++++++++
 audio/wavaudio.c     | 58 +++++++-------------------------------------
 2 files changed, 24 insertions(+), 49 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 214774b947..2c2447176c 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -293,6 +293,17 @@ static void handle_sdl(Audiodev *dev)
                          &dev->out->has_buffer_len, dev->out);
 }
 
+/* wav */
+static void handle_wav(Audiodev *dev)
+{
+    get_int("QEMU_WAV_FREQUENCY",
+            &dev->out->frequency, &dev->out->has_frequency);
+    get_fmt("QEMU_WAV_FORMAT", &dev->out->format, &dev->out->has_format);
+    get_int("QEMU_WAV_DAC_FIXED_CHANNELS",
+            &dev->out->channels, &dev->out->has_channels);
+    get_str("QEMU_WAV_PATH", &dev->u.wav.path, &dev->u.wav.has_path);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -360,6 +371,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
         handle_sdl(e->dev);
         break;
 
+    case AUDIODEV_DRIVER_WAV:
+        handle_wav(e->dev);
+        break;
+
     default:
         break;
     }
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 9eff3555b3..214e30ccd9 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/timer.h"
+#include "qapi/opts-visitor.h"
 #include "audio.h"
 
 #define AUDIO_CAP "wav"
@@ -37,11 +38,6 @@ typedef struct WAVVoiceOut {
     int total_samples;
 } WAVVoiceOut;
 
-typedef struct {
-    struct audsettings settings;
-    const char *wav_path;
-} WAVConf;
-
 static int wav_run_out (HWVoiceOut *hw, int live)
 {
     WAVVoiceOut *wav = (WAVVoiceOut *) hw;
@@ -112,8 +108,10 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
         0x02, 0x00, 0x44, 0xac, 0x00, 0x00, 0x10, 0xb1, 0x02, 0x00, 0x04,
         0x00, 0x10, 0x00, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00
     };
-    WAVConf *conf = drv_opaque;
-    struct audsettings wav_as = conf->settings;
+    Audiodev *dev = drv_opaque;
+    AudiodevWavOptions *wopts = &dev->u.wav;
+    struct audsettings wav_as = audiodev_to_audsettings(dev->out);
+    const char *wav_path = wopts->has_path ? wopts->path : "qemu.wav";
 
     stereo = wav_as.nchannels == 2;
     switch (wav_as.fmt) {
@@ -154,10 +152,10 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
     le_store (hdr + 28, hw->info.freq << (bits16 + stereo), 4);
     le_store (hdr + 32, 1 << (bits16 + stereo), 2);
 
-    wav->f = fopen (conf->wav_path, "wb");
+    wav->f = fopen(wav_path, "wb");
     if (!wav->f) {
         dolog ("Failed to open wave file `%s'\nReason: %s\n",
-               conf->wav_path, strerror (errno));
+               wav_path, strerror(errno));
         g_free (wav->pcm_buf);
         wav->pcm_buf = NULL;
         return -1;
@@ -225,54 +223,17 @@ static int wav_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static WAVConf glob_conf = {
-    .settings.freq      = 44100,
-    .settings.nchannels = 2,
-    .settings.fmt       = AUDIO_FORMAT_S16,
-    .wav_path           = "qemu.wav"
-};
-
 static void *wav_audio_init(Audiodev *dev)
 {
-    WAVConf *conf = g_malloc(sizeof(WAVConf));
-    *conf = glob_conf;
-    return conf;
+    assert(dev->driver == AUDIODEV_DRIVER_WAV);
+    return dev;
 }
 
 static void wav_audio_fini (void *opaque)
 {
     ldebug ("wav_fini");
-    g_free(opaque);
 }
 
-static struct audio_option wav_options[] = {
-    {
-        .name  = "FREQUENCY",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.settings.freq,
-        .descr = "Frequency"
-    },
-    {
-        .name  = "FORMAT",
-        .tag   = AUD_OPT_FMT,
-        .valp  = &glob_conf.settings.fmt,
-        .descr = "Format"
-    },
-    {
-        .name  = "DAC_FIXED_CHANNELS",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.settings.nchannels,
-        .descr = "Number of channels (1 - mono, 2 - stereo)"
-    },
-    {
-        .name  = "PATH",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.wav_path,
-        .descr = "Path to wave file"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
@@ -284,7 +245,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
 static struct audio_driver wav_audio_driver = {
     .name           = "wav",
     .descr          = "WAV renderer http://wikipedia.org/wiki/WAV",
-    .options        = wav_options,
     .init           = wav_audio_init,
     .fini           = wav_audio_fini,
     .pcm_ops        = &wav_pcm_ops,
-- 
2.20.1
