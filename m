Received: from eggs.gnu.org ([209.51.188.92]:40654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Ot0-00081i-Va
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Oma-0004O8-W3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:32:14 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:44937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3Oma-0004NT-LX
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:32:12 -0400
Received: from player795.ha.ovh.net (unknown [10.109.143.209])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 41A021B7389
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:32:10 +0100 (CET)
References: <20190222131322.26079-1-clg@kaod.org>
	<20190222131322.26079-3-clg@kaod.org>
	<20190225232216.GA6872@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <73d44677-2c1f-26bc-73eb-924aacceb534@kaod.org>
Date: Mon, 11 Mar 2019 18:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190225232216.GA6872@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/13] spapr/xive: add hcall support
 when under KVM
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

On 2/26/19 12:22 AM, David Gibson wrote:
> On Fri, Feb 22, 2019 at 02:13:11PM +0100, C=E9dric Le Goater wrote:
>> XIVE hcalls are all redirected to QEMU as none are on a fast path.
>> When necessary, QEMU invokes KVM through specific ioctls to perform
>> host operations. QEMU should have done the necessary checks before
>> calling KVM and, in case of failure, H_HARDWARE is simply returned.
>>
>> H_INT_ESB is a special case that could have been handled under KVM
>> but the impact on performance was low when under QEMU. Here are some
>> figures :
>>
>>     kernel irqchip      OFF          ON
>>     H_INT_ESB                    KVM   QEMU
>>
>>     rtl8139 (LSI )      1.19     1.24  1.23  Gbits/sec
>>     virtio             31.80    42.30   --   Gbits/sec
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h |  15 +++
>>  hw/intc/spapr_xive.c        |  87 +++++++++++++++--
>>  hw/intc/spapr_xive_kvm.c    | 184 +++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 278 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index ab6732b14a02..749c6cbc2c56 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -55,9 +55,24 @@ void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
>>  void spapr_xive_map_mmio(sPAPRXive *xive);
>> =20
>> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>> +                             uint32_t *out_server, uint8_t *out_prio)=
;
>> +
>>  /*
>>   * KVM XIVE device helpers
>>   */
>>  void kvmppc_xive_connect(sPAPRXive *xive, Error **errp);
>> +void kvmppc_xive_reset(sPAPRXive *xive, Error **errp);
>> +void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, Xi=
veEAS *eas,
>> +                                   Error **errp);
>> +void kvmppc_xive_sync_source(sPAPRXive *xive, uint32_t lisn, Error **=
errp);
>> +uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t off=
set,
>> +                            uint64_t data, bool write);
>> +void kvmppc_xive_set_queue_config(sPAPRXive *xive, uint8_t end_blk,
>> +                                 uint32_t end_idx, XiveEND *end,
>> +                                 Error **errp);
>> +void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
>> +                                 uint32_t end_idx, XiveEND *end,
>> +                                 Error **errp);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index c24d649e3668..3db24391e31c 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -86,6 +86,19 @@ static int spapr_xive_target_to_nvt(uint32_t target=
,
>>   * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
>>   * priorities per CPU
>>   */
>> +int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>> +                             uint32_t *out_server, uint8_t *out_prio)
>> +{
>=20
> Since you don't support irq blocks as yet, should this error out
> rather than ignoring if end_blk !=3D 0?

yes we could. I will add a test against SPAPR_XIVE_BLOCK which is the val=
ue=20
of the sPAPR block ID. I would like to be able to track where it is used=20
even if constant. =20

>=20
>> +    if (out_server) {
>> +        *out_server =3D end_idx >> 3;
>> +    }
>> +
>> +    if (out_prio) {
>> +        *out_prio =3D end_idx & 0x7;
>> +    }
>> +    return 0;
>> +}
>> +
>>  static void spapr_xive_cpu_to_end(PowerPCCPU *cpu, uint8_t prio,
>>                                    uint8_t *out_end_blk, uint32_t *out=
_end_idx)
>>  {
>> @@ -792,6 +805,16 @@ static target_ulong h_int_set_source_config(Power=
PCCPU *cpu,
>>          new_eas.w =3D xive_set_field64(EAS_END_DATA, new_eas.w, eisn)=
;
>>      }
>> =20
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_set_source_config(xive, lisn, &new_eas, &local_er=
r);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +    }
>> +
>>  out:
>>      xive->eat[lisn] =3D new_eas;
>>      return H_SUCCESS;
>> @@ -1097,6 +1120,16 @@ static target_ulong h_int_set_queue_config(Powe=
rPCCPU *cpu,
>>       */
>> =20
>>  out:
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_set_queue_config(xive, end_blk, end_idx, &end, &l=
ocal_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +    }
>> +
>>      /* Update END */
>>      memcpy(&xive->endt[end_idx], &end, sizeof(XiveEND));
>>      return H_SUCCESS;
>> @@ -1189,6 +1222,16 @@ static target_ulong h_int_get_queue_config(Powe=
rPCCPU *cpu,
>>          args[2] =3D 0;
>>      }
>> =20
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_get_queue_config(xive, end_blk, end_idx, end, &lo=
cal_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +    }
>> +
>>      /* TODO: do we need any locking on the END ? */
>>      if (flags & SPAPR_XIVE_END_DEBUG) {
>>          /* Load the event queue generation number into the return fla=
gs */
>> @@ -1341,15 +1384,20 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>>          return H_P3;
>>      }
>> =20
>> -    mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) + =
offset;
>> +    if (kvm_irqchip_in_kernel()) {
>> +        args[0] =3D kvmppc_xive_esb_rw(xsrc, lisn, offset, data,
>> +                                     flags & SPAPR_XIVE_ESB_STORE);
>> +    } else {
>> +        mmio_addr =3D xive->vc_base + xive_source_esb_mgmt(xsrc, lisn=
) + offset;
>> =20
>> -    if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
>> -                      (flags & SPAPR_XIVE_ESB_STORE))) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0=
x%"
>> -                      HWADDR_PRIx "\n", mmio_addr);
>> -        return H_HARDWARE;
>> +        if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
>> +                          (flags & SPAPR_XIVE_ESB_STORE))) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ES=
B @0x%"
>> +                          HWADDR_PRIx "\n", mmio_addr);
>> +            return H_HARDWARE;
>> +        }
>> +        args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
>>      }
>> -    args[0] =3D (flags & SPAPR_XIVE_ESB_STORE) ? -1 : data;
>>      return H_SUCCESS;
>>  }
>> =20
>> @@ -1406,7 +1454,20 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
>>       * This is not needed when running the emulation under QEMU
>>       */
>> =20
>> -    /* This is not real hardware. Nothing to be done */
>> +    /*
>> +     * This is not real hardware. Nothing to be done unless when
>> +     * under KVM
>> +     */
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_sync_source(xive, lisn, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +    }
>>      return H_SUCCESS;
>>  }
>> =20
>> @@ -1441,6 +1502,16 @@ static target_ulong h_int_reset(PowerPCCPU *cpu=
,
>>      }
>> =20
>>      device_reset(DEVICE(xive));
>> +
>> +    if (kvm_irqchip_in_kernel()) {
>> +        Error *local_err =3D NULL;
>> +
>> +        kvmppc_xive_reset(xive, &local_err);
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +            return H_HARDWARE;
>> +        }
>> +    }
>>      return H_SUCCESS;
>>  }
>> =20
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index 623fbf74f23e..6b50451b4f85 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -89,6 +89,52 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error =
**errp)
>>   * XIVE Interrupt Source (KVM)
>>   */
>> =20
>> +void kvmppc_xive_set_source_config(sPAPRXive *xive, uint32_t lisn, Xi=
veEAS *eas,
>> +                                   Error **errp)
>> +{
>> +    uint32_t end_idx;
>> +    uint32_t end_blk;
>> +    uint32_t eisn;
>> +    uint8_t priority;
>> +    uint32_t server;
>> +    uint64_t kvm_src;
>> +    Error *local_err =3D NULL;
>> +
>> +    /*
>> +     * No need to set a MASKED source, this is the default state afte=
r
>> +     * reset.
>=20
> I don't quite follow this comment, why is there no need to call a
> MASKED source?

because MASKED is the default state in which KVM initializes the IRQ. I w=
ill
clarify.
=20
>> +     */
>> +    if (!xive_eas_is_valid(eas) || xive_eas_is_masked(eas)) {
>> +        return;
>> +    }
>> +
>> +    end_idx =3D xive_get_field64(EAS_END_INDEX, eas->w);
>> +    end_blk =3D xive_get_field64(EAS_END_BLOCK, eas->w);
>> +    eisn =3D xive_get_field64(EAS_END_DATA, eas->w);
>> +
>> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
>> +
>> +    kvm_src =3D priority << KVM_XIVE_SOURCE_PRIORITY_SHIFT &
>> +        KVM_XIVE_SOURCE_PRIORITY_MASK;
>> +    kvm_src |=3D server << KVM_XIVE_SOURCE_SERVER_SHIFT &
>> +        KVM_XIVE_SOURCE_SERVER_MASK;
>> +    kvm_src |=3D ((uint64_t)eisn << KVM_XIVE_SOURCE_EISN_SHIFT) &
>> +        KVM_XIVE_SOURCE_EISN_MASK;
>> +
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_CONFIG, lisn,
>> +                      &kvm_src, true, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +}
>> +
>> +void kvmppc_xive_sync_source(sPAPRXive *xive, uint32_t lisn, Error **=
errp)
>> +{
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_SOURCE_SYNC, lisn,
>> +                      NULL, true, errp);
>> +}
>> +
>>  /*
>>   * At reset, the interrupt sources are simply created and MASKED. We
>>   * only need to inform the KVM XIVE device about their type: LSI or
>> @@ -125,6 +171,64 @@ void kvmppc_xive_source_reset(XiveSource *xsrc, E=
rror **errp)
>>      }
>>  }
>> =20
>> +/*
>> + * This is used to perform the magic loads on the ESB pages, describe=
d
>> + * in xive.h.
>> + */
>> +static uint64_t xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t off=
set,
>> +                            uint64_t data, bool write)
>> +{
>> +    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
>> +        xive_source_esb_mgmt(xsrc, srcno) + offset;
>=20
> Casting the esb_mmap into unsigned long then back to a pointer looks
> unnecessary.  You should be able to do this with pointer arithmetic.

yes.

>> +    if (write) {
>> +        *((uint64_t *) addr) =3D data;
>> +        return -1;
>> +    } else {
>> +        return *((uint64_t *) addr);
>> +    }
>=20
> Since this is always dealing with 64-bit values, couldn't you put the
> byteswaps in here rather than in all the callers?

indeed.
=20
>> +}
>> +
>> +static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t of=
fset)
>> +{
>> +    /* Prevent the compiler from optimizing away the load */
>> +    volatile uint64_t value =3D xive_esb_rw(xsrc, srcno, offset, 0, 0=
);
>=20
> Wouldn't the volatile magic be better inside xive_esb_rw()?

sure. I will rework these helpers.=20

>> +    return be64_to_cpu(value) & 0x3;
>> +}
>> +
>> +static void xive_esb_trigger(XiveSource *xsrc, int srcno)
>> +{
>> +    unsigned long addr =3D (unsigned long) xsrc->esb_mmap +
>> +        xive_source_esb_page(xsrc, srcno);
>> +
>> +    *((uint64_t *) addr) =3D 0x0;
>> +}
>=20
> Also.. aren't some of these register accesses likely to need memory
> barriers?

AIUI, these are CI pages. So we shouldn't need barriers.

>> +
>> +uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t off=
set,
>> +                            uint64_t data, bool write)
>> +{
>> +    if (write) {
>> +        return xive_esb_rw(xsrc, srcno, offset, data, 1);
>> +    }
>> +
>> +    /*
>> +     * Special Load EOI handling for LSI sources. Q bit is never set
>> +     * and the interrupt should be re-triggered if the level is still
>> +     * asserted.
>> +     */
>> +    if (xive_source_irq_is_lsi(xsrc, srcno) &&
>> +        offset =3D=3D XIVE_ESB_LOAD_EOI) {
>> +        xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
>> +        if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
>> +            xive_esb_trigger(xsrc, srcno);
>> +        }
>> +        return 0;
>> +    } else {
>> +        return xive_esb_rw(xsrc, srcno, offset, 0, 0);
>> +    }
>> +}
>> +
>>  void kvmppc_xive_source_set_irq(void *opaque, int srcno, int val)
>>  {
>>      XiveSource *xsrc =3D opaque;
>> @@ -155,6 +259,86 @@ void kvmppc_xive_source_set_irq(void *opaque, int=
 srcno, int val)
>>  /*
>>   * sPAPR XIVE interrupt controller (KVM)
>>   */
>> +void kvmppc_xive_get_queue_config(sPAPRXive *xive, uint8_t end_blk,
>> +                                  uint32_t end_idx, XiveEND *end,
>> +                                  Error **errp)
>> +{
>> +    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
>> +    uint64_t kvm_eq_idx;
>> +    uint8_t priority;
>> +    uint32_t server;
>> +    Error *local_err =3D NULL;
>> +
>> +    if (!xive_end_is_valid(end)) {
>=20
> This should set an error, shouldn't it?

Hmm, this helper is used in the hcall h_int_get_queue_config() and, later=
,=20
in kvmppc_xive_get_queues() to synchronize the state from KVM.=20

I should probably move the test outside this routine, return H_HARDWARE
in the hcall and skip invalid ENDs in kvmppc_xive_get_queues()=20

Thanks,

C.


>=20
>> +        return;
>> +    }
>> +
>> +    /* Encode the tuple (server, prio) as a KVM EQ index */
>> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
>> +
>> +    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
>> +            KVM_XIVE_EQ_PRIORITY_MASK;
>> +    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
>> +        KVM_XIVE_EQ_SERVER_MASK;
>> +
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_id=
x,
>> +                      &kvm_eq, false, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * The EQ index and toggle bit are updated by HW. These are the
>> +     * only fields we want to return.
>> +     */
>> +    end->w1 =3D xive_set_field32(END_W1_GENERATION, 0ul, kvm_eq.qtogg=
le) |
>> +        xive_set_field32(END_W1_PAGE_OFF, 0ul, kvm_eq.qindex);
>> +}
>> +
>> +void kvmppc_xive_set_queue_config(sPAPRXive *xive, uint8_t end_blk,
>> +                                  uint32_t end_idx, XiveEND *end,
>> +                                  Error **errp)
>> +{
>> +    struct kvm_ppc_xive_eq kvm_eq =3D { 0 };
>> +    uint64_t kvm_eq_idx;
>> +    uint8_t priority;
>> +    uint32_t server;
>> +    Error *local_err =3D NULL;
>> +
>> +    if (!xive_end_is_valid(end)) {
>> +        return;
>> +    }
>> +
>> +    /* Build the KVM state from the local END structure */
>> +    kvm_eq.flags   =3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
>> +    kvm_eq.qsize   =3D xive_get_field32(END_W0_QSIZE, end->w0) + 12;
>> +    kvm_eq.qpage   =3D (uint64_t) be32_to_cpu(end->w2 & 0x0fffffff) <=
< 32 |
>> +        be32_to_cpu(end->w3);
>> +    kvm_eq.qtoggle =3D xive_get_field32(END_W1_GENERATION, end->w1);
>> +    kvm_eq.qindex  =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>> +
>> +    /* Encode the tuple (server, prio) as a KVM EQ index */
>> +    spapr_xive_end_to_target(end_blk, end_idx, &server, &priority);
>> +
>> +    kvm_eq_idx =3D priority << KVM_XIVE_EQ_PRIORITY_SHIFT &
>> +            KVM_XIVE_EQ_PRIORITY_MASK;
>> +    kvm_eq_idx |=3D server << KVM_XIVE_EQ_SERVER_SHIFT &
>> +        KVM_XIVE_EQ_SERVER_MASK;
>> +
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_EQ_CONFIG, kvm_eq_id=
x,
>> +                      &kvm_eq, true, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +}
>> +
>> +void kvmppc_xive_reset(sPAPRXive *xive, Error **errp)
>> +{
>> +    kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL, KVM_DEV_XIVE_R=
ESET,
>> +                      NULL, true, errp);
>> +}
>> =20
>>  static void *kvmppc_xive_mmap(sPAPRXive *xive, int pgoff, size_t len,
>>                                Error **errp)
>=20
