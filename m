Received: from eggs.gnu.org ([209.51.188.92]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFdH-0007wX-Pl
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd6-0003PM-S0
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFd6-0003Nh-9i
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so19945635wrt.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:44 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:27 +0100
Message-Id: <c0642d4f64a82bf2c04c8b52095d11cf9263b5ad.1548714862.git.DirtY.iCE.hu@gmail.com>
In-Reply-To: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 04/14] audio: -audiodev command line option
 basic implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Audio drivers now get an Audiodev * as config paramters, instead of the
global audio_option structs.  There is some code in audio/audio_legacy.c
that converts the old environment variables to audiodev options (this
way backends do not have to worry about legacy options).  It also
contains a replacement of -audio-help, which prints out the equivalent
-audiodev based config of the currently specified environment variables.

Note that backends are not updated and still rely on environment
variables.

Also note that (due to moving try-poll from global to backend specific
option) currently ALSA and OSS will always try poll mode, regardless of
environment variables or -audiodev options.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v2:
    
    * MAJOR: use qobject_input_visitor instead of QemuOpts
    * almost completely rewrote legacy options handling
    * added missing license comment to audio_legacy.c0

 audio/audio.h          |  18 +-
 audio/audio_int.h      |  16 +-
 audio/audio_template.h |  13 +-
 audio/alsaaudio.c      |   2 +-
 audio/audio.c          | 601 ++++++++++++++++-------------------------
 audio/audio_legacy.c   | 295 ++++++++++++++++++++
 audio/coreaudio.c      |   2 +-
 audio/dsoundaudio.c    |   2 +-
 audio/noaudio.c        |   2 +-
 audio/ossaudio.c       |   2 +-
 audio/paaudio.c        |   2 +-
 audio/sdlaudio.c       |   2 +-
 audio/spiceaudio.c     |   2 +-
 audio/wavaudio.c       |   2 +-
 vl.c                   |   7 +-
 audio/Makefile.objs    |   2 +-
 16 files changed, 590 insertions(+), 380 deletions(-)
 create mode 100644 audio/audio_legacy.c

diff --git a/audio/audio.h b/audio/audio.h
index 02f29a3b3e..64b0f761bc 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -36,12 +36,21 @@ typedef void (*audio_callback_fn) (void *opaque, int avail);
 #define AUDIO_HOST_ENDIANNESS 0
 #endif
 
-struct audsettings {
+typedef struct audsettings {
     int freq;
     int nchannels;
     AudioFormat fmt;
     int endianness;
-};
+} audsettings;
+
+audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo);
+int audioformat_bytes_per_sample(AudioFormat fmt);
+int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
+                        audsettings *as, int def_usecs);
+int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
+                         audsettings *as, int def_usecs);
+int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
+                       audsettings *as, int def_usecs);
 
 typedef enum {
     AUD_CNOTIFY_ENABLE,
@@ -81,7 +90,6 @@ typedef struct QEMUAudioTimeStamp {
 void AUD_vlog (const char *cap, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
 void AUD_log (const char *cap, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
-void AUD_help (void);
 void AUD_register_card (const char *name, QEMUSoundCard *card);
 void AUD_remove_card (QEMUSoundCard *card);
 CaptureVoiceOut *AUD_add_capture (
@@ -163,4 +171,8 @@ void audio_sample_to_uint64(void *samples, int pos,
 void audio_sample_from_uint64(void *samples, int pos,
                             uint64_t left, uint64_t right);
 
+void audio_parse_option(const char *opt);
+void audio_init_audiodevs(void);
+void audio_legacy_help(void);
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 6c451b995c..cee46c4809 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -146,7 +146,7 @@ struct audio_driver {
     const char *name;
     const char *descr;
     struct audio_option *options;
-    void *(*init) (void);
+    void *(*init) (Audiodev *);
     void (*fini) (void *);
     struct audio_pcm_ops *pcm_ops;
     int can_be_default;
@@ -193,6 +193,7 @@ struct SWVoiceCap {
 
 typedef struct AudioState {
     struct audio_driver *drv;
+    Audiodev *dev;
     void *drv_opaque;
 
     QEMUTimer *ts;
@@ -203,10 +204,13 @@ typedef struct AudioState {
     int nb_hw_voices_out;
     int nb_hw_voices_in;
     int vm_running;
+    int64_t period_ticks;
 } AudioState;
 
 extern const struct mixeng_volume nominal_volume;
 
+extern const char *audio_prio_list[];
+
 void audio_driver_register(audio_driver *drv);
 audio_driver *audio_driver_lookup(const char *name);
 
@@ -248,4 +252,14 @@ static inline int audio_ring_dist (int dst, int src, int len)
 #define AUDIO_STRINGIFY_(n) #n
 #define AUDIO_STRINGIFY(n) AUDIO_STRINGIFY_(n)
 
+typedef struct AudiodevListEntry {
+    Audiodev *dev;
+    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
+} AudiodevListEntry;
+
+typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
+AudiodevListHead audio_handle_legacy_opts(void);
+
+void audio_free_audiodev_list(AudiodevListHead *head);
+
 #endif /* QEMU_AUDIO_INT_H */
diff --git a/audio/audio_template.h b/audio/audio_template.h
index 7de227d2d1..c1d7207abd 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -302,8 +302,10 @@ static HW *glue (audio_pcm_hw_add_new_, TYPE) (struct audsettings *as)
 static HW *glue (audio_pcm_hw_add_, TYPE) (struct audsettings *as)
 {
     HW *hw;
+    AudioState *s = &glob_audio_state;
+    AudiodevPerDirectionOptions *pdo = s->dev->TYPE;
 
-    if (glue (conf.fixed_, TYPE).enabled && glue (conf.fixed_, TYPE).greedy) {
+    if (pdo->fixed_settings) {
         hw = glue (audio_pcm_hw_add_new_, TYPE) (as);
         if (hw) {
             return hw;
@@ -331,9 +333,11 @@ static SW *glue (audio_pcm_create_voice_pair_, TYPE) (
     SW *sw;
     HW *hw;
     struct audsettings hw_as;
+    AudioState *s = &glob_audio_state;
+    AudiodevPerDirectionOptions *pdo = s->dev->TYPE;
 
-    if (glue (conf.fixed_, TYPE).enabled) {
-        hw_as = glue (conf.fixed_, TYPE).settings;
+    if (pdo->fixed_settings) {
+        hw_as = audiodev_to_audsettings(pdo);
     }
     else {
         hw_as = *as;
@@ -398,6 +402,7 @@ SW *glue (AUD_open_, TYPE) (
     )
 {
     AudioState *s = &glob_audio_state;
+    AudiodevPerDirectionOptions *pdo = s->dev->TYPE;
 
     if (audio_bug(__func__, !card || !name || !callback_fn || !as)) {
         dolog ("card=%p name=%p callback_fn=%p as=%p\n",
@@ -422,7 +427,7 @@ SW *glue (AUD_open_, TYPE) (
         return sw;
     }
 
-    if (!glue (conf.fixed_, TYPE).enabled && sw) {
+    if (!pdo->fixed_settings && sw) {
         glue (AUD_close_, TYPE) (card, sw);
         sw = NULL;
     }
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 5bd034267f..8302f3e882 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1125,7 +1125,7 @@ static ALSAConf glob_conf = {
     .pcm_name_in = "default",
 };
 
-static void *alsa_audio_init (void)
+static void *alsa_audio_init(Audiodev *dev)
 {
     ALSAConf *conf = g_malloc(sizeof(ALSAConf));
     *conf = glob_conf;
diff --git a/audio/audio.c b/audio/audio.c
index ce8e6ea8c2..b37c245a8a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -26,6 +26,9 @@
 #include "audio.h"
 #include "monitor/monitor.h"
 #include "qemu/timer.h"
+#include "qapi/error.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-audio.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
@@ -46,14 +49,16 @@
    The 1st one is the one used by default, that is the reason
     that we generate the list.
 */
-static const char *audio_prio_list[] = {
+const char *audio_prio_list[] = {
     "spice",
     CONFIG_AUDIO_DRIVERS
     "none",
     "wav",
+    NULL
 };
 
 static QLIST_HEAD(, audio_driver) audio_drivers;
+static AudiodevListHead audiodevs = QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
 
 void audio_driver_register(audio_driver *drv)
 {
@@ -80,61 +85,6 @@ audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
 
-static void audio_module_load_all(void)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(audio_prio_list); i++) {
-        audio_driver_lookup(audio_prio_list[i]);
-    }
-}
-
-struct fixed_settings {
-    int enabled;
-    int nb_voices;
-    int greedy;
-    struct audsettings settings;
-};
-
-static struct {
-    struct fixed_settings fixed_out;
-    struct fixed_settings fixed_in;
-    union {
-        int hertz;
-        int64_t ticks;
-    } period;
-    int try_poll_in;
-    int try_poll_out;
-} conf = {
-    .fixed_out = { /* DAC fixed settings */
-        .enabled = 1,
-        .nb_voices = 1,
-        .greedy = 1,
-        .settings = {
-            .freq = 44100,
-            .nchannels = 2,
-            .fmt = AUDIO_FORMAT_S16,
-            .endianness =  AUDIO_HOST_ENDIANNESS,
-        }
-    },
-
-    .fixed_in = { /* ADC fixed settings */
-        .enabled = 1,
-        .nb_voices = 1,
-        .greedy = 1,
-        .settings = {
-            .freq = 44100,
-            .nchannels = 2,
-            .fmt = AUDIO_FORMAT_S16,
-            .endianness = AUDIO_HOST_ENDIANNESS,
-        }
-    },
-
-    .period = { .hertz = 100 },
-    .try_poll_in = 1,
-    .try_poll_out = 1,
-};
-
 static AudioState glob_audio_state;
 
 const struct mixeng_volume nominal_volume = {
@@ -151,9 +101,6 @@ const struct mixeng_volume nominal_volume = {
 #ifdef AUDIO_IS_FLAWLESS_AND_NO_CHECKS_ARE_REQURIED
 #error No its not
 #else
-static void audio_print_options (const char *prefix,
-                                 struct audio_option *opt);
-
 int audio_bug (const char *funcname, int cond)
 {
     if (cond) {
@@ -161,16 +108,9 @@ int audio_bug (const char *funcname, int cond)
 
         AUD_log (NULL, "A bug was just triggered in %s\n", funcname);
         if (!shown) {
-            struct audio_driver *d;
-
             shown = 1;
             AUD_log (NULL, "Save all your work and restart without audio\n");
-            AUD_log (NULL, "Please send bug report to av1474@comtv.ru\n");
             AUD_log (NULL, "I am sorry\n");
-            d = glob_audio_state.drv;
-            if (d) {
-                audio_print_options (d->name, d->options);
-            }
         }
         AUD_log (NULL, "Context:\n");
 
@@ -232,31 +172,6 @@ void *audio_calloc (const char *funcname, int nmemb, size_t size)
     return g_malloc0 (len);
 }
 
-static char *audio_alloc_prefix (const char *s)
-{
-    const char qemu_prefix[] = "QEMU_";
-    size_t len, i;
-    char *r, *u;
-
-    if (!s) {
-        return NULL;
-    }
-
-    len = strlen (s);
-    r = g_malloc (len + sizeof (qemu_prefix));
-
-    u = r + sizeof (qemu_prefix) - 1;
-
-    pstrcpy (r, len + sizeof (qemu_prefix), qemu_prefix);
-    pstrcat (r, len + sizeof (qemu_prefix), s);
-
-    for (i = 0; i < len; ++i) {
-        u[i] = qemu_toupper(u[i]);
-    }
-
-    return r;
-}
-
 static const char *audio_audfmt_to_string (AudioFormat fmt)
 {
     switch (fmt) {
@@ -382,78 +297,6 @@ void AUD_log (const char *cap, const char *fmt, ...)
     va_end (ap);
 }
 
-static void audio_print_options (const char *prefix,
-                                 struct audio_option *opt)
-{
-    char *uprefix;
-
-    if (!prefix) {
-        dolog ("No prefix specified\n");
-        return;
-    }
-
-    if (!opt) {
-        dolog ("No options\n");
-        return;
-    }
-
-    uprefix = audio_alloc_prefix (prefix);
-
-    for (; opt->name; opt++) {
-        const char *state = "default";
-        printf ("  %s_%s: ", uprefix, opt->name);
-
-        if (opt->overriddenp && *opt->overriddenp) {
-            state = "current";
-        }
-
-        switch (opt->tag) {
-        case AUD_OPT_BOOL:
-            {
-                int *intp = opt->valp;
-                printf ("boolean, %s = %d\n", state, *intp ? 1 : 0);
-            }
-            break;
-
-        case AUD_OPT_INT:
-            {
-                int *intp = opt->valp;
-                printf ("integer, %s = %d\n", state, *intp);
-            }
-            break;
-
-        case AUD_OPT_FMT:
-            {
-                AudioFormat *fmtp = opt->valp;
-                printf (
-                    "format, %s = %s, (one of: U8 S8 U16 S16 U32 S32)\n",
-                    state,
-                    audio_audfmt_to_string (*fmtp)
-                    );
-            }
-            break;
-
-        case AUD_OPT_STR:
-            {
-                const char **strp = opt->valp;
-                printf ("string, %s = %s\n",
-                        state,
-                        *strp ? *strp : "(not set)");
-            }
-            break;
-
-        default:
-            printf ("???\n");
-            dolog ("Bad value tag for option %s_%s %d\n",
-                   uprefix, opt->name, opt->tag);
-            break;
-        }
-        printf ("    %s\n", opt->descr);
-    }
-
-    g_free (uprefix);
-}
-
 static void audio_process_options (const char *prefix,
                                    struct audio_option *opt)
 {
@@ -1161,11 +1004,11 @@ static void audio_reset_timer (AudioState *s)
 {
     if (audio_is_timer_needed ()) {
         timer_mod_anticipate_ns(s->ts,
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.ticks);
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
         if (!audio_timer_running) {
             audio_timer_running = true;
             audio_timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-            trace_audio_timer_start(conf.period.ticks / SCALE_MS);
+            trace_audio_timer_start(s->period_ticks / SCALE_MS);
         }
     } else {
         timer_del(s->ts);
@@ -1179,16 +1022,17 @@ static void audio_reset_timer (AudioState *s)
 static void audio_timer (void *opaque)
 {
     int64_t now, diff;
+    AudioState *s = opaque;
 
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     diff = now - audio_timer_last;
-    if (diff > conf.period.ticks * 3 / 2) {
+    if (diff > s->period_ticks * 3 / 2) {
         trace_audio_timer_delayed(diff / SCALE_MS);
     }
     audio_timer_last = now;
 
-    audio_run ("timer");
-    audio_reset_timer (opaque);
+    audio_run("timer");
+    audio_reset_timer(s);
 }
 
 /*
@@ -1248,7 +1092,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_out (hw, VOICE_ENABLE, conf.try_poll_out);
+                    hw->pcm_ops->ctl_out(hw, VOICE_ENABLE, true);
                     audio_reset_timer (s);
                 }
             }
@@ -1293,7 +1137,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
             if (!hw->enabled) {
                 hw->enabled = 1;
                 if (s->vm_running) {
-                    hw->pcm_ops->ctl_in (hw, VOICE_ENABLE, conf.try_poll_in);
+                    hw->pcm_ops->ctl_in(hw, VOICE_ENABLE, true);
                     audio_reset_timer (s);
                 }
             }
@@ -1614,169 +1458,13 @@ void audio_run (const char *msg)
 #endif
 }
 
-static struct audio_option audio_options[] = {
-    /* DAC */
-    {
-        .name  = "DAC_FIXED_SETTINGS",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &conf.fixed_out.enabled,
-        .descr = "Use fixed settings for host DAC"
-    },
-    {
-        .name  = "DAC_FIXED_FREQ",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_out.settings.freq,
-        .descr = "Frequency for fixed host DAC"
-    },
-    {
-        .name  = "DAC_FIXED_FMT",
-        .tag   = AUD_OPT_FMT,
-        .valp  = &conf.fixed_out.settings.fmt,
-        .descr = "Format for fixed host DAC"
-    },
-    {
-        .name  = "DAC_FIXED_CHANNELS",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_out.settings.nchannels,
-        .descr = "Number of channels for fixed DAC (1 - mono, 2 - stereo)"
-    },
-    {
-        .name  = "DAC_VOICES",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_out.nb_voices,
-        .descr = "Number of voices for DAC"
-    },
-    {
-        .name  = "DAC_TRY_POLL",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &conf.try_poll_out,
-        .descr = "Attempt using poll mode for DAC"
-    },
-    /* ADC */
-    {
-        .name  = "ADC_FIXED_SETTINGS",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &conf.fixed_in.enabled,
-        .descr = "Use fixed settings for host ADC"
-    },
-    {
-        .name  = "ADC_FIXED_FREQ",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_in.settings.freq,
-        .descr = "Frequency for fixed host ADC"
-    },
-    {
-        .name  = "ADC_FIXED_FMT",
-        .tag   = AUD_OPT_FMT,
-        .valp  = &conf.fixed_in.settings.fmt,
-        .descr = "Format for fixed host ADC"
-    },
-    {
-        .name  = "ADC_FIXED_CHANNELS",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_in.settings.nchannels,
-        .descr = "Number of channels for fixed ADC (1 - mono, 2 - stereo)"
-    },
-    {
-        .name  = "ADC_VOICES",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.fixed_in.nb_voices,
-        .descr = "Number of voices for ADC"
-    },
-    {
-        .name  = "ADC_TRY_POLL",
-        .tag   = AUD_OPT_BOOL,
-        .valp  = &conf.try_poll_in,
-        .descr = "Attempt using poll mode for ADC"
-    },
-    /* Misc */
-    {
-        .name  = "TIMER_PERIOD",
-        .tag   = AUD_OPT_INT,
-        .valp  = &conf.period.hertz,
-        .descr = "Timer period in HZ (0 - use lowest possible)"
-    },
-    { /* End of list */ }
-};
-
-static void audio_pp_nb_voices (const char *typ, int nb)
-{
-    switch (nb) {
-    case 0:
-        printf ("Does not support %s\n", typ);
-        break;
-    case 1:
-        printf ("One %s voice\n", typ);
-        break;
-    case INT_MAX:
-        printf ("Theoretically supports many %s voices\n", typ);
-        break;
-    default:
-        printf ("Theoretically supports up to %d %s voices\n", nb, typ);
-        break;
-    }
-
-}
-
-void AUD_help (void)
-{
-    struct audio_driver *d;
-
-    /* make sure we print the help text for modular drivers too */
-    audio_module_load_all();
-
-    audio_process_options ("AUDIO", audio_options);
-    QLIST_FOREACH(d, &audio_drivers, next) {
-        if (d->options) {
-            audio_process_options (d->name, d->options);
-        }
-    }
-
-    printf ("Audio options:\n");
-    audio_print_options ("AUDIO", audio_options);
-    printf ("\n");
-
-    printf ("Available drivers:\n");
-
-    QLIST_FOREACH(d, &audio_drivers, next) {
-
-        printf ("Name: %s\n", d->name);
-        printf ("Description: %s\n", d->descr);
-
-        audio_pp_nb_voices ("playback", d->max_voices_out);
-        audio_pp_nb_voices ("capture", d->max_voices_in);
-
-        if (d->options) {
-            printf ("Options:\n");
-            audio_print_options (d->name, d->options);
-        }
-        else {
-            printf ("No options\n");
-        }
-        printf ("\n");
-    }
-
-    printf (
-        "Options are settable through environment variables.\n"
-        "Example:\n"
-#ifdef _WIN32
-        "  set QEMU_AUDIO_DRV=wav\n"
-        "  set QEMU_WAV_PATH=c:\\tune.wav\n"
-#else
-        "  export QEMU_AUDIO_DRV=wav\n"
-        "  export QEMU_WAV_PATH=$HOME/tune.wav\n"
-        "(for csh replace export with setenv in the above)\n"
-#endif
-        "  qemu ...\n\n"
-        );
-}
-
-static int audio_driver_init(AudioState *s, struct audio_driver *drv, bool msg)
+static int audio_driver_init(AudioState *s, struct audio_driver *drv,
+                             bool msg, Audiodev *dev)
 {
     if (drv->options) {
         audio_process_options (drv->name, drv->options);
     }
-    s->drv_opaque = drv->init ();
+    s->drv_opaque = drv->init(dev);
 
     if (s->drv_opaque) {
         audio_init_nb_voices_out (drv);
@@ -1802,11 +1490,11 @@ static void audio_vm_change_state_handler (void *opaque, int running,
 
     s->vm_running = running;
     while ((hwo = audio_pcm_hw_find_any_enabled_out (hwo))) {
-        hwo->pcm_ops->ctl_out (hwo, op, conf.try_poll_out);
+        hwo->pcm_ops->ctl_out(hwo, op, true);
     }
 
     while ((hwi = audio_pcm_hw_find_any_enabled_in (hwi))) {
-        hwi->pcm_ops->ctl_in (hwi, op, conf.try_poll_in);
+        hwi->pcm_ops->ctl_in(hwi, op, true);
     }
     audio_reset_timer (s);
 }
@@ -1856,6 +1544,11 @@ void audio_cleanup(void)
         s->drv->fini (s->drv_opaque);
         s->drv = NULL;
     }
+
+    if (s->dev) {
+        qapi_free_Audiodev(s->dev);
+        s->dev = NULL;
+    }
 }
 
 static const VMStateDescription vmstate_audio = {
@@ -1867,19 +1560,58 @@ static const VMStateDescription vmstate_audio = {
     }
 };
 
-static void audio_init (void)
+static void audio_validate_opts(Audiodev *dev, Error **errp);
+
+static AudiodevListEntry *audiodev_find(
+    AudiodevListHead *head, const char *drvname)
+{
+    AudiodevListEntry *e;
+    QSIMPLEQ_FOREACH(e, head, next) {
+        if (strcmp(AudiodevDriver_str(e->dev->driver), drvname) == 0) {
+            return e;
+        }
+    }
+
+    return NULL;
+}
+
+static int audio_init(Audiodev *dev)
 {
     size_t i;
     int done = 0;
-    const char *drvname;
+    const char *drvname = NULL;
     VMChangeStateEntry *e;
     AudioState *s = &glob_audio_state;
     struct audio_driver *driver;
+    /* silence gcc warning about uninitialized variable */
+    AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
 
     if (s->drv) {
-        return;
+        if (dev) {
+            dolog("Cannot create more than one audio backend, sorry\n");
+            qapi_free_Audiodev(dev);
+        }
+        return -1;
     }
 
+    if (dev) {
+        /* -audiodev option */
+        drvname = AudiodevDriver_str(dev->driver);
+    } else {
+        /* legacy implicit initialization */
+        head = audio_handle_legacy_opts();
+        /*
+         * In case of legacy initialization, all Audiodevs in the list will have
+         * the same configuration (except the driver), so it does't matter which
+         * one we chose.  We need an Audiodev to set up AudioState before we can
+         * init a driver.  Also note that dev at this point is still in the
+         * list.
+         */
+        dev = QSIMPLEQ_FIRST(&head)->dev;
+        audio_validate_opts(dev, &error_abort);
+    }
+    s->dev = dev;
+
     QLIST_INIT (&s->hw_head_out);
     QLIST_INIT (&s->hw_head_in);
     QLIST_INIT (&s->cap_head);
@@ -1887,10 +1619,8 @@ static void audio_init (void)
 
     s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
 
-    audio_process_options ("AUDIO", audio_options);
-
-    s->nb_hw_voices_out = conf.fixed_out.nb_voices;
-    s->nb_hw_voices_in = conf.fixed_in.nb_voices;
+    s->nb_hw_voices_out = dev->out->voices;
+    s->nb_hw_voices_in = dev->in->voices;
 
     if (s->nb_hw_voices_out <= 0) {
         dolog ("Bogus number of playback voices %d, setting to 1\n",
@@ -1904,46 +1634,42 @@ static void audio_init (void)
         s->nb_hw_voices_in = 0;
     }
 
-    {
-        int def;
-        drvname = audio_get_conf_str ("QEMU_AUDIO_DRV", NULL, &def);
-    }
-
     if (drvname) {
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = !audio_driver_init(s, driver, true);
+            done = !audio_driver_init(s, driver, true, dev);
         } else {
             dolog ("Unknown audio driver `%s'\n", drvname);
-            dolog ("Run with -audio-help to list available drivers\n");
         }
-    }
-
-    if (!done) {
-        for (i = 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
+    } else {
+        for (i = 0; audio_prio_list[i]; i++) {
+            AudiodevListEntry *e = audiodev_find(&head, audio_prio_list[i]);
             driver = audio_driver_lookup(audio_prio_list[i]);
-            if (driver && driver->can_be_default) {
-                done = !audio_driver_init(s, driver, false);
+
+            if (e && driver) {
+                s->dev = dev = e->dev;
+                audio_validate_opts(dev, &error_abort);
+                done = !audio_driver_init(s, driver, false, dev);
+                if (done) {
+                    e->dev = NULL;
+                    break;
+                }
             }
         }
     }
+    audio_free_audiodev_list(&head);
 
     if (!done) {
         driver = audio_driver_lookup("none");
-        done = !audio_driver_init(s, driver, false);
+        done = !audio_driver_init(s, driver, false, dev);
         assert(done);
         dolog("warning: Using timer based audio emulation\n");
     }
 
-    if (conf.period.hertz <= 0) {
-        if (conf.period.hertz < 0) {
-            dolog ("warning: Timer period is negative - %d "
-                   "treating as zero\n",
-                   conf.period.hertz);
-        }
-        conf.period.ticks = 1;
+    if (dev->timer_period <= 0) {
+        s->period_ticks = 1;
     } else {
-        conf.period.ticks = NANOSECONDS_PER_SECOND / conf.period.hertz;
+        s->period_ticks = NANOSECONDS_PER_SECOND / dev->timer_period;
     }
 
     e = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
@@ -1954,11 +1680,22 @@ static void audio_init (void)
 
     QLIST_INIT (&s->card_head);
     vmstate_register (NULL, 0, &vmstate_audio, s);
+    return 0;
+}
+
+void audio_free_audiodev_list(AudiodevListHead *head)
+{
+    AudiodevListEntry *e;
+    while ((e = QSIMPLEQ_FIRST(head))) {
+        QSIMPLEQ_REMOVE_HEAD(head, next);
+        qapi_free_Audiodev(e->dev);
+        g_free(e);
+    }
 }
 
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
-    audio_init ();
+    audio_init(NULL);
     card->name = g_strdup (name);
     memset (&card->entries, 0, sizeof (card->entries));
     QLIST_INSERT_HEAD (&glob_audio_state.card_head, card, entries);
@@ -2129,3 +1866,145 @@ void AUD_set_volume_in (SWVoiceIn *sw, int mute, uint8_t lvol, uint8_t rvol)
         }
     }
 }
+
+static void audio_validate_per_direction_opts(
+    AudiodevPerDirectionOptions **pdo, bool *has_pdo, Error **errp)
+{
+    if (!*has_pdo) {
+        *pdo = g_malloc0(sizeof(AudiodevPerDirectionOptions));
+        *has_pdo = true;
+    }
+
+    if (!(*pdo)->has_fixed_settings) {
+        (*pdo)->has_fixed_settings = true;
+        (*pdo)->fixed_settings = true;
+    }
+    if (!(*pdo)->fixed_settings &&
+        ((*pdo)->has_frequency || (*pdo)->has_channels || (*pdo)->has_format)) {
+        error_setg(errp,
+                   "You can't use frequency, channels or format with fixed-settings=off");
+        return;
+    }
+
+    if (!(*pdo)->has_frequency) {
+        (*pdo)->has_frequency = true;
+        (*pdo)->frequency = 44100;
+    }
+    if (!(*pdo)->has_channels) {
+        (*pdo)->has_channels = true;
+        (*pdo)->channels = 2;
+    }
+    if (!(*pdo)->has_voices) {
+        (*pdo)->has_voices = true;
+        (*pdo)->voices = 1;
+    }
+    if (!(*pdo)->has_format) {
+        (*pdo)->has_format = true;
+        (*pdo)->format = AUDIO_FORMAT_S16;
+    }
+}
+
+static void audio_validate_opts(Audiodev *dev, Error **errp)
+{
+    Error *err = NULL;
+
+    audio_validate_per_direction_opts(&dev->in, &dev->has_in, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    audio_validate_per_direction_opts(&dev->out, &dev->has_out, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    if (!dev->has_timer_period) {
+        dev->has_timer_period = true;
+        dev->timer_period = 10000; /* 100Hz -> 10ms */
+    }
+}
+
+void audio_parse_option(const char *opt)
+{
+    AudiodevListEntry *e;
+    Audiodev *dev = NULL;
+
+    Visitor *v = qobject_input_visitor_new_str(opt, "driver", &error_fatal);
+    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
+    visit_free(v);
+
+    audio_validate_opts(dev, &error_fatal);
+
+    e = g_malloc0(sizeof(AudiodevListEntry));
+    e->dev = dev;
+    QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
+}
+
+void audio_init_audiodevs(void)
+{
+    AudiodevListEntry *e;
+
+    QSIMPLEQ_FOREACH(e, &audiodevs, next) {
+        audio_init(e->dev);
+    }
+}
+
+audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
+{
+    return (audsettings) {
+        .freq = pdo->frequency,
+        .nchannels = pdo->channels,
+        .fmt = pdo->format,
+        .endianness = AUDIO_HOST_ENDIANNESS,
+    };
+}
+
+int audioformat_bytes_per_sample(AudioFormat fmt)
+{
+    switch (fmt) {
+    case AUDIO_FORMAT_U8:
+    case AUDIO_FORMAT_S8:
+        return 1;
+
+    case AUDIO_FORMAT_U16:
+    case AUDIO_FORMAT_S16:
+        return 2;
+
+    case AUDIO_FORMAT_U32:
+    case AUDIO_FORMAT_S32:
+        return 4;
+
+    case AUDIO_FORMAT__MAX:
+        ;
+    }
+    abort();
+}
+
+
+/* frames = freq * usec / 1e6 */
+int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
+                        audsettings *as, int def_usecs)
+{
+    uint64_t usecs = pdo->has_buffer_len ? pdo->buffer_len : def_usecs;
+    return (as->freq * usecs + 500000) / 1000000;
+}
+
+/* samples = channels * frames = channels * freq * usec / 1e6 */
+int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
+                         audsettings *as, int def_usecs)
+{
+    return as->nchannels * audio_buffer_frames(pdo, as, def_usecs);
+}
+
+/*
+ * bytes = bytes_per_sample * samples =
+ *     bytes_per_sample * channels * freq * usec / 1e6
+ */
+int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
+                       audsettings *as, int def_usecs)
+{
+    return audio_buffer_samples(pdo, as, def_usecs) *
+        audioformat_bytes_per_sample(as->fmt);
+}
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
new file mode 100644
index 0000000000..c0b2c4604e
--- /dev/null
+++ b/audio/audio_legacy.c
@@ -0,0 +1,295 @@
+/*
+ * QEMU Audio subsystem: legacy configuration handling
+ *
+ * Copyright (c) 2015-2019 Zoltán Kővágó <DirtY.iCE.hu@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "audio.h"
+#include "audio_int.h"
+#include "qemu-common.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-audio.h"
+#include "qapi/visitor-impl.h"
+
+#define AUDIO_CAP "audio-legacy"
+#include "audio_int.h"
+
+static uint32_t toui32(const char *str)
+{
+    unsigned long long ret;
+    if (parse_uint_full(str, &ret, 10) || ret > UINT32_MAX) {
+        dolog("Invalid integer value `%s'\n", str);
+        exit(1);
+    }
+    return ret;
+}
+
+/* helper functions to convert env variables */
+static void get_bool(const char *env, bool *dst, bool *has_dst)
+{
+    const char *val = getenv(env);
+    if (val) {
+        *dst = toui32(val) != 0;
+        *has_dst = true;
+    }
+}
+
+static void get_int(const char *env, uint32_t *dst, bool *has_dst)
+{
+    const char *val = getenv(env);
+    if (val) {
+        *dst = toui32(val);
+        *has_dst = true;
+    }
+}
+
+static void get_fmt(const char *env, AudioFormat *dst, bool *has_dst)
+{
+    const char *val = getenv(env);
+    if (val) {
+        size_t i;
+        for (i = 0; AudioFormat_lookup.size; ++i) {
+            if (strcasecmp(val, AudioFormat_lookup.array[i]) == 0) {
+                *dst = i;
+                *has_dst = true;
+                return;
+            }
+        }
+
+        dolog("Invalid audio format `%s'\n", val);
+        exit(1);
+    }
+}
+
+/* backend specific functions */
+/* todo */
+
+/* general */
+static void handle_per_direction(
+    AudiodevPerDirectionOptions *pdo, const char *prefix)
+{
+    char buf[64];
+    size_t len = strlen(prefix);
+
+    memcpy(buf, prefix, len);
+    strcpy(buf + len, "FIXED_SETTINGS");
+    get_bool(buf, &pdo->fixed_settings, &pdo->has_fixed_settings);
+
+    strcpy(buf + len, "FIXED_FREQ");
+    get_int(buf, &pdo->frequency, &pdo->has_frequency);
+
+    strcpy(buf + len, "FIXED_FMT");
+    get_fmt(buf, &pdo->format, &pdo->has_format);
+
+    strcpy(buf + len, "FIXED_CHANNELS");
+    get_int(buf, &pdo->channels, &pdo->has_channels);
+
+    strcpy(buf + len, "VOICES");
+    get_int(buf, &pdo->voices, &pdo->has_voices);
+}
+
+static AudiodevListEntry *legacy_opt(const char *drvname)
+{
+    AudiodevListEntry *e = g_malloc0(sizeof(AudiodevListEntry));
+    e->dev = g_malloc0(sizeof(Audiodev));
+    e->dev->id = g_strdup(drvname);
+    e->dev->driver = qapi_enum_parse(
+        &AudiodevDriver_lookup, drvname, -1, &error_abort);
+    e->dev->in = g_malloc0(sizeof(AudiodevPerDirectionOptions));
+    e->dev->has_in = true;
+    e->dev->out = g_malloc0(sizeof(AudiodevPerDirectionOptions));
+    e->dev->has_out = true;
+
+    handle_per_direction(e->dev->in, "QEMU_AUDIO_ADC_");
+    handle_per_direction(e->dev->out, "QEMU_AUDIO_DAC_");
+
+    get_int("QEMU_AUDIO_TIMER_PERIOD",
+            &e->dev->timer_period, &e->dev->has_timer_period);
+
+    return e;
+}
+
+AudiodevListHead audio_handle_legacy_opts(void)
+{
+    const char *drvname = getenv("QEMU_AUDIO_DRV");
+    AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
+
+    if (drvname) {
+        AudiodevListEntry *e;
+        audio_driver *driver = audio_driver_lookup(drvname);
+        if (!driver) {
+            dolog("Unknown audio driver `%s'\n", drvname);
+            exit(1);
+        }
+        e = legacy_opt(drvname);
+        QSIMPLEQ_INSERT_TAIL(&head, e, next);
+    } else {
+        for (int i = 0; audio_prio_list[i]; i++) {
+            audio_driver *driver = audio_driver_lookup(audio_prio_list[i]);
+            if (driver && driver->can_be_default) {
+                AudiodevListEntry *e = legacy_opt(driver->name);
+                QSIMPLEQ_INSERT_TAIL(&head, e, next);
+            }
+        }
+        if (QSIMPLEQ_EMPTY(&head)) {
+            dolog("Internal error: no default audio driver available\n");
+            exit(1);
+        }
+    }
+
+    return head;
+}
+
+/* visitor to print -audiodev option */
+typedef struct {
+    Visitor visitor;
+
+    bool comma;
+    GList *path;
+} LegacyPrintVisitor;
+
+static void lv_start_struct(Visitor *v, const char *name, void **obj,
+                            size_t size, Error **errp)
+{
+    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
+    lv->path = g_list_append(lv->path, g_strdup(name));
+}
+
+static void lv_end_struct(Visitor *v, void **obj)
+{
+    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
+    lv->path = g_list_delete_link(lv->path, g_list_last(lv->path));
+}
+
+static void lv_print_key(Visitor *v, const char *name)
+{
+    GList *e;
+    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
+    if (lv->comma) {
+        putchar(',');
+    } else {
+        lv->comma = true;
+    }
+
+    for (e = lv->path; e; e = e->next) {
+        if (e->data) {
+            printf("%s.", (const char *) e->data);
+        }
+    }
+
+    printf("%s=", name);
+}
+
+static void lv_type_int64(Visitor *v, const char *name, int64_t *obj,
+                          Error **errp)
+{
+    lv_print_key(v, name);
+    printf("%" PRIi64, *obj);
+}
+
+static void lv_type_uint64(Visitor *v, const char *name, uint64_t *obj,
+                           Error **errp)
+{
+    lv_print_key(v, name);
+    printf("%" PRIu64, *obj);
+}
+
+static void lv_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
+{
+    lv_print_key(v, name);
+    printf("%s", *obj ? "on" : "off");
+}
+
+static void lv_type_str(Visitor *v, const char *name, char **obj, Error **errp)
+{
+    const char *str = *obj;
+    lv_print_key(v, name);
+
+    while (*str) {
+        if (*str == ',') {
+            putchar(',');
+        }
+        putchar(*str++);
+    }
+}
+
+static void lv_complete(Visitor *v, void *opaque)
+{
+    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
+    assert(lv->path == NULL);
+}
+
+static void lv_free(Visitor *v)
+{
+    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
+
+    g_list_free_full(lv->path, g_free);
+    g_free(lv);
+}
+
+static Visitor *legacy_visitor_new(void)
+{
+    LegacyPrintVisitor *lv = g_malloc0(sizeof(LegacyPrintVisitor));
+
+    lv->visitor.start_struct = lv_start_struct;
+    lv->visitor.end_struct = lv_end_struct;
+    /* lists not supported */
+    lv->visitor.type_int64 = lv_type_int64;
+    lv->visitor.type_uint64 = lv_type_uint64;
+    lv->visitor.type_bool = lv_type_bool;
+    lv->visitor.type_str = lv_type_str;
+
+    lv->visitor.type = VISITOR_OUTPUT;
+    lv->visitor.complete = lv_complete;
+    lv->visitor.free = lv_free;
+
+    return &lv->visitor;
+}
+
+void audio_legacy_help(void)
+{
+    AudiodevListHead head;
+    AudiodevListEntry *e;
+
+    printf("Environment variable based configuration deprecated.\n");
+    printf("Please use the new -audiodev option.\n");
+
+    head = audio_handle_legacy_opts();
+    printf("\nEquivalent -audiodev to your current environment variables:\n");
+    if (!getenv("QEMU_AUDIO_DRV")) {
+        printf("(Since you didn't specify QEMU_AUDIO_DRV, I'll list all "
+               "possibilities)\n");
+    }
+
+    QSIMPLEQ_FOREACH(e, &head, next) {
+        Visitor *v;
+        Audiodev *dev = e->dev;
+        printf("-audiodev ");
+
+        v = legacy_visitor_new();
+        visit_type_Audiodev(v, NULL, &dev, &error_abort);
+        visit_free(v);
+
+        printf("\n");
+    }
+    audio_free_audiodev_list(&head);
+}
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 638c60b300..7d4225dbee 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -685,7 +685,7 @@ static CoreaudioConf glob_conf = {
     .nbuffers = 4,
 };
 
-static void *coreaudio_audio_init (void)
+static void *coreaudio_audio_init(Audiodev *dev)
 {
     CoreaudioConf *conf = g_malloc(sizeof(CoreaudioConf));
     *conf = glob_conf;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 3ed73a30d1..02fe777cba 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -783,7 +783,7 @@ static void dsound_audio_fini (void *opaque)
     g_free(s);
 }
 
-static void *dsound_audio_init (void)
+static void *dsound_audio_init(Audiodev *dev)
 {
     int err;
     HRESULT hr;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 1bfebeca7d..79690af1ea 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -136,7 +136,7 @@ static int no_ctl_in (HWVoiceIn *hw, int cmd, ...)
     return 0;
 }
 
-static void *no_audio_init (void)
+static void *no_audio_init(Audiodev *dev)
 {
     return &no_audio_init;
 }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 355e8fbda5..e0cadbef29 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -842,7 +842,7 @@ static OSSConf glob_conf = {
     .policy = 5
 };
 
-static void *oss_audio_init (void)
+static void *oss_audio_init(Audiodev *dev)
 {
     OSSConf *conf = g_malloc(sizeof(OSSConf));
     *conf = glob_conf;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 8246f260a8..d649c58e3d 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -812,7 +812,7 @@ static PAConf glob_conf = {
     .samples = 4096,
 };
 
-static void *qpa_audio_init (void)
+static void *qpa_audio_init(Audiodev *dev)
 {
     if (glob_conf.server == NULL) {
         char pidfile[64];
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index aa42ea26bf..097841fde1 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -436,7 +436,7 @@ static int sdl_ctl_out (HWVoiceOut *hw, int cmd, ...)
     return 0;
 }
 
-static void *sdl_audio_init (void)
+static void *sdl_audio_init(Audiodev *dev)
 {
     SDLAudioState *s = &glob_sdl;
     if (s->driver_created) {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 3aeb0cb357..affc3df17f 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -77,7 +77,7 @@ static const SpiceRecordInterface record_sif = {
     .base.minor_version = SPICE_INTERFACE_RECORD_MINOR,
 };
 
-static void *spice_audio_init (void)
+static void *spice_audio_init(Audiodev *dev)
 {
     if (!using_spice) {
         return NULL;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 35a614785e..9eff3555b3 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -232,7 +232,7 @@ static WAVConf glob_conf = {
     .wav_path           = "qemu.wav"
 };
 
-static void *wav_audio_init (void)
+static void *wav_audio_init(Audiodev *dev)
 {
     WAVConf *conf = g_malloc(sizeof(WAVConf));
     *conf = glob_conf;
diff --git a/vl.c b/vl.c
index bc9fbec654..80aa0458fc 100644
--- a/vl.c
+++ b/vl.c
@@ -3302,9 +3302,12 @@ int main(int argc, char **argv, char **envp)
                 add_device_config(DEV_BT, optarg);
                 break;
             case QEMU_OPTION_audio_help:
-                AUD_help ();
+                audio_legacy_help();
                 exit (0);
                 break;
+            case QEMU_OPTION_audiodev:
+                audio_parse_option(optarg);
+                break;
             case QEMU_OPTION_soundhw:
                 select_soundhw (optarg);
                 break;
@@ -4533,6 +4536,8 @@ int main(int argc, char **argv, char **envp)
     /* do monitor/qmp handling at preconfig state if requested */
     main_loop();
 
+    audio_init_audiodevs();
+
     /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
 
diff --git a/audio/Makefile.objs b/audio/Makefile.objs
index db4fa7f18f..dca87f6347 100644
--- a/audio/Makefile.objs
+++ b/audio/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y = audio.o noaudio.o wavaudio.o mixeng.o
+common-obj-y = audio.o audio_legacy.o noaudio.o wavaudio.o mixeng.o
 common-obj-$(CONFIG_SPICE) += spiceaudio.o
 common-obj-$(CONFIG_AUDIO_COREAUDIO) += coreaudio.o
 common-obj-$(CONFIG_AUDIO_DSOUND) += dsoundaudio.o
-- 
2.20.1
