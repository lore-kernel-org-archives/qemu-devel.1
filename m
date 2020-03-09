Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A0C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7712D20675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7712D20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBGpZ-00083U-MP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBGou-0007f1-DY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBGoq-0004uP-Gp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:43:39 -0400
Received: from mail.sysgo.com ([176.9.12.79]:57720)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBGop-0004uE-Va
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:43:36 -0400
Subject: Re: [PATCH] vfio: avoid SET_ACTION_TRIGGER ioctls
To: qemu-devel@nongnu.org
References: <20200228120800.5979-1-rka@sysgo.com>
 <20200305153735.238a9ddd@w520.home>
From: Roman Kapl <roman.kapl@sysgo.com>
Message-ID: <734a8a2f-4659-c0e3-8c6f-8df8a3b6a75a@sysgo.com>
Date: Mon, 9 Mar 2020 12:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <20200305153735.238a9ddd@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 176.9.12.79
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/5/20 11:37 PM, Alex Williamson wrote:
> On Fri, 28 Feb 2020 13:08:00 +0100
> Roman Kapl <rka@sysgo.com> wrote:
> 
>> For MSI-X interrupts, remember what the last used eventfd was (KVM
>> bypass vs QEMU) and only call vfio_set_irq_signaling if it has changed.
>>
>> This not only helps with performance, but it seems that interrupts can
>> be lost during VFIO_IRQ_SET_ACTION_TRIGGER. With the 'x-no-kvm-msix'
>> switch and this patch, SET_ACTION_TRIGGER is not called during
>> mask/unmask. This really only affects guests that actively use MSI-X masking.
>>
>> Signed-off-by: Roman Kapl <rka@sysgo.com>
>> ---
>>
>> This patch scratches my particular itch. I am able to get our guest (which masks
>> MSI on each interrupt) running, without getting randomly stuck on waiting for
>> interrupt. However, the solution is far from perfect (x-no-kvm-msix is required)
>> and pretty slow. I would be interested in hearing any ideas how to improve this.
>> Some ideas:
>>
>> 1) Fix the kernel so that SET_ACTION_TRIGGER does not loose interrupts (I think
>> the problem is there, but not 100% sure). I've tested on 5.3.0-40-generic
>> #32~18.04.1-Ubuntu SMP.
> 
> I'd be curious if this (yet unmerged) series resolve this:
> 
> https://lore.kernel.org/lkml/cover.1567394624.git.luoben@linux.alibaba.com/

Indeed it does. Thanks for pointing out this patch. This seems to nicely 
fix the underlying issue and thus QEMU now work both with and without 
KVM bypass.

>   
>> 2) Add support for MASK/UNMASK for MSI-X in kernel and use that. But I don't
>> know how to do PBA in that case. Another IOCTL? We could look at the real PBA
>> array, if mapping is supported, but that seems hacky.
> 
> That lack of a masking API in the host kernel is part of the reason we
> take the hacky approach of emulating the PBA in QEMU.  We could have
> the PBA MemoryRegion do a pread() from the device, but if we're doing
> some ioctls on every un/mask, we're probably already digging ourselves
> out of a hole.
> 
> It would be interesting to see if the series above prevents dropping
> interrupts, how it compares with the reduced ioctls + QEMU handling you
> have here.

Unfortunately I was not able to get any reasonable performance data 
here, because in the interrupt latency seems to be pretty bad (cca 1.5ms 
- 2ms) in all three options I've tried: no-KVM-bypass, KVM-bypass, 
no-KVM-bypass + my patch). So saving one IOCTL does not really make a 
dent in that.

If I will be able to find out why the latency is so bad, or reduce it, I 
will get back.

> 
>> 3) Twiddle the bits behing kernel's back, if it can be mapped?
> 
> I'm not sure what you're thinking here, you mean mask vectors directly
> on the device w/o a host kernel masking API and then read the PBA
> directly from the device, mapping it directly to the guest if possible?
> The MSI-X MMIO space can be mmapped by QEMU, we rely on interrupt
> remmappers to protect us from malicious users.  QEMU certainly
> shouldn't touch the vector or data fields, but masking might be
> reasonably safe, then we could leave the KVM route in place.  I'm
> afraid it might be difficult to integrate with QEMU MSI-X support
> though.

Yes, that's what I was thinking. But that's just an idea.

> 
>> Still, I think this patch does not hurt anything and could be applied if no-one
>> can think of a better way.
>>
>> ---
>>
>>   hw/vfio/pci.c | 32 ++++++++++++++++++++++----------
>>   hw/vfio/pci.h |  2 ++
>>   2 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index e6569a7968..5f7ce91519 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -390,12 +390,16 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
>>            * MSI-X mask and pending bits are emulated, so we want to use the
>>            * KVM signaling path only when configured and unmasked.
>>            */
>> -        if (vdev->msi_vectors[i].use) {
>> -            if (vdev->msi_vectors[i].virq < 0 ||
>> -                (msix && msix_is_masked(&vdev->pdev, i))) {
>> -                fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
>> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
>> +        if (vector->use) {
>> +            if (vector->virq < 0 ||
>> +                (msix && msix_is_masked(&vdev->pdev, i)))
>> +            {
>> +                vector->kvm_path_active = false;
>> +                fd = event_notifier_get_fd(&vector->interrupt);
>>               } else {
>> -                fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
>> +                vector->kvm_path_active = true;
>> +                fd = event_notifier_get_fd(&vector->kvm_interrupt);
>>               }
>>           }
>>   
>> @@ -509,17 +513,23 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>       } else {
>>           Error *err = NULL;
>>           int32_t fd;
>> +        bool kvm_path;
>>   
>>           if (vector->virq >= 0) {
>>               fd = event_notifier_get_fd(&vector->kvm_interrupt);
>> +            kvm_path = true;
>>           } else {
>>               fd = event_notifier_get_fd(&vector->interrupt);
>> +            kvm_path = false;
>>           }
>>   
>> -        if (vfio_set_irq_signaling(&vdev->vbasedev,
>> -                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
>> -                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> -            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +        if (vector->kvm_path_active != kvm_path) {
>> +            if (vfio_set_irq_signaling(&vdev->vbasedev,
>> +                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
>> +                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>> +                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +            }
>> +            vector->kvm_path_active = kvm_path;
> 
> 
> Wouldn't this be more intuitive if we just cached the current fd on the
> VFIOMSIVector object and created a vfio_set_irq_signaling() wrapper for
> vectors that only calls through when the fd changes, updating the fd on
> successful return otherwise?  AIUI, you're only trying to prevent
> gratuitous calls to vfio_set_irq_signaling() when the eventfd remains
> unchanged, which is the common case for your configuration of running
> in QEMU interrupt mode.  Thanks,

I am not against that. If we decide to apply the patch, I can replace 
the two call sites with the wrapper. It's not applicable in 
vfio_enable_vectors.

> 
> Alex

Thanks for comments, Roman Kapl

> 
>>           }
>>       }
>>   
>> @@ -555,13 +565,15 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>        * core will mask the interrupt and set pending bits, allowing it to
>>        * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
>>        */
>> -    if (vector->virq >= 0) {
>> +    if (vector->virq >= 0 && vector->kvm_path_active) {
>>           int32_t fd = event_notifier_get_fd(&vector->interrupt);
>>           Error *err = NULL;
>>   
>>           if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
>>                                      VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>>               error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> +        } else {
>> +            vector->kvm_path_active = false;
>>           }
>>       }
>>   }
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index b329d50338..b01d2676cf 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -91,6 +91,8 @@ typedef struct VFIOMSIVector {
>>        */
>>       EventNotifier interrupt;
>>       EventNotifier kvm_interrupt;
>> +    /* Set when the trigger action is set to the KVM bypass FD */
>> +    bool kvm_path_active;
>>       struct VFIOPCIDevice *vdev; /* back pointer to device */
>>       int virq;
>>       bool use;
> 
> 

