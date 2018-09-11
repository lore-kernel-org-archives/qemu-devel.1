Received: from eggs.gnu.org ([2001:4830:134:3::10]:39779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXfs-0006ku-Dx
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXfo-00014I-8P
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:41:04 -0400
Date: Tue, 11 Sep 2018 11:27:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911012726.GB7978@umbus.fritz.box>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20180910204631.24106-2-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] lsi53c895a: add optional external
 IRQ via qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: hpoussin@reactos.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 09:46:30PM +0100, Mark Cave-Ayland wrote:
> On some early machines the on-board PCI devices IRQs are wired directly to
> the interrupt controller instead of via the PCI host bridge.
>=20
> Add an optional external IRQ that if wired up via qdev will replace the
> in-built PCI IRQ.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Fam, if I get an Acked-by from you I'm happy to take this through my tree.

> ---
>  hw/scsi/lsi53c895a.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index f5cbbf653c..996b40650d 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -207,6 +207,7 @@ typedef struct {
>      PCIDevice parent_obj;
>      /*< public >*/
> =20
> +    qemu_irq ext_irq;
>      MemoryRegion mmio_io;
>      MemoryRegion ram_io;
>      MemoryRegion io_io;
> @@ -443,9 +444,19 @@ static void lsi_stop_script(LSIState *s)
>      s->istat1 &=3D ~LSI_ISTAT1_SRUN;
>  }
> =20
> -static void lsi_update_irq(LSIState *s)
> +static void lsi_set_irq(LSIState *s, int level)
>  {
>      PCIDevice *d =3D PCI_DEVICE(s);
> +
> +    if (s->ext_irq) {
> +        qemu_set_irq(s->ext_irq, level);
> +    } else {
> +        pci_set_irq(d, level);
> +    }
> +}
> +
> +static void lsi_update_irq(LSIState *s)
> +{
>      int level;
>      static int last_level;
>      lsi_request *p;
> @@ -477,7 +488,7 @@ static void lsi_update_irq(LSIState *s)
>                  level, s->dstat, s->sist1, s->sist0);
>          last_level =3D level;
>      }
> -    pci_set_irq(d, level);
> +    lsi_set_irq(s, level);
> =20
>      if (!level && lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON)) {
>          DPRINTF("Handled IRQs & disconnected, looking for pending "
> @@ -2213,6 +2224,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error =
**errp)
>                            "lsi-io", 256);
> =20
>      address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pc=
i-io");
> +    qdev_init_gpio_out(d, &s->ext_irq, 1);
> =20
>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_io);
>      pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio_io);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXGfwACgkQbDjKyiDZ
s5L8Hg//YyM47IAtnbuHrJxRgEEk1fzTFYWgt9/VMFUmQM4Yq6zIcOhN05HRiW/c
79+AtNKjvXJOPUS2ZMwGfhtCoPT468anNuGdj7NRT1TpjfOwJ5EZVz9PmiXRp0AN
V8x9eTgJP680O4YsZgBw53fqwCBPPMUvIXUONq/mDbnBJ5Zkasq+qBacSdMHRx/D
dHS2oa1OaCqe3TiduHSuz4hNR70kB7dzDjVEhQy/3s2BNIT4TKuWH+jv2zaGKenP
Ij/o0n0qoSoYRAAGbfyiu+ZpJnDXNhoyJmzdXVK7oB9xx5aalgTEYmJ8i8mxqYPT
LgfJEPc5xzCEsTC194XEgsMx6Dd8BExBSO3qw/fDe+h9Qf3+yh5ttqRquS9mRZ2n
YNao2qun98R5PimznbTxeEEPiQYvDB84E1L0Sn6xmQ8ZWNEx0w53Klt1/KPinwtb
5ioReV8zL9KeBQhsHxMUOH8CLYhWvrDUmQ1AVF3Qr4d/zOdG3b/IYEir440xJT2L
dxYAk9Dz/84KWkarHLOdmFag2toD00Et3bl55KPHL7ZGSLbeqN7RjOQpZcD6n+ib
QzEeMkr1R9MP5lh5dtjPXVBAL1wXBGgr8Rgm9a2Thn8+fQQZI1AOXWf+oH7zffX5
A2pNp6YWuyoRKdl10A5TVK+C8bma2umUpRMyoAYkFRNKA5Yk1zs=
=J1Ci
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
