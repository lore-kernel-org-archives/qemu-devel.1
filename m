Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fvH3I-00014D-6v
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 03:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fvH3H-0007LW-6v
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 03:07:36 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:36275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fvH3E-0007J5-DC
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 03:07:34 -0400
Received: by mail-yb0-x244.google.com with SMTP id d34-v6so3029247yba.3
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 00:07:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 30 Aug 2018 15:07:29 +0800
Message-ID: <CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 29 August 2018 at 21:42, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Aug 29, 2018 at 05:17:20PM +0800, Hongbo Zhang wrote:
>> On 17 August 2018 at 21:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>> > On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> >> For the Aarch64, there is one machine 'virt', it is primarily meant to
>> >> run on KVM and execute virtualization workloads, but we need an
>> >> environment as faithful as possible to physical hardware, for supporting
>> >> firmware and OS development for pysical Aarch64 machines.
>> >>
>> >> This patch introduces new machine type 'Enterprise' with main features:
>> >>  - Based on 'virt' machine type.
>> >>  - Re-designed memory map.
>> >>  - EL2 and EL3 are enabled by default.
>> >>  - GIC version 3 by default.
>> >>  - AHCI controller attached to system bus, and then CDROM and hard disc
>> >>    can be added to it.
>> >>  - EHCI controller attached to system bus, with USB mouse and key board
>> >>    installed by default.
>> >>  - E1000E ethernet card on PCIE bus.
>> >>  - VGA display adaptor on PCIE bus.
>> >>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>> >>  - No virtio functions enabled, since this is to emulate real hardware.
>> >>  - No paravirtualized fw_cfg device either.
>> >>
>> >> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>> >>
>> >> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> >> ---
>> >> Changes since v1:
>> >>  - rebase on v3.0.0-rc0
>> >>  - introduce another auxillary patch as 1/2, so this is 2/2
>> >>  - rename 'sbsa' to 'enterprise'
>> >>  - remove paravirualized fw_cfg
>> >>  - set gic_vertion to 3 instead of 2
>> >>  - edit commit message to describe purpose of this platform
>> >
>> > Hi; there's been a lot of discussion on this thread. I'm going
>> > to assume that you don't need any further review commentary for
>> > the moment, and will wait for a v3. If there are any specific
>> > questions you want guidance on to produce that v3, let me know.
>> >
>> Thank you for this summary/remind.
>> Sorry for the late reply due to my vacation last week.
>>
>> Yes, I am working on the v3, with main changes:
>>  - machine name "sbsa-ref" (good name?)
>>  - a separate file sbsa-ref.c
>>  - don't touch the acpi c file, acpi will be supplied by uefi
>
> I agree with the above three bullets.
>
>>  - only necessary dt node, no other peripheral dt nodes
>
> I'm not sure what DT nodes are necessary. After discussing the
> ACPI tables, and that firmware would supply them, I thought we
> also agreed firmware would supply the DTB.
>
Yes, firmware supply ACPI to load OS.
But for DT, It is said that UEFI still needs some DT nodes, at least
for memory size. I am trying to figure out which DT nodes are
mandatory too, it is better we don't have any DT nodes left.

@Ard, @Leif, is there any possibility to remove all the DT nodes?
On real hardware, how does UEFI find the memory size and CPU number?

> Thanks,
> drew
>
>>
>> Before my sending, I still like comments on the above effort, it is
>> feasible/reasonable or not etc, in case I go wrong too much.
>>
>> I also know that some reviewers may like to give comments when they
>> see the patch codes, so if you don't have comments now, you can do it
>> after seeing the patch.
>> Thanks all.
>>
>> > thanks
>> > -- PMM
>>
