Received: from eggs.gnu.org ([2001:4830:134:3::10]:59809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLr34-0002PW-2I
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLr32-0006sA-Td
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:16:58 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLr32-0006ru-O3
	for qemu-devel@nongnu.org; Thu, 24 May 2018 10:16:56 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so2110350oth.8
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 07:16:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
	<1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
	<acca5b80-f527-bc39-0b63-147e53affb4b@redhat.com>
	<CAFEAcA-xbHtxora5TU9psYnBgP0+N8_nznhVppEkg7fmmwip3w@mail.gmail.com>
	<10801e6c-5028-add6-b082-22c5dc9758ca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 15:16:35 +0100
Message-ID: <CAFEAcA-eW_1M42c+Fjt98AgVsnbwjwWap3JZFHNU9f8S0H_qww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>

On 24 May 2018 at 14:59, Auger Eric <eric.auger@redhat.com> wrote:
> Hi,
>
> On 05/24/2018 03:14 PM, Peter Maydell wrote:
>> On 24 May 2018 at 10:04, Auger Eric <eric.auger@redhat.com> wrote:
>>> Now I am unclear about the semantics of the s->gicd_ipriority & friends.
>>> With that change, is it supposed to contain only the states of SPIs or
>>> contain the RAZ states of PPI/SGIs + states of SPIs. The array is
>>> dimensionned to contain states for PPI/SGI+SPIs, right? In other words,
>>> shouldn't we also shift field?
>>
>> The semantics of the gicd_ipriority and other data structures are
>> set by the TCG GIC implementation, and include blank space at
>> the start where the PPI/SGI bits would live. See this comment
>> from arm_gicv3_common.h:
>>
>>  * Each bitmap contains a bit for each interrupt. Although there is
>>  * space for the PPIs and SGIs, those bits (the first 32) are never
>>  * used as that state lives in the redistributor. The unused bits are
>>  * provided purely so that interrupt X's state is always in bit X; this
>>  * avoids bugs where we forget to subtract GIC_INTERNAL from an
>>  * interrupt number.
>
> If I understand Shannon's code correctly, the space for PPIs/SGIs is
> currently overwritten by SPI state, hence my comment.

Only for KVM, not for TCG, and it's the other way round: we
end up with two lots of PPI/SGI space in the data structure
by mistake. Let me fish out the comment I made on the v2 of this
series:

In the code in master, we have QEMU data structures
(bitmaps, etc) which have one entry for each of GICV3_MAXIRQ
irqs. That includes the RAZ/WI unused space for the SPIs/PPIs, so
for a 1-bit-per-irq bitmap:
 [0x00000000, irq 32, irq 33, .... ]

When we fill in the values from KVM into these data structures,
we start after the unused space, because the for_each_dist_irq_reg()
macro starts with _irq = GIC_INTERNAL. But we forgot to adjust
the offset value we use for the KVM access, so we start by
reading the RAZ/WI values from KVM, and the data structure
contents end up with:
 [0x00000000, 0x00000000, irq 32, irq 33, ... ]
(and the last irqs wouldn't get transferred).

With this change to the code we will get the offset right and
the data structure will be filled as
 [0x00000000, irq 32, irq 33, .... ]
For TCG, where we never had this bug, this is how the data
structure has always looked.

But for migration from the old version, the data structure
we receive from the migration source will contain the old
broken layout of
 [0x00000000, 0x00000000, irq 32, irq 33, ... ]

So we need in inbound migration to identify when we need
to fix this up (by copying the data down to get rid of that
extra 0x00000000), which is "when KVM is enabled and the source
is not a version new enough to have fixed this bug".

> If we stick to the
> current semantics, can't we just add the last missing 32 SPI states and
> we don't need the subsection?

You need a subsection, because that's how you get migration
compatibility.

thanks
-- PMM
