Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03366C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF78820857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imYuIss8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF78820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUdBJ-0007g5-QM
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdAc-0006rf-H8
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUdAa-00032O-55
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:26:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdAZ-00030x-KR
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588368361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0qLZ5n2WcrkXUdC+g3P/OzC0/mijiJxEQgrt/XjmHI=;
 b=imYuIss8qj5M+N2vuiemQEHjxHhwMhEvGA15bpobCQrjijvyH8do+rL86YtEil7CRBY572
 XXzXxfKvazbWIizttrtHArNa7xKpqVyX0Oc/yGNnwjsTHis6zo91POtLj/tFTDHhW2dk4Z
 46uXMbNlq8aAnH3Z0AsNNR4iZwlwqZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-mmFNPea_PWm2nPWnCaJA4A-1; Fri, 01 May 2020 17:25:57 -0400
X-MC-Unique: mmFNPea_PWm2nPWnCaJA4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62C6E45F;
 Fri,  1 May 2020 21:25:56 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB89F5D714;
 Fri,  1 May 2020 21:25:52 +0000 (UTC)
Subject: Re: [PATCH v2 1/9] block/io: refactor bdrv_is_allocated_above to run
 only one coroutine
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d6bc0618-d570-345e-1b94-4eff8be2fd61@redhat.com>
Date: Fri, 1 May 2020 16:25:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427143907.5710-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 17:26:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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

On 4/27/20 9:38 AM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_is_allocated_above creates new coroutine on each iteration if
> called from non-coroutine context. To simplify expansion of in_flight
> inc/dec sections in further patch let's refactor it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 71 insertions(+), 5 deletions(-)
> 

Quite a lot of lines added, but it fits the the mechanical boilerplate 
we have elsewhere.

> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..94ab8eaa0f 100644
> --- a/block/io.c
> +++ b/block/io.c

> +int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
> +                            bool include_base, int64_t offset, int64_t bytes,
> +                            int64_t *pnum)
> +{
> +    Coroutine *co;
> +    BdrvCoIsAllocatedAboveData data = {
> +        .top = top,
> +        .base = base,
> +        .include_base = include_base,
> +        .offset = offset,
> +        .bytes = bytes,
> +        .pnum = pnum,
> +        .done = false,
> +    };

Omitting the line '.done = false,' has the same effect, since once you 
use a designated initializer, all remaining unspecified fields are 
0-initialized.  But explicitly mentioning it doesn't hurt.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


