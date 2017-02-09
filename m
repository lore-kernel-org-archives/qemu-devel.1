Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbnlk-0005JE-IW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cbnli-000785-0s
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:24:12 -0500
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <a5d47ced-527e-9fa5-9c31-5ffe7981b42c@suse.de>
Date: Thu, 9 Feb 2017 13:24:02 +0100
MIME-Version: 1.0
In-Reply-To: <c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-arm: Declare virtio-mmio as
 dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mst@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>



On 08/02/2017 17:17, Laszlo Ersek wrote:
> On 02/08/17 17:12, Alexander Graf wrote:
>> On 02/08/2017 04:29 PM, Laszlo Ersek wrote:
>>> CC'ing Ard and Shannon (I recall this property from earlier):
>>>
>>> On 02/08/17 14:31, Alexander Graf wrote:
>>>> QEMU emulated hardware is always dma coherent with its guest. We do
>>>> annotate that correctly on the PCI host controller, but left out
>>>> virtio-mmio.
>>> I recommend to reference the following commit here:
>>>
>>> commit 5d636e21c44ecf982a22a7bc4ca89186079ac283
>>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Date:   Mon Jul 4 13:06:36 2016 +0100
>>>
>>>      hw/arm/virt: mark the PCIe host controller as DMA coherent in the DT
>>>           Since QEMU performs cacheable accesses to guest memory when
>>> doing DMA
>>>      as part of the implementation of emulated PCI devices, guest drivers
>>>      should use cacheable accesses as well when running under KVM.
>>> Since this
>>>      essentially means that emulated PCI devices are DMA coherent, set
>>> the
>>>      'dma-coherent' DT property on the PCIe host controller DT node.
>>>           This brings the DT description into line with the ACPI
>>> description,
>>>      which already marks the PCI bridge as cache coherent (see commit
>>>      bc64b96c984abf).
>>>           Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>      Message-id:
>>> 1467134090-5099-1-git-send-email-ard.biesheuvel@linaro.org
>>>      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>
>>>> Recent kernels have started to interpret that flag rather than take
>>>> dma coherency as granted with virtio-mmio. While that is considered
>>>> a kernel bug, as it breaks previously working systems, it showed that
>>>> our dt description is incomplete.
>>>>
>>>> This patch adds the respective marker that allows guest OSs to evaluate
>>>> that our virtio-mmio devices are indeed cache coherent.
>>> As noted above, commit bc64b96c984a ("hw/arm/virt-acpi-build: _CCA
>>> attribute is compulsory", 2015-11-03) had done the same in the ACPI
>>> description of the PCIe host controller.
>>>
>>> Thus, do we need _CCA in the ACPI description of the virtio-mmio
>>> transports, to parallel the DT change? See the LNRO0005 device in
>>> acpi_dsdt_add_virtio().
>>
>> Yes, we should also annotate it correctly in the DSDT. Today it's not a
>> deal breaker as Linux always assumes virtio-mmio to be dma coherent, but
>> it would make our platform description more accurate.
>>
>>> If that's the case, then I propose that either the patch please fix
>>> both DT and ACPI, or that at least we file a bug "somewhere", for
>>> adding _CCA in acpi_dsdt_add_virtio().
>>
>> I agree that it should happen in the same patch (set). While I don't
>> care a lot about ACPI right now (since dt is preferred on upstream
>> kernels), I can take a look.
>
> Thank you!

Is ACPI boot supposed to work at all with 4.9?

Booting Linux on physical CPU 0x0
Linux version 4.9.6-00018-g13e39d5 (agraf@achrid) (gcc version 6.1.1 
20160711 (Linaro GCC 6.1-2016.08) ) #68 SMP PREEMPT Wed Feb 8 13:25:23 
CET 2017
Boot CPU: AArch64 Processor [500f0001]
efi: Getting EFI parameters from FDT:
efi: UEFI not found.
cma: Reserved 16 MiB at 0x00000000bf000000
ACPI: Early table checksum verification disabled
fACPI: Failed to init ACPI tables
On node 0 totalpages: 524288
   DMA zone: 8192 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 524288 pages, LIFO batch:31
psci: is not implemented in ACPI.
ACPI: APIC not present
fmissing boot CPU MPIDR, not enabling secondaries
percpu: Embedded 21 pages/cpu @ffff80007efdd000 s47896 r8192 d29928 u86016
pcpu-alloc: s47896 r8192 d29928 u86016 alloc=21*4096
pcpu-alloc: [0] 0
Detected PIPT I-cache on CPU0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 516096
Kernel command line: acpi=force console=ttyAMA0
PID hash table entries: 4096 (order: 3, 32768 bytes)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2030472K/2097152K available (8380K kernel code, 858K rwdata, 
3632K rodata, 1024K init, 280K bss, 50296K reserved, 16384K cma-reserved)
Virtual kernel memory layout:
     modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
       .text : 0xffff000008080000 - 0xffff0000088b0000   (  8384 KB)
     .rodata : 0xffff0000088b0000 - 0xffff000008c40000   (  3648 KB)
       .init : 0xffff000008c40000 - 0xffff000008d40000   (  1024 KB)
       .data : 0xffff000008d40000 - 0xffff000008e16a00   (   859 KB)
        .bss : 0xffff000008e16a00 - 0xffff000008e5cc3c   (   281 KB)
     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000   (  4108 KB)
     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000   (    16 MB)
     vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
               0xffff7e0000000000 - 0xffff7e0002000000   (    32 MB actual)
     memory  : 0xffff800000000000 - 0xffff800080000000   (  2048 MB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Preemptible hierarchical RCU implementation.
	Build-time adjustment of leaf fanout to 64.
	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=1
NR_IRQS:64 nr_irqs:64 0
ACPI: APIC not present
ACPI: APIC not present
ACPI: APIC not present
ACPI: APIC not present
ACPI: APIC not present
Kernel panic - not syncing: No interrupt controller found.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.6-00018-g13e39d5 #68
Hardware name: linux,dummy-virt (DT)
Call trace:
[<ffff000008088500>] dump_backtrace+0x0/0x1a0
[<ffff0000080886b4>] show_stack+0x14/0x20
[<ffff000008374e54>] dump_stack+0x94/0xb8
[<ffff0000081658fc>] panic+0x110/0x278
[<ffff000008c424a8>] init_IRQ+0x24/0x2c
[<ffff000008c409f0>] start_kernel+0x230/0x38c
[<ffff000008c401d8>] __primary_switched+0x5c/0x64
---[ end Kernel panic - not syncing: No interrupt controller found.
linux,dummy-virt (DT)


Alex
