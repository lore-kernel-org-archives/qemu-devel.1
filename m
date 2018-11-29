Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSOED-0001NJ-9t
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSOE8-0002DP-MF
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:27:45 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:37525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSOE8-0002C3-5E
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:27:40 -0500
Received: from player758.ha.ovh.net (unknown [10.109.143.24])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 509831076C6
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:27:38 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-12-clg@kaod.org>
	<20181128023902.GU2251@umbus.fritz.box>
	<dbd8810e-09b9-7344-92d2-faddebf30c10@kaod.org>
	<20181129010047.GM2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cde0bf38-a766-deab-8d46-41fa7e776185@kaod.org>
Date: Thu, 29 Nov 2018 16:27:31 +0100
MIME-Version: 1.0
In-Reply-To: <20181129010047.GM2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 11/36] spapr/xive: use the VCPU id as a
 NVT identifier
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

[ ... ] 

>>>> +/*
>>>> + * The allocation of VP blocks is a complex operation in OPAL and the
>>>> + * VP identifiers have a relation with the number of HW chips, the
>>>> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
>>>> + * controller model does not have the same constraints and can use a
>>>> + * simple mapping scheme of the CPU vcpu_id
>>>> + *
>>>> + * These identifiers are never returned to the OS.
>>>> + */
>>>> +
>>>> +#define SPAPR_XIVE_VP_BASE 0x400
>>>
>>> 0x400 == 1024.  Could we ever have the possibility of needing to
>>> consider both physical NVTs and PAPR NVTs at the same time?  
>>
>> They would not be in the same CAM line: OS ring vs. PHYS ring. 
> 
> Hm.  They still inhabit the same NVT number space though, don't they?

No. skiboot reserves the range of VPs for the HW at init.

https://github.com/open-power/skiboot/blob/master/hw/xive.c#L1093

> I'm thinking about the END->NVT stage of the process here, rather than
> the NVT->TCTX stage.
>
> Oh, also, you're using "VP" here which IIUC == "NVT".  Can we
> standardize on one, please.

VP is used in Linux/KVM Linux/Native and skiboot. Yes. it's a mess. 
Let's have consistent naming in QEMU and use NVT. 

>>> If so, does this base leave enough space for the physical ones?
>>
>> I only used 0x400 to map the VP identifier to the ones allocated by KVM. 
>> 0x0 would be fine but to exercise the model, it's better having a different 
>> base. 
>>
>>>> +uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt_blk,
>>>> +                                  uint32_t nvt_idx)
>>>> +{
>>>> +    return nvt_idx - SPAPR_XIVE_VP_BASE;
>>>> +}
>>>> +
>>>> +int spapr_xive_cpu_to_nvt(sPAPRXive *xive, PowerPCCPU *cpu,
>>>> +                          uint8_t *out_nvt_blk, uint32_t *out_nvt_idx)
>>>
>>> A number of these conversions will come out a bit simpler if we pass
>>> the block and index around as a single word in most places.
>>
>> Yes I have to check the whole patchset first. These prototype changes
>> are not too difficult in terms of code complexity but they do break
>> how patches apply and PowerNV is also using the idx and blk much more 
>> explicitly. the block has a meaning on bare metal. So I am a bit 
>> reluctant to do so. I will check.
> 
> Yeah, based on your comments here and earlier, I'm not sure that's a
> good idea any more either.
> 
>>>> +{
>>>> +    XiveRouter *xrtr = XIVE_ROUTER(xive);
>>>> +
>>>> +    if (!cpu) {
>>>> +        return -1;
>>>> +    }
>>>> +
>>>> +    if (out_nvt_blk) {
>>>> +        /* For testing purpose, we could use 0 for nvt_blk */
>>>> +        *out_nvt_blk = xrtr->chip_id;
>>>
>>> I don't see any point using the chip_id here, which is currently
>>> always set to 0 for PAPR anyway.  If we just hardwire this to 0 it
>>> removes the only use here of xrtr, which will allow some further
>>> simplifications in the caller, I think.
>>
>> You are right about the simplification. It was one way to exercise 
>> the router model and remove any shortcuts in the indexing. I kept 
>> it to be sure I was not tempted to invent new ones. I think we can
>> remove it before merging. 
>>
>>>
>>>> +    }
>>>> +
>>>> +    if (out_nvt_blk) {
>>>> +        *out_nvt_idx = SPAPR_XIVE_VP_BASE + cpu->vcpu_id;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int spapr_xive_target_to_nvt(sPAPRXive *xive, uint32_t target,
>>>> +                             uint8_t *out_nvt_blk, uint32_t *out_nvt_idx)
>>>
>>> I suspect some, maybe most of these conversion functions could be static.
>>
>> static inline ? 
> 
> It's in a .c file so you don't need the "inline" - the compiler can
> work out whether it's a good idea to inline on its own.

It is used in the hcall file also. But we are going to change that.

Thanks,

C.

> 
>>>
>>>> +{
>>>> +    return spapr_xive_cpu_to_nvt(xive, spapr_find_cpu(target), out_nvt_blk,
>>>> +                                 out_nvt_idx);
>>>> +}
>>>> +
>>>> +/*
>>>> + * sPAPR END indexing uses a simple mapping of the CPU vcpu_id, 8
>>>> + * priorities per CPU
>>>> + */
>>>> +int spapr_xive_end_to_target(sPAPRXive *xive, uint8_t end_blk, uint32_t end_idx,
>>>> +                             uint32_t *out_server, uint8_t *out_prio)
>>>> +{
>>>> +    if (out_server) {
>>>> +        *out_server = end_idx >> 3;
>>>> +    }
>>>> +
>>>> +    if (out_prio) {
>>>> +        *out_prio = end_idx & 0x7;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int spapr_xive_cpu_to_end(sPAPRXive *xive, PowerPCCPU *cpu, uint8_t prio,
>>>> +                          uint8_t *out_end_blk, uint32_t *out_end_idx)
>>>> +{
>>>> +    XiveRouter *xrtr = XIVE_ROUTER(xive);
>>>> +
>>>> +    if (!cpu) {
>>>> +        return -1;
>>>
>>> Is there ever a reason this would be called with cpu == NULL?  If not
>>> might as well just assert() here rather than pushing the error
>>> handling back to the caller.
>>
>> ok. yes.
>>
>>>
>>>> +    }
>>>> +
>>>> +    if (out_end_blk) {
>>>> +        /* For testing purpose, we could use 0 for nvt_blk */
>>>> +        *out_end_blk = xrtr->chip_id;
>>>
>>> Again, I don't see any point to using the chip_id, which is pretty
>>> meaningless for PAPR.
>>>
>>>> +    }
>>>> +
>>>> +    if (out_end_idx) {
>>>> +        *out_end_idx = (cpu->vcpu_id << 3) + prio;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +int spapr_xive_target_to_end(sPAPRXive *xive, uint32_t target, uint8_t prio,
>>>> +                             uint8_t *out_end_blk, uint32_t *out_end_idx)
>>>> +{
>>>> +    return spapr_xive_cpu_to_end(xive, spapr_find_cpu(target), prio,
>>>> +                                 out_end_blk, out_end_idx);
>>>> +}
>>>> +
>>>>  static const VMStateDescription vmstate_spapr_xive_end = {
>>>>      .name = TYPE_SPAPR_XIVE "/end",
>>>>      .version_id = 1,
>>>> @@ -263,6 +396,9 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>>>>      xrc->set_eas = spapr_xive_set_eas;
>>>>      xrc->get_end = spapr_xive_get_end;
>>>>      xrc->set_end = spapr_xive_set_end;
>>>> +    xrc->get_nvt = spapr_xive_get_nvt;
>>>> +    xrc->set_nvt = spapr_xive_set_nvt;
>>>> +    xrc->reset_tctx = spapr_xive_reset_tctx;
>>>>  }
>>>>  
>>>>  static const TypeInfo spapr_xive_info = {
>>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>>> index c49932d2b799..fc6ef5895e6d 100644
>>>> --- a/hw/intc/xive.c
>>>> +++ b/hw/intc/xive.c
>>>> @@ -481,6 +481,7 @@ static uint32_t xive_tctx_hw_cam_line(XiveTCTX *tctx, bool block_group)
>>>>  static void xive_tctx_reset(void *dev)
>>>>  {
>>>>      XiveTCTX *tctx = XIVE_TCTX(dev);
>>>> +    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(tctx->xrtr);
>>>>  
>>>>      memset(tctx->regs, 0, sizeof(tctx->regs));
>>>>  
>>>> @@ -495,6 +496,14 @@ static void xive_tctx_reset(void *dev)
>>>>       */
>>>>      tctx->regs[TM_QW1_OS + TM_PIPR] =
>>>>          ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
>>>> +
>>>> +    /*
>>>> +     * QEMU sPAPR XIVE only. To let the controller model reset the OS
>>>> +     * CAM line with the VP identifier.
>>>> +     */
>>>> +    if (xrc->reset_tctx) {
>>>> +        xrc->reset_tctx(tctx->xrtr, tctx);
>>>> +    }
>>>
>>> AFAICT this whole function is only used from PAPR, so you can just
>>> move the whole thing to the papr code and avoid the hook function.
>>
>> Yes we could add a loop on all CPUs and reset all the XiveTCTX from
>> the machine or a spapr_irq->reset handler. We will need at some time
>> anyhow.
>>
>> Thanks,
>>
>> C.
>>
>>
>>>
>>>>  }
>>>>  
>>>>  static void xive_tctx_realize(DeviceState *dev, Error **errp)
>>>
>>
> 
