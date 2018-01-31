Received: from eggs.gnu.org ([2001:4830:134:3::10]:58996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egu7R-0006vX-OW
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egu7I-0007Sw-5v
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egu7H-0007S8-SY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:16:04 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2bd84a3b-7aa2-8939-63ae-b8f2c830cf71@redhat.com>
Date: Wed, 31 Jan 2018 09:16:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-5-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s2Y6VurR5uvf7gCgZ57wwcDiq8zoC0lUO"
Subject: Re: [Qemu-devel] [PATCH v2 04/19] Include qapi/error.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s2Y6VurR5uvf7gCgZ57wwcDiq8zoC0lUO
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, f4bug@amsat.org
Message-ID: <2bd84a3b-7aa2-8939-63ae-b8f2c830cf71@redhat.com>
Subject: Re: [PATCH v2 04/19] Include qapi/error.h exactly where needed
References: <20180131144846.31697-1-armbru@redhat.com>
 <20180131144846.31697-5-armbru@redhat.com>
In-Reply-To: <20180131144846.31697-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 08:48 AM, Markus Armbruster wrote:
> This cleanup makes the number of objects depending on qapi/error.h
> drop from 1910 (out of 4743) to 1612 in my "build everything" tree.
>=20
> While there, separate #include from file comment with a blank line,
> and drop a useless comment on why qemu/osdep.h is included first.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

> +++ b/block/write-threshold.c
> @@ -16,6 +16,7 @@
>  #include "block/write-threshold.h"
>  #include "qemu/notify.h"
>  #include "qapi-event.h"
> +#include "qapi/error.h"
>  #include "qmp-commands.h"
> =20
> =20

Worth squashing a double blank line while here?


> +++ b/hw/pci-bridge/i82801b11.c
> @@ -44,7 +44,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/pci/pci.h"
>  #include "hw/i386/ich9.h"
> -#include "qapi/error.h"
> =20
> =20
>  /*********************************************************************=
********/

And here

> +++ b/include/crypto/random.h
> @@ -22,7 +22,6 @@
>  #define QCRYPTO_RANDOM_H
> =20
>  #include "qemu-common.h"
> -#include "qapi/error.h"
> =20
> =20
>  /**
> diff --git a/include/crypto/xts.h b/include/crypto/xts.h
> index da32ab82b6..719971afb7 100644
> --- a/include/crypto/xts.h
> +++ b/include/crypto/xts.h
> @@ -27,7 +27,6 @@
>  #define QCRYPTO_XTS_H
> =20
>  #include "qemu-common.h"
> -#include "qapi/error.h"
> =20
> =20
>  #define XTS_BLOCK_SIZE 16

And here

> +++ b/include/ui/console.h
> @@ -6,7 +6,9 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qemu/notify.h"
>  #include "qemu/error-report.h"
> +#ifndef CONFIG_VNC
>  #include "qapi/error.h"
> +#endif

Interesting conditional; it's because of the static inline fallbacks
that are also conditional.  Makes sense.  An alternative would be having
the fallbacks be in a .c rather than static inline in the .h, but it
doesn't bother me enough to worry about it.

My R-b stands whether or not you make more whitespace tweaks.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s2Y6VurR5uvf7gCgZ57wwcDiq8zoC0lUO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx3bEACgkQp6FrSiUn
Q2qgvAf9E0gBRA5CYbVLIPaupZ6lI+yHTvVlNbGn7z2VyX0r66dJw2qbkYPhPQ7Z
lo2yjtnqx6YE6KChtYR7drDC6iCqD255sgWp5NvK4HFFf1wJwKwFj7LfZthlME/J
Of6eT6gP/NPcojRpn/Td2d0qVlRVbEj//uyiAsM39w4n5yf21HPzsAgkLeJMClEn
+afgIXWCN3xwRfdRkfC1moFu8WH3n730/aZztab749/MPa3LovgwoxK8nl6gZpnH
OhS28qIf7YpGNpyHLvq1SPJisHQHCG7lUoHh1C1Md/vzBeaMcc4mowuvSN+Q3h+y
4hepvAHQ9m0oLeGF9hegaZ5rvsC94A==
=jnBL
-----END PGP SIGNATURE-----

--s2Y6VurR5uvf7gCgZ57wwcDiq8zoC0lUO--
