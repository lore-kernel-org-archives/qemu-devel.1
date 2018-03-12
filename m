Received: from eggs.gnu.org ([2001:4830:134:3::10]:41508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKus-0002A4-O2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evKup-0000kd-4H
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35365 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evKuo-0000iF-Qc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:42:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4213A4000B6E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 10:42:47 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 11:42:35 +0100
Message-Id: <20180312104241.24965-3-kraxel@redhat.com>
In-Reply-To: <20180312104241.24965-1-kraxel@redhat.com>
References: <20180312104241.24965-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/8] audio: add driver registry
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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180306074053.22856-2-kraxel@redhat.com
---
 audio/audio_int.h     | 14 ++++--------
 audio/alsaaudio.c     |  8 ++++++-
 audio/audio.c         | 63 ++++++++++++++++++++++++++++++---------------=
------
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
=20
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
=20
 struct audio_pcm_ops {
@@ -203,17 +205,11 @@ struct AudioState {
     int vm_running;
 };
=20
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
=20
+void audio_driver_register(audio_driver *drv);
+audio_driver *audio_driver_lookup(const char *name);
+
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
=20
diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 92a96f8b2b..362a2276fd 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1213,7 +1213,7 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
     .ctl_in   =3D alsa_ctl_in,
 };
=20
-struct audio_driver alsa_audio_driver =3D {
+static struct audio_driver alsa_audio_driver =3D {
     .name           =3D "alsa",
     .descr          =3D "ALSA http://www.alsa-project.org",
     .options        =3D alsa_options,
@@ -1226,3 +1226,9 @@ struct audio_driver alsa_audio_driver =3D {
     .voice_size_out =3D sizeof (ALSAVoiceOut),
     .voice_size_in  =3D sizeof (ALSAVoiceIn)
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
-static struct audio_driver *drvtab[] =3D {
-#ifdef CONFIG_SPICE
-    &spice_audio_driver,
-#endif
+static const char *audio_prio_list[] =3D {
+    "spice",
     CONFIG_AUDIO_DRIVERS
-    &no_audio_driver,
-    &wav_audio_driver
+    "none",
+    "wav",
 };
=20
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
+        if (strcmp(name, d->name) =3D=3D 0) {
+            return d;
+        }
+    }
+    return NULL;
+}
+
 struct fixed_settings {
     int enabled;
     int nb_voices;
@@ -1656,11 +1673,10 @@ static void audio_pp_nb_voices (const char *typ, =
int nb)
=20
 void AUD_help (void)
 {
-    size_t i;
+    struct audio_driver *d;
=20
     audio_process_options ("AUDIO", audio_options);
-    for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
-        struct audio_driver *d =3D drvtab[i];
+    QLIST_FOREACH(d, &audio_drivers, next) {
         if (d->options) {
             audio_process_options (d->name, d->options);
         }
@@ -1672,8 +1688,7 @@ void AUD_help (void)
=20
     printf ("Available drivers:\n");
=20
-    for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
-        struct audio_driver *d =3D drvtab[i];
+    QLIST_FOREACH(d, &audio_drivers, next) {
=20
         printf ("Name: %s\n", d->name);
         printf ("Description: %s\n", d->descr);
@@ -1807,6 +1822,7 @@ static void audio_init (void)
     const char *drvname;
     VMChangeStateEntry *e;
     AudioState *s =3D &glob_audio_state;
+    struct audio_driver *driver;
=20
     if (s->drv) {
         return;
@@ -1842,32 +1858,27 @@ static void audio_init (void)
     }
=20
     if (drvname) {
-        int found =3D 0;
-
-        for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
-            if (!strcmp (drvname, drvtab[i]->name)) {
-                done =3D !audio_driver_init (s, drvtab[i]);
-                found =3D 1;
-                break;
-            }
-        }
-
-        if (!found) {
+        driver =3D audio_driver_lookup(drvname);
+        if (driver) {
+            done =3D !audio_driver_init(s, driver);
+        } else {
             dolog ("Unknown audio driver `%s'\n", drvname);
             dolog ("Run with -audio-help to list available drivers\n");
         }
     }
=20
     if (!done) {
-        for (i =3D 0; !done && i < ARRAY_SIZE (drvtab); i++) {
-            if (drvtab[i]->can_be_default) {
-                done =3D !audio_driver_init (s, drvtab[i]);
+        for (i =3D 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
+            driver =3D audio_driver_lookup(audio_prio_list[i]);
+            if (driver && driver->can_be_default) {
+                done =3D !audio_driver_init(s, driver);
             }
         }
     }
=20
     if (!done) {
-        done =3D !audio_driver_init (s, &no_audio_driver);
+        driver =3D audio_driver_lookup("none");
+        done =3D !audio_driver_init(s, driver);
         assert(done);
         dolog("warning: Using timer based audio emulation\n");
     }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index c75142084f..638c60b300 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -722,7 +722,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops =3D {
     .ctl_out  =3D coreaudio_ctl_out
 };
=20
-struct audio_driver coreaudio_audio_driver =3D {
+static struct audio_driver coreaudio_audio_driver =3D {
     .name           =3D "coreaudio",
     .descr          =3D "CoreAudio http://developer.apple.com/audio/core=
audio.html",
     .options        =3D coreaudio_options,
@@ -735,3 +735,9 @@ struct audio_driver coreaudio_audio_driver =3D {
     .voice_size_out =3D sizeof (coreaudioVoiceOut),
     .voice_size_in  =3D 0
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
@@ -890,7 +890,7 @@ static struct audio_pcm_ops dsound_pcm_ops =3D {
     .ctl_in   =3D dsound_ctl_in
 };
=20
-struct audio_driver dsound_audio_driver =3D {
+static struct audio_driver dsound_audio_driver =3D {
     .name           =3D "dsound",
     .descr          =3D "DirectSound http://wikipedia.org/wiki/DirectSou=
nd",
     .options        =3D dsound_options,
@@ -903,3 +903,9 @@ struct audio_driver dsound_audio_driver =3D {
     .voice_size_out =3D sizeof (DSoundVoiceOut),
     .voice_size_in  =3D sizeof (DSoundVoiceIn)
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
@@ -160,7 +160,7 @@ static struct audio_pcm_ops no_pcm_ops =3D {
     .ctl_in   =3D no_ctl_in
 };
=20
-struct audio_driver no_audio_driver =3D {
+static struct audio_driver no_audio_driver =3D {
     .name           =3D "none",
     .descr          =3D "Timer based audio emulation",
     .options        =3D NULL,
@@ -173,3 +173,9 @@ struct audio_driver no_audio_driver =3D {
     .voice_size_out =3D sizeof (NoVoiceOut),
     .voice_size_in  =3D sizeof (NoVoiceIn)
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
@@ -922,7 +922,7 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
     .ctl_in   =3D oss_ctl_in
 };
=20
-struct audio_driver oss_audio_driver =3D {
+static struct audio_driver oss_audio_driver =3D {
     .name           =3D "oss",
     .descr          =3D "OSS http://www.opensound.com",
     .options        =3D oss_options,
@@ -935,3 +935,9 @@ struct audio_driver oss_audio_driver =3D {
     .voice_size_out =3D sizeof (OSSVoiceOut),
     .voice_size_in  =3D sizeof (OSSVoiceIn)
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
@@ -937,7 +937,7 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
     .ctl_in   =3D qpa_ctl_in
 };
=20
-struct audio_driver pa_audio_driver =3D {
+static struct audio_driver pa_audio_driver =3D {
     .name           =3D "pa",
     .descr          =3D "http://www.pulseaudio.org/",
     .options        =3D qpa_options,
@@ -951,3 +951,9 @@ struct audio_driver pa_audio_driver =3D {
     .voice_size_in  =3D sizeof (PAVoiceIn),
     .ctl_caps       =3D VOICE_VOLUME_CAP
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
@@ -500,7 +500,7 @@ static struct audio_pcm_ops sdl_pcm_ops =3D {
     .ctl_out  =3D sdl_ctl_out,
 };
=20
-struct audio_driver sdl_audio_driver =3D {
+static struct audio_driver sdl_audio_driver =3D {
     .name           =3D "sdl",
     .descr          =3D "SDL http://www.libsdl.org",
     .options        =3D sdl_options,
@@ -513,3 +513,9 @@ struct audio_driver sdl_audio_driver =3D {
     .voice_size_out =3D sizeof (SDLVoiceOut),
     .voice_size_in  =3D 0
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
@@ -391,7 +391,7 @@ static struct audio_pcm_ops audio_callbacks =3D {
     .ctl_in   =3D line_in_ctl,
 };
=20
-struct audio_driver spice_audio_driver =3D {
+static struct audio_driver spice_audio_driver =3D {
     .name           =3D "spice",
     .descr          =3D "spice audio driver",
     .options        =3D audio_options,
@@ -411,3 +411,9 @@ void qemu_spice_audio_init (void)
 {
     spice_audio_driver.can_be_default =3D 1;
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
@@ -278,7 +278,7 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
     .ctl_out  =3D wav_ctl_out,
 };
=20
-struct audio_driver wav_audio_driver =3D {
+static struct audio_driver wav_audio_driver =3D {
     .name           =3D "wav",
     .descr          =3D "WAV renderer http://wikipedia.org/wiki/WAV",
     .options        =3D wav_options,
@@ -291,3 +291,9 @@ struct audio_driver wav_audio_driver =3D {
     .voice_size_out =3D sizeof (WAVVoiceOut),
     .voice_size_in  =3D 0
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
     drivers=3D${line#*=3D}
     echo "#define CONFIG_AUDIO_DRIVERS \\"
     for drv in $drivers; do
-      echo "    &${drv}_audio_driver,\\"
+      echo "    \"${drv}\",\\"
     done
     echo ""
     ;;
--=20
2.9.3
