Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gS8Id-0000aQ-Rv
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:27:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gS8IZ-0007C4-W0
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:27:15 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:50066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gS8IX-00074s-7N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 17:27:09 -0500
Received: from player696.ha.ovh.net (unknown [10.109.146.5])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 57E8D171568
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 23:27:06 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-18-clg@kaod.org>
	<20181128043155.GA2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5877e247-5fcd-2939-adce-ed4492c5950b@kaod.org>
Date: Wed, 28 Nov 2018 23:26:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181128043155.GA2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 17/36] spapr: add device tree support
 for the XIVE exploitation mode
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

On 11/28/18 5:31 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:10AM +0100, C=E9dric Le Goater wrote:
>> The XIVE interface for the guest is described in the device tree under
>> the "interrupt-controller" node. A couple of new properties are
>> specific to XIVE :
>>
>>  - "reg"
>>
>>    contains the base address and size of the thread interrupt
>>    managnement areas (TIMA), for the User level and for the Guest OS
>>    level. Only the Guest OS level is taken into account today.
>>
>>  - "ibm,xive-eq-sizes"
>>
>>    the size of the event queues. One cell per size supported, contains
>>    log2 of size, in ascending order.
>>
>>  - "ibm,xive-lisn-ranges"
>>
>>    the IRQ interrupt number ranges assigned to the guest for the IPIs.
>>
>> and also under the root node :
>>
>>  - "ibm,plat-res-int-priorities"
>>
>>    contains a list of priorities that the hypervisor has reserved for
>>    its own use. OPAL uses the priority 7 queue to automatically
>>    escalate interrupts for all other queues (DD2.X POWER9). So only
>>    priorities [0..6] are allowed for the guest.
>>
>> Extend the sPAPR IRQ backend with a new handler to populate the DT
>> with the appropriate "interrupt-controller" node.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_irq.h  |  2 ++
>>  include/hw/ppc/spapr_xive.h |  2 ++
>>  hw/intc/spapr_xive_hcall.c  | 62 ++++++++++++++++++++++++++++++++++++=
+
>>  hw/ppc/spapr.c              |  3 +-
>>  hw/ppc/spapr_irq.c          | 17 ++++++++++
>>  5 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
>> index c854ae527808..cfdc1f86e713 100644
>> --- a/include/hw/ppc/spapr_irq.h
>> +++ b/include/hw/ppc/spapr_irq.h
>> @@ -40,6 +40,8 @@ typedef struct sPAPRIrq {
>>      void (*free)(sPAPRMachineState *spapr, int irq, int num);
>>      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
>>      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
>> +    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers=
,
>> +                        void *fdt, uint32_t phandle);
>>  } sPAPRIrq;
>> =20
>>  extern sPAPRIrq spapr_irq_xics;
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 418511f3dc10..5b3fab192d41 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -65,5 +65,7 @@ bool spapr_xive_priority_is_valid(uint8_t priority);
>>  typedef struct sPAPRMachineState sPAPRMachineState;
>> =20
>>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
>> +void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt,
>> +                   uint32_t phandle);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/hw/intc/spapr_xive_hcall.c b/hw/intc/spapr_xive_hcall.c
>> index 52e4e23995f5..66c78aa88500 100644
>> --- a/hw/intc/spapr_xive_hcall.c
>> +++ b/hw/intc/spapr_xive_hcall.c
>> @@ -890,3 +890,65 @@ void spapr_xive_hcall_init(sPAPRMachineState *spa=
pr)
>>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>>  }
>> +
>> +void spapr_dt_xive(sPAPRXive *xive, int nr_servers, void *fdt, uint32=
_t phandle)
>> +{
>> +    int node;
>> +    uint64_t timas[2 * 2];
>> +    /* Interrupt number ranges for the IPIs */
>> +    uint32_t lisn_ranges[] =3D {
>> +        cpu_to_be32(0),
>> +        cpu_to_be32(nr_servers),
>> +    };
>> +    uint32_t eq_sizes[] =3D {
>> +        cpu_to_be32(12), /* 4K */
>> +        cpu_to_be32(16), /* 64K */
>> +        cpu_to_be32(21), /* 2M */
>> +        cpu_to_be32(24), /* 16M */
>> +    };
>> +    /* The following array is in sync with the 'spapr_xive_priority_i=
s_valid'
>> +     * routine above. The O/S is expected to choose priority 6.
>> +     */
>> +    uint32_t plat_res_int_priorities[] =3D {
>> +        cpu_to_be32(7),    /* start */
>> +        cpu_to_be32(0xf8), /* count */
>> +    };
>> +    gchar *nodename;
>> +
>> +    /* Thread Interrupt Management Area : User (ring 3) and OS (ring =
2) */
>> +    timas[0] =3D cpu_to_be64(xive->tm_base + 3 * (1ull << TM_SHIFT));
>> +    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
>> +    timas[2] =3D cpu_to_be64(xive->tm_base + 2 * (1ull << TM_SHIFT));
>=20
> Don't you have symbolic constants for the ring numbers, instead of '2'
> and '3' above?

I have offsets in the TIMA, 0x0, 0x10, ... We could add constants
for the ring numbers as they are used in the TIMA memory ops.
=20
>=20
>> +    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
>> +
>> +    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
>> +                               xive->tm_base + 3 * (1 << TM_SHIFT));
>> +    _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
>> +    g_free(nodename);
>> +
>> +    _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
>> +    _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
>> +
>> +    _FDT(fdt_setprop_string(fdt, node, "compatible", "ibm,power-ivpe"=
));
>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-eq-sizes", eq_sizes,
>> +                     sizeof(eq_sizes)));
>> +    _FDT(fdt_setprop(fdt, node, "ibm,xive-lisn-ranges", lisn_ranges,
>> +                     sizeof(lisn_ranges)));
>> +
>> +    /* For Linux to link the LSIs to the main interrupt controller.
>=20
> What's the "main interrupt controller" in this context?

There is only one. This is just how it is reference in the Linux code. =20
I will remove the comment.

>=20
>> +     * These properties are not in XIVE exploitation mode sPAPR
>> +     * specs

These properties have been added now.

>> +     */
>> +    _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
>> +    _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
>> +
>> +    /* For SLOF */
>> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
>> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
>> +
>> +    /* The "ibm,plat-res-int-priorities" property defines the priorit=
y
>> +     * ranges reserved by the hypervisor
>> +     */
>> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
>> +                     plat_res_int_priorities, sizeof(plat_res_int_pri=
orities)));
>> +}
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9f8c19e56e7a..ad1692cdcd0f 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1270,7 +1270,8 @@ static void *spapr_build_fdt(sPAPRMachineState *=
spapr,
>>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
>> =20
>>      /* /interrupt controller */
>> -    spapr_dt_xics(xics_max_server_number(spapr), fdt, PHANDLE_XICP);
>> +    smc->irq->dt_populate(spapr, xics_max_server_number(spapr), fdt,
>> +                          PHANDLE_XICP);
>> =20
>>      ret =3D spapr_populate_memory(spapr, fdt);
>>      if (ret < 0) {
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index da6fcfaa3c52..d88a029d8c5c 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -190,6 +190,13 @@ static void spapr_irq_print_info_xics(sPAPRMachin=
eState *spapr, Monitor *mon)
>>      ics_pic_print_info(spapr->ics, mon);
>>  }
>> =20
>> +static void spapr_irq_dt_populate_xics(sPAPRMachineState *spapr,
>> +                                       uint32_t nr_servers, void *fdt=
,
>> +                                       uint32_t phandle)
>> +{
>> +    spapr_dt_xics(nr_servers, fdt, phandle);
>> +}
>> +
>=20
> It'd be nicer to change the signature of spapr_dt_xics, rather than
> having this one line wrapper.

but this is a sPAPR IRQ method. So you would use spapr_dt_xics directly=20
for the definition of the backend ? if you prefer, it's fine with me.

>=20
>>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
>> @@ -203,6 +210,7 @@ sPAPRIrq spapr_irq_xics =3D {
>>      .free        =3D spapr_irq_free_xics,
>>      .qirq        =3D spapr_qirq_xics,
>>      .print_info  =3D spapr_irq_print_info_xics,
>> +    .dt_populate =3D spapr_irq_dt_populate_xics,
>>  };
>> =20
>>   /*
>> @@ -300,6 +308,13 @@ static void spapr_irq_print_info_xive(sPAPRMachin=
eState *spapr,
>>      spapr_xive_pic_print_info(spapr->xive, mon);
>>  }
>> =20
>> +static void spapr_irq_dt_populate_xive(sPAPRMachineState *spapr,
>> +                                       uint32_t nr_servers, void *fdt=
,
>> +                                       uint32_t phandle)
>> +{
>> +    spapr_dt_xive(spapr->xive, nr_servers, fdt, phandle);
>=20
> Uh.. and to make the hook signature just match what we need rather
> than having to have trivial wrappers in both cases.

ok.

>=20
>> +}
>> +
>>  /*
>>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>>   * with XICS.
>> @@ -317,6 +332,7 @@ sPAPRIrq spapr_irq_xive =3D {
>>      .free        =3D spapr_irq_free_xive,
>>      .qirq        =3D spapr_qirq_xive,
>>      .print_info  =3D spapr_irq_print_info_xive,
>> +    .dt_populate =3D spapr_irq_dt_populate_xive,
>>  };
>> =20
>>  /*
>> @@ -421,4 +437,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>>      .free        =3D spapr_irq_free_xics,
>>      .qirq        =3D spapr_qirq_xics,
>>      .print_info  =3D spapr_irq_print_info_xics,
>> +    .dt_populate =3D spapr_irq_dt_populate_xics,
>>  };
>=20
