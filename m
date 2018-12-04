Received: from eggs.gnu.org ([2001:4830:134:3::10]:58280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUG5l-0003pp-KR
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUG5k-0007hw-Gy
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 14:10:45 -0500
Date: Tue, 4 Dec 2018 14:10:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181204140755-mutt-send-email-mst@kernel.org>
References: <1543865209-50994-1-git-send-email-peng.hao2@zte.com.cn>
	<CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<20181204124739.GA17825@redhat.com>
	<CAFEAcA_ovMgKPPjtYVASFqhzM7MX79EJYMZuFY4-FGRh4oqN8A@mail.gmail.com>
	<9ad451bd-7eb1-902f-6023-4b48bb84249c@redhat.com>
	<CAFEAcA-tzZVVXk+vV=uWOeL6dU3EnFiFRzLu8KR69Ju4PsPrJg@mail.gmail.com>
	<149484eb-c59f-2b22-aa45-d4e5f0abac07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149484eb-c59f-2b22-aa45-d4e5f0abac07@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Peng Hao <peng.hao2@zte.com.cn>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Tue, Dec 04, 2018 at 02:53:26PM +0100, Paolo Bonzini wrote:
> On 04/12/18 14:43, Peter Maydell wrote:
> > The point about PCI is that it is the same everywhere and
> > discoverable, and easy for the user to add to the system or not.
> > MMIO requires extra work for every board model that we want to
> > put the device into, plus extra on both kernel and QEMU side
> > for every system description mechanism (ACPI, dtb, whatever
> > some future architecture might use), even if we have the basic
> > "mmio pvpanic" device code already.
> 
> Looks like dtb is becoming a standard?  Even RISC-V switched from their
> own system description to device tree.  Anyway, this is not too
> important.  I agree with you about discoverability, on the other hand if
> we could have something defined by the vendor rather than QEMU it would
> be even better.  (Even better would be something that distro kernels
> already have support for, but that would be asking too much probably).
> 
> >> Also, while reusing code in general is nice, sometimes there are
> >> platform-specific ways to do it.  For ARM, for example, would it make
> >> sense to use an HVC/SMC that "extends" the PSCI, and pass the number in
> >> the PSCI device tree node?
> > 
> > If you want a hypercall then these days the arm HVC calling convention
> > includes mechanisms for discoverably determining whether a particular
> > hypercall is supported, so you wouldn't need to pass anything in the
> > ACPI or dtb. But I didn't get the impression that anybody wanted a
> > hypercall for this particularly.
> 
> Not for x86, where each hypervisor has its own hypercall number and even
> its calling convention.  But for ARM it already makes more sense.
> 
> >> Related to this, is there a more or less "standard" watchdog device on
> >> ARM that could be added to virt?  There is the SBSA watchdog, but it's
> >> ugly for implementation in KVM because it counts down with frequency
> >> equal to CNTFRQ (which I'm not sure if QEMU has access too, and also it
> >> doesn't play well with live migration).
> > 
> > The i6300esb is PCI, presumably that would work?
> 
> Yeah, I was wondering if there was something in PrimeCell.  I found
> SP805 exists now.
> 
> >>> I notice also that there's a mention in that thread that the pvpanic
> >>> ACPI table entry on x86 resulted in unhelpful Windows notifications
> >>> about new devices it didn't understand. Is that going to be an issue
> >>> for Arm with this mmio pvpanic ?
> >>
> >> Yes, it is probably the same as for x86.
> > 
> > I guess we need to find out if that is a problem before we can
> > merge this, then.
> 
> As long as the pvpanic device is not added by default it's okay.
> 
> Paolo

It isn't too bad, you just include a driver and then it's happy.

Isn't a device just for panic going too far though?
Should it be some kind of PV device that we
can use to add more pv stuff in the future, with
a panic option?

-- 
MST
