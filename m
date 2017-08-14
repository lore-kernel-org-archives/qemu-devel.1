Received: from eggs.gnu.org ([2001:4830:134:3::10]:42721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNN6-0001Pr-TQ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNN2-00029L-OO
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNN2-00028t-Eh
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:58:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DED4C0546C9
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:57:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:35 -0300
Message-Id: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 00/13] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>

Changelog
---------

Changes v3 -> v4:
* New compact representation of slot sets.
* New generic code to automatically merge similar slots
  into a single entry in the command output while keeping
  implementations of the method simpler.
* Example implementation of IDE and USB bus enumeration

Changes v2 -> v3:
* Implemented a "slot set" structure, where multiple slots can be
  reported by using integer ranges or lists for possible
  values for each property. Added a ValueSet struct, that
  can represent a set of values using either a simple list of
  values, or integer ranges. (Its JSON representation is very
  verbose, though. See comments below).
* Removed the *Properties structs, and replaced them with
  a simple list of SlotOption structs.
* DeviceSlotInfo is not an union anymore, removed the 'type'
  field only because there are no slot-type-specific fields in
  the current implementation, but we may add it back if necessary
* The implementation is very quick and dirty, the main purpose of
  this RFC is to evaluate the schema and returned data.

Changes v1 -> v2:
* Don't show sysbus unless has_dynamic_sysbus is set for the
  machine type
* Removed max-devices and devices properties
* Introduced "non-slot" slot type, to explicitly indicate
  we are returning info on a bus that doesn't implement slot
  enumeration yet.
* Return bus name instead of full QOM path on "bus" field
* PCI: Replaced "addr" property (string parsed by property
  setter) with "device-number" uint32 property
* PCI: return only one slot for PCIe ports

Summary
-------

This adds a new command to QMP: query-device-slots. It will allow
management software to query possible slots where devices can be
plugged.

This implementation of the command will return:

* Multiple PCI slots per bus, in the case of PCI buses;
* One slot for each entry from query-hotpluggable-cpus.
* One slot per bus for the other buses (that don't
  implement slot enumeration yet), with opts-complete=false

Representation of slot sets in JSON
-----------------------------------

Slot sets are represented by a list of option names and sets of
possible values for each of those options.  The command uses a
compact representation for the set of valid values for an option.
For example, the following set of 5 PCI functions:

      bus: pcie.0
      device-number: 31
      functions: 1,4,5,6,7

would be represented in the JSON data as:

  {"available":false,"count":5,
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":[1,[4,7]]},
      {"option":"device-number","values":31},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}

I planned to use QAPI alternates to model/document that in the
schema, but it would require implementing a few missing features
in QAPI alternate support.

TODO
----

* Differentiation between legacy-pci-device and pcie-device
* Implement enumeration for other buses
* Document the slotinfo.c functions
* Optimize the slot/option merging algorithm

Example output
--------------

Using the following QEMU command-line:

  $ qemu-system-x86_64 -machine q35,accel=kvm \
    -smp 16,maxcpus=32,threads=2,cores=2

query-device-slots will return the following entries:

  {"available":true,"count":224,
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":[[0,7]]},
      {"option":"device-number","values":[[3,30]]},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":true,"count":1,
   "device-types":["ide-device"],"hotpluggable":false,
   "opts":[
      {"option":"unit","values":0},
      {"option":"bus","values":"ide.2"}],
   "opts-complete":true}
  {"available":true,"count":10,
   "device-types":["ide-device"],"hotpluggable":false,
   "opts":[
      {"option":"unit","values":[[0,1]]},
      {"option":"bus","values":["ide.4","ide.3","ide.5","ide.0","ide.1"]}],
   "opts-complete":true}
  {"available":true,
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":true,"count":16,
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":[[4,7]]},
      {"option":"thread-id","values":[[0,1]]},
      {"option":"core-id","values":[[0,1]]}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[16]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":3},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[15]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":3},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[14]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":3},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[13]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":3},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[12]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":2},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[11]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":2},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[10]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":2},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[9]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":2},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[8]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":1},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[7]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":1},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[6]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":1},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[5]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":1},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[4]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":0},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[3]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":0},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":1}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[2]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":0},
      {"option":"thread-id","values":1},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[0]",
   "device-types":["qemu64-x86_64-cpu"],"hotpluggable":true,
   "opts":[
      {"option":"socket-id","values":0},
      {"option":"thread-id","values":0},
      {"option":"core-id","values":0}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/q35/mch",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":0},
      {"option":"device-number","values":0},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":21,
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":[[1,7]]},
      {"option":"device-number","values":[[0,2]]},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[44]",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":0},
      {"option":"device-number","values":1},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[45]",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":0},
      {"option":"device-number","values":2},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[18]",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":0},
      {"option":"device-number","values":31},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":5,
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":[1,[4,7]]},
      {"option":"device-number","values":31},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[33]",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":2},
      {"option":"device-number","values":31},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[35]",
   "device-types":["pci-device"],"hotpluggable":false,
   "opts":[
      {"option":"function","values":3},
      {"option":"device-number","values":31},
      {"option":"bus","values":"pcie.0"}],
   "opts-complete":true}
  {"available":false,"count":1,"device":"/machine/unattached/device[34]",
   "device-types":["ide-device"],"hotpluggable":false,
   "opts":[
      {"option":"unit","values":1},
      {"option":"bus","values":"ide.2"}],
   "opts-complete":true}
  {"available":false,"device":"/machine/unattached/device[32]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[31]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[30]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[29]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[28]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[27]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[26]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[25]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[24]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[23]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[22]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[20]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}
  {"available":false,"device":"/machine/unattached/device[19]",
   "device-types":["isa-device"],"hotpluggable":false,
   "opts":[
      {"option":"bus","values":"isa.0"}],
   "opts-complete":false}

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: libvir-list@redhat.com
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Laine Stump <laine@redhat.com>

Eduardo Habkost (13):
  qmp: Define query-device-slots command
  qapi: qobject_compare() helper
  qdev: Add BusClass::device_type field
  qdev: Slot info helpers
  query-device-slots: Collapse similar entries
  qdev core: generic enumerate_slots implementation
  qdev: Enumerate CPU slots on query-device-slots
  ide: enumerate_slots implementation
  pci: pci_bus_has_pcie_upstream_port() function
  pci: device-number & function properties
  pci: enumerate_slots implementation
  usb: enumerate_slots implementation
  tests: Experimental query-device-slots test code

 qapi-schema.json              |  89 ++++++
 include/hw/qdev-core.h        |   5 +
 include/hw/qdev-slotinfo.h    |  85 ++++++
 include/hw/usb.h              |   6 +-
 include/qapi/util.h           |  39 +++
 hw/audio/intel-hda.c          |   7 +
 hw/block/fdc.c                |  15 +-
 hw/char/virtio-serial-bus.c   |   1 +
 hw/core/bus.c                 |  42 +++
 hw/core/slotinfo.c            | 610 ++++++++++++++++++++++++++++++++++++++++++
 hw/core/sysbus.c              |   8 +
 hw/i2c/core.c                 |   7 +
 hw/ide/qdev.c                 |  27 ++
 hw/input/adb.c                |   7 +
 hw/ipack/ipack.c              |   7 +
 hw/isa/isa-bus.c              |   1 +
 hw/misc/auxbus.c              |   1 +
 hw/pci/pci.c                  | 120 ++++++++-
 hw/ppc/spapr_vio.c            |   1 +
 hw/s390x/css-bridge.c         |   2 +
 hw/s390x/event-facility.c     |   1 +
 hw/s390x/s390-pci-bus.c       |   7 +
 hw/scsi/scsi-bus.c            |   1 +
 hw/sd/core.c                  |   7 +
 hw/ssi/ssi.c                  |   7 +
 hw/usb/bus.c                  |  37 +++
 hw/usb/dev-smartcard-reader.c |   7 +
 hw/virtio/virtio-bus.c        |   1 +
 qapi/qapi-util.c              |  66 +++++
 qdev-monitor.c                | 109 ++++++++
 tests/test-qapi-util.c        |  53 ++++
 tests/test-slotinfo.c         | 398 +++++++++++++++++++++++++++
 hw/core/Makefile.objs         |   2 +
 tests/Makefile.include        |  14 +-
 tests/qmp-machine-info.py     | 300 +++++++++++++++++++++
 35 files changed, 2075 insertions(+), 15 deletions(-)
 create mode 100644 include/hw/qdev-slotinfo.h
 create mode 100644 hw/core/slotinfo.c
 create mode 100644 tests/test-slotinfo.c
 create mode 100755 tests/qmp-machine-info.py

-- 
2.9.4
