Received: from eggs.gnu.org ([208.118.235.92]:53855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugM-0003Xn-9g
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geugK-0005ei-Qc
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:32:34 -0500
Date: Thu, 3 Jan 2019 14:57:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103035726.GR10853@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bi+HF1AHjw0mn3zx"
Content-Disposition: inline
In-Reply-To: <20190102055743.5052-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 02/10] ppc/xive: introduce a XiveTCTX
 pointer under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Bi+HF1AHjw0mn3zx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:57:35AM +0100, C=E9dric Le Goater wrote:
> which will be used by the machine only when the XIVE interrupt mode is
> in use.

I don't love the idea of putting a hook this specific into the
PowerPCCPU structure, though it might be the easiest path in the short
term.

A couple of approaches: 1) revisit my changes to allow for a pointer
to machine-defined per-cpu data.  or 2) do we actually need a cpu to
tctx pointer.

Expanding on (2) - here you use the pointer to find the right TIMA
state to access, but that could also be handled by having different
TIMA IO instances and mapping those individually to cpu_as.  On the
interrupt delivery side I think a tctx to cpu link will suffice.  For
sPAPR there might be complications with translating cpu numbers in
hcalls to the right tctx.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  target/ppc/cpu.h        | 2 ++
>  hw/intc/xive.c          | 6 +++---
>  hw/ppc/spapr_cpu_core.c | 7 ++++++-
>  hw/ppc/spapr_irq.c      | 8 ++++----
>  4 files changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d5f99f1fc7b9..c76036985623 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1177,6 +1177,7 @@ do {                                            \
> =20
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> +typedef struct XiveTCTX XiveTCTX;
> =20
>  /**
>   * PowerPCCPU:
> @@ -1196,6 +1197,7 @@ struct PowerPCCPU {
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
> +    XiveTCTX *tctx;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index ea33494338dc..410c53278a11 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -321,7 +321,7 @@ static void xive_tm_write(void *opaque, hwaddr offset,
>                            uint64_t value, unsigned size)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> -    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
> +    XiveTCTX *tctx =3D cpu->tctx;
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -360,7 +360,7 @@ static void xive_tm_write(void *opaque, hwaddr offset,
>  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> -    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
> +    XiveTCTX *tctx =3D cpu->tctx;
>      const XiveTmOp *xto;
> =20
>      /*
> @@ -1186,7 +1186,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
> =20
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
> +        XiveTCTX *tctx =3D cpu->tctx;
>          int ring;
> =20
>          /*
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 2739b2a4b818..1473ef853336 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -194,7 +194,12 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sP=
APRCPUCore *sc)
>          vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
>      }
>      qemu_unregister_reset(spapr_cpu_reset, cpu);
> -    object_unparent(cpu->intc);
> +    if (cpu->intc) {
> +        object_unparent(cpu->intc);
> +    }
> +    if (cpu->tctx) {
> +        object_unparent(OBJECT(cpu->tctx));
> +    }
>      cpu_remove_sync(CPU(cpu));
>      object_unparent(OBJECT(cpu));
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2d2e17b66533..8d028db44ff4 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -305,7 +305,7 @@ static void spapr_irq_print_info_xive(sPAPRMachineSta=
te *spapr,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
> +        xive_tctx_pic_print_info(cpu->tctx, mon);
>      }
> =20
>      spapr_xive_pic_print_info(spapr->xive, mon);
> @@ -323,13 +323,13 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMac=
hineState *spapr,
>          return;
>      }
> =20
> -    cpu->intc =3D obj;
> +    cpu->tctx =3D XIVE_TCTX(obj);
> =20
>      /*
>       * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
>       * don't beneficiate from the reset of the XIVE IRQ backend
>       */
> -    spapr_xive_set_tctx_os_cam(XIVE_TCTX(obj));
> +    spapr_xive_set_tctx_os_cam(cpu->tctx);
>  }
> =20
>  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
> @@ -345,7 +345,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState *s=
papr, Error **errp)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
>          /* (TCG) Set the OS CAM line of the thread interrupt context. */
> -        spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
> +        spapr_xive_set_tctx_os_cam(cpu->tctx);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bi+HF1AHjw0mn3zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtiCMACgkQbDjKyiDZ
s5IQbw//STXxOW+gO6NprpiOOIy7jmfvgHyohJd50+A9+9I4eZ2jN1BWdIo9gcJG
i+85TLWlce7+klZA1xr30IfRmB+D4qFDQSjRJMI+chwndwKB72ymPnA+/JrgvjUl
f4zeCFqEd21JjiA3F/k/cxgdNIuNQnPL1cg+DxMXy7vIjnT6yie4OgvW2x1OZJrN
+TucerFE3LBPpfFHTJZNtW2VIwoWu/itrMRIt1QVBAlmHiQC5KmM+NmkcbC6LSeG
gXRxS1CbtogwWGQ07blXM4hObJG6/lNx8LRQWXOLsC1SEkpak0TVXMcJpADWxu/c
cB1+15uugEtpy4RD3hli+GIDo4Es9BI+hsJrGJuf/WzsTB/73tz8+xfw+8Qq/rtg
vRRjZY+5h0oPhkGrz8Cfm66Jli5787VK/PzDWBaeyhJaftknJAO6lG5sP2rowbss
jQfzhjbTGiUgYi5QMOO3NOC3R1ZsghlFWc2nSY/jt12Z3/pZ5Amz71p9cR28KovW
uAi2bLL0rU0indYgCIUwcDUtEYhFFKdNjFUOtf4613sfzmUxBcP2GPsG4tNu/lX+
ZTPNtxq3oTjI+ESK2xAv+spwfOrXZ6wz9GBnPau90BF6i3LKacb0M+Jd03+RXwIS
bjIorUeqYCpjkq+2oDnArqpNs5OpqqEU6oxJ5RnmSgIMat1bhk4=
=Wtwp
-----END PGP SIGNATURE-----

--Bi+HF1AHjw0mn3zx--
