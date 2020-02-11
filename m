Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93502C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F17120708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeJ7mlMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F17120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Xkm-0002Rq-4y
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Xk8-0001xE-9V
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Xk6-0002ce-U2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:46:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Xk6-0002cA-Q3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581435990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rYF6a/rzZIXYq2pah1hmpwwbEOuBhQjJtmq2Cq6gDk=;
 b=aeJ7mlMY21tI/ITJufh0pR4ovrbKFnXNNyH+R6i82uhjWYoPfEhVteHTUCFIBcaB6s3sr7
 82WwEiuNrcfENFih+6ntoOvzgBuVw2SUk05kc8wnacnZEPRj414Uq3hEp9Yz11AK8zabCm
 debjtJUjx/nmNAt390GVWVb1qyjtZ3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-AHlB33cVOdahHoIajSsnpQ-1; Tue, 11 Feb 2020 10:46:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FACB107ACC4;
 Tue, 11 Feb 2020 15:46:26 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA35D60BF1;
 Tue, 11 Feb 2020 15:46:25 +0000 (UTC)
Subject: Re: [PATCH v2 28/33] block: Use bdrv_default_perms()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-29-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ee7f8f32-4b86-de90-8348-48fd2a08260f@redhat.com>
Date: Tue, 11 Feb 2020 09:46:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-29-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AHlB33cVOdahHoIajSsnpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> bdrv_default_perms() can decide which permission profile to use based on
> the BdrvChildRole, so block drivers do not need to select it explicitly.
> 
> The blkverify driver now no longer shares the WRITE permission for the
> image to verify.  We thus have to adjust two places in
> test-block-iothread not to take it.  (Note that in theory, blkverify
> should behave like quorum in this regard and share neither WRITE nor
> RESIZE for both of its children.  In practice, it does not really
> matter, because blkverify is used only for debugging, so we might as
> well keep its permissions rather liberal.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/block/blklogwrites.c
> @@ -295,13 +295,8 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
>           return;
>       }
>   
> -    if (!strcmp(c->name, "log")) {
> -        bdrv_format_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
> -                                  nperm, nshrd);
> -    } else {
> -        bdrv_filter_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
> -                                  nperm, nshrd);
> -    }
> +    bdrv_default_perms(bs, c, child_class, role, ro_q, perm, shrd,
> +                       nperm, nshrd);
>   }

I like the consolidation this is making possible.

The commit note on test-block-iothread was important, and makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


