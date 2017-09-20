Received: from eggs.gnu.org ([2001:4830:134:3::10]:36027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf1S-0002Vx-DJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1duf0n-0003jh-5P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:26:38 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:44794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1duf0m-0003ij-Vl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:25:57 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0602EACAFB
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:50:09 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-16-clg@kaod.org> <20170919075602.GS27153@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5dc03703-2cde-1523-946a-b85edd286370@kaod.org>
Date: Wed, 20 Sep 2017 11:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170919075602.GS27153@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 15/21] spapr: modify
 spapr_populate_pci_dt() to use a 'nr_irqs' argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/19/2017 09:56 AM, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:29PM +0200, C=E9dric Le Goater wrote:
>> This adds some flexibility in the definition of the number of
>> available IRQS used in a sPAPR machine.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This doesn't seem sensible.  You've already stated that the XIVE and
> XICS need equivalent irq number spaces, so in particular they should
> have the same number of irqs advertised.

yes. I am adding an argument to spapr_populate_pci_dt()=20
because it is using the XICS_IRQS_SPAPR define directly=20
and I intend to extend that number of irqs with the=20
number of cpus to have room for IPIs.

C.=20

>> ---
>>  hw/ppc/spapr.c              | 2 +-
>>  hw/ppc/spapr_pci.c          | 4 ++--
>>  include/hw/pci-host/spapr.h | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3e3ff1fbc988..5d69df928434 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1093,7 +1093,7 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
>>      }
>> =20
>>      QLIST_FOREACH(phb, &spapr->phbs, list) {
>> -        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt);
>> +        ret =3D spapr_populate_pci_dt(phb, PHANDLE_XICP, fdt, XICS_IR=
QS_SPAPR);
>>          if (ret < 0) {
>>              error_report("couldn't setup PCI devices in fdt");
>>              exit(1);
>> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index d84abf1070a0..05b0a067458e 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -2073,7 +2073,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBStat=
e *phb)
>> =20
>>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>                            uint32_t xics_phandle,
>> -                          void *fdt)
>> +                          void *fdt, int nr_irqs)
>>  {
>>      int bus_off, i, j, ret;
>>      char nodename[FDT_NAME_MAX];
>> @@ -2142,7 +2142,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>      _FDT(fdt_setprop(fdt, bus_off, "ranges", &ranges, sizeof_ranges))=
;
>>      _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)))=
;
>>      _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", =
0x1));
>> -    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQ=
S_SPAPR));
>> +    _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", nr_irqs)=
);
>> =20
>>      /* Dynamic DMA window */
>>      if (phb->ddw_enabled) {
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 38470b2f0e5c..40146f72c103 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -115,7 +115,7 @@ PCIHostState *spapr_create_phb(sPAPRMachineState *=
spapr, int index);
>> =20
>>  int spapr_populate_pci_dt(sPAPRPHBState *phb,
>>                            uint32_t xics_phandle,
>> -                          void *fdt);
>> +                          void *fdt, int nr_irqs);
>> =20
>>  void spapr_pci_rtas_init(void);
>> =20
>=20
