Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C699C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73872206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sktpm2xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73872206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3165-0004DO-IB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k315I-0003LF-07
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:50:44 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k315F-0003oE-3F
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:50:43 -0400
Received: by mail-pl1-x642.google.com with SMTP id p1so23548458pls.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L6j6wTLrYcGEQez5Lc2cx4bNIZMf/Lgvi9QLPye3XRg=;
 b=sktpm2xVPZcEUvDkfz3Xe+KbokbkJJTuLGmwQ8vV9eQFkEbC2z+u3pWWw6zkOLIYg9
 m8IyvZc9W7mFEbCNM7MSKlIoX5DOdrHp8b00WgdB2Ilrqcr7tuBLu/C22f1gA3+cj3RH
 YsE8d1iP/bKPQGFH4IYSlWawHE8TIldYknLf2q7GRZL+2/7ZtJlnips49g6wdi2Zyf05
 cyldFT98jkBleTki76H9PQKYhaFvRQc1FMJc5yJ743Vh88ybcacXMpmYwu4Kqzs4tEV1
 1k7dAQDrrjjuDEmbtjs0tg0pfBgB0qYU7UorqrklKZwhBZ5G5gOgxUZ5oAbT5HB/Zbcu
 3mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L6j6wTLrYcGEQez5Lc2cx4bNIZMf/Lgvi9QLPye3XRg=;
 b=oCpbmwASM75U5Cr7Vh4kVkgo0FY1Qo9gldqRgrI5Zj7I0zii7lM9KZC6JwsScLFAIo
 d5ZM1OvDMZSYI5rzoCljuV0zQkXnAHDb7wR13fhotVDevp8i6SjZE941Pajuj9oN29mb
 RdVJtZkK8MJWmAPGZpq+9uB/25un23DPJSsE1jr9Cy/xlL97QMrdXuG/NPHQmGDCNMB2
 kVMdVMsav+E2P7NMARgLsJy7bya66/vU43TFpUUb9GbIovtrZEcx41XHjeFCP75t1QsD
 margi+Onq9gs8NQl9iURrUZldiuBiArk4o1NVu0apAXu62WtyuhOELVSgerEXm++z21J
 m3Ag==
X-Gm-Message-State: AOAM530XFxoPO3xAssmiX6DAJ6Vosd5dDyP5GxImBbOrFoLNIyqNqDpw
 Qx9zoq2d437FAhNI4rbfmt5cAg==
X-Google-Smtp-Source: ABdhPJzmyryRPiZdjcVaCpGkyhgnasM0n5bx2MCeKOl/c7DH5oC04qYpFkOObh2v/Bb3r0ted4CAjQ==
X-Received: by 2002:a17:902:820f:: with SMTP id
 x15mr20318376pln.105.1596563439236; 
 Tue, 04 Aug 2020 10:50:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w7sm9113908pfi.164.2020.08.04.10.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:50:38 -0700 (PDT)
Subject: Re: [PATCH 08/11] stubs/notify-event: Mark qemu_notify_event() stub
 as "weak"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-9-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1cd4b50f-7195-ac05-cd37-c7681747fbf3@linaro.org>
Date: Tue, 4 Aug 2020 10:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-9-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 10:00 AM, Thomas Huth wrote:
> Otherwise there is a linker error with MinGW while compiling the tests:
> 
>   LINK    tests/test-timed-average.exe
>  libqemuutil.a(main-loop.o): In function `qemu_notify_event':
>  /builds/huth/qemu/util/main-loop.c:139: multiple definition of
>   `qemu_notify_event'
>  tests/test-timed-average.o:/builds/huth/qemu/tests/../stubs/notify-event.c:5:
>   first defined here
>  collect2: error: ld returned 1 exit status
>  /builds/huth/qemu/rules.mak:124: recipe for target
>   'tests/test-timed-average.exe' failed
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  stubs/notify-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

That doesn't make sense.  Since the symbol is satisfied from main-loop.c, it
should not be pulled in from libqemuutil.a.

What's really happening here?


r~

