Received: from eggs.gnu.org ([2001:4830:134:3::10]:44902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGuAQ-00065B-Jz
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 15:59:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cGuAN-0004rl-EC
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 15:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cGuAN-0004rY-4v
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 15:59:15 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 675EC7F09D
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 20:59:13 +0000 (UTC)
Date: Tue, 13 Dec 2016 18:59:11 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161213205911.GD3808@thinpad.lan.raisama.net>
References: <20161208200737.GA29563@thinpad.lan.raisama.net>
	<87a8c0qedq.fsf@dusky.pond.sub.org>
	<20161213124239.GO3808@thinpad.lan.raisama.net>
	<87inqnli9l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87inqnli9l.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Dec 13, 2016 at 08:51:34PM +0100, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, Dec 13, 2016 at 12:04:17PM +0100, Markus Armbruster wrote:
> >> Quick interface review only:
> >> 
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > This adds a new command to QMP: query-device-slots. It will allow
> >> > management software to query possible slots where devices can be
> >> > plugged.
> >> >
> >> > This implementation of the command will return:
> >> >
> >> > * Multiple PCI slots per bus, in the case of PCI buses;
> >> > * One slot per bus in the case of the other buses;
> >> 
> >> Umm, that doesn't seem right.  For instance, a SCSI bus has multiple
> >> slots.  The slot address is the SCSI ID.  An IDE bus may have one (SATA)
> >> or two (PATA).  For more examples, see qdev-device-use.txt section
> >> "Specifying Bus and Address on Bus".
> >
> > Yes, I should have clarified that: this version changes only PCI
> > to expose multiple slots, but other buses also need be changed to
> > implement BusClass::enumerate_slots() properly, too.
> >
> >> 
> >> > * One slot for each entry from query-hotpluggable-cpus.
> >> > In the example below, I am not sure if the PCIe ports are all
> >> > supposed to report all slots, but I didn't find any existing
> >> > field in PCIBus that would help me figure out the actual number
> >> > of slots in a given PCI bus.
> >> >
> >> > Git tree
> >> > --------
> >> >
> >> > This patch needs the previous query-machines series I am working
> >> > on. The full tree can be found on the git tree at:
> >> >
> >> >   git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info
> >> >
> >> > Example output
> >> > --------------
> >> >
> >> > The following output was returned by QEMU when running it as:
> >> >
> >> >  $ qemu-system-x86_64 -machine q35 \
> >> >    -readconfig docs/q35-chipset.cfg \
> >> >    -smp 4,maxcpus=8,sockets=2,cores=2,threads=2
> >> >
> >> >  {
> >> >     "return": [
> >> 
> >> Are you sure >3000 lines of example output make sense here?
> >
> > I'm not. :)
> >
> > That's why I need feedback from the PCI experts. I believe most
> > of the PCI ports on q35 accept only one device, but I see no code
> > implementing that restriction, and no obvious PCIBus or
> > PCIBusClass field indicating that.
> >
> >> 
> >> [...]
> >> >     ]
> >> >   }
> >> >
> >> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> > ---
> >> >  qapi-schema.json       | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
> >> >  include/hw/qdev-core.h |   6 +++
> >> >  hw/core/bus.c          |  49 +++++++++++++++++++++
> >> >  hw/pci/pci.c           | 106 +++++++++++++++++++++++++++++++++------------
> >> >  qdev-monitor.c         |  86 ++++++++++++++++++++++++++++++++++---
> >> >  5 files changed, 328 insertions(+), 33 deletions(-)
> >> >
> >> > diff --git a/qapi-schema.json b/qapi-schema.json
> >> > index d48ff3f..484d91e 100644
> >> > --- a/qapi-schema.json
> >> > +++ b/qapi-schema.json
> >> > @@ -3166,6 +3166,120 @@
> >> >  { 'command': 'closefd', 'data': {'fdname': 'str'} }
> >> >  
> >> >  ##
> >> > +# @DeviceSlotType:
> >> > +#
> >> > +# Type of device slot
> >> > +#
> >> > +# @generic: Generic device slot, with no bus-specific information
> >> > +# @pci: PCI device slot
> >> > +# @cpu: CPU device slot
> >> > +##
> >> > +{ 'enum': 'DeviceSlotType',
> >> > +  'data': ['generic', 'pci', 'cpu'] }
> >> > +
> >> > +##
> >> > +# @DeviceSlotInfo:
> >> > +#
> >> > +# Information on a slot where devices can be plugged. Some buses
> >> > +# are represented as a single slot that can support multiple devices,
> >> > +# and some buses have multiple slots that are identified by arguments
> >> > +# to @device_add.
> >> 
> >> Okay, let me try to wrap my poor, ignorant mind around this.
> >> 
> >> There are two kinds of buses: "single slot that can support multiple
> >> devices", and "multiple slots that are identified by arguments".
> >> 
> >> How are the two kinds related to @type?
> >
> > They are related to @type indirectly because different bus types
> > will return different data. But I don't want to make this part of
> > the specification: clients should be prepared to handle both
> > cases.
> 
> Well, color me confused :)
> 
> > e.g. a QEMU version might return a single generic catch-all
> > sysbus-device slot that support any number of devices. Future
> > versions may return more detailed information, and return slots
> > only for the sysbus devices that really work with the machine.
> 
> Hmm.  See below.
> 
> >> 
> >> Examples for "multiple slots that are identified by arguments":
> >> 
> >>     -device edu,addr=06.0,bus=...
> >>     -device scsi-hd,scsi-hd=5,bus=...
> >>     -device ide-hd,unit=1,bus=...
> >>     -device virtserialport,nr=7,bus=...
> >> 
> >> Note that each of these buses has its own way to specify a slot address,
> >> namely a bus-specific option.
> >
> > Yes.
> >
> >> 
> >> Can you give examples for "single slot that can support multiple
> >> devices"?
> >
> > I can't name any example except sysbus, right now.
> 
> Sysbus is a bad example, because it's a hack, not a bus.
> 
> Physical devices are wired up in some device-specific way.  An important
> special wiring case is plugging into a standard socket provided by a
> bus.  But not every device is connected only to a bus.  Devices can also
> be wired to other devices in ad hoc ways.
> 
> In the initial qdev design, devices could only plug into buses.
> Anything that didn't fit the mold was declared to plug into the "system
> bus", which isn't a bus at all.
> 
> The hack used to be fairly harmless, because you couldn't do much with
> system bus devices anyway.  Not true anymore: Alex created means to add
> certain system bus devices to certain machines with -device.  Has been a
> thorn in my side ever since.  I'm afraid we need to understand how
> exactly it works before we can finalize the design for this command.

I agree it is a hack, I just wanted to be able to cover it too
(and possibly other cases where there's no obvious "address"
parameter to devices).

The other options I had were:
a) Omitting the bus from the output;
b) Waiting until we fix sysbus before implementing the interface.

I avoided (a) because I would like to tell libvirt "always check
query-device-slots before plugging anything. if it's not there,
it means you can't plug it". To do that, I would need to ensure
all buses are present in the list (even sysbus).

(But as I say below: I don't love this solution and I am open to
suggestions).

> 
> > There are two cases that I tried to cover by reporting
> > multiple-device no-argument slots:
> >
> > 1) Buses that were not converted (yet) to implement
> >    enumerate_buses() (in the current version: everything except
> >    PCI)
> > 2) Buses that really do not require any extra slot address
> >    argument (sysbus? others?)
> >
> > I'm proposing this interface because I don't want (1) or (2) to
> > be missing from the returned data (otherwise management software
> > can't differentiate "this bus is not available" from "this bus
> > simply doesn't implement slot enumeration yet").
> >
> > We won't need the special multi-device-slot case if we eliminate
> > all instances of (1) and (2). Can we do that in 2.9? I'm not
> > sure.
> 
> If we can't do a complete job, and we don't want to hide slots affected
> by that, the data we return for them should unequivocally state that
> it's incomplete because computing complete data hasn't been implemented,
> yet.

OK, so we agree we need a way to tell the client the data is
incomplete (or not as detailed as we would like).

I tried to solve that by providing a mechanism to tell the client
"look, I can tell you that there's a bus called <bus name>, and
it is valid to use it as the 'bus' argument for -device and
device_add, but I don't know the rest of the rules (sorry!)". We
can do that by simply including the bus on the list as if it was
a multi-device slot.

But I don't love this solution, so I am open to other suggestions
on how to tell the client that slot information is incomplete for
a bus.

Maybe the following?

1) Add a new DeviceSlotType value meaning "this entry represents
   a bus/device-type that can't enumerate its slots" (let's call
   it "bus-with-no-slot-info" by now).
2) Remove DeviceSlotType "generic".
3) Remove max-devices field, and simply document the device-limit
   semantics for each DeviceSlotType (cpu: 1 device, pci: 1
   device, bus-with-no-slot-info: undefined limit).

This looks like a trade-off between moving data to specific union
types (and representing type-specific limits/rules in the schema
documentation), or moving data to the base union type (and
representing type-specific limits as data in the base union
type).

> 
> >> > +#
> >> > +# @bus: ID of the bus object where the device can be plugged. Optional,
> >> > +#       as some devices don't need a bus to be plugged (e.g. CPUs).
> >> > +#       Can be copied to the "bus" argument to @device_add.
> >> 
> >> Suggest something like "Can be used as value for @device_add's bus
> >> option".
> >
> > Will do.
> >
> >> 
> >> Should we give similar information on the slot address?  The option name
> >> is obvious.  What about acceptable values?
> >
> > Actually, this part of the documentation was a leftover from a
> > previous version where @bus was inside DeviceSlotInfo. Now I
> > moved @bus inside @props for all device types, and it should be
> > documented the same way as the other fields inside @props.
> >
> >> 
> >> > +#
> >> > +# @type: type of device slot.
> >> > +#
> >> > +# @accepted-device-types: List of device types accepted by the slot.
> >> > +#                         Any device plugged to the slot should implement
> >> > +#                         one of the accepted device types.
> >> > +#
> >> > +# @max-devices: #optional maximum number of devices that can be plugged
> >> > +#               to the slot.
> >> 
> >> What does it mean when @max-devices isn't given?
> >
> > It means there is no hard limit on the number of pluggable
> > devices. sysbus is one of such cases.
> 
> Sysbus certainly has limits, but they're more complicated than just "at
> most @max-devices devices".
> 
> >> > +#
> >> > +# @devices: List of QOM paths for devices that are already plugged.
> >> > +#
> >> > +# @available: If false, the slot is not available for plugging any device.
> >> > +#             This value can change at runtime if condition changes
> >> > +#             (e.g. if the device becomes full, or if the machine
> >> > +#             was already initialized and the slot doesn't support
> >> > +#             hotplug).
> >> > +#
> >> > +# @hotpluggable: If true, the slot accepts hotplugged devices.
> >> > +#
> >> > +# DeviceSlotInfo structs always have a @props member, whose members
> >> > +# can be directly copied to the arguments to @device_add.
> >> 
> >> Do you mean names of properties common to all @accepted-device-types?
> >
> > I mean that it should be safe to simply use the keys+values in
> > @props as arguments to device_add or -device, for any slot @type.
> > Some clients may want to extract some information from @props (if
> > they already manage PCI addresses, for example), but some of them
> > may simply choose any available slot and copy @props blindly.
> >
> > I didn't want to state anything about QOM properties, because I
> > only want @props to represent device_add/-device arguments. Some
> > of those arguments are consumed by the device_add code itself
> > (e.g. "bus") and others are translated to QOM properties. I don't
> > want the interface to impose any restrictions on how this is
> > implemented.
> 
> Hmm, is this meant to work as follows?  To plug a device into this slot,
> you use
> 
>     { "execute": "device_add",
>       "arguments": { "driver": TYPE, ... PROPS ... }
> 
> where TYPE is a (concrete subtype of a) member of
> @accepted-device-types, and PROPS is the value of @props spliced in.
> Example: the data for slot 06.0 of PCI bus pci.0 would be something like
> 
>     {
>       "bus": "pci.0",

There's no "bus" field in DeviceSlotInfo. It was a documentation bug.

>       "props": {
>           "bus": "pci.0",
>           "addr": "06.0"
>       }
>     }
> 
> Doesn't match your example output; I guess I'm still misunderstanding
> something.

This is a busy PCI slot, from my example:

        {
            "available": false,
            "devices": [
                "/machine/q35/mch"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 0
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },

This is an empty PCI slot from my example. It has available=false because
hotplug is not supported on the root bus:

        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"  
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 32
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },

This is an empty PCI slot on pc_piix (not on my example):

        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/i440fx/pci.0",
                "addr": 32
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },

This is a free PCIe slot, from my example:

        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 0
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },

Note that it returns the uint32 value of "addr" (there's some magic on the
devfn setter to make it accept both "<slot>[.<function>]" strings and <devfn>
integers. On the next version, I plan to fix this insanity and replace "addr"
with proper "slot" and "function" integer properties. (See FIXME below)

> 
> >
> >> 
> >> > +##
> >> > +{ 'union': 'DeviceSlotInfo',
> >> > +  'base': { 'type': 'DeviceSlotType',
> >> > +            'accepted-device-types': [ 'str' ],
> >> > +            '*max-devices': 'int', 'devices': [ 'str' ],
> >> > +            'available': 'bool', 'hotpluggable': 'bool' },
> >> > +  'discriminator': 'type',
> >> > +  'data': { 'generic': 'GenericSlotInfo',
> >> > +            'pci': 'PCISlotInfo',
> >> > +            'cpu': 'CPUSlotInfo' } }
> >> > +
> >> > +##
> >> > +# @GenericSlotProperties:
> >> > +##
> >> > +{ 'struct': 'GenericSlotProperties',
> >> > +  'data': { 'bus': 'str' } }
> >> > +
> >> > +
> >> > +##
> >> > +# @GenericSlotInfo:
> >> > +#
> >> > +# Generic slot information, with no bus-specific information
> >> > +##
> >> > +{ 'struct': 'GenericSlotInfo',
> >> > +  'data': { 'props': 'GenericSlotProperties' } }
> >> > +
> >> > +##
> >> > +# @PCIDeviceSlotProperties:
> >> > +#
> >> > +# Properties that can be set when plugging a PCI device.
> >> > +#
> >> > +# @addr: "addr" argument to @device_add.
> >> > +#
> >> > +#FIXME: replace @addr with slot and function properties.
> >> > +##
> >> > +{ 'struct': 'PCIDeviceSlotProperties',
> >> > +  'data': { 'bus': 'str', 'addr': 'int' } }
> >> > +
> >> > +##
> >> > +# @PCISlotInfo:
> >> > +#
> >> > +# Information on a PCI device slot.
> >> > +#
> >> > +# @props: The @device_add arguments that can be used when plugging
> >> > +# the device.
> >> > +##
> >> > +{ 'struct': 'PCISlotInfo',
> >> > +  'data': { 'props': 'PCIDeviceSlotProperties' } }
> >> > +
> >> > +##
> >> > +# @CPUSlotInfo:
> >> > +#
> >> > +# Information on a CPU device slot.
> >> > +#
> >> > +# @props: The @device_add arguments that can be used when plugging
> >> > +# the device.
> >> > +##
> >> > +{ 'struct': 'CPUSlotInfo',
> >> > +  'data': { 'props': 'CpuInstanceProperties' } }
> >> > +
> >> > +##
> >> > +# @query-device-slots:
> >> > +#
> >> > +# Return the list of possible slots for plugging devices using
> >> > +# @device_add.
> >> > +##
> >> > +{ 'command': 'query-device-slots',
> >> > +  'returns': [ 'DeviceSlotInfo' ] }
> >> > +
> >> > +##
> >> >  # @MachineBusInfo
> >> >  #
> >> >  # Information about a bus present on a machine.
> >> [...]

-- 
Eduardo
