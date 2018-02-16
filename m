Received: from eggs.gnu.org ([2001:4830:134:3::10]:34845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marmarek@invisiblethingslab.com>) id 1emnTa-0007yl-3w
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marmarek@invisiblethingslab.com>) id 1emnTW-0007il-Tt
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:23:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marmarek@invisiblethingslab.com>)
	id 1emnTW-0007iV-N9
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 16:23:22 -0500
Date: Fri, 16 Feb 2018 22:23:01 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>
Message-ID: <20180216212301.GL4302@mail-itl>
References: <20180124141848.3969-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline
In-Reply-To: <20180124141848.3969-1-marmarek@invisiblethingslab.com>
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: allow updating FEADDR and
 FEUADDR with one 64bit write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 03:18:48PM +0100, Marek Marczykowski-G=C3=B3recki w=
rote:
> Allow updating those two adjacent 32bit fields with one 64bit write.
> This fixes qemu crash when booting Xen inside.
>=20
> See discussion on Xen side of the thing here:
> http://xen.markmail.org/message/6mrmemrnmhxvaxba

Bump.

> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> ---
>  hw/i386/intel_iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2e841cde27..d214dce277 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2129,8 +2129,12 @@ static void vtd_mem_write(void *opaque, hwaddr add=
r,
> =20
>      /* Fault Event Address Register, 32-bit */
>      case DMAR_FEADDR_REG:
> -        assert(size =3D=3D 4);
> -        vtd_set_long(s, addr, val);
> +        assert(size =3D=3D 4 || size =3D=3D 8);
> +        if (size =3D=3D 4) {
> +            vtd_set_long(s, addr, val);
> +        } else {
> +            vtd_set_quad(s, addr, val);
> +        }
>          break;
> =20
>      /* Fault Event Upper Address Register, 32-bit */

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAlqHS60ACgkQ24/THMrX
1ywT5wf9FG0sbvRyUsOVYMYyzCMiU8yxaHXoDWhb25+Tyl8u0KZ36v3EB1zcxU0d
mv46ApyqDd2QjdyA1jul1N9aatssZhPDfsxCkc6ipPgO1dVuSyDgeCme8BX9sr8Z
dOz+VwuKJ/YdB2TJ3Q5jE4pn717iTmvfgccXerOsau98j1aizs8EWfgf3xzezWK0
73iWKxrOWsmPxKhJns3s88nbEOHdffz1JxHr64SMUK+KbtW8jxzf5CeL5KlqDuWQ
prBU47LmK92gaQeZsw28qnFuv8mTEpnKAxsU3T/JMzn9JF8un6BVRaI7GDYj9xAD
jNS3dTFTUYUkXH0haO92zQ6KkdOkTQ==
=LJpZ
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
