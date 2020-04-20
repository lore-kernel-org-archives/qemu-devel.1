Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469DC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF382074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZypQfrWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF382074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQY9E-0008Qm-Kp
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57754 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQY7z-00074H-QJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:33 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQY7y-0000ve-C6
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQY7x-0000sS-R7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587395668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+VMpnglbIQPjxBEZ2E/gBIToz52g+MeYxSUF9n8Fy4=;
 b=ZypQfrWHieJC87Hu7Fs1CJ444XEOjUxGpYludC9MI/JkZDbQdFNlX4jk0X9kDbastdrWDP
 xkaCWbVJqCKuO15dujljb87oNIKr6a7TLnK0knszaN0JMVtknzmN9YCcyy8vIfG//GGLF+
 9hcqSU6+f8nKQURKLgu+FNk1ByAoJJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-Qrz0cd22MpOe3Mj68Et73Q-1; Mon, 20 Apr 2020 11:14:22 -0400
X-MC-Unique: Qrz0cd22MpOe3Mj68Et73Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2196A192202A;
 Mon, 20 Apr 2020 15:14:21 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9F1A1898;
 Mon, 20 Apr 2020 15:14:19 +0000 (UTC)
Subject: Re: [PATCH v4 5/9] raw-format: Support BDRV_REQ_ZERO_WRITE for
 truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b30bde4c-1ac1-f7cf-0c1f-1e8f52c4c821@redhat.com>
Date: Mon, 20 Apr 2020 10:14:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420133214.28921-6-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 8:32 AM, Kevin Wolf wrote:
> The raw format driver can simply forward the flag and let its bs->file
> child take care of actually providing the zeros.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/raw-format.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/raw-format.c b/block/raw-format.c
> index 3465c9a865..ab69ac46d3 100644
> --- a/block/raw-format.c
> +++ b/block/raw-format.c
> @@ -387,7 +387,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>   
>       s->size = offset;
>       offset += s->offset;
> -    return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
> +    return bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
>   }
>   
>   static void raw_eject(BlockDriverState *bs, bool eject_flag)
> @@ -445,6 +445,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>       bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
> +    bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;

Shouldn't this be:

bs->supported_truncate_flags = (bs->file->bs->supported_truncate_flags &
                                 BDRV_REQ_ZERO_WRITE);

rather than unconditionally advertising something that the underlying 
layer may lack?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


