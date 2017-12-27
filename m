Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUAm7-0004dU-0p
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 07:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eUAm4-0007q7-8e
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 07:25:34 -0500
Received: from mail-he1eur01on0139.outbound.protection.outlook.com
	([104.47.0.139]:62784
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eUAm2-0007mT-Qy
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 07:25:31 -0500
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b3ccb2a7-efe3-2b0b-62ee-a3ab126e0205@virtuozzo.com>
Date: Wed, 27 Dec 2017 15:25:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170801160419.14180-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi all!

Hmm, looks like leak is not fixed here: I've checked it while running=20
iotest 181, that
migration_instance_finalize is not called.

If I understand correct, to call it we need unref current_migration=20
object somewhere.

Or, may be I'm missing something..

01.08.2017 19:04, Marc-Andr=C3=A9 Lureau wrote:
> Spotted thanks to valgrind and tests/device-introspect-test:
>
> =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss record =
6 of 14,537
> =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:299)
> =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
> =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
> =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migration.c:22=
26)
> =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c:344)
> =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (object.c:3=
75)
> =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:483)
> =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
> =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp.c:542)
> =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_properties (qmp=
-marshal.c:1425)
> =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c:104)
> =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:131)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/migration.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 085c32c994..c3fe0ed9ca 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2214,6 +2214,15 @@ static void migration_class_init(ObjectClass *klas=
s, void *data)
>       dc->props =3D migration_properties;
>   }
>  =20
> +static void migration_instance_finalize(Object *obj)
> +{
> +    MigrationState *ms =3D MIGRATION_OBJ(obj);
> +    MigrationParameters *params =3D &ms->parameters;
> +
> +    g_free(params->tls_hostname);
> +    g_free(params->tls_creds);
> +}
> +
>   static void migration_instance_init(Object *obj)
>   {
>       MigrationState *ms =3D MIGRATION_OBJ(obj);
> @@ -2282,6 +2291,7 @@ static const TypeInfo migration_type =3D {
>       .class_size =3D sizeof(MigrationClass),
>       .instance_size =3D sizeof(MigrationState),
>       .instance_init =3D migration_instance_init,
> +    .instance_finalize =3D migration_instance_finalize,
>   };
>  =20
>   static void register_migration_types(void)


--=20
Best regards,
Vladimir
