Received: from eggs.gnu.org ([2001:4830:134:3::10]:59635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSP4L-0004gG-Dj
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSP4I-0005r9-4e
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:37 -0500
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSP4H-0005qO-Te
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:21:34 -0500
Received: from player734.ha.ovh.net (unknown [10.109.159.20])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7E1F9DF0CD
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:21:31 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-25-clg@kaod.org>
	<20181129034732.GC14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <57225722-d2a4-f528-3804-d3b4e5014c0d@kaod.org>
Date: Thu, 29 Nov 2018 17:21:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181129034732.GC14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 24/36] spapr: add a 'reset' method to
 the sPAPR IRQ backend
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

On 11/29/18 4:47 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:17AM +0100, C=E9dric Le Goater wrote:
>> This method will become useful when the new machine supporting both
>> interrupt modes, XIVE and XICS, is introduced. In this machine, the
>> interrupt mode is chosen by the CAS negotiation process and activated
>> after a reset.
>>
>> For the time being, the only thing that can be done in the XIVE reset
>> handler is to map the pages for the TIMA and for the source ESBs.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h  |  2 ++
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  hw/intc/spapr_xive.c        |  4 +---
>>  hw/ppc/spapr.c              |  2 ++
>>  hw/ppc/spapr_irq.c          | 21 +++++++++++++++++++++
>>  5 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 4e36c0984e1a..34128976e21c 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -46,6 +46,7 @@ typedef struct sPAPRIrq {
>>      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
>>                                 Error **errp);
>>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
>> +    void (*reset)(sPAPRMachineState *spapr, Error **errp);
>>  } sPAPRIrq;
>> =20
>>  extern sPAPRIrq spapr_irq_xics;
>> @@ -57,6 +58,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int ir=
q, bool lsi, Error **errp);
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
>> =20
>>  /*
>>   * XICS legacy routines
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index d2517c040958..fa7f3d7718da 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -91,6 +91,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>>  void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt,
>>                     uint32_t phandle);
>> +void spapr_xive_mmio_map(sPAPRXive *xive);
>> =20
>>  /*
>>   * XIVE KVM models
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index c5c0e063dc33..def43160e12a 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -51,7 +51,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Moni=
tor *mon)
>>  }
>> =20
>>  /* Map the ESB pages and the TIMA pages */
>> -static void spapr_xive_mmio_map(sPAPRXive *xive)
>> +void spapr_xive_mmio_map(sPAPRXive *xive)
>>  {
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&xive->source), 0, xive->vc_base);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(&xive->end_source), 0, xive->end_b=
ase);
>> @@ -77,8 +77,6 @@ static void spapr_xive_base_reset(DeviceState *dev)
>>      for (i =3D 0; i < xive->nr_ends; i++) {
>>          xive_end_reset(&xive->endt[i]);
>>      }
>> -
>> -    spapr_xive_mmio_map(xive);
>>  }
>> =20
>>  static void spapr_xive_base_instance_init(Object *obj)
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index d1be2579cd9b..013e6ea8aa64 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1628,6 +1628,8 @@ static void spapr_machine_reset(void)
>>          spapr_irq_msi_reset(spapr);
>>      }
>> =20
>> +    spapr_irq_reset(spapr, &error_fatal);
>> +
>>      qemu_devices_reset();
>> =20
>>      /* DRC reset may cause a device to be unplugged. This will cause =
troubles
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 6fac6ca70595..984c6d60cd9f 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -13,6 +13,7 @@
>>  #include "qapi/error.h"
>>  #include "hw/ppc/spapr.h"
>>  #include "hw/ppc/spapr_xive.h"
>> +#include "hw/ppc/spapr_cpu_core.h"
>>  #include "hw/ppc/xics.h"
>>  #include "sysemu/kvm.h"
>> =20
>> @@ -215,6 +216,10 @@ static int spapr_irq_post_load_xics(sPAPRMachineS=
tate *spapr, int version_id)
>>      return 0;
>>  }
>> =20
>> +static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **er=
rp)
>> +{
>> +}
>> +
>>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
>> @@ -232,6 +237,7 @@ sPAPRIrq spapr_irq_xics =3D {
>>      .dt_populate =3D spapr_irq_dt_populate_xics,
>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>>      .post_load   =3D spapr_irq_post_load_xics,
>> +    .reset       =3D spapr_irq_reset_xics,
>>  };
>> =20
>>   /*
>> @@ -362,6 +368,11 @@ static int spapr_irq_post_load_xive(sPAPRMachineS=
tate *spapr, int version_id)
>>      return spapr_xive_post_load(spapr->xive, version_id);
>>  }
>> =20
>> +static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **er=
rp)
>> +{
>> +    spapr_xive_mmio_map(spapr->xive);
>=20
> It's usually not a good idea to actually construct different
> MemoryRegion's at run time.  Instead map them all in, but disable the
> ones you don't want (with memory_region_set_enabled()).

Yes. I realized that.

> I think your current version will also leave the TIMA etc. still
> mapped if you reboot from a XIVE guest to a XICS guest.

The sysbus mmios are cleared I think.

C.

>> +}
>> +
>>  /*
>>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>>   * with XICS.
>> @@ -383,6 +394,7 @@ sPAPRIrq spapr_irq_xive =3D {
>>      .dt_populate =3D spapr_irq_dt_populate_xive,
>>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
>>      .post_load   =3D spapr_irq_post_load_xive,
>> +    .reset       =3D spapr_irq_reset_xive,
>>  };
>> =20
>>  /*
>> @@ -428,6 +440,15 @@ int spapr_irq_post_load(sPAPRMachineState *spapr,=
 int version_id)
>>      return smc->irq->post_load(spapr, version_id);
>>  }
>> =20
>> +void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
>> +{
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>> +
>> +    if (smc->irq->reset) {
>> +        smc->irq->reset(spapr, errp);
>> +    }
>> +}
>> +
>>  /*
>>   * XICS legacy routines - to deprecate one day
>>   */
>=20
