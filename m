Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2109C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9ED2078A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZy+FPv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9ED2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6tv-0004qU-BL
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT6lu-0005dl-6h
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kT6lq-0003qp-F7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602781828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmMQH1wUxp+pwUjjyq4o0N+58mDvnjdcLLf/jQDMOFs=;
 b=GZy+FPv9JpTmfc8V1wUjBSdkHghLMZgzX8whEpIXmmGqal0g4TwKVIojDhL1aq0CndW7fU
 Jv6zM3VGiwHfxFy/+HN1sLibrYricRh1FjFe2TfTfIDC7UP/mXUc++KN54lSK0kOy1M2EZ
 GLF2/Z9dhRon6wkzhTBLp/xKNe1MP6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-eQD6XulzMFqemAmrnvd-ZA-1; Thu, 15 Oct 2020 13:10:26 -0400
X-MC-Unique: eQD6XulzMFqemAmrnvd-ZA-1
Received: by mail-wr1-f71.google.com with SMTP id j6so2363654wrg.20
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 10:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kmMQH1wUxp+pwUjjyq4o0N+58mDvnjdcLLf/jQDMOFs=;
 b=PgpevOVvM+hzWKW3pD85Tyo22AnFHQbriW7eyCjSCC8eVCzeDZnuDFH7YX1W6ismr9
 PFEO7k4Z8Dx0+mFfFBUdXFDwjXRqkjEywefyKkNI0CTegfc43WWQc3B5UcaXQ9pgChoS
 NAlv/J5Ig9nH0fcR5kjwXlqSdQ5BpH+9tRXfEAwKRnmiUhv6EZ8uifV1pbgPjRSnF5Rl
 T0TE3tWPa2D21fr9CcK+GTmTmgX9nHh7soYC4s0NAqifFYUX9h6Uw8raEUdZRnANaOTg
 rO9YdHYCKOJVI9W/8TcCHSm1wCKlgu0XyATWctZzDScObxlGzAvAMvy4CuRDKxYafY2j
 mqaA==
X-Gm-Message-State: AOAM532Qbd8D/P8UVbkXoDkw9NqEyR/wiicAPEGvsRZKU5rh3xEHc9jJ
 tCHB2PU2W+Wi4tlMh7qOEZo0PZj3xDUXnG6qgCJ3pQYzVutEAlN+g79CjptJrFra1rdzHVYtih/
 VH9rcuOJmebiaMI4=
X-Received: by 2002:adf:a306:: with SMTP id c6mr5366017wrb.160.1602781825110; 
 Thu, 15 Oct 2020 10:10:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybRNge/cdnZfTky7+sh/FIQ/Eqm9balVEkCE2s8lhXgkpyxq8wHj8gyPlGtaQlwGMPIWdVQw==
X-Received: by 2002:adf:a306:: with SMTP id c6mr5365978wrb.160.1602781824808; 
 Thu, 15 Oct 2020 10:10:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2110:4ced:a13b:6857?
 ([2001:b07:6468:f312:2110:4ced:a13b:6857])
 by smtp.gmail.com with ESMTPSA id y190sm5688406wmc.27.2020.10.15.10.10.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 10:10:24 -0700 (PDT)
Subject: Re: [PATCH v2] fuzz: Disable QEMU's SIG{INT,HUP,TERM} handlers
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201014142157.46028-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <29b563d9-f612-ac8b-ea83-f7eb7b459106@redhat.com>
Date: Thu, 15 Oct 2020 19:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014142157.46028-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/20 16:21, Alexander Bulekov wrote:
> Prior to this patch, the only way I found to terminate the fuzzer was
> either to:
>  1. Explicitly specify the number of fuzzer runs with the -runs= flag
>  2. SIGKILL the process with "pkill -9 qemu-fuzz-*" or similar
> 
> In addition to being annoying to deal with, SIGKILLing the process skips
> over any exit handlers(e.g. registered with atexit()). This is bad,
> since some fuzzers might create temporary files that should ideally be
> removed on exit using an exit handler. The only way to achieve a clean
> exit now is to specify -runs=N , but the desired "N" is tricky to
> identify prior to fuzzing.
> 
> Why doesn't the process exit with standard SIGINT,SIGHUP,SIGTERM
> signals? QEMU installs its own handlers for these signals in
> os-posix.c:os_setup_signal_handling, which notify the main loop that an
> exit was requested. The fuzzer, however, does not run qemu_main_loop,
> which performs the main_loop_should_exit() check.  This means that the
> fuzzer effectively ignores these signals. As we don't really care about
> cleanly stopping the disposable fuzzer "VM", this patch uninstalls
> QEMU's signal handlers. Thus, we can stop the fuzzer with
> SIG{INT,HUP,TERM} and the fuzzing code can optionally use atexit() to
> clean up temporary files/resources.
> 
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/qtest/fuzz/fuzz.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index d926c490c5..eb0070437f 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      /* re-enable the rcu atfork, which was previously disabled in qemu_init */
>      rcu_enable_atfork();
>  
> +    /*
> +     * Disable QEMU's signal handlers, since we manually control the main_loop,
> +     * and don't check for main_loop_should_exit
> +     */
> +    signal(SIGINT, SIG_DFL);
> +    signal(SIGHUP, SIG_DFL);
> +    signal(SIGTERM, SIG_DFL);
> +
>      return 0;
>  }
> 

Queued, thanks.

Paolo


