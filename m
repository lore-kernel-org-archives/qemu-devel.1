Received: from eggs.gnu.org ([2001:4830:134:3::10]:48262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1e2zu3-0007Pk-SL
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1e2ztv-0000g3-Sh
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:21:27 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:50696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1e2ztv-0000eb-KX
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:21:19 -0400
Received: by mail-io0-x231.google.com with SMTP id 97so8950832iok.7
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 06:21:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
References: <4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 13 Oct 2017 14:21:16 +0100
Message-ID: <CAKv+Gu820vLCvNq2X_Fha2AW59HsNfTLk--J+wTt+fFdMu7FMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] dynamic DRAM base for ArmVirtQemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, edk2-devel-01 <edk2-devel@lists.01.org>, Drew Jones <drjones@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Andrea Bolognani <abologna@redhat.com>, libvirt devel <libvir-list@redhat.com>

On 13 October 2017 at 13:51, Laszlo Ersek <lersek@redhat.com> wrote:
> Hi Ard, Leif,
>
> the current physical memory map of the "virt" machine type doesn't leave
> much room for ECAM / MMCONFIG, which limits the number of PCI Express
> root ports and downstream ports (each port takes a separate bus number,
> and each bus number eats up a chunk of the ECAM area). Also, each port
> can only accommodate a single PCI Express device. In practice this
> limits the number of (hot-pluggable) PCIe devices to approx. 16, which
> is deemed by some "not scaleable enough". (For devices that only need to
> be cold-plugged, they can be placed directly on the root complex, as
> integrated devices, possibly grouping them into multifunction devices
> even; so those don't need bus numbers.)
>
> In order to grow the MMCONFIG area (and for some other reasons
> possibly), the phys memmap of "virt" should be shuffled around a bit.
> This affects the "system" DRAM too.
>

Is it really necessary to put the ECAM area below 4 GB? For ARM, I
understand this would be an issue, but does the spec actually mandate
anything like this?


>
> One idea is to keep the current system DRAM base at 1GB, but limit its
> size to 1GB. And, if there's more DRAM, use another, disjoint address
> range for that, above 4GB. This would be easy to support for ArmVirtQemu
> (basically nothing new would be necessary), as the high area would be
> handled transparently by "ArmVirtPkg/HighMemDxe". However, this appears
> to present complications for QEMU. (I don't exactly know what
> complications -- I would be very happy to hear them, in detail.)
>
>
> Another idea is to move *the* system DRAM base to a different guest-phys
> address. (Likely using a different version of the "virt" machine type,
> or even a different machine type entirely.) This would not be compatible
> with current ArmVirtQemu, which hard-codes the system DRAM base in
> several, quite brittle / sensitive, locations. (More on this later --
> that's going to be the larger part of my email anyway.) In order to
> handle the new base in ArmVirtQemu, two approaches are possible: change
> the hard-coded address(es), or cope with the address dynamically.
>
> Changing the hard-coded addresses is easy for edk2 contributors (just
> add a new build flag like -D DRAM_BASE_AT_XXX_GB, and dependent on it,
> set a number of fixed-at-build PCDs to new values). For RHEL downstream,
> this is not an un-attractive option, as we are free to break
> compatibility at this time. For upstream users and other distros
> however, it likely wouldn't be convenient, because "old" ArmVirtQemu
> firmware wouldn't boot on the "new" machine type, and vice versa.
>
> (If we can agree that the above "boundary" in firmwares and machine
> types is widely tolerable, then we need not discuss the rest of this
> email.)
>
>
> Finally, coping with "any" system DRAM base address in ArmVirtQemu is
> both the most flexible for users, and the most difficult to implement.
> When QEMU launches the guest, the base of the system DRAM (which equals
> the location of the DTB too) is exposed in the x0 register. The
> challenge is to make everything in the earliest phases of ArmVirtQemu to
> adapt to this value dynamically, and to propagate the value to further
> parts of the firmware.
>
> I've been looking into this for a few days now and would like to pick
> your minds on what I've found.
>
> (
>
>   As a side note, I know (superficially) of Ard's ArmVirtXen and
>   ArmVirtQemuKernel work. If I understand correctly, Ard has turned some
>   of the PCDs I'm about to discuss into "patchable" ones, from
>   "fixed-at-build". The difference in storage is that these constants
>   are now placed in the final firmware image such that they are
>   externally patchable, just before "deployment".
>
>   Because the ArmVirtXen and ArmVirtQemuKernel firmware binaries are
>   loaded into DRAM immediately, this self-patching -- based on the
>   initial value of x0 -- is feasible, in the earliest part of the
>   firmware. (I'm not saying "easy" -- to the contrary; but it's
>   feasible.)
>
>   However, ArmVirtQemu is launched from pflash; its SEC and PEI phases
>   execute-in-place from pflash (until MemoryInitPeim installs the
>   permanent PEI RAM, and the PEI_CORE relocates the HOB list, itself,
>   and the PEIMs into DRAM). Therefore the SEC and PEI phases of
>   ArmVirtQemu cannot be patched like this, i.e., through patchable PCDs.
>   (Unless, of course, the patching is implemented in QEMU itself -- but
>   I don't think that's probable).
>
> )
>
> Now, exactly because SEC and PEI execute in place from pflash, their
> execution (= instruction fetches) are not affected by different initial
> x0 values. However, the following are affected:
>
> - the initial stack,
> - the base address of the initial DTB,
> - the location of the permanent PEI RAM.
>
> In ArmVirtQemu, these are represented by the following PCDs (all
> fixed-at-build currently):
>
> - PcdCPUCoresStackBase
> - PcdDeviceTreeInitialBaseAddress
> - PcdSystemMemoryBase
>
> I've attempted to audit each of these PCDs.
>
> (I should note in advance that I focused on their use *only* in the
> ArmVirtQemu firmware platform, and only on AARCH64. I ignored ARM32, and
> ArmVirtXen and ArmVirtQemuKernel. We obviously must not regress those
> other arches / platforms by messing with these PCDs, but this is only a
> "feasibility study" for now.)
>
>
>
> (1) PcdCPUCoresStackBase
>
> The PCD's current value is, from "ArmVirtPkg/ArmVirtQemu.dsc":
>
>> [PcdsFixedAtBuild.common]
>>   gArmPlatformTokenSpaceGuid.PcdCPUCoresStackBase|0x4007c000
>
> That is, 496KB above the start of the DRAM (which is at 1GB currently).
> This leaves enough room for the initial DTB (placed at the start of
> DRAM).
>
> The PCD is used widely by the SECURITY_CORE (=SEC) module of
> ArmVirtQemu, namely:
>
>   ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf
>
> The PCD is used by no other module.
>
>
> * The stack is set up in
>
>   ArmPlatformPkg/PrePeiCore/AArch64/PrePeiCoreEntryPoint.S
>
> under the label ASM_PFX(MainEntryPoint). This is where the initial value
> of x0 should be considered first, replacing the use of
> "PcdCPUCoresStackBase" with something like
>
>   x0 + 0x7c000
>
> (I don't grok aarch64 assembly, so any help with the implementation
> would be greatly appreciated (if this approach is feasible at all).)
>
>
> * Once we're done with the assembly magic, we enter the CEntryPoint()
> function, and the following tree of calls occurs:
>
>   CEntryPoint()         [ArmPlatformPkg/PrePeiCore/PrePeiCore.c]
>     PrimaryMain()       [ArmPlatformPkg/PrePeiCore/MainUniCore.c]
>       CreatePpiList()   [ArmPlatformPkg/PrePeiCore/PrePeiCore.c]
>     PeiCoreEntryPoint()
>
>
> * The CEntryPoint() function *currently* takes two parameters from the
> assembly entry logic,
>
>> VOID
>> CEntryPoint (
>>   IN  UINTN                     MpId,
>>   IN  EFI_PEI_CORE_ENTRY_POINT  PeiCoreEntryPoint
>>   )
>
> The PeiCoreEntryPoint parameter is the function pointer that is going to
> be invoked at the bottom of the call tree, displayed above. The assembly
> code in "PrePeiCoreEntryPoint.S" fetches the value from the flash image.
> (I'm spelling this out just to clarify the last line in the call tree.)
>
> - The parameter list of the CEntryPoint() function should be extended
>   with
>
>   IN UINT64  MemoryBase,
>   IN UINT64  StackBase
>
> - the assembly code should pass the initial value of x0 in "MemoryBase",
>
> - and the stack base (i.e., (x0 + 0x7c000)) in "StackBase".
>
>
> * Then, the PrimaryMain() function is invoked:
>
>> VOID
>> EFIAPI
>> PrimaryMain (
>>   IN  EFI_PEI_CORE_ENTRY_POINT  PeiCoreEntryPoint
>>   )
>
> This function does the following:
>
> (1a) it creates a PPI list *in DRAM*, at PcdCPUCoresStackBase, by
>      calling CreatePpiList(),
>
> (1b) right above the PPI list, it marks the DRAM area to be used as
>      temporary SEC/PEI stack/heap,
>
> (1c) it enters the PEI_CORE, by calling PeiCoreEntryPoint(), passing it
>      the above-calculated locations, *and* the PPI list also constructed
>      above.
>
> Now, PrimaryMain()'s parameter list should also be extended with
>
>   IN UINT64  MemoryBase,
>   IN UINT64  StackBase
>
> and the "StackBase" parameter should replace "PcdCPUCoresStackBase" in
> the (1a) and (1b) calculations.
>
> In addition, this is where we have the opportunity (and obligation) to
> propagate the "MemoryBase" value to *all* of the PEI phase.
>
> The way SEC propagates *custom* information to PEI is via the PPI list
> parameter of PeiCoreEntryPoint(). Unlike CEntryPoint() and
> PrimaryMain(), PeiCoreEntryPoint() has a standardized function
> prototype:
>
>   MdePkg/Include/Pi/PiPeiCis.h
>
>> typedef
>> VOID
>> (EFIAPI *EFI_PEI_CORE_ENTRY_POINT)(
>>   IN CONST  EFI_SEC_PEI_HAND_OFF    *SecCoreData,
>>   IN CONST  EFI_PEI_PPI_DESCRIPTOR  *PpiList
>> );
>
> (See also the comment block on the typedef! It's super informative.)
>
> The "SecCoreData" pointer passes the information that we calculated in
> (1b). And the "PpiList" pointer passes the PPI list from (1a).
>
>
> * Therefore, if we have to modify the CreatePpiList() function too:
>
>> VOID
>> CreatePpiList (
>>   OUT UINTN                   *PpiListSize,
>>   OUT EFI_PEI_PPI_DESCRIPTOR  **PpiList
>>   )
>
> This function currently concatenates two *constant* (in-flash) PPI
> lists. One comes from the variable
>
>   gCommonPpiTable [ArmPlatformPkg/PrePeiCore/PrePeiCore.c]
>
> and the other is returned by the function
>
>   ArmPlatformGetPlatformPpiList() [ArmVirtPkg/Library/ArmVirtPlatformLib/Virt.c]
>
> The concatenated list is placed into DRAM, at "PcdCPUCoresStackBase".
>
> The point here is that both *input* PPI lists are *constant*, they come
> from pflash, and don't have the "MemoryBase" information. Therefore,
>
> - the parameter list of CreatePpiList() should be extended with
>
>   IN UINT64  MemoryBase,
>   IN UINT64  StackBase
>
> - CreatePpiList() should store the concatenated list at "StackBase", not
>   "PcdCPUCoresStackBase",
>
> - and CreatePpiList() should append *two more* PPI descriptors (with
>   separate, custom GUIDs, to be defined by us), where the first's
>   "EFI_PEI_PPI_DESCRIPTOR.Ppi" (of type pointer-to-void) would point
>   *directly* at "MemoryBase", for advertizing the memory base; and the
>   second would point to the same, but advertize the initial DTB base
>   address. (We'd have two distinct PPIs for completeness.)
>
> Then interested PEIMs could locate these PPIs by GUID in the PEI phase,
> and learn about the "MemoryBase" / initial DTB base address values.
>
>
> * Now, clearly, this is quite a few changes to the
>
>   ArmPlatformPkg/PrePeiCore
>
> module, which is likely used as the SEC phase of a bunch of other ARM
> platforms. Should we copy "ArmPlatformPkg/PrePeiCore" under ArmVirtPkg
> for this kind of customization?
>
>
>
> (2) PcdDeviceTreeInitialBaseAddress
>
> (
>
>   Before discussing this PCD, I have to digress a bit. Namely, the
>   ArmPlatformLib class, defined in
>
>     ArmPlatformPkg/Include/Library/ArmPlatformLib.h
>
>   is unfortunately a very confusing lib class. It is a dumping ground
>   for random "platform" functions. The catch is that some of these
>   functions are meant to be invoked from SEC, exclusively, while some
>   other functions are meant to be invoked from PEI, exclusively.
>
>   The end result is that, if a given ArmPlatformLib instance implements
>   a *PEI-only* function with various PCD, PPI, and GUID dependencies,
>   then the exact same, *bogus*, dependencies will show up in the build
>   report file for the SECURITY_CORE module as well. Simply because the
>   SEC module links against the same library instance, for the sake of
>   the SEC-only functions. Never mind that the SEC module never *calls*
>   those PEI-only functions that incur said dependencies.
>
>   This makes dependency analysis, based on the build report file, very
>   cumbersome.
>
>   The ArmPlatformLib class should be split into SEC-only and PEI-only
>   lib classes.
>
> )
>
> "PcdDeviceTreeInitialBaseAddress" is currently set in
> "ArmVirtPkg/ArmVirtQemu.dsc" as follows:
>
>> [PcdsFixedAtBuild.common]
>>   # initial location of the device tree blob passed by QEMU -- base of DRAM
>>   gArmVirtTokenSpaceGuid.PcdDeviceTreeInitialBaseAddress|0x40000000
>
>
> "PcdDeviceTreeInitialBaseAddress" is used in three library instances:
>
> (2a) ArmVirtPkg/Library/ArmVirtPlatformLib/ArmVirtPlatformLib.inf
>      ArmVirtPkg/Library/ArmVirtPlatformLib/Virt.c
>
> (2b) ArmVirtPkg/Library/FdtPL011SerialPortLib/EarlyFdtPL011SerialPortLib.inf
>      ArmVirtPkg/Library/FdtPL011SerialPortLib/EarlyFdtPL011SerialPortLib.c
>
> (2c) ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.inf
>      ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c
>
>
> (2a) "ArmVirtPlatformLib.inf" is built into SEC, discussed above:
>
>   ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf
>
> and also into the following two PEIMs:
>
>   ArmPlatformPkg/PlatformPei/PlatformPeim.inf
>   ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.inf
>
> The function in ArmVirtPlatformLib that fetches
> "PcdDeviceTreeInitialBaseAddress", namely
> ArmPlatformInitializeSystemMemory(), is *only* called from the entry
> point function of MemoryInitPeim, InitializeMemory().
>
> (See my gripe above about the ArmPlatformLib class -- SEC's apparent
> dependency on this PCD is bogus!)
>
> I.e., we have the following call tree:
>
>   InitializeMemory()                             [ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.c]
>     ArmPlatformInitializeSystemMemory()          [ArmVirtPkg/Library/ArmVirtPlatformLib/Virt.c]
>       PcdGet64 (PcdDeviceTreeInitialBaseAddress)
>
> Consequently, given that the only reference to
> "PcdDeviceTreeInitialBaseAddress" is made from within PEI, we can
> replace the PcdGet64() call with a PeiServicesLocatePpi() call, and grab
> the initial device tree base address from our custom PPI.
>
>
> (2b) "EarlyFdtPL011SerialPortLib.inf" is a SerialPortLib instance that
> parses the UART base address from the initial DTB on every
> SerialPortWrite() call:
>
>   SerialPortWrite()                              [ArmVirtPkg/Library/FdtPL011SerialPortLib/EarlyFdtPL011SerialPortLib.c]
>     SerialPortGetBaseAddress()                   [ArmVirtPkg/Library/FdtPL011SerialPortLib/EarlyFdtPL011SerialPortLib.c]
>       PcdGet64 (PcdDeviceTreeInitialBaseAddress)
>     PL011UartWrite()                             [ArmPlatformPkg/Drivers/PL011Uart/PL011Uart.c]
>
> The library instance is linked into:
>
> - SEC: ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf
>
> - PEI_CORE: MdeModulePkg/Core/Pei/PeiMain.inf
>
> - and all 6 PEIMs included by ArmVirtQemu:
>
>   ArmPkg/Drivers/CpuPei/CpuPei.inf
>   ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.inf
>   ArmPlatformPkg/PlatformPei/PlatformPeim.inf
>   MdeModulePkg/Core/DxeIplPeim/DxeIpl.inf
>   MdeModulePkg/Universal/PCD/Pei/Pcd.inf
>   MdeModulePkg/Universal/Variable/Pei/VariablePei.inf
>
> It is not used by other modules.
>
> If we replaced the "PcdDeviceTreeInitialBaseAddress" access in
> SerialPortGetBaseAddress() with a PeiServicesLocatePpi() call, then the
> PEI_CORE and PEIM modules would remain functional. (See again the
> comment block on EFI_PEI_CORE_ENTRY_POINT in
> "MdePkg/Include/Pi/PiPeiCis.h" -- the PEI_CORE itself is allowed to use
> the PPIs originally exported by SEC.)
>
> However, SEC couldn't use a library instance like this -- there's no way
> to search for a PPI in SEC. In other words, the SerialPortLib class is
> unsuitable for such use in SEC. I don't know how to solve this, other
> than by hard-coding the UART base address with a fixed-at-build PCD, in
> a custom SerialPortLib instance. :/
>
>
> (2c) The "PlatformPeiLib.inf" instance used with ArmVirtQemu copies the
> initial DTB into its final (page-allocated) place, in the PlatformPeim()
> function:
>
>   InitializePlatformPeim()                       [ArmPlatformPkg/PlatformPei/PlatformPeim.c]
>     PlatformPeim()                               [ArmVirtPkg/Library/PlatformPeiLib/PlatformPeiLib.c]
>       PcdGet64 (PcdDeviceTreeInitialBaseAddress)
>
> We can again replace the PcdGet64() with a PeiServicesLocatePpi() call.
> (No other module uses this PlatformPeiLib instance.)
>
>
>
> (3) PcdSystemMemoryBase
>
> Comes currently from "ArmVirtPkg/ArmVirtQemu.dsc":
>
>> [PcdsFixedAtBuild.common]
>>   # System Memory Base -- fixed at 0x4000_0000
>>   gArmTokenSpaceGuid.PcdSystemMemoryBase|0x40000000
>
>
> Based on the build report file, the following modules depend on this
> PCD, directly, or via library instances:
>
> - SEC:  ArmPlatformPkg/PrePeiCore/PrePeiCoreUniCore.inf
> - PEIM: ArmPlatformPkg/PlatformPei/PlatformPeim.inf
> - PEIM: ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.inf
>
> The last two (i.e., the PEIMs) can use PeiServicesLocatePpi() in place
> of "PcdSystemMemoryBase".
>
>
> The first module (SEC) seems to inherit the dependency on
> "PcdSystemMemoryBase" via ArmVirtPlatformLib. In ArmVirtPlatformLib, we
> consume the PCD in two spots:
>
> (3a) in the ArmPlatformInitializeSystemMemory() function. Referring back
> to my notes in (2a), this function is never called from SEC, so we can
> use PeiServicesLocatePpi(), for grabbing the DRAM base.
>
> (3b) The ArmPlatformGetVirtualMemoryMap() function is the other
> consumer. This function appears to be called on the following path, as
> part of
>
>   ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.inf
>
> *only*:
>
>   InitializeMemory()                     [ArmPlatformPkg/MemoryInitPei/MemoryInitPeim.c]
>     MemoryPeim()                         [ArmVirtPkg/Library/ArmVirtMemoryInitPeiLib/ArmVirtMemoryInitPeiLib.c]
>       InitMmu()                          [ArmVirtPkg/Library/ArmVirtMemoryInitPeiLib/ArmVirtMemoryInitPeiLib.c]
>         ArmPlatformGetVirtualMemoryMap() [ArmVirtPkg/Library/ArmVirtPlatformLib/VirtMem.c]
>           PcdGet64 (PcdSystemMemoryBase)
>
> Because this PCD consumption site is again never reached in SEC, we can
> replace it with PeiServicesLocatePpi().
>
>
>
> Summary:
>
> - The end goal is to clear out all appearances of PcdCPUCoresStackBase,
>   PcdDeviceTreeInitialBaseAddress, and PcdSystemMemoryBase from the
>   ArmVirtQemu build report file. The first PCD should be replaced by a
>   plain calculation in SEC, from x0, and the other two should be
>   replaced by custom PPIs that SEC produces (passing them to the
>   PEI_CORE).
>
> - I'd need help with the assembly code in SEC
>   ("ArmPlatformPkg/PrePeiCore/AArch64/PrePeiCoreEntryPoint.S").
>
> - The changes are intrusive enough -- for ArmPlatformPkg, and for the
>   ArmVirtXen and ArmVirtQemuKernel platforms under ArmVirtPkg -- to
>   justify deep-copying a number of modules, specifically for
>   ArmVirtQemu.
>
> - In ArmVirtQemu, SEC would lose serial output, unless we hard-coded the
>   PL011 UART base address. Neither the DebugLib nor the SerialPortLib
>   APIs can take auxiliary data as function parameters, and in SEC, we
>   have *none* of: writeable global variables, HOBs, *searchable* PPIs,
>   dynamic PCDs. The only way to pass information is via the stack, and
>   the DebugLib and SerialPortLib APIs are unsuited for that.
>
> Thoughts?
>
> Thanks
> Laszlo
