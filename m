Received: from eggs.gnu.org ([2001:4830:134:3::10]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eAGhX-0005MY-B8
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eAGhS-0004jR-Ul
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:42:34 -0400
References: <a0750de5-d3ce-3f15-ba12-ce383ded143d@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <1e04415c-83d5-a6ac-f83f-d7a57b9b9868@redhat.com>
Date: Thu, 2 Nov 2017 16:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <a0750de5-d3ce-3f15-ba12-ce383ded143d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Crash with pcie-pci-bridge on qemu-system-s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org
Cc: Aleksandr Bezzubikov <zuban32s@gmail.com>

On 02/11/2017 16:19, Thomas Huth wrote:
>   Hi,
> 

Hi Thomas,

> seems like there's a new way to crash QEMU with the pcie-pci-bridge
> device (using QEMU master branch of today):
>  > $ s390x-softmmu/qemu-system-s390x -nographic -S
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add pcie-pci-bridge,id=x
> Segmentation fault (core dumped)
> 

Thanks for noticing it.

> Does anybody have a clue what might be wrong here?
> 

It was tested with X86 and I think aarch64.
I am not sure how it would work with or if we
really need it for s390.

We need the device to start a PCI hierarchy by plugging
it to PCIe Root Port. If I understand correctly s390
does not use PCIe Root Ports and may not need it.

If the assumption is correct I suppose we should only
be compiled into the above archs.
If you agree, I can post a patch for this.

Thanks,
Marcel

> Backtrace looks like this:
> 
> #0  0x000055555577064b in pci_default_write_config (d=d@entry=0x0,
> addr=addr@entry=26, val_in=1, l=l@entry=1) at
> /home/thuth/devel/qemu/hw/pci/pci.c:1367
> #1  0x00005555556c885f in s390_pcihost_hot_plug (hotplug_dev=<optimized
> out>, dev=0x55555639b160, errp=0x7fffffffc5a0) at
> /home/thuth/devel/qemu/hw/s390x/s390-pci-bus.c:684
> #2  0x000055555575afeb in device_set_realized (obj=<optimized out>,
> value=<optimized out>, errp=0x7fffffffc6d8) at
> /home/thuth/devel/qemu/hw/core/qdev.c:936
> #3  0x00005555557ee48e in property_set_bool (obj=0x55555639b160,
> v=<optimized out>, name=<optimized out>, opaque=0x555556399fe0,
> errp=0x7fffffffc6d8)
>      at /home/thuth/devel/qemu/qom/object.c:1906
> #4  0x00005555557f25ff in object_property_set_qobject
> (obj=obj@entry=0x55555639b160, value=value@entry=0x55555639d170,
> name=name@entry=0x5555559a4157 "realized",
> errp=errp@entry=0x7fffffffc6d8) at
> /home/thuth/devel/qemu/qom/qom-qobject.c:27
> #5  0x00005555557f0270 in object_property_set_bool (obj=0x55555639b160,
> value=<optimized out>, name=0x5555559a4157 "realized", errp=0x7fffffffc6d8)
>      at /home/thuth/devel/qemu/qom/object.c:1171
> #6  0x000055555570b549 in qdev_device_add
> (opts=opts@entry=0x55555640cb50, errp=errp@entry=0x7fffffffc7b0) at
> /home/thuth/devel/qemu/qdev-monitor.c:632
> ...
> 
>   Thomas
> 
