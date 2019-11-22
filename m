Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A3C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1382067D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgofA9Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1382067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDQm-0005Ao-78
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iYDHx-0007h7-7X
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iYDHu-0007Au-Vu
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56968
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iYDHt-0007AM-AE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574445848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNm+zZGyAbb3SSXtboJE8+6hogkIfyF2p8soPtCAR14=;
 b=TgofA9CaNIxm3Hi/+UP5TuKE0RiDdaQSBtb1sCuCBvLpETK0/962f1g5MIOmHEFCHcF+SP
 HYlP0BshntQVTmtxucrZ9GnSoWd27bJWLSjIHFa0aj2CCVGSgONL3m3rlQ2KS/Acs5pliX
 G3jsrywS5kiAQZPFlQHIloKoak8QUWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-vp6Va4pgOjicE18IYcqzog-1; Fri, 22 Nov 2019 13:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8BCB18B5FA2;
 Fri, 22 Nov 2019 18:04:03 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A01386E71F;
 Fri, 22 Nov 2019 18:03:59 +0000 (UTC)
Subject: Re: [PATCH v3 3/8] qcow2: Declare BDRV_REQ_NO_FALLBACK supported
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1ba16c08-9988-5fe7-85f4-b98549952283@redhat.com>
Date: Fri, 22 Nov 2019 12:03:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-4-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: vp6Va4pgOjicE18IYcqzog-1
X-Mimecast-Spam-Score: 0
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 10:05 AM, Kevin Wolf wrote:
> In the common case, qcow2_co_pwrite_zeroes() already only modifies
> metadata case, so we're fine with or without BDRV_REQ_NO_FALLBACK set.
> 
> The only exception is when using an external data file, where the
> request is passed down to the block driver of the external data file. We
> are forwarding the BDRV_REQ_NO_FALLBACK flag there, though, so this is
> fine, too.
> 
> Declare the flag supported therefore.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b201383c3d..3fa10bf807 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1722,7 +1722,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>           }
>       }
>   
> -    bs->supported_zero_flags = header.version >= 3 ? BDRV_REQ_MAY_UNMAP : 0;
> +    bs->supported_zero_flags = header.version >= 3 ?
> +                               BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK : 0;
>   
>       /* Repair image if dirty */
>       if (!(flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) && !bs->read_only &&
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


