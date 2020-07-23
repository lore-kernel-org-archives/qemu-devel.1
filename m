Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FBA2065F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guQfTdXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FBA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyhub-0006tl-V1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 16:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyhti-0006PI-Kg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:32:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37282
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyhth-00025B-4k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 16:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595536376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMTQpcfcq50N0UjDUOYGxWfM546ZeGm06VCJKfzDH0A=;
 b=guQfTdXYE9OTSDB89mmOaXNWhE+ypsW77h/Kwen/ITj6GL/qYwItviwqck9X0/GP8M7RUg
 4FQWtbfDkft9V8nvAa92TYvQJ4FMB/tOhdWI4j0lpHQNM83rtMFC895LLShfsoxrvS1ej1
 I75XgRkTFAb1m+3rRRS9QMDK6qCzbZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-sh5Da68bPJ-_UFZrXlTxRg-1; Thu, 23 Jul 2020 16:32:52 -0400
X-MC-Unique: sh5Da68bPJ-_UFZrXlTxRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 384BE800685;
 Thu, 23 Jul 2020 20:32:49 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C99A95D9D3;
 Thu, 23 Jul 2020 20:32:45 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] block/nbd: define new max_write_zero_fast limit
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
 <20200611162655.4538-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ba407503-d235-da74-6b19-7774605b4ee4@redhat.com>
Date: Thu, 23 Jul 2020 15:32:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200611162655.4538-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:26:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> mirrors Qemu flag BDRV_REQ_NO_FALLBACK).
> 
> bs->bl.max_write_zero_fast is zero by default which means using
> max_pwrite_zeroes. Update nbd driver to allow larger requests with
> BDRV_REQ_NO_FALLBACK.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 4ac23c8f62..b0584cf68d 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1956,6 +1956,7 @@ static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
>   
>       bs->bl.request_alignment = min;
>       bs->bl.max_pdiscard = QEMU_ALIGN_DOWN(INT_MAX, min);
> +    bs->bl.max_pwrite_zeroes_fast = bs->bl.max_pdiscard;
>       bs->bl.max_pwrite_zeroes = max;

Do we even need max_pwrite_zeroes_fast?  Doesn't qemu behave correctly 
if we just blindly assign max_pdiscard and max_pwrite_zeroes to the same 
value near 2G?

>       bs->bl.max_transfer = max;
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


