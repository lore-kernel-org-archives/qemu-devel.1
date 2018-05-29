Received: from eggs.gnu.org ([2001:4830:134:3::10]:43760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNah2-0002c4-4h
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNah1-0007SR-6j
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:13:24 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:45144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNah0-0007RY-Q5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:13:23 -0400
Received: by mail-ot0-x244.google.com with SMTP id 15-v6so16113366otn.12
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 02:13:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <929ce9c7-afae-7978-ed35-3789fcbf026a@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-4-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8yo_NKY=mHNYFFTA1+eR-731ePUb5hDum0ubUM2XOxxg@mail.gmail.com>
	<929ce9c7-afae-7978-ed35-3789fcbf026a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 10:13:01 +0100
Message-ID: <CAFEAcA-yWBexVnpd9_iicL0o8A3TNZ2ezAf8nrYJ_ZPmB+xocg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 3/7] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 29 May 2018 at 10:08, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
> On 05/22/2018 02:27 PM, Peter Maydell wrote:
>> On 13 May 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
>>> To prepare for multiple redistributor regions, we introduce
>>> an array of uint32_t properties that stores the redistributor
>>> count of each redistributor region.
>>>
>>> Non accelerated VGICv3 only supports a single redistributor region.
>>> The capacity of all redist regions is checked against the number of
>>> vcpus.
>>>
>>> Machvirt is updated to set the count to 123 vcpus for the unique
>>> redistributor region we currently have.

>>> +
>>> +    if (type == 3) {
>>> +        qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
>>> +        qdev_prop_set_uint32(gicdev , "redist-region-count[0]",
>>> +                             vms->memmap[VIRT_GIC_REDIST].size / 0x20000);
>>
>> We used to create a region which had num_cpu redistributors in it;
>> won't this cause us to create one which has as many redistributors
>> as will fit in the space ?
> Is that an issue? From a machine perspective the whole region is
> reserved for rdist. dt and ACPI will expose this whole region and the
> device will use a subset of it? I agree I need to document this change
> in the commit message though.

It's a difference, and a guest-visible difference too. This
patchset is supposed to be introducing split-redistributor-regions,
not changing the behaviour of other configs. Also, I don't think
it makes sense to model a GIC with more redistributors than CPUs:
real hardware doesn't look like that AFAIK.

thanks
-- PMM
