Received: from eggs.gnu.org ([2001:4830:134:3::10]:46396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cF4yq-0001KQ-Sp
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cF4yk-0004ME-Gz
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:07:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cF4yk-0004Lq-06
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:07:42 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3AFDC04D2AC
	for <qemu-devel@nongnu.org>; Thu,  8 Dec 2016 20:07:39 +0000 (UTC)
Date: Thu, 8 Dec 2016 18:07:37 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161208200737.GA29563@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [RFC] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This adds a new command to QMP: query-device-slots. It will allow
management software to query possible slots where devices can be
plugged.

This implementation of the command will return:

* Multiple PCI slots per bus, in the case of PCI buses;
* One slot per bus in the case of the other buses;
* One slot for each entry from query-hotpluggable-cpus.

In the example below, I am not sure if the PCIe ports are all
supposed to report all slots, but I didn't find any existing
field in PCIBus that would help me figure out the actual number
of slots in a given PCI bus.

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

 {
    "return": [
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[30]",
                "/machine/unattached/device[29]",
                "/machine/unattached/device[28]",
                "/machine/unattached/device[27]",
                "/machine/unattached/device[26]",
                "/machine/unattached/device[25]",
                "/machine/unattached/device[24]",
                "/machine/unattached/device[23]"
            ],
            "accepted-device-types": [
                "i2c-slave"
            ],
            "props": {
                "bus": "/machine/unattached/device[22]/i2c"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.4"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.5"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.0"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.1"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[21]"
            ],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.2"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "ide-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[20]/ide.3"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[8]",
                "/machine/q35/ioapic",
                "/machine/q35",
                "/machine/fw_cfg",
                "/machine/unattached/device[1]"
            ],
            "accepted-device-types": [
                "sys-bus-device"
            ],
            "props": {
                "bus": "/machine/unattached/sysbus"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[19]",
                "/machine/unattached/device[18]",
                "/machine/unattached/device[17]",
                "/machine/unattached/device[16]",
                "/machine/unattached/device[15]",
                "/machine/unattached/device[14]",
                "/machine/unattached/device[13]",
                "/machine/unattached/device[12]",
                "/machine/unattached/device[11]",
                "/machine/unattached/device[10]",
                "/machine/unattached/device[9]",
                "/machine/unattached/device[7]",
                "/machine/unattached/device[6]"
            ],
            "accepted-device-types": [
                "isa-device"
            ],
            "props": {
                "bus": "/machine/unattached/device[5]/isa.0"
            },
            "hotpluggable": false,
            "type": "generic"
        },
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
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[31]"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 8
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[32]"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 16
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 24
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
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
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 40
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 48
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 56
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 64
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 72
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 80
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 88
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 96
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 104
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 112
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 120
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 128
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 136
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 144
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 152
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 160
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 168
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 176
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 184
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 192
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 200
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/peripheral/ich9-uhci-4"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 208
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/peripheral/ich9-hda-audio"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 216
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/peripheral/ich9-pcie-port-1"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 224
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/peripheral/ich9-uhci-1"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 232
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/peripheral/ich9-pci-bridge"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 240
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[5]"
            ],
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/q35/pcie.0",
                "addr": 248
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 0
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 8
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 16
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 24
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 32
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 40
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 48
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 56
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 64
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 72
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 80
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 88
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 96
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 104
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 112
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 120
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 128
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 136
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 144
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 152
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 160
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 168
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 176
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 184
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 192
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 200
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 208
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 216
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 224
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 232
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 240
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-1/ich9-pcie-port-1",
                "addr": 248
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 0
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 8
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 16
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 24
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 32
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 40
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 48
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 56
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 64
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 72
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 80
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 88
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 96
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 104
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 112
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 120
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 128
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 136
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 144
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 152
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 160
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 168
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 176
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 184
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 192
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 200
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 208
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 216
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 224
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 232
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 240
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-2/ich9-pcie-port-2",
                "addr": 248
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
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
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 8
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 16
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 24
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 32
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 40
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 48
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 56
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 64
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 72
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 80
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 88
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 96
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 104
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 112
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 120
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 128
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 136
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 144
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 152
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 160
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 168
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 176
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 184
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 192
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 200
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 208
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 216
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 224
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 232
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 240
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-3/ich9-pcie-port-3",
                "addr": 248
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 0
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 8
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 16
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 24
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 32
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 40
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 48
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 56
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 64
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 72
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 80
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 88
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 96
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 104
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 112
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 120
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 128
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 136
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 144
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 152
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 160
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 168
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 176
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 184
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 192
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 200
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 208
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 216
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 224
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 232
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 240
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "pci-express-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pcie-port-4/ich9-pcie-port-4",
                "addr": 248
            },
            "hotpluggable": true,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 0
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 8
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 16
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 24
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 32
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 40
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 48
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 56
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 64
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 72
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 80
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 88
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 96
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 104
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 112
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 120
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 128
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 136
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 144
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 152
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 160
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 168
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 176
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 184
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 192
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 200
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 208
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 216
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 224
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 232
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 240
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "legacy-pci-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-pci-bridge/ich9-pci-bridge",
                "addr": 248
            },
            "hotpluggable": false,
            "type": "pci",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "usb-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-ehci-1/ich9-ehci-1.0"
            },
            "hotpluggable": true,
            "type": "generic"
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "usb-device"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-ehci-2/ich9-ehci-2.0"
            },
            "hotpluggable": true,
            "type": "generic"
        },
        {
            "available": false,
            "devices": [],
            "accepted-device-types": [
                "hda-codec"
            ],
            "props": {
                "bus": "/machine/peripheral/ich9-hda-audio/ich9-hda-audio.0"
            },
            "hotpluggable": false,
            "type": "generic"
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 1,
                "core-id": 1,
                "thread-id": 1
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 1,
                "core-id": 1,
                "thread-id": 0
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 1,
                "core-id": 0,
                "thread-id": 1
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": true,
            "devices": [],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 1,
                "core-id": 0,
                "thread-id": 0
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[4]"
            ],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 0,
                "core-id": 1,
                "thread-id": 1
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[3]"
            ],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 0,
                "core-id": 1,
                "thread-id": 0
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[2]"
            ],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 0,
                "core-id": 0,
                "thread-id": 1
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        },
        {
            "available": false,
            "devices": [
                "/machine/unattached/device[0]"
            ],
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ],
            "props": {
                "socket-id": 0,
                "core-id": 0,
                "thread-id": 0
            },
            "hotpluggable": true,
            "type": "cpu",
            "max-devices": 1
        }
    ]
  }

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json       | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h |   6 +++
 hw/core/bus.c          |  49 +++++++++++++++++++++
 hw/pci/pci.c           | 106 +++++++++++++++++++++++++++++++++------------
 qdev-monitor.c         |  86 ++++++++++++++++++++++++++++++++++---
 5 files changed, 328 insertions(+), 33 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index d48ff3f..484d91e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3166,6 +3166,120 @@
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
 ##
+# @DeviceSlotType:
+#
+# Type of device slot
+#
+# @generic: Generic device slot, with no bus-specific information
+# @pci: PCI device slot
+# @cpu: CPU device slot
+##
+{ 'enum': 'DeviceSlotType',
+  'data': ['generic', 'pci', 'cpu'] }
+
+##
+# @DeviceSlotInfo:
+#
+# Information on a slot where devices can be plugged. Some buses
+# are represented as a single slot that can support multiple devices,
+# and some buses have multiple slots that are identified by arguments
+# to @device_add.
+#
+# @bus: ID of the bus object where the device can be plugged. Optional,
+#       as some devices don't need a bus to be plugged (e.g. CPUs).
+#       Can be copied to the "bus" argument to @device_add.
+#
+# @type: type of device slot.
+#
+# @accepted-device-types: List of device types accepted by the slot.
+#                         Any device plugged to the slot should implement
+#                         one of the accepted device types.
+#
+# @max-devices: #optional maximum number of devices that can be plugged
+#               to the slot.
+#
+# @devices: List of QOM paths for devices that are already plugged.
+#
+# @available: If false, the slot is not available for plugging any device.
+#             This value can change at runtime if condition changes
+#             (e.g. if the device becomes full, or if the machine
+#             was already initialized and the slot doesn't support
+#             hotplug).
+#
+# @hotpluggable: If true, the slot accepts hotplugged devices.
+#
+# DeviceSlotInfo structs always have a @props member, whose members
+# can be directly copied to the arguments to @device_add.
+##
+{ 'union': 'DeviceSlotInfo',
+  'base': { 'type': 'DeviceSlotType',
+            'accepted-device-types': [ 'str' ],
+            '*max-devices': 'int', 'devices': [ 'str' ],
+            'available': 'bool', 'hotpluggable': 'bool' },
+  'discriminator': 'type',
+  'data': { 'generic': 'GenericSlotInfo',
+            'pci': 'PCISlotInfo',
+            'cpu': 'CPUSlotInfo' } }
+
+##
+# @GenericSlotProperties:
+##
+{ 'struct': 'GenericSlotProperties',
+  'data': { 'bus': 'str' } }
+
+
+##
+# @GenericSlotInfo:
+#
+# Generic slot information, with no bus-specific information
+##
+{ 'struct': 'GenericSlotInfo',
+  'data': { 'props': 'GenericSlotProperties' } }
+
+##
+# @PCIDeviceSlotProperties:
+#
+# Properties that can be set when plugging a PCI device.
+#
+# @addr: "addr" argument to @device_add.
+#
+#FIXME: replace @addr with slot and function properties.
+##
+{ 'struct': 'PCIDeviceSlotProperties',
+  'data': { 'bus': 'str', 'addr': 'int' } }
+
+##
+# @PCISlotInfo:
+#
+# Information on a PCI device slot.
+#
+# @props: The @device_add arguments that can be used when plugging
+# the device.
+##
+{ 'struct': 'PCISlotInfo',
+  'data': { 'props': 'PCIDeviceSlotProperties' } }
+
+##
+# @CPUSlotInfo:
+#
+# Information on a CPU device slot.
+#
+# @props: The @device_add arguments that can be used when plugging
+# the device.
+##
+{ 'struct': 'CPUSlotInfo',
+  'data': { 'props': 'CpuInstanceProperties' } }
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
+##
 # @MachineBusInfo
 #
 # Information about a bus present on a machine.
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a7f9ac4..7a87234 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -214,6 +214,10 @@ struct BusClass {
      * but on some cases bus instances may override it.
      */
     const char *device_type;
+
+    /*TOD: write doc */
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
diff --git a/hw/core/bus.c b/hw/core/bus.c
index d2bf717..58b5c3d 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
 #include "qapi-visit.h"
 
 static void qbus_set_hotplug_handler_internal(BusState *bus, Object *handler,
@@ -225,12 +226,60 @@ static void bus_get_device_type(Object *obj, Visitor *v,
     visit_type_strList(v, NULL, &bus->accepted_device_types, errp);
 }
 
+bool qbus_is_full(BusState *bus)
+{
+    BusClass *bus_class = BUS_GET_CLASS(bus);
+    return bus_class->max_dev && bus->max_index >= bus_class->max_dev;
+}
+
+/* Generic slot enumeration function: will return a single slot
+ * for the bus, with max_devices set to BusClass::max_dev, if set.
+ */
+static DeviceSlotInfoList *bus_generic_enumerate_slots(BusState *bus, Error **errp)
+{
+    Error *local_err = NULL;
+    BusClass *bc = BUS_GET_CLASS(bus);
+    strList **devlist;
+    BusChild *kid;
+    DeviceSlotInfoList *r = g_new0(DeviceSlotInfoList, 1);
+
+    r->value = g_new0(DeviceSlotInfo, 1);
+    r->value->type = DEVICE_SLOT_TYPE_GENERIC;
+    r->value->has_max_devices = bc->max_dev > 0;
+    r->value->max_devices = bc->max_dev;
+    r->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+    r->value->u.generic.props = g_new0(GenericSlotProperties, 1);
+    r->value->u.generic.props->bus = object_get_canonical_path(OBJECT(bus));
+
+    devlist = &r->value->devices;
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        strList *item = g_new0(strList, 1);
+        item->value = object_get_canonical_path(OBJECT(dev));
+        *devlist = item;
+        devlist = &item->next;
+    }
+    r->value->hotpluggable = qbus_is_hotpluggable(bus);
+
+    /* Conditions that make a bus unavailable:
+     * - Bus already full
+     * - Hotplug when the bus is not hotpluggable
+     */
+    r->value->available =
+        !(qbus_is_full(bus) ||
+          (qdev_hotplug && !qbus_is_hotpluggable(bus)));
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
index 2eac71a..9bcc116 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -41,6 +41,7 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
+#include "qapi/clone-visitor.h"
 
 //#define DEBUG_PCI
 #ifdef DEBUG_PCI
@@ -141,6 +142,8 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+static DeviceSlotInfoList *pci_bus_enumerate_slots(BusState *bus, Error **errp);
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
@@ -156,6 +159,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
      * but overrides BusClass::device_type to INTERFACE_PCIE_DEVICE
      */
     k->device_type = INTERFACE_LEGACY_PCI_DEVICE;
+    k->enumerate_slots = pci_bus_enumerate_slots;
 
     pbc->is_root = pcibus_is_root;
     pbc->bus_num = pcibus_num;
@@ -967,6 +971,81 @@ uint16_t pci_requester_id(PCIDevice *dev)
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
+static DeviceSlotInfoList *pci_bus_enumerate_slots(BusState *bus, Error **errp)
+{
+    PCIBus *pb = PCI_BUS(bus);
+    int devfn;
+    DeviceSlotInfoList *r = NULL;
+    DeviceSlotInfoList **next = &r;
+
+    for(devfn = pb->devfn_min; devfn < ARRAY_SIZE(pb->devices);
+        devfn += PCI_FUNC_MAX) {
+        DeviceSlotInfoList *i = g_new0(DeviceSlotInfoList, 1);
+        i->value = g_new0(DeviceSlotInfo, 1);
+        i->value->type = DEVICE_SLOT_TYPE_PCI;
+        i->value->has_max_devices = true;
+        i->value->max_devices = 1;
+        i->value->u.pci.props = g_new0(PCIDeviceSlotProperties, 1);
+        i->value->u.pci.props->bus = object_get_canonical_path(OBJECT(bus));
+        i->value->u.pci.props->addr = devfn;
+        /*TODO: add info about accepting only bridges on extra PCI root buses */
+        i->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+        if (pb->devices[devfn]) {
+            i->value->devices = g_new0(strList, 1);
+            i->value->devices->value =
+                object_get_canonical_path(OBJECT(pb->devices[devfn]));
+        }
+
+        i->value->hotpluggable = qbus_is_hotpluggable(bus);
+        /* Conditions that make a devfn unavailable:
+         * - Hotplug when function 0 is already occupied
+         * - devfn already occupied by a device
+         * - Hotplug when the bus is not hotpluggable
+         */
+        i->value->available =
+            !((qdev_hotplug && pci_bus_get_function_0(pb, devfn)) ||
+              (pb->devices[devfn]) ||
+              (qdev_hotplug && !qbus_is_hotpluggable(bus)));
+
+        *next = i;
+        next = &i->next;
+    }
+
+    return r;
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -2607,33 +2686,6 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range)
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
diff --git a/qdev-monitor.c b/qdev-monitor.c
index c73410c..b4071c4 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,8 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
+#include "qapi/clone-visitor.h"
+#include "hw/boards.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -399,12 +401,6 @@ static DeviceState *qbus_find_dev(BusState *bus, char *elem)
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
@@ -631,6 +627,84 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return dev;
 }
 
+typedef struct SlotListState {
+    DeviceSlotInfoList *result;
+    DeviceSlotInfoList **next;
+    Error *err;
+} SlotListState;
+
+static int walk_bus(Object *obj, void *opaque)
+{
+    SlotListState *s = opaque;
+    if (object_dynamic_cast(obj, TYPE_BUS)) {
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
+DeviceSlotInfoList *qmp_query_device_slots(Error **errp)
+{
+    SlotListState s = { };
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+
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
+            r->value = g_new0(DeviceSlotInfo, 1);
+            r->value->type = DEVICE_SLOT_TYPE_CPU;
+            r->value->accepted_device_types = g_new0(strList, 1);
+            r->value->accepted_device_types->value = g_strdup(hc->type);
+            r->value->has_max_devices = true;
+            r->value->max_devices = 1;
+            r->value->available = !hc->has_qom_path;
+            /*TODO: should it be always true? */
+            r->value->hotpluggable = true;
+
+            if (hc->has_qom_path) {
+                r->value->devices = g_new0(strList, 1);
+                r->value->devices->value = g_strdup(hc->qom_path);
+            }
+            r->value->u.cpu.props = QAPI_CLONE(CpuInstanceProperties,
+                                               hc->props);
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
-- 
2.7.4

-- 
Eduardo
