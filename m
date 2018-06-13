Received: from eggs.gnu.org ([2001:4830:134:3::10]:43858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0Sm-0004W8-G6
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0Sj-0004vE-AK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:45:04 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:34727)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT0Sj-0004tt-1S
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 03:45:01 -0400
Received: from player715.ha.ovh.net (unknown [10.109.120.94])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 507AEB588E
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:44:59 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-4-clg@kaod.org>
	<20180613050028.GV30690@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1c147c27-0e7e-1531-23fe-458e76ff08df@kaod.org>
Date: Wed, 13 Jun 2018 09:44:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180613050028.GV30690@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: introduce a generic IRQ
 frontend to the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 06/13/2018 07:00 AM, David Gibson wrote:
> On Fri, May 18, 2018 at 06:44:04PM +0200, C=E9dric Le Goater wrote:
>> This proposal moves all the related IRQ routines of the sPAPR machine
>> behind a class interface to prepare for future changes in the IRQ
>> controller model. First of which is a reorganization of the IRQ number
>> space layout and a second, coming later, will be to integrate the
>> support for the new POWER9 XIVE IRQ controller.
>>
>> The new interface defines a set of fixed IRQ number ranges, for each
>> IRQ type, in which devices allocate the IRQ numbers they need
>> depending on a unique device index. Here is the layout :
>>
>>     SPAPR_IRQ_IPI        0x0        /*  1 IRQ per CPU      */
>>     SPAPR_IRQ_EPOW       0x1000     /*  1 IRQ per device   */
>>     SPAPR_IRQ_HOTPLUG    0x1001     /*  1 IRQ per device   */
>>     SPAPR_IRQ_VIO        0x1100     /*  1 IRQ per device   */
>>     SPAPR_IRQ_PCI_LSI    0x1200     /*  4 IRQs per device  */
>>     SPAPR_IRQ_PCI_MSI    0x1400     /* 1K IRQs per device  */
>>
>>     The IPI range is reserved for future use when XIVE support
>>     comes in.
>>
>> The routines of this interface encompass the previous needs and the
>> new ones and seem complex but the provided IRQ backend should
>> implement what we have today without any functional changes.
>>
>> Each device model is modified to take the new interface into account
>> using the IRQ range/type definitions and a device index. A part from
>> the VIO devices, lacking an id, the changes are relatively simple.
>=20
> I find your use of "back end" vs. "front end" in this patch and the
> next kind of confusing.

This is the the front end, interface used by the machine and devices :

  int spapr_irq_assign(sPAPRMachineState *spapr, uint32_t range, uint32_t=
 irq,
                       Error **errp);
  int spapr_irq_alloc(sPAPRMachineState *spapr, uint32_t range, uint32_t =
index,
                    Error **errp);
  int spapr_irq_alloc_block(sPAPRMachineState *spapr, uint32_t range,
                          uint32_t index, int num, bool align, Error **er=
rp);
  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num, Error *=
*errp);
  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);

and the backend, which can be different depending on the machine level,=20
old vs. new layout, or on depending on the interrupt controller.

  typedef struct sPAPRIrq {
    uint32_t    nr_irqs;
    const sPAPRPIrqRange *ranges;

    void (*init)(sPAPRMachineState *spapr, Error **errp);
    int (*assign)(sPAPRMachineState *spapr, uint32_t range, uint32_t irq,
                  Error **errp);
    int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t index=
,
                 Error **errp);
    int (*alloc_block)(sPAPRMachineState *spapr, uint32_t range,
                       uint32_t index, int num, bool align, Error **errp)=
;
    void (*free)(sPAPRMachineState *spapr, int irq, int num, Error **errp=
);
    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
    void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
} sPAPRIrq;


>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr.h     |  10 +-
>>  include/hw/ppc/spapr_irq.h |  46 +++++++++
>>  hw/ppc/spapr.c             | 177 +---------------------------------
>>  hw/ppc/spapr_events.c      |   7 +-
>>  hw/ppc/spapr_irq.c         | 233 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/spapr_pci.c         |  21 +++-
>>  hw/ppc/spapr_vio.c         |   5 +-
>>  hw/ppc/Makefile.objs       |   2 +-
>>  8 files changed, 308 insertions(+), 193 deletions(-)
>>  create mode 100644 include/hw/ppc/spapr_irq.h
>>  create mode 100644 hw/ppc/spapr_irq.c
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 2cfdfdd67eaf..4eb212b16a51 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -3,10 +3,10 @@
>> =20
>>  #include "sysemu/dma.h"
>>  #include "hw/boards.h"
>> -#include "hw/ppc/xics.h"
>>  #include "hw/ppc/spapr_drc.h"
>>  #include "hw/mem/pc-dimm.h"
>>  #include "hw/ppc/spapr_ovec.h"
>> +#include "hw/ppc/spapr_irq.h"
>> =20
>>  struct VIOsPAPRBus;
>>  struct sPAPRPHBState;
>> @@ -104,6 +104,7 @@ struct sPAPRMachineClass {
>>                            unsigned n_dma, uint32_t *liobns, Error **e=
rrp);
>>      sPAPRResizeHPT resize_hpt_default;
>>      sPAPRCapabilities default_caps;
>> +    sPAPRIrq *irq;
>>  };
>> =20
>>  /**
>> @@ -773,13 +774,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
>>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
>> =20
>> -int spapr_irq_alloc(sPAPRMachineState *spapr, bool lsi, Error **errp)=
;
>> -int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi=
,
>> -                          bool align, Error **errp);
>> -void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>> -qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>> -
>> -
>>  int spapr_caps_pre_load(void *opaque);
>>  int spapr_caps_pre_save(void *opaque);
>> =20
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> new file mode 100644
>> index 000000000000..caf4c33d4cec
>> --- /dev/null
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -0,0 +1,46 @@
>> +/*
>> + * QEMU PowerPC sPAPR IRQ backend definitions
>> + *
>> + * Copyright (c) 2018, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +#ifndef HW_SPAPR_IRQ_H
>> +#define HW_SPAPR_IRQ_H
>> +
>> +#include "hw/ppc/xics.h"
>> +
>> +/*
>> + * IRQ ranges
>> + */
>> +#define SPAPR_IRQ_IPI        0x0     /* 1 IRQ per CPU */
>> +#define SPAPR_IRQ_EPOW       0x1000  /* 1 IRQ per device */
>> +#define SPAPR_IRQ_HOTPLUG    0x1001  /* 1 IRQ per device */
>> +#define SPAPR_IRQ_VIO        0x1100  /* 1 IRQ per device */
>> +#define SPAPR_IRQ_PCI_LSI    0x1200  /* 4 IRQs per device */
>> +#define SPAPR_IRQ_PCI_MSI    0x1400  /* 1K IRQs per device covered by
>> +                                      * a bitmap allocator */
>=20
> These look like they belong in the next patch with the fixed allocation=
s.

They act as ids also, can  be discussed.

>> +typedef struct sPAPRIrq {
>=20
> Much of this structure doesn't make sense to me.  AIUI, the idea is
> that this method structure will vary with the xics vs. xive backend,
> yes? =20

This is not only XIVE. the static allocation scheme changes all the=20
backend.


> Comments below are based on that assumption.
>
>> +    uint32_t    nr_irqs;
>> +
>> +    void (*init)(sPAPRMachineState *spapr, Error **errp);
>> +    int (*alloc)(sPAPRMachineState *spapr, uint32_t range, uint32_t i=
ndex,
>> +                 Error **errp);
>=20
> 'range' has no place here - working out the indices should be entirely
> on the spapr side, only the final irq number should need to go to the
> backend.

RAnge identifies the device, see above. Maybe badly named. =20

> I'd also prefer to call it "claim" to distinguish it from the existing
> "alloc" function which finds a free irq as well as setting it up for
> our exclusive use.
...

>> +    int (*alloc_block)(sPAPRMachineState *spapr, uint32_t range,
>> +                       uint32_t index, int num, bool align, Error **e=
rrp);
>=20
> There should be no need for this.  We needed an alloc_block routine
> before, because we wanted to ensure that we got a contiguous (and
> maybe aligned) block of irqs.  By the time we go to the backend we
> should already have absolute irq numbers, so we can just claim each of
> them separately.

...

So, David, let's stop wasting our time. please provide what you feel is=20
right and I will build on top of it.=20
=20
For your information, please understand that I generally make sure that=20
a patchset fits older and newer machines, that migration is tested and=20
that the XIVE patchset is resynced. It takes a HUGE amount of time and=20
it's a not a ramdom idea that just looks nice.=20

Thanks,

C.
