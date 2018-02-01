Received: from eggs.gnu.org ([2001:4830:134:3::10]:49391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehEgX-0005Rp-Pt
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehEgT-0006XO-NU
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:13:49 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
	<c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
Date: Thu, 01 Feb 2018 14:13:01 +0100
Message-ID: <w51r2q46eg2.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed 31 Jan 2018 09:07:48 PM CET, Max Reitz wrote:
> On 2018-01-26 15:59, Alberto Garcia wrote:
>> This patch updates l2_allocate() to support the qcow2 cache returning
>> L2 slices instead of full L2 tables.
>> 
>> The old code simply gets an L2 table from the cache and initializes it
>> with zeroes or with the contents of an existing table. With a cache
>> that returns slices instead of tables the idea remains the same, but
>> the code must now iterate over all the slices that are contained in an
>> L2 table.
>> 
>> Since now we're operating with slices the function can no longer
>> return the newly-allocated table, so it's up to the caller to retrieve
>> the appropriate L2 slice after calling l2_allocate() (note that with
>> this patch the caller is still loading full L2 tables, but we'll deal
>> with that in a separate patch).
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2-cluster.c | 56 +++++++++++++++++++++++++++++++--------------------
>>  1 file changed, 34 insertions(+), 22 deletions(-)
>> 
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 57349928a9..2a53c1dc5f 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -264,11 +264,12 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
>>   *
>>   */
>>  
>> -static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
>> +static int l2_allocate(BlockDriverState *bs, int l1_index)
>>  {
>>      BDRVQcow2State *s = bs->opaque;
>>      uint64_t old_l2_offset;
>> -    uint64_t *l2_table = NULL;
>> +    uint64_t *l2_slice = NULL;
>> +    unsigned slice, slice_size2, n_slices;
>
> I'd personally prefer size_t, but oh well.

I don't see any reason not to use int / unsigned. The size of a slice is
always <= cluster_size (an int), and both slice and n_slices are smaller
than that.

> However, I'm wondering whether this is the best approach.  The old L2
> table is probably not going to be used after this function, so we're
> basically polluting the cache here.  That was bad enough so far, but
> now that actually means wasting multiple cache entries on it.
>
> Sure, the code is simpler this way.  But maybe it would still be
> better to manually copy the data over from the old offset...  (As long
> as it's not much more complicated.)

You mean bypassing the cache altogether?

    qcow2_cache_flush(bs, s->l2_table_cache);
    new_table = g_malloc(s->cluster_size);
    if (old_l2_offset & L1E_OFFSET_MASK) {
        bdrv_pread(bs->file, old_l2_offset, new_table, s->cluster_size);
    } else {
        memset(new_table, 0, s->cluster_size);
    }
    bdrv_pwrite(bs->file, new_l2_offset, new_table, s->cluster_size);
    g_free(new_table);

??

Berto
