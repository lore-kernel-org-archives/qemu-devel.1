Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC49C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 03:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3570B2507F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 03:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3570B2507F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY0V0-0002yC-Bi
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 23:52:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hY0U8-0002b2-Dz
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 23:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hY0U6-0001wC-Dv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 23:51:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hY0U4-0001q7-Cf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 23:51:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3A21812B43;
	Tue,  4 Jun 2019 03:51:30 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2AEE5C28D;
	Tue,  4 Jun 2019 03:51:26 +0000 (UTC)
Date: Tue, 4 Jun 2019 11:51:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190604035124.GA15459@xz-x1>
References: <20190604002810.12869-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604002810.12869-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 04 Jun 2019 03:51:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 08:28:10AM +0800, Wei Yang wrote:
> During migration, we would sync bitmap from ram_list.dirty_memory to
> RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
> 
> Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
> means at the first round this sync is meaningless and is a duplicated
> work.
> 
> Leaving RAMBlock->bmap blank on allocating would have a side effect on
> migration_dirty_pages, since it is calculated from the result of
> cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
> set migration_dirty_pages to 0 in ram_state_init().
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> ---
> v2: add a comment explaining why leaving RAMBlock.bmap clear
> ---
>  migration/ram.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 4c60869226..e9a27ea5e6 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3181,12 +3181,7 @@ static int ram_state_init(RAMState **rsp)
>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>  
> -    /*
> -     * Count the total number of pages used by ram blocks not including any
> -     * gaps due to alignment or unplugs.
> -     */
> -    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
> -

Since you've spent time discovering this relationship, we can also
comment on this too to hint future readers:

       /*
        * This must match with the initial values of dirty bitmap.
        * Currently we initialize the dirty bitmap to all zeros so
        * here the total dirty page count is zero.
        */

> +    (*rsp)->migration_dirty_pages = 0;
>      ram_state_reset(*rsp);
>  
>      return 0;
> @@ -3201,8 +3196,15 @@ static void ram_list_init_bitmaps(void)
>      if (ram_bytes_total()) {
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
> +            /*
> +             * We leave RAMBlock.bmap clear here and they will be sync from
> +             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
> +             * migration_bitmap_sync_precopy().

(This sentence is a bit confusing to me)

> +             *
> +             * ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to all 1
> +             * in ram_block_add().

How about:

    The initial dirty bitmap for migration must be set with all ones
    to make sure we'll migrate every guest RAM page to destination.
    Here we didn't set RAMBlock.bmap simply because it is already set
    in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in ram_block_add,
    and that's where we'll sync the dirty bitmaps.  Here setting
    RAMBlock.bmap would be fine too but not necessary.

?

> +             */
>              block->bmap = bitmap_new(pages);
> -            bitmap_set(block->bmap, 0, pages);
>              if (migrate_postcopy_ram()) {
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
> -- 
> 2.19.1
> 

Regards,

-- 
Peter Xu

