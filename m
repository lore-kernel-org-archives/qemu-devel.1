Received: from eggs.gnu.org ([209.51.188.92]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rjf-0000Mr-9K
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Rjd-0001CJ-Qq
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:41:23 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:36305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3Rjd-00019N-HQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:41:21 -0400
Received: from player795.ha.ovh.net (unknown [10.109.160.25])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E33481167AA
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 21:41:17 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-5-clg@kaod.org>
	<20190226000130.GD6872@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c78e45f9-5c5d-b21b-7145-f19b0e941058@kaod.org>
Date: Mon, 11 Mar 2019 21:41:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190226000130.GD6872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 2/26/19 1:01 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:13PM +0100, C=E9dric Le Goater wrote:
>> This extends the KVM XIVE device backend with 'synchronize_state'
>> methods used to retrieve the state from KVM. The HW state of the
>> sources, the KVM device and the thread interrupt contexts are
>> collected for the monitor usage and also migration.
>>
>> These get operations rely on their KVM counterpart in the host kernel
>> which acts as a proxy for OPAL, the host firmware. The set operations
>> will be added for migration support later.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h |  8 ++++
>>  include/hw/ppc/xive.h       |  1 +
>>  hw/intc/spapr_xive.c        | 17 ++++---
>>  hw/intc/spapr_xive_kvm.c    | 89 ++++++++++++++++++++++++++++++++++++=
+
>>  hw/intc/xive.c              | 10 +++++
>>  5 files changed, 118 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 749c6cbc2c56..ebd65e7fe36b 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -44,6 +44,13 @@ typedef struct sPAPRXive {
>>      void          *tm_mmap;
>>  } sPAPRXive;
>> =20
>> +/*
>> + * The sPAPR machine has a unique XIVE IC device. Assign a fixed valu=
e
>> + * to the controller block id value. It can nevertheless be changed
>> + * for testing purpose.
>> + */
>> +#define SPAPR_XIVE_BLOCK_ID 0x0
>> +
>>  bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
>>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
>> @@ -74,5 +81,6 @@ void kvmppc_xive_set_queue_config(sPAPRXive *xive, u=
int8_t end_blk,
>>  void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
>>                                   uint32_t end_idx, XiveEND *end,
>>                                   Error **errp);
>> +void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 061d43fea24d..f3766fd881a2 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -431,5 +431,6 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc=
, int srcno, Error **errp);
>>  void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp);
>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val);
>>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp);
>> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp);
>> =20
>>  #endif /* PPC_XIVE_H */
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 3db24391e31c..9f07567f4d78 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -40,13 +40,6 @@
>> =20
>>  #define SPAPR_XIVE_NVT_BASE 0x400
>> =20
>> -/*
>> - * The sPAPR machine has a unique XIVE IC device. Assign a fixed valu=
e
>> - * to the controller block id value. It can nevertheless be changed
>> - * for testing purpose.
>> - */
>> -#define SPAPR_XIVE_BLOCK_ID 0x0
>> -
>>  /*
>>   * sPAPR NVT and END indexing helpers
>>   */
>> @@ -153,6 +146,16 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, M=
onitor *mon)
>>      XiveSource *xsrc =3D &xive->source;
>>      int i;
>> =20
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_synchronize_state(xive, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return;
>> +        }
>> +    }
>> +
>>      monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n"=
);
>> =20
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 6b50451b4f85..4b1ffb9835f9 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -60,6 +60,57 @@ static void kvm_cpu_enable(CPUState *cs)
>>  /*
>>   * XIVE Thread Interrupt Management context (KVM)
>>   */
>> +static void kvmppc_xive_cpu_get_state(XiveTCTX *tctx, Error **errp)
>> +{
>> +    uint64_t state[4] =3D { 0 };
>> +    int ret;
>> +
>> +    ret =3D kvm_get_one_reg(tctx->cs, KVM_REG_PPC_NVT_STATE, state);
>> +    if (ret !=3D 0) {
>> +        error_setg_errno(errp, errno,
>> +                         "XIVE: could not capture KVM state of CPU %l=
d",
>> +                         kvm_arch_vcpu_id(tctx->cs));
>> +        return;
>> +    }
>> +
>> +    /* word0 and word1 of the OS ring. */
>> +    *((uint64_t *) &tctx->regs[TM_QW1_OS]) =3D state[0];
>> +
>> +    /*
>> +     * KVM also returns word2 containing the OS CAM line which is
>> +     * interesting to print out in the QEMU monitor.
>> +     */
>> +    *((uint64_t *) &tctx->regs[TM_QW1_OS + TM_WORD2]) =3D state[1];
>=20
> As mentioned elsewhere, it is interesting for debugging, but doesn't
> seem to really match the guest visible CAM state,=20

The guest is not allowed to see these registers in the TIMA OS page=20
and we are not violating the XIVE architecture. That is where the=20
CAM value belong in HW. The exact same place. I was even thinking=20
to propagate the POOL value which could be useful for nested.

> so I'm not convinced it's a good idea to put it into the regs[]=20
> structure.

I understand it is problematic in case of a KVM->QEMU migration=20
because we need to force a XiveTCTX reset to update the registers=20
with the QEMU CAM line which has been overridden with the KVM CAM=20
line.=20

Another solution could be to add a 'nvt_base' property to SpaprXive=20
and a KVM control to get its value (xive->vp_base in the KVM XIVE=20
device). It would be migrated and used by the QEMU XIVE device=20
after migration.=20
=20
>> +}
>> +
>> +typedef struct {
>> +    XiveTCTX *tctx;
>> +    Error *err;
>> +} XiveCpuGetState;
>> +
>> +static void kvmppc_xive_cpu_do_synchronize_state(CPUState *cpu,
>> +                                                 run_on_cpu_data arg)
>> +{
>> +    XiveCpuGetState *s =3D arg.host_ptr;
>> +
>> +    kvmppc_xive_cpu_get_state(s->tctx, &s->err);
>> +}
>> +
>> +void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tctx, Error **errp)
>> +{
>> +    XiveCpuGetState s =3D {
>> +        .tctx =3D tctx,
>> +        .err =3D NULL,
>> +    };
>> +
>> +    run_on_cpu(tctx->cs, kvmppc_xive_cpu_do_synchronize_state,
>> +               RUN_ON_CPU_HOST_PTR(&s));
>=20
> Why does this need a run_on_cpu() ?  The KVM call which is getting the
> actual info takes a cpu parameter.

Don't we need to kick the vCPU ?=20

Thanks,

C.=20


>=20
>> +
>> +    if (s.err) {
>> +        error_propagate(errp, s.err);
>> +        return;
>> +    }
>> +}
>> =20
>>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>>  {
>> @@ -229,6 +280,19 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int=
 srcno, uint32_t offset,
>>      }
>>  }
>> =20
>> +static void kvmppc_xive_source_get_state(XiveSource *xsrc)
>> +{
>> +    int i;
>> +
>> +    for (i =3D 0; i < xsrc->nr_irqs; i++) {
>> +        /* Perform a load without side effect to retrieve the PQ bits=
 */
>> +        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
>> +
>> +        /* and save PQ locally */
>> +        xive_source_esb_set(xsrc, i, pq);
>> +    }
>> +}
>> +
>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>>  {
>>      XiveSource *xsrc =3D opaque;
>> @@ -340,6 +404,31 @@ void kvmppc_xive_reset(sPAPRXive *xive, Error **e=
rrp)
>>                        NULL, true, errp);
>>  }
>> =20
>> +static void kvmppc_xive_get_queues(sPAPRXive *xive, Error **errp)
>> +{
>> +    Error *local_err =3D NULL;
>> +    int i;
>> +
>> +    for (i =3D 0; i < xive->nr_ends; i++) {
>> +        kvmppc_xive_get_queue_config(xive, SPAPR_XIVE_BLOCK_ID, i,
>> +                                     &xive->endt[i], &local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>> +void kvmppc_xive_synchronize_state(sPAPRXive *xive, Error **errp)
>> +{
>> +    kvmppc_xive_source_get_state(&xive->source);
>> +
>> +    /* EAT: there is no extra state to query from KVM */
>> +
>> +    /* ENDT */
>> +    kvmppc_xive_get_queues(xive, errp);
>> +}
>> +
>>  static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>>                                Error **errp)
>>  {
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 0284b5803551..f478c52ab2a0 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -431,6 +431,16 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mon=
itor *mon)
>>      int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
>>      int i;
>> =20
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_cpu_synchronize_state(tctx, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return;
>> +        }
>> +    }
>> +
>>      monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# IN=
C AGE PIPR"
>>                     "  W2\n", cpu_index);
>> =20
>=20
