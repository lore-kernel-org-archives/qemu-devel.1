Received: from eggs.gnu.org ([2001:4830:134:3::10]:55947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdHE-00072N-C9
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehdGA-00070A-AQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:29:20 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <003a82eb-6444-9f5e-e6b0-1cc7cf45d98c@redhat.com>
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
	<c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
	<w51r2q46eg2.fsf@maestria.local.igalia.com>
	<d81eae0f-1481-9dd3-0df9-40063c215784@virtuozzo.com>
	<w511si467gu.fsf@maestria.local.igalia.com>
	<003a82eb-6444-9f5e-e6b0-1cc7cf45d98c@redhat.com>
Date: Fri, 02 Feb 2018 09:08:45 +0100
Message-ID: <w51efm3vmnm.fsf@maestria.local.igalia.com>
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
To: Max Reitz <mreitz@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org

On Thu 01 Feb 2018 07:22:16 PM CET, Max Reitz wrote:
> On 2018-02-01 16:43, Alberto Garcia wrote:
>> On Thu 01 Feb 2018 04:23:09 PM CET, Anton Nefedov wrote:
>>>>> However, I'm wondering whether this is the best approach.  The old
>>>>> L2 table is probably not going to be used after this function, so
>>>>> we're basically polluting the cache here.  That was bad enough so
>>>>> far, but now that actually means wasting multiple cache entries on
>>>>> it.
>>>>>
>>>>> Sure, the code is simpler this way.  But maybe it would still be
>>>>> better to manually copy the data over from the old offset...  (As
>>>>> long as it's not much more complicated.)
>>>>
>>>> You mean bypassing the cache altogether?
>>>>
>>>>      qcow2_cache_flush(bs, s->l2_table_cache);
>>>>      new_table = g_malloc(s->cluster_size);
>>>>      if (old_l2_offset & L1E_OFFSET_MASK) {
>>>>          bdrv_pread(bs->file, old_l2_offset, new_table, s->cluster_size);
>>>>      } else {
>>>>          memset(new_table, 0, s->cluster_size);
>>>>      }
>>>>      bdrv_pwrite(bs->file, new_l2_offset, new_table, s->cluster_size);
>>>>      g_free(new_table);
>>>>
>>>> ??
>>>
>>> (I know it's a draft so you probably just skipped that but just in
>>> case) It seems ok to bypass the cache read - perhaps even a flush is
>>> not necessary: old_l2_offset must be read-only and flushed at this
>>> point; I believe new_l2_offset might be cached too, so it needs to be
>>> updated.
>> 
>> One problem I see with this is that while we wouldn't pollute the cache
>> we'd always be reading the table twice from disk in all cases:
>> 
>>  1) Read old table
>>  2) Write new table
>>  3) Read new table (after l2_allocate(), using the cache this time)
>> 
>> We can of course improve it by reading the old table from disk but
>> directly in the cache -so we'd spare step (3)-, but we'd still have to
>> read at least once from disk.
>> 
>> With the old code (especially if slice_size == cluster_size) we don't
>> need to read anything if the L2 table is already cached:
>> 
>>  1) Get empty table from the cache
>>  2) memcpy() the old data
>>  3) Get new table from the cache (after l2_allocate()).
>
> Well, then scratch the bdrv_pwrite() for the new table and keep using
> the cache for that (because that actually sounds useful).
>
> On second thought, though, it's rather probable the old L2 table is
> already in the cache...  Before the guest does a write to a location,
> it is reasonable to assume it has read from there before.
>
> So I guess we could think about adding a parameter to qcow2_cache_put()
> or something to reset the LRU counter because we probably won't need
> that entry anymore.  But not something for this series, of course.

That actually doesn't sound like a bad idea, there are maybe more cases
in which we know we're unlikely to need a cache entry soon, but as you
say let's take a look at it after this series.

Berto
