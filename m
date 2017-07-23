Received: from eggs.gnu.org ([2001:4830:134:3::10]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJjp-0003YD-7d
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJjl-0000WR-SO
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZJjl-0000WJ-JG
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:28:09 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
	<14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
	<d06866b6-e089-0427-2d57-40c4648734da@intel.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <97068eca-2788-8396-0f8d-1990c651bdfc@redhat.com>
Date: Sun, 23 Jul 2017 19:28:01 +0300
MIME-Version: 1.0
In-Reply-To: <d06866b6-e089-0427-2d57-40c4648734da@intel.com>
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
To: "Kinsella, Ray" <ray.kinsella@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Kevin O'Connor <kevin@koconnor.net>, Michael Tsirkin <mst@redhat.com>

On 22/07/2017 2:57, Kinsella, Ray wrote:
> 
> Hi Marcel
> 


Hi Ray,

> On 21/07/2017 01:33, Marcel Apfelbaum wrote:
>> On 20/07/2017 3:44, Kinsella, Ray wrote:
>> That's strange. Please ensure the virtio devices are working in
>> virtio 1.0 mode (disable-modern=0,disable-legacy=1).
>> Let us know any problems you see.
>>
>>> Not sure what yet, I will try scaling it with hotplugging tomorrow.
>>>
>>
>> Updates?
> 
> I have managed to scale it to 128 devices.
> The kernel does complain about IO address space exhaustion.
> 
> [   83.697956] pci 0000:80:00.0: BAR 13: no space for [io  size 0x1000]
> [   83.700958] pci 0000:80:00.0: BAR 13: failed to assign [io  size 0x1000]
> [   83.701689] pci 0000:80:00.1: BAR 13: no space for [io  size 0x1000]
> [   83.702378] pci 0000:80:00.1: BAR 13: failed to assign [io  size 0x1000]
> [   83.703093] pci 0000:80:00.2: BAR 13: no space for [io  size 0x1000]
> 
> I was surprised that I am running out of IO address space, as I am 
> disabling legacy virtio. I assumed that this would remove the need for 
> SeaBIOS to allocate the PCI Express Root Port IO address space.

Indeed, SeeBIOS does not reserve IO ports in this case, but Linux kernel
still decides ""it knows better" and tries to allocate IO resources
anyway. It does not affect the "modern" virtio-net devices because
they don't need IO ports anyway.

One way to work around the error message is to have the PCIe Root Port
have the corresponding IO headers read-only since IO support is
optional. I tried this some time ago, I'll get back to it.

> In any 
> case - it doesn't stop the virtio-net device coming up and working as 
> expected.
> 

Right.

> [  668.692081] virtio_net virtio103 enp141s0f4: renamed from eth101
> [  668.707114] virtio_net virtio130 enp144s0f7: renamed from eth128
> [  668.719795] virtio_net virtio129 enp144s0f6: renamed from eth127
> 
> I encountered some issues in vhost, due to open file exhaustion but 
> resolved these with 'ulimit' in the usual way - burned alot of time on 
> that today.
> 
> When scaling up to 512 Virtio-net devices SeaBIOS appears to really slow 
> down when configuring PCI Config space - haven't manage to get this to 
> work yet.
> 

Adding SeaBIOS mailing list and maintainers, maybe there is a known
issue about 500+ PCI devices configuration.

>> Not really. All you have to do is to add a property to the pxb-pci/pxb
>> devices: pci_domain=x; then update the ACPI table to include the pxb
>> domain. You also have to tweak a little the pxb-pcie/pxb devices
>> to not share the bus numbers if pci_domain > 0.
> 
> Thanks for information, will add to the list.
> 

Is also on my todo list :)

Thanks,
Marcel

> Ray K
> \
