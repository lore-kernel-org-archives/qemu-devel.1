Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27018C4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E3820715
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bT09BuYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E3820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpC6-0001IE-AD
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpAx-0000rh-7P
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:58:19 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpAv-0001F0-89
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:58:18 -0400
Received: by mail-pj1-x1041.google.com with SMTP id jw11so1893616pjb.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3XrI64iHvjaHnUh2CvQVHQtOluqE2drV5W4E+S888ro=;
 b=bT09BuYwa5mjGjCB1Zx/wMPEH8moKBfwxlNYbA1JcWdpYRHPM7GmOqZqku1KBweFTy
 db2DBpDdlLZ4b1Sx9nx4ClMZkIX8lwh5CJPebwpHNk8Bg2LcRXRjozRiGhj2InehyGNc
 oWSTdDGf48enViCJtZfpkvcmuXqj5OgXnPh0Mt21ZazXveaRjJZ02euvZ+rACpfoAtRN
 KH5vmJdh6sj+eNbGjMFYWwBXtMsW+7WtAb09/PYDXUnqH4t/KOlyZdusQbddSmH0ngBz
 Pv+Nl4FA+gVC/eehr0E4PGWka3/wXMaNmzTZF1pOeq1lB7TpexH59k+9VRfwcKFmWpWQ
 g6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3XrI64iHvjaHnUh2CvQVHQtOluqE2drV5W4E+S888ro=;
 b=kzh/bOfulLOcXHyfeNt17Akpv8MdODzA+Y+VDKuaSrkAYpDMaIGscviCJPKdJQOxOw
 KtJWPzPuyDuGtg0ehF61uaLwbrohRTiLmPPdw4uVpxc482BMAjOU7KpF/WnC/2i4Qgvm
 aWf90WSwPJPTDeBb9nnWX4VH8/PBWZG+XKyccCKZXlYCdfHkzufw0iN9IEYH3dR1DmjH
 hKO65Rar2IO+nGMWuQlFUxN1vRqr+kS6DeDpQOQkSL1/57EeQnaYIiMJFLOeR+POKnIi
 SI0lSWAtpKqsAJ5VGZhEscxevL85e7PCDevIafZoTwil1VgMW4/IBINbDfqD0nqiwmGY
 yIaA==
X-Gm-Message-State: AOAM530KKZuMvLELK8Zk/enOpTULXhQYjRas3X1ZV9rDq0L9qoGq2lhP
 Mwt2nob1ZH/Vm+Tt7S8hP+UBwg==
X-Google-Smtp-Source: ABdhPJzzWGjeDDFf0QpTzdPs8LxZElk2BeGhNZ6DrE8oHWNlwBPtnTqWzbiNaxgl8JO2KYIi3QaYMA==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr5479pji.181.1601045895603; 
 Fri, 25 Sep 2020 07:58:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a12sm3034786pfh.154.2020.09.25.07.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 07:58:14 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] accel/tcg: Fix computing of is_write for MIPS
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <20200925083307.13761-1-kele.hwang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c29d238-b7a0-4ab4-cc38-69a193f328a3@linaro.org>
Date: Fri, 25 Sep 2020 07:58:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925083307.13761-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Xu Zou <iwatchnima@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 1:33 AM, Kele Huang wrote:
> Detect all MIPS store instructions in cpu_signal_handler for all available
> MIPS versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modified code for MIPS.
> 
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> ---
>  accel/tcg/user-exec.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..c4494c93e7 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -702,6 +702,10 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>  
>  #elif defined(__mips__)
>  
> +#if defined(__misp16) || defined(__mips_micromips)
> +#error "Unsupported encoding"
> +#endif
> +
>  int cpu_signal_handler(int host_signum, void *pinfo,
>                         void *puc)
>  {
> @@ -709,9 +713,41 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      ucontext_t *uc = puc;
>      greg_t pc = uc->uc_mcontext.pc;
>      int is_write;
> +    uint32_t insn;
>  
> -    /* XXX: compute is_write */
> +    /* Detect all store instructions at program counter. */
>      is_write = 0;
> +    insn = *(uint32_t *)pc;
> +    switch((insn >> 26) & 077) {
> +    case 050: /* SB */
> +    case 051: /* SH */
> +    case 052: /* SWL */
> +    case 053: /* SW */
> +    case 054: /* SDL */
> +    case 055: /* SDR */
> +    case 056: /* SWR */
> +    case 070: /* SC */
> +    case 071: /* SWC1 */
> +    case 074: /* SCD */
> +    case 075: /* SDC1 */
> +    case 077: /* SD */
> +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> +    case 072: /* SWC2 */
> +    case 076: /* SDC2 */
> +#endif
> +        is_write = 1;
> +        break;
> +    case 023: /* COP1X */
> +        /* Required in all versions of MIPS64 since 
> +           MIPS64r1 and subsequent versions of MIPS32. */
> +        switch (insn & 077) {
> +        case 010: /* SWXC1 */
> +        case 011: /* SDXC1 */
> +            is_write = 1;

Much better.  I just noticed you're missing SUXC1 (COP1X minor 015).  With that
fixed,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

