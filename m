Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B2C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 14:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075B2214AE
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lM0WzvT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075B2214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZcAo-0001lE-0q
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZc7n-0008VT-7O
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZc7h-0001lk-PG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:15:11 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZc7e-0001hx-2W
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 10:15:06 -0400
Received: by mail-ot1-x344.google.com with SMTP id r6so214944oti.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KwnGJ9GqB1RWry5OQZTGJUU9tTViCTx8zwYcMYqxefg=;
 b=lM0WzvT96nvZmIIkiw0FmRAqCNA8V1XdjUBr40BkmKF/GEEMKTBeQRZbEx9F5bUlP8
 GvId/XVvaKsUGolpAIhkXEvB14XVbYWGEyA3S+9AOxNAgrSYirOrixH1ac1Jaav5Ga6C
 oXJfzL9diWNL0vBKuEfSdbMC2DdvieJCXJezOh/Jk2lTGlS8n+Z94f6YxHRtMWCrlDDQ
 cP6rFtBfVtSPhd6dQK6TEPTIjxB0jVDHNwzD19e2p8xS6vEuoIcWoUQKMqQnmIXW6+g2
 JdU3SBEN9CODxuIdC4uD2YF41dUrJE2GjRRYOGiDLMXbbvHHjN6TdsHrwRq7CQR1eFDL
 gqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KwnGJ9GqB1RWry5OQZTGJUU9tTViCTx8zwYcMYqxefg=;
 b=tqJ+l5MLkaJ6CCrtSopJlyWzTzYOdarqtUEHT+i/CPcJ5amoLbgOq0lLT/jyfaixrm
 ysHW1YxZbDXHFw8tmy05NJAGd+lyVrYGwJ/ef8/i2lzZuTYLP530NOLeZe5AEMmxXtCi
 Dqz3NYQ9104TV1vHYQSccNtmhHqj0MPGXzSdoXgV5hnIVr68t6LCj1vJCig7tGbT2ZdT
 OXY950x7IWY2MTyG4zO3WhgDFaJLDB3Ith3h1nmDNXcR6aqqfHA0HehsT/TyzNOICHrD
 zZTpK/GdD7XBFT8kshj/CotQAZHYuQfyfuwHeS138FLRhcd4jFJQjprXLfKcWxWh+StO
 vhMg==
X-Gm-Message-State: APjAAAW4qp6faZmj93pFLENNcKy4aBPZ3eiaoHY9d0vj6cEKJ81ClL3Z
 mUT2AfhhBt1e/adlMkt5g/HEpn2U+lAopA==
X-Google-Smtp-Source: APXvYqwuJemNf6Ph9RR/tOHockgkbkbXWF97diOpgAr19vt0bFIxEbW1YrIg/KzppArKt78lv3ovvw==
X-Received: by 2002:a9d:2c47:: with SMTP id f65mr23890806otb.185.1560003304161; 
 Sat, 08 Jun 2019 07:15:04 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id u62sm1355285otb.63.2019.06.08.07.15.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 07:15:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b6cf60b7-55c0-dc9c-1731-3e46dd8824ca@linaro.org>
Date: Sat, 8 Jun 2019 09:14:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 18/42] target/arm: Convert VFP VMLA to
 decodetree
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VFP VMLA instruction to decodetree.
> 
> This is the first of the VFP 3-operand data processing instructions,
> so we include in this patch the code which loops over the elements
> for an old-style VFP vector operation. The existing code to do this
> looping uses the deprecated cpu_F0s/F0d/F1s/F1d TCG globals; since
> we are going to be converting instructions one at a time anyway
> we can take the opportunity to make the new loop use TCG temporaries,
> which means we can do that conversion one operation at a time
> rather than needing to do it all in one go.
> 
> We include an UNDEF check which was missing in the old code:
> short-vector operations (with stride or length non-zero) were
> deprecated in v7A and must UNDEF in v8A, so if the MVFR0 FPShVec
> field does not indicate that support for short vectors is present
> we UNDEF the operations that would use them. (This is a change
> of behaviour for Cortex-A7, Cortex-A15 and the v8 CPUs, which
> previously were all incorrectly allowing short-vector operations.)
> 
> Note that the conversion fixes a bug in the old code for the
> case of VFP short-vector "mixed scalar/vector operations". These
> happen where the destination register is in a vector bank but
> but the second operand is in a scalar bank. For example
>   vmla.f64 d10, d1, d16   with length 2 stride 2
> is equivalent to the pair of scalar operations
>   vmla.f64 d10, d1, d16
>   vmla.f64 d8, d3, d16
> where the destination and first input register cycle through
> their vector but the second input is scalar (d16). In the
> old decoder the gen_vfp_F1_mul() operation uses cpu_F1{s,d}
> as a temporary output for the multiply, which trashes the
> second input operand. For the fully-scalar case (where we
> never do a second iteration) and the fully-vector case
> (where the loop loads the new second input operand) this
> doesn't matter, but for the mixed scalar/vector case we
> will end up using the wrong value for later loop iterations.
> In the new code we use TCG temporaries and so avoid the bug.
> This bug is present for all the multiply-accumulate insns
> that operate on short vectors: VMLA, VMLS, VNMLA, VNMLS.
> 
> Note 2: the expression used to calculate the next register
> number in the vector bank is not in fact correct; we leave
> this behaviour unchanged from the old decoder and will
> fix this bug later in the series.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h               |   5 +
>  target/arm/translate-vfp.inc.c | 205 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c         |  14 ++-
>  target/arm/vfp.decode          |   6 +
>  4 files changed, 224 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


