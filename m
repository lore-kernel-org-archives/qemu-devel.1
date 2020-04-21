Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64794C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A05206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 21:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLb1gI3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A05206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR0t7-0007on-8I
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 17:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0sO-0007Js-3V
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jR0sM-0007qT-V3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:56:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jR0sM-0007ll-53
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 17:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587506177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8lwKx1HWhAiPOW9KeyheDzm5PqAlGxEr4wcO1dTivrA=;
 b=DLb1gI3SLkCDO59+PodnD3cxgFfLTpNLxNmy34v60U+Mtp3MIuUr/ejM6pIAaVtoJp94bV
 d2PiwTITDDbUkj9FJuCsxMealKYThqz7QAGJ6BH/Cj24uzZBYAXsXYVFixDQS3RJj/ZbnH
 EmiUUABaRyTD3mM8KwNmaBgugyJ97oI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-Y4UxBVOlNP6ObbKgL5po6A-1; Tue, 21 Apr 2020 17:56:13 -0400
X-MC-Unique: Y4UxBVOlNP6ObbKgL5po6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEC95800D53;
 Tue, 21 Apr 2020 21:56:11 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8974AA18AC;
 Tue, 21 Apr 2020 21:56:07 +0000 (UTC)
Subject: Re: [PATCH v2 2/6] block/nbd-client: drop max_block restriction from
 discard
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
 <20200401150112.9557-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e3253b06-4bff-970d-9b9b-32da6bf652b8@redhat.com>
Date: Tue, 21 Apr 2020 16:56:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200401150112.9557-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 15:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 4/1/20 10:01 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD spec is updated, so that max_block doesn't relate to
> NBD_CMD_TRIM. So, drop the restriction.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I might tweak the commit message of 1/6 and here to call out the NBD 
spec commit id (nbd.git 9f30fedb), but that doesn't change the patch proper.

> 
> diff --git a/block/nbd.c b/block/nbd.c
> index d4d518a780..4ac23c8f62 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1955,7 +1955,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>       }
>   
>       bs->bl.request_alignment = min;
> -    bs->bl.max_pdiscard = max;
> +    bs->bl.max_pdiscard = QEMU_ALIGN_DOWN(INT_MAX, min);
>       bs->bl.max_pwrite_zeroes = max;
>       bs->bl.max_transfer = max;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


