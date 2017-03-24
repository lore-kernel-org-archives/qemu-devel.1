Received: from eggs.gnu.org ([2001:4830:134:3::10]:32850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUUl-0006Uk-8D
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUUg-0005OK-AJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crUUg-0005OE-1t
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:03:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F17E375721
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 19:03:25 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-9-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd06e969-6989-9d01-08e2-92aa110a4bca@redhat.com>
Date: Fri, 24 Mar 2017 14:03:19 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-9-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kSgQsGbMGoTsAT5fH5IFXSMMwBDuBF6o8"
Subject: Re: [Qemu-devel] [PATCH RFC v2 8/9] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kSgQsGbMGoTsAT5fH5IFXSMMwBDuBF6o8
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <dd06e969-6989-9d01-08e2-92aa110a4bca@redhat.com>
Subject: Re: [PATCH RFC v2 8/9] rbd: Rewrite the code to extract list-valued
 options
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> We have two list-values options:
>=20
> * "server" is a list of InetSocketAddress.  We use members "host" and
>   "port", and silently ignore the rest.
>=20
> * "auth-supported" is a list of RbdAuthMethod.  We use its only member
>   "auth".
>=20
> Since qemu_rbd_open() takes options as a flattened QDict, options has
> keys of the form server.%d.host, server.%d.port and
> auth-supported.%d.auth, where %d counts up from zero.
>=20

> Rewrite to simply get the values straight from the options QDict.
>=20
> Fixes -drive not to crash when server.*.* are present, but
> server.*.host is absent.
>=20
> Permits cleaning up runtime_opts, which fixes -drive to reject several
> bogus parameters instead of silently ignoring them: host, port, auth;
> server.*.P where P isn't host; port auth-supported.*.P where P isn't

s/host; port/host or port;/

> auth.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 150 +++++++++++++++++++++-------------------------------=
--------
>  1 file changed, 52 insertions(+), 98 deletions(-)
>=20
> diff --git a/block/rbd.c b/block/rbd.c
> index 6397626..e962641 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -13,6 +13,7 @@
> =20
>  #include "qemu/osdep.h"
> =20
> +#include <rbd/librbd.h>
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "block/block_int.h"
> @@ -20,8 +21,6 @@
>  #include "qemu/cutils.h"
>  #include "qapi/qmp/qstring.h"
> =20
> -#include <rbd/librbd.h>
> -

Still no mention of the include cleanup in the commit message. Not the
end of the world (I don't think it's worth splitting into a separate
patch, and the lack of commit message mention isn't fatal).

> @@ -635,7 +590,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDic=
t *options, int flags,
>      }
> =20
>      secretid =3D qemu_opt_get(opts, "password-secret");
> -
>      pool           =3D qemu_opt_get(opts, "pool");

Spurious change that should belong to an earlier commit?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--kSgQsGbMGoTsAT5fH5IFXSMMwBDuBF6o8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1W13AAoJEKeha0olJ0NqpbIH/RDBNiYKm/xX7uhC4ru6pqKI
fCMllY0aXhbN12KT5SNVk+NIYD+zNP/WMWAyAShHEc3rlpvKEBSr66FHDj8WhOXy
r0xpb9oLoLCVMEOq0xXV+BWq/4W7oOoXn2LPmHzJuUZae9fvxHxQzmG0Qv7iAYGD
hCReiPQ9PBj74LwYRpsHP3+3pnt8nv4VDA4U78s2elA/qtc0cTeb3onn0mP5LIMY
Psq0pHniNwWLXkdOJ7FUpjFhqB9K6IQlhhcC554TBPP6bsOMI9+y4873Ryct+lW9
YhzURPHsk48v0JZUxJRmDPKqwRhuXjh9mZp1koZfonKmU3kcdfShJ4AxsC8lz/U=
=QKnM
-----END PGP SIGNATURE-----

--kSgQsGbMGoTsAT5fH5IFXSMMwBDuBF6o8--
