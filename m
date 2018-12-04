Received: from eggs.gnu.org ([2001:4830:134:3::10]:34703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUAz7-0003Ur-7q
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUAz6-00055y-BV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:43:33 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUAz5-00054b-Tg
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:43:32 -0500
Received: by mail-ot1-x344.google.com with SMTP id 32so15139374ota.12
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 05:43:31 -0800 (PST)
MIME-Version: 1.0
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<20181204124739.GA17825@redhat.com>
	<CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
	<9ad451bd-7eb1-902f-6023-4b48bb84249c@redhat.com>
In-Reply-To: <9ad451bd-7eb1-902f-6023-4b48bb84249c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 13:43:18 +0000
Message-ID: <CAFEAcA-tzZVVXk+vV=uWOeL6dU3EnFiFRzLu8KR69Ju4PsPrJg@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Andrew Jones <drjones@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 4 Dec 2018 at 13:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/12/18 13:59, Peter Maydell wrote:
> > ...and if we'd done it that way in the first place for x86 then
> > we wouldn't be having to do anything at all now for Arm.
> > That suggests to me that we should do it that way now, and then we
> > can avoid having to do a bunch of extra development work for the
> > next architecture, or the next interesting Arm board model.
>
> Is there any case where we have anything but ISA and MMIO?  (We have
> 8250 which is ISA, PCI and MMIO, but that's kind of special because PCI
> is only there for hotpluggability.  pvpanic hotplug is not interesting).

The point about PCI is that it is the same everywhere and
discoverable, and easy for the user to add to the system or not.
MMIO requires extra work for every board model that we want to
put the device into, plus extra on both kernel and QEMU side
for every system description mechanism (ACPI, dtb, whatever
some future architecture might use), even if we have the basic
"mmio pvpanic" device code already.

> Also, while reusing code in general is nice, sometimes there are
> platform-specific ways to do it.  For ARM, for example, would it make
> sense to use an HVC/SMC that "extends" the PSCI, and pass the number in
> the PSCI device tree node?

If you want a hypercall then these days the arm HVC calling convention
includes mechanisms for discoverably determining whether a particular
hypercall is supported, so you wouldn't need to pass anything in the
ACPI or dtb. But I didn't get the impression that anybody wanted a
hypercall for this particularly.

> Related to this, is there a more or less "standard" watchdog device on
> ARM that could be added to virt?  There is the SBSA watchdog, but it's
> ugly for implementation in KVM because it counts down with frequency
> equal to CNTFRQ (which I'm not sure if QEMU has access too, and also it
> doesn't play well with live migration).

The i6300esb is PCI, presumably that would work?

> > I notice also that there's a mention in that thread that the pvpanic
> > ACPI table entry on x86 resulted in unhelpful Windows notifications
> > about new devices it didn't understand. Is that going to be an issue
> > for Arm with this mmio pvpanic ?
>
> Yes, it is probably the same as for x86.

I guess we need to find out if that is a problem before we can
merge this, then.

thanks
-- PMM
