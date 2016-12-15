Received: from eggs.gnu.org ([2001:4830:134:3::10]:37550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHbkW-0006w7-BQ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHbkS-00013l-97
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cHbkS-00012u-0T
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 14:31:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE96764DA1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 19:31:22 +0000 (UTC)
Date: Thu, 15 Dec 2016 17:31:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161215193120.GS3808@thinpad.lan.raisama.net>
References: <1481744348-8868-1-git-send-email-ehabkost@redhat.com>
	<87r3591i4d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r3591i4d.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC v2] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>, Laine Stump <laine@redhat.com>

On Thu, Dec 15, 2016 at 01:39:30PM +0100, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > This adds a new command to QMP: query-device-slots. It will allow
> > management software to query possible slots where devices can be
> > plugged.
> >
> > This implementation of the command will return:
> >
> > * Multiple PCI slots per bus, in the case of PCI buses;
> > * One slot per bus for the other buses (that don't
> >   implement slot enumeration yet);
> > * One slot for each entry from query-hotpluggable-cpus.
> >
> > Git tree
> > --------
> >
> > This patch needs the previous query-machines series I am working
> > on. The full tree can be found on the git tree at:
> >
> >   git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info
> >
> > Example output
> > --------------
> >
> > The following output was returned by QEMU when running it as:
> >
> >  $ qemu-system-x86_64 -machine q35 \
> >    -readconfig docs/q35-chipset.cfg \
> >    -smp 4,maxcpus=8,sockets=2,cores=2,threads=2
> >
> >   {
> >     "return": [
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "i2c"
> 
> Missing: bus "i2c-bus" device address, property name "address", value
> 0..255.
> 
> >             },
> >             "type": "non-slot",
> 
> I guess "non-slot" means "props" is incomplete, but the rest should be
> okay.

Yes, non-slot is explicitly documented as incomplete.

> 
> >             "accepted-device-types": [
> >                 "i2c-slave"
> >             ]
> >         },
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "ide.4"
> 
> Bus "IDE" device address property "unit", value 0 (because this is SATA,
> for PATA it would be 0..1).
> 
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "ide-device"
> >             ]
> >         },
> [...]
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "main-system-bus"
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "sys-bus-device"
> >             ]
> >         },
> 
> Can't give guidance on this one, I'm afraid.

So, the good news here seems to be: very few machines-type accept
sysbus devices on -device. This means we can investigate why
exactly we set has_dynamic_sysbus=true on some machine-types
(maybe this will be obvious from the git log, maybe it won't, but
I'm feeling optimistic today), manually whitelist the (hopefully)
few device types that can be created dynamically, create specific
slots for them, and hide sysbus completely from clients.

> 
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "isa.0"
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "isa-device"
> >             ]
> >         },
> 
> Bus "ISA" is iffy, too.
> 
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "pcie.0",
> >                 "device-number": 0
> 
> Really?  "device_add e1000e,help" shows now property "device-number".
> Oh, I see, you're adding it in this patch, along with "function".

Yes. But I am still not sure about how to model/describe
"function". Should we say that (device-number=0, function=0) and
(device-number=0, function=1) are part of the same "slot", or two
different slots?

If we implement something to easily represent slot sets, it will
be easier to represent each PCI function as a separate slot.

> 
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "legacy-pci-device",
> >                 "pci-express-device"
> >             ]
> >         },
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "pcie.0",
> >                 "device-number": 1
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "legacy-pci-device",
> >                 "pci-express-device"
> >             ]
> >         },
> [...]
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "pcie.0",
> >                 "device-number": 31
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "legacy-pci-device",
> >                 "pci-express-device"
> >             ]
> >         },
> 
> Design question: do we need to describe the bus with 32 separate
> objects, or would a single object do?  The objects only differ in the
> value of props.device-number...
> 
> For a hypothetical bus with uint32_t device addresses, separate objects
> would be impossible.  So we probably need to describe slot sets, anyway.

My question is: do we need to describe slots sets in the first
version, or can we do it as an extension later?

> 
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-pcie-port-1",
> >                 "device-number": 0
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "pci-express-device"
> >             ]
> >         },
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-pcie-port-2",
> >                 "device-number": 0
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "pci-express-device"
> >             ]
> >         },
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-pcie-port-3",
> >                 "device-number": 0
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "pci-express-device"
> >             ]
> >         },
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-pcie-port-4",
> >                 "device-number": 0
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "pci-express-device"
> >             ]
> >         },
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "ich9-pci-bridge",
> >                 "device-number": 0
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "legacy-pci-device"
> >             ]
> >         },
> [...]
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "ich9-pci-bridge",
> >                 "device-number": 31
> >             },
> >             "type": "pci",
> >             "accepted-device-types": [
> >                 "legacy-pci-device"
> >             ]
> >         },
> 
> Likewise.
> 
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-ehci-1.0"
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "usb-device"
> >             ]
> >         },
> 
> Okay, more bad news: bus "usb-bus" device address property is "port",
> value is a sequence of port numbers separated by '.'.  The reason is
> "convenience"
> 
> A real USB host controller has a fixed number of ports, numbered 1..N.
> This one has six.
> 
> A real USB hub device plugs into a port and in turn provides a fixed
> number of ports, numbered 1..N.  The USB hub device we model provides
> eight.
> 
> An obvious way to model this would be to have the host controller
> provide a bus with a fixed number of slots, and the usb-hub provide a
> separate bus with eight.  This is how we do PCI bridges.  But it's not
> how we do USB hubs.
> 
> Host software can treat the tree formed by USB host controller, hubs and
> other devices as a single bus, and that's how we model it.
> 
> A "port" value that is a single number addresses that port on the host
> controller.
> 
> A value containing '.' addresses something behind a hub.  The leftmost
> number addresses a host controller port.  A hub must be plugged in
> there.  Recurse for the rest of the port string.
> 
> If you device_add an USB device without specifying a port, it picks an
> unused one.  When it has to pick the last port, it tries to add a
> usb-hub device there, which provides eight ports, then picks a port for
> your device.  If adding the usb-hub succeeds, it'll get the new hub's
> port 1.  Else, it gets the last port.  There's a hard-coded limit of
> five on the depth of the hub chain.  So, if you keep adding USB devices
> to the bus provided by ich9-ehci, the first five go into ports "1", ...,
> "5", the sixth goes into "6.1" (with usb-hub in port "6"), and so forth,
> until the 41st goes into "6.8.8.8.8.8".  Adding hubs manually permits
> more devices.

I assume we won't need to represent the automagic port creation
rules in the query. Only the next case:

> 
> If you do specify "port", then that port must already exist.
> 

So, hubs are _not_ created automatically at ports "A", "A.B" and
"A.B.C" if I explicitly try to plug something to port "A.B.C.D"?
That's good news, because then we can simply represent only the
available ports.

> I think the sanest way to represent the existing ports is enumerating
> them, like this:
> 
>           {
>               "available": true,
>               "hotpluggable": true,
>               "props": {
>                   "bus": "ich9-ehci-1.0", "port": "1"
>               },
>               "type": "usb",
>               "accepted-device-types": [
>                   "usb-device"
>               ]
>           },
>           [...]
>           {
>               "available": true,
>               "hotpluggable": true,
>               "props": {
>                   "bus": "ich9-ehci-1.0", "port": "6"
>               },
>               "type": "usb",
>               "accepted-device-types": [
>                   "usb-device"
>               ]
>           },
> 
> Plugging usb-hub into a port with port: "P" then flips that port's
> "available" to false, and adds eight new ports with "port": "P.1",
> ... "P.8".
> 
> So, plugging a device can not only add buses provided by the device, but
> also, and less obviously, add slots to the bus it plugs into!  Likewise
> for unplug.

Interesting.

> 
> Perhaps we should emit events when slots come and go.

Perhaps. Should we leave this for later?

FWIW, the problem I am trying to solve right now is querying for
machine-type capabilities before creating the VM. The runtime
querying command in this patch is just the first step. Then I
plan to also return DeviceSlotInfo for machine-types just like
the "query-machines"/"available-buses" series I sent.

> 
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "bus": "ich9-ehci-2.0"
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "usb-device"
> >             ]
> >         },
> >         {
> >             "available": false,
> >             "hotpluggable": false,
> >             "props": {
> >                 "bus": "ich9-hda-audio.0"
> 
> Bus "HDA" device address property is "cad", value 0..14.
> 
> >             },
> >             "type": "non-slot",
> >             "accepted-device-types": [
> >                 "hda-codec"
> >             ]
> >         },
> >         {
> >             "available": true,
> >             "hotpluggable": true,
> >             "props": {
> >                 "socket-id": 1,
> >                 "core-id": 1,
> >                 "thread-id": 1
> >             },
> >             "type": "cpu",
> >             "accepted-device-types": [
> >                 "qemu64-x86_64-cpu"
> >             ]
> >         },
> 
> You know CPUs better than me.

Fortunately CPU slots are already modelled, I am just translating
the query-hotpluggable-cpus data.

> 
> [More of them...]
> >     ]
> >   }
> 
> There's still more...
> 
> Bus "SCSI" device address property is "scsi-id", value 0..N, where N
> depends on the SCSI HBA.
> 
> Bus "virtio-serial-bus" device address property is "nr", value 0..N,
> where N is configurable, currenrly up to 511.

Sounds like this is large enough to justify representing
slot-sets since the first version of this interface.

> 
> ccid-bus device address property is "slot", value 0..N, where N depends
> on the device providing the bus (I think).
> 
> Buses not yet covered by docs/qdev-device-use.txt: "floppy-bus",
> "apple-desktop-bus", "IndustryPack", "aux-bus", "spapr-vio-bus",
> "virtual-css-bus", "s390-sclp-events-bus", "s390-pcibus", "sd-bus",
> "SSI", "virtio-bus", "xen-sysbus".  Grep for ".parent = TYPE_BUS".

This will be fun...

Thanks a lot for the information and ideas about the cases above.

> 
> To find all buses in a certain build, use:
> 
>     { "execute": "qom-list-types", "arguments": { "implements": "bus" } }
> 
> [No code review, yet]

-- 
Eduardo
