Received: from eggs.gnu.org ([2001:4830:134:3::10]:36013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VQO-0003hg-EC
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VQJ-0004lR-Pu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:33:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8VQJ-0004kv-K8
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:33:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E91481A88A6
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 18:33:43 +0000 (UTC)
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4d09464-37ba-4b52-70bf-459b2a39d043@redhat.com>
Date: Tue, 17 Apr 2018 13:33:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180417133602.23832-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OnXlu6tYoNbmDHtzF43yrEZAQCYH4Qb1U"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] qobject: use a QObjectBase_ struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OnXlu6tYoNbmDHtzF43yrEZAQCYH4Qb1U
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <e4d09464-37ba-4b52-70bf-459b2a39d043@redhat.com>
Subject: Re: [PATCH v5 2/5] qobject: use a QObjectBase_ struct
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
 <20180417133602.23832-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180417133602.23832-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 08:35 AM, Marc-Andr=C3=A9 Lureau wrote:
> By moving the base fields to a QObjectBase_, QObject can be a type
> which also has a 'base' field. This allows to write a generic

either "allows us to write" or "allows writing"

> QOBJECT() macro that will work with any QObject type, including
> QObject itself. The container_of() macro ensures that the object to
> cast has a QObjectBase_ base field, giving some type safety
> guarantees. QObject must have no members but QObjectBase_ base, or
> else QOBJECT() breaks.
>=20
> QObjectBase_ is not typedef and use a trailing underscore to make it

s/not typedef and use/not a typedef and uses/

> obvious it is not for normal use and to avoid potential abuse.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/include/qapi/qmp/qobject.h
> @@ -34,13 +34,20 @@
> =20
>  #include "qapi/qapi-builtin-types.h"
> =20
> -struct QObject {
> +/* Not for use outside include/qapi/qmp/ */
> +struct QObjectBase_ {
>      QType type;
>      size_t refcnt;
>  };
> =20
> -/* Get the 'base' part of an object */
> -#define QOBJECT(obj) (&(obj)->base)
> +struct QObject {
> +    struct QObjectBase_ base;

I'd add a comment here that this struct must have no other members than
base.

> +};
> +
> +#define QOBJECT(x) ({                                       \
> +    typeof(x) __x =3D (x);                                    \
> +    __x ? container_of(&(__x)->base, QObject, base) : NULL; \
> +})
> =20

With those changes,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OnXlu6tYoNbmDHtzF43yrEZAQCYH4Qb1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWPgEACgkQp6FrSiUn
Q2ojcwgAk1qkPRZvBPf2RqNIEW09SWyeVUms2+cKEYntYoOJ2q+wDbIuAxXYh8V+
3oZ6AJGEWpoJtBRGTheSowscM1uxnYB2RDxFWM0l09QHWb6prseXAvv50h8lkkGU
icfysjfhBnvAAc9s2HJdESzskwKF4lM/nv60mLn7nyilKbNzcURjmRx2FxPZ67uW
GCZJk9ac8naQhYM7f4Ge4HnKFt8/GGfeSYNk34lH1yDlKCyvGVl+LfybqZOSouaW
3WPlvWWcZuQ+9SXDep7IKO69HbjUlAAR4voSPMoxvFVubyBLISYAoL9JcTIx+9N+
SqoUs/doltoBX/wMNOXaXuc1AzXbBw==
=6eBP
-----END PGP SIGNATURE-----

--OnXlu6tYoNbmDHtzF43yrEZAQCYH4Qb1U--
