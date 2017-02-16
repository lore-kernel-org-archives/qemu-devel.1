Received: from eggs.gnu.org ([2001:4830:134:3::10]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceIgX-0002st-76
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceIgT-0002WI-Ap
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:49:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceIgT-0002Vu-2R
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 04:49:05 -0500
References: <9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<20170215194647-mutt-send-email-mst@kernel.org>
	<20170215192436.2695b9f6@nial.brq.redhat.com>
	<20170215211910-mutt-send-email-mst@kernel.org>
	<20170216092550.0ec11535@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4304fbc3-e0c6-da63-bdf2-877cea62b814@redhat.com>
Date: Thu, 16 Feb 2017 10:49:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170216092550.0ec11535@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com

On 02/16/17 09:25, Igor Mammedov wrote:
> On Wed, 15 Feb 2017 21:34:45 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Wed, Feb 15, 2017 at 07:24:36PM +0100, Igor Mammedov wrote:
>>>> As long as all users pass in 0 though there's a real possibility guests
>>>> will implement this incorrectly.  
>>> We are here to ensure that at least Seabios (I'll review it)
>>> and OVMF (Laszlo would take care of it I suppose) do it right,
>>> and if there are other firmwares, they should do it correctly
>>> as described fix their own bugs later wrt randomly written
>>> implementation.  
>>
>> As long as it's untested, it can always do the wrong thing
>> even if it looks right, or it can bitrot.
>>
>>>> I guess we can put in the offset just
>>>> behind the zero-filled padding we have there.  
>>> I've assumed padding was there to make commands fixed size and give
>>> a room for future extensions  
>>
>> you mean
>>         char pad[124];
>> ?
>>
>> Right. So you can easily add fields, but if you do firmware
>> will just assume it does not know how to handle these
>> commands and skip them.
>>
>>> so hunk changing BiosLinkerLoaderEntry
>>> would look like:
>>>
>>> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
>>> index d963ebe..6983713 100644
>>> --- a/hw/acpi/bios-linker-loader.c
>>> +++ b/hw/acpi/bios-linker-loader.c
>>> @@ -49,6 +49,7 @@ struct BiosLinkerLoaderEntry {
>>>              char file[BIOS_LINKER_LOADER_FILESZ];
>>>              uint32_t align;
>>>              uint8_t zone;
>>> +            uint32_t padding;
>>>          } alloc;
>>>  
>>>          /*
>>> @@ -62,6 +63,7 @@ struct BiosLinkerLoaderEntry {
>>>              char src_file[BIOS_LINKER_LOADER_FILESZ];
>>>              uint32_t offset;
>>>              uint8_t size;
>>> +            uint32_t padding;
>>>          } pointer;
>>>  
>>>          /*
>>> @@ -76,10 +78,25 @@ struct BiosLinkerLoaderEntry {
>>>              uint32_t offset;
>>>              uint32_t start;
>>>              uint32_t length;
>>> +            uint32_t padding;
>>>          } cksum;  
>>
>> why is this necessary?
>>
>>> +        /*
>>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
>>> +         * @dest_file) at @wr_pointer.offset, by writing a pointer to @src_offset
>>> +         * within the table originating from @src_file. 1,2,4 or 8 byte unsigned
>>> +         * addition is used depending on @wr_pointer.size.
>>> +         */
>>> +         struct {
>>> +             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>> +             char src_file[BIOS_LINKER_LOADER_FILESZ];
>>> +             uint32_t dst_offset;
>>> +             uint32_t src_offset;
>>> +             uint8_t size;
>>> +        } wr_pointer;
>>> +
>>>          /* padding */
>>> -        char pad[124];
>>> +        char pad[120];  
>>
>> and this shrinks entry size by 4 bytes. Why?
> so total size won't change, due to +4 to account for src_offest in wr_pointer

To be clear, I still disagree with the introduction of "src_offset"
(please let's discuss that in the other sub-thread). Still I can comment
on this question in isolation:

The individual command structures, and the "pad" field (which is 124
bytes), are all members of a *union*. They all start at offset zero in
the union, and the union's size is determined by the largest member,
plus any additional padding at the end that the compiler wishes to
append. (In this case, becasue we use QEMU_PACKED, the compiler doesn't
do that.)

Therefore, as long as you don't exceed the size of

  char pad[124];

you can extend any of the command structures freely -- "pad" will remain
the largest union member, and thereby dictate the size of the union.

In short, "pad" does not *follow* any of the command structures; they
are all laid over each other, from offset 0 in the union.

(If you are curious about the magic constant 124, that comes from 128
minus the size of the "command" field in the outermost
BiosLinkerLoaderEntry structure. The guiding principle here is that the
outermost BiosLinkerLoaderEntry structure be 128 bytes in size.)

--*--

Again: I disagree with the introduction of "src_offset", and I'd like to
hear your opinion about my counter-argument in the other subthread.

Thanks
Laszlo

> 
>>
>>>      };
>>>  } QEMU_PACKED;
>>>  typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
>>>
>>>    
>>>> I'm mostly concerned we are adding new features to something
>>>> that has been through 25 revisions already.  
>>> It's ABI so it's worth extra effort,  
>>
>> There's always yet another possible enhancement you can add.
>> I see it as a bit of a feature creep frankly.
>>
>>> it looks like only one more revision is left and there is
>>> about a week left to post and merge it.  
>>
>> If we can do it quickly, fine, but I think we should merge ASAP.
>>
> 
