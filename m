Received: from eggs.gnu.org ([2001:4830:134:3::10]:48143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ce5zR-0003P6-G9
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ce5zO-0004I1-5q
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:15:49 -0500
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:32788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ce5zN-0004Ho-QA
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 15:15:46 -0500
Received: by mail-pf0-x22a.google.com with SMTP id c73so30440211pfb.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 12:15:45 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <44C57180-7C03-4B0C-BAD9-16F760DF676D@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_FED62D92-5B04-4C5F-B280-BF688DE5C0D9";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 12:15:42 -0800
In-Reply-To: <20170215220837-mutt-send-email-mst@kernel.org>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
	<20170215220837-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com


--Apple-Mail=_FED62D92-5B04-4C5F-B280-BF688DE5C0D9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 15, 2017, at 12:09 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:
>> On 02/15/17 07:15, ben@skyportsystems.com wrote:
>>> From: Ben Warren <ben@skyportsystems.com>
>>>=20
>>> This patch set adds support for passing a GUID to Windows guests.  =
It
>>> is a re-implementation of previous patch sets written by Igor =
Mammedov
>>> et al, but this time passing the GUID data as a fw_cfg blob.
>>>=20
>>> This patch set has dependencies on new guest functionality, in
>>> particular the support for a new linker-loader command and the =
ability
>>> to write back data to QEMU over a DMA link.  Work is in flight in =
both
>>> SeaBIOS and OVMF to support this.
>>>=20
>>> v5->v6:
>>>    - Rebased to top of tree.
>>>    - Changed device from sysbus to a simple device.  This removed =
the need for
>>>      adding dynamic sysbus support to pc_piix boards.
>>>    - Removed patch that introduced QWORD patching of AML.
>>>    - Removed ability to set GUID via QMP/HMP.
>>>    - Improved comments/documentation in code.
>>=20
>> So here's my testing with a RHEL-7 guest:
>>=20
>> (1) The command line option passed to QEMU is
>>=20
>>  -device vmgenid,guid=3D00112233-4455-6677-8899-AABBCCDDEEFF
>>=20
>> This is the example GUID provided in the SMBIOS spec v3.0.0 =
(DSP0134),
>> section 7.2.1 "System -- UUID". (SMBIOS is only relevant here because =
it
>> codifies the fact that Microsoft consumes UUID in little-endian =
order.)
>> The expected representation, according to the SMBIOS spec, is
>>=20
>>  33 22 11 00 55 44 77 66 88 99 AA BB CC DD EE FF
>>=20
>> (2) Here's an excerpt from the OVMF log:
>>=20
>>> ProcessCmdAllocate: File=3D"etc/vmgenid_guid" Alignment=3D0x1000 =
Zone=3D1 Size=3D0x1000 Address=3D0x7FE5C000
>>=20
>> This is where "etc/vmgenid_guid" is allocated and downloaded, the
>> allocation address is 0x7FE5C000.
>>=20
>>> Select Item: 0x19
>>> Select Item: 0x22
>>> ProcessCmdAllocate: File=3D"etc/acpi/tables" Alignment=3D0x40 Zone=3D1=
 Size=3D0x20000 Address=3D0x7E7AB000
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/tables" ResultOffset=3D0x49 =
Start=3D0x40 Length=3D0x1403
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x1467 PointerSize=3D4
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x146B PointerSize=3D4
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/tables" ResultOffset=3D0x144C =
Start=3D0x1443 Length=3D0x74
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/tables" ResultOffset=3D0x14C0 =
Start=3D0x14B7 Length=3D0x80
>>> Select Item: 0x19
>>> SaveCondensedWritePointerToS3Context: 0x002B/[0x00000000+8] :=3D =
0x7FE5C000 (0)
>>=20
>> This is where OVMF stashes the WRITE_POINTER command in "condensed"
>> form, for S3. The fw_cfg selector value is 0x2B (for the fw_cfg file =
to
>> be rewritten), the pointer is located at offset 0, has size 0, and =
the
>> value to assign is 0x7FE5C000. And, this is #0 of the saved / =
condensed
>> WRITE_POINTER commands.
>>=20
>>> Select Item: 0x2B
>>> ProcessCmdWritePointer: PointerFile=3D"etc/vmgenid_addr" =
PointeeFile=3D"etc/vmgenid_guid" PointerOffset=3D0x0 PointerSize=3D8
>>=20
>> This is where the WRITE_POINTER command is actually executed, during
>> normal boot.
>>=20
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/vmgenid_guid" PointerOffset=3D0x1561 PointerSize=3D4
>>=20
>> This is where we link "etc/vmgenid_guid" into VGIA.
>>=20
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/tables" ResultOffset=3D0x1540 =
Start=3D0x1537 Length=3D0xCA
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x1625 PointerSize=3D4
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x1629 PointerSize=3D4
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/tables" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x162D PointerSize=3D4
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/tables" ResultOffset=3D0x160A =
Start=3D0x1601 Length=3D0x30
>>> ProcessCmdAddPointer: PointerFile=3D"etc/acpi/rsdp" =
PointeeFile=3D"etc/acpi/tables" PointerOffset=3D0x10 PointerSize=3D4
>>> ProcessCmdAddChecksum: File=3D"etc/acpi/rsdp" ResultOffset=3D0x8 =
Start=3D0x0 Length=3D0x24
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> InstallQemuFwCfgTables: unknown loader command: 0x0
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AB000 (remaining: 0x20000): found "FACS" size =
0x40
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AB040 (remaining: 0x1FFC0): found "DSDT" size =
0x1403
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/vmgenid_guid" at 0x7FE5C000 (remaining: 0x1000): not found; marking =
fw_cfg blob as opaque
>>=20
>> This is where the OVMF SDT Header Probe Suppressor does its job. (NB,
>> the "opaque marking" has happened already in ProcessCmdWritePointer()
>> too, above.)
>>=20
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AC443 (remaining: 0x1EBBD): found "FACP" size =
0x74
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AC4B7 (remaining: 0x1EB49): found "APIC" size =
0x80
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AC537 (remaining: 0x1EAC9): found "SSDT" size =
0xCA
>>> Process2ndPassCmdAddPointer: checking for ACPI header in =
"etc/acpi/tables" at 0x7E7AC601 (remaining: 0x1E9FF): found "RSDT" size =
0x30
>>> TransferS3ContextToBootScript: boot script fragment saved, =
ScratchBuffer=3D7FE4F018
>>=20
>> This is where the WRITE_POINTER commands, stashed earlier in =
condensed
>> form, are translated to S3 Boot Script opcodes.
>>=20
>>> InstallQemuFwCfgTables: installed 5 tables
>>=20
>> Such as: FACS, DSDT, FACP, APIC, SSDT. OVMF recognizes RSDT and =
ignores
>> it (it's handled by edk2 automatically).
>>=20
>>> InstallQemuFwCfgTables: freeing "etc/acpi/rsdp"
>>> InstallQemuFwCfgTables: freeing "etc/acpi/tables"
>>=20
>> OVMF sees that the above two blobs have not been marked as "opaque" =
--
>> they only contained ACPI tables, judged from the ADD_POINTER commands
>> that pointed into them. So these two blobs are freed.
>>=20
>> Note that "etc/vmgenid_guid" is not freed.
>>=20
>> So, from the firmware log, everything looks OK.
>>=20
>> (3) I dumped the SSDT in the RHEL-7 guest:
>>=20
>>> /*
>>> * Intel ACPI Component Architecture
>>> * AML/ASL+ Disassembler version 20160527-64
>>> * Copyright (c) 2000 - 2016 Intel Corporation
>>> *
>>> * Disassembling to symbolic ASL+ operators
>>> *
>>> * Disassembly of ssdt.dat, Wed Feb 15 19:21:11 2017
>>> *
>>> * Original Table Header:
>>> *     Signature        "SSDT"
>>> *     Length           0x000000CA (202)
>>> *     Revision         0x01
>>> *     Checksum         0x1D
>>> *     OEM ID           "BOCHS "
>>> *     OEM Table ID     "VMGENID"
>>> *     OEM Revision     0x00000001 (1)
>>> *     Compiler ID      "BXPC"
>>> *     Compiler Version 0x00000001 (1)
>>> */
>>> DefinitionBlock ("", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
>>> {
>>>    Name (VGIA, 0x7FE5C000)
>>=20
>> Note that the value matches the value logged by the firmware in (2).
>>=20
>>>    Scope (\_SB)
>>>    {
>>>        Device (VGEN)
>>>        {
>>>            Name (_HID, "QEMUVGID")  // _HID: Hardware ID
>>>            Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
>>>            Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
>>>            Method (_STA, 0, NotSerialized)  // _STA: Status
>>>            {
>>>                Local0 =3D 0x0F
>>>                If (VGIA =3D=3D Zero)
>>>                {
>>>                    Local0 =3D Zero
>>>                }
>>>=20
>>>                Return (Local0)
>>>            }
>>>=20
>>>            Method (ADDR, 0, NotSerialized)
>>>            {
>>>                Local0 =3D Package (0x02) {}
>>>                Local0 [Zero] =3D (VGIA + 0x28)
>>>                Local0 [One] =3D Zero
>>>                Return (Local0)
>>>            }
>>>        }
>>>    }
>>>=20
>>>    Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered =
GPE
>>>    {
>>>        Notify (\_SB.VGEN, 0x80) // Status Change
>>>    }
>>> }
>>=20
>> Looks good and matches the documentation.
>>=20
>> (4) To be sure, I checked the address against the guest dmesg, which
>> contains a dump of the UEFI memory map:
>>=20
>>> [    0.000000] efi: mem52: type=3D10, attr=3D0xf, =
range=3D[0x000000007fe5a000-0x000000007fe5e000) (0MB)
>>=20
>> The page (4096 bytes) at 0x7FE5C000 falls into this range. Type=3D10 =
means
>> EfiACPIMemoryNVS.
>>=20
>> (5) At this point I dumped the guest RAM with the dump-guest-memory
>> monitor command, opened it with "crash", and listed it:
>>=20
>>> crash> rd -p -8 0x7FE5C000 0x40
>>>        7fe5c000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   =
................
>>>        7fe5c010:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   =
................
>>>        7fe5c020:  00 00 00 00 00 00 00 00 33 22 11 00 55 44 77 66   =
........3"..UDwf
>>>        7fe5c030:  88 99 aa bb cc dd ee ff 00 00 00 00 00 00 00 00   =
................
>>=20
>> We can see that the GUID starts at 0x7FE5C000 + 0x28, and also that =
the
>> byte-level representation matches the little endian one given in (1).
>>=20
>> This proves that the initial blob download worked fine.
>>=20
>> (6) Here I attached "gdb" to QEMU, set a breakpoint on
>> vmgenid_handle_reset(), allowed the inferior process to continue
>> execution.
>>=20
>> Then I suspended and resumed the guest (ACPI S3). The breakpoint was =
hit
>> during resume:
>>=20
>>> Breakpoint 1, vmgenid_handle_reset (opaque=3D0x7f2bd03c36e0) at =
.../hw/acpi/vmgenid.c:205
>>> 205         VmGenIdState *vms =3D VMGENID(opaque);
>>=20
>> First of all, before allowing QEMU to zero out the address blob, I
>> listed the address and the contents of the address blob (here =
exploiting
>> that my host is also little endian):
>>=20
>>> (gdb) print (void*)vms->vmgenid_addr_le
>>> $2 =3D (void *) 0x7f2bd03c37b0
>>=20
>>> (gdb) print /x *(uint64_t*)vms->vmgenid_addr_le
>>> $4 =3D 0x7fe5c000
>>=20
>> This proves that QEMU has the right address, matching the firmware =
log
>> from (2), and the ACPI dump from (3).
>>=20
>> (7) At this point I allowed the inferior to proceed a bit:
>>=20
>>> (gdb) n
>>> 207         memset(vms->vmgenid_addr_le, 0, =
ARRAY_SIZE(vms->vmgenid_addr_le));
>>> (gdb) n
>>> 208     }
>>=20
>> I verified that the blob was zeroed:
>>=20
>>> (gdb) print /x *(uint64_t*)vms->vmgenid_addr_le
>>> $5 =3D 0x0
>>=20
>> then allowed the inferior to run free.
>>=20
>>> (gdb) cont
>>> Continuing.
>>=20
>> (8) New messages appeared in the firmware log:
>>=20
>>> S3ResumeExecuteBootScript()
>>> PeiS3ResumeState - 7FF92B18
>>> transfer control to Standalone Boot Script Executor
>>> S3BootScriptExecute:
>>> TableHeader - 0x7E7A7000
>>> TableHeader.Version - 0x0001
>>> TableHeader.TableLength - 0x000000ED
>>> ExecuteBootScript - 7E7A700D
>>> EFI_BOOT_SCRIPT_MEM_WRITE_OPCODE
>>> BootScriptExecuteMemoryWrite - 0x7FE4F018, 0x00000010, 0x00000000
>>=20
>> Here the ACPI S3 Boot Script, prepared in
>> TransferS3ContextToBootScript() -- see (2) -- creates a DMA access
>> command for fw_cfg. The DMA access command is written to pre-reserved
>> memory (see "ScratchBuffer" above).
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F018 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F019 (0x2B)
>>=20
>> The fw_cfg selector is 0x2B. (See under (2).)
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F01A (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01B (0x0C)
>>=20
>> This is a combined select+skip operation.
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F01C (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01D (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01E (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01F (0x00)
>>=20
>> The skip size is 0 bytes.
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F020 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F021 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F022 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F023 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F024 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F025 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F026 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F027 (0x00)
>>=20
>> The address is irrelevant for skip, so it's just nuleld.
>>=20
>>> ExecuteBootScript - 7E7A7030
>>> EFI_BOOT_SCRIPT_IO_WRITE_OPCODE
>>> BootScriptExecuteIoWrite - 0x00000514, 0x00000002, 0x00000002
>>> S3BootScriptWidthUint32 - 0x00000514 (0x00000000)
>>> S3BootScriptWidthUint32 - 0x00000518 (0x18F0E47F)
>>=20
>> The Boot Script passes the DMA command to QEMU, by writing the =
address
>> of the command buffer to IO ports 0x514 and 0x518, in BE byte order.
>>=20
>>> ExecuteBootScript - 7E7A704B
>>> EFI_BOOT_SCRIPT_MEM_POLL_OPCODE
>>> BootScriptExecuteMemPoll - 0x7FE4F018, 0x00000000FFFFFFFF, =
0x0000000000000000
>>> S3BootScriptWidthUint32 - 0x7FE4F018
>>> ExecuteBootScript - 7E7A7072
>>=20
>> This waits until the DMA command succeeds (reading back the Control
>> field continuously until it reads as zero).
>>=20
>>> EFI_BOOT_SCRIPT_MEM_WRITE_OPCODE
>>> BootScriptExecuteMemoryWrite - 0x7FE4F018, 0x00000018, 0x00000000
>>=20
>> This is another DMA access command for fw_cfg, prepared in the same
>> pre-reserved buffer. This time
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F018 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F019 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01A (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01B (0x10)
>>=20
>> we request a write operation,
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F01C (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01D (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01E (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F01F (0x08)
>>=20
>> with a length of 8 bytes (big endian), matching the pointer size,
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F020 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F021 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F022 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F023 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F024 (0x7F)
>>> S3BootScriptWidthUint8 - 0x7FE4F025 (0xE4)
>>> S3BootScriptWidthUint8 - 0x7FE4F026 (0xF0)
>>> S3BootScriptWidthUint8 - 0x7FE4F027 (0x28)
>>=20
>> the data to transfer is located at 0x7FE4F028 (just below, tacked to =
the
>> command buffer itself),
>>=20
>>> S3BootScriptWidthUint8 - 0x7FE4F028 (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F029 (0xC0)
>>> S3BootScriptWidthUint8 - 0x7FE4F02A (0xE5)
>>> S3BootScriptWidthUint8 - 0x7FE4F02B (0x7F)
>>> S3BootScriptWidthUint8 - 0x7FE4F02C (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F02D (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F02E (0x00)
>>> S3BootScriptWidthUint8 - 0x7FE4F02F (0x00)
>>=20
>> and the data to write is the original allocation address of the blob
>> (0x7fe5c000).
>>=20
>>> ExecuteBootScript - 7E7A709D
>>> EFI_BOOT_SCRIPT_IO_WRITE_OPCODE
>>> BootScriptExecuteIoWrite - 0x00000514, 0x00000002, 0x00000002
>>> S3BootScriptWidthUint32 - 0x00000514 (0x00000000)
>>> S3BootScriptWidthUint32 - 0x00000518 (0x18F0E47F)
>>> ExecuteBootScript - 7E7A70B8
>>> EFI_BOOT_SCRIPT_MEM_POLL_OPCODE
>>> BootScriptExecuteMemPoll - 0x7FE4F018, 0x00000000FFFFFFFF, =
0x0000000000000000
>>> S3BootScriptWidthUint32 - 0x7FE4F018
>>> ExecuteBootScript - 7E7A70DF
>>=20
>> Same story as above: fire off the transfer and wait until it =
completes.
>>=20
>>> EFI_BOOT_SCRIPT_INFORMATION_OPCODE
>>> BootScriptExecuteInformation - 0x7E7A70E6
>>> BootScriptInformation: DE AD BE EF
>>> ExecuteBootScript - 7E7A70EA
>>> S3_BOOT_SCRIPT_LIB_TERMINATE_OPCODE
>>> S3BootScriptDone - Success
>>> [...]
>>=20
>> The DEADBEEF informational (no-op) opcode is something that OVMF =
appends
>> to the very end for hysterical raisins.
>>=20
>> (9) Okay, so the guest is now resumed and running, let's interrupt it =
in
>> gdb again, and check the contents of address blob again (we know the
>> address of the address blob from step (6)):
>>=20
>>> ^C
>>> Program received signal SIGINT, Interrupt.
>>> 0x00007f2bbf1d1ebf in ppoll () from /lib64/libc.so.6
>>> (gdb) print /x *(uint64_t*)0x7f2bd03c37b0
>>> $6 =3D 0x7fe5c000
>>=20
>> Et voila.
>>=20
>> (10) I detached gdb from QEMU, and issued the following monitor =
command:
>>=20
>>> $ virsh qemu-monitor-command ovmf.rhel7 --hmp 'info =
vm-generation-id'
>>> 00112233-4455-6677-8899-aabbccddeeff
>>=20
>> (11) I also booted a Windows Server 2012 R2 guest (Q35, broadcast SMI
>> enabled) with a similar vmgenid device/parameter. According to Device
>> Manager | System devices, "Microsoft Hyper-V Generation Counter" is
>> working properly.
>>=20
>> I also tested S3 briefly, it worked okay. (I mentioned the SMI =
broadcast
>> above because for that, OVMF generates an independent S3 Boot Script
>> fragment.)
>>=20
>>=20
>> I'll let someone else test live migration.
>>=20
>> For patches #1, #3, #4 and #5:
>>=20
>> Tested-by: Laszlo Ersek <lersek@redhat.com>
>>=20
>> I'll soon post the OVMF patches.
>>=20
>> Thanks!
>> Laszlo
>=20
>=20
> How do you feel about Igor's request to change WRITE_POINTER to add
> offset in there, so guest can pass in the address of GUID and
> not start of table? Would that be a lot of work to add?
>=20
I know you=E2=80=99re asking Laszlo, but hopefully the answer is =
=E2=80=9COK=E2=80=9D.  I=E2=80=99m finished making those changes to QEMU =
and am coding up SeaBIOS right now.=20
> --=20
> MST


--Apple-Mail=_FED62D92-5B04-4C5F-B280-BF688DE5C0D9
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMjE1MjAxNTQzWjAjBgkqhkiG9w0BCQQxFgQUpdyHFUHmqcGeW1NuXVDFWM1nhJow
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEAWaHiEwhnHoaDJoJA0+P2fMYNogqwGtUmWiiURnjTJiEJYbUNikHmf8NI
BhZNvzLWBuDCwio5dDsROBSvQvJX/9w+9XGUal/zX/RlfkBSZJgEdJ7DI/HGBee1GuPHX58QzPID
FciLdw82vUhK8Cz16KkHmrKH4FnYpmDtZ/4EBDX4f1bEhBK7M9/iDfsyOpELkzy61D8eaCmlJ0FU
3hSnn4z9lQe4uIT+VJpWALIBlmZfzvpmfvIwMvkczNGp3hFdZFKljTDZZ2oTLqMXHpd9LCHNG01K
fKjIXpotRMTu1ZkO9Rf9N0P1+BaTRD0RSD1LPKcagsL3D9PSh4HEzymk2gAAAAAAAA==
--Apple-Mail=_FED62D92-5B04-4C5F-B280-BF688DE5C0D9--
