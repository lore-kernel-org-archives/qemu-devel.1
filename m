Received: from eggs.gnu.org ([2001:4830:134:3::10]:38320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2b7-0001JO-HA
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dO2b2-0005q9-TM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 09:56:37 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-3-pbutsykin@virtuozzo.com>
	<364b26de-e7fa-1a90-ac33-2a444ca281eb@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <e8efe501-49ed-17a8-775f-f436cf7f38a8@virtuozzo.com>
Date: Thu, 22 Jun 2017 16:55:23 +0300
MIME-Version: 1.0
In-Reply-To: <364b26de-e7fa-1a90-ac33-2a444ca281eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 22.06.2017 01:29, Max Reitz wrote:
> On 2017-06-13 14:16, Pavel Butsykin wrote:
>> Whenever l2/refcount table clusters are discarded from the file we can
>> automatically drop unnecessary content of the cache tables. This reduces
>> the chance of eviction useful cache data and eliminates inconsistent data
>> in thecache with the data in the file.
>>
>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>> ---
>>   block/qcow2-cache.c    | 21 +++++++++++++++++++++
>>   block/qcow2-refcount.c |  5 +++++
>>   block/qcow2.h          |  1 +
>>   3 files changed, 27 insertions(+)
>>
>> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
>> index 1d25147392..7931edf237 100644
>> --- a/block/qcow2-cache.c
>> +++ b/block/qcow2-cache.c
>> @@ -411,3 +411,24 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
>>       assert(c->entries[i].offset != 0);
>>       c->entries[i].dirty = true;
>>   }
>> +
>> +void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < c->size; i++) {
>> +        if (c->entries[i].offset == offset) {
>> +            goto found; /* table offset */
>> +        }
>> +    }
>> +    return;
>> +
>> +found:
>> +    assert(c->entries[i].ref == 0);
>> +
>> +    c->entries[i].offset = 0;
>> +    c->entries[i].lru_counter = 0;
>> +    c->entries[i].dirty = false;
>> +
>> +    qcow2_cache_table_release(bs, c, i, 1);
>> +}
>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>> index 7c06061aae..576ab551d6 100644
>> --- a/block/qcow2-refcount.c
>> +++ b/block/qcow2-refcount.c
>> @@ -767,6 +767,11 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
>>           s->set_refcount(refcount_block, block_index, refcount);
>>   
>>           if (refcount == 0 && s->discard_passthrough[type]) {
>> +            qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
> 
> I don't like this very much. It works, but it feels bad.
> 
> Would it be possible to store this refblock's offset somewhere and only
> put it back if @offset is equal to that?
> 
>> +            qcow2_cache_discard(bs, s->refcount_block_cache, offset);
>> +
>> +            qcow2_cache_discard(bs, s->l2_table_cache, offset);
>> +
> 
> So you're blindly calling qcow2_cache_discard() on @offset because
> @offset may be pointing to a refblock or an L2 table? Right, that works,
> but it still deserves a comment, I think (that we have no idea whether
> @offset actually points to any of these refcount structures, but that we
> also just don't have to care).
> 
> Looks OK to me, functionally, but I'd at least like to have that comment.
>

Hmm.. We can split qcow2_cache_discard() and kill two birds with one
stone.

void* qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
                                   uint64_t offset)
{
     int i;

     for (i = 0; i < c->size; i++) {
         if (c->entries[i].offset == offset) {
             return qcow2_cache_get_table_addr(bs, c, i);
         }
     }
     return NULL;
}

void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void table)
{
     int i = qcow2_cache_get_table_idx(bs, c, table);

     assert(c->entries[i].ref == 0);

     c->entries[i].offset = 0;
     c->entries[i].lru_counter = 0;
     c->entries[i].dirty = false;

     qcow2_cache_table_release(bs, c, i, 1);
}

....

if (refcount == 0 && s->discard_passthrough[type]) {
     void *table;

     table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache, 
offset);
     if (table != NULL) {
         qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
         qcow2_cache_discard(bs, s->refcount_block_cache, table);
     }

     table = qcow2_cache_is_table_offset(bs, s->l2_table_cache, offset);
     if (table != NULL) {
         qcow2_cache_discard(bs, s->l2_table_cache, table);
     }
...

> Max
> 
>>               update_refcount_discard(bs, cluster_offset, s->cluster_size);
>>           }
>>       }
>> diff --git a/block/qcow2.h b/block/qcow2.h
>> index 1801dc30dc..07faa6dc78 100644
>> --- a/block/qcow2.h
>> +++ b/block/qcow2.h
>> @@ -597,5 +597,6 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
>>   int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
>>       void **table);
>>   void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
>> +void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset);
>>   
>>   #endif
>>
> 
> 
