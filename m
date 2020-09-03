Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5944520716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 17:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1uxR4g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5944520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDsvU-0004YZ-GQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 13:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsul-0003z1-PG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:20:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDsuj-0001Rn-VK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 13:20:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id 17so2847302pfw.9
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d1sn/7Mq/epfZcOcZoYTxTHlh2hIZLY//znA+goV5kw=;
 b=a1uxR4g/h8fGUMtLCcoU/sOokn3ncDBTP9NxHXjcmrusGM06gBUUkkufVQbJuLJTqE
 NlWKKj2pZe09DUKDVXL5nPlSMqjYlddlrbxbRx4l/QCqE5NlnTuDY4rteiWnwspsO8Ma
 F3qKzI0yDDjJeo4ngVoghC4sxxDnRSAsqzWNseHLw/Xpat9cQTLVrp/AgBRde73b9axy
 7zv9eFzzU1Z7BLucKhB0RCG3nl3HvZRzqyiiQNxUfoeKagyN7BjSwx3T/XfEfum+BMJQ
 KuxCrO0QalcnPxHdBx+mmCK8UxSK9Eft7TGALT5MK+NwfojROTxUiGJnFMSvUJ9WhJWN
 xOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d1sn/7Mq/epfZcOcZoYTxTHlh2hIZLY//znA+goV5kw=;
 b=BkWkHPGXAnjvcowC0mY9DHhW3ld14OOOC0xcV3ssdahcktOTBFb0felmlSHBWa/vrY
 s2gc/hZ8oTrlEkhXMoa+KVrOkKXBAw/QZpsrn73hju0CPCkLzR2P87w6OxBtP7xcyVn6
 kUwl06RyzT4DnJPfHjE33ThEbh8z64B/pnbSSHqKCgxgrLZfpyIp5mO1Ne6OwE1Laoq3
 QEnKPE1yS2BC00WDCYwaBmg2ZjIks0evKPnrj0dk0/k+Q1mUKmpSWueF9zHaJkptiF60
 fu1GiPNXA+ucXmilpJlWitQCk0sY0yBLKbC/s4CDVvKKTp/xdF0UIGlLKtTnuSN4Uxc1
 aV3w==
X-Gm-Message-State: AOAM533qAQmsSHEr7jhERS1coGF9NxjvYOnJtEa4FO8JIFwnYWeXSwKo
 nV6Z8jCku4dO2UxZpeIAAFnIFw==
X-Google-Smtp-Source: ABdhPJy2F7KR2ehrSYlyiRVe/7zC0sApNZ7CoQehBc91w2r3xl8mIVCc2dijrmAR1CHlO8ifPdJm9g==
X-Received: by 2002:a63:784e:: with SMTP id t75mr3679592pgc.389.1599153644349; 
 Thu, 03 Sep 2020 10:20:44 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k5sm3922705pfp.214.2020.09.03.10.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 10:20:43 -0700 (PDT)
Subject: Re: [PATCH v4 03/12] tcg: Fixes dup_const link error
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200903083147.707-1-luoyonggang@gmail.com>
 <20200903083147.707-4-luoyonggang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8c5dd495-abaf-7abc-2ba0-82f13bbd3d02@linaro.org>
Date: Thu, 3 Sep 2020 10:20:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903083147.707-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 1:31 AM, Yonggang Luo wrote:
> Rename function dup_const to dup_const_eval for avoid confliction with macro dup_const
> 
> The link error on msys2
> 
> Linking target qemu-system-alpha.exe
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_optimize.c.obj: in function `tcg_optimize':
> E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106: undefined reference to `dup_const'
> C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg-op-vec.c.obj: in function `tcg_gen_dupi_vec':
> E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283: undefined reference to `dup_const'
> collect2.exe: error: ld returned 1 exit status
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  include/tcg/tcg.h | 6 +++---
>  tcg/tcg-op-gvec.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

No, really, as I asked before: what symbol is present in tcg-op-gvec.c.obj
without this patch?

That you need this, to me says that you've got a broken compiler.  This is
bog-standard C.  There is nothing windows-specific about it.


r~

