Received: from eggs.gnu.org ([2001:4830:134:3::10]:43224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLrs9-0006cd-8y
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLrs3-0004Wf-De
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:09:45 -0400
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
	<CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
	<10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
	<CAFEAcA-eW_1M42c+Fjt98AgVsnbwjwWap3JZFHNU9f8S0H_qww@mail.gmail.com>
	<38aee779-1baf-ab96-7489-0f34bda2f8e6@redhat.com>
	<CAFEAcA9oCppg2C32vd3YKKmvfO7n1KnFeXG14CV7UHcZpxcTqA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <362b56e4-5e15-d01d-2aae-5efe1aaf661d@redhat.com>
Date: Thu, 24 May 2018 17:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9oCppg2C32vd3YKKmvfO7n1KnFeXG14CV7UHcZpxcTqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

Hi Peter,

On 05/24/2018 04:56 PM, Peter Maydell wrote:
> On 24 May 2018 at 15:40, Auger Eric <eric.auger@redhat.com> wrote:
>> Hi Peter,
>>
>> On 05/24/2018 04:16 PM, Peter Maydell wrote:
>>> Only for KVM, not for TCG, and it's the other way round: we
>>> end up with two lots of PPI/SGI space in the data structure
>>> by mistake. Let me fish out the comment I made on the v2 of this
>>> series:
>>>
>>> In the code in master, we have QEMU data structures
>>> (bitmaps, etc) which have one entry for each of GICV3_MAXIRQ
>>> irqs. That includes the RAZ/WI unused space for the SPIs/PPIs, so
>>> for a 1-bit-per-irq bitmap:
>>>  [0x00000000, irq 32, irq 33, .... ]
>>>
>>> When we fill in the values from KVM into these data structures,
>>> we start after the unused space, because the for_each_dist_irq_reg()
>>> macro starts with _irq = GIC_INTERNAL. But we forgot to adjust
>>> the offset value we use for the KVM access, so we start by
>>> reading the RAZ/WI values from KVM, and the data structure
>>> contents end up with:
>>>  [0x00000000, 0x00000000, irq 32, irq 33, ... ]
>>> (and the last irqs wouldn't get transferred).
>> In kvm_dist_get_priority (new code), the offset is where we read and
>> field is where we write, correct? Offset was shifted so we effectively
>> read in KVM regs the num_irq-32 SPI states now but don't we start
>> writing at the beginning of bmp, (ie s->gicd_ipriority), at PPI/SGI
>> offset? What am I missing?
> 
> Oops, yes, you're right. My explanation applies to the
> various other bitmaps, where we are accessing the
> fields in the data structure using gic_bmp_ptr32(bmp, irq),
> but not to gicd_ipriority[], which we are directly accessing
> starting with the first word, not by indexing via bmp[irq].
> 
> So we need to handle these two cases differently.
> You're correct that for gicd_ipriority[], the code in
> master reads and writes to that data structure as:
>  [0, 0, ..., 0, irq 32, irq 33, ..., 0, 0, ... 0]
> so all the values are in the right place but we:
>  (a) unnecessarily read/write zeroes for the PPI/SGI fields
>  (b) fail to transfer the last 32 interrupts
> 
> We can fix the gicd_ipriority[] case simply by adding
>    bmp = GIC_INTERNAL;
> before the assignment to 'field' in both kvm_dist_get_priority()
> and kvm_dist_put_priority(). This doesn't affect migration
> compatibility. We should do this separately from fixing the
> other bitmaps, because it's simpler.

Agreed for the other bitmaps. I actually stumbled on
kvm_dist_get_priority and got stuck there ;-) So indeed the subsection
is needed.
> 
>> I don't understand you TCG remark above, sorry.
> 
> You can migrate a TCG VM as well as a KVM one. The
> TCG GICv3 doesn't use any of this code in hw/intc/arm_gicv3_kvm.c,
> so it doesn't have any of these bugs. So any fixups for the
> KVM bugs so we get migration correct in the
> "buggy VM" -> "not buggy VM" situation should not misidentify
> a TCG VM as "buggy".

Ah OK. Thank you for the clarification

Eric
> 
> PS: I have a feeling that kvm_dist_get/set_priority have
> an endianness problem -- the 'reg' we read from the kernel
> will be a 32-bit value with the priority byte for the
> lowest-numbered IRQ in its least significant byte, but if
> the host is big-endian we'll write that to the wrong offset
> in the gicd_priority[] array...
> 
> thanks
> -- PMM
> 
