Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BCBC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A25206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XqsLzkCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A25206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagoc-0004M7-Kf
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kagnD-0003As-Lc; Thu, 05 Nov 2020 10:03:15 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:43892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1kagnB-0008GX-2x; Thu, 05 Nov 2020 10:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=2BcMUuTpEGenynbxYg/qtid3fTvPdCr6EcbPBxcS0vE=; 
 b=XqsLzkCh1tNjllOiv7MNAlovdQPRe0zboCBq6UIPXR1D6xx6ehHod2IzduD9sVU68FswxLs5J5HvX1pjASlzpUq1uNwQjWumnSy7Y9kUgWiHtobTE6SwSYADimWv78yC+BmiBZPrSlCT7QVMfSRFu44a60fxlHVsCwKKkCt8PEx8glOkKukj286mI2RhYhYv7ghrQ+2tPR0L1+GR81crIzAnYwVkSI61l2MU8F4bUKq1OpG7SUbCgW9gHRT+YbVcEtqyLyR/NTRTM0nZevXiUCxBZIxL47qF/8CvNPu+aB5GvY85/VhEORaQg92a8YOKgXjA1yFlLXtvRq1SC4qJbQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1kagn6-0006al-MG; Thu, 05 Nov 2020 16:03:08 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1kagn6-0008Ue-Bu; Thu, 05 Nov 2020 16:03:08 +0100
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 1/2] block: make bdrv_drop_intermediate() less wrong
In-Reply-To: <20201031123502.4558-2-vsementsov@virtuozzo.com>
References: <20201031123502.4558-1-vsementsov@virtuozzo.com>
 <20201031123502.4558-2-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 05 Nov 2020 16:03:08 +0100
Message-ID: <w517dqzj177.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 10:03:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat 31 Oct 2020 01:35:01 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> @@ -4958,36 +4958,30 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
>          backing_file_str = base->filename;
>      }
>  
> -    QLIST_FOREACH_SAFE(c, &top->parents, next_parent, next) {
> -        /* Check whether we are allowed to switch c from top to base */
> -        GSList *ignore_children = g_slist_prepend(NULL, c);
> -        ret = bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
> -                                     ignore_children, NULL, &local_err);
> -        g_slist_free(ignore_children);
> -        if (ret < 0) {
> -            error_report_err(local_err);
> -            goto exit;
> -        }
> +    bdrv_replace_node(top, base, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        goto exit;
> +    }

At the beginning of this function there's a check for c->frozen. I think
you can remove it safely because you also have it in bdrv_replace_node()

Berto

