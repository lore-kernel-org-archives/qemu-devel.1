Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305EDC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDBB20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrWsfhEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDBB20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2TIm-0006cE-3Y
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shorne@gmail.com>) id 1i2TDo-0002Rc-5g
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1i2TDn-0002Op-8O
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44106)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1i2TDn-0002OK-2Q
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:36:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so11887600pgl.11
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 21:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rqgTbmgCiR6/L3BFdrze6asCXgQcS0IHA+OvYhqvKlc=;
 b=BrWsfhEqHW1+5ZX5wm5NjiRM0Gc4Be+9UBxRcf2e8aEyPJ/dcyrHTeamiKXECxg6hd
 8AceLixyssrodMbWF+2gg8OHEUbX79Y73Us/9/MO++DdmzTo5maLfrGeqJbOh7P+5/1V
 1cWIV/zLyYPpqPs+fF47v9DZF5KtqtaczGIZiDsUgnwuAi+juWgljXgH0rC4RC9E9kMb
 cxtHvRqbvhu7JoO5YVMr6EBNjWkmqUv+XEcMOv6fs02a/cXyT1VeSArdH8yPtvokKDSn
 SWrVyOW8NYs59HL/QWCTc9uRkJUw9VJox2qNoab3SLXLBT+8AFJwQRYw/a5N7+ciHmYw
 EKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rqgTbmgCiR6/L3BFdrze6asCXgQcS0IHA+OvYhqvKlc=;
 b=FnYVr+00onT1v3Xr9TfndtlvGb45jaonWmS7Y+V7byDHUI49At5xKnIlxPRr/ERhpE
 g2O7ZVW7Mt66KH0TQhVogpBjFb/s8t4ux2gRvpqVmrC6C9/4BFvIWJNYoq8tlUWz7x0L
 uCxfKImrR4JgcMHVMh3w3/qWX5GYyTAGNrjzCN69hBZOb73mjyV9JXSJrT3dV2a1IV4w
 dFCuMzgy0Z4XNf9QOmnLxttym8m0Dshow4ndlpd/D505ZLBxfC8M18fVfJcIc5VO2/YR
 xnjOAGMvivQtJ9Xk7y26jIjlfv5EqbiNAUCr4Lr/xhdNlFm3QqqVdUEqJZbmcYTHYLgE
 pZMA==
X-Gm-Message-State: APjAAAWfgAnqtL/keLfbHiOwYAN5G/qkOa9xtDl23T4ZJEJp5+GIvIwU
 pbASP6/01ExaoZAH1QBWeyE=
X-Google-Smtp-Source: APXvYqyM+OylzPfetZo7zkfQETnmhAttIfjRRCv4iF7JTnP4lB6DSYhUBl4fZIlQhAWswQsjQG6sOQ==
X-Received: by 2002:aa7:9524:: with SMTP id c4mr24692538pfp.225.1566880601976; 
 Mon, 26 Aug 2019 21:36:41 -0700 (PDT)
Received: from localhost (g75.222-224-160.ppp.wakwak.ne.jp. [222.224.160.75])
 by smtp.gmail.com with ESMTPSA id
 v66sm20630737pfv.79.2019.08.26.21.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 21:36:41 -0700 (PDT)
Date: Tue, 27 Aug 2019 13:36:39 +0900
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827043639.GL24874@lianli.shorne-pla.net>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
 <20190827000745.19645-8-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827000745.19645-8-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 07/13] target/openrisc: Fix lf.ftoi.s
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 05:07:39PM -0700, Richard Henderson wrote:
> The specification of this insn is round-to-zero.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Stafford Horne <shorne@gmail.com>

> ---
>  target/openrisc/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
> index b9d2ebbb8c..4cc5b297c5 100644
> --- a/target/openrisc/fpu_helper.c
> +++ b/target/openrisc/fpu_helper.c
> @@ -78,7 +78,7 @@ uint64_t HELPER(ftoid)(CPUOpenRISCState *env, uint64_t val)
>  
>  uint32_t HELPER(ftois)(CPUOpenRISCState *env, uint32_t val)
>  {
> -    return float32_to_int32(val, &env->fp_status);
> +    return float32_to_int32_round_to_zero(val, &env->fp_status);
>  }
>  
>  #define FLOAT_CALC(name)                                                  \
> -- 
> 2.17.1
> 

