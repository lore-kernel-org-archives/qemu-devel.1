Received: from eggs.gnu.org ([2001:4830:134:3::10]:56261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX43i-0000Nw-3I
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX43b-0000NK-G1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:19:26 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dX43b-0000LZ-4t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:19:19 -0400
Received: by mail-lf0-x241.google.com with SMTP id t72so12945880lff.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 04:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <1500288755-76809-1-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1500288755-76809-1-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2017 11:19:06 +0000
Message-ID: <CAJ+F1CKTaKQCVe8WsV2kYWx1nPuJUpcOZAUUPvXRwq0DiJry7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: don't exit on hmp 'chardev-add help'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, dgilbert@redhat.com

Hi

On Mon, Jul 17, 2017 at 12:56 PM Anton Nefedov <anton.nefedov@virtuozzo.com=
>
wrote:

> qemu_chr_new_from_opts() is used from both vl.c and hmp,
> and it is quite confusing to see qemu suddenly exit after receiving a hel=
p
> option in hmp.
>
> Create a separate function for printing help and let different callers
> react accordingly.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>
---
>  include/chardev/char.h |  9 +++++++++
>  chardev/char.c         | 27 +++++++++++++++++++--------
>  vl.c                   |  4 ++++
>  3 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 1604ea9..461962b 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -59,6 +59,15 @@ struct Chardev {
>  };
>
>  /**
> + * @qemu_chr_help:
> + *
> + * Print available chardevice backends if 'asked for help' in @opts
> + *
> + * Returns: true if there was a help option
> + */
> +bool qemu_chr_help(QemuOpts *opts);
> +
> +/**
>   * @qemu_chr_new_from_opts:
>   *
>   * Create a new character backend from a QemuOpts list.
> diff --git a/chardev/char.c b/chardev/char.c
> index c34b44a..19833fe 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -604,14 +604,9 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> Error **errp)
>      return backend;
>  }
>
> -Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
> +bool qemu_chr_help(QemuOpts *opts)
>  {
> -    const ChardevClass *cc;
> -    Chardev *chr =3D NULL;
> -    ChardevBackend *backend =3D NULL;
> -    const char *name =3D chardev_alias_translate(qemu_opt_get(opts,
> "backend"));
> -    const char *id =3D qemu_opts_id(opts);
> -    char *bid =3D NULL;
> +    const char *name =3D qemu_opt_get(opts, "backend");
>
>      if (name && is_help_option(name)) {
>          GString *str =3D g_string_new("");
> @@ -620,7 +615,23 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Erro=
r
> **errp)
>
>          error_report("Available chardev backend types: %s", str->str);
>          g_string_free(str, true);
> -        exit(0);
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
> +{
> +    const ChardevClass *cc;
> +    Chardev *chr =3D NULL;
> +    ChardevBackend *backend =3D NULL;
> +    const char *name =3D chardev_alias_translate(qemu_opt_get(opts,
> "backend"));
> +    const char *id =3D qemu_opts_id(opts);
> +    char *bid =3D NULL;
> +
> +    if (qemu_chr_help(opts)) {
> +        return NULL;
>      }
>
>      if (id =3D=3D NULL) {
> diff --git a/vl.c b/vl.c
> index fb6b2ef..7cad539 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2344,6 +2344,10 @@ static int chardev_init_func(void *opaque, QemuOpt=
s
> *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
>
> +    if (qemu_chr_help(opts)) {
> +        exit(0);
> +    }
> +
>      qemu_chr_new_from_opts(opts, &local_err);
>

It is a bit intriguing to have qemu_chr_help() in two code paths here, but
since it should exit at first, it's not a big deal imho.

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



>      if (local_err) {
>          error_report_err(local_err);
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
