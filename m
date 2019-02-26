Received: from eggs.gnu.org ([209.51.188.92]:41576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFc-00075h-Iz
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyTFa-0006rN-Sl
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 22:17:48 -0500
Date: Tue, 26 Feb 2019 11:58:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226005818.GF6872@umbus.fritz.box>
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <20190222131322.26079-7-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/13] spapr/xive: add migration support
 for KVM
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


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:13:15PM +0100, C=E9dric Le Goater wrote:
> When the VM is stopped, the VM state handler stabilizes the XIVE IC
> and marks the EQ pages dirty. These are then transferred to destination
> before the transfer of the device vmstates starts.
>=20
> The sPAPRXive interrupt controller model captures the XIVE internal
> tables, EAT and ENDT and the XiveTCTX model does the same for the
> thread interrupt context registers.
>=20
> At restart, the sPAPRXive 'post_load' method restores all the XIVE
> states. It is called by the sPAPR machine 'post_load' method, when all
> XIVE states have been transferred and loaded.
>=20
> Finally, the source states are restored in the VM change state handler
> when the machine reaches the running state.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr_xive.h |  3 ++
>  include/hw/ppc/xive.h       |  1 +
>  hw/intc/spapr_xive.c        | 24 ++++++++++
>  hw/intc/spapr_xive_kvm.c    | 93 ++++++++++++++++++++++++++++++++++++-
>  hw/intc/xive.c              | 17 +++++++
>  hw/ppc/spapr_irq.c          |  2 +-
>  6 files changed, 138 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 298d204d54ef..22d70650b51f 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -55,6 +55,7 @@ typedef struct sPAPRXive {
>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> +int spapr_xive_post_load(sPAPRXive *xive, int version_id);
> =20
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
> @@ -83,5 +84,7 @@ void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint=
8_t end_blk,
>                                   uint32_t end_idx, XiveEND *end,
>                                   Error **errp);
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
> +int kvmppc_xive_pre_save(sPAPRXive *xive);
> +int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index f3766fd881a2..3b1baa783975 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -432,5 +432,6 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Error=
 **errp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> +void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 9f07567f4d78..21fe5e1aa39f 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -469,10 +469,34 @@ static const VMStateDescription vmstate_spapr_xive_=
eas =3D {
>      },
>  };
> =20
> +static int vmstate_spapr_xive_pre_save(void *opaque)
> +{
> +    if (kvm_irqchip_in_kernel()) {
> +        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * Called by the sPAPR IRQ backend 'post_load' method at the machine
> + * level.
> + */
> +int spapr_xive_post_load(sPAPRXive *xive, int version_id)
> +{
> +    if (kvm_irqchip_in_kernel()) {
> +        return kvmppc_xive_post_load(xive, version_id);
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_spapr_xive =3D {
>      .name =3D TYPE_SPAPR_XIVE,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .pre_save =3D vmstate_spapr_xive_pre_save,
> +    .post_load =3D NULL, /* handled at the machine level */
>      .fields =3D (VMStateField[]) {
>          VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>          VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, sPAPRXive, nr_irqs,
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 44d80175b1b5..119fd59fc9ae 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/cpus.h"
>  #include "sysemu/kvm.h"
>  #include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_cpu_core.h"
>  #include "hw/ppc/spapr_xive.h"
>  #include "hw/ppc/xive.h"
>  #include "kvm_ppc.h"
> @@ -60,7 +61,30 @@ static void kvm_cpu_enable(CPUState *cs)
>  /*
>   * XIVE Thread Interrupt Management context (KVM)
>   */
> -static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
> +
> +static void kvmppc_xive_cpu_set_state(XiveTCTX *tctx, Error **errp)
> +{
> +    uint64_t state[4];
> +    int ret;
> +
> +    /* word0 and word1 of the OS ring. */
> +    state[0] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS]);
> +
> +    /*
> +     * OS CAM line. Used by KVM to print out the VP identifier. This
> +     * is for debug only.
> +     */
> +    state[1] =3D *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]);
> +
> +    ret =3D kvm_set_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
> +    if (ret !=3D 0) {
> +        error_setg_errno(errp, errno,
> +                         "XIVE: could not restore KVM state of CPU %ld",
> +                         kvm_arch_vcpu_id(tctx->cs));
> +    }
> +}
> +
> +void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>  {
>      uint64_t state[4] =3D { 0 };
>      int ret;
> @@ -501,6 +525,73 @@ void kvmppc_xive_synchronize_state(sPAPRXive *xive, =
Error **errp)
>      kvmppc_xive_get_queues(xive, errp);
>  }
> =20
> +/*
> + * The sPAPRXive 'pre_save' method is called by the vmstate handler of
> + * the sPAPRXive model, after the XIVE controller is synced in the VM
> + * change handler.
> + */
> +int kvmppc_xive_pre_save(sPAPRXive *xive)
> +{
> +    Error *local_err =3D NULL;
> +
> +    /* EAT: there is no extra state to query from KVM */
> +
> +    /* ENDT */
> +    kvmppc_xive_get_queues(xive, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * The sPAPRXive 'post_load' method is not called by a vmstate
> + * handler. It is called at the sPAPR machine level at the end of the
> + * migration sequence by the sPAPR IRQ backend 'post_load' method,
> + * when all XIVE states have been transferred and loaded.
> + */
> +int kvmppc_xive_post_load(sPAPRXive *xive, int version_id)
> +{
> +    Error *local_err =3D NULL;
> +    CPUState *cs;
> +    int i;
> +
> +    /* Restore the ENDT first. The targetting depends on it. */
> +    for (i =3D 0; i < xive->nr_ends; i++) {
> +        kvmppc_xive_set_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
> +                                     &xive->endt[i], &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    /* Restore the EAT */
> +    for (i =3D 0; i < xive->nr_irqs; i++) {
> +        kvmppc_xive_set_source_config(xive, i, &xive->eat[i], &local_err=
);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    /* Restore the thread interrupt contexts */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        kvmppc_xive_cpu_set_state(spapr_cpu_state(cpu)->tctx, &local_err=
);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    /* The source states will be restored when the machine starts runnin=
g */
> +    return 0;
> +}
> +
>  static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>                                Error **errp)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f478c52ab2a0..1f8e923ca654 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -518,10 +518,27 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
rror **errp)
>      qemu_unregister_reset(xive_tctx_reset, dev);
>  }
> =20
> +static int vmstate_xive_tctx_pre_save(void *opaque)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (kvm_irqchip_in_kernel()) {
> +        kvmppc_xive_cpu_get_state(XIVE_TCTX(opaque), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_xive_tctx =3D {
>      .name =3D TYPE_XIVE_TCTX,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> +    .pre_save =3D vmstate_xive_tctx_pre_save,
> +    .post_load =3D NULL, /* handled by the sPAPRxive model */
>      .fields =3D (VMStateField[]) {
>          VMSTATE_BUFFER(regs, XiveTCTX),
>          VMSTATE_END_OF_LIST()
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 1ad57582a403..12ecca6264f3 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -356,7 +356,7 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMachi=
neState *spapr,
> =20
>  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
>  {
> -    return 0;
> +    return spapr_xive_post_load(spapr->xive, version_id);
>  }
> =20
>  static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx0jygACgkQbDjKyiDZ
s5JwsxAAxRz0GT7YkGYis+0uSlyjkJuqWj/NPwb1HeoDfTSAccvtifKjrVRBHp0p
GjieQhzU7G9Z4yreXQtyf30QlaViO2G99w0q32N5X+1YwQn8z7vHrqgRnu1yGnwZ
4ZvKZSBn9GwAB3CE2RZ7vIuPDMRxV/Fa0ZI7jWFBleFTAj4b5gljEimlufD9XJAy
+jNfWGz7njtdfnklA2CWu2AgqZaj6hnm15TO9fbREUF3/CqR9Q+UG9S6hNE0abo3
aExxl4XGO1YpzJojJUT0PY8QIB4Heahs0pYIWsPv52y/v5ZW/u0MEVjjnvP97I0V
/IDPGLixnQsa/BYhSSpJfju41aCJC0GUmjQXo5bTPFOPg0TC37sb79pXy5yN7zmI
+BI8gE835kwfh0mH4hKEuio+g/9r86/QY8WhJraIYilaylj7HQO6B8bemz/XDgcz
e27ePr5Un+8TSsP3k3+63o2RTla8Oys7tTC7zwJketAWvahJN7/HgKzGSBO5oEZK
fQ5C3cCxKY/y/L7YB1YdlwiX5QqPsuJ7SNbWgl9pWLbmcvIPQNxQtX+xUEyJqRWg
zinpL+ofgObCgd8BUMNZBRpyJgIPLlBrT81Fr79P0XDnhBgHxqkhJvkRbUeuKy24
eY/9wl+X96Ow0+6NKGvee1BXHWGkT/TkSnbDntV0JYKYpAWO8HY=
=/b+0
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--
