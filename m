Received: from eggs.gnu.org ([2001:4830:134:3::10]:36966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRxa6-0001dh-Bc
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRxZy-0006G4-LB
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:00:34 -0500
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:39323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRxZw-000653-Hd
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:00:26 -0500
Received: from player695.ha.ovh.net (unknown [10.109.160.5])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 55E8C1EB663
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 12:00:14 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
Date: Wed, 28 Nov 2018 11:59:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181127234956.GR2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified
 XIVE presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/28/18 12:49 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:01AM +0100, C=E9dric Le Goater wrote:
>> The last sub-engine of the XIVE architecture is the Interrupt
>> Virtualization Presentation Engine (IVPE). On HW, they share elements,
>> the Power Bus interface (CQ), the routing table descriptors, and they
>> can be combined in the same HW logic. We do the same in QEMU and
>> combine both engines in the XiveRouter for simplicity.
>=20
> Ok, I'm not entirely convinced combining the IVPE and IVRE into a
> single object is a good idea, but we can probably discuss that once
> I've read further.

We could introduce a simplified presenter for sPAPR but I am not even
sure of that as it will get more complex if we support the EBB one day.=20
=20
>> When the IVRE has completed its job of matching an event source with a
>> Notification Virtual Target (NVT) to notify, it forwards the event
>> notification to the IVPE sub-engine. The IVPE scans the thread
>> interrupt contexts of the Notification Virtual Targets (NVT)
>> dispatched on the HW processor threads and if a match is found, it
>> signals the thread. If not, the IVPE escalates the notification to
>> some other targets and records the notification in a backlog queue.
>>
>> The IVPE maintains the thread interrupt context state for each of its
>> NVTs not dispatched on HW processor threads in the Notification
>> Virtual Target table (NVTT).
>>
>> The model currently only supports single NVT notifications.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/xive.h      |  13 +++
>>  include/hw/ppc/xive_regs.h |  22 ++++
>>  hw/intc/xive.c             | 223 ++++++++++++++++++++++++++++++++++++=
+
>>  3 files changed, 258 insertions(+)
>>
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 5987f26ddb98..e715a6c6923d 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -197,6 +197,10 @@ typedef struct XiveRouterClass {
>>                     XiveEND *end);
>>      int (*set_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_id=
x,
>>                     XiveEND *end);
>> +    int (*get_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_id=
x,
>> +                   XiveNVT *nvt);
>> +    int (*set_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_id=
x,
>> +                   XiveNVT *nvt);
>=20
> As with the ENDs, I don't think get/set is a good interface for a
> bigger-than-word-size object.

We need to agree on this interface before I respin. So you would like=20
to add a extra argument specifying the word being accessed ?=20

>=20
>>  } XiveRouterClass;
>> =20
>>  void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mo=
n);
>> @@ -207,6 +211,10 @@ int xive_router_get_end(XiveRouter *xrtr, uint8_t=
 end_blk, uint32_t end_idx,
>>                          XiveEND *end);
>>  int xive_router_set_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t e=
nd_idx,
>>                          XiveEND *end);
>> +int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t n=
vt_idx,
>> +                        XiveNVT *nvt);
>> +int xive_router_set_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t n=
vt_idx,
>> +                        XiveNVT *nvt);
>> =20
>>  /*
>>   * XIVE END ESBs
>> @@ -274,4 +282,9 @@ extern const MemoryRegionOps xive_tm_ops;
>> =20
>>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
>> =20
>> +static inline uint32_t xive_tctx_cam_line(uint8_t nvt_blk, uint32_t n=
vt_idx)
>> +{
>> +    return (nvt_blk << 19) | nvt_idx;
>=20
> I'm guessing this formula is the standard way of combining the NVT
> block and index into a single word? =20

That number is the VP/NVT identifier which is written in the CAM value.=20
The index is on 19 bits because of the NVT  definition in the END=20
structure. It is being increased to 24 bits on Power10=20

> If so, I think we should
> standardize on passing a single word "nvt_id" around and only
> splitting it when we need to use the block separately. =20

This is really the only place where we concatenate the two NVT values,
block and index.=20

> Same goes for
> the end_id, assuming there's a standard way of putting that into a
> single word.  That will address the point I raised earlier about lisn
> being passed around as a single word, but these later stage ids being
> split.

Hmm, I am not sure this is a good option. It is not how the PowerNV=20
model would use it, skiboot is very much aware of these blocks and=20
indexes and for remote accesses chips are identified using the block.=20
I will take a look at it but I am not found of it. I can add helpers=20
in some places though.   =20

I agree we have some kind of issue linking the HW model with the sPAPR=20
machine. The guest interface is only  about IRQ numbers, priorities and
cpu numbers. We really don't care about XIVE blocks and indexes in that=20
case. we can clarify the code by bypassing the XiveRouter interfaces
to the table and directly use the sPAPR interrupt controller. That=20
should help a bit for the hcalls but we would still have to fill in=20
the EAT and the END with some index values if we want to use the router
algorithm.  =20



> We'll probably want some inlines or macros to build an
> nvt/end/lisn/whatever id from block and index as well.
>=20
>> +}
>> +
>>  #endif /* PPC_XIVE_H */
>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>> index 2e3d6cb507da..05cb992d2815 100644
>> --- a/include/hw/ppc/xive_regs.h
>> +++ b/include/hw/ppc/xive_regs.h
>> @@ -158,4 +158,26 @@ typedef struct XiveEND {
>>  #define END_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
>>  } XiveEND;
>> =20
>> +/* Notification Virtual Target (NVT) */
>> +typedef struct XiveNVT {
>> +        uint32_t        w0;
>> +#define NVT_W0_VALID             PPC_BIT32(0)
>> +        uint32_t        w1;
>> +        uint32_t        w2;
>> +        uint32_t        w3;
>> +        uint32_t        w4;
>> +        uint32_t        w5;
>> +        uint32_t        w6;
>> +        uint32_t        w7;
>> +        uint32_t        w8;
>> +#define NVT_W8_GRP_VALID         PPC_BIT32(0)
>> +        uint32_t        w9;
>> +        uint32_t        wa;
>> +        uint32_t        wb;
>> +        uint32_t        wc;
>> +        uint32_t        wd;
>> +        uint32_t        we;
>> +        uint32_t        wf;
>> +} XiveNVT;
>> +
>>  #endif /* PPC_XIVE_REGS_H */
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 4c6cb5d52975..5ba3b06e6e25 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -373,6 +373,32 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Mon=
itor *mon)
>>      }
>>  }
>> =20
>> +/* The HW CAM (23bits) is hardwired to :
>> + *
>> + *   0x000||0b1||4Bit chip number||7Bit Thread number.
>> + *
>> + * and when the block grouping extension is enabled :
>> + *
>> + *   4Bit chip number||0x001||7Bit Thread number.
>> + */
>> +static uint32_t tctx_hw_cam_line(bool block_group, uint8_t chip_id, u=
int8_t tid)
>> +{
>> +    if (block_group) {
>> +        return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
>> +    } else {
>> +        return (chip_id & 0xf) << 11 | 1 << 7 | (tid & 0x7f);
>> +    }
>> +}
>> +
>> +static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx, bool block_grou=
p)
>> +{
>> +    PowerPCCPU *cpu =3D POWERPC_CPU(tctx->cs);
>> +    CPUPPCState *env =3D &cpu->env;
>> +    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
>=20
> I don't much like reaching into the cpu state itself.  I think a
> better idea would be to have the TCTX have its HW CAM id set during
> initialization (via a property) and then use that.  This will mean
> less mucking about if future cpu revisions don't split the PIR into
> chip and tid ids in the same way.

yes good idea. I will see how to handle the block_group boolean. may be w=
e
can leave it out of the model for now as it is not used.=20

>=20
>> +    return tctx_hw_cam_line(block_group, (pir >> 8) & 0xf, pir & 0x7f=
);
>> +}
>> +
>>  static void xive_tctx_reset(void *dev)
>>  {
>>      XiveTCTX *tctx =3D XIVE_TCTX(dev);
>> @@ -1013,6 +1039,195 @@ int xive_router_set_end(XiveRouter *xrtr, uint=
8_t end_blk, uint32_t end_idx,
>>     return xrc->set_end(xrtr, end_blk, end_idx, end);
>>  }
>> =20
>> +int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t n=
vt_idx,
>> +                        XiveNVT *nvt)
>> +{
>> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +   return xrc->get_nvt(xrtr, nvt_blk, nvt_idx, nvt);
>> +}
>> +
>> +int xive_router_set_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t n=
vt_idx,
>> +                        XiveNVT *nvt)
>> +{
>> +   XiveRouterClass *xrc =3D XIVE_ROUTER_GET_CLASS(xrtr);
>> +
>> +   return xrc->set_nvt(xrtr, nvt_blk, nvt_idx, nvt);
>> +}
>> +
>> +static bool xive_tctx_ring_match(XiveTCTX *tctx, uint8_t ring,
>> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                 bool cam_ignore, uint32_t logic_serv=
)
>> +{
>> +    uint8_t *regs =3D &tctx->regs[ring];
>> +    uint32_t w2 =3D be32_to_cpu(*((uint32_t *) &regs[TM_WORD2]));
>> +    uint32_t cam =3D xive_tctx_cam_line(nvt_blk, nvt_idx);
>> +    bool block_group =3D false; /* TODO (PowerNV) */
>> +
>> +    /* TODO (PowerNV): ignore low order bits of nvt id */
>> +
>> +    switch (ring) {
>> +    case TM_QW3_HV_PHYS:
>> +        return (w2 & TM_QW3W2_VT) && xive_tctx_hw_cam_line(tctx, bloc=
k_group) =3D=3D
>> +            tctx_hw_cam_line(block_group, nvt_blk, nvt_idx);
>=20
> The difference between "xive_tctx_hw_cam_line" and "tctx_hw_cam_line"
> here is far from obvious. =20

yes. I lacked inspiration ...

> Remember that namespacing prefixes aren't
> necessary for static functions, which can let you give more
> descriptive names without getting excessively long.

OK.
=20
>> +    case TM_QW2_HV_POOL:
>> +        return (w2 & TM_QW2W2_VP) && (cam =3D=3D GETFIELD(TM_QW2W2_PO=
OL_CAM, w2));
>> +
>> +    case TM_QW1_OS:
>> +        return (w2 & TM_QW1W2_VO) && (cam =3D=3D GETFIELD(TM_QW1W2_OS=
_CAM, w2));
>> +
>> +    case TM_QW0_USER:
>> +        return ((w2 & TM_QW1W2_VO) && (cam =3D=3D GETFIELD(TM_QW1W2_O=
S_CAM, w2)) &&
>> +                (w2 & TM_QW0W2_VU) &&
>> +                (logic_serv =3D=3D GETFIELD(TM_QW0W2_LOGIC_SERV, w2))=
);
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
>> +                                     uint8_t nvt_blk, uint32_t nvt_id=
x,
>> +                                     bool cam_ignore, uint32_t logic_=
serv)
>> +{
>> +    if (format =3D=3D 0) {
>> +        /* F=3D0 & i=3D1: Logical server notification */
>> +        if (cam_ignore =3D=3D true) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no support for LS "
>> +                          "NVT %x/%x\n", nvt_blk, nvt_idx);
>> +             return -1;
>> +        }
>> +
>> +        /* F=3D0 & i=3D0: Specific NVT notification */
>> +        if (xive_tctx_ring_match(tctx, TM_QW3_HV_PHYS,
>> +                                nvt_blk, nvt_idx, false, 0)) {
>> +            return TM_QW3_HV_PHYS;
>> +        }
>> +        if (xive_tctx_ring_match(tctx, TM_QW2_HV_POOL,
>> +                                nvt_blk, nvt_idx, false, 0)) {
>> +            return TM_QW2_HV_POOL;
>> +        }
>> +        if (xive_tctx_ring_match(tctx, TM_QW1_OS,
>> +                                nvt_blk, nvt_idx, false, 0)) {
>> +            return TM_QW1_OS;
>> +        }
>=20
> Hm.  It's a bit pointless to iterate through each ring calling a
> common function, when that "common" function consists entirely of a
> switch which makes it not really common at all.
>=20
> So I think you want separate helper functions for each ring's match,
> or even just fold the previous function into this one.

yes. It can be improved. I did try different layouts. I might just fold=20
both routine in one as you propose. =20

>> +    } else {
>> +        /* F=3D1 : User level Event-Based Branch (EBB) notification *=
/
>> +        if (xive_tctx_ring_match(tctx, TM_QW0_USER,
>> +                                nvt_blk, nvt_idx, false, logic_serv))=
 {
>> +            return TM_QW0_USER;
>> +        }
>> +    }
>> +    return -1;
>> +}
>> +
>> +typedef struct XiveTCTXMatch {
>> +    XiveTCTX *tctx;
>> +    uint8_t ring;
>> +} XiveTCTXMatch;
>> +
>> +static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
>> +                                 uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                 bool cam_ignore, uint8_t priority,
>> +                                 uint32_t logic_serv, XiveTCTXMatch *=
match)
>> +{
>> +    CPUState *cs;
>> +
>> +    /* TODO (PowerNV): handle chip_id overwrite of block field for
>> +     * hardwired CAM compares */
>> +
>> +    CPU_FOREACH(cs) {
>> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> +        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
>> +        int ring;
>> +
>> +        /*
>> +         * HW checks that the CPU is enabled in the Physical Thread
>> +         * Enable Register (PTER).
>> +         */
>> +
>> +        /*
>> +         * Check the thread context CAM lines and record matches. We
>> +         * will handle CPU exception delivery later
>> +         */
>> +        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt=
_idx,
>> +                                         cam_ignore, logic_serv);
>> +        /*
>> +         * Save the context and follow on to catch duplicates, that w=
e
>> +         * don't support yet.
>> +         */
>> +        if (ring !=3D -1) {
>> +            if (match->tctx) {
>> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a=
 thread "
>> +                              "context NVT %x/%x\n", nvt_blk, nvt_idx=
);
>> +                return false;
>> +            }
>> +
>> +            match->ring =3D ring;
>> +            match->tctx =3D tctx;
>> +        }
>> +    }
>> +
>> +    if (!match->tctx) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispat=
ched\n",
>> +                      nvt_blk, nvt_idx);
>> +        return false;
>=20
> Hmm.. this isn't actually an error isn't it? At least not for powernv

It is on sPAPR, it would mean the END was configured with an unknow CPU.=20

It is not error on PowerNV, when we support escalations.

> - that just means the NVT isn't currently dispatched, so we'll need to
> trigger the escalation interrupt. =20

Yes.

> Does this get changed later in the series?

No.

Thanks,

C.

>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +/*
>> + * This is our simple Xive Presenter Engine model. It is merged in th=
e
>> + * Router as it does not require an extra object.
>> + *
>> + * It receives notification requests sent by the IVRE to find one
>> + * matching NVT (or more) dispatched on the processor threads. In cas=
e
>> + * of a single NVT notification, the process is abreviated and the
>> + * thread is signaled if a match is found. In case of a logical serve=
r
>> + * notification (bits ignored at the end of the NVT identifier), the
>> + * IVPE and IVRE select a winning thread using different filters. Thi=
s
>> + * involves 2 or 3 exchanges on the PowerBus that the model does not
>> + * support.
>> + *
>> + * The parameters represent what is sent on the PowerBus
>> + */
>> +static void xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
>> +                                  uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                  bool cam_ignore, uint8_t priority,
>> +                                  uint32_t logic_serv)
>> +{
>> +    XiveNVT nvt;
>> +    XiveTCTXMatch match =3D { 0 };
>> +    bool found;
>> +
>> +    /* NVT cache lookup */
>> +    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
>> +                      nvt_blk, nvt_idx);
>> +        return;
>> +    }
>> +
>> +    if (!(nvt.w0 & NVT_W0_VALID)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is invalid\n"=
,
>> +                      nvt_blk, nvt_idx);
>> +        return;
>> +    }
>> +
>> +    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, ca=
m_ignore,
>> +                                 priority, logic_serv, &match);
>> +    if (found) {
>> +        return;
>> +    }
>> +
>> +    /* If no matching NVT is dispatched on a HW thread :
>> +     * - update the NVT structure if backlog is activated
>> +     * - escalate (ESe PQ bits and EAS in w4-5) if escalation is
>> +     *   activated
>> +     */
>> +}
>> +
>>  /*
>>   * An END trigger can come from an event trigger (IPI or HW) or from
>>   * another chip. We don't model the PowerBus but the END trigger
>> @@ -1081,6 +1296,14 @@ static void xive_router_end_notify(XiveRouter *=
xrtr, uint8_t end_blk,
>>      /*
>>       * Follows IVPE notification
>>       */
>> +    xive_presenter_notify(xrtr, format,
>> +                          GETFIELD(END_W6_NVT_BLOCK, end.w6),
>> +                          GETFIELD(END_W6_NVT_INDEX, end.w6),
>> +                          GETFIELD(END_W7_F0_IGNORE, end.w7),
>> +                          priority,
>> +                          GETFIELD(END_W7_F1_LOG_SERVER_ID, end.w7));
>> +
>> +    /* TODO: Auto EOI. */
>>  }
>> =20
>>  static void xive_router_notify(XiveFabric *xf, uint32_t lisn)
>=20
