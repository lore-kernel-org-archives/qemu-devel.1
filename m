Received: from eggs.gnu.org ([2001:4830:134:3::10]:59264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv8N-0007SB-Nf
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1flv8M-00033n-Pi
	for qemu-devel@nongnu.org; Sat, 04 Aug 2018 07:54:11 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-7-lbloch@janustech.com>
	<w51a7q3liy6.fsf@maestria.local.igalia.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <a6b39d5f-90d8-2b04-aa85-fc16cfad93a2@janustech.com>
Date: Sat, 4 Aug 2018 14:53:48 +0300
MIME-Version: 1.0
In-Reply-To: <w51a7q3liy6.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/6] qcow2: Resize the cache
 upon image resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/03/2018 03:42 PM, Alberto Garcia wrote:
> On Sun 29 Jul 2018 11:27:44 PM CEST, Leonid Bloch wrote:
>> The caches are now recalculated upon image resizing. This is done
>> because the new default behavior of assigning a sufficient L2 cache to
>> cover the entire image implies that the cache will still be sufficient
>> after image resizing. To put a limit on the cache, the options
>> cache-size and l2-cache-size can be used.
>>
>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>> ---
>>   block/qcow2.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 74f2cb10a4..06fac1bb8c 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3656,6 +3656,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>>       }
>>   
>>       s->l1_vm_state_index = new_l1_size;
>> +    /* Update cache sizes */
>> +    QDict *options = qdict_clone_shallow(bs->options);
>> +    ret = qcow2_update_options(bs, options, s->flags, errp);
>> +    if (ret < 0) {
>> +        goto fail;
>> +    }
> 
> Perhaps this could be merged with the "Update total_sectors when
> resizing" patch. When you put both changes together it is quite clear
> why you need to update bs->total_sectors, and doing it is only necessary
> if you want to do this afterwards.

Indeed. I agree.

Leonid.

> 
> Berto
> 
