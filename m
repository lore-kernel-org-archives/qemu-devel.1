Received: from eggs.gnu.org ([209.51.188.92]:58020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuks-000478-6K
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukk-0002vl-BA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukj-0002dB-TM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:46 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so8949704wrt.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:31 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:38 +0100
Message-Id: <3c15ec783e0143566b75215843872a0bdc186af5.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/50] alsaaudio: port to -audiodev config
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
 audio/alsaaudio.c    | 330 ++++++++++++++-----------------------------
 audio/audio_legacy.c |  94 +++++++++++-
 2 files changed, 198 insertions(+), 226 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 8302f3e882..6b43a06180 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -33,28 +33,9 @@
 #define AUDIO_CAP "alsa"
 #include "audio_int.h"
 
-typedef struct ALSAConf {
-    int size_in_usec_in;
-    int size_in_usec_out;
-    const char *pcm_name_in;
-    const char *pcm_name_out;
-    unsigned int buffer_size_in;
-    unsigned int period_size_in;
-    unsigned int buffer_size_out;
-    unsigned int period_size_out;
-    unsigned int threshold;
-
-    int buffer_size_in_overridden;
-    int period_size_in_overridden;
-
-    int buffer_size_out_overridden;
-    int period_size_out_overridden;
-} ALSAConf;
-
 struct pollhlp {
     snd_pcm_t *handle;
     struct pollfd *pfds;
-    ALSAConf *conf;
     int count;
     int mask;
 };
@@ -66,6 +47,7 @@ typedef struct ALSAVoiceOut {
     void *pcm_buf;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
+    Audiodev *dev;
 } ALSAVoiceOut;
 
 typedef struct ALSAVoiceIn {
@@ -73,16 +55,13 @@ typedef struct ALSAVoiceIn {
     snd_pcm_t *handle;
     void *pcm_buf;
     struct pollhlp pollhlp;
+    Audiodev *dev;
 } ALSAVoiceIn;
 
 struct alsa_params_req {
     int freq;
     snd_pcm_format_t fmt;
     int nchannels;
-    int size_in_usec;
-    int override_mask;
-    unsigned int buffer_size;
-    unsigned int period_size;
 };
 
 struct alsa_params_obt {
@@ -408,7 +387,8 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
 
 static void alsa_dump_info (struct alsa_params_req *req,
                             struct alsa_params_obt *obt,
-                            snd_pcm_format_t obtfmt)
+                            snd_pcm_format_t obtfmt,
+                            AudiodevPerDirectionOptions *pdo)
 {
     dolog ("parameter | requested value | obtained value\n");
     dolog ("format    |      %10d |     %10d\n", req->fmt, obtfmt);
@@ -416,8 +396,9 @@ static void alsa_dump_info (struct alsa_params_req *req,
            req->nchannels, obt->nchannels);
     dolog ("frequency |      %10d |     %10d\n", req->freq, obt->freq);
     dolog ("============================================\n");
-    dolog ("requested: buffer size %d period size %d\n",
-           req->buffer_size, req->period_size);
+    dolog ("requested: buffer len %" PRId32 " buffer count %" PRId32 "\n",
+           pdo->has_buffer_len ? pdo->buffer_len : 0,
+           pdo->has_buffer_count ? pdo->buffer_count : 0);
     dolog ("obtained: samples %ld\n", obt->samples);
 }
 
@@ -451,23 +432,25 @@ static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
     }
 }
 
-static int alsa_open (int in, struct alsa_params_req *req,
-                      struct alsa_params_obt *obt, snd_pcm_t **handlep,
-                      ALSAConf *conf)
+static int alsa_open(bool in, struct alsa_params_req *req,
+                     struct alsa_params_obt *obt, snd_pcm_t **handlep,
+                     Audiodev *dev)
 {
+    AudiodevPerDirectionOptions *pdo = in ? dev->in : dev->out;
+    AudiodevAlsaOptions *aopts = &dev->u.alsa;
+    AudiodevAlsaPerDirectionOptions *apdo =
+        in ? aopts->alsa_in : aopts->alsa_out;
     snd_pcm_t *handle;
     snd_pcm_hw_params_t *hw_params;
     int err;
-    int size_in_usec;
     unsigned int freq, nchannels;
-    const char *pcm_name = in ? conf->pcm_name_in : conf->pcm_name_out;
+    const char *pcm_name = apdo->has_dev ? apdo->dev : "default";
     snd_pcm_uframes_t obt_buffer_size;
     const char *typ = in ? "ADC" : "DAC";
     snd_pcm_format_t obtfmt;
 
     freq = req->freq;
     nchannels = req->nchannels;
-    size_in_usec = req->size_in_usec;
 
     snd_pcm_hw_params_alloca (&hw_params);
 
@@ -527,79 +510,49 @@ static int alsa_open (int in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (req->buffer_size) {
-        unsigned long obt;
+    if (pdo->buffer_count) {
+        if (pdo->buffer_len) {
+            int64_t req = pdo->buffer_len * pdo->buffer_count;
 
-        if (size_in_usec) {
             int dir = 0;
-            unsigned int btime = req->buffer_size;
+            unsigned int btime = req;
 
-            err = snd_pcm_hw_params_set_buffer_time_near (
-                handle,
-                hw_params,
-                &btime,
-                &dir
-                );
-            obt = btime;
-        }
-        else {
-            snd_pcm_uframes_t bsize = req->buffer_size;
+            err = snd_pcm_hw_params_set_buffer_time_near(
+                handle, hw_params, &btime, &dir);
 
-            err = snd_pcm_hw_params_set_buffer_size_near (
-                handle,
-                hw_params,
-                &bsize
-                );
-            obt = bsize;
-        }
-        if (err < 0) {
-            alsa_logerr2 (err, typ, "Failed to set buffer %s to %d\n",
-                          size_in_usec ? "time" : "size", req->buffer_size);
-            goto err;
-        }
+            if (err < 0) {
+                alsa_logerr2(err, typ,
+                             "Failed to set buffer time to %" PRId64 "\n",
+                             req);
+                goto err;
+            }
 
-        if ((req->override_mask & 2) && (obt - req->buffer_size))
-            dolog ("Requested buffer %s %u was rejected, using %lu\n",
-                   size_in_usec ? "time" : "size", req->buffer_size, obt);
+            if (pdo->has_buffer_count && btime != req) {
+                dolog("Requested buffer time %" PRId64
+                      " was rejected, using %u\n", req, btime);
+            }
+        } else {
+            dolog("Can't set buffer-count without buffer-len!\n");
+        }
     }
 
-    if (req->period_size) {
-        unsigned long obt;
+    if (pdo->buffer_len) {
+        int dir = 0;
+        unsigned int ptime = pdo->buffer_len;
 
-        if (size_in_usec) {
-            int dir = 0;
-            unsigned int ptime = req->period_size;
-
-            err = snd_pcm_hw_params_set_period_time_near (
-                handle,
-                hw_params,
-                &ptime,
-                &dir
-                );
-            obt = ptime;
-        }
-        else {
-            int dir = 0;
-            snd_pcm_uframes_t psize = req->period_size;
-
-            err = snd_pcm_hw_params_set_period_size_near (
-                handle,
-                hw_params,
-                &psize,
-                &dir
-                );
-            obt = psize;
-        }
+        err = snd_pcm_hw_params_set_period_time_near(handle, hw_params, &ptime,
+                                                     &dir);
 
         if (err < 0) {
-            alsa_logerr2 (err, typ, "Failed to set period %s to %d\n",
-                          size_in_usec ? "time" : "size", req->period_size);
+            alsa_logerr2(err, typ, "Failed to set period time to %" PRId32 "\n",
+                         pdo->buffer_len);
             goto err;
         }
 
-        if (((req->override_mask & 1) && (obt - req->period_size)))
-            dolog ("Requested period %s %u was rejected, using %lu\n",
-                   size_in_usec ? "time" : "size", req->period_size, obt);
+        if (pdo->has_buffer_len && ptime != pdo->buffer_len) {
+            dolog("Requested period time %" PRId32 " was rejected, using %d\n",
+                  pdo->buffer_len, ptime);
+        }
     }
 
     err = snd_pcm_hw_params (handle, hw_params);
@@ -631,33 +584,10 @@ static int alsa_open (int in, struct alsa_params_req *req,
         goto err;
     }
 
-    if (!in && conf->threshold) {
-        snd_pcm_uframes_t threshold;
-        int bytes_per_sec;
-
-        bytes_per_sec = freq << (nchannels == 2);
-
-        switch (obt->fmt) {
-        case AUDIO_FORMAT_S8:
-        case AUDIO_FORMAT_U8:
-            break;
-
-        case AUDIO_FORMAT_S16:
-        case AUDIO_FORMAT_U16:
-            bytes_per_sec <<= 1;
-            break;
-
-        case AUDIO_FORMAT_S32:
-        case AUDIO_FORMAT_U32:
-            bytes_per_sec <<= 2;
-            break;
-
-        default:
-            abort();
-        }
-
-        threshold = (conf->threshold * bytes_per_sec) / 1000;
-        alsa_set_threshold (handle, threshold);
+    if (!in && aopts->has_threshold && aopts->threshold) {
+        struct audsettings as = { .freq = freq };
+        alsa_set_threshold(handle,
+                           audio_buffer_frames(pdo, &as, aopts->threshold));
     }
 
     obt->nchannels = nchannels;
@@ -670,11 +600,11 @@ static int alsa_open (int in, struct alsa_params_req *req,
          obt->nchannels != req->nchannels ||
          obt->freq != req->freq) {
         dolog ("Audio parameters for %s\n", typ);
-        alsa_dump_info (req, obt, obtfmt);
+        alsa_dump_info (req, obt, obtfmt, pdo);
     }
 
 #ifdef DEBUG
-    alsa_dump_info (req, obt, obtfmt);
+    alsa_dump_info (req, obt, obtfmt, pdo);
 #endif
     return 0;
 
@@ -800,19 +730,13 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     struct alsa_params_obt obt;
     snd_pcm_t *handle;
     struct audsettings obt_as;
-    ALSAConf *conf = drv_opaque;
+    Audiodev *dev = drv_opaque;
 
     req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
-    req.period_size = conf->period_size_out;
-    req.buffer_size = conf->buffer_size_out;
-    req.size_in_usec = conf->size_in_usec_out;
-    req.override_mask =
-        (conf->period_size_out_overridden ? 1 : 0) |
-        (conf->buffer_size_out_overridden ? 2 : 0);
 
-    if (alsa_open (0, &req, &obt, &handle, conf)) {
+    if (alsa_open (0, &req, &obt, &handle, dev)) {
         return -1;
     }
 
@@ -833,7 +757,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     alsa->handle = handle;
-    alsa->pollhlp.conf = conf;
+    alsa->dev = dev;
     return 0;
 }
 
@@ -873,16 +797,12 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
 static int alsa_ctl_out (HWVoiceOut *hw, int cmd, ...)
 {
     ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
+    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.alsa_out;
 
     switch (cmd) {
     case VOICE_ENABLE:
         {
-            va_list ap;
-            int poll_mode;
-
-            va_start (ap, cmd);
-            poll_mode = va_arg (ap, int);
-            va_end (ap);
+            bool poll_mode = apdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode && alsa_poll_out (hw)) {
@@ -911,19 +831,13 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     struct alsa_params_obt obt;
     snd_pcm_t *handle;
     struct audsettings obt_as;
-    ALSAConf *conf = drv_opaque;
+    Audiodev *dev = drv_opaque;
 
     req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
     req.freq = as->freq;
     req.nchannels = as->nchannels;
-    req.period_size = conf->period_size_in;
-    req.buffer_size = conf->buffer_size_in;
-    req.size_in_usec = conf->size_in_usec_in;
-    req.override_mask =
-        (conf->period_size_in_overridden ? 1 : 0) |
-        (conf->buffer_size_in_overridden ? 2 : 0);
 
-    if (alsa_open (1, &req, &obt, &handle, conf)) {
+    if (alsa_open (1, &req, &obt, &handle, dev)) {
         return -1;
     }
 
@@ -944,7 +858,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     alsa->handle = handle;
-    alsa->pollhlp.conf = conf;
+    alsa->dev = dev;
     return 0;
 }
 
@@ -1086,16 +1000,12 @@ static int alsa_read (SWVoiceIn *sw, void *buf, int size)
 static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 {
     ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
+    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.alsa_in;
 
     switch (cmd) {
     case VOICE_ENABLE:
         {
-            va_list ap;
-            int poll_mode;
-
-            va_start (ap, cmd);
-            poll_mode = va_arg (ap, int);
-            va_end (ap);
+            bool poll_mode = apdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode && alsa_poll_in (hw)) {
@@ -1118,88 +1028,59 @@ static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return -1;
 }
 
-static ALSAConf glob_conf = {
-    .buffer_size_out = 4096,
-    .period_size_out = 1024,
-    .pcm_name_out = "default",
-    .pcm_name_in = "default",
-};
+static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions **apdo,
+                                    bool *has_apdo)
+{
+    if (!*has_apdo) {
+        *apdo = g_malloc0(sizeof(AudiodevAlsaPerDirectionOptions));
+        *has_apdo = true;
+    }
+
+    if (!(*apdo)->has_try_poll) {
+        (*apdo)->try_poll = true;
+        (*apdo)->has_try_poll = true;
+    }
+}
 
 static void *alsa_audio_init(Audiodev *dev)
 {
-    ALSAConf *conf = g_malloc(sizeof(ALSAConf));
-    *conf = glob_conf;
-    return conf;
+    AudiodevAlsaOptions *aopts;
+    assert(dev->driver == AUDIODEV_DRIVER_ALSA);
+
+    aopts = &dev->u.alsa;
+    alsa_init_per_direction(&aopts->alsa_in, &aopts->has_alsa_in);
+    alsa_init_per_direction(&aopts->alsa_out, &aopts->has_alsa_out);
+
+    /*
+     * need to define them, as otherwise alsa produces no sound
+     * doesn't set has_* so alsa_open can identify it wasn't set by the user
+     */
+    if (!dev->out->has_buffer_count) {
+        dev->out->buffer_count = 4;
+    }
+    if (!dev->out->has_buffer_len) {
+        /* 1024 frames assuming 44100Hz */
+        dev->out->buffer_len = 1024 * 1000000 / 44100;
+    }
+
+    /*
+     * OptsVisitor sets unspecified optional fields to zero, but do not depend
+     * on it...
+     */
+    if (!dev->in->has_buffer_count) {
+        dev->in->buffer_count = 0;
+    }
+    if (!dev->in->has_buffer_len) {
+        dev->in->buffer_len = 0;
+    }
+
+    return dev;
 }
 
 static void alsa_audio_fini (void *opaque)
 {
-    g_free(opaque);
 }
 
-static struct audio_option alsa_options[] = {
-    {
-        .name        = "DAC_SIZE_IN_USEC",
-        .tag         = AUD_OPT_BOOL,
-        .valp        = &glob_conf.size_in_usec_out,
-        .descr       = "DAC period/buffer size in microseconds (otherwise in frames)"
-    },
-    {
-        .name        = "DAC_PERIOD_SIZE",
-        .tag         = AUD_OPT_INT,
-        .valp        = &glob_conf.period_size_out,
-        .descr       = "DAC period size (0 to go with system default)",
-        .overriddenp = &glob_conf.period_size_out_overridden
-    },
-    {
-        .name        = "DAC_BUFFER_SIZE",
-        .tag         = AUD_OPT_INT,
-        .valp        = &glob_conf.buffer_size_out,
-        .descr       = "DAC buffer size (0 to go with system default)",
-        .overriddenp = &glob_conf.buffer_size_out_overridden
-    },
-    {
-        .name        = "ADC_SIZE_IN_USEC",
-        .tag         = AUD_OPT_BOOL,
-        .valp        = &glob_conf.size_in_usec_in,
-        .descr       =
-        "ADC period/buffer size in microseconds (otherwise in frames)"
-    },
-    {
-        .name        = "ADC_PERIOD_SIZE",
-        .tag         = AUD_OPT_INT,
-        .valp        = &glob_conf.period_size_in,
-        .descr       = "ADC period size (0 to go with system default)",
-        .overriddenp = &glob_conf.period_size_in_overridden
-    },
-    {
-        .name        = "ADC_BUFFER_SIZE",
-        .tag         = AUD_OPT_INT,
-        .valp        = &glob_conf.buffer_size_in,
-        .descr       = "ADC buffer size (0 to go with system default)",
-        .overriddenp = &glob_conf.buffer_size_in_overridden
-    },
-    {
-        .name        = "THRESHOLD",
-        .tag         = AUD_OPT_INT,
-        .valp        = &glob_conf.threshold,
-        .descr       = "(undocumented)"
-    },
-    {
-        .name        = "DAC_DEV",
-        .tag         = AUD_OPT_STR,
-        .valp        = &glob_conf.pcm_name_out,
-        .descr       = "DAC device name (for instance dmix)"
-    },
-    {
-        .name        = "ADC_DEV",
-        .tag         = AUD_OPT_STR,
-        .valp        = &glob_conf.pcm_name_in,
-        .descr       = "ADC device name"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops alsa_pcm_ops = {
     .init_out = alsa_init_out,
     .fini_out = alsa_fini_out,
@@ -1217,7 +1098,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
 static struct audio_driver alsa_audio_driver = {
     .name           = "alsa",
     .descr          = "ALSA http://www.alsa-project.org",
-    .options        = alsa_options,
     .init           = alsa_audio_init,
     .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index e094b2bd61..5117bdecb7 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -62,6 +62,18 @@ static void get_int(const char *env, uint32_t *dst, bool *has_dst)
     }
 }
 
+static void get_str(const char *env, char **dst, bool *has_dst)
+{
+    const char *val = getenv(env);
+    if (val) {
+        if (*has_dst) {
+            g_free(*dst);
+        }
+        *dst = g_strdup(val);
+        *has_dst = true;
+    }
+}
+
 static void get_fmt(const char *env, AudioFormat *dst, bool *has_dst)
 {
     const char *val = getenv(env);
@@ -80,8 +92,79 @@ static void get_fmt(const char *env, AudioFormat *dst, bool *has_dst)
     }
 }
 
+
+static void get_millis_to_usecs(const char *env, uint32_t *dst, bool *has_dst)
+{
+    const char *val = getenv(env);
+    if (val) {
+        *dst = toui32(val) * 1000;
+        *has_dst = true;
+    }
+}
+
+static uint32_t frames_to_usecs(uint32_t frames,
+                                AudiodevPerDirectionOptions *pdo)
+{
+    uint32_t freq = pdo->has_frequency ? pdo->frequency : 44100;
+    return (frames * 1000000 + freq / 2) / freq;
+}
+
 /* backend specific functions */
-/* todo */
+/* ALSA */
+static void handle_alsa_per_direction(
+    AudiodevPerDirectionOptions *pdo, AudiodevAlsaPerDirectionOptions **apdo,
+    bool *has_apdo, const char *prefix)
+{
+    char buf[64];
+    size_t len = strlen(prefix);
+    bool size_in_usecs = false;
+    uint32_t buffer_size;
+    bool has_buffer_size = false;
+    bool dummy;
+
+    *apdo = g_malloc0(sizeof(AudiodevAlsaPerDirectionOptions));
+    *has_apdo = true;
+
+    memcpy(buf, prefix, len);
+    strcpy(buf + len, "TRY_POLL");
+    get_bool(buf, &(*apdo)->try_poll, &(*apdo)->has_try_poll);
+
+    strcpy(buf + len, "DEV");
+    get_str(buf, &(*apdo)->dev, &(*apdo)->has_dev);
+
+    strcpy(buf + len, "SIZE_IN_USEC");
+    get_bool(buf, &size_in_usecs, &dummy);
+
+    strcpy(buf + len, "PERIOD_SIZE");
+    get_int(buf, &pdo->buffer_len, &pdo->has_buffer_len);
+
+    if (pdo->has_buffer_len && !size_in_usecs) {
+        pdo->buffer_len = frames_to_usecs(pdo->buffer_len, pdo);
+    }
+
+    strcpy(buf + len, "BUFFER_SIZE");
+    get_int(buf, &buffer_size, &has_buffer_size);
+    if (has_buffer_size) {
+        if (!size_in_usecs) {
+            buffer_size = frames_to_usecs(buffer_size, pdo);
+        }
+
+        pdo->buffer_count = buffer_size;
+        pdo->has_buffer_count = true;
+    }
+}
+
+static void handle_alsa(Audiodev *dev)
+{
+    AudiodevAlsaOptions *aopt = &dev->u.alsa;
+    handle_alsa_per_direction(dev->in, &aopt->alsa_in, &aopt->has_alsa_in,
+                              "QEMU_ALSA_ADC_");
+    handle_alsa_per_direction(dev->out, &aopt->alsa_out, &aopt->has_alsa_out,
+                              "QEMU_ALSA_DAC_");
+
+    get_millis_to_usecs("QEMU_ALSA_THRESHOLD",
+                        &aopt->threshold, &aopt->has_threshold);
+}
 
 /* general */
 static void handle_per_direction(
@@ -125,6 +208,15 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
     get_int("QEMU_AUDIO_TIMER_PERIOD",
             &e->dev->timer_period, &e->dev->has_timer_period);
 
+    switch (e->dev->driver) {
+    case AUDIODEV_DRIVER_ALSA:
+        handle_alsa(e->dev);
+        break;
+
+    default:
+        break;
+    }
+
     return e;
 }
 
-- 
2.20.1
