Received: from eggs.gnu.org ([2001:4830:134:3::10]:41684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvEF-0006v3-B8
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYvEE-0003Da-8T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 11:22:31 -0400
References: <20180628190723.276458-1-eblake@redhat.com>
	<20180628190723.276458-4-eblake@redhat.com>
	<20180629084444.GC15588@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41be61a0-9048-c08f-1a9a-1c213f5103ef@redhat.com>
Date: Fri, 29 Jun 2018 10:22:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180629084444.GC15588@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/6] qcow2: Reduce REFT_OFFSET_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org, berto@igalia.com

On 06/29/2018 03:44 AM, Kevin Wolf wrote:
> Am 28.06.2018 um 21:07 hat Eric Blake geschrieben:
>> Match our code to the spec change in the previous patch - there's
>> no reason for the refcount table to allow larger offsets than the
>> L1/L2 tables.
> 
> What about internal snapshots? And anyway, because of the metadata
> overhead, the physical image size of a fully allocated image is always
> going to be at least minimally larger than the virtual disk size.
> 
> I'm not necessarily opposed to making the change if there is a good
> reason to make it, but I don't see a real need for it and the
> justification used here and also in the previous patch is incorrect.

The fact that ext4 cannot hold an image this large is already an 
indication that setting this limit on the refcount table is NOT going to 
bite real users.

Yes, you can argue that with lots of metadata, including internal 
snapshots, and on a capable file system (such as tmpfs) that can even 
hold files this large to begin with, then yes, allowing the refcount to 
exceed this limit will allow slightly more metadata to be crammed into a 
single image.  But will it actually help anyone?

Do I need to respin the series to split patch 2 into the obvious changes 
(stuff unrelated to capping refcount size) vs. the controversial stuff 
(refcount cap and this code change)?

> 
> Kevin
> 
>> In practice, no image has more than 64PB of
>> allocated clusters anyways, as anything beyond that can't be
>> expressed via L2 mappings to host offsets.

If you're opposed to an exact 56-bit limit on the grounds that 56-bit 
guest data plus minimal metadata should still be expressable, would it 
be better to cap refcount at 57-bits?

>>
>> Suggested-by: Alberto Garcia <berto@igalia.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>>

>> +++ b/block/qcow2.h
>> @@ -439,7 +439,7 @@ typedef enum QCow2MetadataOverlap {
>>   #define L2E_OFFSET_MASK 0x00fffffffffffe00ULL
>>   #define L2E_COMPRESSED_OFFSET_SIZE_MASK 0x3fffffffffffffffULL
>>
>> -#define REFT_OFFSET_MASK 0xfffffffffffffe00ULL
>> +#define REFT_OFFSET_MASK 0x00fffffffffffe00ULL
>>
>>   static inline int64_t start_of_cluster(BDRVQcow2State *s, int64_t offset)
>>   {
>> -- 
>> 2.14.4
>>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
