Received: from eggs.gnu.org ([2001:4830:134:3::10]:44396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZXZb-00021b-8t
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZXZY-0003aI-4O
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:14:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZXZX-0003Yd-Qe
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:14:32 -0400
References: <767EFADFF809234DB6CAABD6D2F93847C5D31539@IRSMSX107.ger.corp.intel.com>
	<3319b641-b7f3-0ee8-e5ed-9c378e723eb4@redhat.com>
	<bc619876-bca3-15c8-0ef0-0fc5f833bab3@intel.com>
	<14b1b111-d2d6-6954-2d12-8e0ac791ae44@redhat.com>
	<d06866b6-e089-0427-2d57-40c4648734da@intel.com>
	<97068eca-2788-8396-0f8d-1990c651bdfc@redhat.com>
	<20170723200440.GA3718@morn.lan>
	<767EFADFF809234DB6CAABD6D2F93847C5D3A5BC@IRSMSX107.ger.corp.intel.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8377f92c-9b65-0da4-2a5c-86c1e5d49448@redhat.com>
Date: Mon, 24 Jul 2017 10:14:23 +0300
MIME-Version: 1.0
In-Reply-To: <767EFADFF809234DB6CAABD6D2F93847C5D3A5BC@IRSMSX107.ger.corp.intel.com>
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
To: "Kinsella, Ray" <ray.kinsella@intel.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "seabios@seabios.org" <seabios@seabios.org>, Gerd Hoffmann <kraxel@redhat.com>, Michael Tsirkin <mst@redhat.com>, "Tan, Jianfeng" <jianfeng.tan@intel.com>

On 24/07/2017 7:53, Kinsella, Ray wrote:
> 

Hi Ray,
Thank you for the details,

> So as it turns out at 512 devices, it is nothing to do SeaBIOS, it was the Kernel again.
> It is taking quite a while to startup, a little over two hours (7489 seconds).
> The main culprits appear to be enumerating/initializing the PCI Express ports and enabling interrupts.
> 
> The PCI Express Root Ports are taking a long time to enumerate/ initializing.
> 42 minutes in total=2579/60=64 ports in total, 40 seconds each.
> 

Even if I am not aware of how much time would take to init a bare-metal
PCIe Root Port, it seems too much.

> [   50.612822] pci_bus 0000:80: root bus resource [bus 80-c1]
> [  172.345361] pci 0000:80:00.0: PCI bridge to [bus 81]
> ...
> [ 2724.734240] pci 0000:80:08.0: PCI bridge to [bus c1]
> [ 2751.154702] ACPI: Enabled 2 GPEs in block 00 to 3F
> 
> I assume the 1 hour (3827 seconds) below is being spent enabling interrupts.
> 

Assuming you are referring to legacy interrupts, maybe is possible
to disable them and use only MSI/MSI-X for PCIe Root Ports
(based on user input, we can't disable INTx for all the ports)


> [ 2899.394288] ACPI: PCI Interrupt Link [GSIG] enabled at IRQ 22
> [ 2899.531324] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
> [ 2899.534778] ACPI: PCI Interrupt Link [GSIE] enabled at IRQ 20
> [ 6726.914388] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [ 6726.937932] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [ 6726.964699] Linux agpgart interface v0.103
> 
> There finally there is another 20 minutes to find in the boot.
> 
> [ 7489.202589] virtio_net virtio515 enp193s0f0: renamed from eth513
> 
> Poky (Yocto Project Reference Distro) 2.3 qemux86-64 ttyS0
> 
> qemux86-64 login: root
> 
> I will remove the virtio-net-pci devices and hotplug them instead.
> In theory it should improve boot time, at expense of incurring some of these costs at runtime.
> 

I would appreciate if you can share the results.

Thanks,
Marcel

> Ray K
> 
> -----Original Message-----
> From: Kevin O'Connor [mailto:kevin@koconnor.net]
> Sent: Sunday, July 23, 2017 1:05 PM
> To: Marcel Apfelbaum <marcel@redhat.com>; Kinsella, Ray <ray.kinsella@intel.com>
> Cc: qemu-devel@nongnu.org; seabios@seabios.org; Gerd Hoffmann <kraxel@redhat.com>; Michael Tsirkin <mst@redhat.com>
> Subject: Re: >256 Virtio-net-pci hotplug Devices
> 
> On Sun, Jul 23, 2017 at 07:28:01PM +0300, Marcel Apfelbaum wrote:
>> On 22/07/2017 2:57, Kinsella, Ray wrote:
>>> When scaling up to 512 Virtio-net devices SeaBIOS appears to really
>>> slow down when configuring PCI Config space - haven't manage to get
>>> this to work yet.
> 
> If there is a slowdown in SeaBIOS, it would help to produce a log with timing information - see:
> https://www.seabios.org/Debugging#Timing_debug_messages
> 
> It may also help to increase the debug level in SeaBIOS to get more fine grained timing reports.
> 
> -Kevin
> 
