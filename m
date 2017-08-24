Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkqKT-0000P9-Vo
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dkqKP-0006lL-2h
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dkqKO-0006ii-Sd
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2C69C0587DF
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 11:29:35 +0000 (UTC)
Date: Thu, 24 Aug 2017 12:29:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170824112927.GE2088@work-vm>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-9-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170822132255.23945-9-marcandre.lureau@redhat.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hmp.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/hmp.c b/hmp.c
> index 29e42ab661..4ba50e8e26 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1544,23 +1544,21 @@ void hmp_migrate_set_capability(Monitor *mon, c=
onst QDict *qdict)
>      bool state =3D qdict_get_bool(qdict, "state");
>      Error *err =3D NULL;
>      MigrationCapabilityStatusList *caps =3D g_malloc0(sizeof(*caps));
> -    int i;
> +    int val;
> =20
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

It would be nice to macro that to something like:
   MigrationCapability_parse(cap, -1, &err);

which would stop the inevitable case of someone using the wrong _lookup
with the wrong _MAX.

I also wonder if having the qapi_enum_parse return a bool and take a
&int would be nicer - it would get rid of the need for the -1 default
and mean actually it could be an unsigned.

Still, those are only suggestions, so:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +    if (val < 0) {
> +        goto end;
>      }
> =20
> -    if (i =3D=3D MIGRATION_CAPABILITY__MAX) {
> -        error_setg(&err, QERR_INVALID_PARAMETER, cap);
> -    }
> +    caps->value =3D g_malloc0(sizeof(*caps->value));
> +    caps->value->capability =3D val;
> +    caps->value->state =3D state;
> +    caps->next =3D NULL;
> +    qmp_migrate_set_capabilities(caps, &err);
> =20
> +end:
>      qapi_free_MigrationCapabilityStatusList(caps);
> =20
>      if (err) {
> --=20
> 2.14.1.146.gd35faa819
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
