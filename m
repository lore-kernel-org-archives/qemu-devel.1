Received: from eggs.gnu.org ([2001:4830:134:3::10]:36209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1cRtjF-0007js-6C
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1cRtjE-0008N0-1v
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:44:41 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1cRtjD-0008Mf-Ra
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 23:44:39 -0500
Received: by mail-it0-x243.google.com with SMTP id o185so4021369itb.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 20:44:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bc3c8207-f788-7f23-8f8a-1663bc5a9e8a@linux.vnet.ibm.com>
References: <1470744604-80857-1-git-send-email-jiangshanlai@gmail.com>
	<87bn11ov1p.fsf@emacs.mitica>
	<CAJhGHyA=n1exdiP03OWctrCpD0wKxz1jH5i=fLsaoEO44NBUEg@mail.gmail.com>
	<bc3c8207-f788-7f23-8f8a-1663bc5a9e8a@linux.vnet.ibm.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Fri, 13 Jan 2017 12:44:38 +0800
Message-ID: <CAJhGHyC0Jfjd8yzVc3qCoafX_yPFT3+pNkQrgvms3eKfCVGefA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] add migration capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jianjun Duan <duanj@linux.vnet.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 13, 2017 at 3:19 AM, Jianjun Duan <duanj@linux.vnet.ibm.com> wrote:
> I have a question related to interplay of bypassing the shared memory in
> migration and memory hotplugging. If on the source guest a big chunk of
> memory is plugged in, will the shared memory still be mapped the same
> way on the guest? i.e, the mapping from guest physical address to the
> host virtual address be the same?

I don't understand the question, the patch doesn't change
the memory hotplugging nor the way how the pages are mapped
in the guest physical.

>
> Thanks,
> Jianjun
>
>
> On 08/29/2016 09:11 PM, Lai Jiangshan wrote:
>> On Wed, Aug 10, 2016 at 5:03 PM, Juan Quintela <quintela@redhat.com> wrote:
>>> Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>>>
>>> Hi
>>>
>>> First of all, I like a lot the patchset, but I would preffer to split it
>>> to find "possible" bugs along the lines, especially in postcopy, but not only.
>>
>> Hello, thanks for review and comments
>>
>> I tried to make the patch be sane and tight.
>> I don't see any strong reason to split it without complicating the patch.
>>
>>>
>>> [very nice description of the patch]
>>>
>>> Nothing to say about the QMP and shared memory detection, looks correct
>>> to me.
>>>
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 815bc0e..880972d 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -605,6 +605,28 @@ static void migration_bitmap_sync_init(void)
>>>>      num_dirty_pages_period = 0;
>>>>      xbzrle_cache_miss_prev = 0;
>>>>      iterations_prev = 0;
>>>> +    migration_dirty_pages = 0;
>>>> +}
>>>> +
>>>> +static void migration_bitmap_init(unsigned long *bitmap)
>>>> +{
>>>> +    RAMBlock *block;
>>>> +
>>>> +    bitmap_clear(bitmap, 0, last_ram_offset() >> TARGET_PAGE_BITS);
>>>> +    rcu_read_lock();
>>>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>>>> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
>>>> +            bitmap_set(bitmap, block->offset >> TARGET_PAGE_BITS,
>>>> +                       block->used_length >> TARGET_PAGE_BITS);
>>>> +
>>>> +            /*
>>>> +             * Count the total number of pages used by ram blocks not including
>>>> +             * any gaps due to alignment or unplugs.
>>>> +             */
>>>> +         migration_dirty_pages += block->used_length >> TARGET_PAGE_BITS;
>>>> +     }
>>>> +    }
>>>> +    rcu_read_unlock();
>>>>  }
>>>
>>> We can split this function in a different patch.
>>
>> it calls the new function migrate_bypass_shared_memory().
>> it is no a good idea to split it out.
>>
>>> I haven't fully search
>>> if we care about taking the rcu lock here.  The thing that I am more
>>> interested is in knowing what happens when we don't set
>>> migration_dirty_pages as the full "possible" memory pages.
>>
>> I hadn't tested it with postcopy, I don't know how to use postcopy.
>> From my review I can't find obvious bugs about it.
>>
>> I don't think there is any good reason to use migrate_bypass
>> and postcopy together,  I can disable the migrate_bypass
>> when postcopy==true if you want.
>>
>>>
>>> Once here, should we check for ROM regions?
>>>
>>> BTW, could'nt we use:
>>>
>>> int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
>>> {
>>>     RAMBlock *block;
>>>     int ret = 0;
>>>
>>>     rcu_read_lock();
>>>     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>>>         ret = func(block->idstr, block->host, block->offset,
>>>                    block->used_length, opaque);
>>>         if (ret) {
>>>             break;
>>>         }
>>>     }
>>>     rcu_read_unlock();
>>>     return ret;
>>> }
>>>
>>
>> the patch only introduces only one "QLIST_FOREACH_RCU(ram_list.blocks)"
>> but
>> # git grep 'QLIST_FOREACH_RCU.*ram_list'  | wc -l
>> #       16
>>
>> I don't want to introduce qemu_ram_foreach_block()
>> and touch another 15 places.
>> I hope someone do it after merged.
>>
>>
>>>
>>>
>>>>
>>>>  static void migration_bitmap_sync(void)
>>>> @@ -631,7 +653,9 @@ static void migration_bitmap_sync(void)
>>>>      qemu_mutex_lock(&migration_bitmap_mutex);
>>>>      rcu_read_lock();
>>>>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>>>> -        migration_bitmap_sync_range(block->offset, block->used_length);
>>>> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
>>>> +            migration_bitmap_sync_range(block->offset, block->used_length);
>>>> +        }
>>>>      }
>>>>      rcu_read_unlock();
>>>>      qemu_mutex_unlock(&migration_bitmap_mutex);
>>>
>>> Oops, another place where we were not using qemu_ram_foreach_block :p
>>>
>>>
>>>> @@ -1926,19 +1950,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>>>      ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>>>>      migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>>>>      migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
>>>> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
>>>> +    migration_bitmap_init(migration_bitmap_rcu->bmap);
>>>>
>>>>      if (migrate_postcopy_ram()) {
>>>>          migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
>>>> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
>>>> +        bitmap_copy(migration_bitmap_rcu->unsentmap,
>>>> +                 migration_bitmap_rcu->bmap, ram_bitmap_pages);
>>>>      }
>>>
>>> I think that if we go this route, we should move the whole if inside the
>>> migration_bitmap_init?
>>
>> good! I will do it when I update the patch.
>>
>> Thanks,
>> Lai
>>
>>>
>>>>
>>>> -    /*
>>>> -     * Count the total number of pages used by ram blocks not including any
>>>> -     * gaps due to alignment or unplugs.
>>>> -     */
>>>> -    migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>>>> -
>>>>      memory_global_dirty_log_start();
>>>>      migration_bitmap_sync();
>>>>      qemu_mutex_unlock_ramlist();
>>>
>>>
>>> As said, very happy with the patch.  And it got much simpler that I
>>> would have expected.
>>>
>>> Thanks, Juan.
>>
>
