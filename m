Received: from eggs.gnu.org ([2001:4830:134:3::10]:46934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAJG-0001PX-JE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAJF-0001nN-OW
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:59:06 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:55380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etAJF-0001n5-GK
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:59:05 -0500
Received: by mail-wm0-x241.google.com with SMTP id q83so21965716wme.5
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 02:59:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306074053.22856-3-kraxel@redhat.com>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<20180306074053.22856-3-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 11:59:03 +0100
Message-ID: <CAJ+F1CJ9a_z7D244TfZ8jJzQ+v47UR=PVCJhdxVWj2RVvcuSnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] audio: add module loading support
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
> Make audio_driver_lookup() try load the module in case it doesn't find
> the driver in the registry.  Also load all modules for -audio-help, so
> the help output includes the help text for modular audio drivers.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/qemu/module.h |  1 +
>  audio/audio.c         | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 9fea75aaeb..54300ab6e5 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -54,6 +54,7 @@ typedef enum {
>
>  #define block_module_load_one(lib) module_load_one("block-", lib)
>  #define ui_module_load_one(lib) module_load_one("ui-", lib)
> +#define audio_module_load_one(lib) module_load_one("audio-", lib)
>
>  void register_module_init(void (*fn)(void), module_init_type type);
>  void register_dso_module_init(void (*fn)(void), module_init_type type);
> diff --git a/audio/audio.c b/audio/audio.c
> index 2384612b87..6eccdb17ee 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -68,9 +68,26 @@ audio_driver *audio_driver_lookup(const char *name)
>              return d;
>          }
>      }
> +
> +    audio_module_load_one(name);
> +    QLIST_FOREACH(d, &audio_drivers, next) {
> +        if (strcmp(name, d->name) =3D=3D 0) {
> +            return d;
> +        }
> +    }
> +
>      return NULL;
>  }
>
> +static void audio_module_load_all(void)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(audio_prio_list); i++) {
> +        audio_driver_lookup(audio_prio_list[i]);
> +    }
> +}
> +
>  struct fixed_settings {
>      int enabled;
>      int nb_voices;
> @@ -1675,6 +1692,9 @@ void AUD_help (void)
>  {
>      struct audio_driver *d;
>
> +    /* make sure we print the help text for modular drivers too */
> +    audio_module_load_all();
> +
>      audio_process_options ("AUDIO", audio_options);
>      QLIST_FOREACH(d, &audio_drivers, next) {
>          if (d->options) {
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
