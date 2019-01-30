Received: from eggs.gnu.org ([209.51.188.92]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goqck-0006wl-Sa
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1goqcj-0000Z5-5c
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:13:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
Date: Wed, 30 Jan 2019 15:13:42 +0100
In-Reply-To: <CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	(Peter Maydell's message of "Mon, 28 Jan 2019 10:39:09 +0000")
Message-ID: <87o97yi67d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo for additonal device infrastructure expertise.

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 25 Jan 2019 at 15:11, Markus Armbruster <armbru@redhat.com> wrote:
>> (1) cfi.pflash01 isn't available with -device.
>>
>> (2) "Magic board code picks up the backend [created for -drive
>>     if=pflash], creates a frontend (a cfi.pflash01 device), and maps it
>>     into the guest's address space."  When we replace if=pflash by
>>     if=none, we get to replicate that magic on top of -device.
>>
>> Issue (1) isn't too hard: we add the device to the dynamic sysbus device
>> white-list, move a sysbus_mmio_map() from pflash_cfi01_realize() into
>> pflash_cfi01_realize().  The latter requires a new device property to
>> configure the base address.  I got a working prototype.  Since this
>> makes the device model's name and properties ABI, review would be
>> advisable.
>
> Flash devices exist on the board at specific addresses, so they
> should in general be created by the board model. Creating them
> by the user on the command line is a mess because then the
> user has to know the right base address.

I agree outsourcing configuration of onboard devices to the user is not
very nice.  However, the current situation is also not nice: onboard
device configuration is different from plugged device configuration, and
markedly inferior.

Our common mechanism to configure devices is device properties.  Some
properties serve to configure the device (e.g. e1000.mac), some serve to
connect it to backends (e.g. e1000.netdev), and some serve to wire it up
(e.g. e1000.bus and .addr).

This mechanism is pretty much a specialization of our general QOM
configuration mechanism (although it predates QOM).

This mechanism is satisfactorily flexible.  In particular, you can
capture commonalities such as "all PCI devices have these properties" or
"all NIC devices have these properties", and still have individual
devices expose their own idiosyncratic properties.

-device / device_add provide full control over properties.

Onboard device configuration is totally different, and leaves most
properties inaccessible.

Board code creates the devices and sets (some of) their properties.  The
property values come from ad hoc board configuration, magic board code,
or the device model's default.

Ad hoc configuration knobs include -drive if=T where T != none, -serial,
-net nic, and more.  They work roughly like this.  Generic code stores
the user's ad hoc board configuration in well-known places.  Board code
picks up some configuration bits, and ignores the rest.

Let's have a closer look at one of these beauties: -serial.  If you
don't need to be convinced the ad hoc configuration is problematic, you
may want to skip ahead to "Observe:".

Let's start with the default:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info chardev 
    parallel0: filename=vc
    serial0: filename=vc
    compat_monitor0: filename=stdio
    (qemu) info qtree
    [...]
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = "serial0"
        mmio ffffffffffffffff/0000000000001000
    [...]

There's a default chardev "serial0".  It's created by generic code
unless the user or the board supress it (this board doesn't).  Its exact
configuration depends on several factors too complicated to explain
here.

There's an onboard serial device pl011, connected to the default
chardev.

Say you don't like the default chardev.  You can suppress it with
-nodefaults or -serial none.  This board creates the serial device
anyway, since its a mandatory onboard device.  It just creates it with a
null backend:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt -nodefaults
    (qemu) info chardev 
    compat_monitor0: filename=stdio
    (qemu) info qtree
    [...]
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = ""
        mmio ffffffffffffffff/0000000000001000
    [...]

Boards with optional onboard serial devices would suppress the entire
device instead.  If you want a null backend without suppressing the
device, use -serial null:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt -serial null
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info chardev 
    parallel0: filename=vc
    serial0: filename=null
    compat_monitor0: filename=stdio
    (qemu) info qtree
    [...]
    dev: pl011, id ""
      gpio-out "sysbus-irq" 1
      chardev = "serial0"
      mmio ffffffffffffffff/0000000000001000
    [...]

That's the chardev type "null", which is not the same as the null
backend we just saw.  They just behave the same, as far as I know.

As example for a "non-null" chardev, here's one wrapping a Unix domain
socket:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt -serial unix:./serial-socket,server,wait=off
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info chardev 
    parallel0: filename=vc
    serial0: filename=disconnected:unix:./serial-socket,server
    compat_monitor0: filename=stdio
    (qemu) info qtree
    [...]
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = "serial0"
        mmio ffffffffffffffff/0000000000001000
    [...]

You can have any number of -serial:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt -serial null -serial unix:./serial-socket,server,wait=off
    (qemu) info chardev
    parallel0: filename=vc
    serial0: filename=null
    compat_monitor0: filename=stdio
    serial1: filename=disconnected:unix:./serial-socket,server

This board silently ignores all but the first.  Except with -machine
virt,secure, it ignores all but the first two:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt,secure -serial null -serial unix:./serial-socket,server,wait=off
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info chardev
    parallel0: filename=vc
    serial0: filename=null
    compat_monitor0: filename=stdio
    serial1: filename=disconnected:unix:./serial-socket,server
    (qemu) info qtree
    [...]
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = "serial1"
        mmio ffffffffffffffff/0000000000001000
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = "serial0"
        mmio ffffffffffffffff/0000000000001000
    [...]

Nothing stops boards from rejecting extra -serial instead.  Perhaps
there's even one that does.

For -drive, we have generic code to detect and reject drives ignored by
the board.

Again, -serial none is not to be confused with -serial null:

    $ qemu-system-aarch64 -S -display none -monitor stdio -machine virt,secure -serial none -serial unix:./serial-socket,server,wait=off
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info chardev
    parallel0: filename=vc
    serial0: filename=disconnected:unix:./serial-socket,server
    compat_monitor0: filename=stdio
    (qemu) info qtree
    [...]
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = ""
        mmio ffffffffffffffff/0000000000001000
      dev: pl011, id ""
        gpio-out "sysbus-irq" 1
        chardev = "serial0"
        mmio ffffffffffffffff/0000000000001000
    [...]

Unlike -serial null, -serial none has no effect here.  Lovely, isn't it?

Note that -serial lets you control just *one* property of the pl011
device model: its backend.  I figure that's quite okay for pl011, but it
can be a problem in other cases.  One such case we saw in the memo that
started this thread: we need to control cfi.pflash01 property "secure",
but -drive if=pflash doesn't let us.  We work around that embarrassment
with

    -global driver=cfi.pflash01,property=secure,value=on

Affects *all* such devices, but fortunately we have at most two, and the
one we don't want to affect happens to ignore the property value.

For block devices, there's an additional issue: our ad hoc board
configuration mechanism (-drive) ties us to the legacy block backend
configuration mechanism (also -drive), with all its legacy baggage.
There is no way to use the modern mechanism (-blockdev) with onboard
devices.

Observe:

* Board configuration is totally different from our common device
  configuration mechanism.

* Each class of onboard device has its own ad hoc board configuration
  option (plus sugared forms in some cases).

* Each ad hoc board configuration option provides only selected
  properties common to all devices of this class.  Many device
  properties remain inaccessible.  Sometimes, we can use -global to work
  around, but not in the general case.

* We can't use -blockdev with onboard block devices, because the ad hoc
  board configuration option for block devices is -drive, with all its
  legacy baggage.  This is what made me write the memo that started this
  thread.

* Ad hoc configuration consistency checking is somewhat haphazard.
  Plenty of nonsense gets silently ignored.

>                                          And then the board
> code needs to do something for "if the user didn't create this
> then we need to do it", because the flash device should exist
> in the model whether the user cared about its contents or not.

True for mandatory onboard devices.  However, this flash device is *not*
mandatory.

If you ask for one flash device, you get OVMF firmware, and the image
you provide must be a unified build.

If you ask for two, you also get OVMF firmware, and the images you
provide must be a split build, unit 0 code, unit 1 data.

If you ask for more than two, you get an error.

If you ask for none, you get a traditional BIOS.

If you ask for both OVMF (with -drive if=pflash) and BIOS (with -bios),
you silently get OVMF.

If that makes you go "boy, this sucks", then I go "right you are."

Back to the issue that made me go down this rabbit hole: libvirt wants
to use -blockdev rather than -drive to configure their backends.

I tried to find a solution that doesn't involve redoing board
configuration from the ground up.  For better or worse, these devices
are optional.  So plug them with -device, and see what explodes.  Turns
out nor all that much, but still enough to make me post a lengthy memo.

You pointed out that using -device is "a mess because then the user has
to know the right base address".  You have a point.  But being stuck
with legacy -drive is also a mess.

For libvirt, plumbing the base address from the firmware's descriptor to
QEMU would be the lesser mess (for the firmware, providing the base
address there would be no mess at all).

For human users, it's perhaps the greater mess.  They can continue to
use -drive if=pflash.

Perhaps we *should* redo board configuration from the ground up.
Perhaps a board should be a composite object that exposes properties of
its own and its part, just like other composite devices, and so that
"create, set properties, realize" works.  That would extend our common
device configuration mechanism naturally to onboard devices.

Of course, "we should" doesn't imply "I could".

> Dynamic sysbus is something I'd rather we did less of, not more
> of. It's there because it solves an annoying problem (people
> want to do device passthrough of hardware that's not on a nice
> pluggable probeable bus), but it's really awkward.

>From 10,000ft, dynamic sysbus is no more awkward than other pluggable
devices: you (cold-)plug a device model by specifying a bunch of
properties.

[...]
