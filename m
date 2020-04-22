Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A073AC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6937420776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTnfebjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6937420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHQL-0005wu-GQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRHOa-00032G-IF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRHOY-0007rC-Pp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:34:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRHOY-0007pk-CT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587569677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=870oJoJDFzJrFyjWZyHnmRVFhVHRsgNfsOmVS94dRao=;
 b=LTnfebjN0MjKX7zHzNcrRrJrQ8mB8Ee6ZTOGQHIle/K//lBn4X4S9mW/q9e1LcZ5CJIMlB
 EqXEP0As9W85gOs3ohRmMnt1wx/kKGdudb93YIuu9ZumbtlVbxEnKlDMSZpp/wKvsrbskc
 0gcN5xJ0gMcq9tILaoNjC1pAZVQdOL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-1jMNyvMJNgqbARxxCHbZJA-1; Wed, 22 Apr 2020 11:34:35 -0400
X-MC-Unique: 1jMNyvMJNgqbARxxCHbZJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C90D100CCCE;
 Wed, 22 Apr 2020 15:34:34 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 912205C1D4;
 Wed, 22 Apr 2020 15:34:33 +0000 (UTC)
Subject: Re: [PATCH v5 5/9] raw-format: Support BDRV_REQ_ZERO_WRITE for
 truncate
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5dd11860-6a13-3f7a-db3b-1286cf9f4207@redhat.com>
Date: Wed, 22 Apr 2020 10:34:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422152129.167074-6-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 10:21 AM, Kevin Wolf wrote:
> The raw format driver can simply forward the flag and let its bs->file
> child take care of actually providing the zeros.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/raw-format.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/raw-format.c b/block/raw-format.c
> index 3465c9a865..351f2d91c6 100644
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
> @@ -445,6 +445,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>       bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>               bs->file->bs->supported_zero_flags);
> +    bs->supported_truncate_flags = bs->file->bs->supported_truncate_flags &
> +                                   BDRV_REQ_ZERO_WRITE;
>   
>       if (bs->probed && !bdrv_is_read_only(bs)) {
>           bdrv_refresh_filename(bs->file->bs);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


