Received: from eggs.gnu.org ([2001:4830:134:3::10]:42149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZeAr-0003M6-8R
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZeAn-0002Q7-3F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:17:29 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZeAm-0002O1-PF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:17:25 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v105so76620216wrb.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 07:17:23 -0700 (PDT)
References: <20170721172832.GI2133@work-vm> <20170721190755.GA2981@work-vm>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170721190755.GA2981@work-vm>
Date: Mon, 24 Jul 2017 15:17:20 +0100
Message-ID: <87y3rddimn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] dirty page count problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: haozhong.zhang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, lvivier@redhat.com, quintela@redhat.com


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
>> Hi,
>>   Git bisect is pointing to your patch 084140bd49:
>>   exec: fix access to ram_list.dirty_memory when sync dirty bitmap
>>
>> trying to diagnose a bug I'm seeing; it looks like the dirty page count
>> is wrong for some reason.
>>
>> Alex Bennée spotted a problem where the postcopy test would occasionally
>> fail under very heavy load;    attaching a debugger and it looks like
>> the problem is we have a migration_dirty_page count stuck at 2;
>> in the normal migration tests we don't spot this, because 2 pages is
>> smaller than the threshold to end migration and so an extra 2 pages
>> doesn't block it finishing.   However, with a very
>> small downtime setting (like we use in the postcopy test) and with
>> very low bandwidth (as when Alex ran the test on a very heavily loaded
>> machine) we end up never calling the bitmap sync again and never
>> completing the iteration.
>>
>> I'm using the following addition to spot the problem:
>
> I think I have the fix for this, or at least the reason; the alignment
> check also needs fixing up, but the 08414 patch missed it.
>
>   Alex: Please test the fix included at the bottom
>
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e75f1050e4..3ddf884952 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1350,6 +1350,13 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>>          }
>>      } while (!pages && again);
>>
>> +    if (!pages && !again && pss.complete_round && rs->migration_dirty_pages)
>> +    {
>> +        /* Should make this fail migration ? */
>> +        fprintf(stderr, "%s: no page found, yet dirty_pages=%"PRIu64"\n",
>> +                __func__, rs->migration_dirty_pages);
>> +    }
>> +
>>      rs->last_seen_block = pss.block;
>>      rs->last_page = pss.page;
>>
>> (which I might add as a test to fail a migration)
>>
>> That test fails easily even on an unloaded machine:
>> tests/postcopy-test
>> /x86_64/postcopy: ram_find_and_save_block: no page found, yet dirty_pages=2
>> ram_find_and_save_block: no page found, yet dirty_pages=2
>> ram_find_and_save_block: no page found, yet dirty_pages=2
>> OK
>>
>>
>> I'll try and debug where our extra two pages are coming from.
>
> From b2c86818eaaaf790246f21ae21fead903c1d64f0 Mon Sep 17 00:00:00 2001
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Date: Fri, 21 Jul 2017 19:59:01 +0100
> Subject: [PATCH] cpu_physical_memory_sync_dirty_bitmap: Fix alignment check
>
> This code has an optimised, word aligned version, and a boring
> unaligned version.  Recently 084140bd498909 fixed a missing offset
> addition from the core of both versions.  However, the offset isn't
> necessarily aligned and thus the choice between the two versions
> needs fixing up to also include the offset.
>
> DANGER: Friday evening, post-dinner lightly tested patch.
>
> Symptom:
>   A few stuck unsent pages during migration; not normally noticed
> unless under very low bandwidth.
>
> Fixes: 084140bd498909
> ---
>  include/exec/ram_addr.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index c04f4f6..c802f7f 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -378,15 +378,16 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>  {
>      ram_addr_t addr;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> +    unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
>
>      /* start address is aligned at the start of a word? */
> -    if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) == start) {
> +    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) ==
> +         (start + rb->offset)) {
>          int k;
>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>          unsigned long * const *src;
> -        unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
>          unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
>          unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
>                                          DIRTY_MEMORY_BLOCK_SIZE);
> --
> 1.8.3.1
>
>> Dave
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

I saw no hangs, there where 4 times it failed but that might be another
test crashing. I'm investigating that so a cautious:

Tested-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
