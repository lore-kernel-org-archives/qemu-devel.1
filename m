Received: from eggs.gnu.org ([2001:4830:134:3::10]:42881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI8vE-0004sN-5b
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eI8v9-0002OC-2m
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:01:16 -0500
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:53567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eI8v8-0002LU-R3
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 03:01:11 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6CE85121133
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 09:01:09 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-7-clg@kaod.org>
	<20171124031820.GE28000@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d5adabeb-c533-e870-a810-faa70bbcc2e4@kaod.org>
Date: Fri, 24 Nov 2017 09:01:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171124031820.GE28000@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/25] spapr: introduce a
 spapr_irq_get_qirq() helper
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

On 11/24/2017 04:18 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:36PM +0100, C=E9dric Le Goater wrote:
>> xics_get_qirq() is only used by the sPAPR machine. Let's move it there
>> and change its name to reflect its scope. It will be useful for XIVE
>> support which will use its own set of qirqs.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> s/spapr_irq_get_qirq/spapr_qirq/
>=20
> for brevity

Sure.
=20
> With that change
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Thanks,

C.
=20
>> ---
>>  hw/intc/xics.c              | 12 ------------
>>  hw/ppc/spapr.c              | 11 +++++++++++
>>  hw/ppc/spapr_events.c       | 12 +++++-------
>>  hw/ppc/spapr_pci.c          |  2 +-
>>  include/hw/pci-host/spapr.h |  2 +-
>>  include/hw/ppc/spapr.h      |  1 +
>>  include/hw/ppc/spapr_vio.h  |  2 +-
>>  include/hw/ppc/xics.h       |  1 -
>>  8 files changed, 20 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index 0f2e7273bc8f..a78b4dbd033d 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -714,18 +714,6 @@ static const TypeInfo xics_fabric_info =3D {
>>  /*
>>   * Exported functions
>>   */
>> -qemu_irq xics_get_qirq(XICSFabric *xi, int irq)
>> -{
>> -    XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
>> -    ICSState *ics =3D xic->ics_get(xi, irq);
>> -
>> -    if (ics) {
>> -        return ics->qirqs[irq - ics->offset];
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>>  ICPState *xics_icp_get(XICSFabric *xi, int server)
>>  {
>>      XICSFabricClass *xic =3D XICS_FABRIC_GET_CLASS(xi);
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 79f38a9ff4e1..5d3325ca3c88 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3689,6 +3689,17 @@ void spapr_irq_free(sPAPRMachineState *spapr, i=
nt irq, int num)
>>      }
>>  }
>> =20
>> +qemu_irq spapr_irq_get_qirq(sPAPRMachineState *spapr, int irq)
>> +{
>> +    ICSState *ics =3D spapr->ics;
>> +
>> +    if (ics_valid_irq(ics, irq)) {
>> +        return ics->qirqs[irq - ics->offset];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>>                                   Monitor *mon)
>>  {
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index cead596f3e7a..0427590e9cac 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -472,9 +472,8 @@ static void spapr_powerdown_req(Notifier *n, void =
*opaque)
>> =20
>>      rtas_event_log_queue(spapr, entry);
>> =20
>> -    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>> -                                 rtas_event_log_to_irq(spapr,
>> -                                                       RTAS_LOG_TYPE_=
EPOW)));
>> +    qemu_irq_pulse(spapr_irq_get_qirq(spapr,
>> +                   rtas_event_log_to_irq(spapr, RTAS_LOG_TYPE_EPOW)))=
;
>>  }
>> =20
>>  static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>> @@ -556,9 +555,8 @@ static void spapr_hotplug_req_event(uint8_t hp_id,=
 uint8_t hp_action,
>> =20
>>      rtas_event_log_queue(spapr, entry);
>> =20
>> -    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr),
>> -                                 rtas_event_log_to_irq(spapr,
>> -                                                       RTAS_LOG_TYPE_=
HOTPLUG)));
>> +    qemu_irq_pulse(spapr_irq_get_qirq(spapr,
>> +                   rtas_event_log_to_irq(spapr, RTAS_LOG_TYPE_HOTPLUG=
)));
>>  }
>> =20
>>  void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc)
>> @@ -678,7 +676,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
>>                  spapr_event_sources_get_source(spapr->event_sources, =
i);
>> =20
>>              g_assert(source->enabled);
>> -            qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr), source->=
irq));
>> +            qemu_irq_pulse(spapr_irq_get_qirq(spapr, source->irq));
>>          }
>>      }
>> =20
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index e0ef77a480e5..a02faa12333e 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -723,7 +723,7 @@ static void spapr_msi_write(void *opaque, hwaddr a=
ddr,
>> =20
>>      trace_spapr_pci_msi_write(addr, data, irq);
>> =20
>> -    qemu_irq_pulse(xics_get_qirq(XICS_FABRIC(spapr), irq));
>> +    qemu_irq_pulse(spapr_irq_get_qirq(spapr, irq));
>>  }
>> =20
>>  static const MemoryRegionOps spapr_msi_ops =3D {
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 38470b2f0e5c..3059fdd614e6 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -108,7 +108,7 @@ static inline qemu_irq spapr_phb_lsi_qirq(struct s=
PAPRPHBState *phb, int pin)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>> =20
>> -    return xics_get_qirq(XICS_FABRIC(spapr), phb->lsi_table[pin].irq)=
;
>> +    return spapr_irq_get_qirq(spapr, phb->lsi_table[pin].irq);
>>  }
>> =20
>>  PCIHostState *spapr_create_phb(sPAPRMachineState *spapr, int index);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 7a133f80411a..9a3885593c86 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -714,5 +714,6 @@ int spapr_irq_alloc(sPAPRMachineState *spapr, int =
irq_hint, bool lsi,
>>  int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi=
,
>>                            bool align, Error **errp);
>>  void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>> +qemu_irq spapr_irq_get_qirq(sPAPRMachineState *spapr, int irq);
>> =20
>>  #endif /* HW_SPAPR_H */
>> diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
>> index 2e9685a5d900..404f1de2c046 100644
>> --- a/include/hw/ppc/spapr_vio.h
>> +++ b/include/hw/ppc/spapr_vio.h
>> @@ -87,7 +87,7 @@ static inline qemu_irq spapr_vio_qirq(VIOsPAPRDevice=
 *dev)
>>  {
>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>> =20
>> -    return xics_get_qirq(XICS_FABRIC(spapr), dev->irq);
>> +    return spapr_irq_get_qirq(spapr, dev->irq);
>>  }
>> =20
>>  static inline bool spapr_vio_dma_valid(VIOsPAPRDevice *dev, uint64_t =
taddr,
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index cea462bc7f3e..2f1f35294e6d 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -183,7 +183,6 @@ typedef struct XICSFabricClass {
>> =20
>>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
>> =20
>> -qemu_irq xics_get_qirq(XICSFabric *xi, int irq);
>>  ICPState *xics_icp_get(XICSFabric *xi, int server);
>> =20
>>  /* Internal XICS interfaces */
>=20
