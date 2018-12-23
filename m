Received: from eggs.gnu.org ([208.118.235.92]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjr-0007WT-Vx
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjp-0001yy-Tf
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjp-0001va-Hf
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:41 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so10406929wmf.5
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:41 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:47 +0100
Message-Id: <26249b5186151dd3be871730b41b87959037540f.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 11/52] ossaudio: port to -audiodev config
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
 audio/audio_legacy.c |  17 +++++
 audio/ossaudio.c     | 153 ++++++++++++-------------------------------
 2 files changed, 59 insertions(+), 111 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 48a22c390a..f37407586b 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -81,6 +81,21 @@ SimpleEnvMap dsound_map[] = {
     { /* End of list */ }
 };
 
+SimpleEnvMap oss_map[] = {
+    { "QEMU_AUDIO_DAC_TRY_POLL", "oss-out.try-poll", ENV_TRANSFORM_BOOL },
+    { "QEMU_AUDIO_ADC_TRY_POLL", "oss-in.try-poll", ENV_TRANSFORM_BOOL },
+
+    { "QEMU_OSS_FRAGSIZE", "buffer-len", ENV_TRANSFORM_BYTES_TO_USECS_OUT },
+    { "QEMU_OSS_NFRAGS", "buffer-count" },
+    { "QEMU_OSS_MMAP", "try-mmap", ENV_TRANSFORM_BOOL },
+    { "QEMU_OSS_DAC_DEV", "oss-out.dev" },
+    { "QEMU_OSS_ADC_DEV", "oss-in.dev" },
+    { "QEMU_OSS_EXCLUSIVE", "exclusive", ENV_TRANSFORM_BOOL },
+    { "QEMU_OSS_POLICY", "dsp-policy" },
+
+    { /* End of list */ }
+};
+
 static unsigned long long toull(const char *str)
 {
     unsigned long long ret;
@@ -255,6 +270,8 @@ static void legacy_opt(const char *drv)
         handle_env_opts(opts, coreaudio_map);
     } else if (strcmp(drv, "dsound") == 0) {
         handle_env_opts(opts, dsound_map);
+    } else if (strcmp(drv, "oss") == 0) {
+        handle_env_opts(opts, oss_map);
     }
 }
 
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index e0cadbef29..83ff1d2ebd 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -27,6 +27,7 @@
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
 #include "qemu/host-utils.h"
+#include "qapi/opts-visitor.h"
 #include "audio.h"
 #include "trace.h"
 
@@ -37,16 +38,6 @@
 #define USE_DSP_POLICY
 #endif
 
-typedef struct OSSConf {
-    int try_mmap;
-    int nfrags;
-    int fragsize;
-    const char *devpath_out;
-    const char *devpath_in;
-    int exclusive;
-    int policy;
-} OSSConf;
-
 typedef struct OSSVoiceOut {
     HWVoiceOut hw;
     void *pcm_buf;
@@ -56,7 +47,7 @@ typedef struct OSSVoiceOut {
     int fragsize;
     int mmapped;
     int pending;
-    OSSConf *conf;
+    Audiodev *dev;
 } OSSVoiceOut;
 
 typedef struct OSSVoiceIn {
@@ -65,12 +56,12 @@ typedef struct OSSVoiceIn {
     int fd;
     int nfrags;
     int fragsize;
-    OSSConf *conf;
+    Audiodev *dev;
 } OSSVoiceIn;
 
 struct oss_params {
     int freq;
-    AudioFormat fmt;
+    int fmt;
     int nchannels;
     int nfrags;
     int fragsize;
@@ -262,19 +253,26 @@ static int oss_get_version (int fd, int *version, const char *typ)
 }
 #endif
 
-static int oss_open (int in, struct oss_params *req,
-                     struct oss_params *obt, int *pfd, OSSConf* conf)
+static int oss_open(int in, struct oss_params *req, audsettings *as,
+                    struct oss_params *obt, int *pfd, Audiodev *dev)
 {
+    AudiodevOssOptions *oopts = &dev->u.oss;
+    AudiodevOssPerDirectionOptions *opdo = in ? oopts->oss_in : oopts->oss_out;
+    AudiodevPerDirectionOptions *pdo = in ? dev->in : dev->out;
     int fd;
-    int oflags = conf->exclusive ? O_EXCL : 0;
+    int oflags = (oopts->has_exclusive && oopts->exclusive) ? O_EXCL : 0;
     audio_buf_info abinfo;
     int fmt, freq, nchannels;
     int setfragment = 1;
-    const char *dspname = in ? conf->devpath_in : conf->devpath_out;
+    const char *dspname = opdo->has_dev ? opdo->dev : "/dev/dsp";
     const char *typ = in ? "ADC" : "DAC";
+#ifdef USE_DSP_POLICY
+    int policy = oopts->has_dsp_policy ? oopts->dsp_policy : 5;
+#endif
 
     /* Kludge needed to have working mmap on Linux */
-    oflags |= conf->try_mmap ? O_RDWR : (in ? O_RDONLY : O_WRONLY);
+    oflags |= (oopts->has_try_mmap && oopts->try_mmap) ?
+        O_RDWR : (in ? O_RDONLY : O_WRONLY);
 
     fd = open (dspname, oflags | O_NONBLOCK);
     if (-1 == fd) {
@@ -285,6 +283,8 @@ static int oss_open (int in, struct oss_params *req,
     freq = req->freq;
     nchannels = req->nchannels;
     fmt = req->fmt;
+    req->nfrags = pdo->has_buffer_count ? pdo->buffer_count : 4;
+    req->fragsize = audio_buffer_bytes(pdo, as, 23220);
 
     if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &fmt)) {
         oss_logerr2 (errno, typ, "Failed to set sample size %d\n", req->fmt);
@@ -308,18 +308,18 @@ static int oss_open (int in, struct oss_params *req,
     }
 
 #ifdef USE_DSP_POLICY
-    if (conf->policy >= 0) {
+    if (policy >= 0) {
         int version;
 
         if (!oss_get_version (fd, &version, typ)) {
             trace_oss_version(version);
 
             if (version >= 0x040000) {
-                int policy = conf->policy;
-                if (ioctl (fd, SNDCTL_DSP_POLICY, &policy)) {
+                int policy2 = policy;
+                if (ioctl (fd, SNDCTL_DSP_POLICY, &policy2)) {
                     oss_logerr2 (errno, typ,
                                  "Failed to set timing policy to %d\n",
-                                 conf->policy);
+                                 policy);
                     goto err;
                 }
                 setfragment = 0;
@@ -502,17 +502,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     int fd;
     AudioFormat effective_fmt;
     struct audsettings obt_as;
-    OSSConf *conf = drv_opaque;
+    Audiodev *dev = drv_opaque;
+    AudiodevOssOptions *oopts = &dev->u.oss;
 
     oss->fd = -1;
 
     req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
-    req.fragsize = conf->fragsize;
-    req.nfrags = conf->nfrags;
 
-    if (oss_open (0, &req, &obt, &fd, conf)) {
+    if (oss_open(0, &req, as, &obt, &fd, dev)) {
         return -1;
     }
 
@@ -539,7 +538,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
 
     oss->mmapped = 0;
-    if (conf->try_mmap) {
+    if (oopts->has_try_mmap && oopts->try_mmap) {
         oss->pcm_buf = mmap (
             NULL,
             hw->samples << hw->info.shift,
@@ -597,7 +596,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     oss->fd = fd;
-    oss->conf = conf;
+    oss->dev = dev;
     return 0;
 }
 
@@ -605,16 +604,12 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
     int trig;
     OSSVoiceOut *oss = (OSSVoiceOut *) hw;
+    AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.oss_out;
 
     switch (cmd) {
     case VOICE_ENABLE:
         {
-            va_list ap;
-            int poll_mode;
-
-            va_start (ap, cmd);
-            poll_mode = va_arg (ap, int);
-            va_end (ap);
+            bool poll_mode = !opdo->has_try_poll || opdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode) {
@@ -669,16 +664,14 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     int fd;
     AudioFormat effective_fmt;
     struct audsettings obt_as;
-    OSSConf *conf = drv_opaque;
+    Audiodev *dev = drv_opaque;
 
     oss->fd = -1;
 
     req.fmt = aud_to_ossfmt (as->fmt, as->endianness);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
-    req.fragsize = conf->fragsize;
-    req.nfrags = conf->nfrags;
-    if (oss_open (1, &req, &obt, &fd, conf)) {
+    if (oss_open(1, &req, as, &obt, &fd, dev)) {
         return -1;
     }
 
@@ -712,7 +705,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     oss->fd = fd;
-    oss->conf = conf;
+    oss->dev = dev;
     return 0;
 }
 
@@ -803,16 +796,12 @@ static int oss_read (SWVoiceIn *sw, void *buf, int size)
 static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     OSSVoiceIn *oss = (OSSVoiceIn *) hw;
+    AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.oss_out;
 
     switch (cmd) {
     case VOICE_ENABLE:
         {
-            va_list ap;
-            int poll_mode;
-
-            va_start (ap, cmd);
-            poll_mode = va_arg (ap, int);
-            va_end (ap);
+            bool poll_mode = !opdo->has_try_poll || opdo->try_poll;
 
             if (poll_mode) {
                 oss_poll_in (hw);
@@ -832,82 +821,25 @@ static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static OSSConf glob_conf = {
-    .try_mmap = 0,
-    .nfrags = 4,
-    .fragsize = 4096,
-    .devpath_out = "/dev/dsp",
-    .devpath_in = "/dev/dsp",
-    .exclusive = 0,
-    .policy = 5
-};
-
 static void *oss_audio_init(Audiodev *dev)
 {
-    OSSConf *conf = g_malloc(sizeof(OSSConf));
-    *conf = glob_conf;
+    AudiodevOssOptions *oopts;
+    assert(dev->driver == AUDIODEV_DRIVER_OSS);
 
-    if (access(conf->devpath_in, R_OK | W_OK) < 0 ||
-        access(conf->devpath_out, R_OK | W_OK) < 0) {
-        g_free(conf);
+    oopts = &dev->u.oss;
+    if (access(oopts->oss_in->has_dev ? oopts->oss_in->dev : "/dev/dsp",
+               R_OK | W_OK) < 0 ||
+        access(oopts->oss_out->has_dev ? oopts->oss_out->dev : "/dev/dsp",
+               R_OK | W_OK) < 0) {
         return NULL;
     }
-    return conf;
+    return dev;
 }
 
 static void oss_audio_fini (void *opaque)
 {
-    g_free(opaque);
 }
 
-static struct audio_option oss_options[] = {
-    {
-        .name  = "FRAGSIZE",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.fragsize,
-        .descr = "Fragment size in bytes"
-    },
-    {
-        .name  = "NFRAGS",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.nfrags,
-        .descr = "Number of fragments"
-    },
-    {
-        .name  = "MMAP",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &glob_conf.try_mmap,
-        .descr = "Try using memory mapped access"
-    },
-    {
-        .name  = "DAC_DEV",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.devpath_out,
-        .descr = "Path to DAC device"
-    },
-    {
-        .name  = "ADC_DEV",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.devpath_in,
-        .descr = "Path to ADC device"
-    },
-    {
-        .name  = "EXCLUSIVE",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &glob_conf.exclusive,
-        .descr = "Open device in exclusive mode (vmix won't work)"
-    },
-#ifdef USE_DSP_POLICY
-    {
-        .name  = "POLICY",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.policy,
-        .descr = "Set the timing policy of the device, -1 to use fragment mode",
-    },
-#endif
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops oss_pcm_ops = {
     .init_out = oss_init_out,
     .fini_out = oss_fini_out,
@@ -925,7 +857,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
 static struct audio_driver oss_audio_driver = {
     .name           = "oss",
     .descr          = "OSS http://www.opensound.com",
-    .options        = oss_options,
     .init           = oss_audio_init,
     .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
-- 
2.20.1
