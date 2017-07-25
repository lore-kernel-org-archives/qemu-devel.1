Received: from eggs.gnu.org ([2001:4830:134:3::10]:59278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da2AN-00079j-9G
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da2AK-0002Os-61
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:54:35 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:55665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1da2AJ-0002Np-SZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:54:32 -0400
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 34F0C591AC
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 17:54:30 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-6-git-send-email-clg@kaod.org>
	<20170719032438.GR3140@umbus.fritz.box>
	<1e07b803-433a-3475-9396-a1f6b82293ff@kaod.org>
	<20170725021648.GB9471@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <53474624-6ca4-526f-0e8f-096c2cadeac3@kaod.org>
Date: Tue, 25 Jul 2017 17:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170725021648.GB9471@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 05/26] ppc/xive: define XIVE internal
 tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 04:16 AM, David Gibson wrote:
> On Mon, Jul 24, 2017 at 02:52:29PM +0200, C=E9dric Le Goater wrote:
>> On 07/19/2017 05:24 AM, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:18PM +0200, C=E9dric Le Goater wrote:
>>>> The XIVE interrupt controller of the POWER9 uses a set of tables to
>>>> redirect exception from event sources to CPU threads. Among which we
>>>> choose to model :
>>>>
>>>>  - the State Bit Entries (SBE), also known as Event State Buffer
>>>>    (ESB). This is a two bit state machine for each event source whic=
h
>>>>    is used to trigger events. The bits are named "P" (pending) and "=
Q"
>>>>    (queued) and can be controlled by MMIO.
>>>>
>>>>  - the Interrupt Virtualization Entry (IVE) table, also known as Eve=
nt
>>>>    Assignment Structure (EAS). This table is indexed by the IRQ numb=
er
>>>>    and is looked up to find the Event Queue associated with a
>>>>    triggered event.
>>>>
>>>>  - the Event Queue Descriptor (EQD) table, also known as Event
>>>>    Notification Descriptor (END). The EQD contains fields that speci=
fy
>>>>    the Event Queue on which event data is posted (and later pulled b=
y
>>>>    the OS) and also a target (or VPD) to notify.
>>>>
>>>> An additional table was not modeled but we might need to to support
>>>> the H_INT_SET_OS_REPORTING_LINE hcall:
>>>>
>>>>  - the Virtual Processor Descriptor (VPD) table, also known as
>>>>    Notification Virtual Target (NVT).
>>>>
>>>> The XIVE object is expanded with the tables described above. The siz=
e
>>>> of each table depends on the number of provisioned IRQ and the maxim=
um
>>>> number of CPUs in the system. The indexing is very basic and might
>>>> need to be improved for the EQs.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/xive-internal.h | 95 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  hw/intc/xive.c          | 72 +++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 167 insertions(+)
>>>>
>>>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
>>>> index 155c2dcd6066..8e755aa88a14 100644
>>>> --- a/hw/intc/xive-internal.h
>>>> +++ b/hw/intc/xive-internal.h
>>>> @@ -11,6 +11,89 @@
>>>> =20
>>>>  #include <hw/sysbus.h>
>>>> =20
>>>> +/* Utilities to manipulate these (originaly from OPAL) */
>>>> +#define MASK_TO_LSH(m)          (__builtin_ffsl(m) - 1)
>>>> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
>>>> +#define SETFIELD(m, v, val)                             \
>>>> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (=
m)))
>>>> +
>>>> +#define PPC_BIT(bit)            (0x8000000000000000UL >> (bit))
>>>> +#define PPC_BIT32(bit)          (0x80000000UL >> (bit))
>>>> +#define PPC_BIT8(bit)           (0x80UL >> (bit))
>>>> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_=
BIT(bs))
>>>> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | =
\
>>>> +                                 PPC_BIT32(bs))
>>>> +
>>>> +/* IVE/EAS
>>>> + *
>>>> + * One per interrupt source. Targets that interrupt to a given EQ
>>>> + * and provides the corresponding logical interrupt number (EQ data=
)
>>>> + *
>>>> + * We also map this structure to the escalation descriptor inside
>>>> + * an EQ, though in that case the valid and masked bits are not use=
d.
>>>> + */
>>>> +typedef struct XiveIVE {
>>>> +        /* Use a single 64-bit definition to make it easier to
>>>> +         * perform atomic updates
>>>> +         */
>>>> +        uint64_t        w;
>>>> +#define IVE_VALID       PPC_BIT(0)
>>>> +#define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ =
block# */
>>>> +#define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ =
index */
>>>> +#define IVE_MASKED      PPC_BIT(32)              /* Masked */
>>>> +#define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to=
 the EQ */
>>>> +} XiveIVE;
>>>> +
>>>> +/* EQ */
>>>> +typedef struct XiveEQ {
>>>> +        uint32_t        w0;
>>>> +#define EQ_W0_VALID             PPC_BIT32(0)
>>>> +#define EQ_W0_ENQUEUE           PPC_BIT32(1)
>>>> +#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2)
>>>> +#define EQ_W0_BACKLOG           PPC_BIT32(3)
>>>> +#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4)
>>>> +#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5)
>>>> +#define EQ_W0_END_OF_INTR       PPC_BIT32(6)
>>>> +#define EQ_W0_QSIZE             PPC_BITMASK32(12, 15)
>>>> +#define EQ_W0_SW0               PPC_BIT32(16)
>>>> +#define EQ_W0_FIRMWARE          EQ_W0_SW0 /* Owned by FW */
>>>> +#define EQ_QSIZE_4K             0
>>>> +#define EQ_QSIZE_64K            4
>>>> +#define EQ_W0_HWDEP             PPC_BITMASK32(24, 31)
>>>> +        uint32_t        w1;
>>>> +#define EQ_W1_ESn               PPC_BITMASK32(0, 1)
>>>> +#define EQ_W1_ESn_P             PPC_BIT32(0)
>>>> +#define EQ_W1_ESn_Q             PPC_BIT32(1)
>>>> +#define EQ_W1_ESe               PPC_BITMASK32(2, 3)
>>>> +#define EQ_W1_ESe_P             PPC_BIT32(2)
>>>> +#define EQ_W1_ESe_Q             PPC_BIT32(3)
>>>> +#define EQ_W1_GENERATION        PPC_BIT32(9)
>>>> +#define EQ_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
>>>> +        uint32_t        w2;
>>>> +#define EQ_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
>>>> +#define EQ_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
>>>> +        uint32_t        w3;
>>>> +#define EQ_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
>>>> +        uint32_t        w4;
>>>> +#define EQ_W4_ESC_EQ_BLOCK      PPC_BITMASK32(4, 7)
>>>> +#define EQ_W4_ESC_EQ_INDEX      PPC_BITMASK32(8, 31)
>>>> +        uint32_t        w5;
>>>> +#define EQ_W5_ESC_EQ_DATA       PPC_BITMASK32(1, 31)
>>>> +        uint32_t        w6;
>>>> +#define EQ_W6_FORMAT_BIT        PPC_BIT32(8)
>>>> +#define EQ_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
>>>> +#define EQ_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
>>>> +        uint32_t        w7;
>>>> +#define EQ_W7_F0_IGNORE         PPC_BIT32(0)
>>>> +#define EQ_W7_F0_BLK_GROUPING   PPC_BIT32(1)
>>>> +#define EQ_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
>>>> +#define EQ_W7_F1_WAKEZ          PPC_BIT32(0)
>>>> +#define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
>>>> +} XiveEQ;
>>>> +
>>>> +#define XIVE_EQ_PRIORITY_COUNT 8
>>>> +#define XIVE_PRIORITY_MAX  (XIVE_EQ_PRIORITY_COUNT - 1)
>>>> +
>>>>  struct XIVE {
>>>>      SysBusDevice parent;
>>>> =20
>>>> @@ -23,6 +106,18 @@ struct XIVE {
>>>>      uint32_t     int_max;       /* Max index */
>>>>      uint32_t     int_hw_bot;    /* Bottom index of HW IRQ allocator=
 */
>>>>      uint32_t     int_ipi_top;   /* Highest IPI index handed out so =
far + 1 */
>>>> +
>>>> +    /* XIVE internal tables */
>>>> +    void         *sbe;
>>>> +    XiveIVE      *ivt;
>>>> +    XiveEQ       *eqdt;
>>>>  };
>>>> =20
>>>> +void xive_reset(void *dev);
>>>> +XiveIVE *xive_get_ive(XIVE *x, uint32_t isn);
>>>> +XiveEQ *xive_get_eq(XIVE *x, uint32_t idx);
>>>> +
>>>> +bool xive_eq_for_target(XIVE *x, uint32_t target, uint8_t prio,
>>>> +                        uint32_t *out_eq_idx);
>>>> +
>>>>  #endif /* _INTC_XIVE_INTERNAL_H */
>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>> index 5b4ea915d87c..5b14d8155317 100644
>>>> --- a/hw/intc/xive.c
>>>> +++ b/hw/intc/xive.c
>>>> @@ -35,6 +35,27 @@
>>>>   */
>>>>  #define MAX_HW_IRQS_ENTRIES (8 * 1024)
>>>> =20
>>>> +
>>>> +void xive_reset(void *dev)
>>>> +{
>>>> +    XIVE *x =3D XIVE(dev);
>>>> +    int i;
>>>> +
>>>> +    /* SBEs are initialized to 0b01 which corresponds to "ints off"=
 */
>>>> +    memset(x->sbe, 0x55, x->int_count / 4);
>>>
>>> I think strictly this should be a DIV_ROUND_UP to handle the case of
>>> int_count not a multiple of 4.
>>
>> ok.=20
>> =20
>>>> +
>>>> +    /* Clear and mask all valid IVEs */
>>>> +    for (i =3D x->int_base; i < x->int_max; i++) {
>>>> +        XiveIVE *ive =3D &x->ivt[i];
>>>> +        if (ive->w & IVE_VALID) {
>>>> +            ive->w =3D IVE_VALID | IVE_MASKED;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    /* clear all EQs */
>>>> +    memset(x->eqdt, 0, x->nr_targets * XIVE_EQ_PRIORITY_COUNT * siz=
eof(XiveEQ));
>>>> +}
>>>> +
>>>>  static void xive_init(Object *obj)
>>>>  {
>>>>      ;
>>>> @@ -62,6 +83,19 @@ static void xive_realize(DeviceState *dev, Error =
**errp)
>>>>      if (x->int_ipi_top < 0x10) {
>>>>          x->int_ipi_top =3D 0x10;
>>>>      }
>>>> +
>>>> +    /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per by=
te */
>>>> +    x->sbe =3D g_malloc0(x->int_count / 4);
>>>
>>> And here as well.
>>
>> yes.
>>
>>>> +
>>>> +    /* Allocate the IVT (Interrupt Virtualization Table) */
>>>> +    x->ivt =3D g_malloc0(x->int_count * sizeof(XiveIVE));
>>>> +
>>>> +    /* Allocate the EQDT (Event Queue Descriptor Table), 8 prioriti=
es
>>>> +     * for each thread in the system */
>>>> +    x->eqdt =3D g_malloc0(x->nr_targets * XIVE_EQ_PRIORITY_COUNT *
>>>> +                        sizeof(XiveEQ));
>>>> +
>>>> +    qemu_register_reset(xive_reset, dev);
>>>>  }
>>>> =20
>>>>  static Property xive_properties[] =3D {
>>>> @@ -92,3 +126,41 @@ static void xive_register_types(void)
>>>>  }
>>>> =20
>>>>  type_init(xive_register_types)
>>>> +
>>>> +XiveIVE *xive_get_ive(XIVE *x, uint32_t lisn)
>>>> +{
>>>> +    uint32_t idx =3D lisn;
>>>> +
>>>> +    if (idx < x->int_base || idx >=3D x->int_max) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    return &x->ivt[idx];
>>>
>>> Should be idx - int_base, no?
>>
>> no, not in the allocator model I have chosen. The IRQ numbers=20
>> are exposed to the guest with their offset. But this is another=20
>> discussion which I would rather continue in another thread.=20
>=20
> Uh.. but you're using idx to index IVT directly, after verifying that
> it lies between int_base and int_max.  AFAICT IVT is only allocated
> with int_max - int_base entries, so without an offset here you'll
> overrun it, won't you?

ah yes, you are right. I got confused because the idx used to be
calculated in a different way. Luckily, 'int_base' is zero for the=20
moment. Anyway I need to rework the allocator and the indexing=20
of these tables, it's too complex for sPAPR.=20

Thanks,

C.=20

>>>> +}
>>>> +
>>>> +XiveEQ *xive_get_eq(XIVE *x, uint32_t idx)
>>>> +{
>>>> +    if (idx >=3D x->nr_targets * XIVE_EQ_PRIORITY_COUNT) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    return &x->eqdt[idx];
>>>> +}
>>>> +
>>>> +/* TODO: improve EQ indexing. This is very simple and relies on the
>>>> + * fact that target (CPU) numbers start at 0 and are contiguous. It
>>>> + * should be OK for sPAPR.
>>>> + */
>>>> +bool xive_eq_for_target(XIVE *x, uint32_t target, uint8_t priority,
>>>> +                        uint32_t *out_eq_idx)
>>>> +{
>>>> +    if (priority > XIVE_PRIORITY_MAX || target >=3D x->nr_targets) =
{
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    if (out_eq_idx) {
>>>> +        *out_eq_idx =3D target + priority;
>>>> +    }
>>>> +
>>>> +    return true;
>>>
>>> Seems a clunky interface.  Why not return a XiveEQ *, NULL if the
>>> inputs aren't valud.
>>
>> Yes. This interface is inherited from OPAL and it's not consistent=20
>> with the other xive_get_*() routines. But we are missing a XIVE=20
>> internal table for VPs which explains the difference. I need to look=20
>> at the support of the OS_REPORTING_LINE hcalls before simplifying.
>>
>> Thanks,
>>
>> C.=20
>>
>>
>=20
