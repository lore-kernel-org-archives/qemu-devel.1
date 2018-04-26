Received: from eggs.gnu.org ([2001:4830:134:3::10]:35245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBkUf-0005nS-QX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBkUb-00040D-Kf
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:41 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:37208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBkUb-0003zS-5J
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 13:15:37 -0400
Received: from player697.ha.ovh.net (unknown [10.109.120.3])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id ACD87AF71D
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 19:15:35 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
Date: Thu, 26 Apr 2018 19:15:29 +0200
MIME-Version: 1.0
In-Reply-To: <9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
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

On 04/26/2018 11:27 AM, C=E9dric Le Goater wrote:
> On 04/26/2018 09:11 AM, David Gibson wrote:
>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
>>> The XIVE presenter engine uses a set of registers to handle priority
>>> management and interrupt acknowledgment among other things. The most
>>> important ones being :
>>>
>>>   - Interrupt Priority Register (PIPR)
>>>   - Interrupt Pending Buffer (IPB)
>>>   - Current Processor Priority (CPPR)
>>>   - Notification Source Register (NSR)
>>>
>>> There is one set of registers per level of privilege, four in all :
>>> HW, HV pool, OS and User. These are called rings. All registers are
>>> accessible through a specific MMIO region called the Thread Interrupt
>>> Management Areas (TIMA) but, depending on the privilege level of the
>>> CPU, the view of the TIMA is filtered. The sPAPR machine runs at the
>>> OS privilege and therefore can only accesses the OS and the User
>>> rings. The others are for hypervisor levels.
>>>
>>> The CPU interrupt state is modeled with a XiveNVT object which stores
>>> the values of the different registers. The different TIMA views are
>>> mapped at the same address for each CPU and 'current_cpu' is used to
>>> retrieve the XiveNVT holding the ring registers.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>> ---
>>>
>>>  Changes since v2 :
>>>
>>>  - introduced the XiveFabric interface
>>>
>>>  hw/intc/spapr_xive.c        |  25 ++++
>>>  hw/intc/xive.c              | 279 ++++++++++++++++++++++++++++++++++=
++++++++++
>>>  include/hw/ppc/spapr_xive.h |   5 +
>>>  include/hw/ppc/xive.h       |  31 +++++
>>>  include/hw/ppc/xive_regs.h  |  84 +++++++++++++
>>>  5 files changed, 424 insertions(+)
>>>
>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>> index 90cde8a4082d..f07832bf0a00 100644
>>> --- a/hw/intc/spapr_xive.c
>>> +++ b/hw/intc/spapr_xive.c
>>> @@ -13,6 +13,7 @@
>>>  #include "target/ppc/cpu.h"
>>>  #include "sysemu/cpus.h"
>>>  #include "monitor/monitor.h"
>>> +#include "hw/ppc/spapr.h"
>>>  #include "hw/ppc/spapr_xive.h"
>>>  #include "hw/ppc/xive.h"
>>>  #include "hw/ppc/xive_regs.h"
>>> @@ -95,6 +96,22 @@ static void spapr_xive_realize(DeviceState *dev, E=
rror **errp)
>>> =20
>>>      /* Allocate the Interrupt Virtualization Table */
>>>      xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
>>> +
>>> +    /* The Thread Interrupt Management Area has the same address for
>>> +     * each chip. On sPAPR, we only need to expose the User and OS
>>> +     * level views of the TIMA.
>>> +     */
>>> +    xive->tm_base =3D XIVE_TM_BASE;
>>
>> The constant should probably have PAPR in the name somewhere, since
>> it's just for PAPR machines (same for the ESB mappings, actually).
>=20
> ok.=20
>=20
> I have also made 'tm_base' a property, like 'vc_base' for ESBs, in=20
> case we want to change the value when the guest is instantiated.=20
> I doubt it but this is an address in the global address space, so=20
> letting the machine have control is better I think.=20
> =20
>>
>>> +
>>> +    memory_region_init_io(&xive->tm_mmio_user, OBJECT(xive),
>>> +                          &xive_tm_user_ops, xive, "xive.tima.user",
>>> +                          1ull << TM_SHIFT);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_user);
>>> +
>>> +    memory_region_init_io(&xive->tm_mmio_os, OBJECT(xive),
>>> +                          &xive_tm_os_ops, xive, "xive.tima.os",
>>> +                          1ull << TM_SHIFT);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->tm_mmio_os);
>>>  }
>>> =20
>>>  static XiveIVE *spapr_xive_get_ive(XiveFabric *xf, uint32_t lisn)
>>> @@ -104,6 +121,13 @@ static XiveIVE *spapr_xive_get_ive(XiveFabric *x=
f, uint32_t lisn)
>>>      return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
>>>  }
>>> =20
>>> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t server)
>>> +{
>>> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
>>> +
>>> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
>>> +}
>>
>> So this is a bit of a tangent, but I've been thinking of implementing
>> a scheme where there's an opaque pointer in the cpu structure for the
>> use of the machine.  I'm planning for that to replace the intc pointer
>> (which isn't really used directly by the cpu). That would allow us to
>> have spapr put a structure there and have both xics and xive pointers
>> which could be useful later on.
>=20
> ok. That should simplify the patchset at the end, in which we need to=20
> switch the 'intc' pointer.=20
>=20
>> I think we'd need something similar to correctly handle migration of
>> the VPA state, which is currently horribly broken.
>>
>>> +
>>>  static const VMStateDescription vmstate_spapr_xive_ive =3D {
>>>      .name =3D TYPE_SPAPR_XIVE "/ive",
>>>      .version_id =3D 1,
>>> @@ -143,6 +167,7 @@ static void spapr_xive_class_init(ObjectClass *kl=
ass, void *data)
>>>      dc->vmsd =3D &vmstate_spapr_xive;
>>> =20
>>>      xfc->get_ive =3D spapr_xive_get_ive;
>>> +    xfc->get_nvt =3D spapr_xive_get_nvt;
>>>  }
>>> =20
>>>  static const TypeInfo spapr_xive_info =3D {
>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>> index dccad0318834..5691bb9474e4 100644
>>> --- a/hw/intc/xive.c
>>> +++ b/hw/intc/xive.c
>>> @@ -14,7 +14,278 @@
>>>  #include "sysemu/cpus.h"
>>>  #include "sysemu/dma.h"
>>>  #include "monitor/monitor.h"
>>> +#include "hw/ppc/xics.h" /* for ICP_PROP_CPU */
>>>  #include "hw/ppc/xive.h"
>>> +#include "hw/ppc/xive_regs.h"
>>> +
>>> +/*
>>> + * XIVE Interrupt Presenter
>>> + */
>>> +
>>> +static uint64_t xive_nvt_accept(XiveNVT *nvt)
>>> +{
>>> +    return 0;
>>> +}
>>> +
>>> +static void xive_nvt_set_cppr(XiveNVT *nvt, uint8_t cppr)
>>> +{
>>> +    if (cppr > XIVE_PRIORITY_MAX) {
>>> +        cppr =3D 0xff;
>>> +    }
>>> +
>>> +    nvt->ring_os[TM_CPPR] =3D cppr;
>>
>> Surely this needs to recheck if we should be interrupting the cpu?
>=20
> yes. In patch 9, when we introduce the nvt notify routine.
>=20
>>> +}
>>> +
>>> +/*
>>> + * OS Thread Interrupt Management Area MMIO
>>> + */
>>> +static uint64_t xive_tm_read_special(XiveNVT *nvt, hwaddr offset,
>>> +                                           unsigned size)
>>> +{
>>> +    uint64_t ret =3D -1;
>>> +
>>> +    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
>>> +        ret =3D xive_nvt_accept(nvt);
>>> +    } else {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
>>> +                      HWADDR_PRIx" size %d\n", offset, size);
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +#define TM_RING(offset) ((offset) & 0xf0)
>>> +
>>> +static uint64_t xive_tm_os_read(void *opaque, hwaddr offset,
>>> +                                      unsigned size)
>>> +{
>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>>
>> So, as I said on a previous version of this, we can actually correctly
>> represent different mappings in different cpu spaces, by exploiting
>> cpu->as and not just having them all point to &address_space_memory.
>=20
> Yes, you did and I haven't studied the question yet. For the next versi=
on.
>=20
>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
>>> +    uint64_t ret =3D -1;
>>> +    int i;
>>> +
>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
>>> +        return xive_tm_read_special(nvt, offset, size);
>>> +    }
>>> +
>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid access to non-=
OS ring @%"
>>> +                      HWADDR_PRIx"\n", offset);
>>> +        return ret;
>>
>> Just return -1 would be clearer here;
>=20
> ok.
>=20
>>
>>> +    }
>>> +
>>> +    ret =3D 0;
>>> +    for (i =3D 0; i < size; i++) {
>>> +        ret |=3D (uint64_t) nvt->regs[offset + i] << (8 * (size - i =
- 1));
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +static bool xive_tm_is_readonly(uint8_t offset)
>>> +{
>>> +    return offset !=3D TM_QW1_OS + TM_CPPR;
>>> +}
>>> +
>>> +static void xive_tm_write_special(XiveNVT *nvt, hwaddr offset,
>>> +                                        uint64_t value, unsigned siz=
e)
>>> +{
>>> +    /* TODO: support TM_SPC_SET_OS_PENDING */
>>> +
>>> +    /* TODO: support TM_SPC_ACK_OS_EL */
>>> +}
>>> +
>>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
>>> +                                   uint64_t value, unsigned size)
>>> +{
>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
>>> +    int i;
>>> +
>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
>>> +        xive_tm_write_special(nvt, offset, value, size);
>>> +        return;
>>> +    }
>>> +
>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
>>
>> Why have this if you have separate OS and user regions as you appear
>> to do below?
>=20
> This is another problem we are trying to solve.=20
>=20
> The registers a CPU can access depends on the TIMA view it is using.=20
> The OS TIMA view only sees the OS ring registers. The HV view sees all.=
=20

So, I gave a deeper look at the specs and I understood a little more=20
details of the concepts behind. You need to do frequent round-trips=20
to this document ... =20

These registers are accessible through four aligned pages, each exposing=20
a different view of the registers. First page (page address ending=20
in 0b00) gives access to the entire context and is reserved for the=20
ring 0 security monitor. The second (page address ending in 0b01)=20
is for the hypervisor, ring 1. The third (page address ending in 0b10)=20
is for the operating system, ring 2. The fourth (page address ending=20
in 0b11) is for user level, ring 3.

The sPAPR machine runs at the OS privilege and therefore can only=20
accesses the OS and the User rings, 2 and 3. The others are for
hypervisor levels.

I will try to come with a better implementation of the model and
make sure the ring numbers are respected. I am not sure we should=20
have only one memory region or four distinct ones with their
own ops. There are some differences in the load/store of each view.

C.


>> Or to look at it another way, shouldn't it be possible to make the
>> read/write accessors the same for the OS and user rings?
>=20
> For some parts yes, but the special load/store addresses are different
> for each view, the read-only register also. It seemed easier to duplica=
te.
>=20
> I think the problem will become clearer (or worse) with pnv which uses=20
> the HV mode.
>
>=20
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid access to non-=
OS ring @%"
>>> +                      HWADDR_PRIx"\n", offset);
>>> +        return;
>>> +    }
>>> +
>>> +    switch (size) {
>>> +    case 1:
>>> +        if (offset =3D=3D TM_QW1_OS + TM_CPPR) {
>>> +            xive_nvt_set_cppr(nvt, value & 0xff);
>>> +        }
>>> +        break;
>>> +    case 4:
>>> +    case 8:
>>> +        for (i =3D 0; i < size; i++) {
>>> +            if (!xive_tm_is_readonly(offset + i)) {
>>> +                nvt->regs[offset + i] =3D (value >> (8 * (size - i -=
 1))) & 0xff;
>>> +            }
>>> +        }
>>> +        break;
>>> +    default:
>>> +        g_assert_not_reached();
>>> +    }
>>> +}
>>> +
>>> +const MemoryRegionOps xive_tm_os_ops =3D {
>>> +    .read =3D xive_tm_os_read,
>>> +    .write =3D xive_tm_os_write,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +    .valid =3D {
>>> +        .min_access_size =3D 1,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +    .impl =3D {
>>> +        .min_access_size =3D 1,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +};
>>> +
>>> +/*
>>> + * User Thread Interrupt Management Area MMIO
>>> + */
>>> +
>>> +static uint64_t xive_tm_user_read(void *opaque, hwaddr offset,
>>> +                                        unsigned size)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "XIVE: invalid access to User TIMA @%"
>>> +                  HWADDR_PRIx"\n", offset);
>>> +    return -1;
>>> +}
>>> +
>>> +static void xive_tm_user_write(void *opaque, hwaddr offset,
>>> +                                     uint64_t value, unsigned size)
>>> +{
>>> +    qemu_log_mask(LOG_UNIMP, "XIVE: invalid access to User TIMA @%"
>>> +                  HWADDR_PRIx"\n", offset);
>>> +}
>>> +
>>> +
>>> +const MemoryRegionOps xive_tm_user_ops =3D {
>>> +    .read =3D xive_tm_user_read,
>>> +    .write =3D xive_tm_user_write,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +    .valid =3D {
>>> +        .min_access_size =3D 1,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +    .impl =3D {
>>> +        .min_access_size =3D 1,
>>> +        .max_access_size =3D 8,
>>> +    },
>>> +};
>>> +
>>> +static char *xive_nvt_ring_print(uint8_t *ring)
>>> +{
>>> +    uint32_t w2 =3D be32_to_cpu(*((uint32_t *) &ring[TM_WORD2]));
>>> +
>>> +    return g_strdup_printf("%02x  %02x   %02x  %02x    %02x   "
>>> +                   "%02x  %02x  %02x   %08x",
>>> +                   ring[TM_NSR], ring[TM_CPPR], ring[TM_IPB], ring[T=
M_LSMFB],
>>> +                   ring[TM_ACK_CNT], ring[TM_INC], ring[TM_AGE], rin=
g[TM_PIPR],
>>> +                   w2);
>>> +}
>>> +
>>> +void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon)
>>> +{
>>> +    int cpu_index =3D nvt->cs ? nvt->cs->cpu_index : -1;
>>> +    char *s;
>>> +
>>> +    monitor_printf(mon, "CPU[%04x]: QW    NSR CPPR IPB LSMFB ACK# IN=
C AGE PIPR"
>>> +                   " W2\n", cpu_index);
>>> +
>>> +    s =3D xive_nvt_ring_print(&nvt->regs[TM_QW1_OS]);
>>> +    monitor_printf(mon, "CPU[%04x]: OS    %s\n", cpu_index, s);
>>> +    g_free(s);
>>> +    s =3D xive_nvt_ring_print(&nvt->regs[TM_QW0_USER]);
>>> +    monitor_printf(mon, "CPU[%04x]: USER  %s\n", cpu_index, s);
>>> +    g_free(s);
>>> +}
>>> +
>>> +static void xive_nvt_reset(void *dev)
>>> +{
>>> +    XiveNVT *nvt =3D XIVE_NVT(dev);
>>> +
>>> +    memset(nvt->regs, 0, sizeof(nvt->regs));
>>> +}
>>> +
>>> +static void xive_nvt_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    XiveNVT *nvt =3D XIVE_NVT(dev);
>>> +    PowerPCCPU *cpu;
>>> +    CPUPPCState *env;
>>> +    Object *obj;
>>> +    Error *err =3D NULL;
>>> +
>>> +    obj =3D object_property_get_link(OBJECT(dev), ICP_PROP_CPU, &err=
);
>>
>> Please get rid of the remaining "ICP" naming in the xive code.
>=20
> ok.  I will kill the define.
>=20
>>> +    if (!obj) {
>>> +        error_propagate(errp, err);
>>> +        error_prepend(errp, "required link '" ICP_PROP_CPU "' not fo=
und: ");
>>> +        return;
>>> +    }
>>> +
>>> +    cpu =3D POWERPC_CPU(obj);
>>> +    nvt->cs =3D CPU(obj);
>>> +
>>> +    env =3D &cpu->env;
>>> +    switch (PPC_INPUT(env)) {
>>> +    case PPC_FLAGS_INPUT_POWER7:
>>> +        nvt->output =3D env->irq_inputs[POWER7_INPUT_INT];
>>> +        break;
>>> +
>>> +    default:
>>> +        error_setg(errp, "XIVE interrupt controller does not support=
 "
>>> +                   "this CPU bus model");
>>> +        return;
>>> +    }
>>> +
>>> +    qemu_register_reset(xive_nvt_reset, dev);
>>
>> If this is a sysbus device, which I think it is,=20
>=20
> It is not. The TIMA MMIO region is in the sPAPRXive model but that migh=
t=20
> change if we use cpu->as. I agree it would look better to have a memory
> region per cpu.
>=20
>> you shouldn't need to
>> explicitly register a reset handler.  Instead you can set a device
>> reset handler which will be called with the reset.
>>
>>> +}
>>> +
>>> +static void xive_nvt_unrealize(DeviceState *dev, Error **errp)
>>> +{
>>> +    qemu_unregister_reset(xive_nvt_reset, dev);
>>> +}
>>> +
>>> +static void xive_nvt_init(Object *obj)
>>> +{
>>> +    XiveNVT *nvt =3D XIVE_NVT(obj);
>>> +
>>> +    nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
>>
>> The ring_os field is basically pointless, being just an offset into a
>> structure you already have.  A macro or inline would be a better idea.
>=20
> ok. I liked the idea but I agree it's overkill to have an init routine
> just for this. I will find something.
>=20
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_xive_nvt =3D {
>>> +    .name =3D TYPE_XIVE_NVT,
>>> +    .version_id =3D 1,
>>> +    .minimum_version_id =3D 1,
>>> +    .fields =3D (VMStateField[]) {
>>> +        VMSTATE_BUFFER(regs, XiveNVT),
>>> +        VMSTATE_END_OF_LIST()
>>> +    },
>>> +};
>>> +
>>> +static void xive_nvt_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +
>>> +    dc->realize =3D xive_nvt_realize;
>>> +    dc->unrealize =3D xive_nvt_unrealize;
>>> +    dc->desc =3D "XIVE Interrupt Presenter";
>>> +    dc->vmsd =3D &vmstate_xive_nvt;
>>> +}
>>> +
>>> +static const TypeInfo xive_nvt_info =3D {
>>> +    .name          =3D TYPE_XIVE_NVT,
>>> +    .parent        =3D TYPE_DEVICE,
>>> +    .instance_size =3D sizeof(XiveNVT),
>>> +    .instance_init =3D xive_nvt_init,
>>> +    .class_init    =3D xive_nvt_class_init,
>>> +};
>>> =20
>>>  /*
>>>   * XIVE Fabric
>>> @@ -27,6 +298,13 @@ XiveIVE *xive_fabric_get_ive(XiveFabric *xf, uint=
32_t lisn)
>>>      return xfc->get_ive(xf, lisn);
>>>  }
>>> =20
>>> +XiveNVT *xive_fabric_get_nvt(XiveFabric *xf, uint32_t server)
>>> +{
>>> +    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xf);
>>> +
>>> +    return xfc->get_nvt(xf, server);
>>> +}
>>> +
>>>  static void xive_fabric_route(XiveFabric *xf, int lisn)
>>>  {
>>> =20
>>> @@ -418,6 +696,7 @@ static void xive_register_types(void)
>>>  {
>>>      type_register_static(&xive_source_info);
>>>      type_register_static(&xive_fabric_info);
>>> +    type_register_static(&xive_nvt_info);
>>>  }
>>> =20
>>>  type_init(xive_register_types)
>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.=
h
>>> index 4538c622b60a..25d78eec884d 100644
>>> --- a/include/hw/ppc/spapr_xive.h
>>> +++ b/include/hw/ppc/spapr_xive.h
>>> @@ -25,6 +25,11 @@ typedef struct sPAPRXive {
>>>      /* Routing table */
>>>      XiveIVE      *ivt;
>>>      uint32_t     nr_irqs;
>>> +
>>> +    /* TIMA memory regions */
>>> +    hwaddr       tm_base;
>>> +    MemoryRegion tm_mmio_user;
>>> +    MemoryRegion tm_mmio_os;
>>>  } sPAPRXive;
>>> =20
>>>  bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)=
;
>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>> index 57295715a4a5..1a2da610d91c 100644
>>> --- a/include/hw/ppc/xive.h
>>> +++ b/include/hw/ppc/xive.h
>>> @@ -20,6 +20,7 @@ typedef struct XiveFabric XiveFabric;
>>>   */
>>> =20
>>>  #define XIVE_VC_BASE   0x0006010000000000ull
>>> +#define XIVE_TM_BASE   0x0006030203180000ull
>>> =20
>>>  /*
>>>   * XIVE Interrupt Source
>>> @@ -155,6 +156,34 @@ static inline void xive_source_irq_set(XiveSourc=
e *xsrc, uint32_t srcno,
>>>  }
>>> =20
>>>  /*
>>> + * XIVE Interrupt Presenter
>>> + */
>>> +
>>> +#define TYPE_XIVE_NVT "xive-nvt"
>>> +#define XIVE_NVT(obj) OBJECT_CHECK(XiveNVT, (obj), TYPE_XIVE_NVT)
>>> +
>>> +#define TM_RING_COUNT           4
>>> +#define TM_RING_SIZE            0x10
>>> +
>>> +typedef struct XiveNVT {
>>> +    DeviceState parent_obj;
>>> +
>>> +    CPUState  *cs;
>>> +    qemu_irq  output;
>>> +
>>> +    /* Thread interrupt Management (TM) registers */
>>> +    uint8_t   regs[TM_RING_COUNT * TM_RING_SIZE];
>>> +
>>> +    /* Shortcuts to rings */
>>> +    uint8_t   *ring_os;
>>> +} XiveNVT;
>>> +
>>> +extern const MemoryRegionOps xive_tm_user_ops;
>>> +extern const MemoryRegionOps xive_tm_os_ops;
>>> +
>>> +void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon);
>>> +
>>> +/*
>>>   * XIVE Fabric
>>>   */
>>> =20
>>> @@ -175,8 +204,10 @@ typedef struct XiveFabricClass {
>>>      void (*notify)(XiveFabric *xf, uint32_t lisn);
>>> =20
>>>      XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
>>> +    XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
>>>  } XiveFabricClass;
>>> =20
>>>  XiveIVE *xive_fabric_get_ive(XiveFabric *xf, uint32_t lisn);
>>> +XiveNVT *xive_fabric_get_nvt(XiveFabric *xf, uint32_t server);
>>> =20
>>>  #endif /* PPC_XIVE_H */
>>> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
>>> index 5903f29eb789..f2e2a1ac8f6e 100644
>>> --- a/include/hw/ppc/xive_regs.h
>>> +++ b/include/hw/ppc/xive_regs.h
>>> @@ -10,6 +10,88 @@
>>>  #ifndef _PPC_XIVE_REGS_H
>>>  #define _PPC_XIVE_REGS_H
>>> =20
>>> +#define TM_SHIFT                16
>>> +
>>> +/* TM register offsets */
>>> +#define TM_QW0_USER             0x000 /* All rings */
>>> +#define TM_QW1_OS               0x010 /* Ring 0..2 */
>>> +#define TM_QW2_HV_POOL          0x020 /* Ring 0..1 */
>>> +#define TM_QW3_HV_PHYS          0x030 /* Ring 0..1 */
>>> +
>>> +/* Byte offsets inside a QW             QW0 QW1 QW2 QW3 */
>>> +#define TM_NSR                  0x0  /*  +   +   -   +  */
>>> +#define TM_CPPR                 0x1  /*  -   +   -   +  */
>>> +#define TM_IPB                  0x2  /*  -   +   +   +  */
>>> +#define TM_LSMFB                0x3  /*  -   +   +   +  */
>>> +#define TM_ACK_CNT              0x4  /*  -   +   -   -  */
>>> +#define TM_INC                  0x5  /*  -   +   -   +  */
>>> +#define TM_AGE                  0x6  /*  -   +   -   +  */
>>> +#define TM_PIPR                 0x7  /*  -   +   -   +  */
>>> +
>>> +#define TM_WORD0                0x0
>>> +#define TM_WORD1                0x4
>>> +
>>> +/*
>>> + * QW word 2 contains the valid bit at the top and other fields
>>> + * depending on the QW.
>>> + */
>>> +#define TM_WORD2                0x8
>>> +#define   TM_QW0W2_VU           PPC_BIT32(0)
>>> +#define   TM_QW0W2_LOGIC_SERV   PPC_BITMASK32(1, 31) /* XX 2,31 ? */
>>> +#define   TM_QW1W2_VO           PPC_BIT32(0)
>>> +#define   TM_QW1W2_OS_CAM       PPC_BITMASK32(8, 31)
>>> +#define   TM_QW2W2_VP           PPC_BIT32(0)
>>> +#define   TM_QW2W2_POOL_CAM     PPC_BITMASK32(8, 31)
>>> +#define   TM_QW3W2_VT           PPC_BIT32(0)
>>> +#define   TM_QW3W2_LP           PPC_BIT32(6)
>>> +#define   TM_QW3W2_LE           PPC_BIT32(7)
>>> +#define   TM_QW3W2_T            PPC_BIT32(31)
>>> +
>>> +/*
>>> + * In addition to normal loads to "peek" and writes (only when inval=
id)
>>> + * using 4 and 8 bytes accesses, the above registers support these
>>> + * "special" byte operations:
>>> + *
>>> + *   - Byte load from QW0[NSR] - User level NSR (EBB)
>>> + *   - Byte store to QW0[NSR] - User level NSR (EBB)
>>> + *   - Byte load/store to QW1[CPPR] and QW3[CPPR] - CPPR access
>>> + *   - Byte load from QW3[TM_WORD2] - Read VT||00000||LP||LE on thrd=
 0
>>> + *                                    otherwise VT||0000000
>>> + *   - Byte store to QW3[TM_WORD2] - Set VT bit (and LP/LE if presen=
t)
>>> + *
>>> + * Then we have all these "special" CI ops at these offset that trig=
ger
>>> + * all sorts of side effects:
>>> + */
>>> +#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
>>> +#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg =
*/
>>> +#define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate use=
r context */
>>> +#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate us=
er
>>> +                                         * context */
>>> +#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending=
 bit */
>>> +#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invali=
date OS
>>> +                                         * context to reg */
>>> +#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invali=
date Pool
>>> +                                         * context to reg*/
>>> +#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg =
*/
>>> +#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx=
 to odd
>>> +                                         * line */
>>> +#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even=
 line */
>>> +#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to=
 even
>>> +                                         * line */
>>> +#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even=
 line */
>>> +/* XXX more... */
>>> +
>>> +/* NSR fields for the various QW ack types */
>>> +#define TM_QW0_NSR_EB           PPC_BIT8(0)
>>> +#define TM_QW1_NSR_EO           PPC_BIT8(0)
>>> +#define TM_QW3_NSR_HE           PPC_BITMASK8(0, 1)
>>> +#define  TM_QW3_NSR_HE_NONE     0
>>> +#define  TM_QW3_NSR_HE_POOL     1
>>> +#define  TM_QW3_NSR_HE_PHYS     2
>>> +#define  TM_QW3_NSR_HE_LSI      3
>>> +#define TM_QW3_NSR_I            PPC_BIT8(2)
>>> +#define TM_QW3_NSR_GRP_LVL      PPC_BIT8(3, 7)
>>> +
>>>  /* IVE/EAS
>>>   *
>>>   * One per interrupt source. Targets that interrupt to a given EQ
>>> @@ -30,4 +112,6 @@ typedef struct XiveIVE {
>>>  #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to =
the EQ */
>>>  } XiveIVE;
>>> =20
>>> +#define XIVE_PRIORITY_MAX  7
>>> +
>>>  #endif /* _INTC_XIVE_INTERNAL_H */
>>
>=20
