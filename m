Received: from eggs.gnu.org ([2001:4830:134:3::10]:48290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dGjHX-0004qC-Cm
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dGjHU-0004LI-9w
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 05:54:11 -0400
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<20170531144331.30173-2-pbutsykin@virtuozzo.com>
	<20170601144106.GF4987@noname.redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <7a88366b-7520-5e37-60e7-8ea307ff9be3@virtuozzo.com>
Date: Fri, 2 Jun 2017 12:53:42 +0300
MIME-Version: 1.0
In-Reply-To: <20170601144106.GF4987@noname.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: add reduce image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com



On 01.06.2017 17:41, Kevin Wolf wrote:
> Am 31.05.2017 um 16:43 hat Pavel Butsykin geschrieben:
>> This patch adds the reduction of the image file for qcow2. As a result, this
>> allows us to reduce the virtual image size and free up space on the disk without
>> copying the image. Image can be fragmented and reduction is done by punching
>> holes in the image file.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   block/qcow2-cache.c    |  8 +++++
>>   block/qcow2-cluster.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2-refcount.c | 65 +++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c          | 40 ++++++++++++++++++------
>>   block/qcow2.h          |  4 +++
>>   qapi/block-core.json   |  4 ++-
>>   6 files changed, 193 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
>> index 1d25147392..da55118ca7 100644
>> --- a/block/qcow2-cache.c
>> +++ b/block/qcow2-cache.c
>> @@ -411,3 +411,11 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
>>       assert(c->entries[i].offset != 0);
>>       c->entries[i].dirty = true;
>>   }
>> +
>> +void qcow2_cache_entry_mark_clean(BlockDriverState *bs, Qcow2Cache *c,
>> +     void *table)
>> +{
>> +    int i = qcow2_cache_get_table_idx(bs, c, table);
>> +    assert(c->entries[i].offset != 0);
>> +    c->entries[i].dirty = false;
>> +}
> 
> This is an interesting function. We can use it whenever we're not
> interested in the content of the table any more. However, we still keep
> that data in the cache and may even evict other tables before this one.
> The data in the cache also becomes inconsistent with the data in the
> file, which should not be a problem in theory (because nobody should be
> using it), but it surely could be confusing when debugging something in
> the cache.
> 

Good idea!

> We can easily improve this a little: Make it qcow2_cache_discard(), a
> function that gets a cluster offset, asserts that a table at this
> offset isn't in use (not cached or ref == 0), and then just directly
> drops it from the cache. This can be called from update_refcount()
> whenever a refcount goes to 0, immediately before or after calling
> update_refcount_discard() - those two are closely related. Then this
> would automatically also be used for L2 tables.
> 

Did I understand correctly? Every time we need to check the incoming
offset to make sure it is offset to L2/refcount table (not to the guest 
data) ?

> Adding this mechanism could be a patch of its own
...
> 
> Kevin
> 
