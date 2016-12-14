Received: from eggs.gnu.org ([2001:4830:134:3::10]:39194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHFOe-0006Hx-Qx
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:39:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHFOa-0000yJ-V4
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:39:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cHFOa-0000xy-IQ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:39:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 996EF3D97F
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:39:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Dec 2016 17:39:08 -0200
Message-Id: <1481744348-8868-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v2] qmp: query-device-slots command
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

This adds a new command to QMP: query-device-slots. It will allow
management software to query possible slots where devices can be
plugged.

This implementation of the command will return:

* Multiple PCI slots per bus, in the case of PCI buses;
* One slot per bus for the other buses (that don't
  implement slot enumeration yet);
* One slot for each entry from query-hotpluggable-cpus.

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
            "hotpluggable": false,
            "props": {
                "bus": "i2c"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "i2c-slave"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.4"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.5"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.0"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.1"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.2"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ide.3"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "ide-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "main-system-bus"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "sys-bus-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "isa.0"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "isa-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 1
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 2
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 3
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 4
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 5
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 6
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 7
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 8
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 9
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 10
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 11
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 12
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 13
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 14
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 15
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 16
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 17
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 18
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 19
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 20
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 21
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 22
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 23
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 24
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 25
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 26
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 27
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 28
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 29
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 30
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "pcie.0",
                "device-number": 31
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device",
                "pci-express-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-pcie-port-1",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "pci-express-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-pcie-port-2",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "pci-express-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-pcie-port-3",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "pci-express-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-pcie-port-4",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "pci-express-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 0
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 1
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 2
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 3
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 4
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 5
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 6
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 7
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 8
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 9
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 10
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 11
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 12
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 13
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 14
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 15
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 16
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 17
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 18
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 19
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 20
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 21
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 22
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 23
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 24
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 25
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 26
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 27
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 28
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 29
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 30
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-pci-bridge",
                "device-number": 31
            },
            "type": "pci",
            "accepted-device-types": [
                "legacy-pci-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-ehci-1.0"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "usb-device"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "bus": "ich9-ehci-2.0"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "usb-device"
            ]
        },
        {
            "available": false,
            "hotpluggable": false,
            "props": {
                "bus": "ich9-hda-audio.0"
            },
            "type": "non-slot",
            "accepted-device-types": [
                "hda-codec"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "socket-id": 1,
                "core-id": 1,
                "thread-id": 1
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "socket-id": 1,
                "core-id": 1,
                "thread-id": 0
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "socket-id": 1,
                "core-id": 0,
                "thread-id": 1
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": true,
            "hotpluggable": true,
            "props": {
                "socket-id": 1,
                "core-id": 0,
                "thread-id": 0
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": false,
            "hotpluggable": true,
            "props": {
                "socket-id": 0,
                "core-id": 1,
                "thread-id": 1
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": false,
            "hotpluggable": true,
            "props": {
                "socket-id": 0,
                "core-id": 1,
                "thread-id": 0
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": false,
            "hotpluggable": true,
            "props": {
                "socket-id": 0,
                "core-id": 0,
                "thread-id": 1
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
        },
        {
            "available": false,
            "hotpluggable": true,
            "props": {
                "socket-id": 0,
                "core-id": 0,
                "thread-id": 0
            },
            "type": "cpu",
            "accepted-device-types": [
                "qemu64-x86_64-cpu"
            ]
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
---
 qapi-schema.json       | 131 +++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-core.h |   6 ++
 hw/core/bus.c          |  35 +++++++++++
 hw/pci/pci.c           | 165 +++++++++++++++++++++++++++++++++++++++++--------
 qdev-monitor.c         |  88 ++++++++++++++++++++++++--
 5 files changed, 392 insertions(+), 33 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index d48ff3f..50e09f5 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3166,6 +3166,137 @@
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
 ##
+# @DeviceSlotType:
+#
+# Type of device slot
+#
+# @non-slot: Slot type representing a bus that doesn't return any
+#            specific slot information yet.
+# @pci: PCI device slot
+# @cpu: CPU device slot
+#
+#TODO: try to find a better name for non-slot. "generic-bus", maybe?
+##
+{ 'enum': 'DeviceSlotType',
+  'data': ['non-slot', 'pci', 'cpu'] }
+
+##
+# @DeviceSlotInfo:
+#
+# Information on a slot where devices can be plugged.
+#
+# @type: type of device slot.
+#
+# @accepted-device-types: List of device types accepted by the slot.
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
+# @props: The arguments that should be given to @device_add if plugging
+#         a device to this slot.
+#
+# For specific rules about what can be plugged on each type of slot,
+# see the type-specific structs (@NonSlotInfo, @PCISlotInfo,
+# @CPUSlotInfo).
+##
+{ 'union': 'DeviceSlotInfo',
+  'base': { 'type': 'DeviceSlotType',
+            'accepted-device-types': [ 'str' ],
+            'available': 'bool', 'hotpluggable': 'bool' },
+  'discriminator': 'type',
+  'data': { 'non-slot': 'NonSlotInfo',
+            'pci': 'PCISlotInfo',
+            'cpu': 'CPUSlotInfo' } }
+
+##
+# @NonSlotProperties:
+#
+# Arguments to @device_add when plugging a device to a bus that
+# doesn't return specific slot info yet.
+#
+# @bus: "bus" argument to @device_add.
+#
+# Slots returned as type=non-slot might require extra arguments to
+# be set to specify the device address, but they are not covered by
+# NonSlotInfoProperties.
+##
+{ 'struct': 'NonSlotProperties',
+  'data': { 'bus': 'str' } }
+
+
+##
+# @NonSlotInfo:
+#
+# Generic entry representing a bus that doesn't support slot enumeration
+# yet. Slots of this type should be replaced by more specific slot types
+# in future QEMU versions.
+#
+# Slots of this type may or may not support multiple devices.
+#
+# @props: The arguments that should be given to @device_add if plugging
+#         a device to this slot. The list of properties might be incomplete
+#         in case the bus requires additional parameters to be provided.
+##
+{ 'struct': 'NonSlotInfo',
+  'data': { 'props': 'NonSlotProperties' } }
+
+##
+# @PCIDeviceSlotProperties:
+#
+# Arguments to @device_add when plugging a device to a PCI slot.
+#
+# @bus: "bus" argument to @device_add.
+# @slot: "device-number" argument to @device_add. PCI device
+#        number (sometimes called "slot").
+#
+##
+{ 'struct': 'PCIDeviceSlotProperties',
+  'data': { 'bus': 'str', 'device-number': 'int' } }
+
+##
+# @PCISlotInfo:
+#
+# Information on a PCI device slot.
+#
+# @props: The arguments that should be given to @device_add if plugging
+#         a device to this slot.
+#
+# PCI device slots become unavailable after a device is plugged to
+# function 0.
+##
+{ 'struct': 'PCISlotInfo',
+  'data': { 'props': 'PCIDeviceSlotProperties' } }
+
+##
+# @CPUSlotInfo:
+#
+# Information on a CPU device slot.
+#
+# @props: The arguments that should be given to @device_add if plugging
+#         a device to this slot.
+#
+# CPU slots become unavailable after one device is plugged to them.
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
diff --git a/hw/core/bus.c b/hw/core/bus.c
index d2bf717..451fa46 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "hw/qdev.h"
 #include "qapi/error.h"
+#include "qapi/clone-visitor.h"
 #include "qapi-visit.h"
 
 static void qbus_set_hotplug_handler_internal(BusState *bus, Object *handler,
@@ -225,12 +226,46 @@ static void bus_get_device_type(Object *obj, Visitor *v,
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
+    r->value->type = DEVICE_SLOT_TYPE_NON_SLOT;
+    r->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+    r->value->u.non_slot.props = g_new0(NonSlotProperties, 1);
+    r->value->u.non_slot.props->bus = g_strdup(bus->name);
+
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
index 2eac71a..7870af9 100644
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
@@ -967,6 +971,77 @@ uint16_t pci_requester_id(PCIDevice *dev)
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
+    int slot, slots;
+    DeviceSlotInfoList *r = NULL;
+    DeviceSlotInfoList **next = &r;
+
+    if (pci_bus_has_pcie_upstream_port(pb)) {
+        slots = 1;
+    } else {
+        slots = PCI_SLOT_MAX;
+    }
+
+    for(slot = PCI_SLOT(pb->devfn_min); slot < slots; slot++) {
+        DeviceSlotInfoList *i = g_new0(DeviceSlotInfoList, 1);
+        i->value = g_new0(DeviceSlotInfo, 1);
+        i->value->type = DEVICE_SLOT_TYPE_PCI;
+        i->value->u.pci.props = g_new0(PCIDeviceSlotProperties, 1);
+        i->value->u.pci.props->bus = g_strdup(bus->name);
+        i->value->u.pci.props->device_number = slot;
+        /*TODO: add info about accepting only bridges on extra PCI root buses */
+        i->value->accepted_device_types = QAPI_CLONE(strList, bus->accepted_device_types);
+
+        i->value->hotpluggable = qbus_is_hotpluggable(bus);
+        /* Conditions that make a slot unavailable:
+         * - function 0 already occupied by a device
+         * - Hotplug when the bus is not hotpluggable
+         */
+        i->value->available =
+            !((pb->devices[PCI_DEVFN(slot, 0)]) ||
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
@@ -2509,6 +2584,56 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
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
@@ -2519,6 +2644,19 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
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
@@ -2607,33 +2745,6 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range)
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
index c73410c..44f8b5c 100644
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
@@ -631,6 +627,86 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
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
+            r->value = g_new0(DeviceSlotInfo, 1);
+            r->value->type = DEVICE_SLOT_TYPE_CPU;
+            r->value->accepted_device_types = g_new0(strList, 1);
+            r->value->accepted_device_types->value = g_strdup(hc->type);
+            r->value->available = !hc->has_qom_path;
+            /*TODO: should it be always true? */
+            r->value->hotpluggable = true;
+
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
