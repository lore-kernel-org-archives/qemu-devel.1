Received: from eggs.gnu.org ([208.118.235.92]:50021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gf72v-0004vq-OI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gf72s-00015c-JI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:44:41 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:44760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gf72s-00014V-BT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:44:38 -0500
Received: from player730.ha.ovh.net (unknown [10.109.143.238])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 651F11EF111
	for <qemu-devel@nongnu.org>; Thu,  3 Jan 2019 18:44:36 +0100 (CET)
References: <20190102055743.5052-1-clg@kaod.org>
	<20190102055743.5052-3-clg@kaod.org>
	<20190103035726.GR10853@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <76f4f558-5e0d-52ee-5c99-c208d005f643@kaod.org>
Date: Thu, 3 Jan 2019 18:44:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190103035726.GR10853@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] ppc/xive: introduce a XiveTCTX
 pointer under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 1/3/19 4:57 AM, David Gibson wrote:
> On Wed, Jan 02, 2019 at 06:57:35AM +0100, C=E9dric Le Goater wrote:
>> which will be used by the machine only when the XIVE interrupt mode is
>> in use.
>=20
> I don't love the idea of putting a hook this specific into the
> PowerPCCPU structure, though it might be the easiest path in the short
> term.
>=20
> A couple of approaches: 1) revisit my changes to allow for a pointer
> to machine-defined per-cpu data. =20

ok but we still need two different presenters objects, one for each
mode.

> or 2) do we actually need a cpu to tctx pointer.
>=20
> Expanding on (2) - here you use the pointer to find the right TIMA
> state to access,

yes.=20

> but that could also be handled by having different TIMA IO instances=20
> and mapping those individually to cpu_as. =20

It might work for QEMU but I am not sure how to implement the KVM=20
backend with such a design. We only have a single ram ptr mapping=20
for the machine in the KVM case.

There are a couple of places where we need to loop on the XiveTCTX=20
(presenter, KVM) and we use the QEMU CPU list and the cpu->tctx for=20
that. One of the reasons we introduced the cpu->intc pointer some=20
time ago was to get rid of the ICP array.=20

I don't think we want to introduce a XiveTCTX array again.

> On the interrupt delivery side I think a tctx to cpu link will suffice.=
 =20

yes. that we already have. It is mostly used by KVM in fact.=20

> For sPAPR there might be complications with translating cpu numbers in
> hcalls to the right tctx.

The XiveTCTX is not used by the hcalls. We are fine on that side.


The double pointer solution is what I prefer today, but if you are=20
uncomfortable with it, we can come back to the previous where I was=20
allocating a XiveTCTX child under the CPU and switching the presenter=20
objects at reset. The only issue remaining was the child unparenting=20
in the unrealize() method.   =20

Thanks,=20

C.

=20
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  target/ppc/cpu.h        | 2 ++
>>  hw/intc/xive.c          | 6 +++---
>>  hw/ppc/spapr_cpu_core.c | 7 ++++++-
>>  hw/ppc/spapr_irq.c      | 8 ++++----
>>  4 files changed, 15 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index d5f99f1fc7b9..c76036985623 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1177,6 +1177,7 @@ do {                                            =
\
>> =20
>>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
>> +typedef struct XiveTCTX XiveTCTX;
>> =20
>>  /**
>>   * PowerPCCPU:
>> @@ -1196,6 +1197,7 @@ struct PowerPCCPU {
>>      uint32_t compat_pvr;
>>      PPCVirtualHypervisor *vhyp;
>>      Object *intc;
>> +    XiveTCTX *tctx;
>>      void *machine_data;
>>      int32_t node_id; /* NUMA node this CPU belongs to */
>>      PPCHash64Options *hash64_opts;
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index ea33494338dc..410c53278a11 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -321,7 +321,7 @@ static void xive_tm_write(void *opaque, hwaddr off=
set,
>>                            uint64_t value, unsigned size)
>>  {
>>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>> -    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
>> +    XiveTCTX *tctx =3D cpu->tctx;
>>      const XiveTmOp *xto;
>> =20
>>      /*
>> @@ -360,7 +360,7 @@ static void xive_tm_write(void *opaque, hwaddr off=
set,
>>  static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned si=
ze)
>>  {
>>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>> -    XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
>> +    XiveTCTX *tctx =3D cpu->tctx;
>>      const XiveTmOp *xto;
>> =20
>>      /*
>> @@ -1186,7 +1186,7 @@ static bool xive_presenter_match(XiveRouter *xrt=
r, uint8_t format,
>> =20
>>      CPU_FOREACH(cs) {
>>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> -        XiveTCTX *tctx =3D XIVE_TCTX(cpu->intc);
>> +        XiveTCTX *tctx =3D cpu->tctx;
>>          int ring;
>> =20
>>          /*
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 2739b2a4b818..1473ef853336 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -194,7 +194,12 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu,=
 sPAPRCPUCore *sc)
>>          vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machi=
ne_data);
>>      }
>>      qemu_unregister_reset(spapr_cpu_reset, cpu);
>> -    object_unparent(cpu->intc);
>> +    if (cpu->intc) {
>> +        object_unparent(cpu->intc);
>> +    }
>> +    if (cpu->tctx) {
>> +        object_unparent(OBJECT(cpu->tctx));
>> +    }
>>      cpu_remove_sync(CPU(cpu));
>>      object_unparent(OBJECT(cpu));
>>  }
>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>> index 2d2e17b66533..8d028db44ff4 100644
>> --- a/hw/ppc/spapr_irq.c
>> +++ b/hw/ppc/spapr_irq.c
>> @@ -305,7 +305,7 @@ static void spapr_irq_print_info_xive(sPAPRMachine=
State *spapr,
>>      CPU_FOREACH(cs) {
>>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> =20
>> -        xive_tctx_pic_print_info(XIVE_TCTX(cpu->intc), mon);
>> +        xive_tctx_pic_print_info(cpu->tctx, mon);
>>      }
>> =20
>>      spapr_xive_pic_print_info(spapr->xive, mon);
>> @@ -323,13 +323,13 @@ static void spapr_irq_cpu_intc_create_xive(sPAPR=
MachineState *spapr,
>>          return;
>>      }
>> =20
>> -    cpu->intc =3D obj;
>> +    cpu->tctx =3D XIVE_TCTX(obj);
>> =20
>>      /*
>>       * (TCG) Early setting the OS CAM line for hotplugged CPUs as the=
y
>>       * don't beneficiate from the reset of the XIVE IRQ backend
>>       */
>> -    spapr_xive_set_tctx_os_cam(XIVE_TCTX(obj));
>> +    spapr_xive_set_tctx_os_cam(cpu->tctx);
>>  }
>> =20
>>  static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int ver=
sion_id)
>> @@ -345,7 +345,7 @@ static void spapr_irq_reset_xive(sPAPRMachineState=
 *spapr, Error **errp)
>>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>> =20
>>          /* (TCG) Set the OS CAM line of the thread interrupt context.=
 */
>> -        spapr_xive_set_tctx_os_cam(XIVE_TCTX(cpu->intc));
>> +        spapr_xive_set_tctx_os_cam(cpu->tctx);
>>      }
>>  }
>> =20
>=20
