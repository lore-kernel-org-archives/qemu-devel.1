Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD37C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4A12086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRY0WFGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4A12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2r99-0005xP-Hw
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2r85-0005MT-Jh
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:12:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2r82-0007rX-OI
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596525173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7BSyhGcbIvVdi9RlQDGIHFyGNRiuCGG0xJZ1DRvyo8=;
 b=JRY0WFGR/CDaKHLPLkaIWTGGZdw6nKYAMHEjISvED38wFgMLvDL4PxyTibxi1KMedHhgcU
 NIaH6bjoLSmdza6ovYa1HkXrBI4K3ehkfaPHUjcyXq5yBKk4VVxu/HOFKKwoRrYMaCC25G
 WAhnp80AiylgLU2jJevxZ/CS40kiSdw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-v7rWPy3bMb24laMq7AeCVg-1; Tue, 04 Aug 2020 03:12:49 -0400
X-MC-Unique: v7rWPy3bMb24laMq7AeCVg-1
Received: by mail-wm1-f69.google.com with SMTP id s4so725417wmh.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E7BSyhGcbIvVdi9RlQDGIHFyGNRiuCGG0xJZ1DRvyo8=;
 b=oM26hj47Ca0Ii4VxNgFlj7GH/lodYj9aREAPPgjmj8I8TmejJ1ICl7fCeA0ujfN+4o
 I8oJhEM7/BNnO0Gon462cx7nbqH4jXMrs3fnu8pxqqxDxGJeOGETIZRN0KnYtPn5/88g
 15e1OcK4jZWvxBY9Fug/xezC0NA4Kw+5RDA+CRJecn28oYQVdPFRYfb0TTW29n0W6qNB
 3V9DwRO288acJULT71u0EbJWAJhD72eiRQKXG/7GGt5gUbjDOtFCBgqyj7aS0CuII6sH
 qXrLSPsmmTHiXTOLVjC4ccB3hHMW3ZMgL9gz9m/x/Zy6tE9ERy/jnTRJbQdKbW2lJA80
 sLWw==
X-Gm-Message-State: AOAM5313j4ZJ9JKz/XidUuL1DYpfbgTnuDR1LbujhmyhNIppAWKLb9Ns
 jRqSFkqEUA5dKCFlFpFtPXSWsKJbWSbL/Ju2CgSOZ6eOkql+X7bLH/qxCD2ov2gAgQl2ezl+tvR
 pfF/hMP68qT5B8DA=
X-Received: by 2002:adf:c983:: with SMTP id f3mr17962726wrh.348.1596525168153; 
 Tue, 04 Aug 2020 00:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbpkOa0vKkkmU8flvKcg9ApmKogm8mzVDle3n0TcYc1YADvzuzi/zviwvyyHY0mOYj3ldkXw==
X-Received: by 2002:adf:c983:: with SMTP id f3mr17962703wrh.348.1596525167820; 
 Tue, 04 Aug 2020 00:12:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id o3sm29373794wru.64.2020.08.04.00.12.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 00:12:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] async: always set ctx->notified in aio_notify()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200804052804.1165291-1-stefanha@redhat.com>
 <20200804052804.1165291-3-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb304bcb-6b5b-8544-0e94-e84055d4fab8@redhat.com>
Date: Tue, 4 Aug 2020 09:12:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200804052804.1165291-3-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/08/20 07:28, Stefan Hajnoczi wrote:
> @@ -425,19 +425,14 @@ void aio_notify(AioContext *ctx)
>      smp_mb();
>      if (atomic_read(&ctx->notify_me)) {
>          event_notifier_set(&ctx->notifier);
> -        atomic_mb_set(&ctx->notified, true);
>      }
> +
> +    atomic_mb_set(&ctx->notified, true);
>  }

This can be an atomic_set since it's already ordered by the smp_mb()
(actually a smp_wmb() would be enough for ctx->notified, though not for
ctx->notify_me).

>  void aio_notify_accept(AioContext *ctx)
>  {
> -    if (atomic_xchg(&ctx->notified, false)
> -#ifdef WIN32
> -        || true
> -#endif
> -    ) {
> -        event_notifier_test_and_clear(&ctx->notifier);
> -    }
> +    atomic_mb_set(&ctx->notified, false);
>  }

I am not sure what this should be.

- If ctx->notified is cleared earlier it's not a problem, there is just
a possibility for the other side to set it to true again and cause a
spurious wakeup

- if it is cleared later, during the dispatch, there is a possibility
that it we miss a set:

	CPU1				CPU2
	------------------------------- ------------------------------
	read bottom half flags
					set BH_SCHEDULED
					set ctx->notified
	clear ctx->notified (reordered)

and the next polling loop misses ctx->notified.

So the requirement is to write ctx->notified before the dispatching
phase start.  It would be a "store acquire" but it doesn't exist; I
would replace it with atomic_set() + smp_mb(), plus a comment saying
that it pairs with the smp_mb() (which actually could be a smp_wmb()) in
aio_notify().

In theory the barrier in aio_bh_dequeue is enough, but I don't
understand memory_order_seqcst atomics well enough to be sure, so I
prefer an explicit fence.

Feel free to include part of this description in aio_notify_accept().

Paolo


