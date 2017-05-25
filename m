Received: from eggs.gnu.org ([2001:4830:134:3::10]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDwAa-00048S-IW
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDwAX-0006Ze-Dz
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:03:28 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:10414 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDwAX-0006Ya-30
	for qemu-devel@nongnu.org; Thu, 25 May 2017 13:03:25 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-2-vsementsov@virtuozzo.com>
	<3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <28332b32-f9e8-d426-9b54-d46e5774366c@virtuozzo.com>
Date: Thu, 25 May 2017 20:03:15 +0300
MIME-Version: 1.0
In-Reply-To: <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

25.05.2017 19:32, Eric Blake wrote:
> On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Current comment is not clear enough: which sparseness is meant, coming
>> from sparse image format or from sparse file system?
>>
>> For example, if we have qcow2 above raw file on non-sparse file system,
>> this function will say nothing about unallocated (by qcow2 layer)
>> clusters.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 50ba264143..ba22fc0dfb 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3388,8 +3388,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, Error **errp)
>>   }
>>   
>>   /**
>> - * Length of a allocated file in bytes. Sparse files are counted by actual
> Yay for getting rid of bad grammar (s/a /an /)
>
>> - * allocated space. Return < 0 if error or unknown.
>> + * Size of allocated in underlying file system area. Sparseness is taken into
> Doesn't read well.  Maybe: s/Size of allocated/Allocation size/ ?
>
>> + * account for sparse file systems. Return < 0 if error or unknown.
> I still don't get what we are trying to present.
>
> If we have the following 6 qcow2 file clusters backed by the underlying
> lseek(SEEK_DATA/HOLE) file system contents:
>
> BDRV_BLOCK_UNALLOCATED   N/A
> BDRV_BLOCK_ZERO_PLAIN    N/A
> BDRV_BLOCK_ZERO_ALLOC    hole
> BDRV_BLOCK_ZERO_ALLOC    data
> BDRV_BLOCK_DATA          hole
> BDRV_BLOCK_DATA          data
>
> Then is our answer the size of all qcow2 allocations regardless of
> underlying status (4, due to clusters 3-6), or the size of only the
> clusters that read from the backing file (2, due to clusters 5-6), or
> the size of only the clusters that currently occupy space in the file
> system (2, due to clusters 4 and 6), or the size of clusters that are
> not provably read-as-zero (1, due to cluster 6)?
>
> Does the answer change if you can have underlying holes happen at a
> smaller granularity than clusters?
>
> What happens for compressed clusters?
>
> I think we still need to do a better job at writing a precise comment.
>

bdrv_get_allocated_file_size is not related to qcow2, as qcow2 doesn't 
support it. So, it is finally just raw_get_allocated_file_size, which 
returns st.st_blocks * 512 after fstat(s->fd).

It will correspond to qcow2 sparseness if qcow2 discarded corresponding 
clusters in bs->file and if underlying fs is sparse.



-- 
Best regards,
Vladimir
