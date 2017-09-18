Received: from eggs.gnu.org ([2001:4830:134:3::10]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0001CA-4H
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002nP-Nj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:43 -0400
Date: Tue, 19 Sep 2017 06:36:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918203620.GG15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-5-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-5-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 4/8] macio: convert pmac_ide_ops from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:44PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Nice, but there are some details I'm not sure about.

> ---
>  hw/ide/macio.c |  154 +++++++++++++++++++++-----------------------------=
------
>  1 file changed, 56 insertions(+), 98 deletions(-)
>=20
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index db5db39..428fbfc 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -255,131 +255,89 @@ static void pmac_ide_flush(DBDMA_io *io)
>  }
> =20
>  /* PowerMac IDE memory IO */
> -static void pmac_ide_writeb (void *opaque,
> -                             hwaddr addr, uint32_t val)
> +static uint64_t pmac_ide_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      MACIOIDEState *d =3D opaque;
> +    uint64_t retval;
> +    addr =3D (addr & 0xfff) >> 4;

Do you need the mask?  Using the new mmio interfaces, the given
address should already be just an offset within the region.  I also
dislike re-using the 'addr' name when it's now essentially a register
index.

> =20
> -    addr =3D (addr & 0xFFF) >> 4;
>      switch (addr) {
> -    case 1 ... 7:
> -        ide_ioport_write(&d->bus, addr, val);
> -        break;
> -    case 8:
> -    case 22:
> -        ide_cmd_write(&d->bus, 0, val);
> -        break;
> -    default:
> +    case 0x0:
> +        if (size =3D=3D 2) {
> +            retval =3D ide_data_readw(&d->bus, 0);
> +        } else if (size =3D=3D 4) {
> +            retval =3D ide_data_readl(&d->bus, 0);
> +        } else {
> +            retval =3D 0xffffffff;

Are single byte reads not permitted, or will they just return parts of
the data?

> +        }
>          break;
> -    }
> -}
> -
> -static uint32_t pmac_ide_readb (void *opaque,hwaddr addr)
> -{
> -    uint8_t retval;
> -    MACIOIDEState *d =3D opaque;
> -
> -    addr =3D (addr & 0xFFF) >> 4;
> -    switch (addr) {
> -    case 1 ... 7:
> +    case 0x1 ... 0x7:
>          retval =3D ide_ioport_read(&d->bus, addr);
>          break;
> -    case 8:
> -    case 22:
> +    case 0x8:
> +    case 0x16:

I think you need some sort of size check for these other registers -
you've declared yourself as both supporting and implementing 1..4 byte
accesses, but I don't think these make sense for size !=3D 4.

>          retval =3D ide_status_read(&d->bus, 0);
>          break;
> +    case 0x20:
> +        retval =3D d->timing_reg;
> +        break;
> +    case 0x30:
> +        /* This is an interrupt state register that only exists
> +         * in the KeyLargo and later variants. Bit 0x8000_0000
> +         * latches the DMA interrupt and has to be written to
> +         * clear. Bit 0x4000_0000 is an image of the disk
> +         * interrupt. MacOS X relies on this and will hang if
> +         * we don't provide at least the disk interrupt
> +         */
> +        retval =3D d->irq_reg;
> +        break;
>      default:
> -        retval =3D 0xFF;
> +        retval =3D 0xffffffff;
>          break;
>      }
> -    return retval;
> -}
> -
> -static void pmac_ide_writew (void *opaque,
> -                             hwaddr addr, uint32_t val)
> -{
> -    MACIOIDEState *d =3D opaque;
> -
> -    addr =3D (addr & 0xFFF) >> 4;
> -    val =3D bswap16(val);
> -    if (addr =3D=3D 0) {
> -        ide_data_writew(&d->bus, 0, val);
> -    }
> -}
> =20
> -static uint32_t pmac_ide_readw (void *opaque,hwaddr addr)
> -{
> -    uint16_t retval;
> -    MACIOIDEState *d =3D opaque;
> -
> -    addr =3D (addr & 0xFFF) >> 4;
> -    if (addr =3D=3D 0) {
> -        retval =3D ide_data_readw(&d->bus, 0);
> -    } else {
> -        retval =3D 0xFFFF;
> -    }
> -    retval =3D bswap16(retval);
>      return retval;
>  }
> =20
> -static void pmac_ide_writel (void *opaque,
> -                             hwaddr addr, uint32_t val)
> +
> +static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
> +                           unsigned size)

Similar comments on the write path.

>  {
>      MACIOIDEState *d =3D opaque;
> +    addr =3D (addr & 0xfff) >> 4;
> =20
> -    addr =3D (addr & 0xFFF) >> 4;
> -    val =3D bswap32(val);
> -    if (addr =3D=3D 0) {
> -        ide_data_writel(&d->bus, 0, val);
> -    } else if (addr =3D=3D 0x20) {
> +    switch (addr) {
> +    case 0x0:
> +        if (size =3D=3D 2) {
> +            ide_data_writew(&d->bus, 0, val);
> +        } else if (size =3D=3D 4) {
> +            ide_data_writel(&d->bus, 0, val);
> +        }
> +        break;
> +    case 0x1 ... 0x7:
> +        ide_ioport_write(&d->bus, addr, val);
> +        break;
> +    case 0x8:
> +    case 0x16:
> +        ide_cmd_write(&d->bus, 0, val);
> +        break;
> +    case 0x20:
>          d->timing_reg =3D val;
> -    } else if (addr =3D=3D 0x30) {
> +        break;
> +    case 0x30:
>          if (val & 0x80000000u) {
>              d->irq_reg &=3D 0x7fffffff;
>          }
> +        break;
>      }
>  }
> =20
> -static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
> -{
> -    uint32_t retval;
> -    MACIOIDEState *d =3D opaque;
> -
> -    addr =3D (addr & 0xFFF) >> 4;
> -    if (addr =3D=3D 0) {
> -        retval =3D ide_data_readl(&d->bus, 0);
> -    } else if (addr =3D=3D 0x20) {
> -        retval =3D d->timing_reg;
> -    } else if (addr =3D=3D 0x30) {
> -        /* This is an interrupt state register that only exists
> -         * in the KeyLargo and later variants. Bit 0x8000_0000
> -         * latches the DMA interrupt and has to be written to
> -         * clear. Bit 0x4000_0000 is an image of the disk
> -         * interrupt. MacOS X relies on this and will hang if
> -         * we don't provide at least the disk interrupt
> -         */
> -        retval =3D d->irq_reg;
> -    } else {
> -        retval =3D 0xFFFFFFFF;
> -    }
> -    retval =3D bswap32(retval);
> -    return retval;
> -}
> -
>  static const MemoryRegionOps pmac_ide_ops =3D {
> -    .old_mmio =3D {
> -        .write =3D {
> -            pmac_ide_writeb,
> -            pmac_ide_writew,
> -            pmac_ide_writel,
> -        },
> -        .read =3D {
> -            pmac_ide_readb,
> -            pmac_ide_readw,
> -            pmac_ide_readl,
> -        },
> -    },
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .read =3D pmac_ide_read,
> +    .write =3D pmac_ide_write,
> +    .valid.min_access_size =3D 1,
> +    .valid.max_access_size =3D 4,

Remember you can set .impl. different from .valid if you want the mmio
core to do the work of splitting accesses up.

> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
>  static const VMStateDescription vmstate_pmac =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnALkQACgkQbDjKyiDZ
s5J+xQ//djcgY9tdvipNYm9v/exwfD7ULsZ4EWLTxjx4jqbVGnj5u3IEfcz5M8rQ
NPe12frBnIXVz47sz64fIULMmWPGqDeSiecRTIXZvneztNcjJAJIzHTpW5dSt3+T
hAoC7XkQM+GsTNd0jaLnEWxyOIefhCg8N2HbekjkHzQZX1NiiQ8CRdUU07aCHokY
nPi+AEOYTq9BuOZUFa4HP5L6tedKH6Uqh/C6ejTUq5y26Wk3x1zbOMtP2YaXt7au
4IR52UtdCk47QueS7ZXdYcVq7v3tF90TXebOOg/YTvdqb70ez6vCAEA9i+xBXxVw
2NaZroc6Yg4ZqnJWKL+rGrNbmiJdj0HrkWmdL4oiJj0nXickPEJXMfcwfGMeHjd9
GZ0NUoGY/wNQZCtsJLFho3LptLNJvM9zXnuyOdbHCfJ8W58VyOPx5d+0GeKSpD9f
PKR+h2PjRzQW9petd8+U72pcBWJsRpS2ToNucROXiPUe945nOO47VSxwWsHXAv1b
/ha2Uq0pq5WKfIHttllEBiiGeKxbduFAMbYkMIrZGT2ZU7F9hBSpZ/OaDwAgiwc1
E1iE0iAEMH06lvO7JbyIMTbrwXgOVn7KoldeJPuHr0mu1ZNZStZC/uyARHEnm3ra
qrl0wNiAfcnVaNgmzVz+ehzOMVXQaUH63Aiu7aNzlwDBqDpxUDU=
=cbqg
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
