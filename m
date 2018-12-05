Received: from eggs.gnu.org ([2001:4830:134:3::10]:47377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUYZS-00021E-LO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:54:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUYZR-0001tl-6F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:54:38 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUYZQ-0001r7-Pn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:54:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id w13so17727876oiw.9
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 06:54:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA8hw_PHrBTC+v9rr8VoeU5uiV3Z6nMRknDM7WWdG1Ti5g@mail.gmail.com>
	<201812050827458661131@zte.com.cn>
In-Reply-To: <201812050827458661131@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Dec 2018 14:54:24 +0000
Message-ID: <CAFEAcA8s87tB4LGaVvJNpS0RN1gQ-ZjtzOBO0mWWQamBFiTzYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 5 Dec 2018 at 00:28, <peng.hao2@zte.com.cn> wrote:
>
> >I'm afraid I don't understand. If it's a PCI device then
> >it does not need to be listed in the device tree or the
> >ACPI tables at all, because it is probeable by the guest.
> >This also significantly simplifies the changes needed in QEMU.
> >
>
> It is precisely because PCI devices can not be controlled by FDT or ACPI tables,
> I do not want to implement it as a pci device.
> X86/pvpanic is implemented as ISA device in QEMU and ACPI device in kernel.
> My implementation extends the implementation of x86/pvpanic, and a large of x86/pvpanic
> codes are reused.If PCI devices are implemented in qemu, then ACPI devices and PCI
> devices may appear simultaneously in the kernel. This would add both devices to the
> crash notifier list, which is odd. I want to see only one device at any time.

Yes, certainly we only need one pvpanic device. If it's implemented
as a PCI device, then that's what appears. We don't need and
would not implement the MMIO version. On x86 a user could
in theory use the command line to request both ISA and PCI
pvpanic devices. That would not be very sensible, but there
are lots of QEMU command lines the user can request that
don't make sense.

> Of course, many
> architectures can use PCI devices, but we are currently reusing x86/pvpanic code as much
> as possible in qemu and kernel , rather than reimplementing it. At the same time,
> backward compatibility also needs to be considered.
>
>                                      pvpanic in guest kernel
> ARM:   ACPI table         acpi device
>             FDT                  mmio device  (start guest bypassing uefi)
> x86      ACPI table         acpi device

For Arm, there is no backward compatibility issue, as we have
not yet implemented or shipped anything.

> >> Secondly, I don't want it to be a pluggable device. If the user
> >> deletes the device by mistake, it may lead to unpredictable results.
> >
> >If the user deletes the PCI device they're using for their
> >disk or networking this will also lead to unpredictable
> >results. We expect users not to randomly unplug things from
> >their system if they want it to continue to work. In any
> >case your guest driver can easily handle the unplug: the
> >guest would then just lose the ability to notify on panic,
> >falling back to as if the pvpanic device had never been
> >present.
>
> If two devices can exist simultaneously by modifying the code,
>  then because ACPI devices rely on a PCI device, if PCI devices are dynamically
>  unplugged, ACPI device will not work when panic is triggered.

If somebody modifies the code to QEMU or the guest kernel
such that something breaks, that's their issue to deal with.
My proposal is that we would ship:
 * a QEMU with a PCI pvpanic device (which you could plug in
   if you wanted it)
 * no changes to the Arm virt board, so nothing in the ACPI
   or device tree
 * no "mmio pvpanic" device

thanks
-- PMM
