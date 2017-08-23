Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkS3B-0007Uk-P2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkS38-0003wj-JO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkS38-0003wG-Ch
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A8A781DEC
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 09:34:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-9-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 11:34:05 +0200
In-Reply-To: <20170822132255.23945-9-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:09 +0200")
Message-ID: <87wp5u4ohe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/54] hmp: use qapi_enum_parse() in
 hmp_migrate_set_capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hmp.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/hmp.c b/hmp.c
> index 29e42ab661..4ba50e8e26 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1544,23 +1544,21 @@ void hmp_migrate_set_capability(Monitor *mon, con=
st QDict *qdict)
>      bool state =3D qdict_get_bool(qdict, "state");
>      Error *err =3D NULL;
>      MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
> -    int i;
> +    int val;
>=20=20
> -    for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
> -        if (strcmp(cap, MigrationCapability_lookup[i]) =3D=3D 0) {
> -            caps->value =3D g_malloc0(sizeof(*caps->value));
> -            caps->value->capability =3D i;
> -            caps->value->state =3D state;
> -            caps->next =3D NULL;
> -            qmp_migrate_set_capabilities(caps, &err);
> -            break;
> -        }
> +    val =3D qapi_enum_parse(MigrationCapability_lookup, cap,
> +                          MIGRATION_CAPABILITY__MAX, -1, &err);
> +    if (val < 0) {
> +        goto end;
>      }
>=20=20
> -    if (i =3D=3D MIGRATION_CAPABILITY__MAX) {
> -        error_setg(&err, QERR_INVALID_PARAMETER, cap);
> -    }
> +    caps->value =3D g_malloc0(sizeof(*caps->value));
> +    caps->value->capability =3D val;
> +    caps->value->state =3D state;
> +    caps->next =3D NULL;
> +    qmp_migrate_set_capabilities(caps, &err);
>=20=20
> +end:
>      qapi_free_MigrationCapabilityStatusList(caps);
>=20=20
>      if (err) {

Reviewed-by: Markus Armbruster <armbru@redhat.com>
