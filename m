Received: from eggs.gnu.org ([2001:4830:134:3::10]:37451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXSsy-0000RV-Et
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXSsu-00041M-Fc
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dXSsu-0003zy-9j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:49:56 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
Date: Tue, 18 Jul 2017 16:49:51 +0300
MIME-Version: 1.0
In-Reply-To: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] >256 Virtio-net-pci hotplug Devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kinsella, Ray" <ray.kinsella@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 18/07/2017 0:50, Kinsella, Ray wrote:
> Hi folks,
> 

Hi Ray,

> I am trying to create a VM that supports hot-plugging a large number of virtio-net-pci device,
> up to 1000 devices initially.
> 
>  From the docs (see below) and from playing with QEMU, it looks like there are two options.
> Both with limitations.
> 
> PCI Express switch
> 
> It looks like using a PCI Express switch hierarchy is not an option due to bus exhaustion.
> Each downstream port creates a separate bus and each downstream port only supports hot-plugging a single device.
> So this gives us a max of 256-ish buses/devices pairs.

Right.

> 
> PCI Root Ports
> 
> The other option is use a flatter hierarchy, with a number of multi-function PCI Root Ports hanging off 'pcie.0'.
> However each 'PCI Root Port' can support hot-plugging a single device.
> So this method really becomes a function of how many free address we have on 'pci.0'.
> If we make room for say 16 multifunction devices, we get 16*8 ... 128
> So ultimately, this will approach will give us a similar to number to using a switch.
> 
> Is there another method?

You can use multi-function PCIe Root Ports, this will give you 8 ports
per slot, if you have 16 empty slots (I think we have more) you reach
128 root ports.
Then you can use multi-function  virtio-net-pci devices, this will
give you 8 functions per port, so you reach the target of 1024 devices.

You loose hot-plug granularity since you can hot-plug 8-functions group,
but maybe is OK, depending on your scenario.

> ( pxb-pcie doesn't support hotplug for instance, and only a single pcie domain is supported qemu )
> 

Even so, you can use one cold-plugged pxb-pcie if you don't
have enough empty slots on pcie.0, in order to reach the maximum
number of PCIe Root Ports (256) which is the maximum for a single
PCI domain.

If you need granularity per single device (1000+ hot-pluggable),
you could enhance the pxb-pcie to support multiple pci domains.

Thanks,
Marcel


> Thanks,
> 
> Ray K
> 
> Pcie.txt,
> ( https://github.com/qemu/qemu/blob/master/docs/pcie.txt )
> Q35 preso
> ( http://wiki.qemu.org/images/4/4e/Q35.pdf )
> 
>   
> 
> 
