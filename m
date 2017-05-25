Received: from eggs.gnu.org ([2001:4830:134:3::10]:46028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtmA-0004Br-Tt
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dDtm9-0007XE-9C
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:30:06 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dDtm8-0007Wr-TX
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:30:05 -0400
Received: by mail-lf0-x241.google.com with SMTP id 99so13517911lfu.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 07:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <1495198042-124203-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495198042-124203-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495198042-124203-2-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 May 2017 14:29:53 +0000
Message-ID: <CAJ+F1CLqDzwo2caHOWtTGSrdVv4kxrb_q+AcxPANG33WLsOzxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/9] char: move QemuOpts->ChardevBackend
 translation to a separate func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com

Hi

On Fri, May 19, 2017 at 4:51 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  chardev/char.c | 72
> +++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 46 insertions(+), 26 deletions(-)
>

Motivation is the upcoming patch for hmp_chardev_change()


>
> diff --git a/chardev/char.c b/chardev/char.c
> index 4e24dc3..684cccd 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -854,17 +854,14 @@ help_string_append(const char *name, void *opaque)
>      g_string_append_printf(str, "\n%s", name);
>  }
>
> -Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> -                                Error **errp)
> +static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> +                                           Error **errp)
>

while at it, make it a single line?


>  {
>      Error *local_err =3D NULL;
>      const ChardevClass *cc;
> -    Chardev *chr;
>      int i;
>      ChardevBackend *backend =3D NULL;
>      const char *name =3D qemu_opt_get(opts, "backend");
> -    const char *id =3D qemu_opts_id(opts);
> -    char *bid =3D NULL;
>
>      if (name =3D=3D NULL) {
>          error_setg(errp, "chardev: \"%s\" missing backend",
> @@ -872,21 +869,6 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>          return NULL;
>      }
>
> -    if (is_help_option(name)) {
> -        GString *str =3D g_string_new("");
> -
> -        chardev_name_foreach(help_string_append, str);
> -
> -        error_report("Available chardev backend types: %s", str->str);
> -        g_string_free(str, true);
> -        exit(0);
> -    }
> -
> -    if (id =3D=3D NULL) {
> -        error_setg(errp, "chardev: no id specified");
> -        return NULL;
> -    }
> -
>      for (i =3D 0; i < ARRAY_SIZE(chardev_alias_table); i++) {
>          if (g_strcmp0(chardev_alias_table[i].alias, name) =3D=3D 0) {
>              name =3D chardev_alias_table[i].typename;
> @@ -902,16 +884,12 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>      backend =3D g_new0(ChardevBackend, 1);
>      backend->type =3D CHARDEV_BACKEND_KIND_NULL;
>
> -    if (qemu_opt_get_bool(opts, "mux", 0)) {
> -        bid =3D g_strdup_printf("%s-base", id);
> -    }
> -
> -    chr =3D NULL;
>      if (cc->parse) {
>          cc->parse(opts, backend, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> -            goto out;
> +            qapi_free_ChardevBackend(backend);
> +            return NULL;
>          }
>      } else {
>          ChardevCommon *ccom =3D g_new0(ChardevCommon, 1);
> @@ -919,6 +897,48 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>          backend->u.null.data =3D ccom; /* Any ChardevCommon member would
> work */
>      }
>
> +    return backend;
> +}
> +
> +Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
> +                                Error **errp)
>

same here


> +{
> +    const ChardevClass *cc;
> +    Chardev *chr =3D NULL;
> +    ChardevBackend *backend =3D NULL;
> +    const char *name =3D qemu_opt_get(opts, "backend");
> +    const char *id =3D qemu_opts_id(opts);
> +    char *bid =3D NULL;
> +
> +    if (name && is_help_option(name)) {
> +        GString *str =3D g_string_new("");
> +
> +        chardev_name_foreach(help_string_append, str);
> +
> +        error_report("Available chardev backend types: %s", str->str);
> +        g_string_free(str, true);
> +        exit(0);
> +    }
> +
> +    if (id =3D=3D NULL) {
> +        error_setg(errp, "chardev: no id specified");
> +        return NULL;
> +    }
> +
> +    backend =3D qemu_chr_parse_opts(opts, errp);
> +    if (backend =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    cc =3D char_get_class(name, errp);
> +    if (cc =3D=3D NULL) {
> +        goto out;
> +    }
> +
> +    if (qemu_opt_get_bool(opts, "mux", 0)) {
> +        bid =3D g_strdup_printf("%s-base", id);
> +    }
> +
>      chr =3D qemu_chardev_new(bid ? bid : id,
>                             object_class_get_name(OBJECT_CLASS(cc)),
>                             backend, errp);
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
