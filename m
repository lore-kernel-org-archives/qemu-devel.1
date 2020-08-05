Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA67A206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU/qcw4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA67A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MG6-00072Y-UM
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3MFU-0006XI-U4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:26:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3MFR-0001wC-7f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596644795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhDFwa31e728NVgSE+eNj9V+WIFmS4/+U1I4n3YDrdE=;
 b=XU/qcw4ZaqL9xkvYAMJsPzKS2dK9PMxqkbsEUrSW4jjZ6oqDQwM8Snfx8OpV3nif46+sjK
 qh8mQ7wFhdC7JXuF6Ml9/llpVRC8zmrPjxEGQG3vBPZHnGurw3gk8D99U/yTARCfNBmYME
 yuY845AcMupK9eEFsG0xm+hinARG4cM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-WdFfzmD_M9OvgKfdbPYbPQ-1; Wed, 05 Aug 2020 12:26:33 -0400
X-MC-Unique: WdFfzmD_M9OvgKfdbPYbPQ-1
Received: by mail-wr1-f72.google.com with SMTP id d6so12192563wrv.23
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HhDFwa31e728NVgSE+eNj9V+WIFmS4/+U1I4n3YDrdE=;
 b=Y2joO424z10Eumiz3RqVAUVlDoTS9LFKU58/8CqePKMmK+x7lkHTIGscI4HYMve5oL
 Nr8JKO+xG3+BZIZJwSKdqHnmfwaXWoz68RTqbFlKvS+1iNvcdltnwVAT6bjuLFP4vexz
 TzPDt23XOOTorMHkpdpQkVARMLNiYicVLDQVM73s6y8MkUYtEbUnTyBHgB7MBYN4Rfmy
 n+SFiUpyTTUdZmsuT0/Zg471WPtupyeZxnLsJRPWkQJIM/CaJhDhsVqCZk1YMrR7gx2T
 VXRDTWYQl9p1oQpeqqVtvSzYI4utjTNtvOQzovRy3oYJBfOdtv3jkaRd6gsn13rd55dz
 VGEg==
X-Gm-Message-State: AOAM533KSojrx1jokhFlCwIe5ieaeqTKEotkPWOOeV7loiUEYkRYa16s
 l+247a0BBbpyZDdaDAU7wZl8+Y0mBJi4xl3MvOYnDeWwDtp9+/+o7pcHx/UsqMtEQWdTWJrviGF
 BNCe4nK4UqEOGp9U=
X-Received: by 2002:adf:aace:: with SMTP id i14mr3391113wrc.236.1596644792227; 
 Wed, 05 Aug 2020 09:26:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKf/Yytr1fLhmOEXhG8q98snI7XCUIr2KLtnx5eF3NLWM1iFH7wdtDWlJ13rj5Rhx040qRHA==
X-Received: by 2002:adf:aace:: with SMTP id i14mr3391086wrc.236.1596644791946; 
 Wed, 05 Aug 2020 09:26:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id t14sm3333822wrv.14.2020.08.05.09.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 09:26:31 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] async: always set ctx->notified in aio_notify()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200805100051.361547-1-stefanha@redhat.com>
 <20200805100051.361547-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db6ce882-3ed8-86b4-e6d1-8db70b158571@redhat.com>
Date: Wed, 5 Aug 2020 18:26:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200805100051.361547-3-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/20 12:00, Stefan Hajnoczi wrote:
> aio_notify() does not set ctx->notified when called with
> ctx->aio_notify_me disabled. Therefore aio_notify_me needs to be enabled
> during polling.
> 
> This is suboptimal since expensive event_notifier_set(&ctx->notifier)
> and event_notifier_test_and_clear(&ctx->notifier) calls are required
> when ctx->aio_notify_me is enabled.
> 
> Change aio_notify() so that aio->notified is always set, regardless of
> ctx->aio_notify_me. This will make polling cheaper since
> ctx->aio_notify_me can remain disabled. Move the
> event_notifier_test_and_clear() to the fd handler function (which is now
> no longer an empty function so "dummy" has been dropped from its name).
> 
> The next patch takes advantage of this by optimizing polling in
> util/aio-posix.c.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/async.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/util/async.c b/util/async.c
> index d9f987e133..3ec3e8d135 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -419,25 +419,32 @@ LuringState *aio_get_linux_io_uring(AioContext *ctx)
>  
>  void aio_notify(AioContext *ctx)
>  {
> -    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
> +    /*
> +     * Write e.g. bh->flags before writing ctx->notified.  Pairs with smp_mb in
> +     * aio_notify_accept.
> +     */
> +    smp_wmb();
> +    atomic_set(&ctx->notified, true);
> +
> +    /*
> +     * Write ctx->notified before reading ctx->notify_me.  Pairs
>       * with smp_mb in aio_ctx_prepare or aio_poll.
>       */
>      smp_mb();
>      if (atomic_read(&ctx->notify_me)) {
>          event_notifier_set(&ctx->notifier);
> -        atomic_mb_set(&ctx->notified, true);
>      }
>  }
>  
>  void aio_notify_accept(AioContext *ctx)
>  {
> -    if (atomic_xchg(&ctx->notified, false)
> -#ifdef WIN32
> -        || true
> -#endif
> -    ) {
> -        event_notifier_test_and_clear(&ctx->notifier);
> -    }
> +    atomic_set(&ctx->notified, false);
> +
> +    /*
> +     * Write ctx->notified before reading e.g. bh->flags.  Pairs with smp_mb in
> +     * aio_notify.

Just a nit: it's an smp_wmb().  (It's okay for a wmb to pair with
anything stronger than a smp_rmb()).

> +     */
> +    smp_mb();
>  }
>  
>  static void aio_timerlist_notify(void *opaque, QEMUClockType type)
> @@ -445,8 +452,11 @@ static void aio_timerlist_notify(void *opaque, QEMUClockType type)
>      aio_notify(opaque);
>  }
>  
> -static void aio_context_notifier_dummy_cb(EventNotifier *e)
> +static void aio_context_notifier_cb(EventNotifier *e)
>  {
> +    AioContext *ctx = container_of(e, AioContext, notifier);
> +
> +    event_notifier_test_and_clear(&ctx->notifier);
>  }
>  
>  /* Returns true if aio_notify() was called (e.g. a BH was scheduled) */
> @@ -508,7 +518,7 @@ AioContext *aio_context_new(Error **errp)
>  
>      aio_set_event_notifier(ctx, &ctx->notifier,
>                             false,
> -                           aio_context_notifier_dummy_cb,
> +                           aio_context_notifier_cb,
>                             aio_context_notifier_poll);
>  #ifdef CONFIG_LINUX_AIO
>      ctx->linux_aio = NULL;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Much better, you can almost trust the code to do the right thing. :)

Paolo


