Received: from eggs.gnu.org ([209.51.188.92]:56848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gwjmw-00023A-24
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gwjmt-0007DB-2N
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:33:02 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:49694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gwjmr-0007AN-7m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 03:32:58 -0500
Received: from player696.ha.ovh.net (unknown [10.109.159.73])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 73A29117BB1
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:32:49 +0100 (CET)
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-6-clg@kaod.org>
	<20190212054013.GL1884@umbus.fritz.box>
	<ef18dbf0-87dc-1ec2-247f-28bae0aef308@kaod.org>
	<20190221031316.GE13129@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <22310d64-31f2-537a-1b04-1f38683697f1@kaod.org>
Date: Thu, 21 Feb 2019 09:32:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190221031316.GE13129@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/19] ppc/pnv: add XIVE support
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

On 2/21/19 4:13 AM, David Gibson wrote:
> On Tue, Feb 19, 2019 at 08:31:25AM +0100, C=E9dric Le Goater wrote:
>> On 2/12/19 6:40 AM, David Gibson wrote:
>>> On Mon, Jan 28, 2019 at 10:46:11AM +0100, C=E9dric Le Goater wrote:
> [snip]
>>>>  #endif /* _PPC_PNV_H */
>>>> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
>>>> index 9961ea3a92cd..8e57c064e661 100644
>>>> --- a/include/hw/ppc/pnv_core.h
>>>> +++ b/include/hw/ppc/pnv_core.h
>>>> @@ -49,6 +49,7 @@ typedef struct PnvCoreClass {
>>>> =20
>>>>  typedef struct PnvCPUState {
>>>>      struct ICPState *icp;
>>>> +    struct XiveTCTX *tctx;
>>>
>>> Unlike sPAPR, we really do always know in advance the interrupt
>>> controller for a particular machine.  I think it makes sense to
>>> further split the POWER8 and POWER9 cases here, so we only track one
>>> for any given setup.
>>
>> So, you would define a :=20
>>
>>   typedef struct Pnv9CPUState {
>>       struct XiveTCTX *tctx;
>>   } Pnv9CPUState;
>>
>> to be allocated when the core is realized ? and later the routine=20
>> pnv_chip_power9_intc_create() would assign the ->tctx pointer.
>=20
> Sounds about right.
>=20
> [snip]
>>>> +    uint32_t      nr_ends;
>>>> +    XiveENDSource end_source;
>>>> +
>>>> +    /* Interrupt controller registers */
>>>> +    uint64_t      regs[0x300];
>>>> +
>>>> +    /* Can be configured by FW */
>>>> +    uint32_t      tctx_chipid;
>>>> +    uint32_t      chip_id;
>>>
>>> Can't you derive that since you have a pointer to the owning chip?
>>
>> Not always, there are register fields to purposely override this value=
.
>> I can improve the current code a little I think.
>=20
> Ok.
>=20
> [snip]
>>>> +/*
>>>> + * Virtual structures table (VST)
>>>> + */
>>>> +typedef struct XiveVstInfo {
>>>> +    uint32_t    type;
>>>> +    const char *name;
>>>> +    uint32_t    size;
>>>> +    uint32_t    max_blocks;
>>>> +} XiveVstInfo;
>>>> +
>>>> +static const XiveVstInfo vst_infos[] =3D {
>>>> +    [VST_TSEL_IVT]  =3D { VST_TSEL_IVT,  "EAT",  sizeof(XiveEAS), 1=
6 },
>>>
>>> I don't love explicitly storing the type/index in each record, as wel=
l
>>> as it being implicit in the table slot.
>>
>> The 'vst_infos' table decribes the different table types and the 'type=
'=20
>> field is used to index the runtime table of VSDs. See
>> pnv_xive_vst_addr()
>=20
> Yes, I know what it's for but it's still redundant information.  You
> could avoid it, for example, by passing around an index instead of a
> pointer to a vst_infos[] slot - then you can look up both vst_infos
> and the other table using that index.

:) This is exactly what the code was doing before and I thought passing=20
the pointer was cleaner ! No problem. This is minor. I will revert.

> [snip]
>>>> +    case CQ_TM1_BAR: /* TM BAR. 4 pages. Map only once */
>>>> +    case CQ_TM2_BAR: /* second TM BAR. for hotplug. Not modeled */
>>>> +        xive->tm_shift =3D val & CQ_TM_BAR_64K ? 16 : 12;
>>>> +        if (!(val & CQ_TM_BAR_VALID)) {
>>>> +            xive->tm_base =3D 0;
>>>> +            if (xive->regs[reg] & CQ_TM_BAR_VALID && xive->chip_id =
=3D=3D 0) {
>>>> +                memory_region_del_subregion(sysmem, &xive->tm_mmio)=
;
>>>> +            }
>>>> +        } else {
>>>> +            xive->tm_base =3D val & ~(CQ_TM_BAR_VALID | CQ_TM_BAR_6=
4K);
>>>> +            if (!(xive->regs[reg] & CQ_TM_BAR_VALID) && xive->chip_=
id =3D=3D 0) {
>>>> +                memory_region_add_subregion(sysmem, xive->tm_base,
>>>> +                                            &xive->tm_mmio);
>>>> +            }
>>>> +        }
>>>> +        break;
>>>> +
>>>> +    case CQ_PC_BARM:
>>>> +        xive->regs[reg] =3D val;
>>>
>>> As discussed elsewhere, this seems to be a big mix of writing things
>>> directly into regs[reg] and doing other things instead, and you reall=
y
>>> want to go one way or the other.  I'd suggest dropping xive->regs[]
>>> and instead putting the state you need persistent into its own
>>> variables.
>>
>> I made a big effort to introduce helper routines to avoid storing valu=
es=20
>> that can be calculated under the PnvXive model, as you asked for it.=20
>> The assignment above is only necessary for the pnv_xive_pc_size() belo=
w
>> and I don't know how handle this current case without duplicating the=20
>> switch statement, which I think is ugly.
>=20
> I'm not sure quite what you mean about duplicating the case.
>> The point here is that since you're only storing in a couple of the
> switch cases, you can just have explicit data backing just those
> values and write to those in the switch cases instead of having a
> great big regs[] array of which only a few bits are used.

The model uses these registers :

    xive->regs[PC_GLOBAL_CONFIG >> 3]
    xive->regs[CQ_VC_BARM >> 3]
    xive->regs[CQ_PC_BARM >> 3]
    xive->regs[CQ_TAR >> 3]
    xive->regs[VC_GLOBAL_CONFIG >> 3]
    xive->regs[VC_VSD_TABLE_ADDR >> 3]);
    xive->regs[CQ_IC_BAR]
    xive->regs[CQ_TM1_BAR]
    xive->regs[CQ_VC_BAR]
    xive->regs[PC_THREAD_EN_REG0 >> 3]
    xive->regs[PC_THREAD_EN_REG1 >> 3]
    xive->regs[(VC_EQC_CWATCH_DAT0 >> 3) + i];
    xive->regs[(PC_VPC_CWATCH_DAT0 >> 3) + i]
    xive->regs[VC_EQC_CONFIG];
    xive->regs[VC_EQC_SCRUB_TRIG]
    xive->regs[PC_AT_KILL];
    xive->regs[VC_AT_MACRO_KILL]
    xive->regs[(PC_TCTXT_INDIR0 >> 3) + i]

The regs array is useful for the different cache watch but apart=20
from that, yes, we could use independent fields. I will see how much=20
energy I have to put into this change.=20

All the registers change in P10, may be this will be a better time
to share a common PnvXive model and isolate the HW interface of each
processor.

>> So, I will keep the xive->regs[] and make the couple of fixes still ne=
eded.
>=20
> [snip]
>>>> +/*
>>>> + * Virtualization Controller MMIO region containing the IPI and END=
 ESB pages
>>>> + */
>>>> +static uint64_t pnv_xive_vc_read(void *opaque, hwaddr offset,
>>>> +                                 unsigned size)
>>>> +{
>>>> +    PnvXive *xive =3D PNV_XIVE(opaque);
>>>> +    uint64_t edt_index =3D offset >> pnv_xive_edt_shift(xive);
>>>> +    uint64_t edt_type =3D 0;
>>>> +    uint64_t edt_offset;
>>>> +    MemTxResult result;
>>>> +    AddressSpace *edt_as =3D NULL;
>>>> +    uint64_t ret =3D -1;
>>>> +
>>>> +    if (edt_index < XIVE_TABLE_EDT_MAX) {
>>>> +        edt_type =3D GETFIELD(CQ_TDR_EDT_TYPE, xive->edt[edt_index]=
);
>>>> +    }
>>>> +
>>>> +    switch (edt_type) {
>>>> +    case CQ_TDR_EDT_IPI:
>>>> +        edt_as =3D &xive->ipi_as;
>>>> +        break;
>>>> +    case CQ_TDR_EDT_EQ:
>>>> +        edt_as =3D &xive->end_as;
>>>
>>> I'm not entirely understanding the function of these AddressSpace obj=
ectz.
>>
>> The IPI and END ESB pages are exposed in the same VC region. But this =
VC=20
>> region is not splitted between the two types with a single offset. It=20
>> is segmented with the EDT tables which defines the type of each segmen=
t.=20
>>
>> The purpose of these address spaces is to translate the load/stores in=
=20
>> the VC region in the equivalent IPI or END region exposing contigously=
=20
>> ESB pages of the same type: 'end_edt_mmio' and 'ipi_edt_mmio'.=20
>>
>> The memory regions of the XiveENDSource and the XiveSource for the IPI=
s=20
>> are mapped in 'end_edt_mmio' and 'ipi_edt_mmio'.
>=20
> Hmm.  Ok, I'm not immediately seeing why you can't map the various IPI
> or END blocks directly into address_space memory rather than having
> this extra internal layer of indirection.

I think I see what you mean.

You would get rid of the intermediate MR &xive->ipi_edt_mmio and map=20
directly &xsrc->esb_mmio into &xive->ipi_mmio

same for the ENDs, map directly &end_xsrc->esb_mmio in &xive->end_mmio

That might be overkill indeed. I will check.

>> (This is changing for P10, should be simpler)  =20
>=20
> [snip]
>>>> +/*
>>>> + *  Maximum number of IRQs and ENDs supported by HW
>>>> + */
>>>> +#define PNV_XIVE_NR_IRQS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K=
_2PAGE))
>>>> +#define PNV_XIVE_NR_ENDS (PNV9_XIVE_VC_SIZE / (1ull << XIVE_ESB_64K=
_2PAGE))
>>>> +
>>>> +static void pnv_xive_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    PnvXive *xive =3D PNV_XIVE(dev);
>>>> +    XiveSource *xsrc =3D &xive->source;
>>>> +    XiveENDSource *end_xsrc =3D &xive->end_source;
>>>> +    Error *local_err =3D NULL;
>>>> +    Object *obj;
>>>> +
>>>> +    obj =3D object_property_get_link(OBJECT(dev), "chip", &local_er=
r);
>>>> +    if (!obj) {
>>>> +        error_propagate(errp, local_err);
>>>> +        error_prepend(errp, "required link 'chip' not found: ");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* The PnvChip id identifies the XIVE interrupt controller. */
>>>> +    xive->chip =3D PNV_CHIP(obj);
>>>> +
>>>> +    /*
>>>> +     * Xive Interrupt source and END source object with the maximum
>>>> +     * allowed HW configuration. The ESB MMIO regions will be resiz=
ed
>>>> +     * dynamically when the controller is configured by the FW to
>>>> +     * limit accesses to resources not provisioned.
>>>> +     */
>>>> +    object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irq=
s",
>>>> +                            &error_fatal);
>>>
>>> You have a constant here, but your router object also includes a
>>> nr_irqs field.  What's up with that?
>>
>> The XiveSource object of PnvXive is realized for the maximum size allo=
wed
>> by HW because we don't know how much IRQs the FW will provision for.
>>
>> The 'nr_irqs' is the number of IRQs configured by the FW (We changed t=
he
>> name to 'nr_ipis') See routine pnv_xive_vst_set_exclusive()
>=20
> Ah, ok.
>=20

I will try to get that done for 4.0.=20

PSI and LPC P9 models should be less complex to review. =20

Thanks,

C.
