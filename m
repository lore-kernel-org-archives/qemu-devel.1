Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6DC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A7926C81
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 16:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A7926C81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWkl7-00086D-LX
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 12:52:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWkjU-0006TD-29
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hWkdO-0000Z6-Ix
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hWkdN-00007B-UA
	for qemu-devel@nongnu.org; Fri, 31 May 2019 12:44:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A49736807;
	Fri, 31 May 2019 16:43:49 +0000 (UTC)
Received: from work-vm (ovpn-117-254.ams2.redhat.com [10.36.117.254])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E38E891CE;
	Fri, 31 May 2019 16:43:40 +0000 (UTC)
Date: Fri, 31 May 2019 17:43:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>, peterx@redhat.com,
	quintela@redhat.com
Message-ID: <20190531164337.GK3169@work-vm>
References: <20190507031703.856-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507031703.856-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 31 May 2019 16:43:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
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

I've looked at this for a while, and I think it's OK, so

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Peter, Juan: Can you just see if there's arny reason this would be bad,
but I think it's actually more sensible than what we have.

Dave
> ---
>  migration/ram.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 95c51109d2..417874707d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3151,12 +3151,7 @@ static int ram_state_init(RAMState **rsp)
>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>  
> -    /*
> -     * Count the total number of pages used by ram blocks not including any
> -     * gaps due to alignment or unplugs.
> -     */
> -    (*rsp)->migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
> -
> +    (*rsp)->migration_dirty_pages = 0;
>      ram_state_reset(*rsp);
>  
>      return 0;
> @@ -3172,7 +3167,6 @@ static void ram_list_init_bitmaps(void)
>          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>              pages = block->max_length >> TARGET_PAGE_BITS;
>              block->bmap = bitmap_new(pages);
> -            bitmap_set(block->bmap, 0, pages);
>              if (migrate_postcopy_ram()) {
>                  block->unsentmap = bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

