Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1civKj-0000aW-8V
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1civKh-00039e-I9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:45 -0500
Date: Wed, 1 Mar 2017 13:56:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301025644.GK12571@umbus.fritz.box>
References: <1488329807-11193-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <1488329807-11193-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: allow control of BAR alignment
 through SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 06:56:47PM -0600, Michael Roth wrote:
> In certain cases, such as PCI-passthrough with VFIO, we cannot offload
> MMIO accesses to KVM unless the BAR alignment matches the host. This
> patch, in conjunction with a separately submitted patch for SLOF
> which allows for control of this via the device-tree, allows us to
> set this alignment via QEMU.
>=20
> Cc: qemu-ppc@nongnu.org
> Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c              | 7 ++++++-
>  hw/ppc/spapr_pci.c          | 8 ++++++++
>  include/hw/pci-host/spapr.h | 1 +
>  3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 81c6c1c..321951c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3121,7 +3121,12 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
>   * pseries-2.8
>   */
>  #define SPAPR_COMPAT_2_8                            \
> -    HW_COMPAT_2_8
> +    HW_COMPAT_2_8                                   \
> +    {                                               \
> +        .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,     \
> +        .property =3D "mem_bar_min_align",            \
> +        .value    =3D "0",                            \
> +    },                                              \
> =20
>  static void spapr_machine_2_8_instance_options(MachineState *machine)
>  {
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2a3499e..fdfd494 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1660,6 +1660,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
> =20
> +    if (sphb->mem_bar_min_align =3D=3D (uint64_t)-1) {
> +        sphb->mem_bar_min_align =3D qemu_real_host_page_size;
> +    }
> +
>      sphb->dtbusname =3D g_strdup_printf("pci@%" PRIx64, sphb->buid);
> =20
>      namebuf =3D alloca(strlen(sphb->dtbusname) + 32);
> @@ -1854,6 +1858,8 @@ static Property spapr_phb_properties[] =3D {
>      DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
>      DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
>                       pre_2_8_migration, false),
> +    DEFINE_PROP_UINT64("mem_bar_min_align", sPAPRPHBState, mem_bar_min_a=
lign,
> +                       -1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2224,6 +2230,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      if (ret) {
>          return ret;
>      }
> +    _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,mem-bar-min-align",
> +                          phb->mem_bar_min_align));

AFAICT the sensible thing to do here is to leave the property out on
older machine types.  In which case you need an if
(phb->mem_bar_min_align) here.
> =20
>      return 0;
>  }
> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> index dfa7614..fa33346 100644
> --- a/include/hw/pci-host/spapr.h
> +++ b/include/hw/pci-host/spapr.h
> @@ -79,6 +79,7 @@ struct sPAPRPHBState {
>      uint64_t dma64_win_addr;
> =20
>      uint32_t numa_node;
> +    uint64_t mem_bar_min_align;
> =20
>      /* Fields for migration compatibility hacks */
>      bool pre_2_8_migration;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtjhrAAoJEGw4ysog2bOSwiYP/i4oyeI9v2IvpBPYEoZeWMsP
tsDBeqej/dSJHYyE//bAjEKg95fHiZ2gK+qu0sAVvjdenByAydgvVeATRUKTOi/+
6GEgJpH9JYJNsxxbDmXjQZJFuU/a5LPSCej4YmmaxwT5HaCpkJObb1HCAcvi+YUL
MqZUaLneGnVqadVsP8LjsKVnaluELE4MNlKcvQh9FZFiUNDOrJnRzB6i6RCL8ZXC
HEVYKY/eQSDcwoK9Hg/9i/qarEDJ9RwOizTiSajzuCLPCFqtGOck5jOefMDZrgMG
4D8W9mgAmAG9SFaf/XDhYJcOOSu+NU2nLHKa0B/3xkebWngfjIKfFCM+DXklhtUP
2wtVZ2b2sx4IL5ohOwD0aOpyTnHxfKaZrlRApDlzIaXcdWvAdLhNFtx8qwYXz/4k
f0MdBLxsVSW9IWG4EAT9eKBff5xWRuLEr7GDNNKRW+7gHFIi6b3zS8dAPatx4qMC
May2otjyk8RvJQYKeOZFAeyqTrP4N5hDDXoEQvC14jOqKx7PJBPsrwhvemGY1qZu
YkpyjrR0uSxH9PRTOJeNNLAYjwiJEzl5Oiy9+x04eo+fmVMjVE7MpipiuXbfPs/B
eV+A56DN0DwD9PSmO0HB8aEuno5ZepuWC6/1aPCvFA9gKAN+nmu/7a9Puu8nQHM7
FVHshxJkNrK0V46ZD8f9
=yRtp
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
