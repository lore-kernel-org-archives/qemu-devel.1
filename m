Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTIC-0005SP-Rb
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:09:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjTIA-0007of-66
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:09:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjTI9-0007nw-UJ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:09:22 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E0FE33886B
	for <qemu-devel@nongnu.org>; Thu,  2 Mar 2017 16:09:22 +0000 (UTC)
References: <20170302123746.9694-1-berrange@redhat.com>
	<20170302123746.9694-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b59a87f7-a694-1522-e0c4-0d2c9e969a1c@redhat.com>
Date: Thu, 2 Mar 2017 10:09:19 -0600
MIME-Version: 1.0
In-Reply-To: <20170302123746.9694-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nKB7VRaVql74bwnB5EDtN5LMK8wGKNivI"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] migration: allow clearing migration
 string parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nKB7VRaVql74bwnB5EDtN5LMK8wGKNivI
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juan Quintela
 <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Message-ID: <b59a87f7-a694-1522-e0c4-0d2c9e969a1c@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: allow clearing migration string
 parameters
References: <20170302123746.9694-1-berrange@redhat.com>
 <20170302123746.9694-2-berrange@redhat.com>
In-Reply-To: <20170302123746.9694-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 06:37 AM, Daniel P. Berrange wrote:
> Some of the migration parameters are strings, which default to NULL,
> eg tls-hostname and tls-creds.
>=20
> The mgmt app will set the tls-creds parameter on both source and target=

> QEMU instances, in order to trigger use of TLS for migration.
>=20
> After performing a TLS encrypted migration though, migration might be
> used for other reasons - for example, to save the QEMU state to a file.=

> We need TLS turned off when doing this, but the migrate-set-parameters
> QAPI command does not provide any facility to clear/reset parameters
> to their default state.
>=20
> If you simply omit the tls_creds parameter in migrate-set-parameters,
> then 'has_tls_creds' will be false and so no action will be taken. JSON=

> allows a parameter to have a nil value, but the QEMU JSON visitor will
> reject that when deserializing into a QObject.
>=20
> The migration code has no need to distinguish "" vs NULL for the TLS
> hostname or TLS credentials object name, since "" is invalid in both
> cases. This enables clearing of tls-hostname and tls-creds by
> treating "" as equivalent to NULL.

It's also worth documenting in the .json file that "" is special-cased.
But the C code change looks okay (with your explanation on v1 that the
has_* parameters are not used internally).

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  migration/migration.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index c6ae69d..a8cb56e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -872,11 +872,19 @@ void qmp_migrate_set_parameters(MigrationParamete=
rs *params, Error **errp)
>      }
>      if (params->has_tls_creds) {
>          g_free(s->parameters.tls_creds);
> -        s->parameters.tls_creds =3D g_strdup(params->tls_creds);
> +        if (*params->tls_creds =3D=3D '\0') {
> +            s->parameters.tls_creds =3D NULL;
> +        } else {
> +            s->parameters.tls_creds =3D g_strdup(params->tls_creds);
> +        }
>      }
>      if (params->has_tls_hostname) {
>          g_free(s->parameters.tls_hostname);
> -        s->parameters.tls_hostname =3D g_strdup(params->tls_hostname);=

> +        if (*params->tls_hostname =3D=3D '\0') {
> +            s->parameters.tls_hostname =3D NULL;
> +        } else {
> +            s->parameters.tls_hostname =3D g_strdup(params->tls_hostna=
me);
> +        }
>      }
>      if (params->has_max_bandwidth) {
>          s->parameters.max_bandwidth =3D params->max_bandwidth;
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--nKB7VRaVql74bwnB5EDtN5LMK8wGKNivI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuEOvAAoJEKeha0olJ0Nqpu0H/1gHxic2q7ecAkNAhF79pPJ2
XSv8KQWZjS6hY8xJn54X1z4op7DvURSUYTczN7zLY12m3efY7W4GRZxErg4B+L9I
zy0+cUTCox43Ta1ovizd7IweKXU6GIl28oc86HiIisDuZ3QDXDii9Lt2utbLzWoM
brKadk/C5ZggtQYIbOG11MsYhs4YWbmvB0+MGkdHaOB6jHVvmT4RIND+yOMYY4eU
+k7yrjwzgu9SK4b8Kvu4b+mPDYTohaUnQ6q5yLv6i51S5XKfhIb5d13YrC8dtDQR
WiXElLTcSE/2Gdukecr7sp+DwdgFPXfvIByQRuqsIIJGKe4vn93KaoFQsSkQaLE=
=1zOd
-----END PGP SIGNATURE-----

--nKB7VRaVql74bwnB5EDtN5LMK8wGKNivI--
