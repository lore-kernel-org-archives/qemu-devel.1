Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4R-0004y5-2g
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gYm4Q-0008U0-0O
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 01:08:03 -0500
Date: Mon, 17 Dec 2018 17:04:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181217060411.GH5597@umbus.fritz.box>
References: <20181211223823.13770-1-clg@kaod.org>
	<20181211223823.13770-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20181211223823.13770-11-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v8 10/12] spapr: enable XIVE MMIOs at reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:38:21PM +0100, C=E9dric Le Goater wrote:
> Depending on the interrupt mode of the machine, enable or disable the
> XIVE MMIOs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v7:
>=20
>  - renamed spapr_xive_enable_mmio() to spapr_xive_mmio_set_enabled()
>=20
>  include/hw/ppc/spapr_xive.h | 1 +
>  hw/intc/spapr_xive.c        | 9 +++++++++
>  hw/ppc/spapr_irq.c          | 8 ++++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 728735dbcfbe..9b49871bdb1a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -48,5 +48,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
> +void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index aaa5865c4080..cd1b2c06f88b 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -179,6 +179,15 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
>  }
> =20
> +void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable)
> +{
> +    memory_region_set_enabled(&xive->source.esb_mmio, enable);
> +    memory_region_set_enabled(&xive->tm_mmio, enable);
> +
> +    /* Disable the END ESBs until a guest OS makes use of them */
> +    memory_region_set_enabled(&xive->end_source.esb_mmio, false);
> +}
> +
>  /*
>   * When a Virtual Processor is scheduled to run on a HW thread, the
>   * hypervisor pushes its identifier in the OS CAM line. Emulate the
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 814500f22d34..b1319905327f 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -216,6 +216,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
>      CPU_FOREACH(cs) {
>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
>      }
> +
> +    /* Deactivate the XIVE MMIOs */
> +    if (spapr->xive) {
> +        spapr_xive_mmio_set_enabled(spapr->xive, false);
> +    }

Rather than having the XICS reset reach across and disable the XIVE
MMIO, I think it would be preferable for the common wrapper to disable
both XICS and XIVE, then have the intc specific hook re-enable the
correct one.

>  }
> =20
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> @@ -341,6 +346,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
>          /* (TCG) Set the OS CAM line of the thread interrupt context. */
>          spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
>      }
> +
> +    /* Activate the XIVE MMIOs */
> +    spapr_xive_mmio_set_enabled(spapr->xive, true);
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwXPFsACgkQbDjKyiDZ
s5LAIhAA536DhAahFXyCzL0oWVYzOuRRjc2x2pNlsOlJsFmHQr7lXxcSjl6Uy2Km
cCB25KWjfKqtus6HAJptmKAG+zJlvLFP0RAf1qED3bs9AHRePWIQfq1bZInz2Dzd
ERBiLmciSbvZlXDF1ZcOrJ9QT01M2N75kJ+dyUV5bcxbKjyodf6QZwbZNevR99j5
GBKRKpn3VABFKTAQhWOPXUuZQMNdP6zukuIYhteablMSThFPGxSy7fjdAbUyuhnE
1JO+TXd4GAsUU1Gu9OARvkMJrlNDd1T81dfCrBv/Ldg0lZz+vzMdzPXp0Hv5zfjX
YB7mfsLpXYr/jVOMMKX4HiAp6vQ7qkzwTQ+67r3B/4u969cSBoCqinGoXM9Ymu8m
vharu9MaCIu5FQWG3vbmlQQG/e/kCPrweDApIigayix2VecScO5ya9T/X74qQHwx
6nNAFP3qKl5NCvK1JTGuXtICEfXE8lkSsGOkPPyzNvFj8Q+gWqFPtrVP+c3+F8gZ
lgz/kjvzg0XFpY+7P4/M6mJ7pV3kg7TzNKX4W0s2vpD8vb77ce2WOKvkTV6/eeK1
5rf6t8prcmCrR3feD0pF01FR2meijQ121skJk2/rVphryDxSbVmQxDpxcd+OjEbh
a3ePCeptN0jTP7BbUzWyGISz8CVqCsr13CdMbU5LraJJ3+fIViI=
=7qz/
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
