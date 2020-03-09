Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C915C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318A6208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318A6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysgo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKln-0004j3-DP
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBKSs-0005Mf-RL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBKSp-000665-O6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:37:09 -0400
Received: from mail.sysgo.com ([176.9.12.79]:38182)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <roman.kapl@sysgo.com>) id 1jBKSp-00065i-Dp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:37:07 -0400
Subject: Re: [PATCH] vfio: avoid SET_ACTION_TRIGGER ioctls
From: Roman Kapl <roman.kapl@sysgo.com>
To: qemu-devel@nongnu.org
References: <20200228120800.5979-1-rka@sysgo.com>
 <20200305153735.238a9ddd@w520.home>
 <734a8a2f-4659-c0e3-8c6f-8df8a3b6a75a@sysgo.com>
Message-ID: <83e8fbdf-4e11-151c-2ec7-fee699bc0d2d@sysgo.com>
Date: Mon, 9 Mar 2020 16:37:05 +0100
MIME-Version: 1.0
In-Reply-To: <734a8a2f-4659-c0e3-8c6f-8df8a3b6a75a@sysgo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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


On 3/9/20 12:43 PM, Roman Kapl wrote:
> On 3/5/20 11:37 PM, Alex Williamson wrote:
>> On Fri, 28 Feb 2020 13:08:00 +0100
>> Roman Kapl <rka@sysgo.com> wrote:
>>
>>> For MSI-X interrupts, remember what the last used eventfd was (KVM
>>> bypass vs QEMU) and only call vfio_set_irq_signaling if it has change=
d.
>>>
>>> This not only helps with performance, but it seems that interrupts ca=
n
>>> be lost during VFIO_IRQ_SET_ACTION_TRIGGER. With the 'x-no-kvm-msix'
>>> switch and this patch, SET_ACTION_TRIGGER is not called during
>>> mask/unmask. This really only affects guests that actively use MSI-X=20
>>> masking.
>>>
>>> Signed-off-by: Roman Kapl <rka@sysgo.com>
>>> ---
>>>
>>> This patch scratches my particular itch. I am able to get our guest=20
>>> (which masks
>>> MSI on each interrupt) running, without getting randomly stuck on=20
>>> waiting for
>>> interrupt. However, the solution is far from perfect (x-no-kvm-msix=20
>>> is required)
>>> and pretty slow. I would be interested in hearing any ideas how to=20
>>> improve this.
>>> Some ideas:
>>>
>>> 1) Fix the kernel so that SET_ACTION_TRIGGER does not loose=20
>>> interrupts (I think
>>> the problem is there, but not 100% sure). I've tested on=20
>>> 5.3.0-40-generic
>>> #32~18.04.1-Ubuntu SMP.
>>
>> I'd be curious if this (yet unmerged) series resolve this:
>>
>> https://lore.kernel.org/lkml/cover.1567394624.git.luoben@linux.alibaba=
.com/=20
>>
>=20
> Indeed it does. Thanks for pointing out this patch. This seems to nicel=
y=20
> fix the underlying issue and thus QEMU now work both with and without=20
> KVM bypass.
>=20
>>> 2) Add support for MASK/UNMASK for MSI-X in kernel and use that. But=20
>>> I don't
>>> know how to do PBA in that case. Another IOCTL? We could look at the=20
>>> real PBA
>>> array, if mapping is supported, but that seems hacky.
>>
>> That lack of a masking API in the host kernel is part of the reason we
>> take the hacky approach of emulating the PBA in QEMU.=C2=A0 We could h=
ave
>> the PBA MemoryRegion do a pread() from the device, but if we're doing
>> some ioctls on every un/mask, we're probably already digging ourselves
>> out of a hole.
>>
>> It would be interesting to see if the series above prevents dropping
>> interrupts, how it compares with the reduced ioctls + QEMU handling yo=
u
>> have here.
>=20
> Unfortunately I was not able to get any reasonable performance data=20
> here, because in the interrupt latency seems to be pretty bad (cca 1.5m=
s=20
> - 2ms) in all three options I've tried: no-KVM-bypass, KVM-bypass,=20
> no-KVM-bypass + my patch). So saving one IOCTL does not really make a=20
> dent in that.
>=20
> If I will be able to find out why the latency is so bad, or reduce it, =
I=20
> will get back.

Ok, just to recapitulate, with the kernel patch linked above, the only=20
issue now is performance, not corectness.

Using perf, I've found out the bad performance was caused by=20
memory_region_set_enabled(msix_pba_mmio). Simply leaving it enabled had=20
a huge effect (maybe 5x) on my workload.

Second in line is adding x-no-kvm-msix, which has modest impact. I've=20
also tried this proposed patch and I've also removed the unecessary=20
qemu_set_fd_handler. Both have a small impact in comparison

So the priority now would be to avoid the calls to=20
memory_region_set_enabled. I can think of two options:

1) Add a flag, e.g. 'x-pba-always-on' and possibly also 'x-pba-disable'.=20
This is probably the simplest thing to do.

2) Add auto-detection. If the guest tries to switch PBA on/off too many=20
times, just permanently enable it. The same goes for KVM bypass.
'x-pba-disable' flag would still probably be useful for guests where PBA=20
would cause performance degradation, but the guest does not use it.

Any thoughts? Or is there some faster way to toggle the memory region=20
emulation?

Thank you, Roman Kapl

>=20
>>
>>> 3) Twiddle the bits behing kernel's back, if it can be mapped?
>>
>> I'm not sure what you're thinking here, you mean mask vectors directly
>> on the device w/o a host kernel masking API and then read the PBA
>> directly from the device, mapping it directly to the guest if possible=
?
>> The MSI-X MMIO space can be mmapped by QEMU, we rely on interrupt
>> remmappers to protect us from malicious users.=C2=A0 QEMU certainly
>> shouldn't touch the vector or data fields, but masking might be
>> reasonably safe, then we could leave the KVM route in place.=C2=A0 I'm
>> afraid it might be difficult to integrate with QEMU MSI-X support
>> though.
>=20
> Yes, that's what I was thinking. But that's just an idea.
>=20
>>
>>> Still, I think this patch does not hurt anything and could be applied=
=20
>>> if no-one
>>> can think of a better way.
>>>
>>> ---
>>>
>>> =C2=A0 hw/vfio/pci.c | 32 ++++++++++++++++++++++----------
>>> =C2=A0 hw/vfio/pci.h |=C2=A0 2 ++
>>> =C2=A0 2 files changed, 24 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index e6569a7968..5f7ce91519 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -390,12 +390,16 @@ static int vfio_enable_vectors(VFIOPCIDevice=20
>>> *vdev, bool msix)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * MSI-X =
mask and pending bits are emulated, so we want to=20
>>> use the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * KVM si=
gnaling path only when configured and unmasked.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vdev->msi_vectors[i].=
use) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (vdev->msi_vectors[i].virq < 0 ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (msix && msix_is_masked(&vdev->pdev, i))) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fd =3D=20
>>> event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOMSIVector *vector =3D=
 &vdev->msi_vectors[i];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vector->use) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (vector->virq < 0 ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (msix && msix_is_masked(&vdev->pdev, i)))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vector->kvm_path_active =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fd =3D event_notifier_get_fd(&vector->interrupt);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fd =3D=20
>>> event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vector->kvm_path_active =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fd =3D event_notifier_get_fd(&vector->kvm_interrupt=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -509,17 +513,23 @@ static int vfio_msix_vector_do_use(PCIDevice=20
>>> *pdev, unsigned int nr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D=
 NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t fd;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool kvm_path;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vector->vi=
rq >=3D 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fd =3D event_notifier_get_fd(&vector->kvm_interrupt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
vm_path =3D true;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fd =3D event_notifier_get_fd(&vector->interrupt);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k=
vm_path =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vfio_set_irq_signalin=
g(&vdev->vbasedev,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
VFIO_PCI_MSIX_IRQ_INDEX, nr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
VFIO_IRQ_SET_ACTION_TRIGGER,=20
>>> fd, &err)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_reportf_err(err, VFIO_MSG_PREFIX,=20
>>> vdev->vbasedev.name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vector->kvm_path_acti=
ve !=3D kvm_path) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (vfio_set_irq_signaling(&vdev->vbasedev,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 VFIO_PCI_MSIX_IRQ_INDEX, nr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 VFIO_IRQ_SET_ACTION_TRIGGER,=20
>>> fd, &err)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(err, VFIO_MSG_PREFIX,=20
>>> vdev->vbasedev.name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
ector->kvm_path_active =3D kvm_path;
>>
>>
>> Wouldn't this be more intuitive if we just cached the current fd on th=
e
>> VFIOMSIVector object and created a vfio_set_irq_signaling() wrapper fo=
r
>> vectors that only calls through when the fd changes, updating the fd o=
n
>> successful return otherwise?=C2=A0 AIUI, you're only trying to prevent
>> gratuitous calls to vfio_set_irq_signaling() when the eventfd remains
>> unchanged, which is the common case for your configuration of running
>> in QEMU interrupt mode.=C2=A0 Thanks,
>=20
> I am not against that. If we decide to apply the patch, I can replace=20
> the two call sites with the wrapper. It's not applicable in=20
> vfio_enable_vectors.
>=20
>>
>> Alex
>=20
> Thanks for comments, Roman Kapl
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> @@ -555,13 +565,15 @@ static void vfio_msix_vector_release(PCIDevice=20
>>> *pdev, unsigned int nr)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * core will mask the interrupt a=
nd set pending bits, allowing=20
>>> it to
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be re-asserted on unmask.=C2=A0=
 Nothing to do if already using=20
>>> QEMU mode.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 if (vector->virq >=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0 if (vector->virq >=3D 0 && vector->kvm_path_activ=
e) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int32_t fd =3D=
 event_notifier_get_fd(&vector->interrupt);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D=
 NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vfio_set_i=
rq_signaling(&vdev->vbasedev,=20
>>> VFIO_PCI_MSIX_IRQ_INDEX, nr,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
VFIO_IRQ_SET_ACTION_TRIGGER, fd,=20
>>> &err)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_reportf_err(err, VFIO_MSG_PREFIX,=20
>>> vdev->vbasedev.name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
ector->kvm_path_active =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index b329d50338..b01d2676cf 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -91,6 +91,8 @@ typedef struct VFIOMSIVector {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EventNotifier interrupt;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EventNotifier kvm_interrupt;
>>> +=C2=A0=C2=A0=C2=A0 /* Set when the trigger action is set to the KVM =
bypass FD */
>>> +=C2=A0=C2=A0=C2=A0 bool kvm_path_active;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct VFIOPCIDevice *vdev; /* back po=
inter to device */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int virq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool use;
>>
>>
>=20

