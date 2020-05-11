Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF17C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56018206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 15:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sz97Lukf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56018206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYAMm-0005K7-Db
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 11:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYALu-0004bP-V5; Mon, 11 May 2020 11:28:22 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:58735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1jYALt-0004eb-3u; Mon, 11 May 2020 11:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=Nzjz6M6OYuKP2RxAW9RMqf/yUvYpcE2FQxxPgzGqbIk=; 
 b=sz97Lukf5hTvkkheUfp5bdFrlVlSMQap8E0ObRv6L5fmDUpAnNN891FSaieggiEZZ32G6ZfgrGH2mHi8KrKeUgizktSWwbsD5IKtv0fqX5u6z4FhBPCXezOuNJSGK6Fp8yQ7l93T4R0Cb6j3yl7ZL/M6Mo4U/qG8x4hI9V8ylGjDfjMtzA7v8uttrWGR5JYzeGiW/dGPQZVxJOumUnjx5nGR3fFYPkpGbc0m7nPiBUSb4YJJrxYHDRUEGtb1rRSH9Cfgq+/LzMMTwOQAEGTZknv2DSb6emqibLSN293iiJpiI8rPWzieBH1lh9ZSxfyirBdgCGhqNtLvIG0KAQ+hxg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jYALl-0000X1-64; Mon, 11 May 2020 17:28:13 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jYALk-0003ts-SL; Mon, 11 May 2020 17:28:12 +0200
From: Alberto Garcia <berto@igalia.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
In-Reply-To: <20200430111033.29980-2-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-2-vsementsov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Mon, 11 May 2020 17:28:12 +0200
Message-ID: <w51ftc6o5ir.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine.igalia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 11:28:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org,
 sheepdog@lists.wpkg.org, pavel.dovgaluk@ispras.ru, dillaman@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com,
 mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 30 Apr 2020 01:10:17 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
> The function is called from 64bit io handlers, and bytes is just passed
> to throttle_account() which is 64bit too (unsigned though). So, let's
> convert intermediate argument to 64bit too.
>
> This patch is a first in the 64-bit-blocklayer series, so we are
> generally moving to int64_t for both offset and bytes parameters on all
> io paths. Main motivation is realization of 64-bit write_zeroes
> operation for fast zeroing large disk chunks, up to the whole disk.
>
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
>
> Patch-correctness audit by Eric Blake:
>
>   Caller has 32-bit, this patch now causes widening which is safe:
>   block/block-backend.c: blk_do_preadv() passes 'unsigned int'
>   block/block-backend.c: blk_do_pwritev_part() passes 'unsigned int'
>   block/throttle.c: throttle_co_pwrite_zeroes() passes 'int'
>   block/throttle.c: throttle_co_pdiscard() passes 'int'
>
>   Caller has 64-bit, this patch fixes potential bug where pre-patch
>   could narrow, except it's easy enough to trace that callers are still
>   capped at 2G actions:
>   block/throttle.c: throttle_co_preadv() passes 'uint64_t'
>   block/throttle.c: throttle_co_pwritev() passes 'uint64_t'
>
>   Implementation in question: block/throttle-groups.c
>   throttle_group_co_io_limits_intercept() takes 'unsigned int bytes'
>   and uses it: argument to util/throttle.c throttle_account(uint64_t)
>
>   All safe: it patches a latent bug, and does not introduce any 64-bit
>   gotchas once throttle_co_p{read,write}v are relaxed, and assuming
>   throttle_account() is not buggy.
>
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

