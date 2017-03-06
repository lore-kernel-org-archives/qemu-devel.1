Received: from eggs.gnu.org ([2001:4830:134:3::10]:51479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckkM8-0002N3-AI
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckkM4-0001vv-FT
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:34:44 -0500
Date: Mon, 6 Mar 2017 15:16:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170306041658.GH12030@umbus.fritz.box>
References: <1488583977-32253-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <1488583977-32253-1-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr_pci: allow control of BAR
 alignment through SLOF
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


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 05:32:57PM -0600, Michael Roth wrote:
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
> v2:
>   * Keep natural alignment as the default in SLOF, only set DT prop if
>     different alignment is specified by QEMU (David)

Unfortunately, this has missed the cutoff for qemu-2.9. =20

I'm afraid I'm still not entirely clear on the rationale here.

Why do we need a variable parameter based on the host page size?
Couldn't we just have SLOF always align to something "big enough"
(64kiB, IIUC)?

> ---
>  hw/ppc/spapr.c              |  7 ++++++-
>  hw/ppc/spapr_pci.c          | 10 ++++++++++
>  include/hw/pci-host/spapr.h |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 14192ac..ef8df35 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3166,7 +3166,12 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
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
> index 919d3c2..485d32d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1664,6 +1664,10 @@ static void spapr_phb_realize(DeviceState *dev, Er=
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
> @@ -1858,6 +1862,8 @@ static Property spapr_phb_properties[] =3D {
>      DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
>      DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
>                       pre_2_8_migration, false),
> +    DEFINE_PROP_UINT64("mem_bar_min_align", sPAPRPHBState, mem_bar_min_a=
lign,
> +                       -1),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2228,6 +2234,10 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>      if (ret) {
>          return ret;
>      }
> +    if (phb->mem_bar_min_align) {
> +        _FDT(fdt_setprop_cell(fdt, bus_off, "qemu,mem-bar-min-align",
> +                              phb->mem_bar_min_align));
> +    }
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

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvOK6AAoJEGw4ysog2bOSJj8P/jW+c7cF2v+rcEBiGgr9mGAG
aTA0b01oQ36j00NvZM3JYDiYzaZ56K7Sxa1v15iZkkEz3BoAoDGNBwhY12e5S/YL
Dw7ptbDD+JKVdwhF0egUE1iw/zzT+8p4CLrDliF3KzCVi8jsWX2BFQtX3mpQpP/B
uNk3xtA9vCR2KN5rvBrWzcuwKIKpokDiQNjU8iJBbdGuhuqzuVGpzKqSH1YUuPRE
RZ8iHJejh8U+IcSp+suqcWqs8r/0w8a3KJFYOhfcT6SQ9k4H5g4c5aQazQbxet/P
zZ7NDgfzAcPK/lPRaGFy+0pit5LR8MnqHq6IaUbuOD8ZpMfEJMqgCaHvFhvHrifb
/Gda9ct+kak98k59Fu2d2JgFNnhlIqijKcygVUIc+xDmrpNw6VCJu8+IOK1khdiy
msv1uDO/d5dXSPEl+qwaiKRdtLUBcs1PUSADr2WPzlA8/cSWALzNFax9f8z7WRnD
anDG6z7iUm1M/gCxjVvRYjv8Esp1lPfDpLnXnXmhePcwjCjDIJORlYnDFOHDDYAm
R4S0VLyPTHvaxt5ztGcZBCEatmwb89HzsASR2JMXLRtFMzknBZRKFswQ+HYLip4w
Q08XGQqHt6ol53nzCWueRrbPWgBs3k6ybHSCJHG+9XAkGONANoovn6uY8amcLnWK
rmdnKcSi1x4Ks3swDjTM
=IOjx
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
