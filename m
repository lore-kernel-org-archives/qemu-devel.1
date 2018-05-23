Received: from eggs.gnu.org ([2001:4830:134:3::10]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLaYu-0006aX-MZ
	for qemu-devel@nongnu.org; Wed, 23 May 2018 16:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLaYt-0002XL-AE
	for qemu-devel@nongnu.org; Wed, 23 May 2018 16:40:44 -0400
References: <1527091418-11874-1-git-send-email-eric.auger@redhat.com>
	<ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bf99311a-823d-34e8-1892-be27534afc32@redhat.com>
Date: Wed, 23 May 2018 22:40:30 +0200
MIME-Version: 1.0
In-Reply-To: <ec6bc0b3-5f0b-bf0c-7d9b-0382e114ee9e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] ARM virt: Support up to 256 PCIe buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: wei@redhat.com, drjones@redhat.com, ard.biesheuvel@linaro.org, zhaoshenglong@huawei.com

Hi Laszlo,

On 05/23/2018 07:45 PM, Laszlo Ersek wrote:
> Hi Eric,
> 
> On 05/23/18 18:03, Eric Auger wrote:
>> Current Machvirt PCI host controller's ECAM region is 16MB large.
>> This limits the number of PCIe buses to 16.
>>
>> PC/Q35 machines have a 256MB region allowing up to 256 buses.
>> This series tries to bridge the gap.
>>
>> It declares a new ECAM region located beyond 256GB, of size 256MB
>> (just after the hypothetical new GICv3 RDIST region). The new
>> ECAM region is used as soon as the highmem option is set (default)
>> and disabled for machines older than 3.0.
>>
>> Best Regards
>>
>> Eric
>>
>> Git: complete series available at
>> https://github.com/eauger/qemu/tree/v2.12.0-256MB-ECAM-RFCv1
>>
>> - Tested with guest running in aarch64 and aarch32 modes (aarch64=off)
>> - In aarch32 mode I encountered the issue the vmalloc region may be
>>   reported too small for the needs (dmesg excerpt below). So I had to
>>   extend the vmalloc size by passing the "vmalloc=512M" option to the
>>   bootargs and this eventually booted fine.
>>
>> [    1.399581] pl061_gpio 9030000.pl061: PL061 GPIO chip @0x0000000009030000 registered
>> [    1.402636] OF: PCI: host bridge /pcie@10000000 ranges:
>> [    1.404506] OF: PCI:    IO 0x3eff0000..0x3effffff -> 0x00000000
>> [    1.406606] OF: PCI:   MEM 0x10000000..0x3efeffff -> 0x10000000
>> [    1.408690] OF: PCI:   MEM 0x8000000000..0xffffffffff -> 0x8000000000
>> [    1.411992] vmap allocation for size 1052672 failed: use vmalloc=<size> to increase size
>> [    1.414895] pci-host-generic 4010000000.pcie: ECAM ioremap failed
>> [    1.427472] pci-host-generic: probe of 4010000000.pcie failed with error -12
>>
>> - Maybe this issue deserves introducing a new highmem_ecam option?
> 
> I refer to my earlier email here:
> 
>   http://mid.mail-archive.com/13d95529-d61e-fc30-ffd4-f1ef93edad40@redhat.com
> 
> This series flips the sole ECAM range that is exposed to the guest to a
> large one that is located above 4GB. That's a problem because -- to my
> understanding -- it breaks 32-bit ARM UEFI builds, unless you change the
> QEMU command line.

Thank you for your quick feedback. Effectively I ran the aarch32 guest
in DT boot. My bad.
> 
> (1) Please enable the "firmware repo" from Gerd's site:
> 
> https://www.kraxel.org/repos/
> 
> (2) Please install the "edk2.git-arm" package.
> 
> (3) Please run the 32-bit ARM UEFI firmware, with qemu-system-aarch64,
> in a separate directory, as follows (note: TCG only, KVM not needed):
> 
>   cp /usr/share/edk2.git/arm/vars-template-pflash.raw vars
>   FWBIN=/usr/share/edk2.git/arm/QEMU_EFI-pflash.raw
> 
>   qemu-system-aarch64 \
>     -nodefaults \
>     -no-user-config \
>     \
>     -M virt \
>     -cpu cortex-a15 \
>     -m 1024 \
>     \
>     -drive if=pflash,format=raw,file=$FWBIN,readonly \
>     -drive if=pflash,format=raw,file=vars \
>     \
>     -device virtio-gpu-pci \
>     -device qemu-xhci \
>     -device usb-kbd \
>     \
>     -chardev stdio,signal=off,mux=on,id=char0 \
>     -mon chardev=char0,mode=readline \
>     -serial chardev:char0
> 
> This will boot the UEFI shell for you in a graphical window and take
> input from the keyboard in that window. A virtio-gpu-pci device is used
> as GPU (a PCI Express virtio device) and a USB3.0 keyboard is used as
> human input device (the USB3.0 controller is also PCI Express).
> 
> 
> I didn't test it, but I expect that this series, when applied as-is,
> will break the above use case, unless highmem is explicitly disabled.

Yes as you expected, it leads to an exception whereas it works properly
without the series. Actually I misunderstood your last email and was
thinking/hoping that with aarch32 LPAE, things should work.


PCI Bus First Scanning

Data Abort Exception PC at 0x7F7E1A06  CPSR 0x40000033 nZcveaifT_svc
/home/jenkins/workspace/edk2/build/edk2-g7cd8a57599/Build/ArmVirtQemu-ARM/DEBUG_GCC5/ARM/MdeModulePkg/Bus/Pci/PciHostBridgeDxe/PciHostBridgeDxe/DEBUG/PciHostBridgeDxe.dll
loaded at 0x7F7E0000 (PE/COFF offset) 0x1A06 (ELF or Mach-O offset) 0xA06
0x6820       LDR    r0, [r4 #0x0]
  R0 0x00000001   R1 0xFFFFFFFF   R2 0x00000000   R3 0x00000000
  R4 0x10000000   R5 0x7FAC6C28   R6 0x00000001   R7 0x00000004
  R8 0x7FAC6C28   R9 0x00000000  R10 0x00000000  R11 0x00000000
 R12 0x00000000   SP 0x7FAC6B68   LR 0x7F7E19F5   PC 0x7F7E1A06
DFSR 0x00000008 DFAR 0x10000000 IFSR 0x00000000 IFAR 0x00000000
 Precise External Abort: read from 0x10000000

ASSERT [ArmCpuDxe]
/home/jenkins/workspace/edk2/build/edk2-g7cd8a57599/ArmPkg/Library/DefaultExceptionHandlerLib/Arm/DefaultExceptionHandler.c(268):
((BOOLEAN)(0==1))

> 
> I think the first patch is OK (modulo the runaway empty line at the end
> of acpi_dsdt_add_pci()), while realizing my review cannot be complete.
> :)
> 
> Regarding the second patch, I do believe we need "more sophistication"
> there. For example, I guess it could be possible to distinguish "-cpu
> cortex-a15" from "-cpu cortex-a57" somehow, and stick with the low/small
> ECAM in the former case. (The 32-bit firmware already runs on cortex-a15
> only, and not on cortex-a57, according to my testing.)

So we should detect we are in ACPI boot  + aarch32 mode to force legacy
ECAM region, right?

Thanks

Eric
> 
> Thanks,
> Laszlo
> 
