Received: from eggs.gnu.org ([2001:4830:134:3::10]:39155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU7Bl-0002cG-Hl
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gU7Bj-0003h3-Cz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:40:21 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gU7Bj-0003gh-5r
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 04:40:19 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so14573884otl.5
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 01:40:19 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<201812040841510784684@zte.com.cn>
In-Reply-To: <201812040841510784684@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 09:40:07 +0000
Message-ID: <CAFEAcA8hw_PHrBTC+v9rr8VoeU5uiV3Z6nMRknDM7WWdG1Ti5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 4 Dec 2018 at 00:41, <peng.hao2@zte.com.cn> wrote:
>
> >I would still prefer to see a more detailed examination of whether
> >we can do this with a PCI device before we commit to taking the
> >MMIO version into the virt board.
>
> I'm sorry I thought I had sent an email. yesterday when I wrote an email to
> explain the reason, I was interrupted and forgot to send it out.
>
> Now the pvpanic device is implemented as a mmio device or an ACPI device in the kernel,
> and only one device can be seen at the same time. If the kernel parses FDT first, then pvpanic
> is a mmio device. The kernel parses ACPI table first(and virtual machine is configured with ACPI),
> and pvpanic  is an ACPI device.
> If pvpanic is implemented as a PCI device, then the PCI device must still be seen when the ACPI table
> is first parsed by the kernel, because ACPI device relies on the mmio space of the PCI device.
> Mmio devices can be thought of as just an address space rather than a device in the strict sense.

I'm afraid I don't understand. If it's a PCI device then
it does not need to be listed in the device tree or the
ACPI tables at all, because it is probeable by the guest.
This also significantly simplifies the changes needed in QEMU.

> Secondly, I don't want it to be a pluggable device. If the user
> deletes the device by mistake, it may lead to unpredictable results.

If the user deletes the PCI device they're using for their
disk or networking this will also lead to unpredictable
results. We expect users not to randomly unplug things from
their system if they want it to continue to work. In any
case your guest driver can easily handle the unplug: the
guest would then just lose the ability to notify on panic,
falling back to as if the pvpanic device had never been
present.

thanks
-- PMM
