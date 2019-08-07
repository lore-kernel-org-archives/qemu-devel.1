Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFE5C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2079721E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2079721E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQ1a-00009Q-3N
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58051)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvQ0v-0008AH-B9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvQ0u-0000qC-9F
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:46:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvQ0u-0000o4-1Q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:46:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EDFA33C92D;
 Wed,  7 Aug 2019 17:46:14 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2CE600C6;
 Wed,  7 Aug 2019 17:46:11 +0000 (UTC)
Date: Wed, 7 Aug 2019 18:46:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190807174609.GJ27871@work-vm>
References: <20190718012547.16373-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718012547.16373-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 07 Aug 2019 17:46:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: just pass RAMBlock is enough
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> RAMBlock->used_length is always passed to migration_bitmap_sync_range(),
> which could be retrieved from RAMBlock.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Queued

> ---
>  migration/ram.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 908517fc2b..0a6070d787 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1669,11 +1669,10 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>      return ret;
>  }
>  
> -static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
> -                                        ram_addr_t length)
> +static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb)
>  {
>      rs->migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(rb, 0, length,
> +        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
>                                                &rs->num_dirty_pages_period);
>  }
>  
> @@ -1762,7 +1761,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(rs, block, block->used_length);
> +        migration_bitmap_sync_range(rs, block);
>      }
>      ram_counters.remaining = ram_bytes_remaining();
>      rcu_read_unlock();
> @@ -4193,7 +4192,7 @@ static void colo_flush_ram_cache(void)
>      memory_global_dirty_log_sync();
>      rcu_read_lock();
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> -        migration_bitmap_sync_range(ram_state, block, block->used_length);
> +        migration_bitmap_sync_range(ram_state, block);
>      }
>      rcu_read_unlock();
>  
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

