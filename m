Received: from eggs.gnu.org ([209.51.188.92]:57768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukj-00042L-4h
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukf-0002nF-A6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukd-0002gH-Bx
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:40 -0500
Received: by mail-wr1-x443.google.com with SMTP id u4so8967135wrp.3
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:35 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:42 +0100
Message-Id: <b80b5b1ba5d7055904efde3d1484747d992fe042.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 09/50] ossaudio: port to -audiodev config
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
 audio/audio_legacy.c |  33 +++++++++
 audio/ossaudio.c     | 167 +++++++++++++++----------------------------
 2 files changed, 90 insertions(+), 110 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 601a68fab6..70b46cbcc1 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -221,6 +221,35 @@ static void handle_dsound(Audiodev *dev)
                        &dev->in->has_buffer_len, dev->in);
 }
 
+/* OSS */
+static void handle_oss_per_direction(
+    AudiodevPerDirectionOptions *pdo, AudiodevOssPerDirectionOptions **opdo,
+    bool *has_opdo, const char *try_poll_env, const char *dev_env)
+{
+    *opdo = g_malloc0(sizeof(AudiodevOssPerDirectionOptions));
+    *has_opdo = true;
+
+    get_bool(try_poll_env, &(*opdo)->try_poll, &(*opdo)->has_try_poll);
+    get_str(dev_env, &(*opdo)->dev, &(*opdo)->has_dev);
+
+    get_bytes_to_usecs("QEMU_OSS_FRAGSIZE",
+                       &pdo->buffer_len, &pdo->has_buffer_len, pdo);
+   get_int("QEMU_OSS_NFRAGS", &pdo->buffer_count, &pdo->has_buffer_count);
+}
+
+static void handle_oss(Audiodev *dev)
+{
+    AudiodevOssOptions *oopt = &dev->u.oss;
+    handle_oss_per_direction(dev->in, &oopt->oss_in, &oopt->has_oss_in,
+                             "QEMU_AUDIO_ADC_TRY_POLL", "QEMU_OSS_ADC_DEV");
+    handle_oss_per_direction(dev->out, &oopt->oss_out, &oopt->has_oss_out,
+                             "QEMU_AUDIO_DAC_TRY_POLL", "QEMU_OSS_DAC_DEV");
+
+    get_bool("QEMU_OSS_MMAP", &oopt->try_mmap, &oopt->has_try_mmap);
+    get_bool("QEMU_OSS_EXCLUSIVE", &oopt->exclusive, &oopt->has_exclusive);
+    get_int("QEMU_OSS_POLICY", &oopt->dsp_policy, &oopt->has_dsp_policy);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -276,6 +305,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
         handle_dsound(e->dev);
         break;
 
+    case AUDIODEV_DRIVER_OSS:
+        handle_oss(e->dev);
+        break;
+
     default:
         break;
     }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index e0cadbef29..d56c705dc0 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -37,16 +37,6 @@
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
@@ -56,7 +46,7 @@ typedef struct OSSVoiceOut {
     int fragsize;
     int mmapped;
     int pending;
-    OSSConf *conf;
+    Audiodev *dev;
 } OSSVoiceOut;
 
 typedef struct OSSVoiceIn {
@@ -65,12 +55,12 @@ typedef struct OSSVoiceIn {
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
@@ -262,19 +252,26 @@ static int oss_get_version (int fd, int *version, const char *typ)
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
@@ -285,6 +282,8 @@ static int oss_open (int in, struct oss_params *req,
     freq = req->freq;
     nchannels = req->nchannels;
     fmt = req->fmt;
+    req->nfrags = pdo->has_buffer_count ? pdo->buffer_count : 4;
+    req->fragsize = audio_buffer_bytes(pdo, as, 23220);
 
     if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &fmt)) {
         oss_logerr2 (errno, typ, "Failed to set sample size %d\n", req->fmt);
@@ -308,18 +307,18 @@ static int oss_open (int in, struct oss_params *req,
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
@@ -502,17 +501,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
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
 
@@ -539,7 +537,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     hw->samples = (obt.nfrags * obt.fragsize) >> hw->info.shift;
 
     oss->mmapped = 0;
-    if (conf->try_mmap) {
+    if (oopts->has_try_mmap && oopts->try_mmap) {
         oss->pcm_buf = mmap (
             NULL,
             hw->samples << hw->info.shift,
@@ -597,7 +595,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     oss->fd = fd;
-    oss->conf = conf;
+    oss->dev = dev;
     return 0;
 }
 
@@ -605,16 +603,12 @@ static int oss_ctl_out (HWVoiceOut *hw, int cmd, ...)
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
+            bool poll_mode = opdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode) {
@@ -669,16 +663,14 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
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
 
@@ -712,7 +704,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     oss->fd = fd;
-    oss->conf = conf;
+    oss->dev = dev;
     return 0;
 }
 
@@ -803,16 +795,12 @@ static int oss_read (SWVoiceIn *sw, void *buf, int size)
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
+            bool poll_mode = opdo->try_poll;
 
             if (poll_mode) {
                 oss_poll_in (hw);
@@ -832,82 +820,42 @@ static int oss_ctl_in (HWVoiceIn *hw, int cmd, ...)
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
+static void oss_init_per_direction(AudiodevOssPerDirectionOptions **opdo,
+                                   bool *has_opdo)
+{
+    if (!*has_opdo) {
+        *opdo = g_malloc0(sizeof(AudiodevOssPerDirectionOptions));
+        *has_opdo = true;
+    }
+
+    if (!(*opdo)->has_try_poll) {
+        (*opdo)->try_poll = true;
+        (*opdo)->has_try_poll = true;
+    }
+}
 
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
+    oss_init_per_direction(&oopts->oss_in, &oopts->has_oss_in);
+    oss_init_per_direction(&oopts->oss_out, &oopts->has_oss_out);
+
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
@@ -925,7 +873,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
 static struct audio_driver oss_audio_driver = {
     .name           = "oss",
     .descr          = "OSS http://www.opensound.com",
-    .options        = oss_options,
     .init           = oss_audio_init,
     .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
-- 
2.20.1
