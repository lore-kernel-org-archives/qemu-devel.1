Received: from eggs.gnu.org ([2001:4830:134:3::10]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHFtW-0002yY-EA
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:11:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cHFtS-0000yf-9G
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cHFtR-0000yP-WB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 15:11:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C77F461B97
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 20:11:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161208200737.GA29563@thinpad.lan.raisama.net>
	<87a8c0qedq.fsf@dusky.pond.sub.org>
	<20161213124239.GO3808@thinpad.lan.raisama.net>
	<87inqnli9l.fsf@dusky.pond.sub.org>
	<20161213205911.GD3808@thinpad.lan.raisama.net>
	<874m26frtf.fsf@dusky.pond.sub.org>
	<20161214164617.GI3808@thinpad.lan.raisama.net>
Date: Wed, 14 Dec 2016 21:11:10 +0100
In-Reply-To: <20161214164617.GI3808@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Wed, 14 Dec 2016 14:46:17 -0200")
Message-ID: <87wpf25l0h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Dec 14, 2016 at 04:34:04PM +0100, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Tue, Dec 13, 2016 at 08:51:34PM +0100, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> 
>> >> > On Tue, Dec 13, 2016 at 12:04:17PM +0100, Markus Armbruster wrote:
>> >> >> Quick interface review only:
>> >> >> 
>> >> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> >> 
>> >> >> > This adds a new command to QMP: query-device-slots. It will allow
>> >> >> > management software to query possible slots where devices can be
>> >> >> > plugged.
>> >> >> >
>> >> >> > This implementation of the command will return:
>> >> >> >
>> >> >> > * Multiple PCI slots per bus, in the case of PCI buses;
>> >> >> > * One slot per bus in the case of the other buses;
>> >> >> 
>> >> >> Umm, that doesn't seem right.  For instance, a SCSI bus has multiple
>> >> >> slots.  The slot address is the SCSI ID.  An IDE bus may have one (SATA)
>> >> >> or two (PATA).  For more examples, see qdev-device-use.txt section
>> >> >> "Specifying Bus and Address on Bus".
>> >> >
>> >> > Yes, I should have clarified that: this version changes only PCI
>> >> > to expose multiple slots, but other buses also need be changed to
>> >> > implement BusClass::enumerate_slots() properly, too.
>> >> >
>> >> >> 
>> >> >> > * One slot for each entry from query-hotpluggable-cpus.
>> >> >> > In the example below, I am not sure if the PCIe ports are all
>> >> >> > supposed to report all slots, but I didn't find any existing
>> >> >> > field in PCIBus that would help me figure out the actual number
>> >> >> > of slots in a given PCI bus.
>> >> >> >
>> >> >> > Git tree
>> >> >> > --------
>> >> >> >
>> >> >> > This patch needs the previous query-machines series I am working
>> >> >> > on. The full tree can be found on the git tree at:
>> >> >> >
>> >> >> >   git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info
>> >> >> >
>> >> >> > Example output
>> >> >> > --------------
>> >> >> >
>> >> >> > The following output was returned by QEMU when running it as:
>> >> >> >
>> >> >> >  $ qemu-system-x86_64 -machine q35 \
>> >> >> >    -readconfig docs/q35-chipset.cfg \
>> >> >> >    -smp 4,maxcpus=8,sockets=2,cores=2,threads=2
>> >> >> >
>> >> >> >  {
>> >> >> >     "return": [
>> >> >> 
>> >> >> Are you sure >3000 lines of example output make sense here?
>> >> >
>> >> > I'm not. :)
>> >> >
>> >> > That's why I need feedback from the PCI experts. I believe most
>> >> > of the PCI ports on q35 accept only one device, but I see no code
>> >> > implementing that restriction, and no obvious PCIBus or
>> >> > PCIBusClass field indicating that.
>> >> >
>> >> >> 
>> >> >> [...]
>> >> >> >     ]
>> >> >> >   }
>> >> >> >
>> >> >> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> >> >> > ---
>> >> >> >  qapi-schema.json       | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
>> >> >> >  include/hw/qdev-core.h |   6 +++
>> >> >> >  hw/core/bus.c          |  49 +++++++++++++++++++++
>> >> >> >  hw/pci/pci.c           | 106 +++++++++++++++++++++++++++++++++------------
>> >> >> >  qdev-monitor.c         |  86 ++++++++++++++++++++++++++++++++++---
>> >> >> >  5 files changed, 328 insertions(+), 33 deletions(-)
>> >> >> >
>> >> >> > diff --git a/qapi-schema.json b/qapi-schema.json
>> >> >> > index d48ff3f..484d91e 100644
>> >> >> > --- a/qapi-schema.json
>> >> >> > +++ b/qapi-schema.json
>> >> >> > @@ -3166,6 +3166,120 @@
>> >> >> >  { 'command': 'closefd', 'data': {'fdname': 'str'} }
>> >> >> >  
>> >> >> >  ##
>> >> >> > +# @DeviceSlotType:
>> >> >> > +#
>> >> >> > +# Type of device slot
>> >> >> > +#
>> >> >> > +# @generic: Generic device slot, with no bus-specific information
>> >> >> > +# @pci: PCI device slot
>> >> >> > +# @cpu: CPU device slot
>> >> >> > +##
>> >> >> > +{ 'enum': 'DeviceSlotType',
>> >> >> > +  'data': ['generic', 'pci', 'cpu'] }
>> >> >> > +
>> >> >> > +##
>> >> >> > +# @DeviceSlotInfo:
>> >> >> > +#
>> >> >> > +# Information on a slot where devices can be plugged. Some buses
>> >> >> > +# are represented as a single slot that can support multiple devices,
>> >> >> > +# and some buses have multiple slots that are identified by arguments
>> >> >> > +# to @device_add.
>> >> >> 
>> >> >> Okay, let me try to wrap my poor, ignorant mind around this.
>> >> >> 
>> >> >> There are two kinds of buses: "single slot that can support multiple
>> >> >> devices", and "multiple slots that are identified by arguments".
>> >> >> 
>> >> >> How are the two kinds related to @type?
>> >> >
>> >> > They are related to @type indirectly because different bus types
>> >> > will return different data. But I don't want to make this part of
>> >> > the specification: clients should be prepared to handle both
>> >> > cases.
>> >> 
>> >> Well, color me confused :)
>> >> 
>> >> > e.g. a QEMU version might return a single generic catch-all
>> >> > sysbus-device slot that support any number of devices. Future
>> >> > versions may return more detailed information, and return slots
>> >> > only for the sysbus devices that really work with the machine.
>> >> 
>> >> Hmm.  See below.
>> >> 
>> >> >> 
>> >> >> Examples for "multiple slots that are identified by arguments":
>> >> >> 
>> >> >>     -device edu,addr=06.0,bus=...
>> >> >>     -device scsi-hd,scsi-hd=5,bus=...
>> >> >>     -device ide-hd,unit=1,bus=...
>> >> >>     -device virtserialport,nr=7,bus=...
>> >> >> 
>> >> >> Note that each of these buses has its own way to specify a slot address,
>> >> >> namely a bus-specific option.
>> >> >
>> >> > Yes.
>> >> >
>> >> >> 
>> >> >> Can you give examples for "single slot that can support multiple
>> >> >> devices"?
>> >> >
>> >> > I can't name any example except sysbus, right now.
>> >> 
>> >> Sysbus is a bad example, because it's a hack, not a bus.
>> >> 
>> >> Physical devices are wired up in some device-specific way.  An important
>> >> special wiring case is plugging into a standard socket provided by a
>> >> bus.  But not every device is connected only to a bus.  Devices can also
>> >> be wired to other devices in ad hoc ways.
>> >> 
>> >> In the initial qdev design, devices could only plug into buses.
>> >> Anything that didn't fit the mold was declared to plug into the "system
>> >> bus", which isn't a bus at all.
>> >> 
>> >> The hack used to be fairly harmless, because you couldn't do much with
>> >> system bus devices anyway.  Not true anymore: Alex created means to add
>> >> certain system bus devices to certain machines with -device.  Has been a
>> >> thorn in my side ever since.  I'm afraid we need to understand how
>> >> exactly it works before we can finalize the design for this command.
>> >
>> > I agree it is a hack, I just wanted to be able to cover it too
>> > (and possibly other cases where there's no obvious "address"
>> > parameter to devices).
>> >
>> > The other options I had were:
>> > a) Omitting the bus from the output;
>> > b) Waiting until we fix sysbus before implementing the interface.
>> >
>> > I avoided (a) because I would like to tell libvirt "always check
>> > query-device-slots before plugging anything. if it's not there,
>> > it means you can't plug it". To do that, I would need to ensure
>> > all buses are present in the list (even sysbus).
>> >
>> > (But as I say below: I don't love this solution and I am open to
>> > suggestions).
>> 
>> I'm okay with doing (c) including all buses, with full information for
>> only some.  As long as the case "no full information" is clearly
>> separate, and appropriately documented.  Then we can tell libvirt to
>> always check query-device-slots, and if it has full information, use
>> that.  Else, falling back to hardcoded strategies is okay, similar to
>> what's done when command query-device-slots doesn't exist.
>
> Understood.
>
>> 
>> >> > There are two cases that I tried to cover by reporting
>> >> > multiple-device no-argument slots:
>> >> >
>> >> > 1) Buses that were not converted (yet) to implement
>> >> >    enumerate_buses() (in the current version: everything except
>> >> >    PCI)
>> >> > 2) Buses that really do not require any extra slot address
>> >> >    argument (sysbus? others?)
>> >> >
>> >> > I'm proposing this interface because I don't want (1) or (2) to
>> >> > be missing from the returned data (otherwise management software
>> >> > can't differentiate "this bus is not available" from "this bus
>> >> > simply doesn't implement slot enumeration yet").
>> >> >
>> >> > We won't need the special multi-device-slot case if we eliminate
>> >> > all instances of (1) and (2). Can we do that in 2.9? I'm not
>> >> > sure.
>> >> 
>> >> If we can't do a complete job, and we don't want to hide slots affected
>> >> by that, the data we return for them should unequivocally state that
>> >> it's incomplete because computing complete data hasn't been implemented,
>> >> yet.
>> >
>> > OK, so we agree we need a way to tell the client the data is
>> > incomplete (or not as detailed as we would like).
>> 
>> Yes.
>> 
>> > I tried to solve that by providing a mechanism to tell the client
>> > "look, I can tell you that there's a bus called <bus name>, and
>> > it is valid to use it as the 'bus' argument for -device and
>> > device_add, but I don't know the rest of the rules (sorry!)". We
>> > can do that by simply including the bus on the list as if it was
>> > a multi-device slot.
>> 
>> What if we ever run into a kind of slot where the full information is
>> "use this 'bus' argument" and "you can plug in multiple devices"?
>> Wouldn't that be indistinguishable from "full information isn't
>> available"?
>> 
>> Let's make "full information isn't available" impossible to confuse with
>> any conceivable set of full information.
>
> I see. I tried to model it in a way that "incomplete information"
> was not considered an exception, just an instance where the data
> is less informative. But adding another bit of information that
> explicitly says "this in incomplete and will probably change in
> the future" is a good idea.
>
>> 
>> > But I don't love this solution, so I am open to other suggestions
>> > on how to tell the client that slot information is incomplete for
>> > a bus.
>> >
>> > Maybe the following?
>> >
>> > 1) Add a new DeviceSlotType value meaning "this entry represents
>> >    a bus/device-type that can't enumerate its slots" (let's call
>> >    it "bus-with-no-slot-info" by now).
>> 
>> Let's call this one a non-slot, for brevity.
>
> I like that name. :)
>
>> 
>> > 2) Remove DeviceSlotType "generic".
>> > 3) Remove max-devices field, and simply document the device-limit
>> >    semantics for each DeviceSlotType (cpu: 1 device, pci: 1
>> >    device, bus-with-no-slot-info: undefined limit).
>> 
>> Not sure there's much to document.  For me a slot takes exactly one plug
>> by definition (if it can take more, it's a set of slots, isn't it?), and
>> non-slots take an unknown number of plugs by definition (if we knew,
>> we'd return suitable slots instead).  But that's mincing words; I'm sure
>> we can come up with language that works for both of us.
>
> I am trying to not make any guarantees about all slot types,
> until we learn more about the more complex cases. All we can say
> right now is that CPU and PCI slots support only 1 device, and we
> don't claim anything about others.

Sane physical buses generally have a "device address" concept: a device
on the bus is identified by its (unique) device address.  For instance,
SCSI has scsi-id, and PCI has device number.

Less-than-sane buses exist, such as the (pre-PnP) ISA "bus": there's no
device address that satisfies my definition.

> I'm not even 100% sure about the 1-device rule for PCI, as each
> PCI function in a slot is a separate DeviceState*. I need to
> understand how multi-function PCI hotplug works, to find out what
> we should do.

*Real* PCI devices consist of function 0 and optionally additional
functions.  The device gets plugged as a whole (d'oh) into a slot with a
specific device address.  Note that the dev.fn address addresses a
*function*, not a device.

The way QEMU models this is "madness, yet there is method in't".  A PCI
qdev models a PCI *function*, not a PCI device.  It gets plugged into a
PCI qbus "slot" with a specific *function* address (dev.fn).  The
functions that share the dev part of the function address together form
a PCI device.  You have to plug something into function 0 for this to
work.  Sufficiently weird function combinations might conceivably
confuse software.  If I remember correctly, you have to hot-plug
function 0 last (actually triggers the device hot-plug), and
hot-unplugging function 0 yanks out all the functions.

When a device has just one function, which is a fairly common case, then
you can pretend the PCI qdev is a PCI device.

So, what are the slots provided by a PCI (not PCIe) bus?  A *real* one
provides 32 *device* slots.  A qbus, however, provides 256 *function*
"slots".

How should query-device-slots report this?  All 256 function "slots", or
just the 32 function 0 slots?  Since management software needs to know
about the PCI qdev madness anyway, I'd say just the 32.

Same question for PCIe, with and without ARI.

If we had had QOM back when we made this mess, we'd have designed PCI
devices as a composition of PCI functions.  At least I hope we'd have.
With such a design, we'd assemble functions into a device, then plug the
device.  A slot would then be the same as for a real bus.

> I worry about having a general 1-slot = 1-device rule from the
> beginning, because I don't know if it can be a problem when the
> set of possible slots is too large. e.g.: should we return one
> slot for each of the 256 possible devfns in a PCI bus? What if a
> bus uses 32-bit identifiers for devices?
>
> My suggestion is to avoid any general claims about device limits
> in slots in the documentation by now, until we have more
> knowledge about other bus types.

For me, a slot can't take more than one device.  Something that can
isn't a slot, it's a set of slots.

Comitting to a design now that models this as a "slot" that can take
multiple devices seems premature.  We really have no idea whether that
would work!

But you made a good point: set of slots too large to permit
query-device-slots enumerating its members may exist.

Enumerating members is just one way to describe a set.  An algorithm to
generate the members is another.

Let's try for your hypothetical bus with 2^32 slots, each identified by
an unsigned 32-bit number.  Say the syntax is bus=BUSNAME,addr=UINT32.
We need to describe bus=BUSNAME,addr=UINT32.  The bus=BUSNAME part is
simple enough: "props" contains a member "bus": "BUSNAME".  For the
addr=UINT32 part, we'll have to invent suitable language to express "any
integer between 0 and 2^32-1".

I believe this will be easier when the information for all slots is
otherwise identical.  If it is, we can describe all 2^32 slots in one
dictionary.  But if slot#7 and slot#42..666 are different, we need
multiple, and probably a more complex language for slot addresses, to
express things like "any integer between 0 and 2^32-1, except for 7 and
42..666".

Note that including information on currently plugged devices makes slot
information different.

Let's take a step back and consider what we want to achieve with
query-device-slots.  I think the core objective is to let libvirt know:

* What slots exist

* What devices can be plugged into each slot

* Whether plugging / unplugging is possible right now

* What arguments need to be used to plug something into a specific slot

Your RFC design provides additional information, namely

* Currently plugged devices

  I'd expect this to be redundant with other queries, such as QOM
  introspection.

* Whether hot-plug is possible

  If the machine has been started already, this is the same as whether
  plugging / unplugging is possible right now.

  Else, it permits predicting whether it will be possible once the
  machine is started.  Perhaps that's important to know, perhaps not.

* Perhaps (I'm not sure) even internal-only slots, i.e. ones that can
  never be used with device_add.

Let's focus on the core objective and completely ignore the additional
information for now.

>> > This looks like a trade-off between moving data to specific union
>> > types (and representing type-specific limits/rules in the schema
>> > documentation), or moving data to the base union type (and
>> > representing type-specific limits as data in the base union
>> > type).
>> 
>> Works for me.
>> 
>> Additionally, let's replace 'devices': [ 'str' ] by '*device': 'str',
>> because a slot is either empty or has one device plugged in.
>> 
>> If we ever need to add a set-of-slots type, we'll have to extend the
>> schema, but then we'll be in a much better position to know what we
>> actually need.
>> 
>
> I am working on a version that even removes 'devices', for
> simplicity. Then we would have more freedom when extending the
> schema later.

Yes, please.

>> >> >> > +#
>> >> >> > +# @bus: ID of the bus object where the device can be plugged. Optional,
>> >> >> > +#       as some devices don't need a bus to be plugged (e.g. CPUs).
>> >> >> > +#       Can be copied to the "bus" argument to @device_add.
>> >> >> 
>> >> >> Suggest something like "Can be used as value for @device_add's bus
>> >> >> option".
>> >> >
>> >> > Will do.
>> >> >
>> >> >> 
>> >> >> Should we give similar information on the slot address?  The option name
>> >> >> is obvious.  What about acceptable values?
>> >> >
>> >> > Actually, this part of the documentation was a leftover from a
>> >> > previous version where @bus was inside DeviceSlotInfo. Now I
>> >> > moved @bus inside @props for all device types, and it should be
>> >> > documented the same way as the other fields inside @props.
>> >> >
>> >> >> 
>> >> >> > +#
>> >> >> > +# @type: type of device slot.
>> >> >> > +#
>> >> >> > +# @accepted-device-types: List of device types accepted by the slot.
>> >> >> > +#                         Any device plugged to the slot should implement
>> >> >> > +#                         one of the accepted device types.
>> >> >> > +#
>> >> >> > +# @max-devices: #optional maximum number of devices that can be plugged
>> >> >> > +#               to the slot.
>> >> >> 
>> >> >> What does it mean when @max-devices isn't given?
>> >> >
>> >> > It means there is no hard limit on the number of pluggable
>> >> > devices. sysbus is one of such cases.
>> >> 
>> >> Sysbus certainly has limits, but they're more complicated than just "at
>> >> most @max-devices devices".
>> >> 
>> >> >> > +#
>> >> >> > +# @devices: List of QOM paths for devices that are already plugged.
>> >> >> > +#
>> >> >> > +# @available: If false, the slot is not available for plugging any device.
>> >> >> > +#             This value can change at runtime if condition changes
>> >> >> > +#             (e.g. if the device becomes full, or if the machine
>> >> >> > +#             was already initialized and the slot doesn't support
>> >> >> > +#             hotplug).
>> >> >> > +#
>> >> >> > +# @hotpluggable: If true, the slot accepts hotplugged devices.
>> >> >> > +#
>> >> >> > +# DeviceSlotInfo structs always have a @props member, whose members
>> >> >> > +# can be directly copied to the arguments to @device_add.
>> >> >> 
>> >> >> Do you mean names of properties common to all @accepted-device-types?
>> >> >
>> >> > I mean that it should be safe to simply use the keys+values in
>> >> > @props as arguments to device_add or -device, for any slot @type.
>> >> > Some clients may want to extract some information from @props (if
>> >> > they already manage PCI addresses, for example), but some of them
>> >> > may simply choose any available slot and copy @props blindly.
>> >> >
>> >> > I didn't want to state anything about QOM properties, because I
>> >> > only want @props to represent device_add/-device arguments. Some
>> >> > of those arguments are consumed by the device_add code itself
>> >> > (e.g. "bus") and others are translated to QOM properties. I don't
>> >> > want the interface to impose any restrictions on how this is
>> >> > implemented.
>> >> 
>> >> Hmm, is this meant to work as follows?  To plug a device into this slot,
>> >> you use
>> >> 
>> >>     { "execute": "device_add",
>> >>       "arguments": { "driver": TYPE, ... PROPS ... }
>> >> 
>> >> where TYPE is a (concrete subtype of a) member of
>> >> @accepted-device-types, and PROPS is the value of @props spliced in.
>> >> Example: the data for slot 06.0 of PCI bus pci.0 would be something like
>> >> 
>> >>     {
>> >>       "bus": "pci.0",
>> >
>> > There's no "bus" field in DeviceSlotInfo. It was a documentation bug.
>> 
>> Should read code, not docs ;)
>> 
>> >>       "props": {
>> >>           "bus": "pci.0",
>> >>           "addr": "06.0"
>> >>       }
>> >>     }
>> >> 
>> >> Doesn't match your example output; I guess I'm still misunderstanding
>> >> something.
>> >
>> > This is a busy PCI slot, from my example:
>> >
>> >         {
>> >             "available": false,
>> >             "devices": [
>> >                 "/machine/q35/mch"
>> >             ],
>> >             "accepted-device-types": [
>> >                 "legacy-pci-device",
>> >                 "pci-express-device"
>> >             ],
>> >             "props": {
>> >                 "bus": "/machine/q35/pcie.0",
>> 
>> Does device_add device_add bus=/machine/q35/pcie.0 even work?  I know
>> qbus_find() interprets /-separated paths, but their semantics are FUBAR
>> (I can find details if you're curious).  We've long advised to use only
>> values without '/', like bus=pcie.0.
>
> @device_add documentation says:
>
> # @bus: #optional the device's parent bus (device tree path)

The line is a recent addition (commit 94cfd07).  Note "device tree
path", not "QOM path".  I think it should either not mention paths at
all, or advise people to stick to qdev IDs.

>> Now, QOM gives us a framework for interpreting paths sanely.  Switching
>> the value of bus to QOM paths would be a compatibility break, though.
>> Matters only if the botched /-paths are actually used.
>
> I would be happy to use the bus name instead of the full path,
> but I don't see any code that ensures that bus names are really
> unique. Is there any existing mechanism to ensure that?

Kind of.  qbus names are typically derived from the providing device's
qdev ID, which is unique.  When they're not, clashes *are* possible.  We
used to have one with -m isapc: the two IDE buses are provided by
separate isa-ide qdevs, and both qbuses were named ide.0.  Fixed in
commit 61de36.  Now the first one to register becomes ide.0, and the
second one ide.1.  I'm not fond of such implicit naming, but we got
bigger fish to fry.

Perhaps we should sidestep this mess and use QOM paths.

>> >                 "addr": 0
>> >             },
>> >             "hotpluggable": false,
>> >             "type": "pci",
>> >             "max-devices": 1
>> >         },
[...]
