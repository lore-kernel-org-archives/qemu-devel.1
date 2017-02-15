Received: from eggs.gnu.org ([2001:4830:134:3::10]:46823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce5ti-0000Ck-M6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce5tf-00018g-CH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:09:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ce5te-000187-W9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:09:51 -0500
Date: Wed, 15 Feb 2017 22:09:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170215220837-mutt-send-email-mst@kernel.org>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, imammedo@redhat.com

On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:
> On 02/15/17 07:15, ben@skyportsystems.com wrote:
> > From: Ben Warren <ben@skyportsystems.com>
> >
> > This patch set adds support for passing a GUID to Windows guests.  It
> > is a re-implementation of previous patch sets written by Igor Mammedov
> > et al, but this time passing the GUID data as a fw_cfg blob.
> >
> > This patch set has dependencies on new guest functionality, in
> > particular the support for a new linker-loader command and the ability
> > to write back data to QEMU over a DMA link.  Work is in flight in both
> > SeaBIOS and OVMF to support this.
> >
> > v5->v6:
> >     - Rebased to top of tree.
> >     - Changed device from sysbus to a simple device.  This removed the need for
> >       adding dynamic sysbus support to pc_piix boards.
> >     - Removed patch that introduced QWORD patching of AML.
> >     - Removed ability to set GUID via QMP/HMP.
> >     - Improved comments/documentation in code.
> 
> So here's my testing with a RHEL-7 guest:
> 
> (1) The command line option passed to QEMU is
> 
>   -device vmgenid,guid=00112233-4455-6677-8899-AABBCCDDEEFF
> 
> This is the example GUID provided in the SMBIOS spec v3.0.0 (DSP0134),
> section 7.2.1 "System -- UUID". (SMBIOS is only relevant here because it
> codifies the fact that Microsoft consumes UUID in little-endian order.)
> The expected representation, according to the SMBIOS spec, is
> 
>   33 22 11 00 55 44 77 66 88 99 AA BB CC DD EE FF
> 
> (2) Here's an excerpt from the OVMF log:
> 
> > ProcessCmdAllocate: File="etc/vmgenid_guid" Alignment=0x1000 Zone=1 Size=0x1000 Address=0x7FE5C000
> 
> This is where "etc/vmgenid_guid" is allocated and downloaded, the
> allocation address is 0x7FE5C000.
> 
> > Select Item: 0x19
> > Select Item: 0x22
> > ProcessCmdAllocate: File="etc/acpi/tables" Alignment=0x40 Zone=1 Size=0x20000 Address=0x7E7AB000
> > ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x49 Start=0x40 Length=0x1403
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/acpi/tables" PointerOffset=0x1467 PointerSize=4
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/acpi/tables" PointerOffset=0x146B PointerSize=4
> > ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x144C Start=0x1443 Length=0x74
> > ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x14C0 Start=0x14B7 Length=0x80
> > Select Item: 0x19
> > SaveCondensedWritePointerToS3Context: 0x002B/[0x00000000+8] := 0x7FE5C000 (0)
> 
> This is where OVMF stashes the WRITE_POINTER command in "condensed"
> form, for S3. The fw_cfg selector value is 0x2B (for the fw_cfg file to
> be rewritten), the pointer is located at offset 0, has size 0, and the
> value to assign is 0x7FE5C000. And, this is #0 of the saved / condensed
> WRITE_POINTER commands.
> 
> > Select Item: 0x2B
> > ProcessCmdWritePointer: PointerFile="etc/vmgenid_addr" PointeeFile="etc/vmgenid_guid" PointerOffset=0x0 PointerSize=8
> 
> This is where the WRITE_POINTER command is actually executed, during
> normal boot.
> 
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/vmgenid_guid" PointerOffset=0x1561 PointerSize=4
> 
> This is where we link "etc/vmgenid_guid" into VGIA.
> 
> > ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x1540 Start=0x1537 Length=0xCA
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/acpi/tables" PointerOffset=0x1625 PointerSize=4
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/acpi/tables" PointerOffset=0x1629 PointerSize=4
> > ProcessCmdAddPointer: PointerFile="etc/acpi/tables" PointeeFile="etc/acpi/tables" PointerOffset=0x162D PointerSize=4
> > ProcessCmdAddChecksum: File="etc/acpi/tables" ResultOffset=0x160A Start=0x1601 Length=0x30
> > ProcessCmdAddPointer: PointerFile="etc/acpi/rsdp" PointeeFile="etc/acpi/tables" PointerOffset=0x10 PointerSize=4
> > ProcessCmdAddChecksum: File="etc/acpi/rsdp" ResultOffset=0x8 Start=0x0 Length=0x24
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > InstallQemuFwCfgTables: unknown loader command: 0x0
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AB000 (remaining: 0x20000): found "FACS" size 0x40
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AB040 (remaining: 0x1FFC0): found "DSDT" size 0x1403
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/vmgenid_guid" at 0x7FE5C000 (remaining: 0x1000): not found; marking fw_cfg blob as opaque
> 
> This is where the OVMF SDT Header Probe Suppressor does its job. (NB,
> the "opaque marking" has happened already in ProcessCmdWritePointer()
> too, above.)
> 
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AC443 (remaining: 0x1EBBD): found "FACP" size 0x74
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AC4B7 (remaining: 0x1EB49): found "APIC" size 0x80
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AC537 (remaining: 0x1EAC9): found "SSDT" size 0xCA
> > Process2ndPassCmdAddPointer: checking for ACPI header in "etc/acpi/tables" at 0x7E7AC601 (remaining: 0x1E9FF): found "RSDT" size 0x30
> > TransferS3ContextToBootScript: boot script fragment saved, ScratchBuffer=7FE4F018
> 
> This is where the WRITE_POINTER commands, stashed earlier in condensed
> form, are translated to S3 Boot Script opcodes.
> 
> > InstallQemuFwCfgTables: installed 5 tables
> 
> Such as: FACS, DSDT, FACP, APIC, SSDT. OVMF recognizes RSDT and ignores
> it (it's handled by edk2 automatically).
> 
> > InstallQemuFwCfgTables: freeing "etc/acpi/rsdp"
> > InstallQemuFwCfgTables: freeing "etc/acpi/tables"
> 
> OVMF sees that the above two blobs have not been marked as "opaque" --
> they only contained ACPI tables, judged from the ADD_POINTER commands
> that pointed into them. So these two blobs are freed.
> 
> Note that "etc/vmgenid_guid" is not freed.
> 
> So, from the firmware log, everything looks OK.
> 
> (3) I dumped the SSDT in the RHEL-7 guest:
> 
> > /*
> >  * Intel ACPI Component Architecture
> >  * AML/ASL+ Disassembler version 20160527-64
> >  * Copyright (c) 2000 - 2016 Intel Corporation
> >  *
> >  * Disassembling to symbolic ASL+ operators
> >  *
> >  * Disassembly of ssdt.dat, Wed Feb 15 19:21:11 2017
> >  *
> >  * Original Table Header:
> >  *     Signature        "SSDT"
> >  *     Length           0x000000CA (202)
> >  *     Revision         0x01
> >  *     Checksum         0x1D
> >  *     OEM ID           "BOCHS "
> >  *     OEM Table ID     "VMGENID"
> >  *     OEM Revision     0x00000001 (1)
> >  *     Compiler ID      "BXPC"
> >  *     Compiler Version 0x00000001 (1)
> >  */
> > DefinitionBlock ("", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
> > {
> >     Name (VGIA, 0x7FE5C000)
> 
> Note that the value matches the value logged by the firmware in (2).
> 
> >     Scope (\_SB)
> >     {
> >         Device (VGEN)
> >         {
> >             Name (_HID, "QEMUVGID")  // _HID: Hardware ID
> >             Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
> >             Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
> >             Method (_STA, 0, NotSerialized)  // _STA: Status
> >             {
> >                 Local0 = 0x0F
> >                 If (VGIA == Zero)
> >                 {
> >                     Local0 = Zero
> >                 }
> >
> >                 Return (Local0)
> >             }
> >
> >             Method (ADDR, 0, NotSerialized)
> >             {
> >                 Local0 = Package (0x02) {}
> >                 Local0 [Zero] = (VGIA + 0x28)
> >                 Local0 [One] = Zero
> >                 Return (Local0)
> >             }
> >         }
> >     }
> >
> >     Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> >     {
> >         Notify (\_SB.VGEN, 0x80) // Status Change
> >     }
> > }
> 
> Looks good and matches the documentation.
> 
> (4) To be sure, I checked the address against the guest dmesg, which
> contains a dump of the UEFI memory map:
> 
> > [    0.000000] efi: mem52: type=10, attr=0xf, range=[0x000000007fe5a000-0x000000007fe5e000) (0MB)
> 
> The page (4096 bytes) at 0x7FE5C000 falls into this range. Type=10 means
> EfiACPIMemoryNVS.
> 
> (5) At this point I dumped the guest RAM with the dump-guest-memory
> monitor command, opened it with "crash", and listed it:
> 
> > crash> rd -p -8 0x7FE5C000 0x40
> >         7fe5c000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> >         7fe5c010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
> >         7fe5c020:  00 00 00 00 00 00 00 00 33 22 11 00 55 44 77 66   ........3"..UDwf
> >         7fe5c030:  88 99 aa bb cc dd ee ff 00 00 00 00 00 00 00 00   ................
> 
> We can see that the GUID starts at 0x7FE5C000 + 0x28, and also that the
> byte-level representation matches the little endian one given in (1).
> 
> This proves that the initial blob download worked fine.
> 
> (6) Here I attached "gdb" to QEMU, set a breakpoint on
> vmgenid_handle_reset(), allowed the inferior process to continue
> execution.
> 
> Then I suspended and resumed the guest (ACPI S3). The breakpoint was hit
> during resume:
> 
> > Breakpoint 1, vmgenid_handle_reset (opaque=0x7f2bd03c36e0) at .../hw/acpi/vmgenid.c:205
> > 205         VmGenIdState *vms = VMGENID(opaque);
> 
> First of all, before allowing QEMU to zero out the address blob, I
> listed the address and the contents of the address blob (here exploiting
> that my host is also little endian):
> 
> > (gdb) print (void*)vms->vmgenid_addr_le
> > $2 = (void *) 0x7f2bd03c37b0
> 
> > (gdb) print /x *(uint64_t*)vms->vmgenid_addr_le
> > $4 = 0x7fe5c000
> 
> This proves that QEMU has the right address, matching the firmware log
> from (2), and the ACPI dump from (3).
> 
> (7) At this point I allowed the inferior to proceed a bit:
> 
> > (gdb) n
> > 207         memset(vms->vmgenid_addr_le, 0, ARRAY_SIZE(vms->vmgenid_addr_le));
> > (gdb) n
> > 208     }
> 
> I verified that the blob was zeroed:
> 
> > (gdb) print /x *(uint64_t*)vms->vmgenid_addr_le
> > $5 = 0x0
> 
> then allowed the inferior to run free.
> 
> > (gdb) cont
> > Continuing.
> 
> (8) New messages appeared in the firmware log:
> 
> > S3ResumeExecuteBootScript()
> > PeiS3ResumeState - 7FF92B18
> > transfer control to Standalone Boot Script Executor
> > S3BootScriptExecute:
> > TableHeader - 0x7E7A7000
> > TableHeader.Version - 0x0001
> > TableHeader.TableLength - 0x000000ED
> > ExecuteBootScript - 7E7A700D
> > EFI_BOOT_SCRIPT_MEM_WRITE_OPCODE
> > BootScriptExecuteMemoryWrite - 0x7FE4F018, 0x00000010, 0x00000000
> 
> Here the ACPI S3 Boot Script, prepared in
> TransferS3ContextToBootScript() -- see (2) -- creates a DMA access
> command for fw_cfg. The DMA access command is written to pre-reserved
> memory (see "ScratchBuffer" above).
> 
> > S3BootScriptWidthUint8 - 0x7FE4F018 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F019 (0x2B)
> 
> The fw_cfg selector is 0x2B. (See under (2).)
> 
> > S3BootScriptWidthUint8 - 0x7FE4F01A (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01B (0x0C)
> 
> This is a combined select+skip operation.
> 
> > S3BootScriptWidthUint8 - 0x7FE4F01C (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01D (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01E (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01F (0x00)
> 
> The skip size is 0 bytes.
> 
> > S3BootScriptWidthUint8 - 0x7FE4F020 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F021 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F022 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F023 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F024 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F025 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F026 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F027 (0x00)
> 
> The address is irrelevant for skip, so it's just nuleld.
> 
> > ExecuteBootScript - 7E7A7030
> > EFI_BOOT_SCRIPT_IO_WRITE_OPCODE
> > BootScriptExecuteIoWrite - 0x00000514, 0x00000002, 0x00000002
> > S3BootScriptWidthUint32 - 0x00000514 (0x00000000)
> > S3BootScriptWidthUint32 - 0x00000518 (0x18F0E47F)
> 
> The Boot Script passes the DMA command to QEMU, by writing the address
> of the command buffer to IO ports 0x514 and 0x518, in BE byte order.
> 
> > ExecuteBootScript - 7E7A704B
> > EFI_BOOT_SCRIPT_MEM_POLL_OPCODE
> > BootScriptExecuteMemPoll - 0x7FE4F018, 0x00000000FFFFFFFF, 0x0000000000000000
> > S3BootScriptWidthUint32 - 0x7FE4F018
> > ExecuteBootScript - 7E7A7072
> 
> This waits until the DMA command succeeds (reading back the Control
> field continuously until it reads as zero).
> 
> > EFI_BOOT_SCRIPT_MEM_WRITE_OPCODE
> > BootScriptExecuteMemoryWrite - 0x7FE4F018, 0x00000018, 0x00000000
> 
> This is another DMA access command for fw_cfg, prepared in the same
> pre-reserved buffer. This time
> 
> > S3BootScriptWidthUint8 - 0x7FE4F018 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F019 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01A (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01B (0x10)
> 
> we request a write operation,
> 
> > S3BootScriptWidthUint8 - 0x7FE4F01C (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01D (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01E (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F01F (0x08)
> 
> with a length of 8 bytes (big endian), matching the pointer size,
> 
> > S3BootScriptWidthUint8 - 0x7FE4F020 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F021 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F022 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F023 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F024 (0x7F)
> > S3BootScriptWidthUint8 - 0x7FE4F025 (0xE4)
> > S3BootScriptWidthUint8 - 0x7FE4F026 (0xF0)
> > S3BootScriptWidthUint8 - 0x7FE4F027 (0x28)
> 
> the data to transfer is located at 0x7FE4F028 (just below, tacked to the
> command buffer itself),
> 
> > S3BootScriptWidthUint8 - 0x7FE4F028 (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F029 (0xC0)
> > S3BootScriptWidthUint8 - 0x7FE4F02A (0xE5)
> > S3BootScriptWidthUint8 - 0x7FE4F02B (0x7F)
> > S3BootScriptWidthUint8 - 0x7FE4F02C (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F02D (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F02E (0x00)
> > S3BootScriptWidthUint8 - 0x7FE4F02F (0x00)
> 
> and the data to write is the original allocation address of the blob
> (0x7fe5c000).
> 
> > ExecuteBootScript - 7E7A709D
> > EFI_BOOT_SCRIPT_IO_WRITE_OPCODE
> > BootScriptExecuteIoWrite - 0x00000514, 0x00000002, 0x00000002
> > S3BootScriptWidthUint32 - 0x00000514 (0x00000000)
> > S3BootScriptWidthUint32 - 0x00000518 (0x18F0E47F)
> > ExecuteBootScript - 7E7A70B8
> > EFI_BOOT_SCRIPT_MEM_POLL_OPCODE
> > BootScriptExecuteMemPoll - 0x7FE4F018, 0x00000000FFFFFFFF, 0x0000000000000000
> > S3BootScriptWidthUint32 - 0x7FE4F018
> > ExecuteBootScript - 7E7A70DF
> 
> Same story as above: fire off the transfer and wait until it completes.
> 
> > EFI_BOOT_SCRIPT_INFORMATION_OPCODE
> > BootScriptExecuteInformation - 0x7E7A70E6
> > BootScriptInformation: DE AD BE EF
> > ExecuteBootScript - 7E7A70EA
> > S3_BOOT_SCRIPT_LIB_TERMINATE_OPCODE
> > S3BootScriptDone - Success
> > [...]
> 
> The DEADBEEF informational (no-op) opcode is something that OVMF appends
> to the very end for hysterical raisins.
> 
> (9) Okay, so the guest is now resumed and running, let's interrupt it in
> gdb again, and check the contents of address blob again (we know the
> address of the address blob from step (6)):
> 
> > ^C
> > Program received signal SIGINT, Interrupt.
> > 0x00007f2bbf1d1ebf in ppoll () from /lib64/libc.so.6
> > (gdb) print /x *(uint64_t*)0x7f2bd03c37b0
> > $6 = 0x7fe5c000
> 
> Et voila.
> 
> (10) I detached gdb from QEMU, and issued the following monitor command:
> 
> > $ virsh qemu-monitor-command ovmf.rhel7 --hmp 'info vm-generation-id'
> > 00112233-4455-6677-8899-aabbccddeeff
> 
> (11) I also booted a Windows Server 2012 R2 guest (Q35, broadcast SMI
> enabled) with a similar vmgenid device/parameter. According to Device
> Manager | System devices, "Microsoft Hyper-V Generation Counter" is
> working properly.
> 
> I also tested S3 briefly, it worked okay. (I mentioned the SMI broadcast
> above because for that, OVMF generates an independent S3 Boot Script
> fragment.)
> 
> 
> I'll let someone else test live migration.
> 
> For patches #1, #3, #4 and #5:
> 
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> 
> I'll soon post the OVMF patches.
> 
> Thanks!
> Laszlo


How do you feel about Igor's request to change WRITE_POINTER to add
offset in there, so guest can pass in the address of GUID and
not start of table? Would that be a lot of work to add?

-- 
MST
