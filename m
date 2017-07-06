Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT6Sm-0008K5-Eg
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dT6Sl-0005No-6j
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:04:56 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:33870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dT6Sk-0005NF-Qp
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:04:55 -0400
Received: by mail-lf0-x243.google.com with SMTP id g21so257758lfk.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 06:04:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499342940-56739-11-git-send-email-anton.nefedov@virtuozzo.com>
References: <1499342940-56739-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1499342940-56739-11-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Jul 2017 06:04:52 -0700
Message-ID: <CAJ+F1CK+x-mdQ9dSkrOv6RLFpH+EUHkyDbSxXvrGqTNuuhDJRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 10/13] hmp: add hmp analogue for
 qmp-chardev-change
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
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/chardev/char.h | 10 ++++++++++
>  hmp.h                  |  1 +
>  chardev/char.c         |  2 +-
>  hmp-commands.hx        | 18 +++++++++++++++++-
>  hmp.c                  | 34 ++++++++++++++++++++++++++++++++++
>  tests/test-hmp.c       |  1 +
>  6 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 22fd734..1604ea9 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -81,6 +81,16 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>  void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
>
>  /**
> + * @qemu_chr_parse_opts:
> + *
> + * Parse the options to the ChardevBackend struct.
> + *
> + * Returns: a new backend or NULL on error
> + */
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> +                                    Error **errp);
> +
> +/**
>   * @qemu_chr_new:
>   *
>   * Create a new character backend from a URI.
> diff --git a/hmp.h b/hmp.h
> index 214b261..1ff4552 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *=
qdict);
>  void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
> +void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict);
> diff --git a/chardev/char.c b/chardev/char.c
> index d6b9d89..c34b44a 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -567,7 +567,7 @@ static const char *chardev_alias_translate(const char=
 *name)
>      return name;
>  }
>
> -static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      const ChardevClass *cc;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 275ccdf..c4c96db 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1724,7 +1724,23 @@ ETEXI
>  STEXI
>  @item chardev-add args
>  @findex chardev-add
> -chardev_add accepts the same parameters as the -chardev command line swi=
tch.
> +chardev-add accepts the same parameters as the -chardev command line swi=
tch.
> +
> +ETEXI
> +
> +    {
> +        .name       =3D "chardev-change",
> +        .args_type  =3D "id:s,args:s",
> +        .params     =3D "id args",
> +        .help       =3D "change chardev",
> +        .cmd        =3D hmp_chardev_change,
> +    },
> +
> +STEXI
> +@item chardev-change args
> +@findex chardev-change
> +chardev-change accepts existing chardev @var{id} and then the same argum=
ents
> +as the -chardev command line switch (except for "id").
>
>  ETEXI
>
> diff --git a/hmp.c b/hmp.c
> index dee4028..1b443e1 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2228,6 +2228,40 @@ void hmp_chardev_add(Monitor *mon, const QDict *qd=
ict)
>      hmp_handle_error(mon, &err);
>  }
>
> +void hmp_chardev_change(Monitor *mon, const QDict *qdict)
> +{
> +    const char *args =3D qdict_get_str(qdict, "args");
> +    const char *id;
> +    Error *err =3D NULL;
> +    ChardevBackend *backend =3D NULL;
> +    ChardevReturn *ret =3D NULL;
> +    QemuOpts *opts =3D qemu_opts_parse_noisily(qemu_find_opts("chardev")=
, args,
> +                                             true);
> +    if (!opts) {
> +        error_setg(&err, "Parsing chardev args failed");
> +        goto end;
> +    }
> +
> +    id =3D qdict_get_str(qdict, "id");
> +    if (qemu_opts_id(opts)) {
> +        error_setg(&err, "Unexpected 'id' parameter");
> +        goto end;
> +    }
> +
> +    backend =3D qemu_chr_parse_opts(opts, &err);
> +    if (!backend) {
> +        goto end;
> +    }
> +
> +    ret =3D qmp_chardev_change(id, backend, &err);
> +
> +end:
> +    qapi_free_ChardevReturn(ret);
> +    qapi_free_ChardevBackend(backend);
> +    qemu_opts_del(opts);
> +    hmp_handle_error(mon, &err);
> +}
> +
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
>  {
>      Error *local_err =3D NULL;
> diff --git a/tests/test-hmp.c b/tests/test-hmp.c
> index 6dfa0c3..d77b3c8 100644
> --- a/tests/test-hmp.c
> +++ b/tests/test-hmp.c
> @@ -23,6 +23,7 @@ static const char *hmp_cmds[] =3D {
>      "boot_set ndc",
>      "chardev-add null,id=3Dtestchardev1",
>      "chardev-send-break testchardev2",
> +    "chardev-change testchardev1 ringbuf",
>      "chardev-remove testchardev1",
>      "commit all",
>      "cpu-add 1",
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
