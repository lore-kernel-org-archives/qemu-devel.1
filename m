Received: from eggs.gnu.org ([2001:4830:134:3::10]:59296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqiX3-0005bT-5c
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqiX2-0002lr-51
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:50:41 -0400
References: <20170314111157.14464-1-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61f68525-8c4d-97a3-67f1-2c2bbdfa7751@redhat.com>
Date: Wed, 22 Mar 2017 16:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KX2nueESN6HQf7fM4lW1RsUloAFN7NFrn"
Subject: Re: [Qemu-devel] [PATCH] nbd-client: fix handling of hungup
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KX2nueESN6HQf7fM4lW1RsUloAFN7NFrn
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <61f68525-8c4d-97a3-67f1-2c2bbdfa7751@redhat.com>
Subject: Re: [PATCH] nbd-client: fix handling of hungup connections
References: <20170314111157.14464-1-pbonzini@redhat.com>
In-Reply-To: <20170314111157.14464-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.03.2017 12:11, Paolo Bonzini wrote:
> After the switch to reading replies in a coroutine, nothing is
> reentering pending receive coroutines if the connection hangs.
> Move nbd_recv_coroutines_enter_all to the reply read coroutine,
> which is the place where hangups are detected.  nbd_teardown_connection=

> can simply wait for the reply read coroutine to detect the hangup
> and clean up after itself.
>=20
> This wouldn't be enough though because nbd_receive_reply returns 0
> (rather than -EPIPE or similar) when reading from a hung connection.
> Fix the return value check in nbd_read_reply_entry.
>=20
> This fixes qemu-iotests 083.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd-client.c | 12 ++++++------
>  nbd/client.c       |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)

Thanks, I've applied the patch to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--KX2nueESN6HQf7fM4lW1RsUloAFN7NFrn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljSnUgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALvIIAKj1lfFIbgq9FxnmRKwBSaxGsVyox5uw
Uypt5hcOMk6+XJ6fRBaD0GbaDkXJaD0lpBjkn3TYbKPUnDk2TV7jPu1/ucuttr2Z
86XLZOxj0ZxdyxiSVBtADrJ+ezLaJYWHjb7XOPMRXrTQWrzZ7H45okxMCeiaBnWZ
rv7CPFkvVVgWE1x3kcffRd5kekLmd7xblaIJI4N/Z1fGcitLH/PYfhI92nNpAYfw
maW7beXPj5CkrkfntokskEnFWbedv7pjY5vIRsct7fY7Kl/8GfvzU2+CM7nyliSQ
UCiskMtMXk6FJHm89rqhoPA/eOXbGMCTjALJqKXaKPvPYIuP6pbpWnc=
=1i5L
-----END PGP SIGNATURE-----

--KX2nueESN6HQf7fM4lW1RsUloAFN7NFrn--
