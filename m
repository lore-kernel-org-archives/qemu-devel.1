Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B07C38A2A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15502070B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQw9iArx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15502070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRoL-00060g-4J
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRnj-0005W4-Po
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:41:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRni-0006wi-6M
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588801316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/vD6iOeJiLlEAmtaYx5vn6gQh4tGwdxTD/sIAmOCP8=;
 b=HQw9iArxw1MN0Jim/BNYSc3XM3UZcamAeYrBGhAiTycRb6recfSzlL3ZzWm8uQBTbTdkSb
 Mn/aqe8osoPPRpACuKQhc1bXK+2RfV0qntR1dlAVxq8wGVjpzz20LpuxNBe3g2p4miD/7Y
 fb1h8wDOTGC+w0ZvmlLuVqS/W1oB/wQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-9r3MznAzMOe8yVCTJn-h3g-1; Wed, 06 May 2020 17:41:55 -0400
X-MC-Unique: 9r3MznAzMOe8yVCTJn-h3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80E64835B40;
 Wed,  6 May 2020 21:41:53 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 738E26061C;
 Wed,  6 May 2020 21:41:49 +0000 (UTC)
Subject: Re: [PATCH 5/8] block/file-posix: drop unallocated_blocks_are_zero
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <432055ab-57f8-c7e2-1032-414069fe1e64@redhat.com>
Date: Wed, 6 May 2020 16:41:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506092513.20904-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 16:22:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com, sw@weilnetz.de,
 pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> raw_co_block_status() in block/file-posix.c never returns 0, so
> unallocated_blocks_are_zero is useless. Drop it.

As in 4/8, you are correct that it had no impact on block_status, but it 
did affect qemu-img convert.  So again, removing the clients first makes 
this easier to justify as a cleanup patch.

That said...

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/file-posix.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 05e094be29..5c01735108 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2878,9 +2878,6 @@ static int coroutine_fn raw_co_pwrite_zeroes(
>   
>   static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>   {
> -    BDRVRawState *s = bs->opaque;
> -
> -    bdi->unallocated_blocks_are_zero = s->discard_zeroes;
>       return 0;
>   }

the function now does nothing.  Hmm - why does bdrv_get_info() return 
-ENOTSUP if the driver does not implement this function?  Wouldn't it be 
better if the block layer could allow us to omit .bdrv_get_info and do 
the same thing, without us having to write a dummy function that does 
nothing but return 0?  As separate patches, of course, as it would 
require changing several existing bdrv_get_info() callers to behave 
sanely when getting an all-0 success return where they now deal with an 
-ENOTSUP return.

So in the meantime, yes, we need this placeholder.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


