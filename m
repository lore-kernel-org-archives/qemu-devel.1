Received: from eggs.gnu.org ([2001:4830:134:3::10]:35614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzwH-0002YD-Pl
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyzwG-0002uF-Os
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 09:07:29 -0400
References: <20180322062447.16537-1-yuchenlin@synology.com>
	<20180322074129.GF26618@lemon.usersys.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <721c2816-c64b-a373-9a33-840778145bc9@redhat.com>
Date: Thu, 22 Mar 2018 08:07:07 -0500
MIME-Version: 1.0
In-Reply-To: <20180322074129.GF26618@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: return ERROR when cluster sector
 is larger than vmdk limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, yuchenlin@synology.com
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu block <qemu-block@nongnu.org>

On 03/22/2018 02:41 AM, Fam Zheng wrote:
> On Thu, 03/22 14:24, yuchenlin@synology.com wrote:
>> From: yuchenlin <yuchenlin@synology.com>
>>
>> VMDK has a hard limitation of extent size, which is due to the size of grain
>> table entry is 32 bits. It means it can only point to a grain located at
>> offset = 2^32. To avoid writing the user data beyond limitation and record a useless offset
>> in grain table. We should return ERROR here.
>>
>> Signed-off-by: yuchenlin <yuchenlin@synology.com>
>> ---

>> +++ b/block/vmdk.c
>> @@ -47,6 +47,8 @@
>>   #define VMDK4_FLAG_MARKER (1 << 17)
>>   #define VMDK4_GD_AT_END 0xffffffffffffffffULL
>>   
>> +#define VMDK_EXTENT_MAX_SECTORS (4294967296)
>> +

Hmm, with sectors instead of bytes, you don't want to use Phillipe's '2 
* T_BYTE' macro after all; but it would still look better spelled as 
'(1ULL << 32)' or '(4ULL * 1024 * 1024 * 1024)'.  Most importantly, 
since the value does NOT fit in a 32-bit unsigned integer, I think you 
NEED to use the ULL suffix to make your intent clear.

>>   #define VMDK_GTE_ZEROED 0x1
>>   
>>   /* VMDK internal error codes */
>> @@ -1250,6 +1252,10 @@ static int get_cluster_offset(BlockDriverState *bs,
>>               return zeroed ? VMDK_ZEROED : VMDK_UNALLOC;
>>           }
>>   
>> +        if (extent->next_cluster_sector >= VMDK_EXTENT_MAX_SECTORS) {
>> +            return VMDK_ERROR;
>> +        }
>> +
>>           cluster_sector = extent->next_cluster_sector;
>>           extent->next_cluster_sector += extent->cluster_sectors;
>>   
>> -- 
>> 2.16.2
>>
> 
> Cc'ing Kevin and Max who merge block/ patches.

Also, CC'ing qemu-block, as all block-related patches should go through 
there.

> 
> Reviewed-by: Fam Zheng <famz@redhat.com>
> 
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
