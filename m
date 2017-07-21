Received: from eggs.gnu.org ([2001:4830:134:3::10]:35573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ray.kinsella@intel.com>) id 1dYhnE-0006QR-IL
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ray.kinsella@intel.com>) id 1dYhnB-0006Kt-Hs
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:57:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:59077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ray.kinsella@intel.com>)
	id 1dYhnB-0006HM-7H
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 19:57:09 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
	<14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
From: "Kinsella, Ray" <ray.kinsella@intel.com>
Message-ID: <d06866b6-e089-0427-2d57-40c4648734da@intel.com>
Date: Fri, 21 Jul 2017 16:57:06 -0700
MIME-Version: 1.0
In-Reply-To: <14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Marcel Apfelbaum <marcel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Hi Marcel

On 21/07/2017 01:33, Marcel Apfelbaum wrote:
> On 20/07/2017 3:44, Kinsella, Ray wrote:
> That's strange. Please ensure the virtio devices are working in
> virtio 1.0 mode (disable-modern=0,disable-legacy=1).
> Let us know any problems you see.
>
>> Not sure what yet, I will try scaling it with hotplugging tomorrow.
>>
>
> Updates?

I have managed to scale it to 128 devices.
The kernel does complain about IO address space exhaustion.

[   83.697956] pci 0000:80:00.0: BAR 13: no space for [io  size 0x1000]
[   83.700958] pci 0000:80:00.0: BAR 13: failed to assign [io  size 0x1000]
[   83.701689] pci 0000:80:00.1: BAR 13: no space for [io  size 0x1000]
[   83.702378] pci 0000:80:00.1: BAR 13: failed to assign [io  size 0x1000]
[   83.703093] pci 0000:80:00.2: BAR 13: no space for [io  size 0x1000]

I was surprised that I am running out of IO address space, as I am 
disabling legacy virtio. I assumed that this would remove the need for 
SeaBIOS to allocate the PCI Express Root Port IO address space. In any 
case - it doesn't stop the virtio-net device coming up and working as 
expected.

[  668.692081] virtio_net virtio103 enp141s0f4: renamed from eth101
[  668.707114] virtio_net virtio130 enp144s0f7: renamed from eth128
[  668.719795] virtio_net virtio129 enp144s0f6: renamed from eth127

I encountered some issues in vhost, due to open file exhaustion but 
resolved these with 'ulimit' in the usual way - burned alot of time on 
that today.

When scaling up to 512 Virtio-net devices SeaBIOS appears to really slow 
down when configuring PCI Config space - haven't manage to get this to 
work yet.

> Not really. All you have to do is to add a property to the pxb-pci/pxb
> devices: pci_domain=x; then update the ACPI table to include the pxb
> domain. You also have to tweak a little the pxb-pcie/pxb devices
> to not share the bus numbers if pci_domain > 0.

Thanks for information, will add to the list.

Ray K
\
