Received: from eggs.gnu.org ([2001:4830:134:3::10]:52968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crSY8-0007zB-DL
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crSY5-0002dd-Bm
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crSY5-0002dI-3K
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 309B085365
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 16:58:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
Date: Fri, 24 Mar 2017 17:58:43 +0100
In-Reply-To: <20170324134821.GC28530@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Fri, 24 Mar 2017 10:48:21 -0300")
Message-ID: <87y3vur4qk.fsf@dusky.pond.sub.org>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Mar 24, 2017 at 01:49:16PM +0300, Marcel Apfelbaum wrote:
>> On 03/22/2017 10:46 PM, Laszlo Ersek wrote:
>> > On 03/22/17 21:31, Eduardo Habkost wrote:
>> > > Hi,
>> > > 
>> > > I am investigating the current status of has_dynamic_sysbus and
>> > > sysbus device support on each of QEMU's machine types. The good
>> > > news is that almost all has_dynamic_sysbus=1 machines have their
>> > > own internal (often short) whitelist of supported sysbus device
>> > > types, and automatically reject unsupported devices.
>> > > 
>> > > ...except for q35.
>> > > 
>> > > q35 currently accepts all sys-bus-device subtypes on "-device",
>> > > and today this includes the following 23 devices:
>> > > 
>> > > * allwinner-ahci
>> > > * amd-iommu
>> > > * cfi.pflash01
>> > > * esp
>> > > * fw_cfg_io
>> > > * fw_cfg_mem
>> > > * generic-sdhci
>> > > * hpet
>> > > * intel-iommu
>> > > * ioapic
>> > > * isabus-bridge
>> > > * kvmclock
>> > > * kvm-ioapic
>> > > * kvmvapic
>> > > * SUNW,fdtwo
>> > > * sysbus-ahci
>> > > * sysbus-fdc
>> > > * sysbus-ohci
>> > > * unimplemented-device
>> > > * virtio-mmio
>> > > * xen-backend
>> > > * xen-sysdev
>> > > 
>> > > My question is: do all those devices really make sense to be used
>> > > with "-device" on q35?
>> > 
>> > I think fw_cfg_io and fw_cfg_mem should be board-only devices (no
>> > -device switch).
>> > 
>> > Regarding cfi.pflash01, I think originally it would have been nice to
>> > specify pflash chips with the modern (non-legacy) syntax, that is,
>> > separate -drive if=none,file=... backend options combined with -device
>> > cfi.pflash01,drive=... frontend options. However, that ship has sailed,
>> > even libvirt uses -drive if=pflash for these, and given the purpose we
>> > use pflash chips for, on Q35, I don't see much benefit in exposing
>> > cfi.pflash01 with a naked -device *now*.
>> > 
>> > Re: virtio-mmio, I don't think that should be available on Q35 at all.
>> > 
>> > I can't comment on the rest.
>> > 
>> 
>> Hi Eduardo,
>> Thanks for finding these problems.
>> 
>> We should ping all maintainers of the above devices, the best way to do it
>> is to add the "cannot_instantiate_with_device_add_yet = true" and ask maintainers
>> to agree (or not) on that.
>
> If I understand it correctly,
> cannot_instantiate_with_device_add_yet is supposed to be
> temporary.

A couple of years ago, we had a -device regression: devices marked
no_user were no longer rejected.  To get my fix for that in, I had to
rename it to cannot_instantiate_with_device_add_yet and add some solemn
protestations that it's temporary.  It's been temporary ever since.

Without doubt getting rid of it would be nice.  But I'm not holding my
breath.

>            And it applies to all machines, with no exceptions.

Correct.

> The problem with today's mechanism is that we have no way to make
> a machine accept one type of sysbus device without making it
> start accepting every other sysbus devices. If we thought all
> !cannot_instantiate_with_device_add_yet sysbus devices were
> already safe, we wouldn't have has_dynamic_sysbus in the first
> place, would we?

In my relatively ignorant opinion, "dynamic sysbus" has to die even
harder than "sysbus".

"Sysbus" isn't a bus.  In qdev's original design, every device had to
plug into a bus, period.  The ones that really didn't were made to plug
into "sysbus".

Pretty much the only thing "sysbus" devices had in common was that they
couldn't be used with device_add and device_del.

We fixed the design to permit bus-less devices, but we didn't get rid of
"sysbus".

We got a "platform bus", which is really not the same as "sysbus", but
we shoehorned it into "sysbus" anyway.

The result is a mess, and you're sitting right in it.

One hack we could perhaps pile on top of the others: have sysbus devices
again set cannot_instantiate_with_device_add_yet, then unset it for the
ones in the whitelist.
