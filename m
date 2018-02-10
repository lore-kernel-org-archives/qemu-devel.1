Received: from eggs.gnu.org ([2001:4830:134:3::10]:45767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXM-0006hA-2v
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekPXK-0001E1-Sv
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:25:28 -0500
Date: Sat, 10 Feb 2018 18:22:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210072208.GM11634@umbus.fritz.box>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L/bWm/e7/ricERqM"
Content-Disposition: inline
In-Reply-To: <20180209185142.17151-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2 01/12] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com


--L/bWm/e7/ricERqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:51:31PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 008d8bd4d5..6631017ca2 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -275,7 +275,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
>      timer_mod(s->sr_delay_timer, expire);
>  }
> =20
> -static uint32_t cuda_readb(void *opaque, hwaddr addr)
> +static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      CUDAState *s =3D opaque;
>      uint32_t val;
> @@ -350,7 +350,7 @@ static uint32_t cuda_readb(void *opaque, hwaddr addr)
>      return val;
>  }
> =20
> -static void cuda_writeb(void *opaque, hwaddr addr, uint32_t val)
> +static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned=
 size)
>  {
>      CUDAState *s =3D opaque;
> =20
> @@ -780,38 +780,14 @@ static void cuda_receive_packet_from_host(CUDAState=
 *s,
>      }
>  }
> =20
> -static void cuda_writew (void *opaque, hwaddr addr, uint32_t value)
> -{
> -}
> -
> -static void cuda_writel (void *opaque, hwaddr addr, uint32_t value)
> -{
> -}
> -
> -static uint32_t cuda_readw (void *opaque, hwaddr addr)
> -{
> -    return 0;
> -}
> -
> -static uint32_t cuda_readl (void *opaque, hwaddr addr)
> -{
> -    return 0;
> -}
> -
>  static const MemoryRegionOps cuda_ops =3D {
> -    .old_mmio =3D {
> -        .write =3D {
> -            cuda_writeb,
> -            cuda_writew,
> -            cuda_writel,
> -        },
> -        .read =3D {
> -            cuda_readb,
> -            cuda_readw,
> -            cuda_readl,
> -        },
> +    .read =3D cuda_read,
> +    .write =3D cuda_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
>      },
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
>  };
> =20
>  static bool cuda_timer_exist(void *opaque, int version_id)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L/bWm/e7/ricERqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+naAACgkQbDjKyiDZ
s5JqWA//awzaqqC232TxFKPkFIBwUkw9XBtBhLQ9yNjW6Alw6g3fmOrFI7l9E8uc
/nTfT6pa1GoLIVL0v9ZCZPnrXh7PuIqdeQKnS7EJpI2RdX/U3aWnGo+jE6d1ufQs
YO+r8LvM/RgItuEw1T6Jn+6lSWCKL9nxjsL8GzNUVxDenBNV7WlcqjvfhAfk0Npn
Z8oSBVUH10phuHIi4NycUoFPpUTYMHSJmatuKZazN96ffWAaqjJ7VNNeaprI17uE
pP2q3C0gUfuf1FIkSKS+rHJ7bt3fCI8z2gx2w2G0Dt68DXZeUHdIUy4IHULNZz/Z
zV/O0fYL8btpw3NjcCkC/uUXJwCO0cEvqqZ4yAZv9exdXGqt85L4pr3xvS1TrMze
bdWg0EepX25/Q5K9jYKhhxZrF1meWhJQjYVVfMoL90+ExFuLMix7mZGLokCe1BY3
lvR17dPhqOLZcnG6jTO9YAncVJtKwakiiXjeCg7UcFIoWgYhnXkB7Q0oIjHmTGPL
UXf4bJt0P4yp0/4tQyJF6uAKaWNgRMMTS/+PRhwQjyxC+0Ws7Q67jDdAsnJzxb6W
aJcMxEY/t/SVbaTV57C0uwXXhHTWYmNP3kMsSXj/nQm0ANEJuKwTH4MqMOsjL5Xu
ybkKEiwIgB5Vca1t4fX/ZOomvBxWrYVLgPcpihFN/P+WCWiyAZY=
=WrPW
-----END PGP SIGNATURE-----

--L/bWm/e7/ricERqM--
