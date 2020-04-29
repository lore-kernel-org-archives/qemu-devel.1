Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E48C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 21:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BE1206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 21:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3DeNqgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BE1206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTu3z-0001nS-1H
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 17:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTu2q-0000st-3y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 17:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTu2o-00064R-Sk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 17:15:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39971
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTu2o-000635-DW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 17:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588194901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nT5/c1dbprIacsVdDUgLcXKewoqxpx2q9bVIfVZWsM8=;
 b=Q3DeNqgG8TNcVwCiD/me1YaICe1tAjpTytIPkzNoxOZLfB+Fy+EfIhtcS8GKqWdBBBqrJY
 WicVLwysDq2fS10pamQrCDBDt5J1IP6+ce9y6c92Rxt6Ble6Vlh/47AhEWFEatcJQ2RzKi
 BS7MG/SyqMw8atbrua+QfTvV3YVqjb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-Wow7D7BSPrKfXF7p1amyMA-1; Wed, 29 Apr 2020 17:14:53 -0400
X-MC-Unique: Wow7D7BSPrKfXF7p1amyMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E7B46B;
 Wed, 29 Apr 2020 21:14:51 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B33D5C1D0;
 Wed, 29 Apr 2020 21:14:38 +0000 (UTC)
Subject: Re: [PATCH v2 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <08bb4e7b-0012-c097-778a-343296c19d9a@redhat.com>
Date: Wed, 29 Apr 2020 16:14:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 15:37:18
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
> on all io paths. Prepare bdrv_co_do_pwrite_zeroes() now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 4796476835..c8c30e3699 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -42,7 +42,7 @@
>   
>   static void bdrv_parent_cb_resize(BlockDriverState *bs);
>   static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> -    int64_t offset, int bytes, BdrvRequestFlags flags);
> +    int64_t offset, int64_t bytes, BdrvRequestFlags flags);
>   
>   static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
>                                         bool ignore_bds_parents)
> @@ -1743,7 +1743,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
>   }
>   
>   static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> -    int64_t offset, int bytes, BdrvRequestFlags flags)
> +    int64_t offset, int64_t bytes, BdrvRequestFlags flags)

Widens from 32- to 64-bit.  Callers (I'm looking at pre-series code, the 
further I get into your series, the more likely that intermediate 
changes may alter the analysis...):

bdrv_co_do_copy_on_readv() - passes 'int64_t pnum' bounded by 
fragmenting loop limited to MAX_BOUNCE_BUFFER
bdrv_aligned_pwritev() - passes 'unsigned int bytes' - latent bug fix 
for sizes between 2G and 4G, if any

to see if that bug could be tickled, look at callers of 
bdrv_aligned_pwritev:

bdrv_co_do_zero_pwritev() - splits 'unsigned int bytes' into 
head|body|tail; head and tail are safe but body could be > 2G
bdrv_co_pwritev_part() - gates with bdrv_check_byte_request()

continuing the audit, callers of bdrv_co_do_zero_pwritev:

bdrv_co_pwritev_part() - gates with bdrv_check_byte_request()

okay, all callers pass < 2G per our current code in 
bdrv_check_byte_request(), so there is no actual bug.  Still, the latent 
fix would be nice to mention in the commit message.

>   {
>       BlockDriver *drv = bs->drv;
>       QEMUIOVector qiov;
> @@ -1773,7 +1773,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>       assert(max_write_zeroes >= bs->bl.request_alignment);
>   
>       while (bytes > 0 && !ret) {
> -        int num = bytes;
> +        int64_t num = bytes;

Use of 'bytes' within the function:

compute 'int tail' via % 'int alignment' - safe
fragmentation loop 'int num' - still fragments with a cap on max_transfer

use of 'num' within the loop
compute 'int head' via % 'int alignment' - safe
clamp size by 'int max_write_zeroes' - safe
drv->bdrv_co_pwrite_zeroes(int) - safe because of clamping
clamp size by 'int max_transfer' - safe
qemu_iovec_init_buf(size_t) - safe because of clamping
bdrv_driver_pwritev(uint64_t) [well, int64_t after 4/17] - safe

So even with the wider type, we aren't exceeding the contract of 
anything we pass it on to.  Later patches may improve 
drv->bdrv_co_pwrite_zeroes and qemu_iovec_init_buf to be 64-bit clean, 
at which point we would want to revisit this function to use 64-bit 
clamping rather than 32-bit clamping, but it does not have to happen here.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


