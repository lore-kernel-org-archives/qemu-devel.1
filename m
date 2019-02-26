Received: from eggs.gnu.org ([209.51.188.92]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075e-Ec
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFa-0006r8-GM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 11:01:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226000130.GD6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 04/13] spapr/xive: add state
 synchronization with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:13PM +0100, C=E9dric Le Goater wrote:
> This extends the KVM XIVE device backend with 'synchronize_state'
> methods used to retrieve the state from KVM. The HW state of the
> sources, the KVM device and the thread interrupt contexts are
> collected for the monitor usage and also migration.
>=20
> These get operations rely on their KVM counterpart in the host kernel
> which acts as a proxy for OPAL, the host firmware. The set operations
> will be added for migration support later.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr_xive.h |  8 ++++
>  include/hw/ppc/xive.h       |  1 +
>  hw/intc/spapr_xive.c        | 17 ++++---
>  hw/intc/spapr_xive_kvm.c    | 89 +++++++++++++++++++++++++++++++++++++
>  hw/intc/xive.c              | 10 +++++
>  5 files changed, 118 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 749c6cbc2c56..ebd65e7fe36b 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -44,6 +44,13 @@ typedef struct sPAPRXive {
>      void          *tm_mmap;
>  } sPAPRXive;
> =20
> +/*
> + * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
> + * to the controller block id value. It can nevertheless be changed
> + * for testing purpose.
> + */
> +#define SPAPR_XIVE_BLOCK_ID 0x0
> +
>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> @@ -74,5 +81,6 @@ void kvmppc_xive_set_queue_config(sPAPRXive *xive, uint=
8_t end_blk,
>  void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
>                                   uint32_t end_idx, XiveEND *end,
>                                   Error **errp);
> +void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 061d43fea24d..f3766fd881a2 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -431,5 +431,6 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc, i=
nt srcno, Error **errp);
>  void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 3db24391e31c..9f07567f4d78 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -40,13 +40,6 @@
> =20
>  #define SPAPR_XIVE_NVT_BASE 0x400
> =20
> -/*
> - * The sPAPR machine has a unique XIVE IC device. Assign a fixed value
> - * to the controller block id value. It can nevertheless be changed
> - * for testing purpose.
> - */
> -#define SPAPR_XIVE_BLOCK_ID 0x0
> -
>  /*
>   * sPAPR NVT and END indexing helpers
>   */
> @@ -153,6 +146,16 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Moni=
tor *mon)
>      XiveSource *xsrc =3D &xive->source;
>      int i;
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_synchronize_state(xive, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return;
> +        }
> +    }
> +
>      monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n");
> =20
>      for (i =3D 0; i < xive->nr_irqs; i++) {
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 6b50451b4f85..4b1ffb9835f9 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -60,6 +60,57 @@ static void kvm_cpu_enable(CPUState *cs)
>  /*
>   * XIVE Thread Interrupt Management context (KVM)
>   */
> +static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
> +{
> +    uint64_t state[4] =3D { 0 };
> +    int ret;
> +
> +    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
> +    if (ret !=3D 0) {
> +        error_setg_errno(errp, errno,
> +                         "XIVE: could not capture KVM state of CPU %ld",
> +                         kvm_arch_vcpu_id(tctx->cs));
> +        return;
> +    }
> +
> +    /* word0 and word1 of the OS ring. */
> +    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
> +
> +    /*
> +     * KVM also returns word2 containing the OS CAM line which is
> +     * interesting to print out in the QEMU monitor.
> +     */
> +    *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]) =3D state[1];

As mentioned elsewhere, it is interesting for debugging, but doesn't
seem to really match the guest visible CAM state, so I'm not convinced
it's a good idea to put it into the regs[] structure.

> +}
> +
> +typedef struct {
> +    XiveTCTX *tctx;
> +    Error *err;
> +} XiveCpuGetState;
> +
> +static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
> +                                                 run_on_cpu_data arg)
> +{
> +    XiveCpuGetState *s =3D arg.host_ptr;
> +
> +    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
> +}
> +
> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
> +{
> +    XiveCpuGetState s =3D {
> +        .tctx =3D tctx,
> +        .err =3D NULL,
> +    };
> +
> +    run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
> +               RUN_ON_CPU_HOST_PTR(&s));

Why does this need a run_on_cpu() ?  The KVM call which is getting the
actual info takes a cpu parameter.

> +
> +    if (s.err) {
> +        error_propagate(errp, s.err);
> +        return;
> +    }
> +}
> =20
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  {
> @@ -229,6 +280,19 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int sr=
cno, uint32_t offset,
>      }
>  }
> =20
> +static void kvmppc_xive_source_get_state(XiveSource *xsrc)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        /* Perform a load without side effect to retrieve the PQ bits */
> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +
> +        /* and save PQ locally */
> +        xive_source_esb_set(xsrc, i, pq);
> +    }
> +}
> +
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>  {
>      XiveSource *xsrc =3D opaque;
> @@ -340,6 +404,31 @@ void kvmppc_xive_reset(sPAPRXive *xive, Error **errp)
>                        NULL, true, errp);
>  }
> =20
> +static void kvmppc_xive_get_queues(sPAPRXive *xive, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    int i;
> +
> +    for (i =3D 0; i < xive->nr_ends; i++) {
> +        kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> +                                     &xive->endt[i], &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
> +void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
> +{
> +    kvmppc_xive_source_get_state(&xive->source);
> +
> +    /* EAT: there is no extra state to query from KVM */
> +
> +    /* ENDT */
> +    kvmppc_xive_get_queues(xive, errp);
> +}
> +
>  static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>                                Error **errp)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 0284b5803551..f478c52ab2a0 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -431,6 +431,16 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon)
>      int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
>      int i;
> =20
> +    if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
> +        kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return;
> +        }
> +    }
> +
>      monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC A=
GE PIPR"
>                     "  W2\n", cpu_index);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0gdcACgkQbDjKyiDZ
s5KW3Q/+LLP6EvWlVlbt9K4R6C+p1yZ9pYTAqlDxvKN9AIJGsGSt5mt99dCQ1EgS
O4l5tN70AQ+0pgPYZ3plY4FC45jN9OZ9OS8KJzqLNV1sNkWWmVLgF+wLiOnt/qMn
bP/hKFVDE35oufQXQePV+rEor9bzbk0z+lk+9Fit8yNn9fkZrYELoGrIII0NoQZj
F3oCucVvs6x0Gk3QmozYftvl346mHA2NbT9f9EoyNQEk1hdIAtfuxRqrDtADJtu+
/RAC8f/b4jO6Co0xouwgxvlBay6nZxklAK1AHvj9VebaFk2ogiCeu6quKBetHDJ/
P8BI5EvLX3TzjxxImmdESHnCl4n/3D0g7MQmFkk3sRooYDxDUhuFUD40AXnX7TWE
/L6lZ6dEw6i8ofhPtIxI/21AA0XZDxD/yCL8AbpdAIA22rtPiLzYOOTi0sCNSZNH
Jbh6oCa2pTdZ5RBIGPYytRsQZkryI4jU7j9pN+KFmw+8VuNHpGHHHEJGvFlNwEZ3
amgExZJEQ/IVDCPDYDJ3ZXpGxx+YSxfVMP00LwqOiDBRiBtwbeMUTYOWqNRFNC4e
fikEiSde5Pe5jPZSbnCdDRMXdhga9nizlHXdeNiQthBuIBz5s7r8TLaCS+QNd+4C
rlrY9vTCWfw22q7SXyv5GiN9TzFRlSEFxU3CAGeRZssUElOu2GY=
=m2ex
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
