Received: from eggs.gnu.org ([2001:4830:134:3::10]:32883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1ficTT-00059I-Lw
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1ficTQ-0006B1-L2
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:22:19 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:51003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1ficTQ-0006AD-En
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 05:22:16 -0400
Received: by mail-it0-x243.google.com with SMTP id w16-v6so1840329ita.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 02:22:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725112621.imdzdkntpmh3n5og@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725112621.imdzdkntpmh3n5og@kamzik.brq.redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 26 Jul 2018 17:22:14 +0800
Message-ID: <CAHmQWvCfHFSU7RGKG5t6=m7ZSWZjf3TeqOo3cX2KT-GSiN3mPw@mail.gmail.com>
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

On 25 July 2018 at 19:26, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Jul 25, 2018 at 06:22:17PM +0800, Hongbo Zhang wrote:
>> On 25 July 2018 at 17:54, Andrew Jones <drjones@redhat.com> wrote:
>> > On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
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
>> >
>> > In the last review it was pointed out that using virtio-pci should still
>> > be "real" enough, so there's not much reason to avoid it. Well, unless
>> > there's some concern as to what drivers are available in the firmware and
>> > guest kernel. But that concern usually only applies to legacy firmwares
>> > and kernels, and therefore shouldn't apply to AArch64.
>> >
>> In real physical arm hardware, *HCI are system memory mapped, not on PCIE.
>> we need a QEMU platform like that. We need firmware developed on this
>> QEMU platform can run on real hardware without change(or only a minor
>> change)
>
> virtio-pci has nothing to do with *HCI. You're adding an E1000e to the
> PCIe bus instead of a virtio-pci nic. Why?
>
No virtio devices are need on this platform, so no virtio-pci either,
on the real Arm server hardware, a NIC is inserted into PCIE, and
E1000E is a typical one.

>> Concern is not only available firmwares, but more emphasis is on new
>> firmwares to be developed on this platform (target is developing
>> firmware for hardware, but using qemu if hardware is not available
>> temporarily), if virtio device used, then the newly developed firmware
>> must include virtio front-end codes, but it isn't needed while run on
>> real hardware at last.
>
> Right. The new firmwares and kernels would need to include virtio-pci nic
> and scsi drivers. Is that a problem? Anyway, this is all the more reason
> not to hard code peripherals. If a particular peripheral is a problem
> for a given firmware, then simply don't add it to the command line, add a
> different one.
>
Yes that is problem, for newly developed firmwares, extra efforts will
be wasted on frontend codes (or glue-layer, whatever we call it), we
want firmwares developed on this platform can run easily on real
hardware, without such change.
Requirement is: some Linaro members just want a qemu platform as true
as possible with real hardware, there should be no problem with such
requirement, problem is 'virt' machine cannot satisfy the requirement,
so a new one is needed.

>>
>> >>  - No paravirtualized fw_cfg device either.
>> >>
>> >> Arm Trusted Firmware and UEFI porting to this are done accordingly.
>> >>
>> >
>> > How will UEFI get the ACPI tables from QEMU without fw-cfg? I didn't
>> > see any sort of reserved ROM region in the patch for them.
>> >
>> UEFI gets ACPI and kernel from network or mass storage, just like the
>> real hardware.
>
> Hmm. I thought for real hardware that the ACPI tables were built into
> the firmware. So, assuming UEFI knows how to read ACPI tables from
> some storage, then how do the QEMU generated ACPI tables get into that
> storage?
>
I should say "mass storage and flash"
There was fw_cfg in v1 patch, it is removed in v2.
If no fw_cfg, just like real hardware, UEFI should include ACPI
support for this SBSA platform, and UEFI/ACPI is load via -pflash,
then the QEMU built-in ACPI isn't used.
But there are side effects too, command 'qemu -bios uefi -kernel'
won't work, I need extra time to evaluate this change.

>> If we develop firmware depends on paravirtualized device like fw_cfg,
>> then we canot run such firmware on real hardware.
>
> Yes, fw-cfg is paravirt, so it's obvious why you'd prefer it not be there,
> but, where real hardware builds its hardware descriptions into its
> platform-specific firmware, or uses some platform-specific means of
> extracting a description from some platform-specific place, QEMU
> machine models use fw-cfg.
>
> Thanks,
> drew
