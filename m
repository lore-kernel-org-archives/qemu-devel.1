Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 18:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD72D2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 18:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLNtw807"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD72D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdedQ-0006sB-0X
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 14:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdecJ-0006NH-EQ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 14:47:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54891
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdecH-0005Wo-2k
 for qemu-devel@nongnu.org; Tue, 26 May 2020 14:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590518871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9CdoVqf6yHTu6xa8kiK5WZRf9DaaFbTuqfImGwNgSg=;
 b=RLNtw807BiH+GKEhpLW6J+r1GToCf+w2p1nILPvQna3wbhgyofmV0g1J6RXYOQ32XS/Fo4
 +4lSYDufsiK5oa+RaC9VSD8WP+Fssncv98z6Sd7890Q/X/ijb1z7SINTE9068VR+ppF9Wr
 P2o8JX6c1G4dm/P/MwBd2ea/QWOa1kg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-94TLNbFGOYGGsgnoZ8S05g-1; Tue, 26 May 2020 14:47:49 -0400
X-MC-Unique: 94TLNbFGOYGGsgnoZ8S05g-1
Received: by mail-ej1-f71.google.com with SMTP id h6so7560545ejb.17
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 11:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R9CdoVqf6yHTu6xa8kiK5WZRf9DaaFbTuqfImGwNgSg=;
 b=Ij9c/YdyQew1jHBYjzOgFbToOrmuHrMtdi+gZaR3QDlq4pJkQPgjfqHTYaxAfldfPa
 SryuEDP7P74lvoM+AcP+LGoFH5hn7hHggPrSdv8cmIPvQ0K2q9NHuExjBr6Y4o4QR5/r
 49+RB2a+W9T5h83UNJtYR5y7gTrGQs7hNn+JuR1+1iAHw7pbqpvbvVciH1mIyfdfaWbi
 V4n7ZCdyCMk26XSwe85yCq50G2snkgHjkpXpz0D+9OqO3ulBYLyOp6okMzX+vWjCD7Bg
 MvILIL9HmZT93gPuowMUfTXzf/oWNjROvkUdxXM5Co2zGBvWg6QnCVc+xiajjj/kREFl
 qoIA==
X-Gm-Message-State: AOAM530jOkKBCSGn54i337NanvIjmv9jGkkzl1iFemBUq/xf9C9ca4MA
 Ji1d8bm5Lt5+o1dbibqDKPkWJ2gaQjHZfy2uChIEbVxUuOQv1W+Qn/BctjGKmM1LefPLg6zo+vh
 i8SFpxWocKtd2Jxs=
X-Received: by 2002:aa7:cf08:: with SMTP id a8mr22129794edy.354.1590518868844; 
 Tue, 26 May 2020 11:47:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoturTZKDr21q0gvRQsO7lOOIOqMzjCcf3syNsRyFZ5rwLxr1k2rTeurfs7OT0Jnm8sNweVQ==
X-Received: by 2002:aa7:cf08:: with SMTP id a8mr22129781edy.354.1590518868582; 
 Tue, 26 May 2020 11:47:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id qo21sm533931ejb.105.2020.05.26.11.47.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 11:47:48 -0700 (PDT)
Subject: Re: [PATCH 13/19] accel/tcg: Fixed tsan warnings.
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-14-robert.foley@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20a437ff-034c-ccc8-24d8-af25f962a445@redhat.com>
Date: Tue, 26 May 2020 20:47:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200522160755.886-14-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.puhov@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 cota@braap.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/05/20 18:07, Robert Foley wrote:
> For example:
> WARNING: ThreadSanitizer: data race (pid=35425)
>   Write of size 4 at 0x7bbc000000ac by main thread (mutexes: write M875):
>     #0 cpu_reset_interrupt hw/core/cpu.c:107:28 (qemu-system-aarch64+0x843790)
>     #1 arm_cpu_set_irq target/arm/cpu.c (qemu-system-aarch64+0x616265)
>     #2 qemu_set_irq hw/core/irq.c:44:5 (qemu-system-aarch64+0x8462ca)
>   Previous atomic read of size 4 at 0x7bbc000000ac by thread T6:
>     #0 __tsan_atomic32_load <null> (qemu-system-aarch64+0x394c1c)
>     #1 cpu_handle_interrupt accel/tcg/cpu-exec.c:534:9 (qemu-system-aarch64+0x4b7e79)
>     #2 cpu_exec accel/tcg/cpu-exec.c:720:17 (qemu-system-aarch64+0x4b7e79)
> or
> WARNING: ThreadSanitizer: data race (pid=25425)
>   Read of size 8 at 0x7f8ad8e138d0 by thread T10:
>     #0 tb_lookup_cmp accel/tcg/cpu-exec.c:307:13 (qemu-system-aarch64+0x4ac4d2)
>     #1 qht_do_lookup util/qht.c:502:34 (qemu-system-aarch64+0xd05264)
>   Previous write of size 8 at 0x7f8ad8e138d0 by thread T15 (mutexes: write M728311726235541804):
>     #0 tb_link_page accel/tcg/translate-all.c:1625:26 (qemu-system-aarch64+0x4b0bf2)
>     #1 tb_gen_code accel/tcg/translate-all.c:1865:19 (qemu-system-aarch64+0x4b0bf2)
>     #2 tb_find accel/tcg/cpu-exec.c:407:14 (qemu-system-aarch64+0x4ad77c)
> 
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  accel/tcg/tcg-all.c       | 4 ++--
>  accel/tcg/tcg-runtime.c   | 7 ++++++-
>  accel/tcg/translate-all.c | 6 +++++-
>  hw/core/cpu.c             | 2 +-
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 3b4fda5640..f94ea4c4b3 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -54,8 +54,8 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
>      int old_mask;
>      g_assert(qemu_mutex_iothread_locked());
>  
> -    old_mask = cpu->interrupt_request;
> -    cpu->interrupt_request |= mask;
> +    old_mask = atomic_read(&cpu->interrupt_request);
> +    atomic_or(&cpu->interrupt_request, mask);

You can use atomic_fetch_or here.

Paolo


