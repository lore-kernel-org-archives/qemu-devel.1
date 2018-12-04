Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUAJ2-0003qa-Fs
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUAJ1-0003b2-E1
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:00:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUAJ1-0003a1-8V
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:00:03 -0500
Received: by mail-ot1-x341.google.com with SMTP id n8so11185269otl.6
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:00:03 -0800 (PST)
MIME-Version: 1.0
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<20181204124739.GA17825@redhat.com>
In-Reply-To: <20181204124739.GA17825@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 12:59:51 +0000
Message-ID: <CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 4 Dec 2018 at 12:47, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> After it had merged there were some changes and the question of turning
> it into a PCI device was raised. Paolo was concerned that the guest OS
> is in an unknown state (arbitrary locks held, data structures corrupt,
> etc) when panic is fired, so simplicity of the I/O port was desirable:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03309.html
>
> Anthony countered that even a PCI device could simply do an outb() in
> config space:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03325.html
>
> So it is not clear using a PCI device is in fact a problem in terms of
> reliability at time of firing.

...and if we'd done it that way in the first place for x86 then
we wouldn't be having to do anything at all now for Arm.
That suggests to me that we should do it that way now, and then we
can avoid having to do a bunch of extra development work for the
next architecture, or the next interesting Arm board model.

> Perhaps more relevant is the question of how easily it can be initialized=
,
> as that affects whether it can be used for panics during very early boot,
> or from firmware:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2013-08/msg03296.html

Mmm, firmware and early boot panic is potentially an interesting
use case. Does UEFI actually make use of it, though? A quick look
at the kernel source for the x86 pvpanic driver suggests it doesn't
take any particular steps to ensure that it is initialized early,
though I guess acpi drivers probably init before PCI.

I notice also that there's a mention in that thread that the pvpanic
ACPI table entry on x86 resulted in unhelpful Windows notifications
about new devices it didn't understand. Is that going to be an issue
for Arm with this mmio pvpanic ?

> Finally, there is also the point that PCI slots are precious, and this
> is something to be enabled out of the box on all VMs, so you'd be removin=
g
> one extra PCI slot from general usage. Thus mgmt apps would need to start
> adding PCI bridges sooner. Not a blocker but something to bear in mind
> when weighing up options.

Space in the 'virt' memory map for random MMIO devices is also a limited
resource, especially if you want something in the <4GB space.

thanks
-- PMM
