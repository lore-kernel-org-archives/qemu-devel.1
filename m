Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRsoj-0000xy-Rj
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRsog-0004fs-Na
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:55:21 -0500
Date: Wed, 28 Nov 2018 16:54:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128055403.GF2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-22-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="656hIAUFSU7Oh46B"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-22-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 21/36] spapr: extend the sPAPR IRQ
 backend for XICS migration
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


--656hIAUFSU7Oh46B
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:14AM +0100, C=E9dric Le Goater wrote:
> Introduce a new sPAPR IRQ handler to handle resend after migration
> when the machine is using a KVM XICS interrupt controller model.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_irq.h |  2 ++
>  hw/ppc/spapr.c             | 13 +++++--------
>  hw/ppc/spapr_irq.c         | 27 +++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index b299dd794bff..4e36c0984e1a 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -45,6 +45,7 @@ typedef struct sPAPRIrq {
>                          void *fdt, uint32_t phandle);
>      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
>                                 Error **errp);
> +    int (*post_load)(sPAPRMachineState *spapr, int version_id);
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> @@ -55,6 +56,7 @@ void spapr_irq_init(sPAPRMachineState *spapr, int nr_se=
rvers, Error **errp);
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> +int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
> =20
>  /*
>   * XICS legacy routines
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8fbb743769db..f9cf2debff5a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1738,14 +1738,6 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          return err;
>      }
> =20
> -    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
> -        CPUState *cs;
> -        CPU_FOREACH(cs) {
> -            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -            icp_resend(ICP(cpu->intc));
> -        }
> -    }
> -
>      /* In earlier versions, there was no separate qdev for the PAPR
>       * RTC, so the RTC offset was stored directly in sPAPREnvironment.
>       * So when migrating from those versions, poke the incoming offset
> @@ -1766,6 +1758,11 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          }
>      }
> =20
> +    err =3D spapr_irq_post_load(spapr, version_id);
> +    if (err) {
> +        return err;
> +    }
> +
>      return err;
>  }
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index f6e9e44d4cf9..33dd5da7d255 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -203,6 +203,18 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRM=
achineState *spapr,
>      return icp_create(cpu, spapr->icp_type, XICS_FABRIC(spapr), errp);
>  }
> =20
> +static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
> +{
> +    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
> +        CPUState *cs;
> +        CPU_FOREACH(cs) {
> +            PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +            icp_resend(ICP(cpu->intc));
> +        }
> +    }
> +    return 0;
> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -219,6 +231,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_irq_dt_populate_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> +    .post_load   =3D spapr_irq_post_load_xics,
>  };
> =20
>   /*
> @@ -331,6 +344,11 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRM=
achineState *spapr,
>                              XIVE_ROUTER(spapr->xive), errp);
>  }
> =20
> +static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
> +{
> +    return 0;
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -351,6 +369,7 @@ sPAPRIrq spapr_irq_xive =3D {
>      .print_info  =3D spapr_irq_print_info_xive,
>      .dt_populate =3D spapr_irq_dt_populate_xive,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
> +    .post_load   =3D spapr_irq_post_load_xive,
>  };
> =20
>  /*
> @@ -389,6 +408,13 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int ir=
q)
>      return smc->irq->qirq(spapr, irq);
>  }
> =20
> +int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +
> +    return smc->irq->post_load(spapr, version_id);
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> @@ -458,4 +484,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>      .print_info  =3D spapr_irq_print_info_xics,
>      .dt_populate =3D spapr_irq_dt_populate_xics,
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> +    .post_load   =3D spapr_irq_post_load_xics,
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--656hIAUFSU7Oh46B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+LXsACgkQbDjKyiDZ
s5LuJBAA1jp0ATNIZMa4BbTrBJp/Ao6JZyPi6wXx2MVJKamxXevjQKKQblSCK5fg
ARBYtIoIdnXKKbTQe7m64FwMwLc48CTAGuCoHMYyGMYiitegHZHObtyQRWdrnSfk
8efwuH9xBEEmLtzuZTwMOui4rwYNOi1nYO4lg4Ang7qYiP93lHNcb8VHYQONhYEt
+eugSTfSB5QFFJc+5LYtdXYJ8KBk4mwHBjoZYNyXHZ+Ws9DQ8TRNdufU/QenPn1W
25Qq37fi5Rh+YHqYSY05iuctwURhv5HPF/jMiSurwe9fefrB/NLd0TWV2xhgt0Ru
ZOsxBBAUDqPvl4MQU7dcu7/0HQOWcLeUNMs88rYtXkj8//neYoZvrrIMOmuPAoZz
sjQ3mS7A0ThyWJJgK8gXI6IJ2EkW27017b/cX6r/95SoX3PrO8Du2CJH37u+QcK3
kpKATl6nV8z30FV7y8kgj8dwG9Umwlf4IX8BA+dg8V1bCmLdGyPd+0Rjx5KSbJTt
86wdHyWthvOJg8KQvIZJaoG7t2hKqDi5cTmM+MVvTaahR2bAPmhow6hOxbG8HI/R
dFAwKwIWsKogp2Anajuux5AS4S/l9yl2ZWWWIs+itwXUSJLZi9kMFFrYs/FBQRcP
3pBrhN10+refjdPehaSXHJlL3mkmQzChzo3BoXykmj31hgBmbiI=
=UBiL
-----END PGP SIGNATURE-----

--656hIAUFSU7Oh46B--
