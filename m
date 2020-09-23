Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A593EC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058B206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 15:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFu6m6H3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL6RC-0004pv-9o
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 11:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL6OY-0002Yw-M9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kL6OW-0002Ir-6r
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 11:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600873758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIabpoMccSipJ8urmAuA4Lm1P9DTlGaPEzUc/0Sn4R0=;
 b=cFu6m6H3gdNoA1Gz9gVov8q3jnrrKIWY8C9ejGW3l9BIMJ/Nk83SI3BVBAXJsskUOZSLeG
 +VrOrM4x8RqOCRZhCDn+RpHZQQx2IciMS5J40sAhavgY3rlb+A923Ck5vj6CQi7hN04tim
 szeU6y+QkIAGsR67/LJlHCB4ktfYDq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_AfZtzyQPKe_DRb1sdIUaw-1; Wed, 23 Sep 2020 11:09:00 -0400
X-MC-Unique: _AfZtzyQPKe_DRb1sdIUaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70D6188C125;
 Wed, 23 Sep 2020 15:08:58 +0000 (UTC)
Received: from [10.3.114.2] (ovpn-114-2.phx2.redhat.com [10.3.114.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2846273668;
 Wed, 23 Sep 2020 15:08:57 +0000 (UTC)
Subject: Re: [PATCH 1/4] block/nbd: fix drain dead-lock because of nbd
 reconnect-delay
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200903190301.367620-1-vsementsov@virtuozzo.com>
 <20200903190301.367620-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <487c992c-806e-9947-eb0e-85d8d5b39224@redhat.com>
Date: Wed, 23 Sep 2020 10:08:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903190301.367620-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 2:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> We pause reconnect process during drained section. So, if we have some
> requests, waiting for reconnect we should cancel them, otherwise they
> deadlock the drained section.
> 
> How to reproduce:
> 

> Now Qemu is trying to reconnect, and dd-generated requests are waiting
> for the connection (they will wait up to 60 seconds (see
> reconnect-delay option above) and than fail). But suddenly, vm may
> totally hang in the deadlock. You may need to increase reconnect-delay
> period to catch the dead-lock.
> 
> VM doesn't respond because drain dead-lock happens in cpu thread with
> global mutex taken. That's not good thing by itself and is not fixed
> by this commit (true way is using iothreads). Still this commit fixes
> drain dead-lock itself.
> 
> Note: probably, we can instead continue to reconnect during drained
> section. To achieve this, we may move negotiation to the connect thread
> to make it independent of bs aio context. But expanding drained section
> doesn't seem good anyway. So, let's now fix the bug the simplest way.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 9daf003bea..912ea27be7 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -242,6 +242,11 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
>       }
>   
>       nbd_co_establish_connection_cancel(bs, false);
> +
> +    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
> +        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
> +        qemu_co_queue_restart_all(&s->free_sema);
> +    }
>   }
>   

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


