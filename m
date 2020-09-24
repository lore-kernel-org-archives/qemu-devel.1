Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC289C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C816B23899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 20:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAtcbRuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C816B23899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXTt-0003h5-L9
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 16:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLXRO-0002aQ-LH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLXRM-0002bY-83
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 16:02:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600977723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y85ZHlPSu0LbWcyK0kASihR4L/4cljs70hwchn0FjHc=;
 b=FAtcbRuXi1JdzMGXbxl9aOYnGejMFziZK/aHjCzSMLvV+LuyIZ8rGFnSGV44pqTVRWAlPa
 DxxyBPbeYOvZbQ+YyEQn0nQvyIOLoZTXn6P5Q8rLmrFXdJa1ICZwsKB7HY2BTqC+ZZUaLY
 ygab7byaUmmGIzfP69oi3qO83vy5uG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-voM5z1hWN1CaFfCZ6R9eEA-1; Thu, 24 Sep 2020 16:01:58 -0400
X-MC-Unique: voM5z1hWN1CaFfCZ6R9eEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A42801002;
 Thu, 24 Sep 2020 20:01:57 +0000 (UTC)
Received: from [10.3.114.148] (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B3487368C;
 Thu, 24 Sep 2020 20:01:52 +0000 (UTC)
Subject: Re: [PATCH v7 1/5] block/io: fix bdrv_co_block_status_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
 <20200924194003.22080-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5dc62204-a1fe-1a94-144d-86c89a5f2bc8@redhat.com>
Date: Thu, 24 Sep 2020 15:01:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924194003.22080-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 2:39 PM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_co_block_status_above has several design problems with handling
> short backing files:
> 
> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> which produces these after-EOF zeros is inside requested backing
> sequence.
> 
> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
> because of EOF of short backing file.
> 
> Fix these things, making logic about short backing files clearer.
> 
> With fixed bdrv_block_status_above we also have to improve is_zero in
> qcow2 code, otherwise iotest 154 will fail, because with this patch we
> stop to merge zeros of different types (produced by fully unallocated
> in the whole backing chain regions vs produced by short backing files).
> 
> Note also, that this patch leaves for another day the general problem
> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
> vs go-to-backing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/io.c    | 68 ++++++++++++++++++++++++++++++++++++++++-----------
>   block/qcow2.c | 16 ++++++++++--
>   2 files changed, 68 insertions(+), 16 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 449b99b92c..4697e67a85 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2350,34 +2350,74 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
>                                     int64_t *map,
>                                     BlockDriverState **file)
>   {
> +    int ret;
>       BlockDriverState *p;
> -    int ret = 0;

The shuffle of these lines is odd, but not a show-stopper.

The new flow is definitely easier to read.  Thanks for doing this!

> +++ b/block/qcow2.c
> @@ -3860,8 +3860,20 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
>       if (!bytes) {
>           return true;
>       }
> -    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
> -    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
> +
> +    /*
> +     * bdrv_block_status_above doesn't merge different types of zeros, for

We're inconsistent on whether we spell the noun 'zeros' or 'zeroes'; but 
I don't care enough to make you change this.

> +     * example, zeros which come from the region which is unallocated in
> +     * the whole backing chain, and zeros which comes because of a short

s/comes/come/

> +     * backing file. So, we need a loop.
> +     */
> +    do {
> +        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
> +        offset += nr;
> +        bytes -= nr;
> +    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
> +
> +    return res >= 0 && (res & BDRV_BLOCK_ZERO) && bytes == 0;
>   }
>   
>   static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


