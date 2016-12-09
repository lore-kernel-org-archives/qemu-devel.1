Received: from eggs.gnu.org ([2001:4830:134:3::10]:49969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFRxb-0007Tg-Q6
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 15:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cFRxW-0002b0-VX
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 15:40:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cFRxW-0002ao-Pn
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 15:39:58 -0500
Date: Fri, 9 Dec 2016 18:39:54 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161209203954.GW4027@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>

Using latest qemu.git master:

  $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
  QEMU 2.7.93 monitor - type 'help' for more information
  (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
  (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
  Segmentation fault (core dumped)

It crashes at:

  #7  0x000055555598d7dc in do_pci_register_device (errp=0x7fffffffbfd0, devfn=64, name=0x5555565df340 "e1000e", bus=0x555558487380, pci_dev=0x5555589cd000)
      at /home/ehabkost/rh/proj/virt/qemu/hw/pci/pci.c:983
  983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
  (gdb) l
  978                        PCI_SLOT(devfn), PCI_FUNC(devfn), name,
  979                        bus->devices[devfn]->name);
  980             return NULL;
  981         } else if (dev->hotplugged &&
  982                    pci_get_function_0(pci_dev)) {
  983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
  984                        " new func %s cannot be exposed to guest.",
  985                        PCI_SLOT(devfn),
  986                        bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
  987                        name);

-- 
Eduardo
