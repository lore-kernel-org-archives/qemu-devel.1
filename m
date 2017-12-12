Received: from eggs.gnu.org ([2001:4830:134:3::10]:40462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOlGQ-0002Lq-Vp
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOlGP-0000lR-6I
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:10:30 -0500
Date: Tue, 12 Dec 2017 15:10:10 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212141010.bpqhgrmzortbfvc7@kamzik.brq.redhat.com>
References: <5A2F6ED9.5030605@huawei.com>
	<ac182406-8011-9f19-38e7-37328434095b@redhat.com>
	<CAFEAcA_9pee99KpL4zwVS5jJuiv2MCGp79crufpU1kH1Okg-Hg@mail.gmail.com>
	<6b4b6351-eeb4-a4d3-8ddf-5401516671ae@redhat.com>
	<CAKv+Gu-Ugm1g8twoKwgXAPtDfETvXntk2h4WzMVuUTDF7GhMvA@mail.gmail.com>
	<5e3798f7-e280-b6c3-1504-828283617c52@redhat.com>
	<CAFEAcA_+NnpeP9Le7bp9yrYQDwtuP79pt8GpVzJ4RBDMx1iomA@mail.gmail.com>
	<09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
	<CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
	<d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrea Bolognani <abologna@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On Tue, Dec 12, 2017 at 02:28:51PM +0100, Laszlo Ersek wrote:
> On 12/12/17 13:47, Peter Maydell wrote:
> > On 12 December 2017 at 12:41, Laszlo Ersek <lersek@redhat.com> wrote:
> >> I agree. There's one user-visible complication: while with one UART,
> >> it's not possible to mix things up, with two UARTs, users will
> >> inevitably want to assign inverse roles to them, relative to what QEMU /
> >> the firmware assigns originally.
> >>
> >> E.g. if one PL011 is redirected to a regular file (debug messages) and
> >> the other one to stdio (console), there will be complaints that "I
> >> wanted it the other way around". The redirection happens on the backend
> >> (chardev) level, but the firmware won't see the difference on the
> >> frontend (PL011) level.
> >>
> >> Is it possible to add a new property to the UART nodes in the DTB, like
> >> "purpose"?
> > 
> > This is what the "chosen" stdout-path node in the DTB is for,
> > but you said you didn't want to look at that :-) (it means
> > "device to be used for boot console output".)
> 
> :(
> 
> Ard is right that we really shouldn't do that kind of parsing magic in
> very early UEFI stuff.
> 
> 
> >> Or can we make a virt-arm policy that "first -serial is always ...,
> >> second -serial is always ..."?
> > 
> > Well, the first -serial will always be the 0x09000000 one
> > that we have today, and the second -serial will be the other
> > one (unless you have -machine secure=yes, in which case
> > second -serial is the secure-only UART and third -serial is
> > the second NS UART).
> > 
> > Is this any different to the x86 case, where there are two
> > UARTs at different IO port/IRQ locations?
> 
> OVMF (x86) uses two distinct devices for the two purposes discussed.
> 
> * It uses the "debug console device" for debug message output, at
> hard-coded IO port 0x402; so if you'd like to capture those messages,
> then you have to add:
> 
>   -chardev file,id=debugfile,path=debug.log \
>   -device isa-debugcon,iobase=0x402,chardev=debugfile \
> 
> (or the more traditional
> 
>   -debugcon file:debug.log \
>   -global isa-debugcon.iobase=0x402 \
> )
> 
> * For console I/O, it uses the first serial port. (I think I have once

If "first" here means the first '-serial' argument on the command line,
then mach-virt has the same requirement. The console must be the first
'-serial' argument. The secure UART, provided when the 'secure' property
is set, gets the next one. So

 -chardev file,path=secure-uart.log,id=s -serial stdio -serial chardev:s

works as expected, but

 -chardev file,path=secure-uart.log,id=s -serial chardev:s -serial stdio

does not.

This series keeps that requirement and adds that the second NS UART's
'-serial' argument must come after the secure UART, when the machine
has the 'secure' property set.

Command line ordering requirements aren't awesome, so it might be nice
to add a serial option 'console', allowing

 -chardev file,path=secure-uart.log,id=s -serial chardev:s -serial stdio,console

to work too.

> investigated what it takes to use other serial ports for console I/O --
> I'm no longer sure if "it happens to be impossible in OVMF", or just
> "nobody ever does that".)
> 
> 
> The important distinction (on the UEFI level anyway) is that the debug
> messages need to go to a super dumb device, while console I/O can use a
> much higher-level serial IO abstraction ("protocol").
> 
> 
> > I think the only thing users really expect is that if you're
> > using just the one serial port for anything then it's the
> > first one.
> 
> You are right -- we've never had two (non-secure) UARTs on virt-arm, so
> we can invent whatever assignment, as long as:
> 
> - the single UART case doesn't break (keeps receiving both debug output
> and console IO),
> 
> - whatever we invent for the two UARTs case now, it remains consistent
> over time. I think this implies we can rely on the FDT node ordering in
> the firmware (if we want to use the 2nd UART at all, that is), and then
> QEMU shouldn't change the serial_hds[] <-> FDT node mapping in the
> future, in machvirt_init() and the callees thereof.
> 
> Thanks!
> Laszlo
> 

Personally I think AAVMF should learn how to parse stdout-path, but as
an interim solution it could just hard code the console address
(0x9000000), like it does the base of memory (which I think it should
eventually learn to get from the DT, pointed to by register x0, too :-)

Always generating the second UART's FDT node with status = "disabled",
as Ard suggests, even when the user has provided a '-serial' command
line option for it, i.e. serial_hds[i] != NULL, i > 0, doesn't seem like
what we'd want to do. Wouldn't Linux assume (when boot directly without
AAVMF) that the UART should not be used in that case?

Thanks,
drew
