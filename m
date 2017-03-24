Received: from eggs.gnu.org ([2001:4830:134:3::10]:41469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTUz-00085k-PL
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTUv-0007bj-1j
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crTUu-0007bY-So
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:59:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
Date: Fri, 24 Mar 2017 18:59:31 +0100
In-Reply-To: <CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
	(Peter Maydell's message of "Fri, 24 Mar 2017 17:08:56 +0000")
Message-ID: <877f3emu7w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 March 2017 at 16:58, Markus Armbruster <armbru@redhat.com> wrote:
>> "Sysbus" isn't a bus.  In qdev's original design, every device had to
>> plug into a bus, period.  The ones that really didn't were made to plug
>> into "sysbus".
>>
>> Pretty much the only thing "sysbus" devices had in common was that they
>> couldn't be used with device_add and device_del.
>
> This isn't really true. Sysbus devices support having MMIO regions
> and IRQ lines and GPIO lines. If you need those you're a
> sysbus device; otherwise you can probably just be a plain old Device.

Well, "device has MMIO regions, IRQ lines and GPIO lines" is about as
"device contains virtual silicon".  What would a device without any of
these *do*?

Devices plugging into a bus have to expose their MMIO regions, IRQ
lines, etc. in a certain way dictated by the bus.  In return, you don't
have to wire up each resource manually, you simply plug into the bus and
are done.  That's what makes a bus a bus for me.

"Sysbus" does nothing of the sort.

>> We fixed the design to permit bus-less devices, but we didn't get rid of
>> "sysbus".
>
> Call it what you want, but we should have some common code support
> for "I want to have MMIOs and IRQs and GPIO lines".

Of course.

>                                                     You could
> argue for moving all that into Device I suppose.

Yup.

>> We got a "platform bus", which is really not the same as "sysbus", but
>> we shoehorned it into "sysbus" anyway.
>
> I agree 'platform bus' is a mess, and I'd rather it didn't exist.
> Unfortunately people really really want to be able to do device
> pass through of random memory-mapped devices :-(

The "platform" bus adds certain constraints over "sysbus", precisely to
make these uses possible.  And that's precisely why it should be its own
thing instead of complicating "sysbus".
