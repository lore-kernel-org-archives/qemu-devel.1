Received: from eggs.gnu.org ([209.51.188.92]:35876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1gwD9L-0003Pl-MG
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1gwD9E-0001gI-Te
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1gwD9B-0001dp-19
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:41:50 -0500
Date: Tue, 19 Feb 2019 22:31:56 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190219213156.64gu4swv3uqs5yxv@jenstp.localdomain>
References: <155060310248.19547.14979269067689441201.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155060310248.19547.14979269067689441201.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH] pci: Sanity test minimum downstream LNKSTA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com

On Tue, Feb 19, 2019 at 12:06:43PM -0700, Alex Williamson wrote:
>The entire link status register for SR-IOV VFs is defined as RsvdZ,
>reads simply return zero.  Usually this is nothing more than lspci
>reporting inconsequentially broken values:
>
>    LnkSta: Speed unknown, Width x0, ...
>
>However, now that we're using the downstream endpoint link status to
>fill in the value at the parent downstream port, invalid values become
>a problem.  In particular, the PCIe hotplug driver in Linux looks for
>a valid negotiated link width and will fail to enumerate hot-added
>downstream endpoints without non-zero value here, ex:
>
>    pciehp 0000:00:02.0:pcie004: Slot(0): Attention button pressed
>    pciehp 0000:00:02.0:pcie004: Slot(0) Powering on due to button press
>    pciehp 0000:00:02.0:pcie004: Slot(0): Card present
>    pciehp 0000:00:02.0:pcie004: Slot(0): Link Up
>    pciehp 0000:00:02.0:pcie004: link training error: status 0x2000
>    pciehp 0000:00:02.0:pcie004: Failed to check link status
>
>Resolve by using minimum width and speed values for the downstream
>port link status when the endpoint fails to provide valid values.
>Long term, we may want to implement emulation in the vfio-pci host
>driver to suppliment this field with the PF value as the SR-IOV spec
>seems to allow, but the solution here is compatible should that be
>implemented later.
>
>Fixes: 727b48661f75 ("pci: Sync PCIe downstream port LNKSTA on read")
>Reported-by: Jens Freimann <jfreimann@redhat.com>
>Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Before I got the link training error message, it looks much better
with this patch:

[   26.572401] pciehp 0000:00:02.0:pcie004: Slot(0): Attention button pressed
[   26.573114] pciehp 0000:00:02.0:pcie004: Slot(0) Powering on due to button press
[   26.573941] pciehp 0000:00:02.0:pcie004: Slot(0): Card present
[   26.574518] pciehp 0000:00:02.0:pcie004: Slot(0): Link Up
[   26.704154] pci 0000:01:00.0: [8086:154c] type 00 class 0x020000
[   26.704971] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit pref]
[   26.705785] pci 0000:01:00.0: reg 0x1c: [mem 0x00000000-0x00003fff 64bit pref]
[   26.706627] pci 0000:01:00.0: enabling Extended Tags
[   26.707671] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:02.0 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[   26.712880] pci 0000:01:00.0: BAR 0: assigned [mem 0xfd400000-0xfd40ffff 64bit pref]
[   26.715039] pci 0000:01:00.0: BAR 3: assigned [mem 0xfd410000-0xfd413fff 64bit pref]
[   26.716595] pcieport 0000:00:02.0: PCI bridge to [bus 01]
[   26.717218] pcieport 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
[   26.720099] pcieport 0000:00:02.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[   26.723214] pcieport 0000:00:02.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
[   26.760930] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver - version 3.2.3-k
[   26.763917] Copyright (c) 2013 - 2018 Intel Corporation.
[   26.767749] iavf 0000:01:00.0: enabling device (0000 -> 0002)
[   26.833042] iavf 0000:01:00.0: Invalid MAC address 00:00:00:00:00:00, using random
[   26.837259] iavf 0000:01:00.0: Multiqueue Enabled: Queue pair count = 3
[   26.841244] iavf 0000:01:00.0: MAC address: 36:33:3d:5a:ca:1c
[   26.842582] iavf 0000:01:00.0: GRO is enabled
[   26.897435] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   26.930108] IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
[   26.976234] iavf 0000:01:00.0 eth2: NIC Link is Up 40 Gbps Full Duplex
[   26.976895] IPv6: ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
[   45.668979] systemd-hostnam (749) used greatest stack depth: 21288 bytes left
[   54.812727] dracut-install (3567) used greatest stack depth: 20088 bytes left


Tested-by: Jens Freimann <jfreimann@redhat.com>

regards,
Jens  
