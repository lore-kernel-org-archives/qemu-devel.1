Received: from eggs.gnu.org ([2001:4830:134:3::10]:49595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dT31L-0001My-Cc
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dT31I-0006W9-9g
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:24:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dT31H-0006Vn-WD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:24:20 -0400
References: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
	<503895c7-4649-a568-2ee4-0fea1908fd60@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <537c874c-a5d4-30ce-6bb2-1a2bc345f66a@redhat.com>
Date: Thu, 6 Jul 2017 12:24:12 +0300
MIME-Version: 1.0
In-Reply-To: <503895c7-4649-a568-2ee4-0fea1908fd60@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The maximum limit of virtual network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Wu, Jiaxin" <jiaxin.wu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexander Bezzubikov <zuban32s@gmail.com>

On 06/07/2017 11:31, Laszlo Ersek wrote:
> Hi Jiaxin,
> 
> it's nice to see a question from you on qemu-devel! :)
> 
> On 07/06/17 08:20, Wu, Jiaxin wrote:
>> Hello experts,
>>
>> We know QEMU has the capability to create the multiple network devices
>> in one QEMU guest with the -device syntax. But I met the below failure
>> when I'm trying to create more than 30 virtual devices with the each
>> TAP backend:
>>
>> qemu-system-x86_64: -device e1000: PCI: no slot/function available for
>> e1000, all in use.
>>
>> The corresponding QEMU command shows as following:
>>
>> sudo qemu-system-x86_64 \
>>    -pflash OVMF.fd \
>>    -global e1000.romfile="" \
>>    -netdev tap,id=hostnet0,ifname=tap0,script=no,downscript=no \
>>    -device e1000,netdev=hostnet0 \

[...]

>>    -netdev tap,id=hostnet29,ifname=tap29,script=no,downscript=no \
>>    -device e1000,netdev=hostnet29
>>
>>  From above,  the max limit of virtual network device in one guest is
>> about 29? If not, how can I avoid such failure? My use case is to
>> create more than 150 network devices in one guest. Please provide your
>> comments on this.
> 
> You are seeing the above symptom because the above command line
> instructs QEMU to do the following:
> - use the i440fx machine type,
> - use a single PCI bus (= the main root bridge),
> - add the e1000 cards to separate slots (always using function 0) on
>    that bus.
> 
> Accordingly, there are three things you can do to remedy this:
> 
> - Use the Q35 machine type and work with a PCI Express hierarchy rather
>    than a PCI hierarchy. I'm mentioning this only for completeness,
>    because it won't directly help your use case. But, I certainly want to
>    highlight "docs/pcie.txt". Please read it sometime; it has nice
>    examples and makes good points.
> 
> - Use multiple PCI bridges to attach the devices. For this, several ways
>    are possible:
> 
>    - use multiple root buses, with the pxb or pxb-pcie devices (see
>      "docs/pci_expander_bridge.txt" and "docs/pcie.txt")
> 
>    - use multiple normal PCI bridges
> 
>    - use multiple PCI Express root ports or downstream ports (but for
>      this, you'll likely have to use the PCI Express variant of the
>      e1000, namely e1000e)
> 
> - If you don't need hot-plug / hot-unplug, aggregate eights of e1000
>    NICs into multifunction PCI devices.
> > Now, I would normally recommend sticking with i440fx for simplicity.
> However, each PCI bridge requires 4KB of IO space (meaning (1 + 5) * 4KB
> = 24KB),  and OVMF on the i440fx does not support that much (only
> 0x4000). So, I'll recommend Q35 for IO space purposes; OVMF on Q35
> provides 0xA000 (40KB).

So if we use OVMF, going for Q35 gives us actually more IO space, nice!
However recommending Q35 for IO space seems odd :)

> 
> For scaling higher than this, a PCI Express hierarchy should be used
> with PCI Express devices that require no IO space at all. However, that
> setup is even more problematic *for now*; please see section "3. IO
> space issues" in "docs/pcie.txt". We have open OVMF and QEMU BZs for
> limiting IO space allocation to cases when it is really necessary:
> 
>    https://bugzilla.redhat.com/show_bug.cgi?id=1344299
>    https://bugzilla.redhat.com/show_bug.cgi?id=1434740
> 
> Therefore I guess the simplest example I can give now is:
> - use Q35 (for a larger IO space),
> - plug a DMI-PCI bridge into the root bridge,
> - plug 5 PCI bridges into the DMI-PCI bridge,
> - plug 31 NICs per PCI bridge, each NIC into a separate slot.
> 

The setup looks OK to me (assuming OVMF is needed, otherwise
PC + pci-bridges will result in more devices),
I do have a little concern.
We want to deprecate the dmi-pci bridge since it does not support 
hot-plug (for itself or devices behind it).
Alexandr (CCed) is a GSOC student working on a generic
pcie-pci bridge that can (eventually) be hot-plugged
into a PCIe Root Port and keeps the machine cleaner.

See:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05498.html

If is a "lab" project it doesn't really matter, but I wanted
to point out the direction.

Thanks,
Marcel

> This follows the following recommendation of "2.3 PCI only hierarchy" in
> "docs/pcie.txt" (slightly rewrapped here):
> 
>> 2.3 PCI only hierarchy
>> ======================
>> Legacy PCI devices can be plugged into pcie.0 as Integrated Endpoints,
>> but, as mentioned in section 5, doing so means the legacy PCI
>> device in question will be incapable of hot-unplugging.
>> Besides that use DMI-PCI Bridges (i82801b11-bridge) in combination
>> with PCI-PCI Bridges (pci-bridge) to start PCI hierarchies.
>>
>> Prefer flat hierarchies. For most scenarios a single DMI-PCI Bridge
>> (having 32 slots) and several PCI-PCI Bridges attached to it (each
>> supporting also 32 slots) will support hundreds of legacy devices. The
>> recommendation is to populate one PCI-PCI Bridge under the DMI-PCI
>> Bridge until is full and then plug a new PCI-PCI Bridge...
> 
> Here's a command line. Please note that the OVMF boot may take quite
> long with this, as the E3522X2.EFI driver from BootUtil (-D
> E1000_ENABLE) binds all 150 e1000 NICs in succession! Watching the OVMF
> debug log is recommended.
> 
> qemu-system-x86_64 \
>    \
>    -machine q35,vmport=off,accel=kvm \
>    -pflash OVMF.fd \
>    -global e1000.romfile="" \
>    -m 2048 \
>    -debugcon file:debug.log \
>    -global isa-debugcon.iobase=0x402 \
>    \
>    -netdev tap,id=hostnet0,ifname=tap0,script=no,downscript=no \
[...]
>    -netdev tap,id=hostnet149,ifname=tap149,script=no,downscript=no \
>    \
>    -device i82801b11-bridge,id=dmi-pci-bridge \
>    \
>    -device pci-bridge,id=bridge-1,chassis_nr=1,bus=dmi-pci-bridge \
>    -device pci-bridge,id=bridge-2,chassis_nr=2,bus=dmi-pci-bridge \
>    -device pci-bridge,id=bridge-3,chassis_nr=3,bus=dmi-pci-bridge \
>    -device pci-bridge,id=bridge-4,chassis_nr=4,bus=dmi-pci-bridge \
>    -device pci-bridge,id=bridge-5,chassis_nr=5,bus=dmi-pci-bridge \
>    \
>    -device e1000,netdev=hostnet0,bus=bridge-1,addr=0x1.0 \
[...]
>    -device e1000,netdev=hostnet149,bus=bridge-5,addr=0x1a.0
> 
> Thanks
> Laszlo
> 
