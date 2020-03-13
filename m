Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D669CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5182074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh4LkDLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5182074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCsAx-0003Fy-ID
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCsA7-00028v-DD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCsA6-0000pL-5a
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:48:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCsA6-0000hN-0q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584136089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZ1ipuWhr00Q7fnHx89znDp6U66N5ws9/G+x5se4voo=;
 b=Nh4LkDLgX+NM9WJ6vTVQVN1kvb4EbG+LZcEnOcBrM4LVaEqBqBdO+/3pP30assxiMOsyYD
 heyYd/NRzTIsJPsOueuTlzrV5HBBnd3D0dZbHJRWN7FLCeReqIquQXmnqIy2qiZyRngFYm
 3ESy7vatuR71mGaNrB5Lvdywx9Znz1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-yMa2RtZ8O4iWXrdax-v3Ug-1; Fri, 13 Mar 2020 17:48:06 -0400
X-MC-Unique: yMa2RtZ8O4iWXrdax-v3Ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB685108838D;
 Fri, 13 Mar 2020 21:48:04 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 227CA96B60;
 Fri, 13 Mar 2020 21:47:59 +0000 (UTC)
Subject: Re: [PATCH 4/5] block/io: fix bdrv_co_do_pwrite_zeroes head
 calculation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
 <20200302100537.29058-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <67a739c0-61c2-2134-50d5-559ed5f3a7e0@redhat.com>
Date: Fri, 13 Mar 2020 16:47:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302100537.29058-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's wrong to update head using num in this place, as num may be
> reduced during the iteration, and we'll have wrong head value on next
> iteration.
> 
> Instead update head at iteration end.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Offhand, I don't see how this fixes any bug....
/me reads on

> 
> diff --git a/block/io.c b/block/io.c
> index 75fd5600c2..c64566b4cf 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1785,7 +1785,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>                * convenience, limit this request to max_transfer even if
>                * we don't need to fall back to writes.  */
>               num = MIN(MIN(bytes, max_transfer), alignment - head);
> -            head = (head + num) % alignment;
>               assert(num < max_write_zeroes);

Here, we've asserted that if head was non-zero, num was already smaller 
than max_write_zeroes.  The rest of the loop does indeed have code that 
appears like it can reduce num, but that code is guarded:

         /* limit request size */
         if (num > max_write_zeroes) {
             num = max_write_zeroes;
         }
...
         if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
             /* Fall back to bounce buffer if write zeroes is unsupported */
             BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;

             if ((flags & BDRV_REQ_FUA) &&
                 !(bs->supported_write_flags & BDRV_REQ_FUA)) {
                 /* No need for bdrv_driver_pwrite() to do a fallback
                  * flush on each chunk; use just one at the end */
                 write_flags &= ~BDRV_REQ_FUA;
                 need_flush = true;
             }
             num = MIN(num, max_transfer);

Oh. Now I see.  If max_write_zeroes is > max_transfer, but we fall back 
to a bounce buffer, it is indeed possible that a misaligned request that 
forces fallbacks to writes may indeed require more than one write to get 
to the point where it is then using a buffer aligned to max_write_zeroes.

Do we have an iotest provoking this, or is it theoretical?  With an 
iotest, this one is material for 5.0 even if the rest of the series 
misses soft freeze.

>           } else if (tail && num > alignment) {
>               /* Shorten the request to the last aligned sector.  */
> @@ -1844,6 +1843,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>   
>           offset += num;
>           bytes -= num;
> +        if (head) {
> +            head = offset % alignment;
> +        }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


