Received: from eggs.gnu.org ([2001:4830:134:3::10]:51099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0001DF-Uo
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtR-0002nv-0Q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:43 -0400
Date: Tue, 19 Sep 2017 09:03:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918230358.GG27153@umbus>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
	<150539848430.21523.2732328570419779115.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <150539848430.21523.2732328570419779115.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr_pci: make index property
 mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 04:14:44PM +0200, Greg Kurz wrote:
> Creating several PHBs without index property confuses the DRC code
> and causes issues:
> - only the first index-less PHB is functional, the other ones will
>   silently ignore hotplugging of PCI devices
> - QEMU will even terminate if these PHBs have cold-plugged devices

So, this is true, but it's kind of missing the point; we could fix
those things if we wanted.  The real point here is that the non-index
option is more trouble than it's worth: it's difficult to use, keeps
requiring (potentially incompatible) changes when some new parameter
needs adding, and is awkward to check for collisions.

> qemu-system-ppc64: -device virtio-net,bus=3Dpci2.0: an attached device
>  is still awaiting release
>=20
> This happens because DR connectors for child PCI devices are created
> with a DRC index that is derived from the PHB's index property. If the
> PHBs are created without index, then the same value of -1 is used to
> compute the DRC indexes for both PHBs, hence causing the collision.
>=20
> Also, the index property is used to compute the placement of the PHB's
> memory regions. It is limited to 31 or 255, depending on the machine
> type version. This fits well with the requirements of DRC indexes, which
> need the PHB index to be a 16-bit value.
>=20
> This patch hence makes the index property mandatory. As a consequence,
> the PHB's memory regions and BUID are now always configured according
> to the index, and it is no longer possible to set them from the command
> line. We have to introduce a PHB instance init function to initialize
> the 64-bit window address to -1 because pseries-2.7 and older machines
> don't set it.
>=20
> This DOES BREAK backwards compat, but we don't think the non-index
> PHB feature was used in practice (at least libvirt doesn't) and the
> simplification is worth it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v1->v2: - error out if mem64_win_pciaddr is set but mem64_win_size
>           isn't
>         - set mem64_win_addr to -1 for old configuration with 32-bit
>           window below 2G in spapr_phb_realize()
>         - drop instance init function
>=20
> RFC->v1: - as suggested dy David, updated the changelog to explicitely
>            mention that we intentionally break backwards compat.
> ---
>  hw/ppc/spapr_pci.c |   53 +++++++++++-----------------------------------=
------
>  1 file changed, 11 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index cf54160526fa..024638e18b53 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1523,16 +1523,6 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>          Error *local_err =3D NULL;
> =20
> -        if ((sphb->buid !=3D (uint64_t)-1) || (sphb->dma_liobn[0] !=3D (=
uint32_t)-1)
> -            || (sphb->dma_liobn[1] !=3D (uint32_t)-1 && windows_supporte=
d =3D=3D 2)
> -            || (sphb->mem_win_addr !=3D (hwaddr)-1)
> -            || (sphb->mem64_win_addr !=3D (hwaddr)-1)
> -            || (sphb->io_win_addr !=3D (hwaddr)-1)) {
> -            error_setg(errp, "Either \"index\" or other parameters must"
> -                       " be specified for PAPR PHB, not both");
> -            return;
> -        }
> -
>          smc->phb_placement(spapr, sphb->index,
>                             &sphb->buid, &sphb->io_win_addr,
>                             &sphb->mem_win_addr, &sphb->mem64_win_addr,
> @@ -1541,36 +1531,12 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>              error_propagate(errp, local_err);
>              return;
>          }
> -    }
> -
> -    if (sphb->buid =3D=3D (uint64_t)-1) {
> -        error_setg(errp, "BUID not specified for PHB");
> -        return;
> -    }
> -
> -    if ((sphb->dma_liobn[0] =3D=3D (uint32_t)-1) ||
> -        ((sphb->dma_liobn[1] =3D=3D (uint32_t)-1) && (windows_supported =
> 1))) {
> -        error_setg(errp, "LIOBN(s) not specified for PHB");
> -        return;
> -    }
> -
> -    if (sphb->mem_win_addr =3D=3D (hwaddr)-1) {
> -        error_setg(errp, "Memory window address not specified for PHB");
> -        return;
> -    }
> -
> -    if (sphb->io_win_addr =3D=3D (hwaddr)-1) {
> -        error_setg(errp, "IO window address not specified for PHB");
> +    } else {
> +        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
>          return;
>      }
> =20
>      if (sphb->mem64_win_size !=3D 0) {
> -        if (sphb->mem64_win_addr =3D=3D (hwaddr)-1) {
> -            error_setg(errp,
> -                       "64-bit memory window address not specified for P=
HB");
> -            return;
> -        }
> -
>          if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
>              error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PR=
Ix
>                         " (max 2 GiB)", sphb->mem_win_size);

Some of these checks could probably just become assert()s now, where
they're things determined by the placement code and no longer have
parameters, a problem indicates a bug in the machine rather than a
user error.

> @@ -1581,6 +1547,9 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
>              /* 64-bit window defaults to identity mapping */
>              sphb->mem64_win_pciaddr =3D sphb->mem64_win_addr;
>          }
> +    } else if (sphb->mem64_win_pciaddr !=3D (hwaddr) -1) {
> +        error_setg(errp, "64-bit memory window requires \"mem64_win_size=
\"");
> +        return;

Likewise this new one.

>      } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
>          /*
>           * For compatibility with old configuration, if no 64-bit MMIO
> @@ -1594,6 +1563,12 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          sphb->mem64_win_pciaddr =3D
>              SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
>          sphb->mem_win_size =3D SPAPR_PCI_MEM32_WIN_SIZE;
> +    } else {
> +        /* Old configuration with the 32-bit MMIO window <=3D 2GiB don't=
 need a
> +         * 64-bit MMIO window.
> +         */

Wouldn't it be easier to just change the test below to check for size
!=3D 0 instead of checking for addr !=3D -1 as it does now.

> +        sphb->mem64_win_addr =3D (hwaddr) -1;
> +        sphb->mem64_win_pciaddr =3D (hwaddr) -1;
>      }
> =20
>      if (spapr_pci_find_phb(spapr, sphb->buid)) {
> @@ -1789,18 +1764,12 @@ static void spapr_phb_reset(DeviceState *qdev)
> =20
>  static Property spapr_phb_properties[] =3D {
>      DEFINE_PROP_UINT32("index", sPAPRPHBState, index, -1),
> -    DEFINE_PROP_UINT64("buid", sPAPRPHBState, buid, -1),
> -    DEFINE_PROP_UINT32("liobn", sPAPRPHBState, dma_liobn[0], -1),
> -    DEFINE_PROP_UINT32("liobn64", sPAPRPHBState, dma_liobn[1], -1),
> -    DEFINE_PROP_UINT64("mem_win_addr", sPAPRPHBState, mem_win_addr, -1),
>      DEFINE_PROP_UINT64("mem_win_size", sPAPRPHBState, mem_win_size,
>                         SPAPR_PCI_MEM32_WIN_SIZE),
> -    DEFINE_PROP_UINT64("mem64_win_addr", sPAPRPHBState, mem64_win_addr, =
-1),
>      DEFINE_PROP_UINT64("mem64_win_size", sPAPRPHBState, mem64_win_size,
>                         SPAPR_PCI_MEM64_WIN_SIZE),
>      DEFINE_PROP_UINT64("mem64_win_pciaddr", sPAPRPHBState, mem64_win_pci=
addr,
>                         -1),
> -    DEFINE_PROP_UINT64("io_win_addr", sPAPRPHBState, io_win_addr, -1),
>      DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
>                         SPAPR_PCI_IO_WIN_SIZE),
>      DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_enable=
d,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAUNwACgkQbDjKyiDZ
s5JDsBAApu7BC+53CBO+vJ/iI0fTOgsWdJvIAj4LMAbWgwQhs0+AlQ1k9HMdSJRa
pcYdtDZ2UkvXUNo8iKfBlTRmdvzML02lKzkZmrpp4h3dZfv/iWMuZSLZP+/oW4W4
zdyVNh1zPNV+umBEilM+aTYRNpfW3gjwpeclvnBeuluWaVV8NsdeLhLWf+jQuKYJ
hV96ZSCysVgFy3CfDxkGXGP1pevVwA3rTeFQmU0j6I/HT0C9EJBpWtRtfHXI3vQm
qytwWrFKUzfwtz/4+y84HPoeA5ED7QyfPgW3DWpQK/rhiTk3vsm5bF2iuBgHhQKf
WMiluSDAos1qBnbVCPRToF5TeH2D/DbT4RklPryfP0lWrJhqW/jIJMId96l94IHw
l1KrW17W8LJJUjWf7KdgxD1YwSIBEwrDo6uYBZli10p/scqpU7h6wCJEGJc2NRuR
QlsdTanO8nLwuEBOIC5vDKINP9D1KEj6P2x35zixvBl3UaIoe8O9wg3Z8vKfWfLz
LaRk0KrUDM2geilaLiBP7QA1NMZf3nJu027F6MyIvFGplRlHC3qnc1sFROCBuSSw
TuueFFYhrzB3bGet8OFbTgt7wmWv9IG/+L4sZbK8GhvY+RJV1kAtZLQUafcDEaAD
izkv1qQjhWCtmHykGkuCN3qQIaXofWzU+8vpJ78LUTJ283reYs4=
=2aO2
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
