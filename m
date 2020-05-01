Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C38C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB6320836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHNPadbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB6320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZ07-0002xp-6q
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:58:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYyv-0001fg-M4
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYxt-0006UM-6L
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:57:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUYxs-0006QP-PU; Fri, 01 May 2020 12:56:40 -0400
Received: by mail-wm1-x341.google.com with SMTP id h4so298382wmb.4;
 Fri, 01 May 2020 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AERUYqi+ho3RVgMTEsAXXKJQB7G9nCVFcF4XCc9qPH8=;
 b=RHNPadbSAlb9N0+Lsc7N2rIB7jKlkGP+HML2bonjQJjG1T4jWeaXvtk4Oojl6SsrU/
 ADu9JQBcZgAXIcOymEXzn6W+i4BJNZdtf7R510mO75frv40Jv6VvNJs1nzE2uPd54gdd
 rxU+0WqFj5eyvlqsnguWDODggulDPfcTcFEKM+JAD98HXP/mQXoaBWOIbmtjuWTo1W8f
 Co44vf7r6nE4VcrSEv9XyUf5WdiqKGdQcpJS+TwDYbkZCe/AzFnGviVxMyaq1ALGpRTc
 /04l4+aMQ1auUH6+PCchHQWbM2x7mR82IeHoMW0+x9EjJYTLwSn3BIIUKE/tGUZ3ncdR
 V6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AERUYqi+ho3RVgMTEsAXXKJQB7G9nCVFcF4XCc9qPH8=;
 b=H14USWF4QyudZ+T2vFs/p8gRa75yK7INhb+FjWgmJFIC0f6H8bJN2MMHbFaYhJIQLk
 4q77JiTyy09JZUUKEUszKqIimtq1+rZuWi5YcahHhu6tWDJVf6YIVm3FTbqPOcfKg8zH
 n56eC3BDhwu/qn5uP2jgxvVTW1to6KDQMQO4gunqNj+iINWPGvXTmPKkMY8/G18k5Rhk
 Gbe/kArW5LIbBOlA0AXZYVYx6JKNWQxnFN3O/dW2E9QuLQsjrKXbFmY3d54ZMXcN823g
 1GruF68VWeAaA17L4zah6nXm12XeOUX+5127GwfqqHaUuf8a0pLrFb6F5ZlRHNOrFIWh
 sZMQ==
X-Gm-Message-State: AGi0Puad1c3Gjqra4OW/moN3thCjPaFqIJ5cEhZswfHv4z7OFXRXLvvB
 LAdtXrVhtq/XpF8sQiqKYfvFU2L4Oaw=
X-Google-Smtp-Source: APiQypLjEeTfyDjYdTfp9RP2GKDYS4FEFuxbv9tYSihgVk1NKI1m0Oq3NRcqOsb18qjfkbLJcmG9cw==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr457745wma.30.1588352198848;
 Fri, 01 May 2020 09:56:38 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id r3sm5337316wrx.72.2020.05.01.09.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 09:56:38 -0700 (PDT)
Subject: Re: [PATCH 02/36] target/arm: Don't allow Thumb Neon insns without
 FEATURE_NEON
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a297b20b-718e-6c34-85b4-09b0520f023f@amsat.org>
Date: Fri, 1 May 2020 18:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 8:09 PM, Peter Maydell wrote:
> We were accidentally permitting decode of Thumb Neon insns even if
> the CPU didn't have the FEATURE_NEON bit set, because the feature
> check was being done before the call to disas_neon_data_insn() and
> disas_neon_ls_insn() in the Arm decoder but was omitted from the
> Thumb decoder.  Push the feature bit check down into the called
> functions so it is done for both Arm and Thumb encodings.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d4ad2028f12..ab5324a5aaa 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -3258,6 +3258,10 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
>       TCGv_i32 tmp2;
>       TCGv_i64 tmp64;
>   
> +    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> +        return 1;
> +    }
> +
>       /* FIXME: this access check should not take precedence over UNDEF
>        * for invalid encodings; we will generate incorrect syndrome information
>        * for attempts to execute invalid vfp/neon encodings with FP disabled.
> @@ -5002,6 +5006,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
>       TCGv_ptr ptr1, ptr2, ptr3;
>       TCGv_i64 tmp64;
>   
> +    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> +        return 1;
> +    }
> +
>       /* FIXME: this access check should not take precedence over UNDEF
>        * for invalid encodings; we will generate incorrect syndrome information
>        * for attempts to execute invalid vfp/neon encodings with FP disabled.
> @@ -10948,10 +10956,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>   
>           if (((insn >> 25) & 7) == 1) {
>               /* NEON Data processing.  */
> -            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> -                goto illegal_op;
> -            }
> -
>               if (disas_neon_data_insn(s, insn)) {
>                   goto illegal_op;
>               }
> @@ -10959,10 +10963,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>           }
>           if ((insn & 0x0f100000) == 0x04000000) {
>               /* NEON load/store.  */
> -            if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
> -                goto illegal_op;
> -            }
> -
>               if (disas_neon_ls_insn(s, insn)) {
>                   goto illegal_op;
>               }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

