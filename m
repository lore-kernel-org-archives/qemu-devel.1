Received: from eggs.gnu.org ([2001:4830:134:3::10]:57318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce3El-0004qF-Ke
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ce3Eg-0004Pl-Jx
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:19:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ce3Eg-0004Pg-AS
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 12:19:22 -0500
References: <cover.1487139038.git.ben@skyportsystems.com>
	<9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d971f4f3-7cb1-bb42-d200-aa9fdd6d105d@redhat.com>
Date: Wed, 15 Feb 2017 18:19:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170215183736-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org

On 02/15/17 17:39, Michael S. Tsirkin wrote:
> On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Mammedov wrote:
>> On Wed, 15 Feb 2017 17:30:00 +0200
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Wed, Feb 15, 2017 at 04:22:25PM +0100, Igor Mammedov wrote:
>>>> On Wed, 15 Feb 2017 15:13:20 +0100
>>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>>   
>>>>> Commenting under Igor's reply for simplicity
>>>>>
>>>>> On 02/15/17 11:57, Igor Mammedov wrote:  
>>>>>> On Tue, 14 Feb 2017 22:15:43 -0800
>>>>>> ben@skyportsystems.com wrote:
>>>>>>     
>>>>>>> From: Ben Warren <ben@skyportsystems.com>
>>>>>>>
>>>>>>> This is similar to the existing 'add pointer' functionality, but instead
>>>>>>> of instructing the guest (BIOS or UEFI) to patch memory, it instructs
>>>>>>> the guest to write the pointer back to QEMU via a writeable fw_cfg file.
>>>>>>>
>>>>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>>>>>> ---
>>>>>>>  hw/acpi/bios-linker-loader.c         | 58 ++++++++++++++++++++++++++++++++++--
>>>>>>>  include/hw/acpi/bios-linker-loader.h |  6 ++++
>>>>>>>  2 files changed, 61 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
>>>>>>> index d963ebe..5030cf1 100644
>>>>>>> --- a/hw/acpi/bios-linker-loader.c
>>>>>>> +++ b/hw/acpi/bios-linker-loader.c
>>>>>>> @@ -78,6 +78,19 @@ struct BiosLinkerLoaderEntry {
>>>>>>>              uint32_t length;
>>>>>>>          } cksum;
>>>>>>>  
>>>>>>> +        /*
>>>>>>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
>>>>>>> +         * @dest_file) at @wr_pointer.offset, by adding a pointer to the table
>>>>>>> +         * originating from @src_file. 1,2,4 or 8 byte unsigned
>>>>>>> +         * addition is used depending on @wr_pointer.size.
>>>>>>> +         */    
>>>>>
>>>>> The words "adding" and "addition" are causing confusion here.
>>>>>
>>>>> In all of the previous discussion, *addition* was out of scope from
>>>>> WRITE_POINTER. Again, the firmware is specifically not required to
>>>>> *read* any part of the fw_cfg blob identified by "dest_file".
>>>>>
>>>>> WRITE_POINTER instructs the firmware to return the allocation address of
>>>>> the downloaded "src_file" to QEMU. Any necessary runtime subscripting
>>>>> within "src_file" is to be handled by QEMU code dynamically.
>>>>>
>>>>> For example, consider that "src_file" has *several* fields that QEMU
>>>>> wants to massage; in that case, indexing within QEMU code with field
>>>>> offsets is simply unavoidable.  
>>>> what I don't like here is that this indexing would be rather fragile
>>>> and has to be done in different parts of QEMU /device, AML/.
>>>>
>>>> I'd prefer this helper function to have the same @src_offset
>>>> behavior as ADD_POINTER where patched address could point to
>>>> any part of src_file i.e. not just beginning.  
>>>
>>>
>>>
>>>         /*
>>>          * COMMAND_ADD_POINTER - patch the table (originating from
>>>          * @dest_file) at @pointer.offset, by adding a pointer to the table
>>>          * originating from @src_file. 1,2,4 or 8 byte unsigned
>>>          * addition is used depending on @pointer.size.
>>>          */
>>>  
>>> so the way ADD works is
>>> 	read at offset
>>> 	add table address
>>> 	write result at offset
>>>
>>> in other words it is always beginning of table that is added.
>> more exactly it's, read at 
>>   src_offset = *(dst_blob_ptr+dst_offset)
>>   *(dst_blob+dst_offset) = src_blob_ptr + src_offset
>>
>>> Would the following be acceptable?
>>>
>>>
>>>          * COMMAND_WRITE_POINTER - update the fw_cfg file (originating from
>>>          * @dest_file) at @wr_pointer.offset, by writing a pointer to the table
>>>          * originating from @src_file. 1,2,4 or 8 byte unsigned value
>>>          * is written depending on @wr_pointer.size.
>> it looses 'adding' part of ADD_POINTER command which handles src_offset,
>> however implementing adding part looks a bit complicated
>> as patched blob (dst) is not in guest memory but in QEMU and
>> on reset *(dst_blob+dst_offset) should be reset to src_offset.
>> Considering dst file could be device specific memory (field/blob/whatever)
>> it could be hard to track/notice proper reset behavior.
>>
>> So now I'm not sure if src_offset is worth adding.
> 
> Right. Let's just do this math in QEMU if we have to.

Deal. :)

Thanks
Laszlo
