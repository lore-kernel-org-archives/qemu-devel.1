Received: from eggs.gnu.org ([2001:4830:134:3::10]:42844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT5sq-0002d2-GA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT5sp-0003Ro-DQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:27:48 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dT5so-0003RY-WB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:27:47 -0400
Received: by mail-lf0-x242.google.com with SMTP id g21so93718lfk.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 05:27:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499342940-56739-2-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499342940-56739-2-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jul 2017 05:27:44 -0700
Message-ID: <CAJ+F1CK0uS=sprf3SX7DRg3-_RyqQ_qZna1uL80DdDVgjirjKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/13] char: move
 QemuOpts->ChardevBackend translation to a separate func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, den@virtuozzo.com, amit@kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jul 6, 2017 at 5:08 AM, Anton Nefedov
<anton.nefedov@virtuozzo.com> wrote:
> parse function will be used by the following patch
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  chardev/char.c | 81 ++++++++++++++++++++++++++++++++++++----------------=
------
>  1 file changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 2b679a2..839eff6 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -556,17 +556,23 @@ help_string_append(const char *name, void *opaque)
>      g_string_append_printf(str, "\n%s", name);
>  }
>
> -Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> -                                Error **errp)
> +static const char *chardev_alias_translate(const char *name)
> +{
> +    int i;
> +    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
> +        if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
> +            return chardev_alias_table[i].typename;
> +        }
> +    }
> +    return name;
> +}
> +
> +static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      const ChardevClass *cc;
> -    Chardev *chr;
> -    int i;
>      ChardevBackend *backend =3D NULL;
> -    const char *name =3D qemu_opt_get(opts, "backend");
> -    const char *id =3D qemu_opts_id(opts);
> -    char *bid =3D NULL;
> +    const char *name =3D chardev_alias_translate(qemu_opt_get(opts, "bac=
kend"));
>
>      if (name =3D=3D NULL) {
>          error_setg(errp, "chardev: \"%s\" missing backend",
> @@ -574,7 +580,40 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>          return NULL;
>      }
>
> -    if (is_help_option(name)) {
> +    cc =3D char_get_class(name, errp);
> +    if (cc =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    backend =3D g_new0(ChardevBackend, 1);
> +    backend->type =3D CHARDEV_BACKEND_KIND_NULL;
> +
> +    if (cc->parse) {
> +        cc->parse(opts, backend, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            qapi_free_ChardevBackend(backend);
> +            return NULL;
> +        }
> +    } else {
> +        ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
> +        qemu_chr_parse_common(opts, ccom);
> +        backend->u.null.data =3D ccom; /* Any ChardevCommon member would=
 work */
> +    }
> +
> +    return backend;
> +}
> +
> +Chardev *qemu_chr_new_from_opts(QemuOpts *opts, Error **errp)
> +{
> +    const ChardevClass *cc;
> +    Chardev *chr =3D NULL;
> +    ChardevBackend *backend =3D NULL;
> +    const char *name =3D chardev_alias_translate(qemu_opt_get(opts, "bac=
kend"));
> +    const char *id =3D qemu_opts_id(opts);
> +    char *bid =3D NULL;
> +
> +    if (name && is_help_option(name)) {
>          GString *str =3D g_string_new("");
>
>          chardev_name_foreach(help_string_append, str);
> @@ -589,38 +628,20 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>          return NULL;
>      }
>
> -    for (i =3D 0; i < (int)ARRAY_SIZE(chardev_alias_table); i++) {
> -        if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
> -            name =3D chardev_alias_table[i].typename;
> -            break;
> -        }
> +    backend =3D qemu_chr_parse_opts(opts, errp);
> +    if (backend =3D=3D NULL) {
> +        return NULL;
>      }
>
>      cc =3D char_get_class(name, errp);
>      if (cc =3D=3D NULL) {
> -        return NULL;
> +        goto out;
>      }

Looks like this change wasn't needed though

>
> -    backend =3D g_new0(ChardevBackend, 1);
> -    backend->type =3D CHARDEV_BACKEND_KIND_NULL;
> -
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>          bid =3D g_strdup_printf("%s-base", id);
>      }
>
> -    chr =3D NULL;
> -    if (cc->parse) {
> -        cc->parse(opts, backend, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            goto out;
> -        }
> -    } else {
> -        ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
> -        qemu_chr_parse_common(opts, ccom);
> -        backend->u.null.data =3D ccom; /* Any ChardevCommon member would=
 work */
> -    }
> -
>      chr =3D qemu_chardev_new(bid ? bid : id,
>                             object_class_get_name(OBJECT_CLASS(cc)),
>                             backend, errp);
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
