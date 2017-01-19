Received: from eggs.gnu.org ([2001:4830:134:3::10]:56927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cUHKC-0007V8-MU
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cUHK9-0004Gd-H1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:20:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cUHK9-0004FM-6U
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 13:20:37 -0500
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
	<40ee4c2a-59b6-dc6a-0ce6-97f7026b8d07@redhat.com>
	<6285FEB6-6536-4276-99B6-3E99C2F2F2E9@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <93eb7746-2fc2-ff3f-fbdc-458732ef5244@redhat.com>
Date: Thu, 19 Jan 2017 19:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <6285FEB6-6536-4276-99B6-3E99C2F2F2E9@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On 01/19/17 18:47, Ben Warren wrote:
> Thanks Laszlo!
>> On Jan 19, 2017, at 1:25 AM, Laszlo Ersek <lersek@redhat.com
>> <mailto:lersek@redhat.com>> wrote:
>>
>> On 01/19/17 08:09, Ben Warren wrote:
>>>
>>>> On Jan 18, 2017, at 4:02 PM, Ben Warren <ben@skyportsystems.com
>>>> <mailto:ben@skyportsystems.com>>
>>>> wrote:
>>>>
>>>> Hi Michael,
>>>>> On Jan 17, 2017, at 9:45 AM, Michael S. Tsirkin <mst@redhat.com
>>>>> <mailto:mst@redhat.com>>
>>>>> wrote:
>>>>>
>>>>> On Mon, Jan 16, 2017 at 10:57:42AM -0800, Ben Warren wrote:
>>>>>> I think we have a misunderstanding here.  I'm storing the VM
>>>>>> Generation ID __data__ (a GUID) in a fw_cfg blob, not the address.
>>>>>
>>>>> Yes, I think I gathered this much from the discussion. This is what
>>>>> I'm saying - don't. Have guest loader reserve guest memory and writ=
e
>>>>> the address into a fw cfg blob, and have qemu write the id at that
>>>>> address. This way you can update guest memory at any time.
>>>>>
>>>> So I've gone down the path of creating a writeable fw_cfg blob to
>>>> hold the VGID address, but it doesn't seem to be getting updated.
>>>>
>>>> Here's the code I've added:
>>>>
>>>> #define VMGENID_FW_CFG_FILE      "etc/vmgenid"
>>>> #define VMGENID_FW_CFG_ADDR_FILE      "etc/vmgenid_addr"
>>>>
>>>> // Create writeable fw_cfg blob, vas->vgia is a GArray of size 8 and
>>>> element size 1
>>>> fw_cfg_add_file_callback(s, VMGENID_FW_CFG_ADDR_FILE, NULL, NULL,
>>>> vms->vgia->data, 8, false);
>>>>
>>>> // Request BIOS to allocate memory for the read-only DATA file:
>>>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_FILE, guid, 0,false)=
;
>>>>
>>>> // Request BIOS to allocate memory for the writeable ADDRESS file:
>>>> bios_linker_loader_alloc(linker, VMGENID_FW_CFG_ADDR_FILE, s->vgia,
>>>> 0, false);
>>>>
>>>> // Request BIOS to write the address of the DATA file into the
>>>> ADDRESS file:
>>>> bios_linker_loader_add_pointer(linker, VMGENID_FW_CFG_ADDR_FILE, 0,
>>>> sizeof(uint64_t), VMGENID_FW_CFG_FILE, 0);
>>>>
>>>> I've instrumented SeaBIOS and see the requests being made and memcpy
>>>> to the file happening, but don't see any changes in QEMU in the
>>>> memory pointed to by VMGENID_FW_CFG_ADDR_FILE.  Is this how writeabl=
e
>>>> fw_cfg is supposed to work?
>>>>
>>> Ed explained it to me and I think I get it now.  I realize that you
>>> and Igor have explained this throughout the e-mail chain, but I'm a
>>> little bit slower.
>>>
>>> Anyway, is this understanding correct?  BIOS is in fact patching
>>> fw_cfg data, but it's in a copy of the fw_cfg file that is in guest
>>> space.  In order to get this to work we would need to add a new
>>> command to the linker/loader protocol to write back changes to QEMU
>>> after patching, and of course implement the change in BIOS and UEFI
>>> projects.
>>
>> (1) It's not enough to create just the "etc/vmgenid_addr" file; the
>> "etc/vmgenid" file must exist too, so that the firmware can download i=
t.
>>
> I do have that file too, just didn=E2=80=99t show it.
>> (2) I don't understand why you need the ADD_POINTER command here. I
>> think it's unnecessary.
>>
>> (3) The ALLOCATE command for "etc/vmgenid_addr" is also unnecessary.
>>
> For both of these, I was working within the confines of the existing
> API, which we now know is inadequate.
>> (4) A new ALLOCATE_RETURN_ADDR command type should be introduced, with
>> the following contents:
>>
>>        struct {
>>            char file[BIOS_LINKER_LOADER_FILESZ];
>>            uint32_t align;
>>            uint8_t zone;
>>            char addr_file[BIOS_LINKER_LOADER_FILESZ];
>>        } alloc_return_addr;
>>
>> The first three fields have identical meanings to those of the current
>> ALLOCATE command. The last field instructs the firmware as to what
>> fw_cfg file to write the 8-byte physical address back to, in little
>> endian byte order, of the actual allocation.
>>
>> (5) The linker/loader script should then use one command in total,
>> namely ALLOCATE_RETURN_ADDR, with
>>
>>  file =3D etc/vmgenid
>>  addr_file =3D etc/vmgenid_addr
>>
>> This will allow both SeaBIOS and OVMF to do the right thing.
>>
>> In summary:
>> - create the read-only "etc/vmgenid" fw_cfg file
>> - create the writeable "etc/vmgenid_addr" fw_cfg file
>> - use one ALLOCATE_RETURN_ADDR command, and nothing else.
>>
>> I hereby volunteer to write the OVMF patch for the ALLOCATE_RETURN_ADD=
R
>> command type.
>>
> Sounds great.  We use SeaBIOS so I=E2=80=99ll try to do the same there.
>=20
> So, just to make sure everything=E2=80=99s covered: this new mechanism =
will
> allow QEMU to have the guest allocate an arbitrary blob of memory (in
> the form of a fw_cfg file),

Yes.

> and will get an offset within guest memory
> in return (via another fw_cfg file).

Yes.

The information that QEMU will receive is the LE-encoded 8-byte GPA
(guest-physical address) of the allocation carried out by the firmware.

> It can then translate the guest
> offset into a host address

Yes.

I'm a bit rusty on the exact QEMU memory APIs here, but I think that
ram_addr_t is *not* the right source address type to convert from (to
HVA, host virtual address).

I.e., what the firmware returns should *not* be considered a ram_addr_t;
IIRC, ram_addr_t is a linear offset into RAMBlocks that does not take,
for example, the 32-bit PCI MMIO hole into account.

Instead, the value written by the firmware should be considered a
hwaddr. (See "include/exec/hwaddr.h".) Therefore you'll have to find a
translation from hwaddr to HVA.

(I'm sure seasoned QEMU developers will correct me on the APIs / src
address type if necessary.)

> and update the blob at will.

Yes.

(And then Igor said something about dirtying that memory after the QEMU
write...)

> Is this
> correct, because that=E2=80=99s what we need for VM Generation ID?

Yes, it seems correct to me.

Thanks
Laszlo

>=20
>> If someone is interested, I'll remind us that EFI_ACPI_TABLE_PROTOCOL
>> installs *copies* of ACPI tables, out of the fw_cfg blobs that were
>> downloaded. Therefore OVMF tracks all ADD_POINTER commands that point
>> into fw_cfg blobs, and if an fw_cfg blob is not pointed-to by *any*
>> ADD_POINTER command, or else *all* ADD_POINTER commands that point int=
o
>> it point to ACPI table headers, then OVMF will ultimately free the
>> originally downloaded fw_cfg blob. If there is at least one referring
>> ADD_POINTER command that points to non-ACPI-table data within the blob=
,
>> then OVMF marks the blob to be preserved permanently, in AcpiNVS type
>> memory.
>>
>> By introducing the above ALLOCATE_RETURN_ADDR command type, OVMF can d=
o
>> two things:
>>
>> (a) immediately mark the blob for permanent preservation (i.e., it won=
't
>>    be released after the script processing is complete),
>> (b) write the actual allocation address back to the appropriate fw_cfg
>>    file.
>>
>> For SeaBIOS, only (b) matters -- because it doesn't install *copies* o=
f
>> ACPI tables; it rather keeps everything in place, as originally
>> allocated, and it just links things together --, but
>> ALLOCATE_RETURN_ADDR as proposed above should be suitable for SeaBIOS
>> just as well.
>>
>> Thanks
>> Laszlo
> =E2=80=94Ben
>=20
