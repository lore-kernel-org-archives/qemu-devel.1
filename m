Received: from eggs.gnu.org ([2001:4830:134:3::10]:44819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TXK-00041c-Ka
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f4TXH-0001B8-Hq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:44:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f4TXH-0001AN-CX
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:44:19 -0400
References: <20180406120356.24757-1-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <18da2a0b-bb37-a3bf-d9ca-220835df7ae2@redhat.com>
Date: Fri, 6 Apr 2018 10:44:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180406120356.24757-1-brijesh.singh@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qIOJTz6B62cehioFWQIyFE7NcPpfPfhP9"
Subject: Re: [Qemu-devel] [PATCH for-2.12] tap: set vhostfd passed from qemu
 cli to non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Thomas.Lendacky@amd.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qIOJTz6B62cehioFWQIyFE7NcPpfPfhP9
From: Eric Blake <eblake@redhat.com>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Thomas.Lendacky@amd.com, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Message-ID: <18da2a0b-bb37-a3bf-d9ca-220835df7ae2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] tap: set vhostfd passed from qemu
 cli to non-blocking
References: <20180406120356.24757-1-brijesh.singh@amd.com>
In-Reply-To: <20180406120356.24757-1-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2018 07:03 AM, Brijesh Singh wrote:
> A guest boot hangs while probing the network interface when
> iommu_platform=3Don is used.
>=20
> The following qemu cli hangs without this patch:
>=20
> # $QEMU \
>   -netdev tap,fd=3D3,id=3Dhostnet0,vhost=3Don,vhostfd=3D4 3<>/dev/tap67=
 4<>/dev/host-net \
>   -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,iommu_platform=3Do=
n,disable-legacy=3Don \
>   ...
>=20
> Commit: c471ad0e9bd46 (vhost_net: device IOTLB support) took care of
> setting vhostfd to non-blocking when QEMU opens /dev/host-net but if
> the fd is passed from qemu cli then we need to ensure that fd is set
> to non-blocking.
>=20
> Fixes: c471ad0e9bd46 "vhost_net: device IOTLB support"
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  net/tap.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/net/tap.c b/net/tap.c
> index 2b3a36f9b50d..8c026fbf95cd 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -693,6 +693,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>                  }
>                  return;
>              }
> +            fcntl(vhostfd, F_SETFL, O_NONBLOCK);

Please use qemu_set_nonblock() instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qIOJTz6B62cehioFWQIyFE7NcPpfPfhP9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrHlcgACgkQp6FrSiUn
Q2q4Mgf/Sn6uqRh7AmsN2v9bc5z0jjkz0QOFy/ALsIJUWXEYK9bHC0+RcnGjQaRR
l18O5+jnq5k/ZFQUP7xCzMIyYkkIsSiPHPJOl8WRovLQ9jX3K4IXuyJgCXZG5XLH
q9cDzFbZQB3DFvZpSw7BFbYHei32AhBQm7KneCM+Uuf5RxTxvwX+Jm6ZWKyzKv7b
XI+v9y9TFEwVvBGih9kEiwMwmpH4m9PYlCdFnsSuYFe3YNW8TvgJtAmJJTqojb6s
3lm/wyPI3mm1s3fP2/buVG9P1feW/o/fjVWN4nb8JvbLYhArLiKBaC5cMxYy7ZC6
RGiEAnV6zZOYn8TmR/Pz539CbWfvrg==
=GXpR
-----END PGP SIGNATURE-----

--qIOJTz6B62cehioFWQIyFE7NcPpfPfhP9--
