Received: from eggs.gnu.org ([2001:4830:134:3::10]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzaZB-0005fU-Gn
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzaVP-0008TK-5O
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:42:30 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:45803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzaVN-0008SX-0t
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:42:25 -0400
Received: from player714.ha.ovh.net (unknown [10.109.143.249])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 2AD9E1E50ED
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 06:42:22 +0200 (CEST)
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910110222.8162-4-clg@kaod.org>
	<20180911015032.GG7978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <86b41d62-73b1-f181-ceeb-ad0396fc1c11@kaod.org>
Date: Tue, 11 Sep 2018 06:42:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180911015032.GG7978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr_pci: fix "ibm,
 pe-total-#msi" value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 09/11/2018 03:50 AM, David Gibson wrote:
> On Mon, Sep 10, 2018 at 01:02:22PM +0200, C=E9dric Le Goater wrote:
>> The "ibm,pe-total-#msi" property of the sPAPR PHB defines the number
>> of allocatable MSI interrupts. This is currently set to XICS_IRQS_SPAP=
R
>> which covers the full IRQ number space of the machine. This is wrong.
>>
>> Fix the definition by using the 'nr_msis' attribute of the sPAPRIrq
>> class and remove XICS_IRQS_SPAPR which is now unused.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Oh.. right.. I think it makes more sense to just merge this into the
> first patch.

OK. I will also remove XICS_IRQS_SPAPR in the first patch then

Thanks,

C.

>> ---
>>  include/hw/ppc/xics.h | 2 --
>>  hw/ppc/spapr_irq.c    | 2 +-
>>  hw/ppc/spapr_pci.c    | 5 +++--
>>  3 files changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 9c2916c9b23a..9958443d1984 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
>>      ICPState *(*icp_get)(XICSFabric *xi, int server);
>>  } XICSFabricClass;
>> =20
>> -#define XICS_IRQS_SPAPR               1024
>> -
>>  void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
>> =20
>>  ICPState *xics_icp_get(XICSFabric *xi, int server);
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index b14d7bce00ea..e77b94cc685e 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -290,7 +290,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int n=
um, bool align, Error **errp)
>>      return first + ics->offset;
>>  }
>> =20
>> -#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     XICS_IRQS_SPAPR
>> +#define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
>> =20
>>  sPAPRIrq spapr_irq_xics_legacy =3D {
>>      .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index 6bcb4f419b6b..bb736177e76c 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -2121,6 +2121,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>      sPAPRTCETable *tcet;
>>      PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
>>      sPAPRFDT s_fdt;
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(qdev_get_machi=
ne());
>> =20
>>      /* Start populating the FDT */
>>      nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
>> @@ -2138,8 +2139,8 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges))=
;
>>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)))=
;
>>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", =
0x1));
>> -    /* TODO: fine tune the total count of allocatable MSIs per PHB */
>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQ=
S_SPAPR));
>> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
>> +                          smc->irq->nr_msis));
>> =20
>>      /* Dynamic DMA window */
>>      if (phb->ddw_enabled) {
>=20
