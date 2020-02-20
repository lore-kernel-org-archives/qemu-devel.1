Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72936C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C67A207FD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 11:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM/Ddxcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C67A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4jsI-0003MC-Er
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 06:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j4jrf-0002xI-S2
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:19:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j4jre-0002Rm-Um
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:19:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j4jre-0002Qe-Rb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 06:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582197570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ExnBrkrNjcDF1qxjrZgTz25sYsoV684O2fw45o39mU=;
 b=PM/Ddxcpdhx0xMKhzeZu9ufgXN67h80u7yZuw6YXxEyKxg4L5YgQBSkL61r6MCHS2ThKfs
 YKOyglu23zbjdEcZhNXz/+yipYqsWZzhHGCCtqxZLddDdo2ukis980f1ao06E44YgtrVCu
 vI8OSzhVvnQYx9dJZkK6cGCX2Us9gGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-SdCSbn9bOD-hPzupJb0uSQ-1; Thu, 20 Feb 2020 06:19:28 -0500
Received: by mail-wm1-f72.google.com with SMTP id u11so691121wmb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 03:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9ExnBrkrNjcDF1qxjrZgTz25sYsoV684O2fw45o39mU=;
 b=OcJF2nZmj5MJ4ybTSXmOa2yDw5Uzw5jxtym1QMGuBT+AJv7Uw7GmfF2C61DtjGIr1w
 AwgE+2hxI0ElcOFzmTLiZ0BKgRs4E0RBSNgJCbZs/8iohZ4Xj4WqnB7W+taLgAR4EP67
 NsKQ0wL4NGfO3ZYRIGPuelkddXtxtGkrtWUSpelh9PHBhpGqrtM19PHvDYlx5Ysd+BKB
 B/JkZrenbwsR8kG3OxtDVB2B+c8gOOjIzoIf2XaE7y3/gZKLAhvCiB7NevULMQTOEeim
 ZPjGvaV0HeEgzjk4++/WWnwgdvsZvvHvTXO3cO6dtai6aroBJI79+0iZVlSl30l5mjx7
 rLSQ==
X-Gm-Message-State: APjAAAX5y1hbT9CgrDjUbUum+GlmcDMTFHm+zgBIlddZ0SZ817H7qa25
 OK0IEUSxGQnAbaV8Y9KPWD9C8ogor05xU20j5wv0CyOolqhMY1bMHHOXNpqtmcBcYTz147XYl+C
 QiZlzRK2FQZla/Xo=
X-Received: by 2002:a5d:4705:: with SMTP id y5mr42185937wrq.370.1582197566800; 
 Thu, 20 Feb 2020 03:19:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdd0TNkz4IaWESAJPfHPfI/5C4UyXG+gg2pTbQZ68jPhyu/L2/Mp5KaMp6YofB12Y0pNbc5A==
X-Received: by 2002:a5d:4705:: with SMTP id y5mr42185912wrq.370.1582197566517; 
 Thu, 20 Feb 2020 03:19:26 -0800 (PST)
Received: from [10.201.49.12] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id t12sm3970190wrq.97.2020.02.20.03.19.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 03:19:26 -0800 (PST)
Subject: Re: [PATCH] aio-posix: avoid reacquiring rcu_read_lock() when polling
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200218182708.914552-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c365745-2608-6ff7-d752-5e2d2290b418@redhat.com>
Date: Thu, 20 Feb 2020 12:19:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218182708.914552-1-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: SdCSbn9bOD-hPzupJb0uSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 19:27, Stefan Hajnoczi wrote:
> The first rcu_read_lock/unlock() is expensive.  Nested calls are cheap.
> 
> This optimization increases IOPS from 73k to 162k with a Linux guest
> that has 2 virtio-blk,num-queues=1 and 99 virtio-blk,num-queues=32
> devices.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index a4977f538e..f67f5b34e9 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "block/block.h"
> +#include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/sockets.h"
>  #include "qemu/cutils.h"
> @@ -514,6 +515,16 @@ static bool run_poll_handlers_once(AioContext *ctx, int64_t *timeout)
>      bool progress = false;
>      AioHandler *node;
>  
> +    /*
> +     * Optimization: ->io_poll() handlers often contain RCU read critical
> +     * sections and we therefore see many rcu_read_lock() -> rcu_read_unlock()
> +     * -> rcu_read_lock() -> ... sequences with expensive memory
> +     * synchronization primitives.  Make the entire polling loop an RCU
> +     * critical section because nested rcu_read_lock()/rcu_read_unlock() calls
> +     * are cheap.
> +     */
> +    RCU_READ_LOCK_GUARD();
> +
>      QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
>          if (!node->deleted && node->io_poll &&
>              aio_node_check(ctx, node->is_external) &&
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


