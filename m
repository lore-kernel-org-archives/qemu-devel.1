Received: from eggs.gnu.org ([2001:4830:134:3::10]:41350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cX98u-0008S9-7H
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cX98q-0002OJ-W2
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cX98q-0002OB-Nj
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:12:48 -0500
References: <29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
	<6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
	<20170126205508-mutt-send-email-mst@kernel.org>
	<20170127141854.GA2524@morn.lan>
	<58bbf216-a2f1-481f-21b0-4ada4f73a5e5@redhat.com>
	<20170127154313.GB7213@morn.lan>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0e627b59-08ad-ac77-5a7b-c80c0b027406@redhat.com>
Date: Fri, 27 Jan 2017 17:12:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170127154313.GB7213@morn.lan>
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
To: Kevin O'Connor <kevin@koconnor.net>, Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On 01/27/17 16:43, Kevin O'Connor wrote:
> On Fri, Jan 27, 2017 at 03:46:33PM +0100, Laszlo Ersek wrote:
>> On 01/27/17 15:18, Kevin O'Connor wrote:
>>> If an offset is going to be added, shouldn't both a source offset and
>>> destination offset be used?
>>>
>>>         /*
>>>          * COMMAND_WRITE_POINTER - update a writeable file named
>>>          * @pointer.dest_file at @pointer.dest_offset, by writing pointer
>>>          * plus @pointer.src_offset to the blob originating from
>>>          * @src_file. 1,2,4 or 8 byte unsigned write is used depending
>>>          * on @pointer.size.
>>>          */
>>>         struct {
>>>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>>>             uint32_t src_offset, dest_offset;
>>>             uint8_t size;
>>>         } pointer;
>>>
>>> I doubt the offsets or size is really all that important though.
>>
>> The offset into the fw_cfg file that receives the allocation address is
>> important, that allows the same file to receive several different
>> addresses (for different downloaded blobs), at different offsets.
>>
>> OTOH, asking the firmware to add a constant to the address value before
>> writing it to the fw_cfg file is not necessary, in my opinion. The blob
>> that the firmware allocated and downloaded originates from QEMU to begin
>> with, so QEMU knows its internal structure.
> 
> I guess I'm missing why QEMU would want to use the same writable file
> for multiple pointers

I know no specific reason; I just thought this possible generalization
was one of the advantages in Michael's suggestion.

> as well as why it would want support for
> pointers smaller than 8 bytes in size.

Hm, right, good point.

> If it's because it may be
> easier to support an internal QEMU blob of a particular format, then
> adding a src_offset would facilitate that.
> 
> However, if it was done so that WRITE_POINTER mimicks ADD_POINTER then
> that's fine too.

That might be the main reason I guess; reading back a bit, Michael wrote
"... a variant of ADD_POINTER".

>  I'm okay with either format.

I'd say let's go ahead with Michael's proposal then. Ben, are you okay
with that?

Thanks!
Laszlo
