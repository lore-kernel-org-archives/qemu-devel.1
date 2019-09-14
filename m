Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD88C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 17:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3652067B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 17:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMoc46P0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3652067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9BR0-0001xb-1r
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 13:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i9BPR-0001Dn-MN
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i9BPQ-000112-DK
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:00:29 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i9BPQ-00010I-3B
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 13:00:28 -0400
Received: by mail-ed1-x541.google.com with SMTP id c20so20589570eds.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MicksqALfdlFHDKbclLmzXFPc7ny7peoEdxsVDWuN5Y=;
 b=RMoc46P0by3Bk/Jiq7kse0gCQJth3A1ysJfCIKnCqWMsnM3XPXVpSN9NhG9dzJ6+Pl
 o62SfSPnHMs3J6gukx8GMuLEElDA+MS/KwcMVM+GYeuUXnVRmijskKbPZPk+tgk4qosq
 NXIKF08pXinIdQNrYAMyvYg2ZxaMLcuqkNCq50uok/QL7PF2I7Ulwtff6ZfjqyTpsY18
 1dlybuPoIRIqtJs686IAQXmYEy80+Nj3rPhNuKTh4j+rOXnr+2XPpsZ7Ea/EfDA3aPD6
 hsSELwVqlmILPmrobBrSflkfFBzECY5mxxjcKpFFRNRATT+5/x4zdy7KIVnsD/udjD7E
 ZfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MicksqALfdlFHDKbclLmzXFPc7ny7peoEdxsVDWuN5Y=;
 b=he9UqbvBqTIWU448E3mPYAbKtEFnLrivWOtk2dBVIHOUeOwSxT6zeKGMvmzeO9YY94
 PR5AoGM93uA8xF1x4Wn4j4bHw0J2NxTQW1PZ1M9q5WIKrMAzYpzsV6cMV3kC3SvKXvSg
 DfH2Qg2ExLJKydUyVbYCm5+K8QVrFAi9UfBTLBO6dd3VHDQctn6TDvqDZq1pQB5Ir8zc
 vdLCJ+rDpmqAwSxz27mCMHPgIpmfWO3tv8NFoQXbXBcbzQCua24ayFF4WeaVEXpwiOyV
 d09dYK8HpdT/7itSp+QpeDwwFZ4+j/ghjQ731TtgGjwAqIQ3VhYLTI1OwXNTpvbs2GZV
 WaOg==
X-Gm-Message-State: APjAAAXWNYy/0pUZEbNVnSulS4DWlS8fuqID26y6lAcJZROCIINskkML
 6Ovutrm0MgCBZRXIpxoml/2Pdw==
X-Google-Smtp-Source: APXvYqyM3qSddCoCMr8XPhSk64zM2ZlDIzmE+Hpj8w4hADfgeDLOKVSJc5Wf/3OiLdsj9uuNj6+n5A==
X-Received: by 2002:a17:906:3543:: with SMTP id
 s3mr16035541eja.240.1568480426412; 
 Sat, 14 Sep 2019 10:00:26 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.21])
 by smtp.gmail.com with ESMTPSA id f36sm5864756ede.28.2019.09.14.10.00.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 10:00:25 -0700 (PDT)
To: "Paul A. Clarke" <pc@us.ibm.com>, qemu-devel@nongnu.org
References: <1568292868-5067-1-git-send-email-pc@us.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c39334e3-46f9-1973-11d0-c862ce80cc8b@linaro.org>
Date: Sat, 14 Sep 2019 13:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568292868-5067-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH] ppc: Add support for 'mffsce' instruction
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/19 8:54 AM, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffsce' instruction.
> 
> 'mffsce' is identical to 'mffs', except that it also clears the exception
> enable bits in the FPSCR.
> 
> On CPUs without support for 'mffsce' (below ISA 3.0), the
> instruction will execute identically to 'mffs'.
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
>  target/ppc/translate/fp-ops.inc.c  |  2 ++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp-impl.inc.c
> index 59a4faf..34edc45 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -639,6 +639,36 @@ static void gen_mffsl(DisasContext *ctx)
>      tcg_temp_free_i64(t0);
>  }
>  
> +/* mffsce */
> +static void gen_mffsce(DisasContext *ctx)
> +{
> +    TCGv_i64 t0;
> +    TCGv_i32 mask;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +
> +    t0 = tcg_temp_new_i64();
> +
> +    gen_reset_fpstatus();

Note for future cleanup: we should not need to sprinkle these all over.  This
should be the steady-state condition after softfp exceptions have been
processed into powerpc exceptions, after every single fp instruction.

That said, you're mirroring gen_mffs here, and the cleanup should happen globally.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

