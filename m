Received: from eggs.gnu.org ([2001:4830:134:3::10]:47748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cX7nd-0004gi-Ba
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cX7nS-0007B1-J0
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cX7nS-0007At-8q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:46:38 -0500
References: <dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
	<6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
	<20170126205508-mutt-send-email-mst@kernel.org>
	<20170127141854.GA2524@morn.lan>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <58bbf216-a2f1-481f-21b0-4ada4f73a5e5@redhat.com>
Date: Fri, 27 Jan 2017 15:46:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170127141854.GA2524@morn.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>

On 01/27/17 15:18, Kevin O'Connor wrote:
> On Thu, Jan 26, 2017 at 08:59:04PM +0200, Michael S. Tsirkin wrote:
>> On Thu, Jan 26, 2017 at 07:25:22PM +0100, Laszlo Ersek wrote:
>>> On 01/26/17 19:15, Michael S. Tsirkin wrote:
>>>> On Thu, Jan 26, 2017 at 06:43:22PM +0100, Laszlo Ersek wrote:
>>>>> On 01/26/17 16:20, Michael S. Tsirkin wrote:
>>>>>> On Thu, Jan 26, 2017 at 01:48:37AM +0100, Laszlo Ersek wrote:
>>>>>
>>>>>>> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
>>>>>>
>>>>>>
>>>>>> What is COMMAND_ALLOCATE_RETURN_ADDR? I'm only familiar with
>>>>>> COMMAND_ALLOCATE.
>>>>>
>>>>> It's a new command being introduced in this series, at my suggestion. It
>>>>> does the exact same thing as COMMAND_ALLOCATE, except once the
>>>>> allocation / download is carried out by the firmware, the firmware
>>>>> writes back the allocation address to the fw_cfg file that is named in
>>>>> an additional field of the COMMAND_ALLOCATE_RETURN_ADDR structure. (This
>>>>> is how QEMU learns where the blob in GPA space was placed by the
>>>>> firmware.) The format for this address-receiving fw_cfg file is supposed
>>>>> to be 8-byte, little endian.
>>>>
>>>> I see. I really think it's better as a separate command though.
>>>> E.g. COMMAND_WRITE_PTR?
>>>
>>> Sure, but please provide specifics, otherwise Ben & myself will have a
>>> hard time divining & implementing your intent :)
>>>
>>> Thanks,
>>> Laszlo
>>
>> I would say a variant of ADD_POINTER:
>>
>>         /*
>> 	 * COMMAND_WRITE_POINTER - update a writeable file named
>> 	 * @pointer.dest_file at @pointer.offset, by writing pointer to
>> 	 * the table originating from @src_file. 1,2,4 or 8 byte
>> 	 * unsigned write is used depending on @pointer.size.
>>          */
>>         struct {
>>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>>             uint32_t offset;
>>             uint8_t size;
>>         } pointer;
>>
> 
> I'm okay with this approach.
> 
> If an offset is going to be added, shouldn't both a source offset and
> destination offset be used?
> 
>         /*
>          * COMMAND_WRITE_POINTER - update a writeable file named
>          * @pointer.dest_file at @pointer.dest_offset, by writing pointer
>          * plus @pointer.src_offset to the blob originating from
>          * @src_file. 1,2,4 or 8 byte unsigned write is used depending
>          * on @pointer.size.
>          */
>         struct {
>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>             uint32_t src_offset, dest_offset;
>             uint8_t size;
>         } pointer;
> 
> I doubt the offsets or size is really all that important though.

The offset into the fw_cfg file that receives the allocation address is
important, that allows the same file to receive several different
addresses (for different downloaded blobs), at different offsets.

OTOH, asking the firmware to add a constant to the address value before
writing it to the fw_cfg file is not necessary, in my opinion. The blob
that the firmware allocated and downloaded originates from QEMU to begin
with, so QEMU knows its internal structure.

Here's a diagram for ADD_POINTER:

blob-to-patch
+---------------+
|               |
| pointer = N   |-----------+
|               |           |       pointed-to-blob
+---------------+           |       +----------------+
                            |       |                |
                            +-----> | offset N: ...  |
                                    |                |
                                    +----------------+

In this case, QEMU pre-populates the pointer field in "blob-to-patch"
with the value N (a small relative offset, from the beginning of
"pointed-to-blob"). The firmware then increases the pointer field in
"blob-to-patch" with the absolute allocation address of
"pointed-to-blob". Thus "pointer" will point to the absolute address of
offset N into "pointed-to-blob".

This is useful primarily when the "pointer" field in "blob-to-patch" is
part of an ACPI table in "blob-to-patch". ACPI tables are consumed by
the guest OS.

The information necessary for the above is:
- name of "blob-to-patch"
- name of "pointed-to-blob"
- relative address of pointer field to patch within "blob-to-patch"
- size of the same

Compare WRITE_POINTER:

fw-cfg-file-to-rewrite
+---------------+
|               |
| pointer = XXX |-----------+
|               |           |       pointed-to-blob
+---------------+           +-----> +----------------+
                                    |                |
                                    | offset N: ...  |
                                    | offset K: ...  |
                                    |                |
                                    +----------------+

In this case, the "pointer field" that the firmware should update lives
inside QEMU only. The only consumer for it is QEMU itself, from which
"pointed-to-blob" originates too. The original value XXX is irrelevant.
The firmware writes the base address of "pointed-to-blob" over XXX, and
then QEMU can add N whenever it wants to access the field at offset N in
"pointed-to-blob". It can add K too, whenever it wants to access another
field in "pointed-to-blob".

The information necessary for this command is:
- name of "fw-cfg-file-to-rewrite"
- name of "pointed-to-blob"
- offset of "pointer field" to overwrite within "fw-cfg-file-to-rewrite"
- size of the same

Thanks
Laszlo
