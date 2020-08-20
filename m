Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A74AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000D22054F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfCJeyWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000D22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nUo-0007Lx-2Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8nTf-0006fZ-8G
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:31:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k8nTd-0002Hn-0B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597941104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EBXdfwFuef8FZhEhWS+aa2trMdAvE3vgzOtyVhhyY1c=;
 b=DfCJeyWZK3ZNoLpl7J/Gceai0WLfGvYoiNZj7Rl1HfjbV4q2LCr9M6Kmekdkm62MzvqUSW
 QN1H5jKZAtkvlzDVlGcfYx9e5/F4j8B7S+TOj+78zGsmjgSe8LXOeQmu4YOgeUdqZWv1kG
 SV8VyKsCgorkJkpbPfXSI1vKHf8topE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-iPH5sGwROhWgCl3-NA4FWg-1; Thu, 20 Aug 2020 12:31:40 -0400
X-MC-Unique: iPH5sGwROhWgCl3-NA4FWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7470186A581;
 Thu, 20 Aug 2020 16:31:38 +0000 (UTC)
Received: from work-vm (ovpn-114-2.ams2.redhat.com [10.36.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C07A017567;
 Thu, 20 Aug 2020 16:31:36 +0000 (UTC)
Date: Thu, 20 Aug 2020 17:31:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Chuan Zheng <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 04/10] migration/dirtyrate: move
 RAMBLOCK_FOREACH_MIGRATABLE into ram.h
Message-ID: <20200820163134.GL2664@work-vm>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-5-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1597634433-18809-5-git-send-email-zhengchuan@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Chuan Zheng (zhengchuan@huawei.com) wrote:
> RAMBLOCK_FOREACH_MIGRATABLE is need in dirtyrate measure,
> move the existing definition up into migration/ram.h
> 
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(I noticed this triggered a few checker warnings, but this is just
moving an existing odd #define)



> ---
>  migration/dirtyrate.c |  1 +
>  migration/ram.c       | 11 +----------
>  migration/ram.h       | 10 ++++++++++
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 8708090..c4304ef 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -21,6 +21,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "migration.h"
> +#include "ram.h"
>  #include "dirtyrate.h"
>  
>  CalculatingDirtyRateState CalculatingState = CAL_DIRTY_RATE_INIT;
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee..37ef0da 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -158,21 +158,12 @@ out:
>      return ret;
>  }
>  
> -static bool ramblock_is_ignored(RAMBlock *block)
> +bool ramblock_is_ignored(RAMBlock *block)
>  {
>      return !qemu_ram_is_migratable(block) ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block));
>  }
>  
> -/* Should be holding either ram_list.mutex, or the RCU lock. */
> -#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (ramblock_is_ignored(block)) {} else
> -
> -#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (!qemu_ram_is_migratable(block)) {} else
> -
>  #undef RAMBLOCK_FOREACH
>  
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> diff --git a/migration/ram.h b/migration/ram.h
> index 2eeaacf..011e854 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -37,6 +37,16 @@ extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
>  extern CompressionStats compression_counters;
>  
> +bool ramblock_is_ignored(RAMBlock *block);
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else
> +
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +
>  int xbzrle_cache_resize(int64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
> -- 
> 1.8.3.1
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


