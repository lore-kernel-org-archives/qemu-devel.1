Received: from eggs.gnu.org ([2001:4830:134:3::10]:45656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crTgI-0003uf-21
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crTgG-0003vP-S9
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:11:21 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crTgG-0003tC-MN
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 14:11:20 -0400
Received: by mail-wm0-x230.google.com with SMTP id t189so8652779wmt.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 11:11:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877f3emu7w.fsf@dusky.pond.sub.org>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
	<877f3emu7w.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 18:10:59 +0000
Message-ID: <CAFEAcA94t24TATa=9GFWszD9__i=TL09E7_kGptaPEKFe_TBhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 March 2017 at 17:59, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> This isn't really true. Sysbus devices support having MMIO regions
>> and IRQ lines and GPIO lines. If you need those you're a
>> sysbus device; otherwise you can probably just be a plain old Device.
>
> Well, "device has MMIO regions, IRQ lines and GPIO lines" is about as
> "device contains virtual silicon".  What would a device without any of
> these *do*?

A PCI device doesn't have them, for instance -- it exposes only
a PCI-bus connector.

> Devices plugging into a bus have to expose their MMIO regions, IRQ
> lines, etc. in a certain way dictated by the bus.  In return, you don't
> have to wire up each resource manually, you simply plug into the bus and
> are done.  That's what makes a bus a bus for me.

I think of these as various kinds of connection. A connection
can be a single wire (like a GPIO line or an interrupt line),
or it can be a well-defined bundle of signals (like a PCI bus
slot's multiple connections), or (for emulation) it can be a
more abstracted connection like what we call an MMIO region
(which is an abstraction of a data bus and address bus
set of signals which we don't want to modify at that level).
A PCI device in QEMU is *not* exposing an MMIO region, because
the only correct way to access it is via the PCI bus APIs.
(We just implement our PCI bus in terms of MMIO regions.)

A "bus" is just a well defined set of signals that it's convenient
to manipulate all at once. It isn't necessarily every signal
the device has.

Not all hardware is defined like that -- quite a lot (especially
in the embedded world) is defined with much more ad-hoc
connection specifications because it's going to be "wired up"
as part of an SoC, with some verilog/RTL which says "this GPIO
line goes to here" and so on. In fact even at this level there's
usually some sort of 'bus' abstraction for some of these signals:
what we represent as an individual MMIO region is usually
a connection on an AXI or AHB bus or other architectural equivalent.

The way that we privilege some of these connections above others
(eg that PCI devices all inherit from a particular parent class)
is a bit ugly in an abstract sense (really a device should just
say "I have a PCI connection here" in the same way it can say
"I have a bare GPIO wire here", rather than PCI devices being
subclasses of a common PCI device base class), but it's a
bit simpler in practice. Similarly having a base class that's
providing some useful functionality for devices that deal
mostly in "bare wires" is convenient in practice.

thanks
-- PMM
