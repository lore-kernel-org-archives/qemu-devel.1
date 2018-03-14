Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew07Y-00080r-Gg
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ew07V-0004hb-A1
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 02:42:44 -0400
Date: Wed, 14 Mar 2018 17:42:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180314064222.GN4182@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="I4g3zIzscEHdx6fd"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 00/19] uninorth fixes/mac_newworld board
 wiring improvements
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


--I4g3zIzscEHdx6fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:44PM +0000, Mark Cave-Ayland wrote:
> [This is for New World Machines: there is a follow-up patch for Old World=
 Machines]
>=20
> This patchset is a combination of uninorth fixes/cleanup with the final a=
im
> of removing the remaining custom init functions and switching IRQ arrays =
over
> to qdev GPIOs.
>=20
> The first couple of patches apply some style fixups and remove what appea=
rs to
> be an obsolete set of uninorth registers according to my testing.
>=20
> Following on from this, the next few patches QOMify the PCI/AGP host brid=
ges
> and change the existing _init() functions to return the device itself. Th=
is
> allows the memory regions to be setup during device init, and using a tem=
porary
> qdev pointer property allows moving the remaining initialisation to device
> realize.
>=20
> Next we fix the mixup between the PCI/AGP host bridges making sure that t=
he correct
> PCI bus instance is instantiated for the corresponding host bridge , and =
enabling
> the third PCI host bridge. This allows potential handling of any accesses=
 although
> it should be ignored for all OSs that correctly parse the DT since OpenBI=
OS currently
> only supports (and exposes) a single PCI host bridge.
>=20
> Once the legacy _init() functions have been removed and all devices are
> instantiated via the qdev API, it is then possible to wire up the PCI IO
> space to the relevant PCI bus.
>=20
> After this we implement a separate uninorth device (equivalent to uni-n i=
n the
> Mac New World DT) as suggested by the TODO comment and wire it up as part=
 of the
> board initialisation.
>=20
> Finally once this is done we can remove the temporary pics IRQ array and =
instead
> wire up the macio_newworld device to the PIC directly using the existing =
object
> link.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I've applied the patches up to 16/19 to ppc-for-2.13.

>=20
> Mark Cave-Ayland (19):
>   uninorth: trivial style fixups
>   uninorth: remove second set of uninorth token registers
>   uninorth: QOMify PCI and AGP host bridges
>   uninorth: remove stray PCIBus realize from mac_newworld.c
>   uninorth: move uninorth definitions into uninorth.h
>   uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return
>     uninorth device
>   uninorth: move PCI mmio memory region initialisation into init
>     function
>   uninorth: introduce temporary pic_irqs device property
>   uninorth: move PCI host bridge bus initialisation into device realize
>   uninorth: fix PCI and AGP bus mixup
>   uninorth: enable internal PCI host bridge
>   uninorth: remove obsolete pci_pmac_init() function
>   uninorth: remove obsolete pci_pmac_u3_init() function
>   uninorth: use object link to pass OpenPIC object to uninorth
>   uninorth: move PCI IO (ISA) memory region into the uninorth device
>   uninorth: rename UNINState to UNINHostState
>   uninorth: create new uninorth device
>   mac_newworld: remove pics IRQ array and wire up macio to OpenPIC
>     directly
>   mac_newworld: move wiring of macio IRQs to macio_newworld_realize()
>=20
>  hw/misc/macio/macio.c          |  37 ++--
>  hw/pci-host/trace-events       |   2 +
>  hw/pci-host/uninorth.c         | 415 ++++++++++++++++++++++++-----------=
------
>  hw/ppc/mac.h                   |  20 +-
>  hw/ppc/mac_newworld.c          | 124 ++++++------
>  hw/ppc/trace-events            |   4 -
>  include/hw/misc/macio/macio.h  |   1 -
>  include/hw/pci-host/uninorth.h |  65 +++++++
>  8 files changed, 404 insertions(+), 264 deletions(-)
>  create mode 100644 include/hw/pci-host/uninorth.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I4g3zIzscEHdx6fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqoxEwACgkQbDjKyiDZ
s5JutRAAzrDnzDS/vlioDzuBHy0NWy575UJGZUkjcVAoMeW+7Xie7kwRUXsBKGy6
KbQH95ZcTKcPpcKk/vfqXSkz6nyv9lyHnwyEjgRMyAKSAset8P7ZhBEzL8IiYu1v
kbgi6PEBE99iOACMZGrU5/wkbS9D1+cJ7C3A1r72Qa7VzXYYks1idEB1yYuCrFqJ
ZXnCHpHvMDfFGBP9MJUXtjjqHNFJdzuE7rgoXPU4gt6Fdt/sBO8lMvS18IZl/Oxv
umeQQcwn7XJtfJb1izlSgmLwJ4J5S+MNNS4IYeWlXVvPLygM3f2dPWqRDujMcxUE
BmoBTIjVI0UQpG8BHZMlWPIQlbQ7hknu+BcBC7owemPAf0FMWrjR0HndnnegRB01
/OcMRbwLjS/JzF1tYPC9iXD8Epzhn6GRFyDvbK7ksIui8UEVb/urNrrGrvtQHRCX
KcAJLFiYeNm9nCX5cFYwtINaeAqbIZY9pl7ESww4i3YQE9mmVZrRCzru0IaYSlp+
2FhPs4a3aTby8WcEkR5wW2ST0u3EzaQ/0WDqi8IX3MMEhPMZKFogwvAruRXVDk2C
9dDxp9p8w7OiRR554x+P0nv8pGGnRu2PYkAmWSFRjMbVCXNEpNYLWrchNZlnrINm
ejDMV/uMOFeYU+F9Ut8RF1SjhOqvp+SVFDHQ1A5uuM+sVJmt/z0=
=3MAU
-----END PGP SIGNATURE-----

--I4g3zIzscEHdx6fd--
