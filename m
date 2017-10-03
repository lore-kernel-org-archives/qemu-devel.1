Received: from eggs.gnu.org ([2001:4830:134:3::10]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dzPfy-0007SH-1t
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dzPfs-0001tW-3V
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:04:06 -0400
Received: from mail-bl2nam02on0055.outbound.protection.outlook.com
	([104.47.38.55]:18704
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dzPfr-0001sh-RV
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:04:00 -0400
From: Brijesh Singh <brijesh.singh@amd.com>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<11d514ce-5752-d1a9-852c-9f091d2791e2@redhat.com>
	<210c74c8-5ced-94cd-2025-29f94c71fdf2@amd.com>
	<fc4e1267-0fd3-6412-b7af-5082b122c309@redhat.com>
	<8377576a-000e-8a8e-9817-41bd39122efb@redhat.com>
Message-ID: <a921eae2-232b-e651-d004-91295ab4bdee@amd.com>
Date: Tue, 3 Oct 2017 11:03:50 -0500
MIME-Version: 1.0
In-Reply-To: <8377576a-000e-8a8e-9817-41bd39122efb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: brijesh.singh@amd.com, Richard Relph <richard.relph@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, qemu-devel@nongnu.org

Hi Laszlo,


On 10/01/2017 04:56 AM, Laszlo Ersek wrote:
> On 10/01/17 11:17, Laszlo Ersek wrote:
> 
>> (3) Implement SEV encryption for pflash. A pflash chip can be in one of
>> two modes: (a) it reads and executes as ROM, or (b) it behaves like a
>> programmable (r/w) device with MMIO registers. Switching between both
>> modes is explicit (see
>> "OvmfPkg/QemuFlashFvbServicesRuntimeDxe/QemuFlash.c"); perhaps some SEV
>> controls could be hooked in there.
> 
> Hmmm wait a second, we *already* execute code from pflash (namely SEC
> code from OVMF_CODE.fd), and instruction fetch always entails decryption.
> 
> Furthermore, in SEC, we decompress PEI and DXE FVs from pflash
> (OVMF_CODE.fd) to RAM -- the decompression code runs in long mode, plus
> you modified the OVMF/X64 reset vector to set the C-bit in all PTEs,
> covering the low 4GB of guest RAM.
> 
> This tells me that at least read and execute from pflash work with SEV
> decryption already. Is this expected?
> 


Yes, this is expected. During the machine_init, qemu creates two pflash units.
The pflash unit#0 contains OVMF_CODE.fd and unit #1 points to OVMF_VARS.fd.
As part of machine creation, we encrypt the unit#0 using KVM_SEV_LAUNCH_UPDATE
command. The unit#0 is mapped at the x86 reset vector. On vm_start, guest
fetches the code from the unit#0. Since the code was already encrypted hence
guest was able to read and execute the initial bootstrap code just fine.

When OVMF is build with OvmfPkgX64.dsc, SetCr3ForPageTables64 builds the
initial page table. When SEV is active, we add the C-bit pte mask [1] -- it
will ensures that when decompression happen then data get written as
encrypted in the guest RAM.

[1] https://github.com/tianocore/edk2/commit/e60af8a1ebb15bfcbf2ecc4afb6cf35084c847aa


When OVMF is build with OvmfPkgIa32X64.dsc, the SEC phase runs in 32-bit mode
hence SEV hardware forces the C-bit to 1.  This will ensure that decompression
routines writes the data as encrypted.



> However, in PlatformPei, we don't report the varstore pflash range via
> any resource descriptor HOB (the varstore chip is at [0xffc00000,
> 0xFFC84000) in the 4MB build).  Consequently, AmdSevDxe clears the C-bit
> under the "NonExistent" branch:
> 
> AmdSevDxe:SetMemoryEncDec: Cr3Base=0x0 Physical=0xFEF00000
> Length=0x1100000 Mode=Decrypt CacheFlush=0
> 
> Subsequently, "OvmfPkg/QemuFlashFvbServicesRuntimeDxe/FwBlockService.c"
> adds the pflash range as EFI_MEMORY_UC | EFI_MEMORY_RUNTIME. The C-bit
> remains clear, AIUI.
> 
> OK, I'm totally confused now. Looks like SEV decryption already works
> for pflash (from SEC's example), and transparently at that (???), but we
> fail to use it in QemuFlashFvbServicesRuntimeDxe?
> 


AmdSevDxe clears the C-bit of pflash range in PlatformPei because
QemuFlashFvbServicesRuntimeDxe switches the pflash out from ROMD mode; i.e
it become MMIO. The MMIO regions must be mapped as unencrypted.

SEV hardware engine uses a random encryption key on each run. Since
OVMF_VAR.fd is used for storing the UEFI persistent variable hence we
will not be able to store the data encrypted using the SEV engine. Any
persistent storage should be protected using a disk encryption technologies
(like luks, dm-crypt etc).

Regarding optionROM comments, I will propose something on edk-devel
list. I am thinking at least we should start by adding some kind of bug_on or
warning when a SEV guest BIOS is attempting to copy the option ROM.
I am hoping that once we have secure boot working then we should be able to
handle the signed option ROM, grub.efi or kernel.efi etc.


-Brijesh
