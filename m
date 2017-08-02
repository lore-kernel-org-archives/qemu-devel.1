Received: from eggs.gnu.org ([2001:4830:134:3::10]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcqrs-0001qE-Cb
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcqrp-0005YJ-A2
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcqrp-0005WU-4e
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECA575F795
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 10:27:03 +0000 (UTC)
Date: Wed, 2 Aug 2017 11:26:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170802102658.GA5624@work-vm>
References: <20170801160419.14180-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170801160419.14180-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: fix small leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Spotted thanks to valgrind and tests/device-introspect-test:
>=20
> =3D=3D11711=3D=3D 1 bytes in 1 blocks are definitely lost in loss recor=
d 6 of 14,537
> =3D=3D11711=3D=3D    at 0x4C2EB6B: malloc (vg_replace_malloc.c:299)
> =3D=3D11711=3D=3D    by 0x1E0CDBD8: g_malloc (gmem.c:94)
> =3D=3D11711=3D=3D    by 0x1E0E696E: g_strdup (gstrfuncs.c:363)
> =3D=3D11711=3D=3D    by 0x695693: migration_instance_init (migration.c:=
2226)
> =3D=3D11711=3D=3D    by 0x717C4B: object_init_with_type (object.c:344)
> =3D=3D11711=3D=3D    by 0x717E80: object_initialize_with_type (object.c=
:375)
> =3D=3D11711=3D=3D    by 0x7182EB: object_new_with_type (object.c:483)
> =3D=3D11711=3D=3D    by 0x718328: object_new (object.c:493)
> =3D=3D11711=3D=3D    by 0x4B8A29: qmp_device_list_properties (qmp.c:542=
)
> =3D=3D11711=3D=3D    by 0x4A9561: qmp_marshal_device_list_properties (q=
mp-marshal.c:1425)
> =3D=3D11711=3D=3D    by 0x819D4A: do_qmp_dispatch (qmp-dispatch.c:104)
> =3D=3D11711=3D=3D    by 0x819E82: qmp_dispatch (qmp-dispatch.c:131)
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Queued for migration

> ---
>  migration/migration.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 085c32c994..c3fe0ed9ca 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2214,6 +2214,15 @@ static void migration_class_init(ObjectClass *kl=
ass, void *data)
>      dc->props =3D migration_properties;
>  }
> =20
> +static void migration_instance_finalize(Object *obj)
> +{
> +    MigrationState *ms =3D MIGRATION_OBJ(obj);
> +    MigrationParameters *params =3D &ms->parameters;
> +
> +    g_free(params->tls_hostname);
> +    g_free(params->tls_creds);
> +}
> +
>  static void migration_instance_init(Object *obj)
>  {
>      MigrationState *ms =3D MIGRATION_OBJ(obj);
> @@ -2282,6 +2291,7 @@ static const TypeInfo migration_type =3D {
>      .class_size =3D sizeof(MigrationClass),
>      .instance_size =3D sizeof(MigrationState),
>      .instance_init =3D migration_instance_init,
> +    .instance_finalize =3D migration_instance_finalize,
>  };
> =20
>  static void register_migration_types(void)
> --=20
> 2.14.0.rc0.1.g40ca67566
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
