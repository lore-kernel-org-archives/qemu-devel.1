Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B4C47256
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AD220857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQJPO9F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AD220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUdo3-0007p0-Dy
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 18:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdmj-0005m5-5v
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUdmg-0005X7-6q
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:05:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27215
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdmf-0005TX-ME
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588370724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJCRrn0++JMt9ey/QxBh1DGyPFzhezHatD2d2IKYezg=;
 b=EQJPO9F2cVWE2i9r27ja12lCvEnZbSA94dt4sMXia34bHD9R5274AJTSzhk6Xq10JZQrPB
 BlwrKjOfvtZilHLz2/BCkEz3PT5j1L50buW1jocv2lVWhMhngFghkXSMbYbzJa/F0eH8GQ
 e1ZW6JG6VZsN+uD+aQ/2hkvOVgF9wzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-b7LTM9J3ObqZbG9Hc1pAoA-1; Fri, 01 May 2020 18:05:16 -0400
X-MC-Unique: b7LTM9J3ObqZbG9Hc1pAoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA10A462;
 Fri,  1 May 2020 22:05:14 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E3F261537;
 Fri,  1 May 2020 22:05:09 +0000 (UTC)
Subject: Re: [PATCH v2 7/9] block/io: add bdrv_do_pwrite_zeroes
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <19145553-f432-3de5-9a09-50d8074a0e96@redhat.com>
Date: Fri, 1 May 2020 17:05:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427143907.5710-8-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 18:01:20
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

On 4/27/20 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> We'll need a bdrv_co_pwrite_zeroes version without inc/dec in_flight to
> be used in further implementation of bdrv_make_zero.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/io.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 1cb6f433e5..e6a8ead46c 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2016,8 +2016,10 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
>       return ret;
>   }
>   
> -int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
> -                                       int bytes, BdrvRequestFlags flags)
> +/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
> +static int coroutine_fn
> +bdrv_do_pwrite_zeroes(BdrvChild *child, int64_t offset, int bytes,
> +                      BdrvRequestFlags flags)

I assume your 64-bit conversion series is based on top of this one, and 
therefore this gets cleaned up there to take a 64-bit bytes request.  In 
the meantime, sticking to 32-bit is fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


