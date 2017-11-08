Received: from eggs.gnu.org ([2001:4830:134:3::10]:54944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCTc1-0002rO-Qy
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eCTbw-0000A1-TO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:54:01 -0500
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:39307)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eCTbw-00009e-Mi
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:53:56 -0500
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5BCEB76DEA
	for <qemu-devel@nongnu.org>; Wed,  8 Nov 2017 17:53:53 +0100 (CET)
References: <20171029181217.9927-1-clg@kaod.org>
	<20171029181217.9927-3-clg@kaod.org>
	<20171108142135.7d4f9506@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ee5f5da4-5fab-7ac4-3205-a33805d5e5a0@kaod.org>
Date: Wed, 8 Nov 2017 16:53:47 +0000
MIME-Version: 1.0
In-Reply-To: <20171108142135.7d4f9506@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/8] spapr: introduce a machine class flag
 to handle migration compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/08/2017 01:21 PM, Greg Kurz wrote:
> On Sun, 29 Oct 2017 19:12:11 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Older pseries machines, before 2.11, do not have a bitmap acting as a
>=20
> We're in hard freeze for 2.11: this should now target 2.12 (David has j=
ust
> created the ppc-for-2.12 branch).

ok. I have switched my 'xive' branch to track Dave's ppc-for-2.12.

>> IRQ number allocator but use the ICSIRQState array for this purpose.
>> This difference between machine versions needs to be taken into
>> account when loading the state.
>>
>> To keep in sync the bitmap with the ICSIRQState array flags, we
>> introduce a machine class flag 'pre_2_11_has_no_bitmap' identifying an
>> older version.
>>
>=20
> Since you're introducing the bitmap in this series, I think you should
> rather do the other way around: add a 'has_irq_bitmap' flag to the mach=
ine
> class defaulting to 'true' in spapr_machine_class_init() and setting it=
 to
> 'false' for older machine types.

yes. Will do.

Thanks,

C.=20

>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/ppc/spapr.c         | 19 +++++++++++++++++++
>>  include/hw/ppc/spapr.h |  1 +
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 88da4bad2328..b33eebe44906 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -1532,6 +1532,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Erro=
r **errp)
>>  static int spapr_post_load(void *opaque, int version_id)
>>  {
>>      sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>>      int err =3D 0;
>> =20
>>      if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
>> @@ -1562,6 +1563,20 @@ static int spapr_post_load(void *opaque, int ve=
rsion_id)
>>          }
>>      }
>> =20
>> +    /*
>> +     * synchronize the IRQ number bitmap with the ICSIRQState array
>> +     * coming from an pre-2.11 pseries machine
>> +     */
>> +    if (smc->pre_2_11_has_no_bitmap) {
>> +        int srcno;
>> +
>> +        for (srcno =3D 0; srcno < spapr->ics->nr_irqs; srcno++) {
>> +            if (spapr->ics->irqs[srcno].flags & XICS_FLAGS_IRQ_MASK &=
&
>> +                !test_bit(srcno, spapr->irq_map)) {
>> +                bitmap_set(spapr->irq_map, srcno, 1);
>> +            }
>> +        }
>> +    }
>>      return err;
>>  }
>> =20
>> @@ -3772,8 +3787,12 @@ static void spapr_machine_2_10_instance_options=
(MachineState *machine)
>> =20
>>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>>  {
>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>> +
>>      spapr_machine_2_11_class_options(mc);
>>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
>> +
>> +    smc->pre_2_11_has_no_bitmap =3D true;
>>  }
>> =20
>>  DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index b962bfe09bb5..1525d1518c47 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -62,6 +62,7 @@ struct sPAPRMachineClass {
>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of =
LMBs */
>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>>      bool pre_2_10_has_unused_icps;
>> +    bool pre_2_11_has_no_bitmap;
>>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>>                            uint64_t *buid, hwaddr *pio,=20
>>                            hwaddr *mmio32, hwaddr *mmio64,
>=20
