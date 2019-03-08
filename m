Received: from eggs.gnu.org ([209.51.188.92]:38717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4k-0007p0-I6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1h2O4h-0002hG-KO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:45 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1h2O4d-0002dx-PO
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 17:34:41 -0500
Received: by mail-wr1-x42e.google.com with SMTP id d17so22954997wre.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 14:34:38 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Fri,  8 Mar 2019 23:34:21 +0100
Message-Id: <c74dc9c282075fba6928c40b2deae057fa0d4049.1552083282.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
References: <cover.1552083282.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 10/14] paaudio: port to -audiodev config
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
 audio/audio_legacy.c | 38 +++++++++++++++++++++
 audio/paaudio.c      | 81 ++++++++++++++++----------------------------
 2 files changed, 67 insertions(+), 52 deletions(-)

diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
index 94f95bbc73..8d7f1475b5 100644
--- a/audio/audio_legacy.c
+++ b/audio/audio_legacy.c
@@ -127,6 +127,16 @@ static uint32_t samples_to_usecs(uint32_t samples,
     return frames_to_usecs(samples / channels, pdo);
 }
 
+static void get_samples_to_usecs(const char *env, uint32_t *dst, bool *has_dst,
+                                 AudiodevPerDirectionOptions *pdo)
+{
+    const char *val = getenv(env);
+    if (val) {
+        *dst = samples_to_usecs(toui32(val), pdo);
+        *has_dst = true;
+    }
+}
+
 static uint32_t bytes_to_usecs(uint32_t bytes, AudiodevPerDirectionOptions *pdo)
 {
     AudioFormat fmt = pdo->has_format ? pdo->format : AUDIO_FORMAT_S16;
@@ -247,6 +257,30 @@ static void handle_oss(Audiodev *dev)
     get_int("QEMU_OSS_POLICY", &oopt->dsp_policy, &oopt->has_dsp_policy);
 }
 
+/* pulseaudio */
+static void handle_pa_per_direction(
+    AudiodevPaPerDirectionOptions *ppdo, const char *env)
+{
+    get_str(env, &ppdo->name, &ppdo->has_name);
+}
+
+static void handle_pa(Audiodev *dev)
+{
+    handle_pa_per_direction(dev->u.pa.in, "QEMU_PA_SOURCE");
+    handle_pa_per_direction(dev->u.pa.out, "QEMU_PA_SINK");
+
+    get_samples_to_usecs(
+        "QEMU_PA_SAMPLES", &dev->u.pa.in->buffer_length,
+        &dev->u.pa.in->has_buffer_length,
+        qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.in));
+    get_samples_to_usecs(
+        "QEMU_PA_SAMPLES", &dev->u.pa.out->buffer_length,
+        &dev->u.pa.out->has_buffer_length,
+        qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.out));
+
+    get_str("QEMU_PA_SERVER", &dev->u.pa.server, &dev->u.pa.has_server);
+}
+
 /* general */
 static void handle_per_direction(
     AudiodevPerDirectionOptions *pdo, const char *prefix)
@@ -304,6 +338,10 @@ static AudiodevListEntry *legacy_opt(const char *drvname)
         handle_oss(e->dev);
         break;
 
+    case AUDIODEV_DRIVER_PA:
+        handle_pa(e->dev);
+        break;
+
     default:
         break;
     }
diff --git a/audio/paaudio.c b/audio/paaudio.c
index d649c58e3d..5d410ed73f 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -2,6 +2,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "audio.h"
+#include "qapi/opts-visitor.h"
 
 #include <pulse/pulseaudio.h>
 
@@ -10,14 +11,7 @@
 #include "audio_pt_int.h"
 
 typedef struct {
-    int samples;
-    char *server;
-    char *sink;
-    char *source;
-} PAConf;
-
-typedef struct {
-    PAConf conf;
+    Audiodev *dev;
     pa_threaded_mainloop *mainloop;
     pa_context *context;
 } paaudio;
@@ -32,6 +26,7 @@ typedef struct {
     void *pcm_buf;
     struct audio_pt pt;
     paaudio *g;
+    int samples;
 } PAVoiceOut;
 
 typedef struct {
@@ -46,6 +41,7 @@ typedef struct {
     const void *read_data;
     size_t read_index, read_length;
     paaudio *g;
+    int samples;
 } PAVoiceIn;
 
 static void qpa_audio_fini(void *opaque);
@@ -227,7 +223,7 @@ static void *qpa_thread_out (void *arg)
             }
         }
 
-        decr = to_mix = audio_MIN(pa->live, pa->g->conf.samples >> 5);
+        decr = to_mix = audio_MIN(pa->live, pa->samples >> 5);
         rpos = pa->rpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -319,7 +315,7 @@ static void *qpa_thread_in (void *arg)
             }
         }
 
-        incr = to_grab = audio_MIN(pa->dead, pa->g->conf.samples >> 5);
+        incr = to_grab = audio_MIN(pa->dead, pa->samples >> 5);
         wpos = pa->wpos;
 
         if (audio_pt_unlock(&pa->pt, __func__)) {
@@ -546,6 +542,8 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     struct audsettings obt_as = *as;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     paaudio *g = pa->g = drv_opaque;
+    AudiodevPaOptions *popts = &g->dev->u.pa;
+    AudiodevPaPerDirectionOptions *ppdo = popts->out;
 
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
@@ -566,7 +564,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
         g,
         "qemu",
         PA_STREAM_PLAYBACK,
-        g->conf.sink,
+        ppdo->has_name ? ppdo->name : NULL,
         &ss,
         NULL,                   /* channel map */
         &ba,                    /* buffering attributes */
@@ -578,7 +576,8 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = g->conf.samples;
+    hw->samples = pa->samples = audio_buffer_samples(
+        qapi_AudiodevPaPerDirectionOptions_base(ppdo), &obt_as, 46440);
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->rpos = hw->rpos;
     if (!pa->pcm_buf) {
@@ -612,6 +611,8 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     struct audsettings obt_as = *as;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     paaudio *g = pa->g = drv_opaque;
+    AudiodevPaOptions *popts = &g->dev->u.pa;
+    AudiodevPaPerDirectionOptions *ppdo = popts->in;
 
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
@@ -623,7 +624,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
         g,
         "qemu",
         PA_STREAM_RECORD,
-        g->conf.source,
+        ppdo->has_name ? ppdo->name : NULL,
         &ss,
         NULL,                   /* channel map */
         NULL,                   /* buffering attributes */
@@ -635,7 +636,8 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     }
 
     audio_pcm_init_info (&hw->info, &obt_as);
-    hw->samples = g->conf.samples;
+    hw->samples = pa->samples = audio_buffer_samples(
+        qapi_AudiodevPaPerDirectionOptions_base(ppdo), &obt_as, 46440);
     pa->pcm_buf = audio_calloc(__func__, hw->samples, 1 << hw->info.shift);
     pa->wpos = hw->wpos;
     if (!pa->pcm_buf) {
@@ -808,13 +810,13 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
 }
 
 /* common */
-static PAConf glob_conf = {
-    .samples = 4096,
-};
-
 static void *qpa_audio_init(Audiodev *dev)
 {
-    if (glob_conf.server == NULL) {
+    paaudio *g;
+    AudiodevPaOptions *popts = &dev->u.pa;
+    const char *server;
+
+    if (!popts->has_server) {
         char pidfile[64];
         char *runtime;
         struct stat st;
@@ -829,8 +831,12 @@ static void *qpa_audio_init(Audiodev *dev)
         }
     }
 
-    paaudio *g = g_malloc(sizeof(paaudio));
-    g->conf = glob_conf;
+    assert(dev->driver == AUDIODEV_DRIVER_PA);
+
+    g = g_malloc(sizeof(paaudio));
+    server = popts->has_server ? popts->server : NULL;
+
+    g->dev = dev;
     g->mainloop = NULL;
     g->context = NULL;
 
@@ -840,14 +846,14 @@ static void *qpa_audio_init(Audiodev *dev)
     }
 
     g->context = pa_context_new (pa_threaded_mainloop_get_api (g->mainloop),
-                                 g->conf.server);
+                                 server);
     if (!g->context) {
         goto fail;
     }
 
     pa_context_set_state_callback (g->context, context_state_cb, g);
 
-    if (pa_context_connect (g->context, g->conf.server, 0, NULL) < 0) {
+    if (pa_context_connect(g->context, server, 0, NULL) < 0) {
         qpa_logerr (pa_context_errno (g->context),
                     "pa_context_connect() failed\n");
         goto fail;
@@ -910,34 +916,6 @@ static void qpa_audio_fini (void *opaque)
     g_free(g);
 }
 
-struct audio_option qpa_options[] = {
-    {
-        .name  = "SAMPLES",
-        .tag   = AUD_OPT_INT,
-        .valp  = &glob_conf.samples,
-        .descr = "buffer size in samples"
-    },
-    {
-        .name  = "SERVER",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.server,
-        .descr = "server address"
-    },
-    {
-        .name  = "SINK",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.sink,
-        .descr = "sink device name"
-    },
-    {
-        .name  = "SOURCE",
-        .tag   = AUD_OPT_STR,
-        .valp  = &glob_conf.source,
-        .descr = "source device name"
-    },
-    { /* End of list */ }
-};
-
 static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
@@ -955,7 +933,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
 static struct audio_driver pa_audio_driver = {
     .name           = "pa",
     .descr          = "http://www.pulseaudio.org/",
-    .options        = qpa_options,
     .init           = qpa_audio_init,
     .fini           = qpa_audio_fini,
     .pcm_ops        = &qpa_pcm_ops,
-- 
2.20.1
