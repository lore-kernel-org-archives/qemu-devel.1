Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D79C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11A5207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNN9k0N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11A5207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30qV-00028x-Uh
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k30pN-0001D6-KR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:34:17 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k30pL-0001YE-Sq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:34:17 -0400
Received: by mail-pg1-x543.google.com with SMTP id s15so11161843pgc.8
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OqBkPgwcD0qsf/kF/EckR3fpeJHhj7GlWBWUw2EOXaA=;
 b=oNN9k0N7/Es9EFEfgSuVGp96hkQNKLHat/YkPLPklDh0cjAn+a/i02Zd3D9dw7AciJ
 4l4CWoIGBj9SfETVGIeoM2Wp6Utpc2heasINLUIxhq1P8H8hsZwA6WZ32Li/1/ktT4Iw
 G9i7w1pbxc7OrFQjpd1LLFA+mvf7dLcdX/NB5hwLTeVfeNPZJDlRQM5dkRzzwhhZTBDo
 Yq99iqjUMcyk2NcKJvxT0VL2Rfd2AoQVL4niZ6B581sZgDRm+vl/KjHGqHbOnv9Y3OL8
 q8Vztq+U/PuEVqR5DwoFIUrmOSpyTNgIeFVkwahfg9TeQIFRdAmNqeyY/5WCBA/6qRJK
 cdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OqBkPgwcD0qsf/kF/EckR3fpeJHhj7GlWBWUw2EOXaA=;
 b=h46zrRoW6qowty8pNCl7ObJ3KMrMlVpSw5z9L3ELCOuVinXHcRf0rYeVRN3RMdDInL
 33mPVNl2asSQBhGm0wp6X9AyJcsnlzcYwiMR8tGt1hXRYoch5rljbMnVl+k4o+jVnZQb
 OHBIEiQxtaQ6WVlVhcQsbfsIv3OotZA9cpxft1jZ0z0bG8T+yhk8NO6P9HTR48TNmu/g
 5Pw0sGB0oaojvDDBw5Q4uobbdcJFyFdBggd6Q49oKvG41zt2h4UsTwbmUlHQ71+AzJrt
 /2zf6bQIuxvubYeLcj62S4xskDVwu3iMuDPZ06aADABwlwmNxX/VUfnz5gTsELZUpEf5
 36VQ==
X-Gm-Message-State: AOAM533lBWqI4yzSpafgiFhVFoljqh8E6ddULOI/1pZtVpgQfnQ3cdNp
 Wi++UHA1dnwXjbxiawG8rmaxgg==
X-Google-Smtp-Source: ABdhPJyhOP2YwynEEpOtrMcfq6akGQbwC/HPNtTFalsuHi0nQjJx4aqdABfn3lXBAnZ1Z4v5tZDClg==
X-Received: by 2002:a63:4861:: with SMTP id x33mr19380547pgk.448.1596562453321; 
 Tue, 04 Aug 2020 10:34:13 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r77sm25105682pfc.193.2020.08.04.10.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:34:12 -0700 (PDT)
Subject: Re: [PATCH 02/11] target/riscv/vector_helper: Fix build on 32-bit big
 endian targets
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-3-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2769c099-5f2b-4fe3-8673-942b96521332@linaro.org>
Date: Tue, 4 Aug 2020 10:34:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
> The code currently fails to compile on 32-bit big endian targets:
> 
>  target/riscv/vector_helper.c: In function 'vext_clear':
>  target/riscv/vector_helper.c:154:16: error: cast to pointer from integer
>  of different size [-Werror=int-to-pointer-cast]
>          memset((void *)((uintptr_t)tail & ~(7ULL)), 0, part1);
>                 ^
>  target/riscv/vector_helper.c:155:16: error: cast to pointer from integer
>  of different size [-Werror=int-to-pointer-cast]
>          memset((void *)(((uintptr_t)tail + 8) & ~(7ULL)), 0, part2);
>                 ^
>  cc1: all warnings being treated as errors
> 
> We should not use "long long" (i.e. 64-bit) values here to avoid the
> problem. Switch to our QEMU_ALIGN_PTR_DOWN/UP macros instead.
> 
> Fixes: 751538d5da ("add vector stride load and store instructions")
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/riscv/vector_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


