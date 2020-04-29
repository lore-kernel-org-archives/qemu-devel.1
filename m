Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A6C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59117205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TC3VGwnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59117205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsQ1-0000bE-CN
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTsNt-00067L-8v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTsNE-0001OS-9I
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:28:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTsND-0001O2-SL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588188478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uOtEGVjbUtjv0Pga9WDhRbcNLkNI/4L3JkBGlpyOHpY=;
 b=TC3VGwnCUKQgKyedAgkhf1mX65PZ4sIIXLnsHiPht0cknj/4jy1RDebDpe+7YSuCo9tJlE
 EU54S2g6qgUgGXkYaaBqcEoEeG9rLCyPPBs7LTHgXJDD+n/ALZihddFPbyB2sa7ZNTB8dl
 5REnKD4Rw4fGUubmlmbHmJ/AmA6o7C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-aZM12trSPv2_Xgx02-ooXg-1; Wed, 29 Apr 2020 15:27:50 -0400
X-MC-Unique: aZM12trSPv2_Xgx02-ooXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E1341800D4A;
 Wed, 29 Apr 2020 19:27:48 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8655D780;
 Wed, 29 Apr 2020 19:27:38 +0000 (UTC)
Subject: Re: [PATCH v2 03/17] block/io: use int64_t bytes parameter in
 bdrv_check_byte_request()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e75e6fd2-67c8-16eb-2736-06f2fcca2b24@redhat.com>
Date: Wed, 29 Apr 2020 14:27:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:59:33
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Convert bdrv_check_byte_request() now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 7cbb80bd24..1267918def 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
>   }
>   
>   static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
> -                                   size_t size)
> +                                   int64_t bytes)
>   {

This changes an unsigned to signed value on 64-bit machines, and 
additionally widens the parameter on 32-bit machines.  Existing callers:

bdrv_co_preadv_part() with 'unsigned int' - no impact
bdrv_co_pwritev_part() with 'unsigned int' - no impact
bdrv_co_copy_range_internal() with 'uint64_t' - potentially fixes a 
latent bug on 32-bit machines. Requires a larger audit to see how 
bdrv_co_copy_range() and friends are used:

block/block-backend.c:blk_co_copy_range() - passes 'int', thus < 2G
block/block-copy.c:block_copy_do_copy() - passes 'int64_t', but only 
after assert(nbytes < INT_MAX); also it has a BLOCK_COPY_MAX_COPY_RANGE 
set to 16M that factors into its calculations on how much to do per 
iteration

So it looks like at present we are safe, but the commit message should 
definitely call out the fix for an unreachable latent bug.

I will also point out that on Linux, copy_file_range() is capped by a 
size_t len parameter, so even if we DO have a 32-bit caller passing > 
2G, it will encounter further truncation bugs if the block layer does 
not fragment the request internally.  I don't see any fragmentation 
logic in the public bdrv_co_copy_range() or in 
bdrv_co_copy_range_internal() - I suspect that needs to be added 
(probably as a separate patch); maybe by moving the fragmentation loop 
currently in block-copy.c to instead live in io.c?

> -    if (size > BDRV_REQUEST_MAX_BYTES) {
> +    if (bytes > BDRV_REQUEST_MAX_BYTES) {
>           return -EIO;
>       }
>   
> @@ -885,7 +885,7 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>           return -ENOMEDIUM;
>       }
>   
> -    if (offset < 0) {
> +    if (offset < 0 || bytes < 0) {
>           return -EIO;
>       }

Reviewed-by: Eric Blake <eblake@redhat.com>

I don't know if we have any iotest coverage of copy_range with a 5G 
image to prove that it doesn't misbehave on a 32-bit machine.  That 
seems like it will eventually be useful, but doesn't necessarily have to 
be at the same time as this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


