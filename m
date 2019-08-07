Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4550C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9357322297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9357322297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQsS-0001Fj-Tj
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvQrd-0000pz-Uk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvQrc-0003ZP-6j
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:40:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvQrb-0003Wn-U6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 36042308C21D;
 Wed,  7 Aug 2019 18:40:43 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F0315D9D3;
 Wed,  7 Aug 2019 18:40:42 +0000 (UTC)
Date: Wed, 7 Aug 2019 19:40:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190807184039.GO27871@work-vm>
References: <20190724010721.2146-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724010721.2146-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 07 Aug 2019 18:40:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Patch v2] migration/postcopy: make
 PostcopyDiscardState a static variable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> In postcopy-ram.c, we provide three functions to discard certain
> RAMBlock range:
> 
>   * postcopy_discard_send_init()
>   * postcopy_discard_send_range()
>   * postcopy_discard_send_finish()
> 
> Currently, we allocate/deallocate PostcopyDiscardState for each RAMBlock
> on sending discard information to destination. This is not necessary and
> the same data area could be reused for each RAMBlock.
> 
> This patch defines PostcopyDiscardState a static variable. By doing so:
> 
>   1) avoid memory allocation and deallocation to the system
>   2) avoid potential failure of memory allocation
>   3) hide some details for their users
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Queued

> 
> ---
> v2:
>   * make it a static variable, suggested by Dave
> ---
>  migration/postcopy-ram.c | 70 +++++++++++++++++-----------------------
>  migration/postcopy-ram.h | 13 +++-----
>  migration/ram.c          | 30 +++++++----------
>  3 files changed, 46 insertions(+), 67 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 7b3e198538..cf2400b47e 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1375,22 +1375,16 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
>   *   asking to discard individual ranges.
>   *
>   * @ms: The current migration state.
> - * @offset: the bitmap offset of the named RAMBlock in the migration
> - *   bitmap.
> + * @offset: the bitmap offset of the named RAMBlock in the migration bitmap.
>   * @name: RAMBlock that discards will operate on.
> - *
> - * returns: a new PDS.
>   */
> -PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
> -                                                 const char *name)
> +static PostcopyDiscardState pds = {0};
> +void postcopy_discard_send_init(MigrationState *ms, const char *name)
>  {
> -    PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
> -
> -    if (res) {
> -        res->ramblock_name = name;
> -    }
> -
> -    return res;
> +    pds.ramblock_name = name;
> +    pds.cur_entry = 0;
> +    pds.nsentwords = 0;
> +    pds.nsentcmds = 0;
>  }
>  
>  /**
> @@ -1399,30 +1393,29 @@ PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
>   *   be sent later.
>   *
>   * @ms: Current migration state.
> - * @pds: Structure initialised by postcopy_discard_send_init().
>   * @start,@length: a range of pages in the migration bitmap in the
>   *   RAM block passed to postcopy_discard_send_init() (length=1 is one page)
>   */
> -void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardState *pds,
> -                                unsigned long start, unsigned long length)
> +void postcopy_discard_send_range(MigrationState *ms, unsigned long start,
> +                                 unsigned long length)
>  {
>      size_t tp_size = qemu_target_page_size();
>      /* Convert to byte offsets within the RAM block */
> -    pds->start_list[pds->cur_entry] = start  * tp_size;
> -    pds->length_list[pds->cur_entry] = length * tp_size;
> -    trace_postcopy_discard_send_range(pds->ramblock_name, start, length);
> -    pds->cur_entry++;
> -    pds->nsentwords++;
> +    pds.start_list[pds.cur_entry] = start  * tp_size;
> +    pds.length_list[pds.cur_entry] = length * tp_size;
> +    trace_postcopy_discard_send_range(pds.ramblock_name, start, length);
> +    pds.cur_entry++;
> +    pds.nsentwords++;
>  
> -    if (pds->cur_entry == MAX_DISCARDS_PER_COMMAND) {
> +    if (pds.cur_entry == MAX_DISCARDS_PER_COMMAND) {
>          /* Full set, ship it! */
>          qemu_savevm_send_postcopy_ram_discard(ms->to_dst_file,
> -                                              pds->ramblock_name,
> -                                              pds->cur_entry,
> -                                              pds->start_list,
> -                                              pds->length_list);
> -        pds->nsentcmds++;
> -        pds->cur_entry = 0;
> +                                              pds.ramblock_name,
> +                                              pds.cur_entry,
> +                                              pds.start_list,
> +                                              pds.length_list);
> +        pds.nsentcmds++;
> +        pds.cur_entry = 0;
>      }
>  }
>  
> @@ -1431,24 +1424,21 @@ void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardState *pds,
>   * bitmap code. Sends any outstanding discard messages, frees the PDS
>   *
>   * @ms: Current migration state.
> - * @pds: Structure initialised by postcopy_discard_send_init().
>   */
> -void postcopy_discard_send_finish(MigrationState *ms, PostcopyDiscardState *pds)
> +void postcopy_discard_send_finish(MigrationState *ms)
>  {
>      /* Anything unsent? */
> -    if (pds->cur_entry) {
> +    if (pds.cur_entry) {
>          qemu_savevm_send_postcopy_ram_discard(ms->to_dst_file,
> -                                              pds->ramblock_name,
> -                                              pds->cur_entry,
> -                                              pds->start_list,
> -                                              pds->length_list);
> -        pds->nsentcmds++;
> +                                              pds.ramblock_name,
> +                                              pds.cur_entry,
> +                                              pds.start_list,
> +                                              pds.length_list);
> +        pds.nsentcmds++;
>      }
>  
> -    trace_postcopy_discard_send_finish(pds->ramblock_name, pds->nsentwords,
> -                                       pds->nsentcmds);
> -
> -    g_free(pds);
> +    trace_postcopy_discard_send_finish(pds.ramblock_name, pds.nsentwords,
> +                                       pds.nsentcmds);
>  }
>  
>  /*
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index e3a5cfd2d8..e3dde32155 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -43,10 +43,8 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis);
>  
>  /*
>   * Called at the start of each RAMBlock by the bitmap code.
> - * Returns a new PDS
>   */
> -PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
> -                                                 const char *name);
> +void postcopy_discard_send_init(MigrationState *ms, const char *name);
>  
>  /*
>   * Called by the bitmap code for each chunk to discard.
> @@ -55,15 +53,14 @@ PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
>   * @start,@length: a range of pages in the migration bitmap in the
>   *  RAM block passed to postcopy_discard_send_init() (length=1 is one page)
>   */
> -void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardState *pds,
> -                                 unsigned long start, unsigned long length);
> +void postcopy_discard_send_range(MigrationState *ms, unsigned long start,
> +                                 unsigned long length);
>  
>  /*
>   * Called at the end of each RAMBlock by the bitmap code.
> - * Sends any outstanding discard messages, frees the PDS.
> + * Sends any outstanding discard messages.
>   */
> -void postcopy_discard_send_finish(MigrationState *ms,
> -                                  PostcopyDiscardState *pds);
> +void postcopy_discard_send_finish(MigrationState *ms);
>  
>  /*
>   * Place a page (from) at (host) efficiently
> diff --git a/migration/ram.c b/migration/ram.c
> index ecd10baa43..7b7155a368 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2761,12 +2761,9 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>   *       with the dirtymap; so a '1' means it's either dirty or unsent.
>   *
>   * @ms: current migration state
> - * @pds: state for postcopy
>   * @block: RAMBlock to discard
>   */
> -static int postcopy_send_discard_bm_ram(MigrationState *ms,
> -                                        PostcopyDiscardState *pds,
> -                                        RAMBlock *block)
> +static int postcopy_send_discard_bm_ram(MigrationState *ms, RAMBlock *block)
>  {
>      unsigned long end = block->used_length >> TARGET_PAGE_BITS;
>      unsigned long current;
> @@ -2787,7 +2784,7 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
>          } else {
>              discard_length = zero - one;
>          }
> -        postcopy_discard_send_range(ms, pds, one, discard_length);
> +        postcopy_discard_send_range(ms, one, discard_length);
>          current = one + discard_length;
>      }
>  
> @@ -2813,16 +2810,15 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>      int ret;
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        PostcopyDiscardState *pds =
> -            postcopy_discard_send_init(ms, block->idstr);
> +        postcopy_discard_send_init(ms, block->idstr);
>  
>          /*
>           * Postcopy sends chunks of bitmap over the wire, but it
>           * just needs indexes at this point, avoids it having
>           * target page specific code.
>           */
> -        ret = postcopy_send_discard_bm_ram(ms, pds, block);
> -        postcopy_discard_send_finish(ms, pds);
> +        ret = postcopy_send_discard_bm_ram(ms, block);
> +        postcopy_discard_send_finish(ms);
>          if (ret) {
>              return ret;
>          }
> @@ -2845,11 +2841,9 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>   * @unsent_pass: if true we need to canonicalize partially unsent host pages
>   *               otherwise we need to canonicalize partially dirty host pages
>   * @block: block that contains the page we want to canonicalize
> - * @pds: state for postcopy
>   */
>  static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
> -                                          RAMBlock *block,
> -                                          PostcopyDiscardState *pds)
> +                                          RAMBlock *block)
>  {
>      RAMState *rs = ram_state;
>      unsigned long *bitmap = block->bmap;
> @@ -2910,8 +2904,7 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>                   *     (any partially sent pages were already discarded
>                   *     by the previous unsent_pass)
>                   */
> -                postcopy_discard_send_range(ms, pds, fixup_start_addr,
> -                                            host_ratio);
> +                postcopy_discard_send_range(ms, fixup_start_addr, host_ratio);
>              }
>  
>              /* Clean up the bitmap */
> @@ -2954,18 +2947,17 @@ static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsent_pass,
>   */
>  static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
>  {
> -    PostcopyDiscardState *pds =
> -        postcopy_discard_send_init(ms, block->idstr);
> +    postcopy_discard_send_init(ms, block->idstr);
>  
>      /* First pass: Discard all partially sent host pages */
> -    postcopy_chunk_hostpages_pass(ms, true, block, pds);
> +    postcopy_chunk_hostpages_pass(ms, true, block);
>      /*
>       * Second pass: Ensure that all partially dirty host pages are made
>       * fully dirty.
>       */
> -    postcopy_chunk_hostpages_pass(ms, false, block, pds);
> +    postcopy_chunk_hostpages_pass(ms, false, block);
>  
> -    postcopy_discard_send_finish(ms, pds);
> +    postcopy_discard_send_finish(ms);
>      return 0;
>  }
>  
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

