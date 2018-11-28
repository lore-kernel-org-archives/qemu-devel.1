Received: from eggs.gnu.org ([2001:4830:134:3::10]:37947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRrgr-0001R7-7H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 23:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRrgq-0006no-3i
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 23:43:09 -0500
Date: Wed, 28 Nov 2018 15:42:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128044257.GC2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-20-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pgNHpQPJFoUYTAIP"
Content-Disposition: inline
In-Reply-To: <20181116105729.23240-20-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 19/36] spapr: add a 'pseries-3.1-xive'
 machine type
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


--pgNHpQPJFoUYTAIP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 11:57:12AM +0100, C=E9dric Le Goater wrote:
> The interrupt mode is statically defined to XIVE only for this machine.
> The guest OS is required to have support for the XIVE exploitation
> mode of the POWER9 interrupt controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_irq.h |  1 +
>  hw/ppc/spapr.c             | 36 +++++++++++++++++++++++++++++++-----
>  hw/ppc/spapr_irq.c         |  3 +++
>  3 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index c3b4c38145eb..b299dd794bff 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -33,6 +33,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>  typedef struct sPAPRIrq {
>      uint32_t    nr_irqs;
>      uint32_t    nr_msis;
> +    uint8_t     ov5;

I'm a bit confused as to what exactly this represents..

>      void (*init)(sPAPRMachineState *spapr, int nr_irqs, int nr_servers,
>                   Error **errp);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ad1692cdcd0f..8fbb743769db 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1097,12 +1097,14 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
r, void *fdt)
>      spapr_dt_rtas_tokens(fdt, rtas);
>  }
> =20
> -/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU feat=
ures
> - * that the guest may request and thus the valid values for bytes 24..26=
 of
> - * option vector 5: */
> -static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
> +/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
> + * and the XIVE features that the guest may request and thus the valid
> + * values for bytes 23..26 of option vector 5: */
> +static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
> +                                          int chosen)
>  {
>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      char val[2 * 4] =3D {
>          23, 0x00, /* Xive mode, filled in below. */
> @@ -1123,7 +1125,11 @@ static void spapr_dt_ov5_platform_support(void *fd=
t, int chosen)
>          } else {
>              val[3] =3D 0x00; /* Hash */
>          }
> +        /* TODO: test KVM support */
> +        val[1] =3D smc->irq->ov5;
>      } else {
> +        val[1] =3D smc->irq->ov5;

=2E.here it seems to be a specific value for this OV5 byte, indicating the
supported intc...

> +
>          /* V3 MMU supports both hash and radix in tcg (with dynamic swit=
ching) */
>          val[3] =3D 0xC0;
>      }
> @@ -1191,7 +1197,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path)=
);
>      }
> =20
> -    spapr_dt_ov5_platform_support(fdt, chosen);
> +    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> =20
>      g_free(stdout_path);
>      g_free(bootlist);
> @@ -2622,6 +2628,11 @@ static void spapr_machine_init(MachineState *machi=
ne)
>      /* advertise support for ibm,dyamic-memory-v2 */
>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> =20
> +    /* advertise XIVE */
> +    if (smc->irq->ov5) {

=2E.but here it seems to be a bool indicating XIVE support specifically.

> +        spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
> +    }
> +
>      /* init CPUs */
>      spapr_init_cpus(spapr);
> =20
> @@ -3971,6 +3982,21 @@ static void spapr_machine_3_1_class_options(Machin=
eClass *mc)
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> =20
> +static void spapr_machine_3_1_xive_instance_options(MachineState *machin=
e)
> +{
> +    spapr_machine_3_1_instance_options(machine);
> +}
> +
> +static void spapr_machine_3_1_xive_class_options(MachineClass *mc)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
> +    spapr_machine_3_1_class_options(mc);
> +    smc->irq =3D &spapr_irq_xive;
> +}
> +
> +DEFINE_SPAPR_MACHINE(3_1_xive, "3.1-xive", false);
> +
>  /*
>   * pseries-3.0
>   */
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 253abc10e780..42e73851b174 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -210,6 +210,7 @@ static Object *spapr_irq_cpu_intc_create_xics(sPAPRMa=
chineState *spapr,
>  sPAPRIrq spapr_irq_xics =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
> +    .ov5         =3D 0x0, /* XICS only */
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,
> @@ -341,6 +342,7 @@ static Object *spapr_irq_cpu_intc_create_xive(sPAPRMa=
chineState *spapr,
>  sPAPRIrq spapr_irq_xive =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
> +    .ov5         =3D 0x40, /* XIVE exploitation mode only */
> =20
>      .init        =3D spapr_irq_init_xive,
>      .claim       =3D spapr_irq_claim_xive,
> @@ -447,6 +449,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
>  sPAPRIrq spapr_irq_xics_legacy =3D {
>      .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>      .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
> +    .ov5         =3D 0x0, /* XICS only */
> =20
>      .init        =3D spapr_irq_init_xics,
>      .claim       =3D spapr_irq_claim_xics,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pgNHpQPJFoUYTAIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+HNEACgkQbDjKyiDZ
s5ITHxAAgO6lcCgPWmIjON55JbojfxdysEttTrdR1lwPPThvfKzbvBgiTbTfnpJA
rUfA+UT6QWxYnOy2A/YwYsnOwLsRcITG2eqnC04CE+e//BRkvqdoART8F1ZMIANO
tV7zW5vjeQiefN3JPFqsAqAVQJvEDhcYFipH82x0AwiSX/kygDxZLFa/O6yq0gOK
gFqySNmFZFUgOHIbq1HDZJ8LUmyQlk1Alwg+NTHpvJx6khYTafiVAbS1XPFjD2AD
4x66vtMlqvdV0gq36sag6FfcWE9k4Ri3mIk2qCmmvm6vD4rM0uuVHHRpf0D+eDLl
ImGX6Y2fdoMMHC6CwPqAc1RASn7i55NQLSGxa4ds0NoMjaf5LCYKmaL7lvMvpesf
EbYt8+13DgXYKCTYjFLxymzGZjmycpyLKX+tnZMoR41oMx8s9nvTY4BJoPfn4yaz
0FLgV+9IxcZ6+2eiiGpMko8mKNPcZ/vJe95iijTGlge7nd/M0Rf61ji9bHkiGh2U
+FulGN33LIuRZlu8mzVhHxWHfLyEAXC9YNT5Cp8BR9TvgMldOJAhw6lBOJsqNFEQ
rBzVR8V2CDGO3dep2ps/Ib4X15Rqu+f7VUT1sEIY8VEtNtWK3Kg+eWCBbC+fkvOT
JbjwjPRH0vOrCVzSR1PHnJ+jhL4gN5T4aG8q/StRIdqzWzdL0oA=
=AKnv
-----END PGP SIGNATURE-----

--pgNHpQPJFoUYTAIP--
