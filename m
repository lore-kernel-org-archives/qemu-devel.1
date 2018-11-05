Received: from eggs.gnu.org ([2001:4830:134:3::10]:35943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZY-0005n7-RP
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gJmZR-0002EN-11
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:38:09 -0500
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
	<1539981546-10596-6-git-send-email-Liam.Merwick@oracle.com>
	<dbd5f2e1-677a-e1d7-f494-c8f7f5d34f75@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <58c7d3a3-670d-90e9-2354-44440868a3e0@oracle.com>
Date: Mon, 5 Nov 2018 21:38:16 +0000
MIME-Version: 1.0
In-Reply-To: <dbd5f2e1-677a-e1d7-f494-c8f7f5d34f75@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/8] block: Fix potential Null pointer
 dereferences in vvfat.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com



On 05/11/18 00:19, Max Reitz wrote:
> On 19.10.18 22:39, Liam Merwick wrote:
>> The calls to find_mapping_for_cluster() may return NULL but it
>> isn't always checked for before dereferencing the value returned.
>> Additionally, add some asserts to cover cases where NULL can't
>> be returned but which might not be obvious at first glance.
>>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> ---
>>   block/vvfat.c | 33 ++++++++++++++++++++++++++++-----
>>   1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index fc41841a5c3c..19f6725054a0 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -100,6 +100,7 @@ static inline void array_free(array_t* array)
>>   /* does not automatically grow */
>>   static inline void* array_get(array_t* array,unsigned int index) {
>>       assert(index < array->next);
>> +    assert(array->pointer);
>>       return array->pointer + index * array->item_size;
>>   }
>>   
>> @@ -108,8 +109,7 @@ static inline int array_ensure_allocated(array_t* array, int index)
>>       if((index + 1) * array->item_size > array->size) {
>>           int new_size = (index + 32) * array->item_size;
>>           array->pointer = g_realloc(array->pointer, new_size);
>> -        if (!array->pointer)
>> -            return -1;
>> +        assert(array->pointer);
> 
> It would make sense to make this function not return any value (because
> it just always returns 0 now), but I fully understand if you don't want
> to mess around with vvfat more than you have to.  (Neither do I.)

It had occurred to me too but wasn't sure if it'd be preferred to roll 
that change in. 3 of the 4 callers ignored the return value already, so 
I bit the bullet and made the change.


> 
>>           memset(array->pointer + array->size, 0, new_size - array->size);
>>           array->size = new_size;
>>           array->next = index + 1;
>> @@ -2261,6 +2261,9 @@ static mapping_t* insert_mapping(BDRVVVFATState* s,
>>       }
>>       if (index >= s->mapping.next || mapping->begin > begin) {
>>           mapping = array_insert(&(s->mapping), index, 1);
>> +        if (mapping == NULL) {
>> +            return NULL;
>> +        }
> 
> array_insert() will never return NULL.


Removed.

> 
>>           mapping->path = NULL;
>>           adjust_mapping_indices(s, index, +1);
>>       }
>> @@ -2428,6 +2431,9 @@ static int commit_direntries(BDRVVVFATState* s,
>>       direntry_t* direntry = array_get(&(s->directory), dir_index);
>>       uint32_t first_cluster = dir_index == 0 ? 0 : begin_of_direntry(direntry);
>>       mapping_t* mapping = find_mapping_for_cluster(s, first_cluster);
>> +    if (mapping == NULL) {
>> +        return -1;
>> +    }
> 
> This should be moved below the declarations that still follow here.

Done. (It resulted in a bit more code rearranging and I had to fix two 
checkpatch warnings in existing code)

> 
>>   
>>       int factor = 0x10 * s->sectors_per_cluster;
>>       int old_cluster_count, new_cluster_count;
> 
> [...]
> 
>> @@ -3193,6 +3215,7 @@ static int enable_write_target(BlockDriverState *bs, Error **errp)
>>   
>>       backing = bdrv_new_open_driver(&vvfat_write_target, NULL, BDRV_O_ALLOW_RDWR,
>>                                      &error_abort);
>> +    assert(backing);
>>       *(void**) backing->opaque = s;
> 
> I personally wouldn't use an assert() here because it's clear that the
> value is dereferenced immediately, so that is the assertion that it is
> non-NULL, but I won't give too much of a fight.
> 
> The thing is, I believe we should write code for humans, not machines.
> Fixing machines to understand what we produce is possible -- fixing
> humans is more difficult.
> 
> On top of that, it would be a bug if NULL is returned and it would be
> good if a static analyzer could catch that case.  Just fully silencing
> it with assert() is not ideal.  Ideal would be if it would know that
> setting &error_abort to any value crashes the program, and could thus
> infer whether this function will actually ever get to return NULL when
> &error_abort has been passed to it.
> 

I'm investigating if the tool's config file syntax can describe that 
error_handle_fatal() exits when particular error_xxx parameters are passed.

I'll drop that assert in any case.

Regards,
Liam


> Max
> 
>>   
>>       bdrv_set_backing_hd(s->bs, backing, &error_abort);
>>
> 
> 
