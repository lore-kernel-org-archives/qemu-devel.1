Received: from eggs.gnu.org ([2001:4830:134:3::10]:41649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fidL3-0003Lb-Me
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fidL0-0006Lg-Ly
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:17:41 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fidL0-0006Km-FX
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:17:38 -0400
Received: by mail-it0-x243.google.com with SMTP id d70-v6so2103661ith.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 03:17:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 26 Jul 2018 18:17:36 +0800
Message-ID: <CAHmQWvC44mLchhEFPU0T0gKWVcjjozp95ZumaKK9EkPwpeehTA@mail.gmail.com>
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

On 25 July 2018 at 19:44, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Jul 25, 2018 at 06:46:59PM +0800, Hongbo Zhang wrote:
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
>> For Armv7, there is one typical platform 'vexpress', but for Armv8, no
>
> Wasn't the vexpress model designed for a specific machine? Namely for
> Arm's simulator? Is the vexpress model really something typical among
> all the Armv7 platforms?
>
>> such typical one, the 'virt' is typically for running workloads, one
>> example is using it under OpenStack.
>> So a 'typical' one for Armv8 is needed for firmware and OS
>> development, similar like 'vexpress' for Armv7.
>
> What is a "typical" Armv8 machine? What will a typical Armv8 machine be in
> two years?
>
> Note, I'm not actually opposed to the current definition (because I don't
> really have one myself). I'm just opposed to hard coding one.
>
For x86, we have i440fx and q35 (although they are old), but for
Armv8, simple usage like "qemu -bios/-pflash -cdrom" to install an OS
and "qemu -bios/-pflash -hda" to launch is needed too.
Armv8 has no such ones like x86, but we need, and SBSA could be the one.

Hard coding, user may have different customs, It couldn't be better if
one platform satisfy requirement, if not satisfied we edit it with
command or readconfig slightly, if we always need to change a platform
to another one with huge difference, then why not maintain the other
one, otherwise we don't need to maintain so many platforms at all.

> Thanks,
> drew
