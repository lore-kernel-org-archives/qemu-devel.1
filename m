Received: from eggs.gnu.org ([2001:4830:134:3::10]:42899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaG-0005GE-Nc
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaF-0007pM-HD
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:08 -0500
Date: Thu, 8 Mar 2018 13:04:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308020425.GM3083@umbus.fritz.box>
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Content-Disposition: inline
In-Reply-To: <1520413694-1271-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 10:08:14AM +0100, Thomas Huth wrote:
> The global hack for creating SCSI devices has recently been removed,
> but this apparently broke SCSI devices on some boards that were not
> ready for this change yet. For the 40p machine you now get:
>=20
> $ ppc64-softmmu/qemu-system-ppc64 -M 40p -cdrom x.iso
> qemu-system-ppc64: -cdrom x.iso: machine type does not support if=3Dscsi,=
bus=3D0,unit=3D2
>=20
> Fix it by providing a lsi53c810_create() function that takes care
> of calling scsi_bus_legacy_handle_cmdline() after creating the
> corresponding SCSI controller.
>=20
> Fixes: 1454509726719e0933c800fad00d6999752688ea
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/ppc/prep.c        | 2 +-
>  hw/scsi/lsi53c895a.c | 7 +++++++
>  include/hw/pci/pci.h | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 096d4d4..3361509 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -788,7 +788,7 @@ static void ibm_40p_init(MachineState *machine)
>          qdev_prop_set_uint32(dev, "equipment", 0xc0);
>          qdev_init_nofail(dev);
> =20
> -        pci_create_simple(pci_bus, PCI_DEVFN(1, 0), "lsi53c810");
> +        lsi53c810_create(pci_bus, PCI_DEVFN(1, 0));
> =20
>          /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>          pci_vga_init(pci_bus);
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index f3d4c4d..160657f 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2279,3 +2279,10 @@ void lsi53c895a_create(PCIBus *bus)
> =20
>      scsi_bus_legacy_handle_cmdline(&s->bus);
>  }
> +
> +void lsi53c810_create(PCIBus *bus, int devfn)
> +{
> +    LSIState *s =3D LSI53C895A(pci_create_simple(bus, devfn, "lsi53c810"=
));
> +
> +    scsi_bus_legacy_handle_cmdline(&s->bus);
> +}
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index d8c18c7..e255941 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -708,6 +708,7 @@ PCIDevice *pci_create(PCIBus *bus, int devfn, const c=
har *name);
>  PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name);
> =20
>  void lsi53c895a_create(PCIBus *bus);
> +void lsi53c810_create(PCIBus *bus, int devfn);
> =20
>  qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
>  void pci_set_irq(PCIDevice *pci_dev, int level);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqgmikACgkQbDjKyiDZ
s5KZHRAA2rLRODR/pSybSk91Wbw+RmL3sU3WkJn1zh2HQ0n1avn7p3fW4HtGFgYl
9ZBvWMGzTM2nbXxDrQVG+cihTQfniY99NeDZkBs3mPgzEt9KZOirmmv6j6DiAYMx
awjgolJUGZJW5KpzeqDTpIlGBYqLf7eDZECHmDSHjvves0326BHRrq0TTLYlwjHF
7gcmd0SZZEfHxuD9C21YHJIMd6HounivD9rlMfIIon1E09iV5jyghYfdqzd7usCN
PeuZp+kj2jnyTu46Fs3ukXAHsuRw7YupEGKs2javSFaEEgR73sV7J6vYrFfQvBWi
RhyqiYVY7s45hgbk1I/yvkd7aH2thxh8qbqFyIOsAH3z8yFEdPH20bRcGaTESRD7
X2VJ5Bng+f+3MVRAdd9xf13/QjGzyDiFNF87aNlHw0kPFuRWTolg0JHP8AIIZ7uS
LknknCVlvZlWLst1s6ZnOPXqDsagysZa4S0Z/O4UYo5raFNRIMTwk48vnsSUbb8A
aXd7tftKeluZzz30tLPU/YZr67PpNKLjmjvdwCYAMEmJ+AgodmbR4+xeTC8C7iwl
kIV66gJjFceMxOW8fHSZvLsILyNq3cLTkvVpL3eW02RBqsIsqMl21k5WadDlnbl/
SVutwDCGY0gYKx2fyp6EvnQkqAdOufo0qLd7gJ/mVKLphgDWSfs=
=hFZ6
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--
