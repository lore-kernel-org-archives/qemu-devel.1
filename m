Received: from eggs.gnu.org ([2001:4830:134:3::10]:57453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7Di-0002jR-5y
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7De-0000Be-9p
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et7De-0000Ad-4X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 810E04061B88
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 07:41:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 08:40:47 +0100
Message-Id: <20180306074053.22856-2-kraxel@redhat.com>
In-Reply-To: <20180306074053.22856-1-kraxel@redhat.com>
References: <20180306074053.22856-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] audio: add driver registry
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

Add registry for audio drivers, using the existing audio_driver struct.
Make all drivers register themself.  The old list of audio_driver struct
pointers is now a list of audio driver names, specifying the priority
(aka probe order) in case no driver is explicitly asked for.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio_int.h     | 14 ++++--------
 audio/alsaaudio.c     |  8 ++++++-
 audio/audio.c         | 63 ++++++++++++++++++++++++++++++---------------------
 audio/coreaudio.c     |  8 ++++++-
 audio/dsoundaudio.c   |  8 ++++++-
 audio/noaudio.c       |  8 ++++++-
 audio/ossaudio.c      |  8 ++++++-
 audio/paaudio.c       |  8 ++++++-
 audio/sdlaudio.c      |  8 ++++++-
 audio/spiceaudio.c    |  8 ++++++-
 audio/wavaudio.c      |  8 ++++++-
 scripts/create_config |  2 +-
 12 files changed, 106 insertions(+), 45 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 700bd43143..244b454012 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -141,6 +141,7 @@ struct SWVoiceIn {
     QLIST_ENTRY (SWVoiceIn) entries;
 };
 
+typedef struct audio_driver audio_driver;
 struct audio_driver {
     const char *name;
     const char *descr;
@@ -154,6 +155,7 @@ struct audio_driver {
     int voice_size_out;
     int voice_size_in;
     int ctl_caps;
+    QLIST_ENTRY(audio_driver) next;
 };
 
 struct audio_pcm_ops {
@@ -203,17 +205,11 @@ struct AudioState {
     int vm_running;
 };
 
-extern struct audio_driver no_audio_driver;
-extern struct audio_driver oss_audio_driver;
-extern struct audio_driver sdl_audio_driver;
-extern struct audio_driver wav_audio_driver;
-extern struct audio_driver alsa_audio_driver;
-extern struct audio_driver coreaudio_audio_driver;
-extern struct audio_driver dsound_audio_driver;
-extern struct audio_driver pa_audio_driver;
-extern struct audio_driver spice_audio_driver;
 extern const struct mixeng_volume nominal_volume;
 
+void audio_driver_register(audio_driver *drv);
+audio_driver *audio_driver_lookup(const char *name);
+
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
 
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 92a96f8b2b..362a2276fd 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1213,7 +1213,7 @@ static struct audio_pcm_ops alsa_pcm_ops = {
     .ctl_in   = alsa_ctl_in,
 };
 
-struct audio_driver alsa_audio_driver = {
+static struct audio_driver alsa_audio_driver = {
     .name           = "alsa",
     .descr          = "ALSA http://www.alsa-project.org",
     .options        = alsa_options,
@@ -1226,3 +1226,9 @@ struct audio_driver alsa_audio_driver = {
     .voice_size_out = sizeof (ALSAVoiceOut),
     .voice_size_in  = sizeof (ALSAVoiceIn)
 };
+
+static void register_audio_alsa(void)
+{
+    audio_driver_register(&alsa_audio_driver);
+}
+type_init(register_audio_alsa);
diff --git a/audio/audio.c b/audio/audio.c
index 7658d2af66..2384612b87 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -45,15 +45,32 @@
    The 1st one is the one used by default, that is the reason
     that we generate the list.
 */
-static struct audio_driver *drvtab[] = {
-#ifdef CONFIG_SPICE
-    &spice_audio_driver,
-#endif
+static const char *audio_prio_list[] = {
+    "spice",
     CONFIG_AUDIO_DRIVERS
-    &no_audio_driver,
-    &wav_audio_driver
+    "none",
+    "wav",
 };
 
+static QLIST_HEAD(, audio_driver) audio_drivers;
+
+void audio_driver_register(audio_driver *drv)
+{
+    QLIST_INSERT_HEAD(&audio_drivers, drv, next);
+}
+
+audio_driver *audio_driver_lookup(const char *name)
+{
+    struct audio_driver *d;
+
+    QLIST_FOREACH(d, &audio_drivers, next) {
+        if (strcmp(name, d->name) == 0) {
+            return d;
+        }
+    }
+    return NULL;
+}
+
 struct fixed_settings {
     int enabled;
     int nb_voices;
@@ -1656,11 +1673,10 @@ static void audio_pp_nb_voices (const char *typ, int nb)
 
 void AUD_help (void)
 {
-    size_t i;
+    struct audio_driver *d;
 
     audio_process_options ("AUDIO", audio_options);
-    for (i = 0; i < ARRAY_SIZE (drvtab); i++) {
-        struct audio_driver *d = drvtab[i];
+    QLIST_FOREACH(d, &audio_drivers, next) {
         if (d->options) {
             audio_process_options (d->name, d->options);
         }
@@ -1672,8 +1688,7 @@ void AUD_help (void)
 
     printf ("Available drivers:\n");
 
-    for (i = 0; i < ARRAY_SIZE (drvtab); i++) {
-        struct audio_driver *d = drvtab[i];
+    QLIST_FOREACH(d, &audio_drivers, next) {
 
         printf ("Name: %s\n", d->name);
         printf ("Description: %s\n", d->descr);
@@ -1807,6 +1822,7 @@ static void audio_init (void)
     const char *drvname;
     VMChangeStateEntry *e;
     AudioState *s = &glob_audio_state;
+    struct audio_driver *driver;
 
     if (s->drv) {
         return;
@@ -1842,32 +1858,27 @@ static void audio_init (void)
     }
 
     if (drvname) {
-        int found = 0;
-
-        for (i = 0; i < ARRAY_SIZE (drvtab); i++) {
-            if (!strcmp (drvname, drvtab[i]->name)) {
-                done = !audio_driver_init (s, drvtab[i]);
-                found = 1;
-                break;
-            }
-        }
-
-        if (!found) {
+        driver = audio_driver_lookup(drvname);
+        if (driver) {
+            done = !audio_driver_init(s, driver);
+        } else {
             dolog ("Unknown audio driver `%s'\n", drvname);
             dolog ("Run with -audio-help to list available drivers\n");
         }
     }
 
     if (!done) {
-        for (i = 0; !done && i < ARRAY_SIZE (drvtab); i++) {
-            if (drvtab[i]->can_be_default) {
-                done = !audio_driver_init (s, drvtab[i]);
+        for (i = 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
+            driver = audio_driver_lookup(audio_prio_list[i]);
+            if (driver && driver->can_be_default) {
+                done = !audio_driver_init(s, driver);
             }
         }
     }
 
     if (!done) {
-        done = !audio_driver_init (s, &no_audio_driver);
+        driver = audio_driver_lookup("none");
+        done = !audio_driver_init(s, driver);
         assert(done);
         dolog("warning: Using timer based audio emulation\n");
     }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index c75142084f..638c60b300 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -722,7 +722,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops = {
     .ctl_out  = coreaudio_ctl_out
 };
 
-struct audio_driver coreaudio_audio_driver = {
+static struct audio_driver coreaudio_audio_driver = {
     .name           = "coreaudio",
     .descr          = "CoreAudio http://developer.apple.com/audio/coreaudio.html",
     .options        = coreaudio_options,
@@ -735,3 +735,9 @@ struct audio_driver coreaudio_audio_driver = {
     .voice_size_out = sizeof (coreaudioVoiceOut),
     .voice_size_in  = 0
 };
+
+static void register_audio_coreaudio(void)
+{
+    audio_driver_register(&coreaudio_audio_driver);
+}
+type_init(register_audio_coreaudio);
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index bc39cb9b4d..3ed73a30d1 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -890,7 +890,7 @@ static struct audio_pcm_ops dsound_pcm_ops = {
     .ctl_in   = dsound_ctl_in
 };
 
-struct audio_driver dsound_audio_driver = {
+static struct audio_driver dsound_audio_driver = {
     .name           = "dsound",
     .descr          = "DirectSound http://wikipedia.org/wiki/DirectSound",
     .options        = dsound_options,
@@ -903,3 +903,9 @@ struct audio_driver dsound_audio_driver = {
     .voice_size_out = sizeof (DSoundVoiceOut),
     .voice_size_in  = sizeof (DSoundVoiceIn)
 };
+
+static void register_audio_dsound(void)
+{
+    audio_driver_register(&dsound_audio_driver);
+}
+type_init(register_audio_dsound);
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 9ca9eaf01f..1bfebeca7d 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -160,7 +160,7 @@ static struct audio_pcm_ops no_pcm_ops = {
     .ctl_in   = no_ctl_in
 };
 
-struct audio_driver no_audio_driver = {
+static struct audio_driver no_audio_driver = {
     .name           = "none",
     .descr          = "Timer based audio emulation",
     .options        = NULL,
@@ -173,3 +173,9 @@ struct audio_driver no_audio_driver = {
     .voice_size_out = sizeof (NoVoiceOut),
     .voice_size_in  = sizeof (NoVoiceIn)
 };
+
+static void register_audio_none(void)
+{
+    audio_driver_register(&no_audio_driver);
+}
+type_init(register_audio_none);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index a0428881c2..6c69622b4c 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -922,7 +922,7 @@ static struct audio_pcm_ops oss_pcm_ops = {
     .ctl_in   = oss_ctl_in
 };
 
-struct audio_driver oss_audio_driver = {
+static struct audio_driver oss_audio_driver = {
     .name           = "oss",
     .descr          = "OSS http://www.opensound.com",
     .options        = oss_options,
@@ -935,3 +935,9 @@ struct audio_driver oss_audio_driver = {
     .voice_size_out = sizeof (OSSVoiceOut),
     .voice_size_in  = sizeof (OSSVoiceIn)
 };
+
+static void register_audio_oss(void)
+{
+    audio_driver_register(&oss_audio_driver);
+}
+type_init(register_audio_oss);
diff --git a/audio/paaudio.c b/audio/paaudio.c
index aa0a7477d3..949769774d 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -937,7 +937,7 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .ctl_in   = qpa_ctl_in
 };
 
-struct audio_driver pa_audio_driver = {
+static struct audio_driver pa_audio_driver = {
     .name           = "pa",
     .descr          = "http://www.pulseaudio.org/",
     .options        = qpa_options,
@@ -951,3 +951,9 @@ struct audio_driver pa_audio_driver = {
     .voice_size_in  = sizeof (PAVoiceIn),
     .ctl_caps       = VOICE_VOLUME_CAP
 };
+
+static void register_audio_pa(void)
+{
+    audio_driver_register(&pa_audio_driver);
+}
+type_init(register_audio_pa);
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index e92135bd2f..9db5ac92bc 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -500,7 +500,7 @@ static struct audio_pcm_ops sdl_pcm_ops = {
     .ctl_out  = sdl_ctl_out,
 };
 
-struct audio_driver sdl_audio_driver = {
+static struct audio_driver sdl_audio_driver = {
     .name           = "sdl",
     .descr          = "SDL http://www.libsdl.org",
     .options        = sdl_options,
@@ -513,3 +513,9 @@ struct audio_driver sdl_audio_driver = {
     .voice_size_out = sizeof (SDLVoiceOut),
     .voice_size_in  = 0
 };
+
+static void register_audio_sdl(void)
+{
+    audio_driver_register(&sdl_audio_driver);
+}
+type_init(register_audio_sdl);
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 5580e76307..6ad0eafbc6 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -391,7 +391,7 @@ static struct audio_pcm_ops audio_callbacks = {
     .ctl_in   = line_in_ctl,
 };
 
-struct audio_driver spice_audio_driver = {
+static struct audio_driver spice_audio_driver = {
     .name           = "spice",
     .descr          = "spice audio driver",
     .options        = audio_options,
@@ -411,3 +411,9 @@ void qemu_spice_audio_init (void)
 {
     spice_audio_driver.can_be_default = 1;
 }
+
+static void register_audio_spice(void)
+{
+    audio_driver_register(&spice_audio_driver);
+}
+type_init(register_audio_spice);
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 068a595732..40adfa30c3 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -278,7 +278,7 @@ static struct audio_pcm_ops wav_pcm_ops = {
     .ctl_out  = wav_ctl_out,
 };
 
-struct audio_driver wav_audio_driver = {
+static struct audio_driver wav_audio_driver = {
     .name           = "wav",
     .descr          = "WAV renderer http://wikipedia.org/wiki/WAV",
     .options        = wav_options,
@@ -291,3 +291,9 @@ struct audio_driver wav_audio_driver = {
     .voice_size_out = sizeof (WAVVoiceOut),
     .voice_size_in  = 0
 };
+
+static void register_audio_wav(void)
+{
+    audio_driver_register(&wav_audio_driver);
+}
+type_init(register_audio_wav);
diff --git a/scripts/create_config b/scripts/create_config
index 603b826886..d727e5e36e 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -36,7 +36,7 @@ case $line in
     drivers=${line#*=}
     echo "#define CONFIG_AUDIO_DRIVERS \\"
     for drv in $drivers; do
-      echo "    &${drv}_audio_driver,\\"
+      echo "    \"${drv}\",\\"
     done
     echo ""
     ;;
-- 
2.9.3
