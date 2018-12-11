Received: from eggs.gnu.org ([2001:4830:134:3::10]:49890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXbw-0008Tc-N6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXMw-0003lw-Qk
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:01:57 -0500
Date: Tue, 11 Dec 2018 12:47:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211014737.GE4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sG624X+5B8xHI10M"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-16-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 15/19] spapr/xive: enable XIVE MMIOs at
 reset
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


--sG624X+5B8xHI10M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:46:06PM +0100, C=E9dric Le Goater wrote:
> Depending on the interrupt mode chosen, enable or disable the XIVE
> MMIOs.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_xive.h | 1 +
>  hw/intc/spapr_xive.c        | 9 +++++++++
>  hw/ppc/spapr_irq.c          | 8 ++++++++
>  3 files changed, 18 insertions(+)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7244a6231ce6..308afb61a666 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -48,5 +48,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  void spapr_xive_reset_tctx(sPAPRXive *xive);
> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 560d8d031f74..c6dbb2e8cfc7 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -179,6 +179,15 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
>  }
> =20
> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable)

The logic looks fine, but I dislike this name - it's called
=2E.._enable() when it can also be used to disable.

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
> index b423cee30e2c..a8e50725397c 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -217,6 +217,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
>      CPU_FOREACH(cs) {
>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
>      }
> +
> +    /* Deactivate the XIVE MMIOs */
> +    if (spapr->xive) {
> +        spapr_xive_enable_mmio(spapr->xive, false);
> +    }
>  }
> =20
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> @@ -358,6 +363,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
>       * to come after the XiveTCTX reset handlers.
>       */
>      spapr_xive_reset_tctx(spapr->xive);
> +
> +    /* Activate the XIVE MMIOs */
> +    spapr_xive_enable_mmio(spapr->xive, true);
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sG624X+5B8xHI10M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPFzkACgkQbDjKyiDZ
s5IZqQ/+PDgqqFuxTWksqr/KMkZNsrTSLXwoKnkeLYZZYwzAHR9oa+hDXoBRoyI8
HSsYHJo24ou6w2VK09v6jN+dr1MxgNsGGEHC/fXfg6Fry7MFPyPV1RBcdF2lyiEP
eYRNGpLHqlnXAqQ4rrROgeSi7JdGFRMWyg5IXsj8tGFh6olflLSzvlvdRTQTcqA9
QGrKnPmCdge7lr0pXCeL4tb+B5IlXJ/4YVEW8hNQ79zfbJxZVpN4xxSBNx8fY6s9
/Na8x1Vq3WpWH0YjmuthieOPZXZG24D/psrjNqhZJYOJfCva4norfRuzPxnXJ+L4
wED+6HNCTfResiBEsQ9MmrT8ESuGAAlodR0eOfCuTrlP3WJIUxfpRGKnyoLeR8SK
+BFZd2Vd0YrHpOCzaIUt2ehYd/vPKsfIcn6Rh5nCsyxeU70+hU6v1Umdi51qV5cE
xwL2UGFNggljnYL6dpZPNcat6gbbOSsJZ4DybL1xBRu+lHGJl3Tp8pupfX2xFugS
YWdqE5sfTMlIL7UDtgpCn/guakZmhBo/d9FMf9UGy1go2vYTlD6tzUiig2thvLkp
a02GAM5IqGh+BpywkN/uoEQtKiaV3zZWirjbO6kIWow8xc1roMRJ9uEXSIsfvVOM
FXPtiHviYZW4QdXSkvYcsuMPItIOik4eWLZUvVZtkRLU8rCt7OI=
=7WiE
-----END PGP SIGNATURE-----

--sG624X+5B8xHI10M--
