Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55570C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4E82073E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 04:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJAojlc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4E82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUMyj-0006Ci-Ai
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 00:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMxy-0005gJ-N3
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUMxv-0002fO-S0
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:07:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUMxv-0002YF-EL
 for qemu-devel@nongnu.org; Fri, 01 May 2020 00:07:55 -0400
Received: by mail-pg1-x544.google.com with SMTP id s18so4040210pgl.12
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=53zo227nmqhkaH2bxUIKsDvrPImSGtKqPyQI6C8DCFU=;
 b=UJAojlc8CYQugPotPXeeaT4d2AvbwPZ7dF66nyHuMqfADwPuLTirdxACle7/7VYtz4
 IMpyHP4pPa22OR6RviQFuIZG4ASmNgJrAY8fNIz3NVXJwlN20tTi9STnIAYGj6M3kxBn
 r8vfVfB8YKGDIILuhtdm7PTxhpmuoUq9F/u+5d3jlDpnqq3wpie+z8LFLGcAKDJYUBTK
 kI6TWVD/VDo8jakp3gRDhauZEeeb8iCXGwxGaZwt244G0FLkN7xSbn+vgoqopYlm1glT
 3QPZQLLRdMR/CN1NGTfG4VGTkISwEdvuaTXOO4yepEsnx67Qer7QUyS7biY3MADwrsnC
 Odmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=53zo227nmqhkaH2bxUIKsDvrPImSGtKqPyQI6C8DCFU=;
 b=gOflBEIQghXyCrbi79ZGd7azQgfDOBE5ILmNPctU4nRtEzEryRjGb0YMExjZ1du/2x
 zscQzT8aGFGPH+Rha9RQ/KWpcG6FC69yYXVea0mX2Mpd/XIyOvjBu5rfD+pgaVn5ASWn
 PV7bhGwsvczsP/CyHqCJPt0zlHl+sCOtOe8FVXmD2r5tcKNyp8JLu7oUGPdTPDqPdB55
 +hLk7DYg7hA+wrWy58D3HuV9oOrqfng1U0uIX6wmb/NTZjmlr0xnUt4HA4T5+rtiwAgI
 7nOZOy/hkexLhkC/POogw3RHNyXtJDDTE9UPpo4cm7NHHD7jJmSagMuavUZdbfC1ZG62
 N3YQ==
X-Gm-Message-State: AGi0PuajQrQ9wbAhkWtY6xX1FanKWgLef2E0+rgXq/Wnh8dArOsZVd6t
 hA7jgSbAbGmi9KLXpr1ieVoh/gBQx9s=
X-Google-Smtp-Source: APiQypKej0A43NQn0TV4Ax2/70jCvEpnDpLp/KWANDfimHBNwWnAKFUc7YB7YNPEWbGs2Yk6SRqldw==
X-Received: by 2002:aa7:9a11:: with SMTP id w17mr2218097pfj.314.1588306073505; 
 Thu, 30 Apr 2020 21:07:53 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 5sm980206pjf.19.2020.04.30.21.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 21:07:52 -0700 (PDT)
Subject: Re: [PATCH 33/36] target/arm: Convert Neon fp VMUL, VMLA, VMLS
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-34-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef96d1f3-65b3-808e-afdc-4f43f58fbf21@linaro.org>
Date: Thu, 30 Apr 2020 21:07:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-34-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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

On 4/30/20 11:10 AM, Peter Maydell wrote:
> Convert the Neon integer VMUL, VMLA, and VMLS 3-reg-same inssn to
> decodetree.
> 
> Since VMLA and VMLS accumulate into the destination register, we add
> a reads_vd parameter to do_3same_fp() which tells it to load the
> old value into vd before calling the callback function, in the same
> way that the translate-vfp.inc.c do_vfp_3op_sp() and do_vfp_3op_dp()
> functions work.
> 
> This conversion fixes in passing an underdecoding for VMUL
> (originally reported by Fredrik Strupe <fredrik@strupe.net>): bit 1
> of the 'size' field must be 0.  The old decoder didn't enforce this,
> but the decodetree pattern does.
> 
> The gen_VMLA_fp_reg() function performs the addition operation
> with the operands in the opposite order to the old decoder:
> since Neon sets 'default NaN mode' float32_add operations are
> commutative so there is no behaviour difference, but putting
> them this way around matches the Arm ARM pseudocode and the
> required operation order for the subtraction in gen_VMLS_fp_reg().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 49 +++++++++++++++++++++++++++------
>  target/arm/translate.c          | 17 +-----------
>  target/arm/neon-dp.decode       |  3 ++
>  3 files changed, 44 insertions(+), 25 deletions(-)

Note that we do have helper_gvec_fmul_s, similar to fadd before, but currently
no mla.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

