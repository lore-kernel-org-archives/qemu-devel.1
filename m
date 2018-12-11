Received: from eggs.gnu.org ([2001:4830:134:3::10]:46405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWf43-0000mn-Qh
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWf3x-0000dJ-VR
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:14:54 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:49911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWf3w-0000bH-Fc
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:14:49 -0500
Received: from player734.ha.ovh.net (unknown [10.109.160.253])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 043941EAC32
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:14:45 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-16-clg@kaod.org>
	<20181211014737.GE4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dcb91154-72d4-fd7e-42fd-d168cc2415e3@kaod.org>
Date: Tue, 11 Dec 2018 11:14:41 +0100
MIME-Version: 1.0
In-Reply-To: <20181211014737.GE4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 15/19] spapr/xive: enable XIVE MMIOs at
 reset
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

On 12/11/18 2:47 AM, David Gibson wrote:
> On Sun, Dec 09, 2018 at 08:46:06PM +0100, C=E9dric Le Goater wrote:
>> Depending on the interrupt mode chosen, enable or disable the XIVE
>> MMIOs.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h | 1 +
>>  hw/intc/spapr_xive.c        | 9 +++++++++
>>  hw/ppc/spapr_irq.c          | 8 ++++++++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 7244a6231ce6..308afb61a666 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -48,5 +48,6 @@ void spapr_xive_hcall_init(sPAPRMachineState *spapr)=
;
>>  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
>>                     uint32_t phandle);
>>  void spapr_xive_reset_tctx(sPAPRXive *xive);
>> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 560d8d031f74..c6dbb2e8cfc7 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -179,6 +179,15 @@ static void spapr_xive_map_mmio(sPAPRXive *xive)
>>      sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
>>  }
>> =20
>> +void spapr_xive_enable_mmio(sPAPRXive *xive, bool enable)
>=20
> The logic looks fine, but I dislike this name - it's called
> ..._enable() when it can also be used to disable.

ok. Let's call it spapr_xive_mmio_set_enabled() then

C.
=20
>> +{
>> +    memory_region_set_enabled(&xive->source.esb_mmio, enable);
>> +    memory_region_set_enabled(&xive->tm_mmio, enable);
>> +
>> +    /* Disable the END ESBs until a guest OS makes use of them */
>> +    memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>> +}
>> +
>>  /*
>>   * When a Virtual Processor is scheduled to run on a HW thread, the
>>   * hypervisor pushes its identifier in the OS CAM line. Emulate the
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index b423cee30e2c..a8e50725397c 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -217,6 +217,11 @@ static void spapr_irq_reset_xics(sPAPRMachineStat=
e *spapr, Error **errp)
>>      CPU_FOREACH(cs) {
>>          spapr_cpu_core_set_intc(POWERPC_CPU(cs), spapr->icp_type);
>>      }
>> +
>> +    /* Deactivate the XIVE MMIOs */
>> +    if (spapr->xive) {
>> +        spapr_xive_enable_mmio(spapr->xive, false);
>> +    }
>>  }
>> =20
>>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>> @@ -358,6 +363,9 @@ static void spapr_irq_reset_xive(sPAPRMachineState=
 *spapr, Error **errp)
>>       * to come after the XiveTCTX reset handlers.
>>       */
>>      spapr_xive_reset_tctx(spapr->xive);
>> +
>> +    /* Activate the XIVE MMIOs */
>> +    spapr_xive_enable_mmio(spapr->xive, true);
>>  }
>> =20
>>  /*
>=20
