Received: from eggs.gnu.org ([2001:4830:134:3::10]:33394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cGJBl-0001hi-0v
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 00:30:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cGJBh-0007qX-4X
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 00:30:13 -0500
Received: from [59.151.112.132] (port=62201 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cGJBg-0007iB-N8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 00:30:09 -0500
References: <20161209203954.GW4027@thinpad.lan.raisama.net>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <584E36CD.50405@cn.fujitsu.com>
Date: Mon, 12 Dec 2016 13:34:05 +0800
MIME-Version: 1.0
In-Reply-To: <20161209203954.GW4027@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Reproducible crash on PCIe hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 12/10/2016 04:39 AM, Eduardo Habkost wrote:
> Using latest qemu.git master:
> 
>   $ qemu-system-x86_64 -machine q35 -readconfig docs/q35-chipset.cfg -monitor stdio
>   QEMU 2.7.93 monitor - type 'help' for more information
>   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=00
>   (qemu) device_add e1000e,bus=ich9-pcie-port-4,addr=08
>   Segmentation fault (core dumped)
> 
> It crashes at:
> 
>   #7  0x000055555598d7dc in do_pci_register_device (errp=0x7fffffffbfd0, devfn=64, name=0x5555565df340 "e1000e", bus=0x555558487380, pci_dev=0x5555589cd000)
>       at /home/ehabkost/rh/proj/virt/qemu/hw/pci/pci.c:983
>   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>   (gdb) l
>   978                        PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>   979                        bus->devices[devfn]->name);
>   980             return NULL;
>   981         } else if (dev->hotplugged &&
>   982                    pci_get_function_0(pci_dev)) {
>   983             error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>   984                        " new func %s cannot be exposed to guest.",
>   985                        PCI_SLOT(devfn),
>   986                        bus->devices[PCI_DEVFN(PCI_SLOT(devfn), 0)]->name,
>   987                        name);
> 

Thanks for informing me. I am kind of busy for now, so I suppose I will
investigate it after 2.8 release.
-- 
Sincerely,
Cao jin
