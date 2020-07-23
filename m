Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CB9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722E82065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5+UEXFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722E82065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyhst-0005vV-Dq
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 16:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyhs9-0005Qh-Be
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:31:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyhs7-0001vw-54
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595536277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aPwbriBLDNY1jzz04bUrWzLnJ2m1vzdUSluFUlEJsfU=;
 b=R5+UEXFGI0OYFOpT6lJpRB2l7D1X2Nle3HN6ysi2q1KLepsIIWn94/eXzJoBB+yCmrOL06
 /6MrRan51f3JNv57DxYsDXPfH//FqUOgIdPGKFoUEV7NtlidVabbgG5lGOY7k6RQvAdGMn
 BJhaEAwHRTvcMIOOX0X3AzIrM3rIRjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-oYNjQ6yLOpSWgxg6FTCdBw-1; Thu, 23 Jul 2020 16:31:14 -0400
X-MC-Unique: oYNjQ6yLOpSWgxg6FTCdBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9EB0106B25A;
 Thu, 23 Jul 2020 20:31:12 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F9360E1C;
 Thu, 23 Jul 2020 20:31:09 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] block: add max_pwrite_zeroes_fast to BlockLimits
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
 <20200611162655.4538-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <087ee47b-8f21-11b0-4de4-b5affc2ee68a@redhat.com>
Date: Thu, 23 Jul 2020 15:31:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200611162655.4538-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 22:13:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 11:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> The NBD spec was recently updated to clarify that max_block doesn't
> relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
> mirrors Qemu flag BDRV_REQ_NO_FALLBACK). To drop the restriction we
> need new max_pwrite_zeroes_fast.
> 
> Default value of new max_pwrite_zeroes_fast is zero and it means
> use max_pwrite_zeroes. So this commit semantically changes nothing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block_int.h |  8 ++++++++
>   block/io.c                | 17 ++++++++++++-----
>   2 files changed, 20 insertions(+), 5 deletions(-)

Hmm, this is an optimization, rather than a correctness issue.  I'm 
sorry I didn't review it sooner, but at this point, I think it is better 
as 5.2 material.

> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 791de6a59c..277e32fe31 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -626,6 +626,14 @@ typedef struct BlockLimits {
>        * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
>       int32_t max_pwrite_zeroes;
>   
> +    /*
> +     * Maximum number of bytes that can zeroed at once if flag
> +     * BDRV_REQ_NO_FALLBACK specified. Must be multiple of
> +     * pwrite_zeroes_alignment.
> +     * If 0, max_pwrite_zeroes is used for no-fallback case.
> +     */
> +    int64_t max_pwrite_zeroes_fast;

Nice that this is 64-bit off the bat (I know you have another series 
about converting more stuff to 64-bit).

> +
>       /* Optimal alignment for write zeroes requests in bytes. A power
>        * of 2 is best but not mandatory.  Must be a multiple of
>        * bl.request_alignment, and must be less than max_pwrite_zeroes
> diff --git a/block/io.c b/block/io.c
> index df8f2a98d4..0af62a53fd 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1774,12 +1774,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>       bool need_flush = false;
>       int head = 0;
>       int tail = 0;
> -
> -    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
> +    int max_write_zeroes;

32-bit...

>       int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
>                           bs->bl.request_alignment);
>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
>   
> +    assert(alignment % bs->bl.request_alignment == 0);

Would this look any better using the QEMU_IS_ALIGNED macro?

> +
>       if (!drv) {
>           return -ENOMEDIUM;
>       }
> @@ -1788,12 +1789,18 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>           return -ENOTSUP;
>       }
>   
> -    assert(alignment % bs->bl.request_alignment == 0);
> -    head = offset % alignment;
> -    tail = (offset + bytes) % alignment;
> +    if ((flags & BDRV_REQ_NO_FALLBACK) && bs->bl.max_pwrite_zeroes_fast) {
> +        max_write_zeroes = bs->bl.max_pwrite_zeroes_fast;

...but you try to assign something that may be 64-bit into it.  Risk of 
overflow.  Maybe we should get your 64-bit cleanup series in first.

> +    } else {
> +        max_write_zeroes = bs->bl.max_pwrite_zeroes;
> +    }
> +    max_write_zeroes = MIN_NON_ZERO(max_write_zeroes, INT_MAX);
>       max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
>       assert(max_write_zeroes >= bs->bl.request_alignment);
>   
> +    head = offset % alignment;
> +    tail = (offset + bytes) % alignment;
> +
>       while (bytes > 0 && !ret) {
>           int num = bytes;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


