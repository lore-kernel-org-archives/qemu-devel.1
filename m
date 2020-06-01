Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B09EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331512073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IENq2kfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331512073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnJO-0002WW-FK
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jfnIb-000255-Jb
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:28:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jfnIZ-0004sK-Rf
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591028906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omCX/201/bqxo8gzog+yl11Z4cOuOGzzmz618nHPnKY=;
 b=IENq2kfYohrdbejdUyal8WXk3JoMgbJCDehAhYjxnbtgwpNxDZyAYXrn78vAYN913yX+b4
 3n5vVRw87rONgYqLUDPsjqF248AXSv9FsViJeoYY9RBYHjliV7R/Eho3yHwZc844bTj0XU
 OTe+r4/HlqseobRezx/cB+lNqImgyZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-eCdqEQJWO9q7Ve2I5t1Ssg-1; Mon, 01 Jun 2020 12:28:24 -0400
X-MC-Unique: eCdqEQJWO9q7Ve2I5t1Ssg-1
Received: by mail-wm1-f72.google.com with SMTP id 18so51667wmu.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=omCX/201/bqxo8gzog+yl11Z4cOuOGzzmz618nHPnKY=;
 b=nC5YTRWmWpsWbiMBCEcRaMp1Y+/goDbox8e3n1J1MZpPP7Z+gF7Fbofi6hOWPRTJvh
 Jxg2up9QsDAsKqBI+DP3yvDfpW+u0PpciN/SOmsSGZwOnyx2/MyiLqE9gxKKK0GSQEcb
 IJDqnc0JoGUZnY2MZmF6wqmPf366PjGAa7ELIHH5hm7QAZAuN1dZY9v38drmg697uV2l
 loEerqWt1Vj+HOVrVMXaGg2iOe0UKtXG71iYGZ56VBrAV/bfShLjBjiF945L2hlV40U/
 MzUJJ6OiT0xX9vPZ6dpQwvcSg4IW3fLfmOjpg1WVudr+ZfoyPvQb3U7GlZ8bnq322y2b
 zghQ==
X-Gm-Message-State: AOAM531J/6mlaT0hzku61rLlk4kkqxn//hs00oRstfo/fPkuIxYqpjjK
 9UOTeZldJBRv3enMM0+97g1jmIG2OlVsJSAYpURx4wGXYXi3CMTaSJqCA3JN8Ur9TAa3F9RXLMx
 nGf8cE29aR4vkN70=
X-Received: by 2002:a5d:4745:: with SMTP id o5mr21454328wrs.87.1591028902996; 
 Mon, 01 Jun 2020 09:28:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhsvh0Sh74X4vryrk02aW3MiEcFKVEGIod0AiztLPpQ/auP6P3hTld4JawtUNoTUeFbJ307w==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr21454306wrs.87.1591028902582; 
 Mon, 01 Jun 2020 09:28:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1c3:280a:2d69:cc83?
 ([2001:b07:6468:f312:1c3:280a:2d69:cc83])
 by smtp.gmail.com with ESMTPSA id b14sm63307wmj.47.2020.06.01.09.28.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 09:28:22 -0700 (PDT)
Subject: Re: [RFC PATCH] qemu/thread: Mark qemu_thread_exit() with 'noreturn'
 attribute
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200601093808.13102-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a558f58-ef6f-4eac-1511-854148a419fc@redhat.com>
Date: Mon, 1 Jun 2020 18:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200601093808.13102-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/20 11:38, Philippe Mathieu-Daudé wrote:
> After upgrading to Ubuntu 20.04 LTS, GCC 9.3 complains:
> 
>   util/qemu-thread-posix.c: In function ‘qemu_thread_exit’:
>   util/qemu-thread-posix.c:577:6: error: function might be candidate for attribute ‘noreturn’ [-Werror=suggest-attribute=noreturn]
>     577 | void qemu_thread_exit(void *retval)
>         |      ^~~~~~~~~~~~~~~~
> 
> Fix by marking the qemu_thread_exit function with QEMU_NORETURN
> to set the 'noreturn' attribute.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> RFC because I'm not sure the error is correct, or we should
> simply ignore it by default with -Wno-suggest-attribute=noreturn.
> ---
>  include/qemu/thread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index d22848138e..06c058fb58 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -177,7 +177,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>  void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
> -void qemu_thread_exit(void *retval);
> +void qemu_thread_exit(void *retval) QEMU_NORETURN;
>  void qemu_thread_naming(bool enable);
>  
>  struct Notifier;
> 

Yes, it's correct.  Queued, thanks.

Paolo


