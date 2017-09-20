Received: from eggs.gnu.org ([2001:4830:134:3::10]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1E-0007wK-ID
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duX1B-0001JG-9V
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 00:53:52 -0400
Date: Wed, 20 Sep 2017 14:29:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920042907.GC5520@umbus.fritz.box>
References: <1505851374-6408-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <1505851374-6408-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 09:02:54PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This didn't apply for me.  Can you rebase on top of ppc-for-2.11, please.

> ---
>  hw/ide/macio.c |  181 +++++++++++++++++++++++---------------------------=
------
>  1 file changed, 75 insertions(+), 106 deletions(-)
>=20
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index db5db39..18ae952 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -255,131 +255,100 @@ static void pmac_ide_flush(DBDMA_io *io)
>  }
> =20
>  /* PowerMac IDE memory IO */
> -static void pmac_ide_writeb (void *opaque,
> -                             hwaddr addr, uint32_t val)
> +static uint64_t pmac_ide_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      MACIOIDEState *d =3D opaque;
> -
> -    addr =3D (addr & 0xFFF) >> 4;
> -    switch (addr) {
> -    case 1 ... 7:
> -        ide_ioport_write(&d->bus, addr, val);
> -        break;
> -    case 8:
> -    case 22:
> -        ide_cmd_write(&d->bus, 0, val);
> +    uint64_t retval =3D 0xffffffff;
> +    int reg =3D addr >> 4;
> +
> +    switch (reg) {
> +    case 0x0:
> +        if (size =3D=3D 2) {
> +            retval =3D ide_data_readw(&d->bus, 0);
> +        } else if (size =3D=3D 4) {
> +            retval =3D ide_data_readl(&d->bus, 0);
> +        }
>          break;
> -    default:
> +    case 0x1 ... 0x7:
> +        if (size =3D=3D 1) {
> +            retval =3D ide_ioport_read(&d->bus, reg);
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
> -        retval =3D ide_ioport_read(&d->bus, addr);
> +    case 0x8:
> +    case 0x16:
> +        if (size =3D=3D 1) {
> +            retval =3D ide_status_read(&d->bus, 0);
> +        }
>          break;
> -    case 8:
> -    case 22:
> -        retval =3D ide_status_read(&d->bus, 0);
> +    case 0x20:
> +        if (size =3D=3D 4) {
> +            retval =3D d->timing_reg;
> +        }
>          break;
> -    default:
> -        retval =3D 0xFF;
> +    case 0x30:
> +        /* This is an interrupt state register that only exists
> +         * in the KeyLargo and later variants. Bit 0x8000_0000
> +         * latches the DMA interrupt and has to be written to
> +         * clear. Bit 0x4000_0000 is an image of the disk
> +         * interrupt. MacOS X relies on this and will hang if
> +         * we don't provide at least the disk interrupt
> +         */
> +        if (size =3D=3D 4) {
> +            retval =3D d->irq_reg;
> +        }
>          break;
>      }
> -    return retval;
> -}
> =20
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
> -
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
> -{
> -    MACIOIDEState *d =3D opaque;
> =20
> -    addr =3D (addr & 0xFFF) >> 4;
> -    val =3D bswap32(val);
> -    if (addr =3D=3D 0) {
> -        ide_data_writel(&d->bus, 0, val);
> -    } else if (addr =3D=3D 0x20) {
> -        d->timing_reg =3D val;
> -    } else if (addr =3D=3D 0x30) {
> -        if (val & 0x80000000u) {
> -            d->irq_reg &=3D 0x7fffffff;
> -        }
> -    }
> -}
> -
> -static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
> +static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
> +                           unsigned size)
>  {
> -    uint32_t retval;
>      MACIOIDEState *d =3D opaque;
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
> +    int reg =3D addr >> 4;
> +
> +    switch (reg) {
> +    case 0x0:
> +        if (size =3D=3D 2) {
> +            ide_data_writew(&d->bus, 0, val);
> +        } else if (size =3D=3D 4) {
> +            ide_data_writel(&d->bus, 0, val);
> +        }
> +        break;
> +    case 0x1 ... 0x7:
> +        if (size =3D=3D 1) {
> +            ide_ioport_write(&d->bus, reg, val);
> +        }
> +        break;
> +    case 0x8:
> +    case 0x16:
> +        if (size =3D=3D 1) {
> +            ide_cmd_write(&d->bus, 0, val);
> +        }
> +        break;
> +    case 0x20:
> +        if (size =3D=3D 4) {
> +            d->timing_reg =3D val;
> +        }
> +        break;
> +    case 0x30:
> +        if (size =3D=3D 4) {
> +            if (val & 0x80000000u) {
> +                d->irq_reg &=3D 0x7fffffff;
> +            }
> +        }
> +        break;
>      }
> -    retval =3D bswap32(retval);
> -    return retval;
>  }
> =20
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
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
>  static const VMStateDescription vmstate_pmac =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnB7osACgkQbDjKyiDZ
s5LpQg/9Eckv9Ch9Oq40FYC2QplwFCg5tlXGqY4KcyfJHqVcFYvy2Qn8RVY/bjmk
NXTpibCmgb11uFR3VQ07DUuPEUCXIF03uodXk2nhcdtMSKs2pMx0QfGomKMPCyoy
3W2iPBnKlQCiysqyu0wZpSXJFKsVo0hwC3oCZKKEngxhDf3x06a4FbG1H4SDumxO
COSINMGcR0RRow5rSPdvxetykQQGU/qmGLgecj7aALOHt7j5wcrcy4SnTq0nqUkW
k1uR3G9ji9lu+2GJA5O/1auEFwTyWFNhCNLRnsuh4hcjNQO76GDSHUmSrs9i5vXA
xsNEKFwfgS2UoWla3z6TfNuBZzbL/P8/i2vOyM1oxvX3P7/ulJtyzMwVtpr5OBJq
regrMGza3iM4V78z9h9KI7yOjIzAbnhUg3ZhO4tRqHeE33Cx+7GSsj/vdqBp82gr
yxRp+zYnk0Zr7ou36liFmhTmdS3iHA0+uVRWWEgHaq1/f0phC+Aci1Duw3onNDzM
w4AgimlyFIucw+ha18OvuL1PLe77Id4e41ExOymCjHd7zLgXgUjTu7auHSfgLPmC
RMznbckcvpvyZrEqMLCgINboQ6dphfe1kXzzElYl6ObALBPATdslEL+k7Ugm2KKX
NTwD8FgWZPPsPdJaCHQ1Hzag98NWbeQckXLRNKihGPgFNr9g4/U=
=lg5v
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
