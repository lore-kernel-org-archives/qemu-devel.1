Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC217C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA2D23787
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7vqAdx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA2D23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLB7a-00022r-MM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLB6c-0001Es-K2
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLB6a-0004lm-80
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600891866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmjHQ6V9sNcuepAT/+zte8y9CbIoIH74+xrwdWH3EjM=;
 b=a7vqAdx7pBBavTRQZwmQYjZUgGjkQr+3+1/SStyjxNrCao6uQDJ+5vksIx1hkMVxV3JLV1
 lepONOCW7peHWm3M7nXCNmRnjGXBI0n914DOI9opKusc/DXNGMW2zd7ekwaWnIScr7PkM6
 JBwBiu+AfiIxPYBioid2ILafEvNqwX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-IuVJdsXpPWe00uece5d_KQ-1; Wed, 23 Sep 2020 16:11:02 -0400
X-MC-Unique: IuVJdsXpPWe00uece5d_KQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C7B5188C12B;
 Wed, 23 Sep 2020 20:11:01 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8BE19D6C;
 Wed, 23 Sep 2020 20:10:57 +0000 (UTC)
Subject: Re: [PATCH v8 7/7] block/io: refactor save/load vmstate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7fd65dfd-6264-8510-5995-b712d5c4cfa7@redhat.com>
Date: Wed, 23 Sep 2020 15:10:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 11:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> Like for read/write in a previous commit, drop extra indirection layer,
> generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   block/coroutines.h    | 10 +++----
>   include/block/block.h |  6 ++--
>   block/io.c            | 67 ++++++++++++++++++++++---------------------
>   3 files changed, 42 insertions(+), 41 deletions(-)
> 
> diff --git a/block/coroutines.h b/block/coroutines.h

>   int coroutine_fn
> -bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
> -                   bool is_read)
> +bdrv_co_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>   {
>       BlockDriver *drv = bs->drv;
>       int ret = -ENOTSUP;
>   
> +    if (!drv) {
> +        return -ENOMEDIUM;
> +    }
> +
>       bdrv_inc_in_flight(bs);
>   
> -    if (!drv) {
> -        ret = -ENOMEDIUM;
> -    } else if (drv->bdrv_load_vmstate) {
> -        if (is_read) {
> -            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
> -        } else {
> -            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
> -        }
> +    if (drv->bdrv_load_vmstate) {
> +        ret = drv->bdrv_load_vmstate(bs, qiov, pos);

This one makes sense;

>       } else if (bs->file) {
> -        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> +        ret = bdrv_co_readv_vmstate(bs->file->bs, qiov, pos);
>       }
>   
>       bdrv_dec_in_flight(bs);
> +
>       return ret;
>   }
>   
> -int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
> -                      int64_t pos, int size)
> +int coroutine_fn
> +bdrv_co_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>   {
> -    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
> -    int ret;
> +    BlockDriver *drv = bs->drv;
> +    int ret = -ENOTSUP;
>   
> -    ret = bdrv_writev_vmstate(bs, &qiov, pos);
> -    if (ret < 0) {
> -        return ret;
> +    if (!drv) {
> +        return -ENOMEDIUM;
>       }
>   
> -    return size;
> -}
> +    bdrv_inc_in_flight(bs);
>   
> -int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
> -{
> -    return bdrv_rw_vmstate(bs, qiov, pos, false);
> +    if (drv->bdrv_load_vmstate) {
> +        ret = drv->bdrv_save_vmstate(bs, qiov, pos);

but this one looks awkward. It represents the pre-patch logic, but it 
would be nicer to check for bdrv_save_vmstate.  With that tweak, my R-b 
still stands.

I had an interesting time applying this patch due to merge conflicts 
with the new bdrv_primary_bs() changes that landed in the meantime.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


