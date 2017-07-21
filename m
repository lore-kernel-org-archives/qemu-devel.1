Received: from eggs.gnu.org ([2001:4830:134:3::10]:60821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYTMx-0005RB-2c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dYTMu-0001a2-0I
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dYTMt-0001ZP-Ou
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:33:03 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
Date: Fri, 21 Jul 2017 11:33:02 +0300
MIME-Version: 1.0
In-Reply-To: <bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
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

On 20/07/2017 3:44, Kinsella, Ray wrote:
> Hi Marcel,
> 

Hi Ray,

>> You can use multi-function PCIe Root Ports, this will give you 8 ports
>> per slot, if you have 16 empty slots (I think we have more) you reach
>> 128 root ports.
>> Then you can use multi-function  virtio-net-pci devices, this will
>> give you 8 functions per port, so you reach the target of 1024 devices.
>>
>> You loose hot-plug granularity since you can hot-plug 8-functions group,
>> but maybe is OK, depending on your scenario.
> 
> Thanks for the advice losing the hotplug granularity is something I 
> think I can live with. It would mean, I would have to track how many 
> ports are allocated to a VM, and create 8 new ports when 1 is required, 
> caching the other 7 for when they are needed.
> 
>> Even so, you can use one cold-plugged pxb-pcie if you don't
>> have enough empty slots on pcie.0, in order to reach the maximum
>> number of PCIe Root Ports (256) which is the maximum for a single
>> PCI domain.
> 
> Took your advice see the attached cfg, it works exactly as you 
> indicated. If you are interested, you can use it from your VM adding 
> -readconfig to your qemu cmd line. I can currently only manage to start 
> a VM with around 50 coldplugged virtio devices before something breaks. 


That's strange. Please ensure the virtio devices are working in
virtio 1.0 mode (disable-modern=0,disable-legacy=1).
Let us know any problems you see.

> Not sure what yet, I will try scaling it with hotplugging tomorrow.
> 

Updates?

>>
>> If you need granularity per single device (1000+ hot-pluggable),
>> you could enhance the pxb-pcie to support multiple pci domains.
> 
> Do think there would be much work in this?
> 

Not really. All you have to do is to add a property to the pxb-pci/pxb
devices: pci_domain=x; then update the ACPI table to include the pxb
domain. You also have to tweak a little the pxb-pcie/pxb devices
to not share the bus numbers if pci_domain > 0.

Thanks,
Marcel

> Thanks,
> 
> Ray K
