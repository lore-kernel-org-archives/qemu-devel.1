Received: from eggs.gnu.org ([2001:4830:134:3::10]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiaxC-0005Oh-HA
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiax9-00036z-JT
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:44:54 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiax9-00036Y-C1
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 03:44:51 -0400
Received: by mail-it0-x241.google.com with SMTP id h23-v6so1422936ita.5
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 00:44:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmQWvCHBxdMy+Qocc1XfURx86RTZd72rnB5-R=5QA00R6fEqw@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725105330.GB2366@work-vm>
	<CAHmQWvCHBxdMy+Qocc1XfURx86RTZd72rnB5-R=5QA00R6fEqw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 26 Jul 2018 09:44:49 +0200
Message-ID: <CAKv+Gu8qM=C=bJeDrUHxMEp3mZ-PYemRXK-Qttvwk9k+C2uz+Q@mail.gmail.com>
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
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 26 July 2018 at 09:35, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> On 25 July 2018 at 18:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> * Hongbo Zhang (hongbo.zhang@linaro.org) wrote:
>>> On 25 July 2018 at 17:54, Andrew Jones <drjones@redhat.com> wrote:
>>> > On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
>>> >> For the Aarch64, there is one machine 'virt', it is primarily meant to
>>> >> run on KVM and execute virtualization workloads, but we need an
>>> >> environment as faithful as possible to physical hardware, for supporting
>>> >> firmware and OS development for pysical Aarch64 machines.
>>> >>
>>> >> This patch introduces new machine type 'Enterprise' with main features:
>>> >>  - Based on 'virt' machine type.
>>> >>  - Re-designed memory map.
>>> >>  - EL2 and EL3 are enabled by default.
>>> >>  - GIC version 3 by default.
>>> >>  - AHCI controller attached to system bus, and then CDROM and hard disc
>>> >>    can be added to it.
>>> >>  - EHCI controller attached to system bus, with USB mouse and key board
>>> >>    installed by default.
>>> >>  - E1000E ethernet card on PCIE bus.
>>> >>  - VGA display adaptor on PCIE bus.
>>> >>  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
>>> >>  - No virtio functions enabled, since this is to emulate real hardware.
>>> >
>>> > In the last review it was pointed out that using virtio-pci should still
>>> > be "real" enough, so there's not much reason to avoid it. Well, unless
>>> > there's some concern as to what drivers are available in the firmware and
>>> > guest kernel. But that concern usually only applies to legacy firmwares
>>> > and kernels, and therefore shouldn't apply to AArch64.
>>> >
>>> In real physical arm hardware, *HCI are system memory mapped, not on PCIE.
>>> we need a QEMU platform like that. We need firmware developed on this
>>> QEMU platform can run on real hardware without change(or only a minor
>>> change)
>>
>> How would you deal with most modern hardware now using XHCI rather than
>> EHCI ?
>>
> Well, EHCI still works well on server, some new X86 servers have both
> XHCI and EHCI, Qualcomm Centriq Arm server even has only EHCI, so
> currently only the EHCI is added.
> I had no strong reason for XHCI or EHCI, if newer is better or some
> users have special requirement for XHCI, it can be added too.
>

Does that really matter? As I pointed out before, we are not
interested in running the firmware on actual bare metal. What we do
care about is not having code in the reference firmware stack that was
added specifically to deal with the dynamic nature of our QEMU
platform.
