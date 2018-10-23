Received: from eggs.gnu.org ([2001:4830:134:3::10]:39233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEykr-0001qT-Ma
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEykp-0004sZ-MJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:38:01 -0400
Received: from ozlabs.org ([203.11.71.1]:44645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gEykp-0004r6-9c
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:37:59 -0400
Date: Tue, 23 Oct 2018 16:37:10 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
References: <20181022121907.13635-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SzQ167Kp6Zo0TWVn"
Content-Disposition: inline
In-Reply-To: <20181022121907.13635-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, clg@kaod.org


--SzQ167Kp6Zo0TWVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2018 at 05:49:07PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> While performing PowerNV memory r/w operations, the access length
> 'sz' could exceed the data[4] buffer size. Add check to avoid OOB
> access.
>=20
> Reported-by: Moguofang <moguofang@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

So, it certainly does look like we can get an overrun here.  But is
just turning the access into a no-op if the size is too large the
correct behaviour?  It doesn't seem a very likely behaviour for the
actual hardware.

Should we be reporting an error via some register bits?  Or should we
be masking or truncating the size field instead the size down to
something smaller?

BenH or Cedric, do you know how the hardware actually behaves here?

> ---
>  hw/ppc/pnv_lpc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index d7721320a2..f5e5bd4053 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -158,6 +158,10 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, u=
int64_t cmd)
>      uint8_t data[4];
>      bool success;
> =20
> +    if (sz > sizeof(data)) {
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

--SzQ167Kp6Zo0TWVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPQCYACgkQbDjKyiDZ
s5LG0Q/+LrO3io4mUMpZP0X7P+bYXJSUaWOwEWLiQ5gcH6NXfvfZO4nGhOI1ZGFE
gCd1NF53CP/89HIhktmiEFoqXzFpTJ9CHaM2p4zmWvyDOb3EiXDTTtnV9AUbi+Nj
A+SDF4sFzBd9bduqXA+v+HzniUNgoMGgXJ8V5+rNbhu8jJZ9Kuw2yhLK4EQq5Ygx
af0N4++lk4dIJKciqLGji5CoLL6wIZGM8eS9c9jtovm0LT8jVfLf3w2bSseP9qo6
DJBHUvfnkr16Nr/Rpuxfdg2eCSj8Gpcy2y1zSBLWkyrvOalsJeg0kdXtNM/cr5HR
hKcF9RJbKubePjiCn4scSrNOD5/PuCUzLqZeXGXwD7zajNJjwAugQeHNaPMogV9B
FqxSq3S1jzR3g0BTU1CnFjDXEZnOYgLNqGhyP8rwd3erWMjZXU4IX6jW3t8wZzGr
ganG0bDbTZBWY0bVIDVqiY8kSxG/D5rF1s7N729ehvqd0EMFziD5cqWGlON14RgM
xIeOJzUdhbMUkIBsQTWYJ7BnXORCa6bl12wxTdNmaJ93QeXuJsJVnP3srnOJCDv9
TS7qcUeSnvBDrnJlx+I4151U+8hmVa1jeSr7NmG6Rf5BNvWurhVcFL7kWEctK97n
7Qss4jRJxOd1/Xzqa5guwAhBy99pRtct7JYmQmLCH5SWHOEJNdg=
=PVxW
-----END PGP SIGNATURE-----

--SzQ167Kp6Zo0TWVn--
