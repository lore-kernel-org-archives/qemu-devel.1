Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E3C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A93C206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 19:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/zSwcki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A93C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsu3X-0005p0-5O
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 15:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36861)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsu39-0005QS-Qg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsu38-0004Nf-VZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:14:11 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsu38-0004Mz-MH
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 15:14:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id c3so9259336pfa.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=z4pGP4WjxF1XK5GfFXbYasiitbFhzveAG1t7Oo1tnH0=;
 b=U/zSwckiuTpM6ZR1YvlW669dfEyyQQ8gqQqWUknQ/Z1cjFh9t6AvdbDtvkfyHTIJ1Q
 lf/m1NWq3EiYRLb8gYDaGjEm5rRcg+kZizTyj5+bKycZvyOP7IWOy3GHO52Lr9/nYaYg
 zRFIHXO/yMxRKYegMgmYQO1Q4GBuetYEkiLT/5R/NIyicIBpkR2nggedhFDf2vX4RP4k
 /RjIoA6IgfBF1r1mYOh9xERdMMfU3Co05V8cKd+KlFFGvfmQo1jhVW4HHMCFWCa2G41T
 5Heg3WE5qL0gGUTugdRp13vg2Tkt2wVxE42wJ8UG7inFi4d2m1JiAQtMfJOYnloGUBiB
 +ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z4pGP4WjxF1XK5GfFXbYasiitbFhzveAG1t7Oo1tnH0=;
 b=jAjrQ+QuJFsik6WFQpKqCuJ/Cv0V0rqZZmVxUF3xJMmSahN0M3S2cS3/GrxwTpdlMF
 CGehoqOv7S+4G2mZ9O69GHejFFhAONCe6nlT/XqHwTXQZunWgyc1p0z2A2+nF3xZR5HE
 SiQk8DY+naNBK9qy3Psb9BZUwsUf9tA4NStfC57XQbvvImbjqnlNDJthU8LZCczef23s
 Nkbcof/0xKP0piFbloh3YpvN+GhqAItpWJFiynZWpAWbdSeOzvzyuYrUJ/MNQrZglHra
 sS1pZ9JEsG6gSDgCPtQlmHZR6UGRzmzuwvSjuVkPoYrUrpS+4hxq2dM6296DDiLeRISv
 dIYg==
X-Gm-Message-State: APjAAAXvb41G+VcTaVkOtp4WAr9cDhztsQaHJlDWagV0bZ0CEyLpkvkY
 /s7NTR261r5uIdOX3IGD1Ar0gA==
X-Google-Smtp-Source: APXvYqzMYwcxryOE7n7DFLGb2KDKeDtm+oe5Yx8TJpEAt2L1cvGdka1Z8P9J80zg2ZNdxsHJthulqA==
X-Received: by 2002:aa7:940c:: with SMTP id x12mr49734019pfo.80.1564600449501; 
 Wed, 31 Jul 2019 12:14:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s185sm102548340pgs.67.2019.07.31.12.14.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 12:14:08 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-8-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73dabf94-ed02-ac18-5a08-97249fba84e6@linaro.org>
Date: Wed, 31 Jul 2019 12:14:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731175702.4916-8-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [RFC PATCH v1 07/22] target/i386: add vector
 register file alignment constraints
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 10:56 AM, Jan Bobek wrote:
> gvec operations require that all vectors be aligned on 16-byte
> boundary; make sure the MM/XMM/YMM/ZMM register file is aligned as
> neccessary.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  target/i386/cpu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

