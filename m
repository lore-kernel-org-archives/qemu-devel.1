Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92A2C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F072173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt7v7C6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F072173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8s5j-0000b9-QV
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j8s4x-0008Gj-9J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j8s4w-0005cb-Ci
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:54:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35925
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j8s4w-0005cS-8M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583182457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/iE/DJqNJbcJD3U4FvFZlrNcoAndPiktAU44ry3GMc=;
 b=bt7v7C6pPpCfyVBPAuVtOZJeF7p8VMkIguoL2W7B7qCojtlbWqiqH+kA0T5p9m8nVL/XZ+
 0FQqRiHMkMpELFkryfj2h4+6KBuGARM5sibAuVOjcYO4UkZHTMHWkViQjQHJD9r2f21NXF
 jPEq2nvDovyabY8D+Jn6yvFpTaR1ar4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-iOqKIPMBPBePLMKt7MH0ng-1; Mon, 02 Mar 2020 15:54:16 -0500
X-MC-Unique: iOqKIPMBPBePLMKt7MH0ng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47FD800D4E;
 Mon,  2 Mar 2020 20:54:14 +0000 (UTC)
Received: from [10.3.117.157] (ovpn-117-157.phx2.redhat.com [10.3.117.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4572F5C122;
 Mon,  2 Mar 2020 20:54:02 +0000 (UTC)
Subject: Re: [PATCH 2/5] block/nbd-client: drop max_block restriction from
 discard
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <45be1ff4-ebd5-6ab4-8cac-75362f1dd9cf@redhat.com>
Date: Mon, 2 Mar 2020 14:53:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302100537.29058-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> NBD spec is updated, so that max_block doesn't relate to
> NBD_CMD_TRIM. So, drop the restriction.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 2a58d6b91c..a62761ea5a 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1955,7 +1955,6 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>       }
>   
>       bs->bl.request_alignment = min;
> -    bs->bl.max_pdiscard = max;

We should still tell the block layer that we have a 32-bit cap (in case 
the block layer starts supporting 64-bit discard).

>       bs->bl.max_pwrite_zeroes = max;
>       bs->bl.max_transfer = max;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


