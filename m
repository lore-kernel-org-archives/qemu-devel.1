Received: from eggs.gnu.org ([2001:4830:134:3::10]:50968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtP-00016B-7T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtN-0002hp-Qm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:39 -0400
Date: Tue, 19 Sep 2017 06:27:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918202749.GF15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-4-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 3/8] ppc/ide/macio: Add missing registers
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


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:43PM +0100, Mark Cave-Ayland wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> The timing register exists on all variants of MacIO IDE, we just
> store and return its value.
>=20
> The interrupts register only exists on KeyLargo but it doesn't
> hurt to have it. The lack of this register causes MacOS X to
> hangs under some circumstances.
>=20
> Both are 32-bit only. The HW might support smaller access sizes
> but no known OS uses them.
>=20
> Because the core IDE subsystem doesn't provide us with a way
> to query the main (level) interrupt state, nor do we have a way
> to know that DBDMA issued a (edge) interrupt, we reflect both
> through a private pair of qirq's in order to maintain the
> register state.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to ppc-for-2.11.

> ---
>  hw/ide/macio.c |   44 +++++++++++++++++++++++++++++++++++++++++---
>  hw/ppc/mac.h   |    6 +++++-
>  2 files changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index 9742c00..db5db39 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -331,6 +331,12 @@ static void pmac_ide_writel (void *opaque,
>      val =3D bswap32(val);
>      if (addr =3D=3D 0) {
>          ide_data_writel(&d->bus, 0, val);
> +    } else if (addr =3D=3D 0x20) {
> +        d->timing_reg =3D val;
> +    } else if (addr =3D=3D 0x30) {
> +        if (val & 0x80000000u) {
> +            d->irq_reg &=3D 0x7fffffff;
> +        }
>      }
>  }
> =20
> @@ -342,6 +348,17 @@ static uint32_t pmac_ide_readl (void *opaque,hwaddr =
addr)
>      addr =3D (addr & 0xFFF) >> 4;
>      if (addr =3D=3D 0) {
>          retval =3D ide_data_readl(&d->bus, 0);
> +    } else if (addr =3D=3D 0x20) {
> +        retval =3D d->timing_reg;
> +    } else if (addr =3D=3D 0x30) {
> +        /* This is an interrupt state register that only exists
> +         * in the KeyLargo and later variants. Bit 0x8000_0000
> +         * latches the DMA interrupt and has to be written to
> +         * clear. Bit 0x4000_0000 is an image of the disk
> +         * interrupt. MacOS X relies on this and will hang if
> +         * we don't provide at least the disk interrupt
> +         */
> +        retval =3D d->irq_reg;
>      } else {
>          retval =3D 0xFFFFFFFF;
>      }
> @@ -426,13 +443,32 @@ static void macio_ide_realizefn(DeviceState *dev, E=
rror **errp)
>  {
>      MACIOIDEState *s =3D MACIO_IDE(dev);
> =20
> -    ide_init2(&s->bus, s->irq);
> +    ide_init2(&s->bus, s->ide_irq);
> =20
>      /* Register DMA callbacks */
>      s->dma.ops =3D &dbdma_ops;
>      s->bus.dma =3D &s->dma;
>  }
> =20
> +static void pmac_ide_irq(void *opaque, int n, int level)
> +{
> +    MACIOIDEState *s =3D opaque;
> +    uint32_t mask =3D 0x80000000u >> n;
> +
> +    /* We need to reflect the IRQ state in the irq register */
> +    if (level) {
> +        s->irq_reg |=3D mask;
> +    } else {
> +        s->irq_reg &=3D ~mask;
> +    }
> +
> +    if (n) {
> +        qemu_set_irq(s->real_ide_irq, level);
> +    } else {
> +        qemu_set_irq(s->real_dma_irq, level);
> +    }
> +}
> +
>  static void macio_ide_initfn(Object *obj)
>  {
>      SysBusDevice *d =3D SYS_BUS_DEVICE(obj);
> @@ -441,8 +477,10 @@ static void macio_ide_initfn(Object *obj)
>      ide_bus_new(&s->bus, sizeof(s->bus), DEVICE(obj), 0, 2);
>      memory_region_init_io(&s->mem, obj, &pmac_ide_ops, s, "pmac-ide", 0x=
1000);
>      sysbus_init_mmio(d, &s->mem);
> -    sysbus_init_irq(d, &s->irq);
> -    sysbus_init_irq(d, &s->dma_irq);
> +    sysbus_init_irq(d, &s->real_ide_irq);
> +    sysbus_init_irq(d, &s->real_dma_irq);
> +    s->dma_irq =3D qemu_allocate_irq(pmac_ide_irq, s, 0);
> +    s->ide_irq =3D qemu_allocate_irq(pmac_ide_irq, s, 1);
>  }
> =20
>  static void macio_ide_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
> index 20cbddb..300fc8a 100644
> --- a/hw/ppc/mac.h
> +++ b/hw/ppc/mac.h
> @@ -132,7 +132,9 @@ typedef struct MACIOIDEState {
>      SysBusDevice parent_obj;
>      /*< public >*/
> =20
> -    qemu_irq irq;
> +    qemu_irq real_ide_irq;
> +    qemu_irq real_dma_irq;
> +    qemu_irq ide_irq;
>      qemu_irq dma_irq;
> =20
>      MemoryRegion mem;
> @@ -140,6 +142,8 @@ typedef struct MACIOIDEState {
>      IDEDMA dma;
>      void *dbdma;
>      bool dma_active;
> +    uint32_t timing_reg;
> +    uint32_t irq_reg;
>  } MACIOIDEState;
> =20
>  void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnALEUACgkQbDjKyiDZ
s5JZdRAAwoF1u3xIiGQhIjM7bPgjHQVrGLQ3O6Wwys/Y7n6WSoqTB7RsB5wm3dEw
jIbAmIUU3F2CuJ2WC42tnMUJgS5PIsQre34DFrtAF4paZ2K21CgTWHU/JbIogpZ4
Ck6Tn4qPpEvJCSFxhwCVVKIG/6lSkmr5LiGk5BukA3FZSYz2OxIZOZVszD+EBEta
eemBljsFUqqF/C9231MnDpq23hCoQR5KrbqjCI/ZJcSpot7LzCOMFshre4DvHY1i
MQt0abmF8b0uwtp2hwLXFjO9nPMaLWHbo6e9LmDBIQgDySqwaWyxDdfCRIixoGlt
Kd68NWUM82csA4IlAD6bC2ZKniakb1fZT3atfBqeT6oiWGgRvOoxO9wDJMNxA80q
O3JN4iiO/C5wwxzj7e6dzMmqc+Nq9bCJohrlNRQz0ArQIcbjcUA/nKxbICUVarpP
ubEpirp9FnXyIh//t2E66jepekbkehFvYF3QVLn/QpqRCKMVdn1YXVJS7+cq6MAf
v4X0hWkrCjNbO83v4UQSgEUOuPKjqpoLocuV4PRccKddmzUUOrEtnMGtQXXz63eG
wxzICRAaOiS+vtDhLQlkz/xduj5zqXatgddwcFR8Gt142kvrRV3Fjia5OAX0nKWD
kleFhI6IgklfcXdhNJqvQAOfSBM+gxI9QhQfPIRdBPXKCPs8AJg=
=289p
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
