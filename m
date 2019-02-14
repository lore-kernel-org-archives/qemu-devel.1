Received: from eggs.gnu.org ([209.51.188.92]:54440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGyp-0006yn-8J
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGoE-0004Ox-D1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:12:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1guGoE-0004MW-6R
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:12:10 -0500
Received: by mail-wm1-x341.google.com with SMTP id x7so6205707wmj.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:12:09 -0800 (PST)
References: <49127da6-814d-4675-21a5-48a8aa764e34@linux.intel.com>
	<20190205164716.79b9cd08@Igors-MacBook-Pro.local>
	<c6e1d704-e0da-215e-40c7-6db3daa66da1@linux.intel.com>
	<20190214123140.53d3cdf6@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <6cd527d2-b8d8-0eb9-78eb-a59c3ee4ccc7@gmail.com>
Date: Thu, 14 Feb 2019 15:12:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190214123140.53d3cdf6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Issues] PCI hotplug does not work well on pc
 platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc: yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>

Hi Igor, Jing

On 2/14/19 1:31 PM, Igor Mammedov wrote:
> On Wed, 13 Feb 2019 15:40:57 +0800
> "Liu, Jing2" <jing2.liu@linux.intel.com> wrote:
>
>> Hi Igor,
>>
>> Thanks for your reply!
>>
>> On 2/5/2019 11:47 PM, Igor Mammedov wrote:
>>> On Wed, 30 Jan 2019 21:02:10 +0800
>>> "Liu, Jing2" <jing2.liu@linux.intel.com> wrote:
>>>    
>>>> Hi everyone,
>>>>
>>>> I have two questions.
>>>> 1. PCI hotplug on pci.0 must manually rescan in guest. The ACPI hotplug
>>>> handler sends the GPE event to guest but it seems guest doesn't receive
>>>> it? I tried to open ACPI debug level/layer to 0xffffffff, in order to
>>>> see if there is any message after device_add in monitor, but no message
>>>> comes out until I manually rescan. Also tried printk in
>>>> acpi_ev_gpe_xrupt_handler() and acpi_ev_sci_xrupt_handler(). No output
>>>> in dmesg.
>>>> (I'm sure that CONFIG_HOTPLUG_PCI_PCIE=y, CONFIG_HOTPLUG_PCI_CPCI=y,
>>>> CONFIG_HOTPLUG_PCI=y, CONFIG_HOTPLUG_PCI_ACPI=y)

What about |CONFIG_HOTPLUG_PCI_SHPC=y ?

|
>>>> Whether this is a kind of design or a known issue? Does guest receive
>>>> the request, where can I find the
>>> does it work with known to work kernels (RHEL7)?
>>>
>>> Also sharing used QEMU version and command line could help.
>>>    
>> Is there any key config of kernel in guest, besides those I listed above?
> Maybe Marcel knows something about it
> (CCed)

May I ask why do you need SHPC hotplug and not the ACPI based hotplug?

Anyway, please look at dmesg (in guest) to see which hoplug handler is 
registered for
the pci bridge slots. You should have 2 options: acpiphp and shpchp.

If you see something like this:
[    0.014285] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.014314] PCI: Using configuration type 1 for base access
[    0.016011] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.016041] cryptd: max_cpu_qlen set to 1000
[    0.016078] ACPI: Added _OSI(Module Device)
[    0.016079] ACPI: Added _OSI(Processor Device)
[    0.016080] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.016081] ACPI: Added _OSI(Processor Aggregator Device)
[    0.016082] ACPI: Added _OSI(Linux-Dell-Video)
[    0.016578] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.018248] ACPI: Interpreter enabled
[    0.018260] ACPI: (supports S0 S5)
[    0.018261] ACPI: Using IOAPIC for interrupt routing
[    0.018276] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.018375] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.020616] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.020620] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments 
MSI]
[    0.020624] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.020630] acpi PNP0A03:00: fail to add MMCONFIG information, can't 
access extended PCI configuration space under this bridge.
[    0.020884] acpiphp: Slot [3] registered
[    0.020915] acpiphp: Slot [4] registered
[    0.020955] acpiphp: Slot [6] registered
[    0.020985] acpiphp: Slot [7] registered
[...]


it means the ACPI subsystem takes charge of PCI hotplug and shpc based 
hotplug will not work.


Bottom line, you just have to ensure the shpchp takes responsibility for 
the pci bridge hotplug.

Thanks,
Marcel

>> I used guest kernel v4.18 and qemu upstream v3.1.0
>> Command line:
>> sudo /home/xxx/qemu/x86_64-softmmu/qemu-system-x86_64  \
>> -machine pc,accel=kvm,kernel_irqchip -cpu host -m 1G,slots=2,maxmem=10G \
>> -nographic -no-user-config -nodefaults -vga none \
>> -drive file=/home/xxx/image/clear-24690-kvm.img,if=virtio,format=raw \
>>    -smp sockets=1,cpus=4,cores=2,maxcpus=8 \
>> -device virtio-serial-pci,id=virtio-serial0,disable-modern,addr=0x5 \
>> -monitor tcp:0.0.0.0:5000,nowait,server \
>> -chardev stdio,id=charconsole0 -device
>> virtconsole,chardev=charconsole0,id=console0  \
>> -kernel /home/xxx/linux-stable/arch/x86/boot/bzImage \
>> -append 'root=/dev/vda3 rw rootfstype=ext4 data=ordered
>> rcupdate.rcu_expedited=1 pci=lastbus=0 pci=realloc=on tsc=reliable
>> no_timer_check reboot=t noapictimer console=hvc0 iommu=off  panic=1
>> initcall_debug acpi.debug_layer=0x40000 acpi.debug_level=4 ' \
>> -device pci-bridge,bus=pci.0,id=br1,chassis_nr=1,shpc=on,addr=6  \
>>
>>>> 2. I want to try hotplugging on pci-bridge on pc platform, using shpc. I
>>>> set shpc=on, but when I do device_add, qemu still calls
>>>> acpi_pcihp_device_plug_cb? Why it does not call pci_bridge_dev_hotplug_cb?
>>>> (CONFIG_HOTPLUG_PCI_SHPC=y)
>>> try to disable ACPI hotplug for bridges
>>>    -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off
>>>    
>> I'll try it!
>>
>> Thanks!
>> Jing
>>>    
