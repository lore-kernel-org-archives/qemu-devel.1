Received: from eggs.gnu.org ([2001:4830:134:3::10]:39641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cU8yi-0006Mk-5N
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cU8ye-0008Oe-SH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cU8ye-0008OP-JK
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:25:52 -0500
References: <CAO_EM_kuP9kk55bzxWqNOeuL8yW7gKNnacd1-UVGnJPyx2ZNYw@mail.gmail.com>
	<20160916033402-mutt-send-email-mst@kernel.org>
	<CAO_EM_mHyC7cywV4KUqH_MWwt2vVkK6GEOuaUX0FHpffdfaAuQ@mail.gmail.com>
	<20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
	<20170117194321-mutt-send-email-mst@kernel.org>
	<BD6CD44B-68C2-40F6-9251-7DFD06821AD4@skyportsystems.com>
	<DD5278F7-9CF4-4BAA-861D-F615430C1991@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <40ee4c2a-59b6-dc6a-0ce6-97f7026b8d07@redhat.com>
Date: Thu, 19 Jan 2017 10:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <DD5278F7-9CF4-4BAA-861D-F615430C1991@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 01/19/17 08:09, Ben Warren wrote:
>
>> On Jan 18, 2017, at 4:02 PM, Ben Warren <ben@skyportsystems.com>
>> wrote:
>>
>> Hi Michael,
>>> On Jan 17, 2017, at 9:45 AM, Michael S. Tsirkin <mst@redhat.com>
>>> wrote:
>>>
>>> On Mon, Jan 16, 2017 at 10:57:42AM -0800, Ben Warren wrote:
>>>> I think we have a misunderstanding here.  I'm storing the VM
>>>> Generation ID __data__ (a GUID) in a fw_cfg blob, not the address.
>>>
>>> Yes, I think I gathered this much from the discussion. This is what
>>> I'm saying - don't. Have guest loader reserve guest memory and write
>>> the address into a fw cfg blob, and have qemu write the id at that
>>> address. This way you can update guest memory at any time.
>>>
>> So I've gone down the path of creating a writeable fw_cfg blob to
>> hold the VGID address, but it doesn't seem to be getting updated.
>>
>> Here's the code I've added:
>>
>> #define VMGENID_FW_CFG_FILE      "etc/vmgenid"
>> #define VMGENID_FW_CFG_ADDR_FILE      "etc/vmgenid_addr"
>>
>> // Create writeable fw_cfg blob, vas->vgia is a GArray of size 8 and element size 1
>> fw_cfg_add_file_callback(s, VMGENID_FW_CFG_ADDR_FILE, NULL, NULL, vms->vgia->data, 8, false);
>>
>> // Request BIOS to allocate memory for the read-only DATA file:
>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_FILE, guid, 0,false);
>>
>> // Request BIOS to allocate memory for the writeable ADDRESS file:
>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_ADDR_FILE, s->vgia, 0, false);
>>
>> // Request BIOS to write the address of the DATA file into the ADDRESS file:
>> bios_linker_loader_add_pointer(linker, VMGENID_FW_CFG_ADDR_FILE, 0, sizeof(uint64_t), VMGENID_FW_CFG_FILE, 0);
>>
>> I've instrumented SeaBIOS and see the requests being made and memcpy
>> to the file happening, but don't see any changes in QEMU in the
>> memory pointed to by VMGENID_FW_CFG_ADDR_FILE.  Is this how writeable
>> fw_cfg is supposed to work?
>>
> Ed explained it to me and I think I get it now.  I realize that you
> and Igor have explained this throughout the e-mail chain, but I'm a
> little bit slower.
>
> Anyway, is this understanding correct?  BIOS is in fact patching
> fw_cfg data, but it's in a copy of the fw_cfg file that is in guest
> space.  In order to get this to work we would need to add a new
> command to the linker/loader protocol to write back changes to QEMU
> after patching, and of course implement the change in BIOS and UEFI
> projects.

(1) It's not enough to create just the "etc/vmgenid_addr" file; the
"etc/vmgenid" file must exist too, so that the firmware can download it.

(2) I don't understand why you need the ADD_POINTER command here. I
think it's unnecessary.

(3) The ALLOCATE command for "etc/vmgenid_addr" is also unnecessary.

(4) A new ALLOCATE_RETURN_ADDR command type should be introduced, with
the following contents:

        struct {
            char file[BIOS_LINKER_LOADER_FILESZ];
            uint32_t align;
            uint8_t zone;
            char addr_file[BIOS_LINKER_LOADER_FILESZ];
        } alloc_return_addr;

The first three fields have identical meanings to those of the current
ALLOCATE command. The last field instructs the firmware as to what
fw_cfg file to write the 8-byte physical address back to, in little
endian byte order, of the actual allocation.

(5) The linker/loader script should then use one command in total,
namely ALLOCATE_RETURN_ADDR, with

  file = etc/vmgenid
  addr_file = etc/vmgenid_addr

This will allow both SeaBIOS and OVMF to do the right thing.

In summary:
- create the read-only "etc/vmgenid" fw_cfg file
- create the writeable "etc/vmgenid_addr" fw_cfg file
- use one ALLOCATE_RETURN_ADDR command, and nothing else.

I hereby volunteer to write the OVMF patch for the ALLOCATE_RETURN_ADDR
command type.

If someone is interested, I'll remind us that EFI_ACPI_TABLE_PROTOCOL
installs *copies* of ACPI tables, out of the fw_cfg blobs that were
downloaded. Therefore OVMF tracks all ADD_POINTER commands that point
into fw_cfg blobs, and if an fw_cfg blob is not pointed-to by *any*
ADD_POINTER command, or else *all* ADD_POINTER commands that point into
it point to ACPI table headers, then OVMF will ultimately free the
originally downloaded fw_cfg blob. If there is at least one referring
ADD_POINTER command that points to non-ACPI-table data within the blob,
then OVMF marks the blob to be preserved permanently, in AcpiNVS type
memory.

By introducing the above ALLOCATE_RETURN_ADDR command type, OVMF can do
two things:

(a) immediately mark the blob for permanent preservation (i.e., it won't
    be released after the script processing is complete),
(b) write the actual allocation address back to the appropriate fw_cfg
    file.

For SeaBIOS, only (b) matters -- because it doesn't install *copies* of
ACPI tables; it rather keeps everything in place, as originally
allocated, and it just links things together --, but
ALLOCATE_RETURN_ADDR as proposed above should be suitable for SeaBIOS
just as well.

Thanks
Laszlo
