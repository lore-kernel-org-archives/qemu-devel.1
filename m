Received: from eggs.gnu.org ([208.118.235.92]:52291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjx-0007lQ-RE
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjv-0002Lr-Iq
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjv-0002IU-72
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:47 -0500
Received: by mail-wm1-x32e.google.com with SMTP id c126so10408927wmh.0
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:47 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:54 +0100
Message-Id: <899034ec66d2d4b9a2302d874482b727d7eb92e4.1545598229.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/52] audio: basic support for multi
 backend audio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Audio functions no longer access glob_audio_state, instead they get an
AudioState as a parameter.  This is required in order to support
multiple backends.

glob_audio_state is also gone, and replaced with a tailq so we can store
more than one states.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/audio.c          | 105 +++++++++++++++++++++++++++++++----------
 audio/audio.h          |  12 +++--
 audio/audio_int.h      |   2 +
 audio/audio_template.h |   2 +-
 audio/wavcapture.c     |   6 +--
 hmp-commands.hx        |  11 +++--
 monitor.c              |  12 ++++-
 qemu-options.hx        |   5 ++
 ui/vnc.c               |  15 +++++-
 ui/vnc.h               |   2 +
 10 files changed, 133 insertions(+), 39 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 461aea7a01..92fa170b46 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -86,7 +86,8 @@ audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
 
-static AudioState glob_audio_state;
+static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =
+    QTAILQ_HEAD_INITIALIZER(audio_states);
 
 const struct mixeng_volume nominal_volume = {
     .mute = 0,
@@ -1240,11 +1241,14 @@ static void audio_run_capture (AudioState *s)
 
 void audio_run (const char *msg)
 {
-    AudioState *s = &glob_audio_state;
+    AudioState *s;
+
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        audio_run_out (s);
+        audio_run_in (s);
+        audio_run_capture (s);
+    }
 
-    audio_run_out (s);
-    audio_run_in (s);
-    audio_run_capture (s);
 #ifdef DEBUG_POLL
     {
         static double prevtime;
@@ -1306,13 +1310,11 @@ bool audio_is_cleaning_up(void)
     return is_cleaning_up;
 }
 
-void audio_cleanup(void)
+static void free_audio_state(AudioState *s)
 {
-    AudioState *s = &glob_audio_state;
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
-    is_cleaning_up = true;
     QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
         SWVoiceCap *sc;
 
@@ -1349,6 +1351,17 @@ void audio_cleanup(void)
         qapi_free_Audiodev(s->dev);
         s->dev = NULL;
     }
+    g_free(s);
+}
+
+void audio_cleanup(void)
+{
+    is_cleaning_up = true;
+    while (!QTAILQ_EMPTY(&audio_states)) {
+        AudioState *s = QTAILQ_FIRST(&audio_states);
+        QTAILQ_REMOVE(&audio_states, s, list);
+        free_audio_state(s);
+    }
 }
 
 static const VMStateDescription vmstate_audio = {
@@ -1361,28 +1374,34 @@ static const VMStateDescription vmstate_audio = {
 };
 
 static Audiodev *parse_option(QemuOpts *opts, Error **errp);
-static int audio_init(Audiodev *dev)
+
+/*
+ * if we have dev, this function was called because of an -audiodev argument =>
+ *   initialize a new state with it
+ * if dev == NULL => legacy implicit initialization, return the already created
+ *   state or create a new one
+ */
+static AudioState *audio_init(Audiodev *dev)
 {
+    static bool atexit_registered;
     size_t i;
     int done = 0;
     const char *drvname = NULL;
     VMChangeStateEntry *e;
-    AudioState *s = &glob_audio_state;
+    AudioState *s;
     struct audio_driver *driver;
     /* silence gcc warning about uninitialized variable */
     QemuOptsList *list = NULL;
 
-    if (s->drv) {
-        if (dev) {
-            dolog("Cannot create more than one audio backend, sorry\n");
-            qapi_free_Audiodev(dev);
-        }
-        return -1;
-    }
-
     if (dev) {
         /* -audiodev option */
         drvname = AudiodevDriver_str(dev->driver);
+    } else if (!QTAILQ_EMPTY(&audio_states)) {
+        /*
+         * todo: check for -audiodev once we have normal audiodev selection
+         * support
+         */
+        return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
         audio_handle_legacy_opts();
@@ -1392,12 +1411,18 @@ static int audio_init(Audiodev *dev)
             exit(1);
         }
     }
+
+    s = g_malloc0(sizeof(AudioState));
     s->dev = dev;
 
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
-    atexit(audio_cleanup);
+    if (!atexit_registered) {
+        atexit(audio_cleanup);
+        atexit_registered = true;
+    }
+    QTAILQ_INSERT_TAIL(&audio_states, s, list);
 
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
@@ -1466,15 +1491,18 @@ static int audio_init(Audiodev *dev)
 
     QLIST_INIT (&s->card_head);
     vmstate_register (NULL, 0, &vmstate_audio, s);
-    return 0;
+    return s;
 }
 
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
-    audio_init(NULL);
+    if (!card->state) {
+        card->state = audio_init(NULL);
+    }
+
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
-    QLIST_INSERT_HEAD (&glob_audio_state.card_head, card, entries);
+    QLIST_INSERT_HEAD (&card->state->card_head, card, entries);
 }
 
 void AUD_remove_card (QEMUSoundCard *card)
@@ -1484,16 +1512,21 @@ void AUD_remove_card (QEMUSoundCard *card)
 }
 
 
-CaptureVoiceOut *AUD_add_capture (
+CaptureVoiceOut *AUD_add_capture(
+    AudioState *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *cb_opaque
     )
 {
-    AudioState *s = &glob_audio_state;
     CaptureVoiceOut *cap;
     struct capture_callback *cb;
 
+    if (!s) {
+        /* todo: remove when we have normal audiodev selection support */
+        s = audio_init(NULL);
+    }
+
     if (audio_validate_settings (as)) {
         dolog ("Invalid settings were passed when trying to add capture\n");
         audio_print_settings (as);
@@ -1730,7 +1763,7 @@ static int each_option(void *opaque, QemuOpts *opts, Error **errp)
     if (!dev) {
         return -1;
     }
-    return audio_init(dev);
+    return audio_init(dev) ? 0 : -1;
 }
 
 void audio_set_options(void)
@@ -1798,3 +1831,25 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
     return audio_buffer_samples(pdo, as, def_usecs) *
         audioformat_bytes_per_sample(as->fmt);
 }
+
+AudioState *audio_state_by_name(const char *name)
+{
+    AudioState *s;
+    QTAILQ_FOREACH(s, &audio_states, list) {
+        assert(s->dev);
+        if (strcmp(name, s->dev->id) == 0) {
+            return s;
+        }
+    }
+    return NULL;
+}
+
+const char *audio_get_id(QEMUSoundCard *card)
+{
+    if (card->state) {
+        assert(card->state->dev);
+        return card->state->dev->id;
+    } else {
+        return "";
+    }
+}
diff --git a/audio/audio.h b/audio/audio.h
index 7df1b8b249..5e0dcdb93e 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -78,8 +78,10 @@ typedef struct SWVoiceOut SWVoiceOut;
 typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
+typedef struct AudioState AudioState;
 typedef struct QEMUSoundCard {
     char *name;
+    AudioState *state;
     QLIST_ENTRY (QEMUSoundCard) entries;
 } QEMUSoundCard;
 
@@ -94,7 +96,8 @@ void AUD_log (const char *cap, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 void AUD_register_card (const char *name, QEMUSoundCard *card);
 void AUD_remove_card (QEMUSoundCard *card);
-CaptureVoiceOut *AUD_add_capture (
+CaptureVoiceOut *AUD_add_capture(
+    AudioState *s,
     struct audsettings *as,
     struct audio_capture_ops *ops,
     void *opaque
@@ -162,8 +165,8 @@ static inline void *advance (void *p, int incr)
 #define audio_MAX(a, b) ((a)<(b)?(b):(a))
 #endif
 
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels);
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels);
 
 bool audio_is_cleaning_up(void);
 void audio_cleanup(void);
@@ -177,4 +180,7 @@ void audio_set_options(void);
 void audio_handle_legacy_opts(void);
 void audio_legacy_help(void);
 
+AudioState *audio_state_by_name(const char *name);
+const char *audio_get_id(QEMUSoundCard *card);
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 792ec3152a..9d9db8c270 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -195,6 +195,8 @@ struct AudioState {
 
     bool timer_running;
     uint64_t timer_last;
+
+    QTAILQ_ENTRY(AudioState) list;
 };
 
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index ccf6d810f7..ce1e5d6559 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -399,7 +399,7 @@ SW *glue (AUD_open_, TYPE) (
     struct audsettings *as
     )
 {
-    AudioState *s = &glob_audio_state;
+    AudioState *s = card->state;
     AudiodevPerDirectionOptions *pdo = s->dev->TYPE;
 
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index e943565210..88d3141be5 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -107,8 +107,8 @@ static struct capture_ops wav_capture_ops = {
     .info = wav_capture_info
 };
 
-int wav_start_capture (CaptureState *s, const char *path, int freq,
-                       int bits, int nchannels)
+int wav_start_capture(AudioState *state, CaptureState *s, const char *path,
+                      int freq, int bits, int nchannels)
 {
     Monitor *mon = cur_mon;
     WAVState *wav;
@@ -175,7 +175,7 @@ int wav_start_capture (CaptureState *s, const char *path, int freq,
         goto error_free;
     }
 
-    cap = AUD_add_capture (&as, &ops, wav);
+    cap = AUD_add_capture(state, &as, &ops, wav);
     if (!cap) {
         monitor_printf (mon, "Failed to add audio capture\n");
         goto error_free;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ba71558c25..dc339a5484 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -796,16 +796,17 @@ ETEXI
 
     {
         .name       = "wavcapture",
-        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
-        .params     = "path [frequency [bits [channels]]]",
+        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?,audiodev:s?",
+        .params     = "path [frequency [bits [channels [audiodev]]]]",
         .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
         .cmd        = hmp_wavcapture,
     },
 STEXI
-@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
+@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels} [@var{audiodev}]]]]
 @findex wavcapture
-Capture audio into @var{filename}. Using sample rate @var{frequency}
-bits per sample @var{bits} and number of channels @var{channels}.
+Capture audio into @var{filename} from @var{audiodev}. Using sample rate
+@var{frequency} bits per sample @var{bits} and number of channels
+@var{channels}.
 
 Defaults:
 @itemize @minus
diff --git a/monitor.c b/monitor.c
index 0ad54d8b11..14e130308f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2038,7 +2038,17 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     int bits = qdict_get_try_int(qdict, "bits", -1);
     int has_channels = qdict_haskey(qdict, "nchannels");
     int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
+    const char *audiodev = qdict_get_try_str(qdict, "audiodev");
     CaptureState *s;
+    AudioState *as = NULL;
+
+    if (audiodev) {
+        as = audio_state_by_name(audiodev);
+        if (!as) {
+            monitor_printf(mon, "Invalid audiodev specified\n");
+            return;
+        }
+    }
 
     s = g_malloc0 (sizeof (*s));
 
@@ -2046,7 +2056,7 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     bits = has_bits ? bits : 16;
     nchannels = has_channels ? nchannels : 2;
 
-    if (wav_start_capture (s, path, freq, bits, nchannels)) {
+    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
         monitor_printf(mon, "Failed to add wave capture\n");
         g_free (s);
         return;
diff --git a/qemu-options.hx b/qemu-options.hx
index 3ede6a591d..687dd23bf2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1911,6 +1911,11 @@ can help the device and guest to keep up and not lose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
 
+@item audiodev=@var{audiodev}
+
+Use the specified @var{audiodev} when the VNC client requests audio
+transmission.
+
 @end table
 ETEXI
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 0e9e9fb63a..c64ca10de9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1195,7 +1195,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(&vs->as, &ops, vs);
+    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -3390,6 +3390,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "non-adaptive",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "audiodev",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -3825,6 +3828,7 @@ void vnc_display_open(const char *id, Error **errp)
     int acl = 0;
     int lock_key_sync = 1;
     int key_delay_ms;
+    const char *audiodev;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3978,6 +3982,15 @@ void vnc_display_open(const char *id, Error **errp)
     vd->ledstate = 0;
     vd->key_delay_ms = key_delay_ms;
 
+    audiodev = qemu_opt_get(opts, "audiodev");
+    if (audiodev) {
+        vd->audio_state = audio_state_by_name(audiodev);
+        if (!vd->audio_state) {
+            error_setg(errp, "Audiodev '%s' not found", audiodev);
+            goto fail;
+        }
+    }
+
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
         int head = qemu_opt_get_number(opts, "head", 0);
diff --git a/ui/vnc.h b/ui/vnc.h
index a86e0610e8..0c9a2d82e0 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -181,6 +181,8 @@ struct VncDisplay
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
+
+    AudioState *audio_state;
 };
 
 typedef struct VncTight {
-- 
2.20.1
