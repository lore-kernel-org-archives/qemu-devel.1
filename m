Received: from eggs.gnu.org ([2001:4830:134:3::10]:42002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91J-0007BA-9x
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gJ91I-0002k2-80
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gJ91H-0002bb-7d
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 23:24:11 -0400
Date: Sat, 3 Nov 2018 13:28:26 +0000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181103132826.GG24365@umbus.hotspot.internet-for-guests.com>
References: <20181026123358.2554-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
In-Reply-To: <20181026123358.2554-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Moguofang <moguofang@huawei.com>, Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Prasad J Pandit <pjp@fedoraproject.org>


--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2018 at 06:03:58PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> While performing PowerNV memory r/w operations, the access length
> 'sz' could exceed the data[4] buffer size. Add check to avoid OOB
> access.
>=20
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Applied to ppc-for-3.1, thanks.

> ---
>  hw/ppc/pnv_lpc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> Update v2: add error log message
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05750.html
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d7721320a2..172a915cfc 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -155,9 +155,15 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, u=
int64_t cmd)
>      /* XXX Check for magic bits at the top, addr size etc... */
>      unsigned int sz =3D (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
>      uint32_t opb_addr =3D cmd & ECCB_CTL_ADDR_MASK;
> -    uint8_t data[4];
> +    uint8_t data[8];
>      bool success;
> =20
> +    if (sz > sizeof(data)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "ECCB: invalid operation at @0x%08x size %d\n", opb_addr, sz=
);
> +        return;
> +    }
> +
>      if (cmd & ECCB_CTL_READ) {
>          success =3D opb_read(lpc, opb_addr, data, sz);
>          if (success) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvdonoACgkQbDjKyiDZ
s5LncxAA44DJmqUHWf7w+/5as+pafVOH05QCPFRyRM6hE2Ocsg0vjc1Yoadzm4bl
lVgjCh63qhE5L8f9cf/92Iqim7LORKYarqrgOFg6Gftmj5fZMRnPYqLIBYiFF6hq
FFTXP0kzE8yBaypvgbR85NwlSOCZNKHzwnIVIt9o7K5LD2+5Rhgxhxtf83Asbw9e
ZDZy3NlWTEwq6yd6ZJ7NoYzBnPjRZsG4YE47Mw+0irxY0LtZ3vKvYE7hE9oPoYMt
DxdNslwbq3oEjGPmTRR3ENWf95nEihwMHWys5169hLX95nXjT0cTxTBZCmGhbrAA
/xMqQQjzw6As6P/kZttlfLl9s4FLbxbAt0XMdmYiGi7KRX6jWPorGwhDE3uOdwnx
4JktFu1TS9cGk1f6ca0hnoYLn/a7PM5KGG2NC5JzQpfsXIbPEqjGk7JH7Ye3EF2v
KeB0uKeaCzbGsxSaJACd3GPLvv8EQQS9NldPg4VQcHrGx7OO2Z+PHTxqad4AT7UB
ZZHcv6fYesiWdNc2dAEBN/FaVFemGsckLA1AvdLflrM/mXnHHo19y0+Pd1DzqsjL
wcfJEYZ5CB+gn6ED5aKgJpxQn7YTIa+KlCZYC9Oe7tvBU+ir47MtolyGmlwMHuBl
VMrnG/ftvi7EJUHqCrTRyoLs1yZXbZsyUzEhCDB5HDBpAocmMkk=
=WILe
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--
