Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2657C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A261520656
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwWZ3UDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A261520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEyF-0008CC-NG
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEwI-0006k9-6c
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUEvT-0004Iy-3z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:33:41 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:34838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUEvS-0004Ed-Lh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:32:50 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ms17so1270703pjb.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=PFgHzcWxXXD4Rdl+GsSG30wPNWmZLE0pgZMLsUnVXBY=;
 b=wwWZ3UDr4s7WgzJuhkn2ukXgJVtRmfuOif2cwgmAEQ3CwMlkvWvoTzjqKuyLNE9Nnp
 uU5Swox2iFK5RuF+gsnUanTKKzZIOtqxgbXMLeJvXjlRXgHEBX31qlhva2WRXzhCAqGt
 kkYFzvRjTIJDOeLcpuJr5L6fHvUdboqIMTVEJTW3v1PMArW7CHa/w2noWmzCzt+6dKvm
 xAiCZtWOJ//fr8ZK4xAA5K2A/QFwrnARZTtFTDy0KAFIEgyQv/71GUXNJoL9VmbdO4AR
 nTLaF8sdPOOc6dLG/zb2C1LNKE6/hczHyvVbmLk/aPEw9uLEuvZ2sXcmrX0UA5God2pA
 D+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PFgHzcWxXXD4Rdl+GsSG30wPNWmZLE0pgZMLsUnVXBY=;
 b=CpenI4FwReXfQnEbn74a66Ov5cVFxYRUeTyAdcOUBwjMzEVERIiNA9gEBUCarkaZPw
 UyKJXdxmbh7PK5C+Fq0BPEqfOHscrFJX2CZQWJqGSqtU9GCDuuZvdlpMb1VqWPFL/D/Q
 z3fSoxYTbLQMXzcOF1to/0avX/zh7Vonl80qw/MOFNuPB9qojTL4pklfzudcqICXe3Nh
 nm+K0sIrBQao8jAnq0dXGErpcSKB/cIJDcfBc/slznAqC9nlguSbxktU5JOoPIFzwKY4
 6hlXVce5ppNI2AQwTNUfuJ3pLSiKzZikbMKElGujPJPqc+er8MrK8F6VSx1GvsBNTCZt
 fX0w==
X-Gm-Message-State: AGi0Puahllzf2FWm/gz7uOOK8u0pvJj7gLdVfE/sR7KWTNs1Igu642Zz
 huJlztIIBWbylLZk5XheKg9X786j6mg=
X-Google-Smtp-Source: APiQypIEU8QFp8t4u8rseNPBgS04f6oDlvZfnl42j2pI88Ocva6KRWYaJF+TDjcOSI4Uz2vWCOq6kw==
X-Received: by 2002:a17:902:b20e:: with SMTP id
 t14mr529804plr.223.1588275168846; 
 Thu, 30 Apr 2020 12:32:48 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id q21sm461511pgl.7.2020.04.30.12.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 12:32:48 -0700 (PDT)
Subject: Re: [PATCH 13/36] target/arm: Convert Neon 'load/store single
 structure' to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fb49237-362c-120e-cd45-68645efddbc0@linaro.org>
Date: Thu, 30 Apr 2020 12:32:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1043
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

On 4/30/20 11:09 AM, Peter Maydell wrote:
> Convert the Neon "load/store single structure to one lane" insns to
> decodetree.
> 
> As this is the last set of insns in the neon load/store group,
> we can remove the whole disas_neon_ls_insn() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c |  89 +++++++++++++++++++
>  target/arm/translate.c          | 147 --------------------------------
>  target/arm/neon-ls.decode       |  11 +++
>  3 files changed, 100 insertions(+), 147 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

