Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBB7C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1D720838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 16:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFZQ6WT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1D720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6GMf-0000Nt-La
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 11:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6GM4-0008Ei-Sp
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6GM3-00076S-MP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:13:12 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6GM3-00076B-FD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 11:13:11 -0500
Received: by mail-pj1-x1042.google.com with SMTP id j17so4400552pjz.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 08:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ytd2liUqDMuwmba0gpu1DGVBZf23bwevs9YQqFkwl5o=;
 b=gFZQ6WT7AvAF65u4jtf5AROK+QsZ6DinOEE2tVvIOrdDTl/CGMBctQAwqU5sj7nBSb
 wn3cpKpD8FYPOUQGoeJ20WWKHQfau+ftM6KWEASHb2mqjNRch2rXCMah8m7wC+Hg6crq
 GfRNkdQKzpNROFUfcMh9/RxL1yEs79ycNxknLFsJwl1gAHeuqeQEweDAHOuSoNjQJwjD
 TrGqEqMK1uiP/4nVBQwBaFOyxX6Vgi26C0gHfaIuFd2bf7T8s8O9OknOq8k3H/VXfQlh
 nEJbBb9jmQz69Rwq9nlgjmCQrFe5keJkelRah0FbFCWEeZ0rQe2+NNf1wWIpMiUba9yA
 cLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ytd2liUqDMuwmba0gpu1DGVBZf23bwevs9YQqFkwl5o=;
 b=qsaajcaeUORuFrIQljPZ/6tQwuehlfuzgFFPQlWkmERgm8pejza2mlQQsoedDCthgp
 G42FobwbywGwmMokgvOyq0MSt4IWsuGK9DA7j46p3p3vSVcR79lvGweudWqyJFrShsBH
 mksBfwvUFSyeAscUAYbVJ+s/tjIfUlr552XNSs1DV0EZ7dbeJfPXcon9NJzhCqvlobLw
 Emj11xV8BYwqf32dKA6PLXYajutrnkkELyoG24wLcqYSn41i2gtx/HM7S7CiHPHJ5TK2
 yRsLT5C1MI+2OpMqQBRisZOKTIDH4+YIvRb1nH4wNahUYEPjb6IWdMCxV5tYLynyGoxC
 dWoQ==
X-Gm-Message-State: APjAAAWUa/bFCR+aQN9sJYgnW4if8J0Pv4rTcpfCCR0bWq2KXgO3iNzb
 n/bIbTCyn+CI7xmEnQ7cE8PMAA==
X-Google-Smtp-Source: APXvYqwhq0VvvxP0EXTOLTF+A3+0nogzJHf9aQZ40qfpY5TY/lNZuKP+3Gbrqh84P3hnCc7Kkt0okA==
X-Received: by 2002:a17:902:9a08:: with SMTP id
 v8mr10896107plp.192.1582560789877; 
 Mon, 24 Feb 2020 08:13:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 y9sm13663268pjj.17.2020.02.24.08.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 08:13:09 -0800 (PST)
Subject: Re: [PATCH 2/2] util: add util function buffer_zero_avx512()
To: Robert Hoo <robert.hu@linux.intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, laurent@vivier.eu, philmd@redhat.com,
 berrange@redhat.com
References: <1581580379-54109-1-git-send-email-robert.hu@linux.intel.com>
 <1581580379-54109-3-git-send-email-robert.hu@linux.intel.com>
 <ee2ef44a-737b-e989-7f20-18a69e19d430@linaro.org>
 <160d077042713fc46b36650946712a43e6e89b51.camel@linux.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b8fd7a0-9cb8-aab8-0f1b-4a77dd7a6378@linaro.org>
Date: Mon, 24 Feb 2020 08:13:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <160d077042713fc46b36650946712a43e6e89b51.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: robert.hu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/23/20 11:07 PM, Robert Hoo wrote:
> Inspired by your suggestion, I'm thinking go further: use immediate
> rather than a global variable, so that saves 1 memory(/cache) access. 
> 
> #ifdef CONFIG_AVX512F_OPT   
> #define OPTIMIZE_LEN    256
> #else
> #define OPTIMIZE_LEN    64
> #endif

With that, the testing in tests/test-bufferiszero.c, looping through the
implementations, is invalidated.  Because once you start compiling for avx512,
you're no longer testing sse2 et al with the same inputs.

IF we want to change the length to suit avx512, we would want to change it
unconditionally.  And then you could also tidy up avx2 to avoid the extra
comparisons there.


r~

