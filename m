Received: from eggs.gnu.org ([209.51.188.92]:60982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grawx-0007Ek-5q
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 23:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grawv-0006Tt-6e
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 23:06:07 -0500
Date: Thu, 7 Feb 2019 14:41:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190207034116.GB518@umbus.fritz.box>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20190107183946.7230-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/13] spapr/xive: add migration support
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:39:38PM +0100, C=E9dric Le Goater wrote:
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

Looks find modulo possible changes in the KVM interface.

> ---
>  include/hw/ppc/spapr_xive.h |   5 +
>  include/hw/ppc/xive.h       |   1 +
>  hw/intc/spapr_xive.c        |  34 +++++++
>  hw/intc/spapr_xive_kvm.c    | 187 +++++++++++++++++++++++++++++++++++-
>  hw/intc/xive.c              |  17 ++++
>  hw/ppc/spapr_irq.c          |   2 +-
>  6 files changed, 244 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 8815ed5aa372..52804516e909 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -46,6 +46,7 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lis=
n, bool lsi);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>  bool spapr_xive_priority_is_reserved(uint8_t priority);
> +int spapr_xive_post_load(sPAPRXive *xive, int version_id);
> =20
>  void spapr_xive_cpu_to_nvt(PowerPCCPU *cpu,
>                             uint8_t *out_nvt_blk, uint32_t *out_nvt_idx);
> @@ -53,6 +54,8 @@ void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t pri=
o,
>                             uint8_t *out_end_blk, uint32_t *out_end_idx);
>  int spapr_xive_target_to_end(uint32_t target, uint8_t prio,
>                               uint8_t *out_end_blk, uint32_t *out_end_idx=
);
> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
> +                             uint32_t *out_server, uint8_t *out_prio);
> =20
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
> @@ -68,5 +71,7 @@ void spapr_xive_map_mmio(sPAPRXive *xive);
>   */
>  void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
> +int kvmppc_xive_pre_save(sPAPRXive *xive);
> +int kvmppc_xive_post_load(sPAPRXive *xive, int version_id);
> =20
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 2e48d75a22e0..8aa314f93ffd 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -443,5 +443,6 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, Error=
 **errp);
>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>  void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
> +void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 50dd66707968..21f3c1ef0901 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -85,6 +85,19 @@ static int spapr_xive_target_to_nvt(uint32_t target,
>   * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
>   * priorities per CPU
>   */
> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
> +                             uint32_t *out_server, uint8_t *out_prio)
> +{
> +    if (out_server) {
> +        *out_server =3D end_idx >> 3;
> +    }
> +
> +    if (out_prio) {
> +        *out_prio =3D end_idx & 0x7;
> +    }
> +    return 0;
> +}
> +
>  void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
>                             uint8_t *out_end_blk, uint32_t *out_end_idx)
>  {
> @@ -438,10 +451,31 @@ static const VMStateDescription vmstate_spapr_xive_=
eas =3D {
>      },
>  };
> =20
> +static int vmstate_spapr_xive_pre_save(void *opaque)
> +{
> +    if (kvmppc_xive_enabled()) {
> +        return kvmppc_xive_pre_save(SPAPR_XIVE(opaque));
> +    }
> +
> +    return 0;
> +}
> +
> +/* Called by the sPAPR machine 'post_load' method */
> +int spapr_xive_post_load(sPAPRXive *xive, int version_id)
> +{
> +    if (kvmppc_xive_enabled()) {
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
> index c7639ffe7758..fe58a9ee32d3 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -60,7 +60,30 @@ static void kvm_cpu_enable(CPUState *cs)
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
> @@ -228,6 +251,58 @@ void kvmppc_xive_source_set_irq(void *opaque, int sr=
cno, int val)
>  /*
>   * sPAPR XIVE interrupt controller (KVM)
>   */
> +static int kvmppc_xive_set_eq_state(sPAPRXive *xive, CPUState *cs, Error=
 **errp)
> +{
> +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
> +    int ret;
> +    int i;
> +
> +    for (i =3D 0; i < XIVE_PRIORITY_MAX + 1; i++) {
> +        Error *local_err =3D NULL;
> +        XiveEND *end;
> +        uint8_t end_blk;
> +        uint32_t end_idx;
> +        struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
> +        uint64_t kvm_eq_idx;
> +
> +        if (spapr_xive_priority_is_reserved(i)) {
> +            continue;
> +        }
> +
> +        spapr_xive_cpu_to_end(POWERPC_CPU(cs), i, &end_blk, &end_idx);
> +
> +        assert(end_idx < xive->nr_ends);
> +        end =3D &xive->endt[end_idx];
> +
> +        if (!xive_end_is_valid(end)) {
> +            continue;
> +        }
> +
> +        /* Build the KVM state from the local END structure */
> +        kvm_eq.flags   =3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
> +        kvm_eq.qsize   =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
> +        kvm_eq.qpage   =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) =
<< 32 |
> +            be32_to_cpu(end->w3);
> +        kvm_eq.qtoggle =3D xive_get_field32(END_W1_GENERATION, end->w1);
> +        kvm_eq.qindex  =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
> +
> +        /* Encode the tuple (server, prio) as a KVM EQ index */
> +        kvm_eq_idx =3D i << KVM_XIVE_EQ_PRIORITY_SHIFT &
> +            KVM_XIVE_EQ_PRIORITY_MASK;
> +        kvm_eq_idx |=3D vcpu_id << KVM_XIVE_EQ_SERVER_SHIFT &
> +            KVM_XIVE_EQ_SERVER_MASK;
> +
> +        ret =3D kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ, kvm_eq_=
idx,
> +                                &kvm_eq, true, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int kvmppc_xive_get_eq_state(sPAPRXive *xive, CPUState *cs, Error=
 **errp)
>  {
>      unsigned long vcpu_id =3D kvm_arch_vcpu_id(cs);
> @@ -298,6 +373,48 @@ static int kvmppc_xive_get_eq_state(sPAPRXive *xive,=
 CPUState *cs, Error **errp)
>      return 0;
>  }
> =20
> +static void kvmppc_xive_set_eas_state(sPAPRXive *xive, Error **errp)
> +{
> +    XiveSource *xsrc =3D &xive->source;
> +    int i;
> +
> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        XiveEAS *eas =3D &xive->eat[i];
> +        uint32_t end_idx;
> +        uint32_t end_blk;
> +        uint32_t eisn;
> +        uint8_t priority;
> +        uint32_t server;
> +        uint64_t kvm_eas;
> +        Error *local_err =3D NULL;
> +
> +        /* No need to set MASKED EAS, this is the default state after re=
set */
> +        if (!xive_eas_is_valid(eas) || xive_eas_is_masked(eas)) {
> +            continue;
> +        }
> +
> +        end_idx =3D xive_get_field64(EAS_END_INDEX, eas->w);
> +        end_blk =3D xive_get_field64(EAS_END_BLOCK, eas->w);
> +        eisn =3D xive_get_field64(EAS_END_DATA, eas->w);
> +
> +        spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
> +
> +        kvm_eas =3D priority << KVM_XIVE_EAS_PRIORITY_SHIFT &
> +            KVM_XIVE_EAS_PRIORITY_MASK;
> +        kvm_eas |=3D server << KVM_XIVE_EAS_SERVER_SHIFT &
> +            KVM_XIVE_EAS_SERVER_MASK;
> +        kvm_eas |=3D ((uint64_t)eisn << KVM_XIVE_EAS_EISN_SHIFT) &
> +            KVM_XIVE_EAS_EISN_MASK;
> +
> +        kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EAS, i, &kvm_eas, t=
rue,
> +                          &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
> +    }
> +}
> +
>  static void kvmppc_xive_get_eas_state(sPAPRXive *xive, Error **errp)
>  {
>      XiveSource *xsrc =3D &xive->source;
> @@ -448,6 +565,74 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>      }
>  }
> =20
> +int kvmppc_xive_pre_save(sPAPRXive *xive)
> +{
> +    Error *local_err =3D NULL;
> +    CPUState *cs;
> +
> +    /* Grab the EAT */
> +    kvmppc_xive_get_eas_state(xive, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return -1;
> +    }
> +
> +    /*
> +     * Grab the ENDT. The EQ index and the toggle bit are what we want
> +     * to capture.
> +     */
> +    CPU_FOREACH(cs) {
> +        kvmppc_xive_get_eq_state(xive, cs, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * The sPAPRXive 'post_load' method is called by the sPAPR machine
> + * 'post_load' method, when all XIVE states have been transferred and
> + * loaded.
> + */
> +int kvmppc_xive_post_load(sPAPRXive *xive, int version_id)
> +{
> +    Error *local_err =3D NULL;
> +    CPUState *cs;
> +
> +    /* Restore the ENDT first. The targetting depends on it. */
> +    CPU_FOREACH(cs) {
> +        kvmppc_xive_set_eq_state(xive, cs, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            return -1;
> +        }
> +    }
> +
> +    /* Restore the EAT */
> +    kvmppc_xive_set_eas_state(xive, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return -1;
> +    }
> +
> +    /* Restore the thread interrupt contexts */
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        kvmppc_xive_cpu_set_state(cpu->tctx, &local_err);
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
>  void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
>  {
>      XiveSource *xsrc =3D &xive->source;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 596c29d8c826..c5c2fbc3f8bc 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -521,10 +521,27 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
rror **errp)
>      qemu_unregister_reset(xive_tctx_reset, dev);
>  }
> =20
> +static int vmstate_xive_tctx_pre_save(void *opaque)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (kvmppc_xive_enabled()) {
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
> index afbdabfa6543..233c97c5ecd9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -363,7 +363,7 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMachi=
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

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxbqNoACgkQbDjKyiDZ
s5LvKBAAs7IK4g3k97IESxfh7viWakKIdo5QSLm/j332geAHwqogl64BJsTwXAjG
r+we1Cr/8+/J1ECKwljLJCeTCvUxSg184owVzYxgDDHa6ryD6i9mc86vB+ufwdxI
ckzK824MtpM4RzTqGO9TJLNF3E9V1RQM74t9J0MqGGbAsHWjvZKL7gqCdE2lxON/
TMuJjGLDb3R50Dpm/oGt6XkLinvt3UPPuZtTNFszmOAL0TQVCrOWphaGgEjfj1/r
sEfpn72A15f6Z13ItpByS8ZQ5QiLZlYNIzirE181N4a36+eoEREFNKmVfPo6usCJ
buAaHylCeRF48rMpAeotnSLmRyf24dP+8Q5MYUPx54k804/ONhUUM8DJez+Re1ny
2UPUVAGGT6EM7mKV81mRNtBe0GAUJr6iiVZ74NI81QORT3VdMp5Qg8ioQT7KLtl8
jqcsmLzgSpY2IWwI5Kef7InHhqMF4n8oieTXdO6KVdmzW2LEzbgHyS4szcNZVCzh
FlOq7hiLlLUkC6MSdLs8CHc4M6SuZ7kjiOe1p+EqS4kTVnBuu1ewr5yDP0BFCis8
T21F5uwvuZtzl8j4Nqwv9eUqsG/9uw+ahneFLjnqdIG+ZVT70nQfOXzZIyYjjM4D
gtX6jq79kWu+xOn8acnAFpFxeA2flOtcrJOgZGQi7YMSl4hvorQ=
=3BS3
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
