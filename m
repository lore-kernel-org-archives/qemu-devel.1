Received: from eggs.gnu.org ([2001:4830:134:3::10]:33909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGksi-0002XZ-JV
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGksf-0001CB-9x
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGksf-0001Bq-0z
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:04:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13C9189C31
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 11:04:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20161208200737.GA29563@thinpad.lan.raisama.net>
Date: Tue, 13 Dec 2016 12:04:17 +0100
In-Reply-To: <20161208200737.GA29563@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Thu, 8 Dec 2016 18:07:37 -0200")
Message-ID: <87a8c0qedq.fsf@dusky.pond.sub.org>
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

Quick interface review only:

Eduardo Habkost <ehabkost@redhat.com> writes:

> This adds a new command to QMP: query-device-slots. It will allow
> management software to query possible slots where devices can be
> plugged.
>
> This implementation of the command will return:
>
> * Multiple PCI slots per bus, in the case of PCI buses;
> * One slot per bus in the case of the other buses;

Umm, that doesn't seem right.  For instance, a SCSI bus has multiple
slots.  The slot address is the SCSI ID.  An IDE bus may have one (SATA)
or two (PATA).  For more examples, see qdev-device-use.txt section
"Specifying Bus and Address on Bus".

> * One slot for each entry from query-hotpluggable-cpus.
> In the example below, I am not sure if the PCIe ports are all
> supposed to report all slots, but I didn't find any existing
> field in PCIBus that would help me figure out the actual number
> of slots in a given PCI bus.
>
> Git tree
> --------
>
> This patch needs the previous query-machines series I am working
> on. The full tree can be found on the git tree at:
>
>   git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info
>
> Example output
> --------------
>
> The following output was returned by QEMU when running it as:
>
>  $ qemu-system-x86_64 -machine q35 \
>    -readconfig docs/q35-chipset.cfg \
>    -smp 4,maxcpus=8,sockets=2,cores=2,threads=2
>
>  {
>     "return": [

Are you sure >3000 lines of example output make sense here?

[...]
>     ]
>   }
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi-schema.json       | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/qdev-core.h |   6 +++
>  hw/core/bus.c          |  49 +++++++++++++++++++++
>  hw/pci/pci.c           | 106 +++++++++++++++++++++++++++++++++------------
>  qdev-monitor.c         |  86 ++++++++++++++++++++++++++++++++++---
>  5 files changed, 328 insertions(+), 33 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index d48ff3f..484d91e 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3166,6 +3166,120 @@
>  { 'command': 'closefd', 'data': {'fdname': 'str'} }
>  
>  ##
> +# @DeviceSlotType:
> +#
> +# Type of device slot
> +#
> +# @generic: Generic device slot, with no bus-specific information
> +# @pci: PCI device slot
> +# @cpu: CPU device slot
> +##
> +{ 'enum': 'DeviceSlotType',
> +  'data': ['generic', 'pci', 'cpu'] }
> +
> +##
> +# @DeviceSlotInfo:
> +#
> +# Information on a slot where devices can be plugged. Some buses
> +# are represented as a single slot that can support multiple devices,
> +# and some buses have multiple slots that are identified by arguments
> +# to @device_add.

Okay, let me try to wrap my poor, ignorant mind around this.

There are two kinds of buses: "single slot that can support multiple
devices", and "multiple slots that are identified by arguments".

How are the two kinds related to @type?

Examples for "multiple slots that are identified by arguments":

    -device edu,addr=06.0,bus=...
    -device scsi-hd,scsi-hd=5,bus=...
    -device ide-hd,unit=1,bus=...
    -device virtserialport,nr=7,bus=...

Note that each of these buses has its own way to specify a slot address,
namely a bus-specific option.

Can you give examples for "single slot that can support multiple
devices"?

> +#
> +# @bus: ID of the bus object where the device can be plugged. Optional,
> +#       as some devices don't need a bus to be plugged (e.g. CPUs).
> +#       Can be copied to the "bus" argument to @device_add.

Suggest something like "Can be used as value for @device_add's bus
option".

Should we give similar information on the slot address?  The option name
is obvious.  What about acceptable values?

> +#
> +# @type: type of device slot.
> +#
> +# @accepted-device-types: List of device types accepted by the slot.
> +#                         Any device plugged to the slot should implement
> +#                         one of the accepted device types.
> +#
> +# @max-devices: #optional maximum number of devices that can be plugged
> +#               to the slot.

What does it mean when @max-devices isn't given?

> +#
> +# @devices: List of QOM paths for devices that are already plugged.
> +#
> +# @available: If false, the slot is not available for plugging any device.
> +#             This value can change at runtime if condition changes
> +#             (e.g. if the device becomes full, or if the machine
> +#             was already initialized and the slot doesn't support
> +#             hotplug).
> +#
> +# @hotpluggable: If true, the slot accepts hotplugged devices.
> +#
> +# DeviceSlotInfo structs always have a @props member, whose members
> +# can be directly copied to the arguments to @device_add.

Do you mean names of properties common to all @accepted-device-types?

> +##
> +{ 'union': 'DeviceSlotInfo',
> +  'base': { 'type': 'DeviceSlotType',
> +            'accepted-device-types': [ 'str' ],
> +            '*max-devices': 'int', 'devices': [ 'str' ],
> +            'available': 'bool', 'hotpluggable': 'bool' },
> +  'discriminator': 'type',
> +  'data': { 'generic': 'GenericSlotInfo',
> +            'pci': 'PCISlotInfo',
> +            'cpu': 'CPUSlotInfo' } }
> +
> +##
> +# @GenericSlotProperties:
> +##
> +{ 'struct': 'GenericSlotProperties',
> +  'data': { 'bus': 'str' } }
> +
> +
> +##
> +# @GenericSlotInfo:
> +#
> +# Generic slot information, with no bus-specific information
> +##
> +{ 'struct': 'GenericSlotInfo',
> +  'data': { 'props': 'GenericSlotProperties' } }
> +
> +##
> +# @PCIDeviceSlotProperties:
> +#
> +# Properties that can be set when plugging a PCI device.
> +#
> +# @addr: "addr" argument to @device_add.
> +#
> +#FIXME: replace @addr with slot and function properties.
> +##
> +{ 'struct': 'PCIDeviceSlotProperties',
> +  'data': { 'bus': 'str', 'addr': 'int' } }
> +
> +##
> +# @PCISlotInfo:
> +#
> +# Information on a PCI device slot.
> +#
> +# @props: The @device_add arguments that can be used when plugging
> +# the device.
> +##
> +{ 'struct': 'PCISlotInfo',
> +  'data': { 'props': 'PCIDeviceSlotProperties' } }
> +
> +##
> +# @CPUSlotInfo:
> +#
> +# Information on a CPU device slot.
> +#
> +# @props: The @device_add arguments that can be used when plugging
> +# the device.
> +##
> +{ 'struct': 'CPUSlotInfo',
> +  'data': { 'props': 'CpuInstanceProperties' } }
> +
> +##
> +# @query-device-slots:
> +#
> +# Return the list of possible slots for plugging devices using
> +# @device_add.
> +##
> +{ 'command': 'query-device-slots',
> +  'returns': [ 'DeviceSlotInfo' ] }
> +
> +##
>  # @MachineBusInfo
>  #
>  # Information about a bus present on a machine.
[...]
