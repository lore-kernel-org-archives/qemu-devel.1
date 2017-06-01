Received: from eggs.gnu.org ([2001:4830:134:3::10]:47935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGKI7-0003hs-LU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGKI5-0006Wz-QT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:13:07 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGKI5-0006VA-Bc
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:13:05 -0400
Received: by mail-lf0-x242.google.com with SMTP id u62so997242lfg.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 00:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-11-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-11-git-send-email-anton.nefedov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 01 Jun 2017 07:12:53 +0000
Message-ID: <CAJ+F1CLQ_Yi_rzRPSez2xJJVMV_cD_bX79vLVPyWuga8-_T50w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/13] hmp: add hmp analogue for
 qmp-chardev-change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Tue, May 30, 2017 at 6:08 PM Anton Nefedov <anton.nefedov@virtuozzo.com>
wrote:

> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  chardev/char.c        |  2 +-
>  hmp-commands.hx       | 16 ++++++++++++++++
>  hmp.c                 | 34 ++++++++++++++++++++++++++++++++++
>  hmp.h                 |  1 +
>  include/sysemu/char.h | 12 ++++++++++++
>  5 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 2d6e204..1e2a2dd 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -888,7 +888,7 @@ help_string_append(const char *name, void *opaque)
>      g_string_append_printf(str, "\n%s", name);
>  }
>
> -static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      const ChardevClass *cc;
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index baeac47..19bfddd 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1727,6 +1727,22 @@ chardev_add accepts the same parameters as the
> -chardev command line switch.
>  ETEXI
>
>      {
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
> +chardev_change accepts existing chardev @var{id} and then the same
> arguments
>

chardev_change vs chardev-change. Apparently, there is this difference for
chardev-add too


> +as the -chardev command line switch (except for "id").
> +
> +ETEXI
> +
> +    {
>          .name       =3D "chardev-remove",
>          .args_type  =3D "id:s",
>          .params     =3D "id",
> diff --git a/hmp.c b/hmp.c
> index 20f5dab..7660495 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2224,6 +2224,40 @@ void hmp_chardev_add(Monitor *mon, const QDict
> *qdict)
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
,
> args,
> +                                             true);
> +    if (!opts) {
> +        error_setg(&err, "Parsing chardev args failed");
> +        goto end;
> +    }
> +
> +    id =3D qdict_get_str(qdict, "id");
> +    if (qemu_opts_id(opts)) {
> +        error_setg(&err, "Unexpected 'id' parameter");
>

enlighten me, how is this triggered?


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
> diff --git a/hmp.h b/hmp.h
> index d8b94ce..23e035c 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict
> *qdict);
>  void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
>  void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_add(Monitor *mon, const QDict *qdict);
> +void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>  void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
>  void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>  void hmp_cpu_add(Monitor *mon, const QDict *qdict);
> diff --git a/include/sysemu/char.h b/include/sysemu/char.h
> index 342f531..18fcd26 100644
> --- a/include/sysemu/char.h
> +++ b/include/sysemu/char.h
> @@ -131,6 +131,18 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>  void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
>
>  /**
> + * @qemu_chr_parse_opts:
> + *
> + * Parse the options to the ChardevBackend struct.
> + *
> + * @opts
> + *
>

You may remove that line


> + * Returns: a new backend
>

or NULL on error


> + */
> +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
> +                                    Error **errp);
> +
> +/**
>   * @qemu_chr_new:
>   *
>   * Create a new character backend from a URI.
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
