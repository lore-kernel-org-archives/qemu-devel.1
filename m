Received: from eggs.gnu.org ([2001:4830:134:3::10]:34254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cI4MZ-0001cB-N8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 21:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cI4MS-0000hn-J3
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 21:04:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cI4MS-0000gb-1u
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 21:04:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6966C05AA70
	for <qemu-devel@nongnu.org>; Sat, 17 Dec 2016 02:04:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Sat, 17 Dec 2016 00:04:22 -0200
Message-Id: <1481940262-11164-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v3] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: libvir-list@redhat.com, Igor Mammedov <imammedo@redhat.com>, Laine Stump <laine@redhat.com>

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

This adds a new command to QMP: query-device-slots. It will allow
management software to query possible slots where devices can be
plugged.

This implementation of the command will return:

* Multiple PCI slots per bus, in the case of PCI buses;
* One slot per bus for the other buses (that don't
  implement slot enumeration yet);
* One slot for each entry from query-hotpluggable-cpus.

Representation of slot sets in JSON
-----------------------------------

Slot sets are represented by a list of option names and sets of
possible values for each of those options. See the SlotOption
struct below for details.

The representation of those sets is very verbose in this version
(see below). e.g. the following set of 5 PCI functions:

      bus: pcie.0
      device-number: 31
      function: 1,4-7

Is represented in the JSON data as:

  "props": [
      {
          "values": {
              "data": {
                  "ranges": [
                      { "max": 1, "min": 1 },
                      { "max": 7, "min": 4 }
                  ]
              },
              "type": "int-set"
          },
          "option": "function"
      },
      {
          "values": {
              "data": {
                  "ranges": [ { "max": 31, "min": 31 } ]
              },
              "type": "int-set"
          },
          "option": "device-number"
      },
      {
          "values": {
              "data": [ "pcie.0" ],
              "type": "list"
          },
          "option": "bus"
      }
  ]

We could have used something more compact like:

      function: 1,4-7
      device-number: 31
      bus: pcie.0

  "props": {
      "function": [ 1, { 'min': 4, 'max': 7 } ],
      "device-number": 31,
      "bus": "pcie.0"
  }

But this would probably cost us the ability of describing and
validating the exact representation using the QAPI schema. I
don't know which way we should go.

QAPI schema
-----------

The following structures were added to the QAPI schema:

{ 'struct': 'IntegerSet',
  'data': { 'ranges': [ 'IntegerRange' ] } }

{ 'struct': 'IntegerRange',
  'data': { 'min': 'int', 'max': 'int' } }

{ 'union': 'ValueSet',
  'data': { 'list': [ 'any' ], 'int-set': 'IntegerSet' } }

{ 'struct': 'SlotOption',
  'data': { 'option': 'str', 'values': 'ValueSet' } }

{ 'struct': 'DeviceSlotInfo',
  'data': { 'accepted-device-types': [ 'str' ],
            'available': 'bool', 'hotpluggable': 'bool',
            '*count': 'int', 'incomplete': 'bool',
            'props': [ 'SlotOption' ] } }

{ 'command': 'query-device-slots',
  'returns': [ 'DeviceSlotInfo' ] }

Git tree
--------

This patch needs the previous query-machines series I am working
on. The full tree can be found on the git tree at:

  git://github.com/ehabkost/qemu-hacks.git work/query-machines-bus-info

Example output
--------------

The following output was returned by QEMU when running it as:

 $ qemu-system-x86_64 -machine q35 \
   -readconfig docs/q35-chipset.cfg \
   -smp 4,maxcpus=8,sockets=2,cores=2,threads=2

As the JSON output is now quite verbose, I am including the
output of a script that translates the JSON data to a more
human-friendly format:

  Slot set for: i2c-slave
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: i2c
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.4
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.5
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.0
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.1
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.2
  Slot set for: ide-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ide.3
  Slot set for: sys-bus-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: main-system-bus
  Slot set for: isa-device
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: isa.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 0
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 7
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1-7
      device-number: 0
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 1
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 7
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1-7
      device-number: 1
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 2
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 7
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1-7
      device-number: 2
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 26
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 1
      device-number: 26
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 2
      device-number: 26
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 7
      device-number: 26
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 4
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 3-6
      device-number: 26
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 27
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 7
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1-7
      device-number: 27
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 28
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 1
      device-number: 28
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 2
      device-number: 28
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 3
      device-number: 28
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 4
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 4-7
      device-number: 28
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 29
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 1
      device-number: 29
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 2
      device-number: 29
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 7
      device-number: 29
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 4
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 3-6
      device-number: 29
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 30
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 7
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1-7
      device-number: 30
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 0
      device-number: 31
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 2
      device-number: 31
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 1
    available: no
    hotpluggable: no
    valid device_add arguments:
      function: 3
      device-number: 31
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 5
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 1,4-7
      device-number: 31
      bus: pcie.0
  Slot set for: legacy-pci-device, pci-express-device
    Slot count: 184
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 0-7
      device-number: 3-25
      bus: pcie.0
  Slot set for: pci-express-device
    Slot count: 8
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      function: 0-7
      device-number: 0
      bus: ich9-pcie-port-1
  Slot set for: pci-express-device
    Slot count: 8
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      function: 0-7
      device-number: 0
      bus: ich9-pcie-port-2
  Slot set for: pci-express-device
    Slot count: 8
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      function: 0-7
      device-number: 0
      bus: ich9-pcie-port-3
  Slot set for: pci-express-device
    Slot count: 8
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      function: 0-7
      device-number: 0
      bus: ich9-pcie-port-4
  Slot set for: legacy-pci-device
    Slot count: 256
    available: yes
    hotpluggable: no
    valid device_add arguments:
      function: 0-7
      device-number: 0-31
      bus: ich9-pci-bridge
  Slot set for: usb-device
    Incomplete set
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      bus: ich9-ehci-1.0
  Slot set for: usb-device
    Incomplete set
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      bus: ich9-ehci-2.0
  Slot set for: hda-codec
    Incomplete set
    available: no
    hotpluggable: no
    valid device_add arguments:
      bus: ich9-hda-audio.0
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 1
      thread-id: 1
      core-id: 1
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 1
      thread-id: 0
      core-id: 1
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 1
      thread-id: 1
      core-id: 0
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: yes
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 1
      thread-id: 0
      core-id: 0
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: no
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 0
      thread-id: 1
      core-id: 1
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: no
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 0
      thread-id: 0
      core-id: 1
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: no
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 0
      thread-id: 1
      core-id: 0
  Slot set for: qemu64-x86_64-cpu
    Slot count: 1
    available: no
    hotpluggable: yes
    valid device_add arguments:
      socket-id: 0
      thread-id: 0
      core-id: 0

Raw JSON data for the above:

  {
    "return": [
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "i2c"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "i2c-slave"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.4"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.5"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.1"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.2"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ide.3"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "main-system-bus"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "sys-bus-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "isa.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "isa-device"
            ]
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 7,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 7,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 7,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 26,
                                    "min": 26
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 26,
                                    "min": 26
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 26,
                                    "min": 26
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 7
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 26,
                                    "min": 26
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 4,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 6,
                                    "min": 3
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 26,
                                    "min": 26
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 27,
                                    "min": 27
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 7,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 27,
                                    "min": 27
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 28,
                                    "min": 28
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 28,
                                    "min": 28
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 28,
                                    "min": 28
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 3,
                                    "min": 3
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 28,
                                    "min": 28
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 4,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 4
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 28,
                                    "min": 28
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 29,
                                    "min": 29
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 29,
                                    "min": 29
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 29,
                                    "min": 29
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 7
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 29,
                                    "min": 29
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 4,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 6,
                                    "min": 3
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 29,
                                    "min": 29
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 30,
                                    "min": 30
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 7,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 1
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 30,
                                    "min": 30
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 31,
                                    "min": 31
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 2,
                                    "min": 2
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 31,
                                    "min": 31
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 3,
                                    "min": 3
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 31,
                                    "min": 31
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 5,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 1,
                                    "min": 1
                                },
                                {
                                    "max": 7,
                                    "min": 4
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 31,
                                    "min": 31
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 184,
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 25,
                                    "min": 3
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "pcie.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "count": 8,
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "ich9-pcie-port-1"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 8,
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "ich9-pcie-port-2"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 8,
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "ich9-pcie-port-3"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 8,
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 0,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "ich9-pcie-port-4"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 256,
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": [
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 7,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "function"
                },
                {
                    "values": {
                        "data": {
                            "ranges": [
                                {
                                    "max": 31,
                                    "min": 0
                                }
                            ]
                        },
                        "type": "int-set"
                    },
                    "option": "device-number"
                },
                {
                    "values": {
                        "data": [
                            "ich9-pci-bridge"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "hotpluggable": false,
            "incomplete": false
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": [
                {
                    "values": {
                        "data": [
                            "ich9-ehci-1.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "usb-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": [
                {
                    "values": {
                        "data": [
                            "ich9-ehci-2.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "usb-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": [
                {
                    "values": {
                        "data": [
                            "ich9-hda-audio.0"
                        ],
                        "type": "list"
                    },
                    "option": "bus"
                }
            ],
            "incomplete": true,
            "accepted-device-types": [
                "hda-codec"
            ]
        },
        {
            "available": true,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": true,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            1
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        },
        {
            "available": false,
            "count": 1,
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": [
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "socket-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "thread-id"
                },
                {
                    "values": {
                        "data": [
                            0
                        ],
                        "type": "list"
                    },
                    "option": "core-id"
                }
            ],
            "hotpluggable": true,
            "incomplete": false
        }
    ]
  }

Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: libvir-list@redhat.com,
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Laine Stump <laine@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
---
 qapi-schema.json                      | 109 ++++++++++
 scripts/qmp/query-slots.py            |  50 +++++
 include/hw/qdev-core.h                |   6 +
 include/qapi/qobject-output-visitor.h |   9 +
 hw/core/bus.c                         |  45 +++++
 hw/pci/pci.c                          | 363 +++++++++++++++++++++++++++++++---
 qapi/qobject-output-visitor.c         |  14 ++
 qdev-monitor.c                        | 128 +++++++++++-
 tests/qmp-machine-info.py             |  72 +++++--
 9 files changed, 746 insertions(+), 50 deletions(-)
 create mode 100755 scripts/qmp/query-slots.py

diff --git a/qapi-schema.json b/qapi-schema.json
index d48ff3f..3d597b5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3165,6 +3165,115 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
+
+##
+# @IntegerSet:
+#
+# A set of integers.
+##
+{ 'struct': 'IntegerSet',
+  'data': { 'ranges': [ 'IntegerRange' ] } }
+
+##
+# @IntegerRange:
+#
+# A contiguous range of integers.
+#
+# @min: The first value in the range
+# @max: The last value in the range
+##
+{ 'struct': 'IntegerRange',
+  'data': { 'min': 'int', 'max': 'int' } }
+
+##
+# @ValueSet:
+#
+# A set of values.
+#
+# @list: A set of elements in a list.
+#
+# @int-set: A set represented by an IntegerSet.
+##
+{ 'union': 'ValueSet',
+  'data': { 'list': [ 'any' ], 'int-set': 'IntegerSet' } }
+
+##
+# @SlotOption:
+#
+# A option to be used when plugging a device to a slot.
+#
+# @option: Option name.
+#
+# @values: Set of valid option values.
+##
+{ 'struct': 'SlotOption',
+  'data': { 'option': 'str', 'values': 'ValueSet' } }
+
+##
+# @DeviceSlotInfo:
+#
+# Information on a set of slots where devices can be plugged.
+#
+# @type: type of device slot.
+#
+# @accepted-device-types: List of device types accepted by the slots.
+#                         Any device plugged to the slot should implement
+#                         one of the accepted device types.
+#
+# @available: If false, the slot is not available for plugging any device.
+#             This value can change at runtime if condition changes
+#             (e.g. if the slot becomes full, or if the machine
+#             was already initialized and the slot doesn't support
+#             hotplug).
+#
+# @hotpluggable: If true, the slot accepts hotplugged devices.
+#
+# @count: #optional Number of slots represented by this slot set.
+#         Will always be present if @incomplete=false.
+#
+# @incomplete: Slot information is incomplete. Slot count is not
+#              available, and additional arguments are missing
+#              on @props.
+#
+# @props: Information on the arguments that should be given to
+#         @device_add if plugging a device to this slot.
+#
+# How to interpret @props
+# -----------------------
+#
+# Each key/value pair in @props represent an option that should
+# be set when using @device_add to plug a new device.
+#
+# Each value in @props represent a single value that should be
+# provided to @device_add, or a set of possible values for the option.
+#
+# Incomplete Slot Sets
+# --------------------
+#
+# Slot sets with @incomplete=true represent a bus that doesn't
+# support slot enumeration yet. Slots of this type should be replaced
+# by more detailed slot sets in future QEMU versions.
+#
+# Slots of this type may or may not support multiple devices.
+#
+# Slots in incomplete slot sets might require extra arguments to
+# be set to specify the device address.
+##
+{ 'struct': 'DeviceSlotInfo',
+  'data': { 'accepted-device-types': [ 'str' ],
+            'available': 'bool', 'hotpluggable': 'bool',
+            '*count': 'int', 'incomplete': 'bool',
+            'props': [ 'SlotOption' ] } }
+
+##
+# @query-device-slots:
+#
+# Return the list of possible slots for plugging devices using
+# @device_add.
+##
+{ 'command': 'query-device-slots',
+  'returns': [ 'DeviceSlotInfo' ] }
+
 ##
 # @MachineBusInfo
 #
diff --git a/scripts/qmp/query-slots.py b/scripts/qmp/query-slots.py
new file mode 100755
index 0000000..02c60b7
--- /dev/null
+++ b/scripts/qmp/query-slots.py
@@ -0,0 +1,50 @@
+#!/usr/bin/env python
+# test script to dump slot info in a more human-friendly way
+
+import qmp
+import sys
+
+q = qmp.QEMUMonitorProtocol(sys.argv[1])
+q.connect()
+slots = q.command('query-device-slots')
+for slot in slots:
+    types = slot.pop('accepted-device-types')
+    print 'Slot set for: %s' % (', '.join(types))
+    inc = slot.pop('incomplete')
+    if inc:
+        print '  Incomplete set'
+    else:
+        count = slot.pop('count')
+        print '  Slot count: %d' % (count)
+    props = slot.pop('props')
+    for k,v in slot.items():
+        if type(v) == bool:
+            if v:
+                v = 'yes'
+            else:
+                v = 'no'
+        elif type(v) == unicode:
+            v = str(v)
+        else:
+            v = repr(v)
+        print '  %s: %s' % (k, v)
+
+    print '  valid device_add arguments:'
+    for p in props:
+        option = p.pop('option')
+        values = p.pop('values')
+        assert not p # no other field
+        valuestr = repr(values)
+        if values['type'] == 'list':
+            valuestr = ', '.join(str(v) for v in values['data'])
+        elif values['type'] == 'int-set':
+            ranges = []
+            for r in values['data']['ranges']:
+                if r['max'] == r['min']:
+                    ranges.append('%d' % (r['max']))
+                else:
+                    ranges.append('%d-%d' % (r['min'], r['max']))
+            valuestr = ','.join(ranges)
+        else:
+            assert False
+        print '    %s: %s' % (option, valuestr)
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a7f9ac4..2cb043a 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -214,6 +214,10 @@ struct BusClass {
      * but on some cases bus instances may override it.
      */
     const char *device_type;
+
+    /*TODO: write doc */
+    DeviceSlotInfoList *(*enumerate_slots)(BusState *bus, Error **errp);
+
 };
 
 typedef struct BusChild {
@@ -412,4 +416,6 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
+bool qbus_is_full(BusState *bus);
+
 #endif
diff --git a/include/qapi/qobject-output-visitor.h b/include/qapi/qobject-output-visitor.h
index 8241877..319985e 100644
--- a/include/qapi/qobject-output-visitor.h
+++ b/include/qapi/qobject-output-visitor.h
@@ -16,6 +16,7 @@
 
 #include "qapi/visitor.h"
 #include "qapi/qmp/qobject.h"
+#include "qapi/error.h"
 
 typedef struct QObjectOutputVisitor QObjectOutputVisitor;
 
@@ -27,4 +28,12 @@ typedef struct QObjectOutputVisitor QObjectOutputVisitor;
  */
 Visitor *qobject_output_visitor_new(QObject **result);
 
+QObject *qapi_to_qobject(const void *src,
+                         void (*visit_fn)(Visitor *, const char *,
+                                          void**, Error **));
+
+#define QAPI_TO_QOBJ(type, src)                                        \
+    (qapi_to_qobject((src), (void (*)(Visitor *, const char *, void**, \
+                                      Error **))visit_type_ ## type))
+
 #endif
diff --git a/hw/core/bus.c b/hw/core/bus.c
index d2bf717..2f47fe1 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,7 +21,9 @@
 #include "qemu-common.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
 #include "qapi-visit.h"
+#include "qapi/qmp/qstring.h"
 
 static void qbus_set_hotplug_handler_internal(BusState *bus, Object *handler,
                                               Error **errp)
@@ -225,12 +227,55 @@ static void bus_get_device_type(Object *obj, Visitor *v,
     visit_type_strList(v, NULL, &bus->accepted_device_types, errp);
 }
 
+bool qbus_is_full(BusState *bus)
+{
+    BusClass *bus_class = BUS_GET_CLASS(bus);
+    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
+}
+
+/* Generic slot enumeration function that will return a generic-slot slot type.
+ */
+static DeviceSlotInfoList *bus_generic_enumerate_slots(BusState *bus, Error **errp)
+{
+    Error *local_err = NULL;
+    DeviceSlotInfoList *r = g_new0(DeviceSlotInfoList, 1);
+
+    r->value = g_new0(DeviceSlotInfo, 1);
+    r->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+
+    r->value->hotpluggable = qbus_is_hotpluggable(bus);
+
+    r->value->incomplete = true;
+
+    /* Conditions that make a bus unavailable:
+     * - Bus already full
+     * - Hotplug when the bus is not hotpluggable
+     */
+    r->value->available =
+        !(qbus_is_full(bus) ||
+          (qdev_hotplug && !qbus_is_hotpluggable(bus)));
+
+
+    /* r->value->props = { 'bus': bus->name } */
+    r->value->props = g_new0(SlotOptionList, 1);
+    r->value->props->value = g_new0(SlotOption, 1);
+    r->value->props->value->option = g_strdup("bus");
+    r->value->props->value->values = g_new0(ValueSet, 1);
+    r->value->props->value->values->type = VALUE_SET_KIND_LIST;;
+    r->value->props->value->values->u.list.data = g_new0(anyList, 1);
+    r->value->props->value->values->u.list.data->value = QOBJECT(qstring_from_str(bus->name));
+
+    error_propagate(errp, local_err);
+    return r;
+}
+
 static void bus_class_init(ObjectClass *class, void *data)
 {
     BusClass *bc = BUS_CLASS(class);
 
     class->unparent = bus_unparent;
     bc->get_fw_dev_path = default_bus_get_fw_dev_path;
+    bc->enumerate_slots = bus_generic_enumerate_slots;
 
     object_class_property_add(class, "accepted-device-types", "strList",
                               bus_get_device_type, NULL, NULL, NULL,
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2eac71a..26721a6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -41,6 +41,8 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qmp/qstring.h"
 
 //#define DEBUG_PCI
 #ifdef DEBUG_PCI
@@ -141,6 +143,8 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+static DeviceSlotInfoList *pci_bus_enumerate_slots(BusState *bus, Error **errp);
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -156,6 +160,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
      * but overrides BusClass::device_type to INTERFACE_PCIE_DEVICE
      */
     k->device_type = INTERFACE_LEGACY_PCI_DEVICE;
+    k->enumerate_slots = pci_bus_enumerate_slots;
 
     pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
@@ -967,6 +972,274 @@ uint16_t pci_requester_id(PCIDevice *dev)
     return pci_req_id_cache_extract(&dev->requester_id_cache);
 }
 
+static bool pci_bus_has_pcie_upstream_port(PCIBus *bus)
+{
+    PCIDevice *parent_dev = pci_bridge_get_device(bus);
+
+    /* Device associated with an upstream port.
+     * As there are several types of these, it's easier to check the
+     * parent device: upstream ports are always connected to
+     * root or downstream ports.
+     */
+    return parent_dev &&
+        pci_is_express(parent_dev) &&
+        parent_dev->exp.exp_cap &&
+        (pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_ROOT_PORT ||
+         pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_DOWNSTREAM);
+}
+
+static PCIDevice *pci_bus_get_function_0(PCIBus *bus, int devfn)
+{
+    if(pci_bus_has_pcie_upstream_port(bus)) {
+        /* With an upstream PCIe port, we only support 1 device at slot 0 */
+        return bus->devices[0];
+    } else {
+        /* Other bus types might support multiple devices at slots 0-31 */
+        return bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)];
+    }
+}
+
+PCIDevice *pci_get_function_0(PCIDevice *pci_dev)
+{
+    return pci_bus_get_function_0(pci_dev->bus, pci_dev->devfn);
+}
+
+static bool int_set_empty(IntegerSet *set)
+{
+    return !set->ranges;
+}
+
+static int int_range_size(IntegerRange *range)
+{
+    return range->max - range->min + 1;
+}
+
+static int int_set_size(IntegerSet *set)
+{
+    int r = 0;
+    IntegerRangeList *rl;
+    for (rl = set->ranges; rl; rl = rl->next) {
+        r += int_range_size(rl->value);
+    }
+    return r;
+}
+
+static void int_set_add(IntegerSet *set, int min, int max)
+{
+    IntegerRangeList *rl;
+    IntegerRangeList **pnext = &set->ranges;
+    IntegerRangeList *prev = NULL;
+
+    for (rl = set->ranges; rl; rl = rl->next) {
+        IntegerRange *r = rl->value;
+        if (max < r->min - 1) {
+            goto insert;
+        } else if (max <= r->max) {
+            r->min = min;
+            goto try_merge_back;
+        } else if (min == r->max + 1) {
+            r->max = max;
+            goto try_merge_front;
+        } else {
+            pnext = &rl->next;
+            prev = rl;
+        }
+    }
+
+insert:
+    rl = g_new0(IntegerRangeList, 1);
+    rl->value = g_new0(IntegerRange, 1);
+    rl->value->min = min;
+    rl->value->max = max;
+    rl->next = *pnext;
+    *pnext = rl;
+
+try_merge_back:
+    /*TODO: can't merge more than 1 range */
+    if (prev && prev->value->max == rl->value->min - 1) {
+        prev->value->max = rl->value->max;
+        prev->next = rl->next;
+        g_free(rl);
+    }
+
+try_merge_front:
+    while (rl->next && rl->value->max + 1 == rl->next->value->min) {
+        IntegerRangeList *old = rl->next;
+        rl->next = old->next;
+        g_free(old);
+    }
+}
+
+static ValueSet *new_slot_prop(DeviceSlotInfo *slot, const char *option, ValueSetKind type)
+{
+    SlotOptionList *l =  g_new0(SlotOptionList, 1);
+    SlotOption *opt = g_new0(SlotOption, 1);
+    ValueSet *vs = g_new0(ValueSet, 1);
+
+    vs->type = type;
+    opt->option = g_strdup(option);
+    opt->values = vs;
+    l->value = opt;
+    l->next = slot->props;
+    slot->props = l;
+    return vs;
+}
+
+static void value_set_list_append(ValueSet *vs, QObject *value)
+{
+    anyList *new = g_new0(anyList, 1);
+
+    assert(vs->type == VALUE_SET_KIND_LIST);
+    new->value = value;
+    new->next = vs->u.list.data;
+    vs->u.list.data = new;
+}
+
+static DeviceSlotInfoList *pci_bus_enumerate_slots(BusState *bus, Error **errp)
+{
+    PCIBus *pb = PCI_BUS(bus);
+    int devnr, devnrs;
+    DeviceSlotInfoList *r = NULL;
+    DeviceSlotInfoList **next = &r;
+    IntegerSet *empty_slots = g_new0(IntegerSet, 1);
+
+    if (pci_bus_has_pcie_upstream_port(pb)) {
+        devnrs = 1;
+    } else {
+        devnrs = PCI_SLOT_MAX;
+    }
+
+    /* Each PCI devfn (device number + function) is a separate slot,
+     * because we implement multi-function PCI devices as separate
+     * device objects.
+     *
+     * As an experiment, return a slot set for each device number.
+     */
+    for(devnr = PCI_SLOT(pb->devfn_min); devnr < devnrs; devnr++) {
+        IntegerSet *empty_funcs = g_new0(IntegerSet, 1);
+
+        int func;
+        for (func = 0; func < PCI_FUNC_MAX; func++) {
+            if (pb->devices[PCI_DEVFN(devnr, func)]) {
+                break;
+            }
+        }
+        if (func == PCI_FUNC_MAX) {
+            /* All functions are empty, we can return the whole slot in the "empty" slot set */
+            int_set_add(empty_slots, devnr, devnr);
+            continue;
+        }
+
+        /* Not all functions are empty, so return one entry for each function */
+        for (func = 0; func < PCI_FUNC_MAX; func++) {
+            /* Empty functions will be reported as a single slot set later: */
+            if (!pb->devices[PCI_DEVFN(devnr, func)]) {
+                int_set_add(empty_funcs, func, func);
+                continue;
+            }
+
+            DeviceSlotInfoList *i = g_new0(DeviceSlotInfoList, 1);
+            i->value = g_new0(DeviceSlotInfo, 1);
+            /*TODO: add info about accepting only bridges on extra PCI root buses */
+            i->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+
+            i->value->hotpluggable = qbus_is_hotpluggable(bus);
+
+            /* Conditions that make a devnr unavailable:
+             * - function already occupied
+             * - function 0 already occupied by a device
+             * - Hotplug when the bus is not hotpluggable
+             */
+            i->value->available =
+                !((pb->devices[PCI_DEVFN(devnr, func)]) ||
+                  (pb->devices[PCI_DEVFN(devnr, 0)]) ||
+                  (0 && qdev_hotplug && !qbus_is_hotpluggable(bus)));
+
+            ValueSet *bus_values = new_slot_prop(i->value, "bus", VALUE_SET_KIND_LIST);
+            value_set_list_append(bus_values, QOBJECT(qstring_from_str(bus->name)));
+
+            ValueSet *dev_values = new_slot_prop(i->value, "device-number", VALUE_SET_KIND_INT_SET);
+            dev_values->u.int_set.data = g_new0(IntegerSet, 1);
+            int_set_add(dev_values->u.int_set.data, devnr, devnr);
+
+            ValueSet *func_values = new_slot_prop(i->value, "function", VALUE_SET_KIND_INT_SET);
+            func_values->u.int_set.data = g_new0(IntegerSet, 1);
+            int_set_add(func_values->u.int_set.data, func, func);
+
+            i->value->has_count = true;
+            i->value->count = 1;
+
+            *next = i;
+            next = &i->next;
+        }
+
+        if (!int_set_empty(empty_funcs)) {
+            DeviceSlotInfoList *i = g_new0(DeviceSlotInfoList, 1);
+            i->value = g_new0(DeviceSlotInfo, 1);
+            /*TODO: add info about accepting only bridges on extra PCI root buses */
+            i->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+
+            i->value->hotpluggable = qbus_is_hotpluggable(bus);
+
+            i->value->available =
+                !(0 && qdev_hotplug && !qbus_is_hotpluggable(bus));
+
+            ValueSet *bus_values = new_slot_prop(i->value, "bus", VALUE_SET_KIND_LIST);
+            value_set_list_append(bus_values, QOBJECT(qstring_from_str(bus->name)));
+
+            ValueSet *dev_values = new_slot_prop(i->value, "device-number", VALUE_SET_KIND_INT_SET);
+            dev_values->u.int_set.data = g_new0(IntegerSet, 1);
+            int_set_add(dev_values->u.int_set.data, devnr, devnr);
+
+            ValueSet *func_values = new_slot_prop(i->value, "function", VALUE_SET_KIND_INT_SET);
+            func_values->u.int_set.data = empty_funcs;
+
+            i->value->has_count = true;
+            i->value->count = int_set_size(empty_funcs);
+
+            *next = i;
+            next = &i->next;
+        } else {
+            qapi_free_IntegerSet(empty_slots);
+        }
+    }
+
+    /* Return a single slot set for the empty slots */
+    if (!int_set_empty(empty_slots)) {
+        DeviceSlotInfoList *i = g_new0(DeviceSlotInfoList, 1);
+        i->value = g_new0(DeviceSlotInfo, 1);
+        /*TODO: add info about accepting only bridges on extra PCI root buses */
+        i->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+
+        i->value->hotpluggable = qbus_is_hotpluggable(bus);
+
+        /* Conditions that make a devnr unavailable:
+         * - function 0 already occupied by a device
+         * - Hotplug when the bus is not hotpluggable
+         */
+        i->value->available = !(0 && qdev_hotplug && !qbus_is_hotpluggable(bus));
+
+        ValueSet *bus_values = new_slot_prop(i->value, "bus", VALUE_SET_KIND_LIST);
+        value_set_list_append(bus_values, QOBJECT(qstring_from_str(bus->name)));
+
+        ValueSet *dev_values = new_slot_prop(i->value, "device-number", VALUE_SET_KIND_INT_SET);
+        dev_values->u.int_set.data = empty_slots;
+
+        ValueSet *func_values = new_slot_prop(i->value, "function", VALUE_SET_KIND_INT_SET);
+        func_values->u.int_set.data = g_new0(IntegerSet, 1);
+        int_set_add(func_values->u.int_set.data, 0, PCI_FUNC_MAX - 1);
+
+        i->value->has_count = true;
+        i->value->count = PCI_FUNC_MAX * int_set_size(empty_slots);
+
+        *next = i;
+        next = &i->next;
+    } else {
+        qapi_free_IntegerSet(empty_slots);
+    }
+    return r;
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -2509,6 +2782,56 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
     return dev->bus->address_space_io;
 }
 
+static void pci_device_get_devnr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t devnr = PCI_SLOT(dev->devfn);
+
+    visit_type_uint32(v, "device-number", &devnr, errp);
+}
+
+static void pci_device_set_devnr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t devnr;
+    Error *local_err = NULL;
+
+    visit_type_uint32(v, "device-number", &devnr, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    dev->devfn = PCI_DEVFN(devnr, PCI_FUNC(dev->devfn));
+out:
+    error_propagate(errp, local_err);
+}
+
+static void pci_device_get_function(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t function = PCI_FUNC(dev->devfn);
+
+    visit_type_uint32(v, "function", &function, errp);
+}
+
+static void pci_device_set_function(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t function;
+    Error *local_err = NULL;
+
+    visit_type_uint32(v, "function", &function, &local_err);
+    if (local_err) {
+        goto out;
+    }
+    dev->devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), function);
+out:
+    error_propagate(errp, local_err);
+}
+
 static void pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -2519,6 +2842,19 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_PCI_BUS;
     k->props = pci_props;
     pc->realize = pci_default_realize;
+
+    /* Internally, bits 3:8 of devfn are called "slots", but:
+     * - they can be confused with physical slot numbers;
+     * - TYPE_PCIE_SLOT objects already have a "slot" property.
+     * So we use the terminology used in the PCI specifiction:
+     * "device number".
+     */
+    object_class_property_add(klass, "device-number", "uint32",
+                              pci_device_get_devnr, pci_device_set_devnr,
+                              NULL, NULL, &error_abort);
+    object_class_property_add(klass, "function", "uint32",
+                              pci_device_get_function, pci_device_set_function,
+                              NULL, NULL, &error_abort);
 }
 
 static void pci_device_class_base_init(ObjectClass *klass, void *data)
@@ -2607,33 +2943,6 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range)
     pci_for_each_device_under_bus(bus, pci_dev_get_w64, range);
 }
 
-static bool pcie_has_upstream_port(PCIDevice *dev)
-{
-    PCIDevice *parent_dev = pci_bridge_get_device(dev->bus);
-
-    /* Device associated with an upstream port.
-     * As there are several types of these, it's easier to check the
-     * parent device: upstream ports are always connected to
-     * root or downstream ports.
-     */
-    return parent_dev &&
-        pci_is_express(parent_dev) &&
-        parent_dev->exp.exp_cap &&
-        (pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_ROOT_PORT ||
-         pcie_cap_get_type(parent_dev) == PCI_EXP_TYPE_DOWNSTREAM);
-}
-
-PCIDevice *pci_get_function_0(PCIDevice *pci_dev)
-{
-    if(pcie_has_upstream_port(pci_dev)) {
-        /* With an upstream PCIe port, we only support 1 device at slot 0 */
-        return pci_dev->bus->devices[0];
-    } else {
-        /* Other bus types might support multiple devices at slots 0-31 */
-        return pci_dev->bus->devices[PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 0)];
-    }
-}
-
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
 {
     MSIMessage msg;
diff --git a/qapi/qobject-output-visitor.c b/qapi/qobject-output-visitor.c
index 8711270..86c3e1b 100644
--- a/qapi/qobject-output-visitor.c
+++ b/qapi/qobject-output-visitor.c
@@ -252,3 +252,17 @@ Visitor *qobject_output_visitor_new(QObject **result)
 
     return &v->visitor;
 }
+
+QObject *qapi_to_qobject(const void *src,
+                         void (*visit_fn)(Visitor *, const char *,
+                                          void**, Error **))
+{
+    QObject *qobj = NULL;
+    void *obj = (void *) src;
+    Visitor *v = qobject_output_visitor_new(&qobj);
+
+    visit_fn(v, "unused", &obj, &error_abort);
+    visit_complete(v, &qobj);
+    visit_free(v);
+    return qobj;
+}
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c73410c..4df29c4 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,9 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "hw/boards.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -399,12 +402,6 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
     return NULL;
 }
 
-static inline bool qbus_is_full(BusState *bus)
-{
-    BusClass *bus_class = BUS_GET_CLASS(bus);
-    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
-}
-
 /*
  * Search the tree rooted at @bus for a bus.
  * If @name, search for a bus with that name.  Note that bus names
@@ -631,6 +628,125 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return dev;
 }
 
+typedef struct SlotListState {
+    MachineState *machine;
+    DeviceSlotInfoList *result;
+    DeviceSlotInfoList **next;
+    Error *err;
+} SlotListState;
+
+static int walk_bus(Object *obj, void *opaque)
+{
+    SlotListState *s = opaque;
+
+    /* sysbus is special: never return it unless the machine
+     * supports dynamic sysbus devices.
+     */
+    if (object_dynamic_cast(obj, TYPE_BUS) &&
+        (!object_dynamic_cast(obj, TYPE_SYSTEM_BUS) ||
+         MACHINE_GET_CLASS(s->machine)->has_dynamic_sysbus)) {
+        BusState *bus = BUS(obj);
+        BusClass *bc = BUS_GET_CLASS(bus);
+        DeviceSlotInfoList *l = bc->enumerate_slots(bus, &s->err);
+        *s->next = l;
+        for (; l; l = l->next) {
+            s->next = &l->next;
+        }
+        if (s->err) {
+            return 1;
+        }
+    }
+    return 0;
+}
+
+static void add_option(const char *key, QObject *obj, void *opaque)
+{
+    SlotOptionList **l = opaque;
+    SlotOption *opt = g_new0(SlotOption, 1);
+    SlotOptionList *new = g_new0(SlotOptionList, 1);
+
+    opt->option = g_strdup(key);
+    opt->values = g_new0(ValueSet, 1);
+    opt->values->type = VALUE_SET_KIND_LIST;
+    opt->values->u.list.data = g_new0(anyList, 1);
+    opt->values->u.list.data->value = obj;
+    qobject_incref(obj);
+
+    new->next = *l;
+    new->value = opt;
+    *l = new;
+}
+
+/* Convert a simple QDict to a list of single-value slot properties */
+static void qdict_to_slot_props(QDict *d, SlotOptionList **l)
+{
+    qdict_iter(d, add_option, l);
+}
+
+static QObject *cpu_instance_props_to_qobj(CpuInstanceProperties *src, Error **errp)
+{
+    QObject *qobj = NULL;
+    Visitor *v = qobject_output_visitor_new(&qobj);
+
+    visit_type_CpuInstanceProperties(v, "unused", &src, &error_abort);
+    visit_complete(v, &qobj);
+    visit_free(v);
+    return qobj;
+}
+
+DeviceSlotInfoList *qmp_query_device_slots(Error **errp)
+{
+    SlotListState s = { };
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
+    s.machine = ms;
+    s.next = &s.result;
+
+    /* We build the device slot list from two sources:
+     * 1) Calling the BusClass::enumerate_slots() method on all buses;
+     * 2) The return value of MachineClass::query_hotpluggable_cpus()
+     */
+
+
+    object_child_foreach_recursive(qdev_get_machine(), walk_bus, &s);
+    if (s.err) {
+        goto out;
+    }
+
+    if (mc->query_hotpluggable_cpus) {
+        HotpluggableCPUList *hcl = mc->query_hotpluggable_cpus(ms);
+        HotpluggableCPUList *i;
+
+        for (i = hcl; i; i = i->next) {
+            DeviceSlotInfoList *r = g_new0(DeviceSlotInfoList, 1);
+            HotpluggableCPU *hc = i->value;
+            QObject *props;
+
+            r->value = g_new0(DeviceSlotInfo, 1);
+            r->value->accepted_device_types = g_new0(strList, 1);
+            r->value->accepted_device_types->value = g_strdup(hc->type);
+            r->value->available = !hc->has_qom_path;
+            /*TODO: should it be always true? */
+            r->value->hotpluggable = true;
+            r->value->has_count = true;
+            r->value->count = 1;
+
+            props = cpu_instance_props_to_qobj(hc->props, &s.err);
+            qdict_to_slot_props(qobject_to_qdict(props), &r->value->props);
+
+            *s.next = r;
+            s.next = & r->next;
+        }
+
+        qapi_free_HotpluggableCPUList(hcl);
+    }
+
+out:
+    error_propagate(errp, s.err);
+    return s.result;
+}
+
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 static void qbus_print(Monitor *mon, BusState *bus, int indent);
diff --git a/tests/qmp-machine-info.py b/tests/qmp-machine-info.py
index 7905afb..850e89a 100755
--- a/tests/qmp-machine-info.py
+++ b/tests/qmp-machine-info.py
@@ -6,6 +6,8 @@ import qtest
 import unittest
 import logging
 import argparse
+import itertools
+import operator
 
 logger = logging.getLogger('qemu.tests.machineinfo')
 
@@ -35,6 +37,34 @@ NODEFAULTS_BLACKLIST = set([
     'z2',              # "qemu: missing SecureDigital device"
 ])
 
+# iterators for QAPI ValueSets:
+# all of the iterators below should support iter() and len()
+
+def int_range(d):
+    """Iterator for IntegerRange"""
+    return xrange(d['min'], d['max'] + 1)
+
+class IntegerSet:
+    """Iterator for IntegerSet"""
+    def __init__(self, d):
+        self._ranges = d['ranges']
+
+    def __iter__(self):
+        iters = [int_range(r) for r in self._ranges]
+        return itertools.chain(*iters)
+
+    def __len__(self):
+        return sum([len(int_range(r)) for r in self._ranges])
+
+def value_set(d):
+    """Iterator for ValueSet"""
+    if d['type'] == 'list':
+        return d['data']
+    elif d['type'] == 'int-set':
+        return IntegerSet(d['data'])
+    else:
+        raise NotImplementedError
+
 class QueryMachinesTest(unittest.TestCase):
     def setUp(self):
         self.vm = None
@@ -154,9 +184,12 @@ class QueryMachinesTest(unittest.TestCase):
         types_to_check = {}
         buses_to_check = {}
         for slot in slots:
-            if slot['props'].has_key('bus'):
-                bus = slot['props']['bus']
-                buses_to_check.setdefault(bus, []).append(slot)
+            for prop in slot['props']:
+                if prop['option'] == 'bus':
+                    values = value_set(bus['values'])
+                    self.assertEquals(len(values), 1)
+                    bus = values[0]
+                    buses_to_check.setdefault(v, []).append(slot)
 
             for t in slot['accepted-device-types']:
                 types_to_check.setdefault(t, set()).update(slot['props'].keys())
@@ -185,27 +218,32 @@ class QueryMachinesTest(unittest.TestCase):
                 self.assertFalse(slot['available'])
 
     def checkSlotInfo(self, args):
-        #TODO:
-        # * check if -device works with at least one device type
-        # * check if query-hotpluggable-cpus matches what's in query-device-slots
-        # * check if accepted-device-types match the property on the bus
-        # * check if available=false if len(devices) >= max-devices
-        # * check if all plugged devices are really in the QOM tree
+        #TODO: check if:
+        # * -device works with at least one device type
+        # * query-hotpluggable-cpus matches what's in query-device-slots
+        # * accepted-device-types match the property on the bus
+        # * available=false if hotpluggable=false
+        # * 'count' is always set if not incomplete
+        # * slot count is <= set of possible values for @props
         self.vm = qtest.QEMUQtestMachine(args=args, logging=False)
         self.vm.launch()
 
         slots = self.vm.command('query-device-slots')
-        self.checkSlotProps(slots)
+        #self.checkSlotProps(slots)
         #self.checkSlotDevices(slots)
-        self.checkAvailableField(slots)
+        #self.checkAvailableField(slots)
+
+        for slot in slots:
+            logging.debug('slot: %r', slot)
+            if not slot['incomplete']:
+                self.assertTrue(slot.has_key('count'))
+
+                all_counts = [len(value_set(p['values'])) for p in slot['props']]
+                total_count = reduce(operator.mul, all_counts, 1)
+                logging.debug('%d possible values', total_count)
+                self.assertEquals(total_count, slot['count'])
 
     def machineTestSlotInfo(self, machine):
-        #TODO:
-        # * check if -device works with at least one device type
-        # * check if query-hotpluggable-cpus matches what's in query-device-slots
-        # * check if accepted-device-types match the property on the bus
-        # * check if available=false if len(devices) >= max-devices
-        # * check if all plugged devices are really in the QOM tree
         if machine['name'] in BLACKLIST:
             self.skipTest("machine %s on BLACKLIST" % (machine['name']))
 
-- 
2.7.4
