Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D99C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6009A24DB6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 05:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6009A24DB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45990 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY23U-00027s-NJ
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 01:32:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY20c-0000Lx-6m
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hY1tz-00015q-7m
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:22:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:3740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hY1ty-00013O-Vq
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 01:22:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 22:22:24 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2019 22:22:23 -0700
Date: Tue, 4 Jun 2019 13:21:55 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190604052154.GA28779@richard>
References: <20190604002810.12869-1-richardw.yang@linux.intel.com>
	<20190604035124.GA15459@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604035124.GA15459@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v2] migratioin/ram: leave RAMBlock->bmap
 blank on allocating
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 11:51:24AM +0800, Peter Xu wrote:
>On Tue, Jun 04, 2019 at 08:28:10AM +0800, Wei Yang wrote:
>> During migration, we would sync bitmap from ram_list.dirty_memory to
>> RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
>> 
>> Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
>> means at the first round this sync is meaningless and is a duplicated
>> work.
>> 
>> Leaving RAMBlock->bmap blank on allocating would have a side effect on
>> migration_dirty_pages, since it is calculated from the result of
>> cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
>> set migration_dirty_pages to 0 in ram_state_init().
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> ---
>> v2: add a comment explaining why leaving RAMBlock.bmap clear
>> ---
>>  migration/ram.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 4c60869226..e9a27ea5e6 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -3181,12 +3181,7 @@ static int ram_state_init(RAMState **rsp)
>>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>>  
>> -    /*
>> -     * Count the total number of pages used by ram blocks not including any
>> -     * gaps due to alignment or unplugs.
>> -     */
>> -    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>> -
>
>Since you've spent time discovering this relationship, we can also
>comment on this too to hint future readers:
>
>       /*
>        * This must match with the initial values of dirty bitmap.
>        * Currently we initialize the dirty bitmap to all zeros so
>        * here the total dirty page count is zero.
>        */
>

You are right.

>> +    (*rsp)->migration_dirty_pages = 0;
>>      ram_state_reset(*rsp);
>>  
>>      return 0;
>> @@ -3201,8 +3196,15 @@ static void ram_list_init_bitmaps(void)
>>      if (ram_bytes_total()) {
>>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>>              pages = block->max_length >> TARGET_PAGE_BITS;
>> +            /*
>> +             * We leave RAMBlock.bmap clear here and they will be sync from
>> +             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
>> +             * migration_bitmap_sync_precopy().
>
>(This sentence is a bit confusing to me)
>
>> +             *
>> +             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to all 1
>> +             * in ram_block_add().
>
>How about:
>
>    The initial dirty bitmap for migration must be set with all ones
>    to make sure we'll migrate every guest RAM page to destination.
>    Here we didn't set RAMBlock.bmap simply because it is already set
>    in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in ram_block_add,
>    and that's where we'll sync the dirty bitmaps.  Here setting
>    RAMBlock.bmap would be fine too but not necessary.
>
>?
>

Sounds better :-)

>> +             */
>>              block->bmap = bitmap_new(pages);
>> -            bitmap_set(block->bmap, 0, pages);
>>              if (migrate_postcopy_ram()) {
>>                  block->unsentmap = bitmap_new(pages);
>>                  bitmap_set(block->unsentmap, 0, pages);
>> -- 
>> 2.19.1
>> 
>
>Regards,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

