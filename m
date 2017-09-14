Received: from eggs.gnu.org ([2001:4830:134:3::10]:50023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsTta-00066s-U3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsTtV-0000aS-DA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:09:30 -0400
Date: Thu, 14 Sep 2017 22:31:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914123126.GN3972@umbus.fritz.box>
References: <150537259490.3298.1180094221641142666.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Content-Disposition: inline
In-Reply-To: <150537259490.3298.1180094221641142666.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 09:03:15AM +0200, Greg Kurz wrote:
> Creating several PHBs without index property confuses the DRC code
> and causes issues:
> - only the first index-less PHB is functional, the other ones will
>   silently ignore hotplugging of PCI devices
> - QEMU will even terminate if these PHBs have cold-plugged devices
>=20
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
> RFC->v1: - as suggested dy David, updated the changelog to explicitely
>            mention that we intentionally break backwards compat.
> ---
>  hw/ppc/spapr_pci.c |   52 ++++++++++------------------------------------=
------
>  1 file changed, 10 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index cf54160526fa..9a338b7f197b 100644
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
> @@ -1789,18 +1755,12 @@ static void spapr_phb_reset(DeviceState *qdev)
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
> @@ -1937,6 +1897,13 @@ static const char *spapr_phb_root_bus_path(PCIHost=
State *host_bridge,
>      return sphb->dtbusname;
>  }
> =20
> +static void spapr_phb_instance_init(Object *obj)
> +{
> +    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
> +
> +    sphb->mem64_win_addr =3D (hwaddr)-1;
> +}
> +

Why do we need to initialize this field especially?

>  static void spapr_phb_class_init(ObjectClass *klass, void *data)
>  {
>      PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
> @@ -1960,6 +1927,7 @@ static const TypeInfo spapr_phb_info =3D {
>      .parent        =3D TYPE_PCI_HOST_BRIDGE,
>      .instance_size =3D sizeof(sPAPRPHBState),
>      .class_init    =3D spapr_phb_class_init,
> +    .instance_init =3D spapr_phb_instance_init,
>      .interfaces    =3D (InterfaceInfo[]) {
>          { TYPE_HOTPLUG_HANDLER },
>          { }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm6dpwACgkQbDjKyiDZ
s5I6dg/+I4BuK9vJwBSkNxJi2CoHm4q6WfZ6t8x15lx/id5yZVXKeQoUoP/CY/jg
NmaLd4ORIQWgfBDPyks7coelrI5/6Tk8vZgV5vIj0iRwQA8tt/W+MOKQkzZWsLgt
YaIOkA1BGhkv61qThOE8QfEyQs3aSsFkYclikQc3euvTiwTRuu98Yn6hHvkYNFp0
Xfpio0y3n9S1h8vui00/ETl2XyX10kD8x2sfhWKzpKTHzUGzlzRx83kUwBVM6Y3/
dxqhUGiJ0Wknh4gsR8UluOZf8oc3yuPwnASyJC/ay8SIpuHrKD2O4r8/Er/bbGEx
tFrboxD1mF0YSygBVJw7GJGG6qNKk81Z/AZjd+BYvJpLmsVfWfedmbnxS26pOm9O
Vjqaow3DUWdy+/f6n9wb2FTcXG6incFWC0RFsCP65xx7PaycRQQG/JMHoNje6qqq
hxu0+QZfb2ZelbZ4dpVCsquisKuIjRpnekmKUndgO48T0XLA89NZumBLv6HuuDrp
i1Q2rBggDVTOoHhAd4VHuj83jNL7oR+kqQGgOrX5+ALXRWmZWQx+6qFR92Ic/FdI
CAObk5XePC8BgbbjrWnKpafVYU35EE9NaZ2fdCoef6KXjyfwe3xcNZkWbBeyjBkV
otPmasIFM4giw5jaVAzO9pAUWOhaphDulLh+nXM0IT8HgXuv/X8=
=+zqE
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--
