Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6281C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:02:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC55920857
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 22:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY2kirvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC55920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUdjo-0003fn-NL
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 18:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdis-0002rV-Vy
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUdiq-0000gq-SF
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:01:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdiq-0000cy-Am
 for qemu-devel@nongnu.org; Fri, 01 May 2020 18:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588370487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7hFZPvKlE9aCHgCSB2pPwhg4tvmjvIy5jhytVwzEH0=;
 b=fY2kirvJNd9DC/owMTZ/szsedKSf7FpTnP/cOEc24MDfDO5JShV3khVw9VzZegOiYi1e9l
 eCmpLAzP/Q7scHgaJ6QFHuL6RfQ0RfObat0Z0Klst3yLsrO+gvCOBwiANu9DRM/RRlyi32
 XYiI9P/k8JYMLRWEF9CvJV80Ne/H2sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-wLC__JtSOCGfoouiaLiW2A-1; Fri, 01 May 2020 18:01:13 -0400
X-MC-Unique: wLC__JtSOCGfoouiaLiW2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E75F800D24;
 Fri,  1 May 2020 22:01:12 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 767CD6109E;
 Fri,  1 May 2020 22:01:00 +0000 (UTC)
Subject: Re: [PATCH v2 6/9] block/io: expand in_flight inc/dec section:
 block-status
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <12c9ba13-ec91-ed3a-4713-018e0332f61b@redhat.com>
Date: Fri, 1 May 2020 17:00:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427143907.5710-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 17:43:47
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's safer to expand in_flight request to start before enter to
> coroutine in synchronous wrappers and end after BDRV_POLL_WHILE loop.
> Note that qemu_coroutine_enter may only schedule the coroutine in some
> circumstances.

Wording suggestion:

It's safer to expand the region protected by an in_flight request to 
begin in the synchronous wrapper and end after the BDRV_POLL_WHILE loop. 
  Leaving the in_flight request in the coroutine itself risks a race 
where calling qemu_coroutine_enter() may have only scheduled, rather 
than started, the coroutine, allowing some other thread a chance to not 
realize an operation is in flight.

> 
> block-status requests are complex, they involve querying different
> block driver states across backing chain. Let's expand only in_flight
> section for the top bs, keeping other sections as is.

block-status requests are complex, involving a query of different block 
driver states across the backing chain.  Let's expand only the in_flight 
section for the top bs, and keep the other sections as-is.

I'd welcome Kevin's review on my next comment, but if I'm correct, I 
think we can further add the following justification to the commit message:

Gathering block status only requires reads from the block device, and 
backing devices are typically read-only, so losing any in_flight race on 
a backing device is less likely to cause problems with concurrent 
modifications on the overall backing chain.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 65 ++++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 51 insertions(+), 14 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index a91d8c1e21..1cb6f433e5 100644
> --- a/block/io.c

> @@ -2624,15 +2646,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
>    * words, the result is not necessarily the maximum possible range);
>    * but 'pnum' will only be 0 when end of file is reached.
>    *
> + * To be called between exactly one pair of bdrv_inc/dec_in_flight() for top bs.
> + * bdrv_do_is_allocated_above takes care of increasing in_fligth for other block

in_flight

> + * driver states from bs backing chain.
>    */
>   static int coroutine_fn
> -bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
> +bdrv_do_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
>                              bool include_base, int64_t offset, int64_t bytes,
>                              int64_t *pnum)

> @@ -2682,11 +2710,16 @@ typedef struct BdrvCoIsAllocatedAboveData {
>       bool done;
>   } BdrvCoIsAllocatedAboveData;
>   
> +/*
> + * To be called between exactly one pair of bdrv_inc/dec_in_flight() for top bs.
> + * bdrv_do_is_allocated_above takes care of increasing in_fligth for other block
> + * driver states from the backing chain.
> + */
>   static void coroutine_fn bdrv_is_allocated_above_co_entry(void *opaque)

and again

Otherwise looks reasonable to me.  Fixing typos is trivial, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


