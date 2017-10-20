Received: from eggs.gnu.org ([2001:4830:134:3::10]:46860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dgt-00020Q-SQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5dgp-0004Pd-Se
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5dgp-0004PJ-Jg
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:14:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8F086A13
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 20:14:41 +0000 (UTC)
References: <20171020141243.27845-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7769fa10-629b-7006-1340-648d0cc2adb8@redhat.com>
Date: Fri, 20 Oct 2017 15:14:40 -0500
MIME-Version: 1.0
In-Reply-To: <20171020141243.27845-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MsvCRCPiinQc0hcsjppQN6dMerGuoR1L8"
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid leak of listen file
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MsvCRCPiinQc0hcsjppQN6dMerGuoR1L8
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7769fa10-629b-7006-1340-648d0cc2adb8@redhat.com>
Subject: Re: [PATCH v2] sockets: avoid leak of listen file descriptor
References: <20171020141243.27845-1-berrange@redhat.com>
In-Reply-To: <20171020141243.27845-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 09:12 AM, Daniel P. Berrange wrote:
> If we iterate over the full port range without successfully binding+lis=
tening
> on the socket, we'll try the next address, whereupon we overwrite the s=
listen
> file descriptor variable without closing it.
>=20
> Rather than having two places where we open + close socket FDs on diffe=
rent
> iterations of nested for loops, re-arrange the code to always open+clos=
e
> within the same loop iteration.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 52 +++++++++++++++++++++++++++++----------------=
-------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>=20

> +            slisten =3D create_fast_reuse_socket(e);
> +            if (slisten < 0) {
> +                /* First time we expect we might fail to create the so=
cket
> +                 * eg if 'e' has AF_INET6 but ipv6 kmod is not loaded.=

> +                 * Later iterations should always succeeed if first it=
eration

s/succeeed/succeed/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MsvCRCPiinQc0hcsjppQN6dMerGuoR1L8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqWTAACgkQp6FrSiUn
Q2ouCggAnWiPtvOD+RFQRgEoaM2pV7khAjSDSFiIaXPyYp9v12hegJUZVVGJ/sW7
gIDOxhgBEMFCLiHFYOJsZelgOL1giNwnl20V+pC0ld8kn5JpatSTOe3FgTF/aL7F
Ld/6MJng3DR+j3jOYu+Xjyf+s5vVWOQrDVeNi3bdFXQxjMtbWZ996Nfd2Qq9hEMd
BuiTKQKkryFHd/hEUUz0+j7KUNCB8zLsl3wuukBzjly9wti4FuFCSI4QKRvprh4t
NfKsbuWkV7cFf0INCbBfhxPGuD4p4KTMU9TnOhLQ0EN0oJMLh4SJQgiQsZZOPKFT
5/ilcVOVeE+V9CHO6o2sK60OCXZl9Q==
=NRn0
-----END PGP SIGNATURE-----

--MsvCRCPiinQc0hcsjppQN6dMerGuoR1L8--
