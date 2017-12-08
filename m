Received: from eggs.gnu.org ([2001:4830:134:3::10]:46205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLPD-0002xc-N4
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNLPC-0001QF-IB
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:21:43 -0500
References: <20171208133416.28978-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <73ad7473-67e5-0e2c-908e-9e3349ac87bb@redhat.com>
Date: Fri, 8 Dec 2017 10:21:35 -0600
MIME-Version: 1.0
In-Reply-To: <20171208133416.28978-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w3G7exKaOoDcmARmrG8RH4PTswRrC9efv"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w3G7exKaOoDcmARmrG8RH4PTswRrC9efv
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <73ad7473-67e5-0e2c-908e-9e3349ac87bb@redhat.com>
Subject: Re: [PATCH v2] qemu-io: fix EOF Ctrl-D handling in qemu-io readline
 code
References: <20171208133416.28978-1-berrange@redhat.com>
In-Reply-To: <20171208133416.28978-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 07:34 AM, Daniel P. Berrange wrote:
> qemu-io puts the TTY into non-canonical mode, which means no EOF proces=
sing is
> done and thus getchar() will never return the EOF constant. Instead we =
have to
> query the TTY attributes to determine the configured EOF character (usu=
ally
> Ctrl-D / 0x4), and then explicitly check for that value. This fixes the=

> regression that prevented Ctrl-D from triggering an exit of qemu-io tha=
t has
> existed since readline was first added in
>=20
>   commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>   Author: Stefan Hajnoczi <stefanha@redhat.com>
>   Date:   Thu Nov 14 11:54:17 2013 +0100
>=20
>     qemu-io: use readline.c
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> Changed in v2:

> +++ b/qemu-io.c
> @@ -10,6 +10,9 @@
>  #include "qemu/osdep.h"
>  #include <getopt.h>
>  #include <libgen.h>
> +#ifndef _WIN32
> +#include <termios.h>
> +#endif

Wouldn't a configure probe for the existence of <termios.h> be more
reliable than just hard-coding the list of platforms where it is
currently not found?

> =20
>  #include "qapi/error.h"
>  #include "qemu-io.h"
> @@ -41,6 +44,26 @@ static bool imageOpts;
> =20
>  static ReadLineState *readline_state;
> =20
> +static int ttyEOF;
> +
> +static int get_eof_char(void)
> +{
> +#ifdef _WIN32

in which case this also should be #if HAVE_TERMIOS_H

But I guess unless someone complains, all other platforms that we care
about have termios.h, so a weak:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w3G7exKaOoDcmARmrG8RH4PTswRrC9efv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqvA8ACgkQp6FrSiUn
Q2rlUgf8DFg8MFhmyCynNURuxXmfCyw+3JfZ0NYNtkrpHhvdRwhNAYWxxftyXznh
ewxIy8sKwkhv2+4LjYRIQilsEDJpIQtgXlXlSukKythcwW4uVNV3XcaXM5e7hAY4
5aUPFvAQdEPO5NU3DSPmtd3Tx/NAGTxd3NAJmyV1mjlI5EK27mZhpkMsvElW4Qxq
7yRoWkKBy7sp9HLPbXWe16d6Pj8f9cf0sMeN5Wf5OQYmBPjqvou3aLUa8RnydLBQ
h9RCFAjQ6u9YRlQm6FSiBu2O7IUn67B8csMC64gpkXg1ytAmgTMm3D08gsYm27d4
s/XPJGRz4vHJtlHF8o20TkxCJE4A8Q==
=ro23
-----END PGP SIGNATURE-----

--w3G7exKaOoDcmARmrG8RH4PTswRrC9efv--
