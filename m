Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzdhp-0003LF-Bp
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fzdX5-0004sR-Lq
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:56:27 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fzdX5-0004k5-D3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:56:23 -0400
Received: from player687.ha.ovh.net (unknown [10.109.160.230])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4572928AC5
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 09:56:14 +0200 (CEST)
References: <20180911055503.2303-1-clg@kaod.org>
	<20180911055503.2303-2-clg@kaod.org>
	<20180911093452.1608d5fc@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c4858950-8a98-603c-ce21-1a12357cf7b8@kaod.org>
Date: Tue, 11 Sep 2018 09:56:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180911093452.1608d5fc@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: introduce a spapr_irq class
 'nr_msis' attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 09/11/2018 09:34 AM, Greg Kurz wrote:
> On Tue, 11 Sep 2018 07:55:02 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> The number of MSI interrupts a sPAPR machine can allocate is in direct
>> relation with the number of interrupts of the sPAPRIrq backend. Define
>> statically this value at the sPAPRIrq class level and use it for the
>> "ibm,pe-total-#msi" property of the sPAPR PHB.
>>
>> According to the PAPR specs, "ibm,pe-total-#msi" defines the maximum
>> number of MSIs that are available to the PE. We choose to advertise
>> the maximum number of MSIs that are available to the machine for
>> simplicity of the model and to avoid segmenting the MSI interrupt pool
>> which can be easily shared. If the pool limit is reached, it can be
>> extended dynamically.
>>
>> Finally, remove XICS_IRQS_SPAPR which is now unused.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>=20
> Looks good to me. Just one comment below.
>=20
>>  include/hw/ppc/spapr_irq.h | 1 +
>>  include/hw/ppc/xics.h      | 2 --
>>  hw/ppc/spapr_irq.c         | 9 +++++++--
>>  hw/ppc/spapr_pci.c         | 5 +++--
>>  4 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index 0e98c4474bb2..650f810ad2aa 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -31,6 +31,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
>> =20
>>  typedef struct sPAPRIrq {
>>      uint32_t    nr_irqs;
>> +    uint32_t    nr_msis;
>> =20
>>      void (*init)(sPAPRMachineState *spapr, Error **errp);
>>      int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
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
>> index 0cbb5dd39368..fe8be5f5217a 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -99,7 +99,7 @@ static void spapr_irq_init_xics(sPAPRMachineState *s=
papr, Error **errp)
>> =20
>>      /* Initialize the MSI IRQ allocator. */
>>      if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
>> -        spapr_irq_msi_init(spapr, XICS_IRQ_BASE + nr_irqs - SPAPR_IRQ=
_MSI);
>> +        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
>>      }
>> =20
>>      if (kvm_enabled()) {
>> @@ -195,8 +195,13 @@ static void spapr_irq_print_info_xics(sPAPRMachin=
eState *spapr, Monitor *mon)
>>      ics_pic_print_info(spapr->ics, mon);
>>  }
>> =20
>> +#define SPAPR_IRQ_XICS_NR_IRQS     0x400
>> +#define SPAPR_IRQ_XICS_NR_MSIS     \
>> +    (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
>> +
>>  sPAPRIrq spapr_irq_xics =3D {
>> -    .nr_irqs     =3D XICS_IRQS_SPAPR,
>> +    .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
>> +    .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
>> =20
>>      .init        =3D spapr_irq_init_xics,
>>      .claim       =3D spapr_irq_claim_xics,
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
>=20
> It is a bit unfortunate to add another user of qdev_get_machine()...
>=20
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
>=20
> ... and to expose machine class internals. Since spapr_populate_pci_dt(=
) is only
> called from the core machine code, maybe have the caller to pass the nu=
mber of
> MSIs ?

yes we could add an extra parameter to spapr_populate_pci_dt()

> Anyway, this can be done in a followup patch so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks,

C.
>=20
>>      /* Dynamic DMA window */
>>      if (phb->ddw_enabled) {
>=20
