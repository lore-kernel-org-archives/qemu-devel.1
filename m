Received: from eggs.gnu.org ([208.118.235.92]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjp-0007Rr-0O
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjm-0001oM-Lh
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:40 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjm-0001kk-AV
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id u4so10091652wrp.3
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:38 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:43 +0100
Message-Id: <07f5a54a86ae8083a91111e06387c8dc892aaf4b.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/52] alsaaudio: port to -audiodev config
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
 audio/alsaaudio.c    | 314 ++++++++++++-------------------------------
 audio/audio_legacy.c |  64 +++++++++
 2 files changed, 152 insertions(+), 226 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 8302f3e882..6f75644538 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -23,6 +23,7 @@
  */
 #include "qemu/osdep.h"
 #include <alsa/asoundlib.h>
+#include "qapi/opts-visitor.h"
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
 #include "audio.h"
@@ -33,28 +34,9 @@
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
@@ -66,6 +48,7 @@ typedef struct ALSAVoiceOut {
     void *pcm_buf;
     snd_pcm_t *handle;
     struct pollhlp pollhlp;
+    Audiodev *dev;
 } ALSAVoiceOut;
 
 typedef struct ALSAVoiceIn {
@@ -73,16 +56,13 @@ typedef struct ALSAVoiceIn {
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
@@ -408,7 +388,8 @@ static int alsa_to_audfmt (snd_pcm_format_t alsafmt, AudioFormat *fmt,
 
 static void alsa_dump_info (struct alsa_params_req *req,
                             struct alsa_params_obt *obt,
-                            snd_pcm_format_t obtfmt)
+                            snd_pcm_format_t obtfmt,
+                            AudiodevPerDirectionOptions *pdo)
 {
     dolog ("parameter | requested value | obtained value\n");
     dolog ("format    |      %10d |     %10d\n", req->fmt, obtfmt);
@@ -416,8 +397,9 @@ static void alsa_dump_info (struct alsa_params_req *req,
            req->nchannels, obt->nchannels);
     dolog ("frequency |      %10d |     %10d\n", req->freq, obt->freq);
     dolog ("============================================\n");
-    dolog ("requested: buffer size %d period size %d\n",
-           req->buffer_size, req->period_size);
+    dolog ("requested: buffer len %" PRId64 " buffer count %" PRId64 "\n",
+           pdo->has_buffer_len ? pdo->buffer_len : 0,
+           pdo->has_buffer_count ? pdo->buffer_count : 0);
     dolog ("obtained: samples %ld\n", obt->samples);
 }
 
@@ -451,23 +433,25 @@ static void alsa_set_threshold (snd_pcm_t *handle, snd_pcm_uframes_t threshold)
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
 
@@ -527,79 +511,49 @@ static int alsa_open (int in, struct alsa_params_req *req,
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
+            alsa_logerr2(err, typ, "Failed to set period time to %" PRId64 "\n",
+                         pdo->buffer_len);
             goto err;
         }
 
-        if (((req->override_mask & 1) && (obt - req->period_size)))
-            dolog ("Requested period %s %u was rejected, using %lu\n",
-                   size_in_usec ? "time" : "size", req->period_size, obt);
+        if (pdo->has_buffer_len && ptime != pdo->buffer_len) {
+            dolog("Requested period time %" PRId64 " was rejected, using %d\n",
+                  pdo->buffer_len, ptime);
+        }
     }
 
     err = snd_pcm_hw_params (handle, hw_params);
@@ -631,33 +585,10 @@ static int alsa_open (int in, struct alsa_params_req *req,
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
@@ -670,11 +601,11 @@ static int alsa_open (int in, struct alsa_params_req *req,
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
 
@@ -800,19 +731,13 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
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
 
@@ -833,7 +758,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     alsa->handle = handle;
-    alsa->pollhlp.conf = conf;
+    alsa->dev = dev;
     return 0;
 }
 
@@ -873,16 +798,12 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
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
+            bool poll_mode = !apdo->has_try_poll || apdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode && alsa_poll_out (hw)) {
@@ -911,19 +832,13 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
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
 
@@ -944,7 +859,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     alsa->handle = handle;
-    alsa->pollhlp.conf = conf;
+    alsa->dev = dev;
     return 0;
 }
 
@@ -1086,16 +1001,12 @@ static int alsa_read (SWVoiceIn *sw, void *buf, int size)
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
+            bool poll_mode = !apdo->has_try_poll || apdo->try_poll;
 
             ldebug ("enabling voice\n");
             if (poll_mode && alsa_poll_in (hw)) {
@@ -1118,88 +1029,40 @@ static int alsa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return -1;
 }
 
-static ALSAConf glob_conf = {
-    .buffer_size_out = 4096,
-    .period_size_out = 1024,
-    .pcm_name_out = "default",
-    .pcm_name_in = "default",
-};
-
 static void *alsa_audio_init(Audiodev *dev)
 {
-    ALSAConf *conf = g_malloc(sizeof(ALSAConf));
-    *conf = glob_conf;
-    return conf;
+    assert(dev->driver == AUDIODEV_DRIVER_ALSA);
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
@@ -1217,7 +1080,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
 static struct audio_driver alsa_audio_driver = {
     .name           = "alsa",
     .descr          = "ALSA http://www.alsa-project.org",
-    .options        = alsa_options,
     .init           = alsa_audio_init,
     .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 2242f06a5e..f91ce0c3e2 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -52,6 +52,17 @@ SimpleEnvMap global_map[] = {
     { /* End of list */ }
 };
 
+SimpleEnvMap alsa_map[] = {
+    { "QEMU_AUDIO_DAC_TRY_POLL", "alsa-out.try-poll", ENV_TRANSFORM_BOOL },
+    { "QEMU_AUDIO_ADC_TRY_POLL", "alsa-in.try-poll", ENV_TRANSFORM_BOOL },
+
+    { "QEMU_ALSA_THRESHOLD", "threshold", ENV_TRANSFORM_MILLIS_TO_USECS },
+    { "QEMU_ALSA_DAC_DEV", "alsa-out.dev" },
+    { "QEMU_ALSA_ADC_DEV", "alsa-in.dev" },
+
+    { /* End of list */ }
+};
+
 static unsigned long long toull(const char *str)
 {
     unsigned long long ret;
@@ -162,6 +173,54 @@ static void handle_env_opts(QemuOpts *opts, SimpleEnvMap *map)
     }
 }
 
+static void handle_alsa_side(QemuOpts *opts, int period, int buffer,
+                             const char *usec_env, const char *period_env,
+                             const char *buffer_env, const char *usec_opt,
+                             const char *count_opt, bool in)
+{
+    char *usec_s, *period_s, *buffer_s;
+    bool usec = false;
+
+    usec_s = getenv(usec_env);
+    if (usec_s) {
+        usec = toull(usec_s);
+    }
+
+    period_s = getenv(period_env);
+    if (period_s) {
+        period = toull(period_s);
+    }
+    if (!usec) {
+        period = frames_to_usecs(opts, period, in);
+    }
+    if (period_s) {
+        qemu_opt_set(opts, usec_opt, tostr(period), &error_abort);
+    }
+
+    buffer_s = getenv(buffer_env);
+    if (buffer_s) {
+        buffer = toull(buffer_s);
+        if (!usec) {
+            buffer = frames_to_usecs(opts, buffer, in);
+        }
+        printf("buffer %d period %d\n", buffer, period);
+        qemu_opt_set(opts, count_opt, tostr((buffer + period / 2) / period),
+                     &error_abort);
+    }
+}
+
+static void handle_alsa(QemuOpts *opts)
+{
+    handle_alsa_side(opts, 1024, 4096,
+                     "QEMU_ALSA_DAC_SIZE_IN_USEC", "QEMU_ALSA_DAC_PERIOD_SIZE",
+                     "QEMU_ALSA_DAC_BUFFER_SIZE",
+                     "out.buffer-len", "out.buffer-count", false);
+    handle_alsa_side(opts, 0, 0,
+                     "QEMU_ALSA_ADC_SIZE_IN_USEC", "QEMU_ALSA_ADC_PERIOD_SIZE",
+                     "QEMU_ALSA_ADC_BUFFER_SIZE",
+                     "in.buffer-len", "in.buffer-count", true);
+}
+
 static void legacy_opt(const char *drv)
 {
     QemuOpts *opts;
@@ -170,6 +229,11 @@ static void legacy_opt(const char *drv)
     qemu_opt_set(opts, "driver", drv, &error_abort);
 
     handle_env_opts(opts, global_map);
+
+    if (strcmp(drv, "alsa") == 0) {
+        handle_env_opts(opts, alsa_map);
+        handle_alsa(opts);
+    }
 }
 
 void audio_handle_legacy_opts(void)
-- 
2.20.1
