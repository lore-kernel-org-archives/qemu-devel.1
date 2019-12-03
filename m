Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E00C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8076C20803
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3R+8GfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8076C20803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEHf-00072t-KI
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 14:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icDPn-0003v6-LZ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icDPS-0002jE-Da
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:00:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55252
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icDPQ-0002d0-Is
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575399622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4R2IxJR6Z+mDgU3XpFRwM621OR0bReN1q5SncFZT7oY=;
 b=L3R+8GfCtOV9d+czxFZI6h3iQdLSVGU4rpBgWjIv1AmEQXM6OkWmgJizzF7m3m4hnxNi3A
 5/m53olySpShVKp/yTsKQQdj7k8dLxKsBN1Vy+diCG9D2gRcot7QISeKX1gy8wN0oDV2XH
 wjdjBB7sGtlZcF/zOcGHR+01XRdt0dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-dRQcVbTkMK6u9rAVZfDplQ-1; Tue, 03 Dec 2019 14:00:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B8B6801E72;
 Tue,  3 Dec 2019 19:00:19 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1C55DA70;
 Tue,  3 Dec 2019 19:00:16 +0000 (UTC)
Subject: Re: [PATCH V3 1/2] block/nbd: extract the common cleanup code
To: pannengyuan@huawei.com, kwolf@redhat.com, mreitz@redhat.com,
 sgarzare@redhat.com
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c700a37d-d31d-f0e7-4edb-4872c4f0e5c2@redhat.com>
Date: Tue, 3 Dec 2019 13:00:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dRQcVbTkMK6u9rAVZfDplQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/29/19 1:25 AM, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
> 
> The BDRVNBDState cleanup code is common in two places, add
> nbd_free_bdrvstate_prop() function to do these cleanups (suggested by
> Stefano Garzarella).
> 
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> ---
>   block/nbd.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 1239761..5805979 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -94,6 +94,8 @@ typedef struct BDRVNBDState {
>   
>   static int nbd_client_connect(BlockDriverState *bs, Error **errp);
>   
> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s);
> +

Why do you need a static function prototype?  Just implement the 
function prior to its first use, then you won't need a forward declaration.

>   static void nbd_channel_error(BDRVNBDState *s, int ret)
>   {
>       if (ret == -EIO) {
> @@ -1486,6 +1488,15 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
>       }
>   }
>   
> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s)
> +{
> +    object_unref(OBJECT(s->tlscreds));
> +    qapi_free_SocketAddress(s->saddr);
> +    g_free(s->export);
> +    g_free(s->tlscredsid);
> +    g_free(s->x_dirty_bitmap);
> +}

In fact, it appears that you did just that, as the first use...

Bike-shedding: the name 'nbd_free_bdrvstate_prop' doesn't seem right to 
me - when I see a function with 'free' in the name taking a single 
pointer, I assume that the given pointer (here, BDRVNBDState *s) is 
freed - but your function does NOT free then incoming pointer.  Rather, 
you are clearing out the contents within a pre-allocated object which 
remains allocated.  What's more, since the object remains allocated, I'm 
surprised that you are not setting fields to NULL to prevent 
use-after-free bugs.

Either this function should also free s (in which case naming it merely 
'nbd_free_bdrvstate' might be better), or you should consider naming it 
'nbd_clear_bdrvstate' and assigning cleared fields to NULL.

> +
>   /*
>    * Parse nbd_open options
>    */
> @@ -1855,10 +1866,7 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
>   
>    error:
>       if (ret < 0) {
> -        object_unref(OBJECT(s->tlscreds));
> -        qapi_free_SocketAddress(s->saddr);
> -        g_free(s->export);
> -        g_free(s->tlscredsid);
> +        nbd_free_bdrvstate_prop(s);

...is here.

>       }
>       qemu_opts_del(opts);
>       return ret;
> @@ -1937,12 +1945,7 @@ static void nbd_close(BlockDriverState *bs)
>       BDRVNBDState *s = bs->opaque;
>   
>       nbd_client_close(bs);
> -
> -    object_unref(OBJECT(s->tlscreds));
> -    qapi_free_SocketAddress(s->saddr);
> -    g_free(s->export);
> -    g_free(s->tlscredsid);
> -    g_free(s->x_dirty_bitmap);
> +    nbd_free_bdrvstate_prop(s);
>   }
>   
>   static int64_t nbd_getlength(BlockDriverState *bs)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


