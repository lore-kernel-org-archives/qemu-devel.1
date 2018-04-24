Received: from eggs.gnu.org ([2001:4830:134:3::10]:35108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAtBJ-0000nP-Hl
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAtBF-00016z-CZ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:20:09 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:59459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAtBF-00013U-38
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:20:05 -0400
Received: from player737.ha.ovh.net (unknown [10.109.120.83])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id D23621B08DE
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 10:20:02 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-6-clg@kaod.org>
	<20180424065810.GR19804@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6086f4d7-c927-6660-679b-719c59003f64@kaod.org>
Date: Tue, 24 Apr 2018 10:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180424065810.GR19804@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 05/35] spapr/xive: add a single source
 block to the sPAPR XIVE model
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

On 04/24/2018 08:58 AM, David Gibson wrote:
> On Thu, Apr 19, 2018 at 02:43:01PM +0200, C=E9dric Le Goater wrote:
>> Bare-metal systems (PowerNV) have multiples interrupt sources. The
>> XIVE interrupt controller has an internal source for IPIs and generic
>> IPIs, the PSIHB has one and also the PHBs. But, for simplicity on the
>> sPAPR machine, we use a unique XiveSource object for all IPIs and
>> virtual device interrupts of the VM.
>>
>> The ESB MMIO region used to control the sources is mapped at the
>> address of chip 0 of a real system and only the provisioned IRQ
>> numbers are covered.
>=20
> Is that MMIO address PAPR specified, or arbitrary?

There are no specified value for the ESB address. It's queried by=20
the guest using the H_INT_GET_SOURCE_INFO hcall. For KVM, I have
introduced a ioctl to configure the KVM device.=20

Same for the TIMA, but in this case, the address is exposed to the
guest in the device tree.
=20
>=20
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c        | 34 ++++++++++++++++++++++++++++++++++
>>  include/hw/ppc/spapr_xive.h |  3 +++
>>  include/hw/ppc/xive.h       |  6 ++++++
>>  3 files changed, 43 insertions(+)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 020444e2665a..90cde8a4082d 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -14,12 +14,15 @@
>>  #include "sysemu/cpus.h"
>>  #include "monitor/monitor.h"
>>  #include "hw/ppc/spapr_xive.h"
>> +#include "hw/ppc/xive.h"
>>  #include "hw/ppc/xive_regs.h"
>> =20
>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
>>  {
>>      int i;
>> =20
>> +    xive_source_pic_print_info(&xive->source, mon);
>> +
>>      monitor_printf(mon, "IVE Table\n");
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>>          XiveIVE *ive =3D &xive->ivt[i];
>> @@ -40,6 +43,9 @@ static void spapr_xive_reset(DeviceState *dev)
>>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>>      int i;
>> =20
>> +    /* Xive Source reset is done through SysBus, it should put all
>> +     * IRQs to OFF (!P|Q) */
>> +
>>      /* Mask all valid IVEs in the IRQ number space. */
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>>          XiveIVE *ive =3D &xive->ivt[i];
>> @@ -51,18 +57,42 @@ static void spapr_xive_reset(DeviceState *dev)
>> =20
>>  static void spapr_xive_init(Object *obj)
>>  {
>> +    sPAPRXive *xive =3D SPAPR_XIVE(obj);
>> =20
>> +    object_initialize(&xive->source, sizeof(xive->source), TYPE_XIVE_=
SOURCE);
>> +    object_property_add_child(obj, "source", OBJECT(&xive->source), N=
ULL);
>>  }
>> =20
>>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>  {
>>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>> +    XiveSource *xsrc =3D &xive->source;
>> +    Error *local_err =3D NULL;
>> =20
>>      if (!xive->nr_irqs) {
>>          error_setg(errp, "Number of interrupt needs to be greater 0")=
;
>>          return;
>>      }
>> =20
>> +    /* The XIVE interrupt controller has an internal source for IPIs
>> +     * and generic IPIs, the PSIHB has one and also the PHBs. For
>> +     * simplicity, we use a unique XIVE source object for *all*
>> +     * interrupts on sPAPR. The ESBs pages are mapped at the address
>> +     * of chip 0 of a real system.
>> +     */
>> +    object_property_set_int(OBJECT(xsrc), XIVE_VC_BASE, "bar",
>> +                            &error_fatal);
>> +    object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
>> +                            &error_fatal);
>> +    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(xive)=
,
>> +                                   &error_fatal);
>> +    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_e=
rr);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
>> +
>>      /* Allocate the Interrupt Virtualization Table */
>>      xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
>>  }
>> @@ -137,23 +167,27 @@ type_init(spapr_xive_register_types)
>>  bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi)
>>  {
>>      XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
>> +    XiveSource *xsrc =3D &xive->source;
>> =20
>>      if (!ive) {
>>          return false;
>>      }
>> =20
>>      ive->w |=3D IVE_VALID;
>> +    xive_source_irq_set(xsrc, lisn - xsrc->offset, lsi);
>>      return true;
>>  }
>> =20
>>  bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn)
>>  {
>>      XiveIVE *ive =3D spapr_xive_get_ive(XIVE_FABRIC(xive), lisn);
>> +    XiveSource *xsrc =3D &xive->source;
>> =20
>>      if (!ive) {
>>          return false;
>>      }
>> =20
>>      ive->w &=3D ~IVE_VALID;
>> +    xive_source_irq_set(xsrc, lisn - xsrc->offset, false);
>>      return true;
>>  }
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 1d966b5d3a96..4538c622b60a 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -19,6 +19,9 @@
>>  typedef struct sPAPRXive {
>>      SysBusDevice parent;
>> =20
>> +    /* Internal interrupt source for IPIs and virtual devices */
>> +    XiveSource   source;
>> +
>>      /* Routing table */
>>      XiveIVE      *ivt;
>>      uint32_t     nr_irqs;
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 5b145816acdc..57295715a4a5 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -16,6 +16,12 @@
>>  typedef struct XiveFabric XiveFabric;
>> =20
>>  /*
>> + * XIVE MMIO regions
>> + */
>> +
>> +#define XIVE_VC_BASE   0x0006010000000000ull
>> +
>> +/*
>>   * XIVE Interrupt Source
>>   */
>> =20
>=20
