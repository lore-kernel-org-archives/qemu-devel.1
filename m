Received: from eggs.gnu.org ([209.51.188.92]:58013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjuks-000475-5I
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gjukl-0002yM-FN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gjukk-0002ok-MX
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:37:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id a62so3880093wmh.4
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 15:37:43 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Thu, 17 Jan 2019 00:36:51 +0100
Message-Id: <2770bdbdff44ea3ca88ab30378a8eddbd7e2ef52.1547681517.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 18/50] audio: audiodev= parameters no longer
 optional when -audiodev present
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

This means you should probably stop using -soundhw (as it doesn't allow
you to specify any options) and add the device manually with -device.
The exception is pcspk, it's currently not possible to manually add it.
To use it with audiodev, use something like this:

    -audiodev id=foo,... -global isa-pcspk.audiodev=foo -soundhw pcspk

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c   |  24 ++--
 audio/paaudio.c | 304 ++++++++++++++++++++++++++++--------------------
 2 files changed, 190 insertions(+), 138 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 2f9f37afb8..f768a6059d 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -99,6 +99,8 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
+static bool legacy_config = true;
+
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
 #error No its not
 #else
@@ -1393,7 +1395,7 @@ static AudiodevListEntry *audiodev_find(
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, const char *name)
 {
     static bool atexit_registered;
     size_t i;
@@ -1407,12 +1409,13 @@ static AudioState *audio_init(Audiodev *dev)
 
     if (dev) {
         /* -audiodev option */
+        legacy_config = false;
         drvname = AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
-        /*
-         * todo: check for -audiodev once we have normal audiodev selection
-         * support
-         */
+        if (!legacy_config) {
+            dolog("You must specify an audiodev= for the device %s\n", name);
+            exit(1);
+        }
         return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
@@ -1518,7 +1521,7 @@ void audio_free_audiodev_list(AudiodevListHead *head)
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
-        card->state = audio_init(NULL);
+        card->state = audio_init(NULL, name);
     }
 
     card->name = g_strdup (name);
@@ -1544,8 +1547,11 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        /* todo: remove when we have normal audiodev selection support */
-        s = audio_init(NULL);
+        if (!legacy_config) {
+            dolog("You must specify audiodev when trying to capture\n");
+            goto err0;
+        }
+        s = audio_init(NULL, NULL);
     }
 
     if (audio_validate_settings (as)) {
@@ -1778,7 +1784,7 @@ void audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        audio_init(e->dev);
+        audio_init(e->dev, NULL);
     }
 }
 
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 33e0e5d9be..1c20f8a7aa 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -10,10 +10,21 @@
 #include "audio_int.h"
 #include "audio_pt_int.h"
 
-typedef struct {
-    Audiodev *dev;
+typedef struct PAConnection {
+    char *server;
+    int refcount;
+    QTAILQ_ENTRY(PAConnection) list;
+
     pa_threaded_mainloop *mainloop;
     pa_context *context;
+} PAConnection;
+
+static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
+    QTAILQ_HEAD_INITIALIZER(pa_conns);
+
+typedef struct {
+    Audiodev *dev;
+    PAConnection *conn;
 } paaudio;
 
 typedef struct {
@@ -44,7 +55,7 @@ typedef struct {
     int samples;
 } PAVoiceIn;
 
-static void qpa_audio_fini(void *opaque);
+static void qpa_conn_fini(PAConnection *c);
 
 static void GCC_FMT_ATTR (2, 3) qpa_logerr (int err, const char *fmt, ...)
 {
@@ -107,11 +118,11 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
 
 static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror)
 {
-    paaudio *g = p->g;
+    PAConnection *c = p->g->conn;
 
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
 
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
 
     while (length > 0) {
         size_t l;
@@ -120,11 +131,11 @@ static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror
             int r;
 
             r = pa_stream_peek (p->stream, &p->read_data, &p->read_length);
-            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
+            CHECK_SUCCESS_GOTO(c, rerror, r == 0, unlock_and_fail);
 
             if (!p->read_data) {
-                pa_threaded_mainloop_wait (g->mainloop);
-                CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+                pa_threaded_mainloop_wait(c->mainloop);
+                CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
             } else {
                 p->read_index = 0;
             }
@@ -147,53 +158,53 @@ static int qpa_simple_read (PAVoiceIn *p, void *data, size_t length, int *rerror
             p->read_length = 0;
             p->read_index = 0;
 
-            CHECK_SUCCESS_GOTO (g, rerror, r == 0, unlock_and_fail);
+            CHECK_SUCCESS_GOTO(c, rerror, r == 0, unlock_and_fail);
         }
     }
 
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return 0;
 
 unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return -1;
 }
 
 static int qpa_simple_write (PAVoiceOut *p, const void *data, size_t length, int *rerror)
 {
-    paaudio *g = p->g;
+    PAConnection *c = p->g->conn;
 
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
 
-    CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+    CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
 
     while (length > 0) {
         size_t l;
         int r;
 
         while (!(l = pa_stream_writable_size (p->stream))) {
-            pa_threaded_mainloop_wait (g->mainloop);
-            CHECK_DEAD_GOTO (g, p->stream, rerror, unlock_and_fail);
+            pa_threaded_mainloop_wait(c->mainloop);
+            CHECK_DEAD_GOTO(c, p->stream, rerror, unlock_and_fail);
         }
 
-        CHECK_SUCCESS_GOTO (g, rerror, l != (size_t) -1, unlock_and_fail);
+        CHECK_SUCCESS_GOTO(c, rerror, l != (size_t) -1, unlock_and_fail);
 
         if (l > length) {
             l = length;
         }
 
         r = pa_stream_write (p->stream, data, l, NULL, 0LL, PA_SEEK_RELATIVE);
-        CHECK_SUCCESS_GOTO (g, rerror, r >= 0, unlock_and_fail);
+        CHECK_SUCCESS_GOTO(c, rerror, r >= 0, unlock_and_fail);
 
         data = (const uint8_t *) data + l;
         length -= l;
     }
 
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return 0;
 
 unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
     return -1;
 }
 
@@ -431,13 +442,13 @@ static AudioFormat pa_to_audfmt (pa_sample_format_t fmt, int *endianness)
 
 static void context_state_cb (pa_context *c, void *userdata)
 {
-    paaudio *g = userdata;
+    PAConnection *conn = userdata;
 
     switch (pa_context_get_state(c)) {
     case PA_CONTEXT_READY:
     case PA_CONTEXT_TERMINATED:
     case PA_CONTEXT_FAILED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
+        pa_threaded_mainloop_signal(conn->mainloop, 0);
         break;
 
     case PA_CONTEXT_UNCONNECTED:
@@ -450,14 +461,14 @@ static void context_state_cb (pa_context *c, void *userdata)
 
 static void stream_state_cb (pa_stream *s, void * userdata)
 {
-    paaudio *g = userdata;
+    PAConnection *c = userdata;
 
     switch (pa_stream_get_state (s)) {
 
     case PA_STREAM_READY:
     case PA_STREAM_FAILED:
     case PA_STREAM_TERMINATED:
-        pa_threaded_mainloop_signal (g->mainloop, 0);
+        pa_threaded_mainloop_signal(c->mainloop, 0);
         break;
 
     case PA_STREAM_UNCONNECTED:
@@ -468,13 +479,13 @@ static void stream_state_cb (pa_stream *s, void * userdata)
 
 static void stream_request_cb (pa_stream *s, size_t length, void *userdata)
 {
-    paaudio *g = userdata;
+    PAConnection *c = userdata;
 
-    pa_threaded_mainloop_signal (g->mainloop, 0);
+    pa_threaded_mainloop_signal(c->mainloop, 0);
 }
 
 static pa_stream *qpa_simple_new (
-        paaudio *g,
+        PAConnection *c,
         const char *name,
         pa_stream_direction_t dir,
         const char *dev,
@@ -485,50 +496,48 @@ static pa_stream *qpa_simple_new (
 {
     int r;
     pa_stream *stream;
+    pa_stream_flags_t flags;
 
-    pa_threaded_mainloop_lock (g->mainloop);
+    pa_threaded_mainloop_lock(c->mainloop);
 
-    stream = pa_stream_new (g->context, name, ss, map);
+    stream = pa_stream_new(c->context, name, ss, map);
     if (!stream) {
         goto fail;
     }
 
-    pa_stream_set_state_callback (stream, stream_state_cb, g);
-    pa_stream_set_read_callback (stream, stream_request_cb, g);
-    pa_stream_set_write_callback (stream, stream_request_cb, g);
+    pa_stream_set_state_callback(stream, stream_state_cb, c);
+    pa_stream_set_read_callback(stream, stream_request_cb, c);
+    pa_stream_set_write_callback(stream, stream_request_cb, c);
+
+    flags =
+        PA_STREAM_INTERPOLATE_TIMING
+#ifdef PA_STREAM_ADJUST_LATENCY
+        |PA_STREAM_ADJUST_LATENCY
+#endif
+        |PA_STREAM_AUTO_TIMING_UPDATE;
 
     if (dir == PA_STREAM_PLAYBACK) {
-        r = pa_stream_connect_playback (stream, dev, attr,
-                                        PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                        |PA_STREAM_ADJUST_LATENCY
-#endif
-                                        |PA_STREAM_AUTO_TIMING_UPDATE, NULL, NULL);
+        r = pa_stream_connect_playback(stream, dev, attr, flags, NULL, NULL);
     } else {
-        r = pa_stream_connect_record (stream, dev, attr,
-                                      PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-                                      |PA_STREAM_ADJUST_LATENCY
-#endif
-                                      |PA_STREAM_AUTO_TIMING_UPDATE);
+        r = pa_stream_connect_record(stream, dev, attr, flags);
     }
 
     if (r < 0) {
       goto fail;
     }
 
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
 
     return stream;
 
 fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
+    pa_threaded_mainloop_unlock(c->mainloop);
 
     if (stream) {
         pa_stream_unref (stream);
     }
 
-    *rerror = pa_context_errno (g->context);
+    *rerror = pa_context_errno(c->context);
 
     return NULL;
 }
@@ -544,6 +553,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     paaudio *g = pa->g = drv_opaque;
     AudiodevPaOptions *popts = &g->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo = popts->sink;
+    PAConnection *c = g->conn;
 
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
@@ -561,7 +571,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
     obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
 
     pa->stream = qpa_simple_new (
-        g,
+        c,
         "qemu",
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
@@ -613,6 +623,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     paaudio *g = pa->g = drv_opaque;
     AudiodevPaOptions *popts = &g->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo = popts->source;
+    PAConnection *c = g->conn;
 
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
@@ -621,7 +632,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     obt_as.fmt = pa_to_audfmt (ss.format, &obt_as.endianness);
 
     pa->stream = qpa_simple_new (
-        g,
+        c,
         "qemu",
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
@@ -709,7 +720,7 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
     PAVoiceOut *pa = (PAVoiceOut *) hw;
     pa_operation *op;
     pa_cvolume v;
-    paaudio *g = pa->g;
+    PAConnection *c = pa->g->conn;
 
 #ifdef PA_CHECK_VERSION    /* macro is present in 0.9.16+ */
     pa_cvolume_init (&v);  /* function is present in 0.9.13+ */
@@ -729,28 +740,28 @@ static int qpa_ctl_out (HWVoiceOut *hw, int cmd, ...)
             v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
             v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
 
-            pa_threaded_mainloop_lock (g->mainloop);
+            pa_threaded_mainloop_lock(c->mainloop);
 
-            op = pa_context_set_sink_input_volume (g->context,
+            op = pa_context_set_sink_input_volume(c->context,
                 pa_stream_get_index (pa->stream),
                 &v, NULL, NULL);
             if (!op)
-                qpa_logerr (pa_context_errno (g->context),
+                qpa_logerr (pa_context_errno(c->context),
                             "set_sink_input_volume() failed\n");
             else
                 pa_operation_unref (op);
 
-            op = pa_context_set_sink_input_mute (g->context,
+            op = pa_context_set_sink_input_mute(c->context,
                 pa_stream_get_index (pa->stream),
                sw->vol.mute, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
+                qpa_logerr (pa_context_errno(c->context),
                             "set_sink_input_mute() failed\n");
             } else {
                 pa_operation_unref (op);
             }
 
-            pa_threaded_mainloop_unlock (g->mainloop);
+            pa_threaded_mainloop_unlock(c->mainloop);
         }
     }
     return 0;
@@ -761,7 +772,7 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
     PAVoiceIn *pa = (PAVoiceIn *) hw;
     pa_operation *op;
     pa_cvolume v;
-    paaudio *g = pa->g;
+    PAConnection *c = pa->g->conn;
 
 #ifdef PA_CHECK_VERSION
     pa_cvolume_init (&v);
@@ -781,35 +792,96 @@ static int qpa_ctl_in (HWVoiceIn *hw, int cmd, ...)
             v.values[0] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.l) / UINT32_MAX;
             v.values[1] = ((PA_VOLUME_NORM - PA_VOLUME_MUTED) * sw->vol.r) / UINT32_MAX;
 
-            pa_threaded_mainloop_lock (g->mainloop);
+            pa_threaded_mainloop_lock(c->mainloop);
 
-            op = pa_context_set_source_output_volume (g->context,
-                pa_stream_get_index (pa->stream),
+            op = pa_context_set_source_output_volume(c->context,
+                pa_stream_get_index(pa->stream),
                 &v, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_source_output_volume() failed\n");
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_source_output_volume() failed\n");
             } else {
                 pa_operation_unref(op);
             }
 
-            op = pa_context_set_source_output_mute (g->context,
+            op = pa_context_set_source_output_mute(c->context,
                 pa_stream_get_index (pa->stream),
                 sw->vol.mute, NULL, NULL);
             if (!op) {
-                qpa_logerr (pa_context_errno (g->context),
-                            "set_source_output_mute() failed\n");
+                qpa_logerr(pa_context_errno(c->context),
+                           "set_source_output_mute() failed\n");
             } else {
                 pa_operation_unref (op);
             }
 
-            pa_threaded_mainloop_unlock (g->mainloop);
+            pa_threaded_mainloop_unlock(c->mainloop);
         }
     }
     return 0;
 }
 
 /* common */
+static void *qpa_conn_init(const char *server)
+{
+    PAConnection *c = g_malloc0(sizeof(PAConnection));
+    QTAILQ_INSERT_TAIL(&pa_conns, c, list);
+
+    c->mainloop = pa_threaded_mainloop_new();
+    if (!c->mainloop) {
+        goto fail;
+    }
+
+    c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
+                                server);
+    if (!c->context) {
+        goto fail;
+    }
+
+    pa_context_set_state_callback(c->context, context_state_cb, c);
+
+    if (pa_context_connect(c->context, server, 0, NULL) < 0) {
+        qpa_logerr(pa_context_errno(c->context),
+                   "pa_context_connect() failed\n");
+        goto fail;
+    }
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    if (pa_threaded_mainloop_start(c->mainloop) < 0) {
+        goto unlock_and_fail;
+    }
+
+    for (;;) {
+        pa_context_state_t state;
+
+        state = pa_context_get_state(c->context);
+
+        if (state == PA_CONTEXT_READY) {
+            break;
+        }
+
+        if (!PA_CONTEXT_IS_GOOD (state)) {
+            qpa_logerr(pa_context_errno(c->context),
+                       "Wrong context state\n");
+            goto unlock_and_fail;
+        }
+
+        /* Wait until the context is ready */
+        pa_threaded_mainloop_wait(c->mainloop);
+    }
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return c;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+fail:
+    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
+    qpa_conn_fini(c);
+    return NULL;
+}
+
+
 static void qpa_init_per_direction(AudiodevPaPerDirectionOptions **ppdo,
                                    bool *has_ppdo)
 {
@@ -824,91 +896,65 @@ static void *qpa_audio_init(Audiodev *dev)
     paaudio *g;
     AudiodevPaOptions *popts;
     const char *server;
+    PAConnection *c;
 
     assert(dev->driver == AUDIODEV_DRIVER_PA);
 
     qpa_init_per_direction(&dev->u.pa.sink, &dev->u.pa.has_sink);
     qpa_init_per_direction(&dev->u.pa.source, &dev->u.pa.has_source);
 
-    g = g_malloc(sizeof(paaudio));
+    g = g_malloc0(sizeof(paaudio));
     popts = &dev->u.pa;
     server = popts->has_server ? popts->server : NULL;
 
     g->dev = dev;
-    g->mainloop = NULL;
-    g->context = NULL;
 
-    g->mainloop = pa_threaded_mainloop_new ();
-    if (!g->mainloop) {
-        goto fail;
-    }
-
-    g->context = pa_context_new (pa_threaded_mainloop_get_api (g->mainloop),
-                                 server);
-    if (!g->context) {
-        goto fail;
-    }
-
-    pa_context_set_state_callback (g->context, context_state_cb, g);
-
-    if (pa_context_connect (g->context, server, 0, NULL) < 0) {
-        qpa_logerr (pa_context_errno (g->context),
-                    "pa_context_connect() failed\n");
-        goto fail;
-    }
-
-    pa_threaded_mainloop_lock (g->mainloop);
-
-    if (pa_threaded_mainloop_start (g->mainloop) < 0) {
-        goto unlock_and_fail;
-    }
-
-    for (;;) {
-        pa_context_state_t state;
-
-        state = pa_context_get_state (g->context);
-
-        if (state == PA_CONTEXT_READY) {
+    QTAILQ_FOREACH(c, &pa_conns, list) {
+        if (server == NULL || c->server == NULL ?
+            server == c->server :
+            strcmp(server, c->server) == 0) {
+            g->conn = c;
             break;
         }
-
-        if (!PA_CONTEXT_IS_GOOD (state)) {
-            qpa_logerr (pa_context_errno (g->context),
-                        "Wrong context state\n");
-            goto unlock_and_fail;
-        }
-
-        /* Wait until the context is ready */
-        pa_threaded_mainloop_wait (g->mainloop);
+    }
+    if (!g->conn) {
+        g->conn = qpa_conn_init(server);
+    }
+    if (!g->conn) {
+        g_free(g);
+        return NULL;
     }
 
-    pa_threaded_mainloop_unlock (g->mainloop);
-
+    ++g->conn->refcount;
     return g;
+}
 
-unlock_and_fail:
-    pa_threaded_mainloop_unlock (g->mainloop);
-fail:
-    AUD_log (AUDIO_CAP, "Failed to initialize PA context");
-    qpa_audio_fini(g);
-    return NULL;
+static void qpa_conn_fini(PAConnection *c)
+{
+    if (c->mainloop) {
+        pa_threaded_mainloop_stop(c->mainloop);
+    }
+
+    if (c->context) {
+        pa_context_disconnect(c->context);
+        pa_context_unref(c->context);
+    }
+
+    if (c->mainloop) {
+        pa_threaded_mainloop_free(c->mainloop);
+    }
+
+    QTAILQ_REMOVE(&pa_conns, c, list);
+    g_free(c);
 }
 
 static void qpa_audio_fini (void *opaque)
 {
     paaudio *g = opaque;
+    PAConnection *c = g->conn;
 
-    if (g->mainloop) {
-        pa_threaded_mainloop_stop (g->mainloop);
-    }
-
-    if (g->context) {
-        pa_context_disconnect (g->context);
-        pa_context_unref (g->context);
-    }
-
-    if (g->mainloop) {
-        pa_threaded_mainloop_free (g->mainloop);
+    if (--c->refcount == 0) {
+        qpa_conn_fini(c);
     }
 
     g_free(g);
-- 
2.20.1
