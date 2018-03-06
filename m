Received: from eggs.gnu.org ([2001:4830:134:3::10]:46900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAIz-0001Es-Li
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAIx-0001ec-LD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:58:49 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etAIx-0001eH-Ar
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:58:47 -0500
Received: by mail-wr0-x242.google.com with SMTP id m12so20423626wrm.13
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 02:58:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306074053.22856-2-kraxel@redhat.com>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<20180306074053.22856-2-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 11:58:45 +0100
Message-ID: <CAJ+F1C+9D5dkKKYsoHvix5uC+RtJRNykEh2j7Q7oKZ8dOu2qeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] audio: add driver registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Mar 6, 2018 at 8:40 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add registry for audio drivers, using the existing audio_driver struct.
> Make all drivers register themself.  The old list of audio_driver struct
> pointers is now a list of audio driver names, specifying the priority
> (aka probe order) in case no driver is explicitly asked for.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/audio_int.h     | 14 ++++--------
>  audio/alsaaudio.c     |  8 ++++++-
>  audio/audio.c         | 63 ++++++++++++++++++++++++++++++---------------=
------
>  audio/coreaudio.c     |  8 ++++++-
>  audio/dsoundaudio.c   |  8 ++++++-
>  audio/noaudio.c       |  8 ++++++-
>  audio/ossaudio.c      |  8 ++++++-
>  audio/paaudio.c       |  8 ++++++-
>  audio/sdlaudio.c      |  8 ++++++-
>  audio/spiceaudio.c    |  8 ++++++-
>  audio/wavaudio.c      |  8 ++++++-
>  scripts/create_config |  2 +-
>  12 files changed, 106 insertions(+), 45 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 700bd43143..244b454012 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -141,6 +141,7 @@ struct SWVoiceIn {
>      QLIST_ENTRY (SWVoiceIn) entries;
>  };
>
> +typedef struct audio_driver audio_driver;
>  struct audio_driver {
>      const char *name;
>      const char *descr;
> @@ -154,6 +155,7 @@ struct audio_driver {
>      int voice_size_out;
>      int voice_size_in;
>      int ctl_caps;
> +    QLIST_ENTRY(audio_driver) next;
>  };
>
>  struct audio_pcm_ops {
> @@ -203,17 +205,11 @@ struct AudioState {
>      int vm_running;
>  };
>
> -extern struct audio_driver no_audio_driver;
> -extern struct audio_driver oss_audio_driver;
> -extern struct audio_driver sdl_audio_driver;
> -extern struct audio_driver wav_audio_driver;
> -extern struct audio_driver alsa_audio_driver;
> -extern struct audio_driver coreaudio_audio_driver;
> -extern struct audio_driver dsound_audio_driver;
> -extern struct audio_driver pa_audio_driver;
> -extern struct audio_driver spice_audio_driver;
>  extern const struct mixeng_volume nominal_volume;
>
> +void audio_driver_register(audio_driver *drv);
> +audio_driver *audio_driver_lookup(const char *name);
> +
>  void audio_pcm_init_info (struct audio_pcm_info *info, struct audsetting=
s *as);
>  void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, i=
nt len);
>
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 92a96f8b2b..362a2276fd 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -1213,7 +1213,7 @@ static struct audio_pcm_ops alsa_pcm_ops =3D {
>      .ctl_in   =3D alsa_ctl_in,
>  };
>
> -struct audio_driver alsa_audio_driver =3D {
> +static struct audio_driver alsa_audio_driver =3D {
>      .name           =3D "alsa",
>      .descr          =3D "ALSA http://www.alsa-project.org",
>      .options        =3D alsa_options,
> @@ -1226,3 +1226,9 @@ struct audio_driver alsa_audio_driver =3D {
>      .voice_size_out =3D sizeof (ALSAVoiceOut),
>      .voice_size_in  =3D sizeof (ALSAVoiceIn)
>  };
> +
> +static void register_audio_alsa(void)
> +{
> +    audio_driver_register(&alsa_audio_driver);
> +}
> +type_init(register_audio_alsa);
> diff --git a/audio/audio.c b/audio/audio.c
> index 7658d2af66..2384612b87 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -45,15 +45,32 @@
>     The 1st one is the one used by default, that is the reason
>      that we generate the list.
>  */
> -static struct audio_driver *drvtab[] =3D {
> -#ifdef CONFIG_SPICE
> -    &spice_audio_driver,
> -#endif
> +static const char *audio_prio_list[] =3D {
> +    "spice",
>      CONFIG_AUDIO_DRIVERS
> -    &no_audio_driver,
> -    &wav_audio_driver
> +    "none",
> +    "wav",
>  };
>
> +static QLIST_HEAD(, audio_driver) audio_drivers;
> +
> +void audio_driver_register(audio_driver *drv)
> +{
> +    QLIST_INSERT_HEAD(&audio_drivers, drv, next);
> +}
> +
> +audio_driver *audio_driver_lookup(const char *name)
> +{
> +    struct audio_driver *d;
> +
> +    QLIST_FOREACH(d, &audio_drivers, next) {
> +        if (strcmp(name, d->name) =3D=3D 0) {
> +            return d;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  struct fixed_settings {
>      int enabled;
>      int nb_voices;
> @@ -1656,11 +1673,10 @@ static void audio_pp_nb_voices (const char *typ, =
int nb)
>
>  void AUD_help (void)
>  {
> -    size_t i;
> +    struct audio_driver *d;
>
>      audio_process_options ("AUDIO", audio_options);
> -    for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
> -        struct audio_driver *d =3D drvtab[i];
> +    QLIST_FOREACH(d, &audio_drivers, next) {
>          if (d->options) {
>              audio_process_options (d->name, d->options);
>          }
> @@ -1672,8 +1688,7 @@ void AUD_help (void)
>
>      printf ("Available drivers:\n");
>
> -    for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
> -        struct audio_driver *d =3D drvtab[i];
> +    QLIST_FOREACH(d, &audio_drivers, next) {
>
>          printf ("Name: %s\n", d->name);
>          printf ("Description: %s\n", d->descr);
> @@ -1807,6 +1822,7 @@ static void audio_init (void)
>      const char *drvname;
>      VMChangeStateEntry *e;
>      AudioState *s =3D &glob_audio_state;
> +    struct audio_driver *driver;
>
>      if (s->drv) {
>          return;
> @@ -1842,32 +1858,27 @@ static void audio_init (void)
>      }
>
>      if (drvname) {
> -        int found =3D 0;
> -
> -        for (i =3D 0; i < ARRAY_SIZE (drvtab); i++) {
> -            if (!strcmp (drvname, drvtab[i]->name)) {
> -                done =3D !audio_driver_init (s, drvtab[i]);
> -                found =3D 1;
> -                break;
> -            }
> -        }
> -
> -        if (!found) {
> +        driver =3D audio_driver_lookup(drvname);
> +        if (driver) {
> +            done =3D !audio_driver_init(s, driver);
> +        } else {
>              dolog ("Unknown audio driver `%s'\n", drvname);
>              dolog ("Run with -audio-help to list available drivers\n");
>          }
>      }
>
>      if (!done) {
> -        for (i =3D 0; !done && i < ARRAY_SIZE (drvtab); i++) {
> -            if (drvtab[i]->can_be_default) {
> -                done =3D !audio_driver_init (s, drvtab[i]);
> +        for (i =3D 0; !done && i < ARRAY_SIZE(audio_prio_list); i++) {
> +            driver =3D audio_driver_lookup(audio_prio_list[i]);
> +            if (driver && driver->can_be_default) {
> +                done =3D !audio_driver_init(s, driver);
>              }
>          }
>      }
>
>      if (!done) {
> -        done =3D !audio_driver_init (s, &no_audio_driver);
> +        driver =3D audio_driver_lookup("none");
> +        done =3D !audio_driver_init(s, driver);
>          assert(done);
>          dolog("warning: Using timer based audio emulation\n");
>      }
> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
> index c75142084f..638c60b300 100644
> --- a/audio/coreaudio.c
> +++ b/audio/coreaudio.c
> @@ -722,7 +722,7 @@ static struct audio_pcm_ops coreaudio_pcm_ops =3D {
>      .ctl_out  =3D coreaudio_ctl_out
>  };
>
> -struct audio_driver coreaudio_audio_driver =3D {
> +static struct audio_driver coreaudio_audio_driver =3D {
>      .name           =3D "coreaudio",
>      .descr          =3D "CoreAudio http://developer.apple.com/audio/core=
audio.html",
>      .options        =3D coreaudio_options,
> @@ -735,3 +735,9 @@ struct audio_driver coreaudio_audio_driver =3D {
>      .voice_size_out =3D sizeof (coreaudioVoiceOut),
>      .voice_size_in  =3D 0
>  };
> +
> +static void register_audio_coreaudio(void)
> +{
> +    audio_driver_register(&coreaudio_audio_driver);
> +}
> +type_init(register_audio_coreaudio);
> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index bc39cb9b4d..3ed73a30d1 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -890,7 +890,7 @@ static struct audio_pcm_ops dsound_pcm_ops =3D {
>      .ctl_in   =3D dsound_ctl_in
>  };
>
> -struct audio_driver dsound_audio_driver =3D {
> +static struct audio_driver dsound_audio_driver =3D {
>      .name           =3D "dsound",
>      .descr          =3D "DirectSound http://wikipedia.org/wiki/DirectSou=
nd",
>      .options        =3D dsound_options,
> @@ -903,3 +903,9 @@ struct audio_driver dsound_audio_driver =3D {
>      .voice_size_out =3D sizeof (DSoundVoiceOut),
>      .voice_size_in  =3D sizeof (DSoundVoiceIn)
>  };
> +
> +static void register_audio_dsound(void)
> +{
> +    audio_driver_register(&dsound_audio_driver);
> +}
> +type_init(register_audio_dsound);
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index 9ca9eaf01f..1bfebeca7d 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -160,7 +160,7 @@ static struct audio_pcm_ops no_pcm_ops =3D {
>      .ctl_in   =3D no_ctl_in
>  };
>
> -struct audio_driver no_audio_driver =3D {
> +static struct audio_driver no_audio_driver =3D {
>      .name           =3D "none",
>      .descr          =3D "Timer based audio emulation",
>      .options        =3D NULL,
> @@ -173,3 +173,9 @@ struct audio_driver no_audio_driver =3D {
>      .voice_size_out =3D sizeof (NoVoiceOut),
>      .voice_size_in  =3D sizeof (NoVoiceIn)
>  };
> +
> +static void register_audio_none(void)
> +{
> +    audio_driver_register(&no_audio_driver);
> +}
> +type_init(register_audio_none);
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index a0428881c2..6c69622b4c 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -922,7 +922,7 @@ static struct audio_pcm_ops oss_pcm_ops =3D {
>      .ctl_in   =3D oss_ctl_in
>  };
>
> -struct audio_driver oss_audio_driver =3D {
> +static struct audio_driver oss_audio_driver =3D {
>      .name           =3D "oss",
>      .descr          =3D "OSS http://www.opensound.com",
>      .options        =3D oss_options,
> @@ -935,3 +935,9 @@ struct audio_driver oss_audio_driver =3D {
>      .voice_size_out =3D sizeof (OSSVoiceOut),
>      .voice_size_in  =3D sizeof (OSSVoiceIn)
>  };
> +
> +static void register_audio_oss(void)
> +{
> +    audio_driver_register(&oss_audio_driver);
> +}
> +type_init(register_audio_oss);
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index aa0a7477d3..949769774d 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -937,7 +937,7 @@ static struct audio_pcm_ops qpa_pcm_ops =3D {
>      .ctl_in   =3D qpa_ctl_in
>  };
>
> -struct audio_driver pa_audio_driver =3D {
> +static struct audio_driver pa_audio_driver =3D {
>      .name           =3D "pa",
>      .descr          =3D "http://www.pulseaudio.org/",
>      .options        =3D qpa_options,
> @@ -951,3 +951,9 @@ struct audio_driver pa_audio_driver =3D {
>      .voice_size_in  =3D sizeof (PAVoiceIn),
>      .ctl_caps       =3D VOICE_VOLUME_CAP
>  };
> +
> +static void register_audio_pa(void)
> +{
> +    audio_driver_register(&pa_audio_driver);
> +}
> +type_init(register_audio_pa);
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index e92135bd2f..9db5ac92bc 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -500,7 +500,7 @@ static struct audio_pcm_ops sdl_pcm_ops =3D {
>      .ctl_out  =3D sdl_ctl_out,
>  };
>
> -struct audio_driver sdl_audio_driver =3D {
> +static struct audio_driver sdl_audio_driver =3D {
>      .name           =3D "sdl",
>      .descr          =3D "SDL http://www.libsdl.org",
>      .options        =3D sdl_options,
> @@ -513,3 +513,9 @@ struct audio_driver sdl_audio_driver =3D {
>      .voice_size_out =3D sizeof (SDLVoiceOut),
>      .voice_size_in  =3D 0
>  };
> +
> +static void register_audio_sdl(void)
> +{
> +    audio_driver_register(&sdl_audio_driver);
> +}
> +type_init(register_audio_sdl);
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index 5580e76307..6ad0eafbc6 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -391,7 +391,7 @@ static struct audio_pcm_ops audio_callbacks =3D {
>      .ctl_in   =3D line_in_ctl,
>  };
>
> -struct audio_driver spice_audio_driver =3D {
> +static struct audio_driver spice_audio_driver =3D {
>      .name           =3D "spice",
>      .descr          =3D "spice audio driver",
>      .options        =3D audio_options,
> @@ -411,3 +411,9 @@ void qemu_spice_audio_init (void)
>  {
>      spice_audio_driver.can_be_default =3D 1;
>  }
> +
> +static void register_audio_spice(void)
> +{
> +    audio_driver_register(&spice_audio_driver);
> +}
> +type_init(register_audio_spice);
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 068a595732..40adfa30c3 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -278,7 +278,7 @@ static struct audio_pcm_ops wav_pcm_ops =3D {
>      .ctl_out  =3D wav_ctl_out,
>  };
>
> -struct audio_driver wav_audio_driver =3D {
> +static struct audio_driver wav_audio_driver =3D {
>      .name           =3D "wav",
>      .descr          =3D "WAV renderer http://wikipedia.org/wiki/WAV",
>      .options        =3D wav_options,
> @@ -291,3 +291,9 @@ struct audio_driver wav_audio_driver =3D {
>      .voice_size_out =3D sizeof (WAVVoiceOut),
>      .voice_size_in  =3D 0
>  };
> +
> +static void register_audio_wav(void)
> +{
> +    audio_driver_register(&wav_audio_driver);
> +}
> +type_init(register_audio_wav);
> diff --git a/scripts/create_config b/scripts/create_config
> index 603b826886..d727e5e36e 100755
> --- a/scripts/create_config
> +++ b/scripts/create_config
> @@ -36,7 +36,7 @@ case $line in
>      drivers=3D${line#*=3D}
>      echo "#define CONFIG_AUDIO_DRIVERS \\"
>      for drv in $drivers; do
> -      echo "    &${drv}_audio_driver,\\"
> +      echo "    \"${drv}\",\\"
>      done
>      echo ""
>      ;;
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
