Received: from eggs.gnu.org ([2001:4830:134:3::10]:38071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGODq-0007ZS-1c
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGODm-0004Jv-Rp
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:24:58 -0400
Received: from mail-eopbgr20099.outbound.protection.outlook.com
	([40.107.2.99]:21600
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dGODm-0004IE-CQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:24:54 -0400
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496152683-102751-11-git-send-email-anton.nefedov@virtuozzo.com>
	<CAJ+F1CLQ_Yi_rzRPSez2xJJVMV_cD_bX79vLVPyWuga8-_T50w@mail.gmail.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <b4652581-1e1c-91b0-4326-699528d7b0af@virtuozzo.com>
Date: Thu, 1 Jun 2017 14:24:46 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLQ_Yi_rzRPSez2xJJVMV_cD_bX79vLVPyWuga8-_T50w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@virtuozzo.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 06/01/2017 10:12 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, May 30, 2017 at 6:08 PM Anton Nefedov=20
> <anton.nefedov@virtuozzo.com <mailto:anton.nefedov@virtuozzo.com>> wrote:
>=20
>     Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com
>     <mailto:anton.nefedov@virtuozzo.com>>
>     Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com
>     <mailto:vsementsov@virtuozzo.com>>
>     CC: Dr. David Alan Gilbert <dgilbert@redhat.com
>     <mailto:dgilbert@redhat.com>>
>     ---
>       chardev/char.c        |  2 +-
>       hmp-commands.hx       | 16 ++++++++++++++++
>       hmp.c                 | 34 ++++++++++++++++++++++++++++++++++
>       hmp.h                 |  1 +
>       include/sysemu/char.h | 12 ++++++++++++
>       5 files changed, 64 insertions(+), 1 deletion(-)
>=20
>     diff --git a/chardev/char.c b/chardev/char.c
>     index 2d6e204..1e2a2dd 100644
>     --- a/chardev/char.c
>     +++ b/chardev/char.c
>     @@ -888,7 +888,7 @@ help_string_append(const char *name, void *opaque=
)
>           g_string_append_printf(str, "\n%s", name);
>       }
>=20
>     -static ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error
>     **errp)
>     +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts, Error **errp)
>       {
>           Error *local_err =3D NULL;
>           const ChardevClass *cc;
>     diff --git a/hmp-commands.hx b/hmp-commands.hx
>     index baeac47..19bfddd 100644
>     --- a/hmp-commands.hx
>     +++ b/hmp-commands.hx
>     @@ -1727,6 +1727,22 @@ chardev_add accepts the same parameters as
>     the -chardev command line switch.
>       ETEXI
>=20
>           {
>     +        .name       =3D "chardev-change",
>     +        .args_type  =3D "id:s,args:s",
>     +        .params     =3D "id args",
>     +        .help       =3D "change chardev",
>     +        .cmd        =3D hmp_chardev_change,
>     +    },
>     +
>     +STEXI
>     +@item chardev-change args
>     +@findex chardev-change
>     +chardev_change accepts existing chardev @var{id} and then the same
>     arguments
>=20
>=20
> chardev_change vs chardev-change. Apparently, there is this difference=20
> for chardev-add too
>=20

Done.

>     +as the -chardev command line switch (except for "id").
>     +
>     +ETEXI
>     +
>     +    {
>               .name       =3D "chardev-remove",
>               .args_type  =3D "id:s",
>               .params     =3D "id",
>     diff --git a/hmp.c b/hmp.c
>     index 20f5dab..7660495 100644
>     --- a/hmp.c
>     +++ b/hmp.c
>     @@ -2224,6 +2224,40 @@ void hmp_chardev_add(Monitor *mon, const
>     QDict *qdict)
>           hmp_handle_error(mon, &err);
>       }
>=20
>     +void hmp_chardev_change(Monitor *mon, const QDict *qdict)
>     +{
>     +    const char *args =3D qdict_get_str(qdict, "args");
>     +    const char *id;
>     +    Error *err =3D NULL;
>     +    ChardevBackend *backend =3D NULL;
>     +    ChardevReturn *ret =3D NULL;
>     +    QemuOpts *opts =3D
>     qemu_opts_parse_noisily(qemu_find_opts("chardev"), args,
>     +                                             true);
>     +    if (!opts) {
>     +        error_setg(&err, "Parsing chardev args failed");
>     +        goto end;
>     +    }
>     +
>     +    id =3D qdict_get_str(qdict, "id");
>     +    if (qemu_opts_id(opts)) {
>     +        error_setg(&err, "Unexpected 'id' parameter");
>=20
>=20
> enlighten me, how is this triggered?
>=20

correct variant:

   chardev-change char2 pipe,path=3D/tmp/cent.fifo

vs. (without this check)

   (qemu) chardev-change char2 pipe,id=3Dchar2,path=3D/tmp/cent.fifo
   chardev-change char2 pipe,id=3Dchar2,path=3D/tmp/cent.fifo
   Duplicate ID 'char2' for chardev
   Parsing chardev args failed

or

   (qemu) chardev-change char2 pipe,id=3Dnewchar3,path=3D/tmp/cent.fifo

the command would succeed but the user might expect the id to change,
but it wouldn't

>     +        goto end;
>     +    }
>     +
>     +    backend =3D qemu_chr_parse_opts(opts, &err);
>     +    if (!backend) {
>     +        goto end;
>     +    }
>     +
>     +    ret =3D qmp_chardev_change(id, backend, &err);
>     +
>     +end:
>     +    qapi_free_ChardevReturn(ret);
>     +    qapi_free_ChardevBackend(backend);
>     +    qemu_opts_del(opts);
>     +    hmp_handle_error(mon, &err);
>     +}
>     +
>       void hmp_chardev_remove(Monitor *mon, const QDict *qdict)
>       {
>           Error *local_err =3D NULL;
>     diff --git a/hmp.h b/hmp.h
>     index d8b94ce..23e035c 100644
>     --- a/hmp.h
>     +++ b/hmp.h
>     @@ -102,6 +102,7 @@ void hmp_nbd_server_start(Monitor *mon, const
>     QDict *qdict);
>       void hmp_nbd_server_add(Monitor *mon, const QDict *qdict);
>       void hmp_nbd_server_stop(Monitor *mon, const QDict *qdict);
>       void hmp_chardev_add(Monitor *mon, const QDict *qdict);
>     +void hmp_chardev_change(Monitor *mon, const QDict *qdict);
>       void hmp_chardev_remove(Monitor *mon, const QDict *qdict);
>       void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>       void hmp_cpu_add(Monitor *mon, const QDict *qdict);
>     diff --git a/include/sysemu/char.h b/include/sysemu/char.h
>     index 342f531..18fcd26 100644
>     --- a/include/sysemu/char.h
>     +++ b/include/sysemu/char.h
>     @@ -131,6 +131,18 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts,
>       void qemu_chr_parse_common(QemuOpts *opts, ChardevCommon *backend);
>=20
>       /**
>     + * @qemu_chr_parse_opts:
>     + *
>     + * Parse the options to the ChardevBackend struct.
>     + *
>     + * @opts
>     + *
>=20
>=20
> You may remove that line
>=20
>     + * Returns: a new backend
>=20
>=20
> or NULL on error
>=20

Done.

>     + */
>     +ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,
>     +                                    Error **errp);
>     +
>     +/**
>        * @qemu_chr_new:
>        *
>        * Create a new character backend from a URI.
>     --
>     2.7.4
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau

/Anton
