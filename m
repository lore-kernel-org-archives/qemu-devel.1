Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434F2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9AD20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9HybEwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9AD20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMYy-00054n-C3
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrMYG-0003kJ-1g
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:20:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50072
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrMYB-0006RQ-Hl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593786021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVTzsTheAmn9jl3yypvrWQaZhVAP5++U24xp6ZqKoTM=;
 b=S9HybEwVmWwEXkWL3yByfOBJyGS9KZfCCJYwECCgVo9tfpKGiIKwmaxHo6fCsp2QIj7cDo
 LyUcjQdMfrRCzS5qLL5vf2JDwvUMxN/7JQVp33bD9zTqWE1srvsRakN8jIWRpb79W/Y3d0
 m+CyCJQM7FK9QhyLJIqgqGMXzQPgBqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-5Z7nsEoAMau7dVzQ6wlZUg-1; Fri, 03 Jul 2020 10:20:20 -0400
X-MC-Unique: 5Z7nsEoAMau7dVzQ6wlZUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D18107ACCA;
 Fri,  3 Jul 2020 14:20:17 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28BB971682;
 Fri,  3 Jul 2020 14:20:16 +0000 (UTC)
Date: Fri, 3 Jul 2020 15:20:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3] migration: Count new_dirty instead of real_dirty
Message-ID: <20200703142013.GC36813@work-vm>
References: <20200622032037.31112-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200622032037.31112-1-zhukeqian1@huawei.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>,
 wanghaibin.wang@huawei.com, Chao Fan <fanc.fnst@cn.fujitsu.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jianjay.zhou@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Keqian Zhu (zhukeqian1@huawei.com) wrote:
> real_dirty_pages becomes equal to total ram size after dirty log sync
> in ram_init_bitmaps, the reason is that the bitmap of ramblock is
> initialized to be all set, so old path counts them as "real dirty" at
> beginning.
> 
> This causes wrong dirty rate and false positive throttling.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

OK, 

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued.

you might still want to look at migration_trigger_thrtottle and see if
you can stop the throttling if in the RAM bulk stage.

> ---
> Changelog:
> 
> v3:
>  - Address Dave's comments.
> 
> v2:
>  - Use new_dirty_pages instead of accu_dirty_pages.
>  - Adjust commit messages.
> ---
>  include/exec/ram_addr.h | 5 +----
>  migration/ram.c         | 8 +++++---
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 7b5c24e928..3ef729a23c 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -442,8 +442,7 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>  static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                                 ram_addr_t start,
> -                                               ram_addr_t length,
> -                                               uint64_t *real_dirty_pages)
> +                                               ram_addr_t length)
>  {
>      ram_addr_t addr;
>      unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
> @@ -469,7 +468,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>              if (src[idx][offset]) {
>                  unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>                  unsigned long new_dirty;
> -                *real_dirty_pages += ctpopl(bits);
>                  new_dirty = ~dest[k];
>                  dest[k] |= bits;
>                  new_dirty &= bits;
> @@ -502,7 +500,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                          start + addr + offset,
>                          TARGET_PAGE_SIZE,
>                          DIRTY_MEMORY_MIGRATION)) {
> -                *real_dirty_pages += 1;
>                  long k = (start + addr) >> TARGET_PAGE_BITS;
>                  if (!test_and_set_bit(k, dest)) {
>                      num_dirty++;
> diff --git a/migration/ram.c b/migration/ram.c
> index 069b6e30bc..5554a7d2d8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -859,9 +859,11 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>  /* Called with RCU critical section */
>  static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
>  {
> -    rs->migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
> -                                              &rs->num_dirty_pages_period);
> +    uint64_t new_dirty_pages =
> +        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
> +
> +    rs->migration_dirty_pages += new_dirty_pages;
> +    rs->num_dirty_pages_period += new_dirty_pages;
>  }
>  
>  /**
> -- 
> 2.19.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


