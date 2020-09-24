Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5E7C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D144221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 14:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gztE+H7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D144221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRsu-00045v-4B
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 10:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLRs2-0003Xh-4n
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:05:14 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLRrw-0000i4-Km
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 10:05:13 -0400
Received: by mail-pf1-x444.google.com with SMTP id o20so1952427pfp.11
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=37rQjxTXR7LVn5iZ9zVEOcoBYYaaawOYY/P9gI1e2i0=;
 b=gztE+H7dGxWDePpcDkweDK4NzoRKBl3xIa2BBn0vMMxiiAXZ2oKb4N8BB/XC8iCfl7
 Hwz6mAJSVY3NTs9StaGwXZe9utQMkKi/QKOTZG2aSpsrBlJiHL3/pdhxQ9jGLF1IlvRQ
 RpU5QfEu8TjA24u6XGSaWZ4uaca/rqUL2N/dfvWYq2WVrqJV7rJUjUm7Yckkeaspc5O0
 jSQR9phI3r8cVeyprvdiGLa5jdCWpUW4u0XuFYgF/C/2QEIH2YxjXTSg3DZtSy7VYFLy
 /HsQizk3wl7iL1LffqAKTyFWjrRC8DZCPGxfjCJvM3H/RoP3SoAsS8rAYjRm3XQp8OGB
 Ey2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=37rQjxTXR7LVn5iZ9zVEOcoBYYaaawOYY/P9gI1e2i0=;
 b=lyyOCQpsOh4REEFrcTkZlL8g7BUYkU5MERYg8WlCrIsiciV2VV6fTrMJi2lXvUK+TG
 CGd3qJHXmUxx7NKTm64QW+dbYsq5yLykjA1V7SE4RRzMy4nfOeVB9ngUtcxakSa8XF75
 mNjnG1/wdZDr2Nj1W085yl24invtMN7phAhXxV5FUmoJz/ZmL2cNIxucgkZZvIWmszYB
 Fz4gzOn8sk2e0xkJ8/iPew8Onp8kF7Ye+p11+2WrvWt/ji4iSpsJQPh+oP3YCa1OVhKj
 5cGNEEmi7BbSWbNw99DMO4GP5fQyMbrKM4UkGuUXOK2ps7uN9vHlM1ZKCUjE6roAEyJX
 ZlUg==
X-Gm-Message-State: AOAM531P1us9iIkemiSnCn2pCgFj5nVQCZ/HtQYd4jhkV91tt0n1FAwD
 c3FTyYWABZZDbkUvlJDiMRbWpw==
X-Google-Smtp-Source: ABdhPJzO/iILVUgVHOC9DOZWHho7+lr5wcs+hQCXWXEMm3pwvF8lXnnEIu9r5FeRMRsV6oxYm2aI7g==
X-Received: by 2002:a63:5d61:: with SMTP id o33mr4256258pgm.355.1600956306781; 
 Thu, 24 Sep 2020 07:05:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h15sm3297708pfo.194.2020.09.24.07.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 07:05:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] accel/tcg: Fix computing of is_write for mips
To: Kele Huang <kele.hwang@gmail.com>, qemu-devel@nongnu.org
References: <503406> <20200923093800.9845-1-kele.hwang@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74c6f6d4-714a-4f8d-71fd-185cf3b35655@linaro.org>
Date: Thu, 24 Sep 2020 07:05:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923093800.9845-1-kele.hwang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
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
Cc: Xu Zou <iwatchnima@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 2:38 AM, Kele Huang wrote:
> Detect mips store instructions in cpu_signal_handler for all MIPS
> versions, and set is_write if encountering such store instructions.
> 
> This fixed the error while dealing with self-modifed code for MIPS.
> 
> Signed-off-by: Kele Huang <kele.hwang@gmail.com>
> Signed-off-by: Xu Zou <iwatchnima@gmail.com>
> ---
>  accel/tcg/user-exec.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index bb039eb32d..18784516e5 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -710,11 +710,60 @@ int cpu_signal_handler(int host_signum, void *pinfo,
>      greg_t pc = uc->uc_mcontext.pc;
>      int is_write;
>  
> -    /* XXX: compute is_write */
>      is_write = 0;
> +
> +    /* Detect store by reading the instruction at the program counter. */
> +    uint32_t insn = *(uint32_t *)pc;
> +    switch(insn>>29) {

This would be easier if you simply looked at the entire major opcode field,
beginning at bit 26.

> +    case 0x5:
> +        switch((insn>>26) & 0x7) {
> +        case 0x0: /* SB */
> +        case 0x1: /* SH */
> +        case 0x2: /* SWL */
> +        case 0x3: /* SW */
> +        case 0x4: /* SDL */
> +        case 0x5: /* SDR */
> +        case 0x6: /* SWR */
> +            is_write = 1;
> +        }

So this becomes

    case 050: /* SB */
    case 051: /* SH */
      ...

I know there are some who don't like octal, but IMO MIPS and its 6 bit fields
and 8x8 tables is a natural fit -- one can read the two octal digits right off
of the table.

Otherwise, perhaps you'd prefer binary constants like 0b101000.  But with these
tables I find the mental bit-extract from hex to be tiresome.

> +        break;
> +    case 0x7:
> +        switch((insn>>26) & 0x7) {
> +        case 0x0: /* SC */
> +        case 0x1: /* SWC1 */
> +        case 0x4: /* SCD */
> +        case 0x5: /* SDC1 */
> +        case 0x7: /* SD */
> +#if !defined(__mips_isa_rev) || __mips_isa_rev < 6
> +        case 0x2: /* SWC2 */
> +        case 0x6: /* SDC2 */
> +#endif
> +            is_write = 1;

Similarly.

> +        }
> +        break;
> +    }
> +
> +    /*
> +     * Required in all versions of MIPS64 since MIPS64r1. Not available
> +     * in MIPS32r1. Required by MIPS32r2 and subsequent versions of MIPS32.
> +     */
> +    switch ((insn >> 3) & 0x7) {
> +    case 0x1:
> +        switch (insn & 0x7) {
> +        case 0x0: /* SWXC1 */
> +        case 0x1: /* SDXC1 */
> +            is_write = 1;
> +        }
> +        break;
> +    }

This switch is incorrectly placed.  It must be within the first switch, under
major opcode 023 (COP1X).  And again, you should extract the entire 6-bit minor
opcode all at once, not one octal digit at a time.

> +#elif defined(__misp16) || defined(__mips_micromips)
> +
> +#error "Unsupported encoding"

This is incorrectly placed, because we've already successfully entered the
preceeding #elif defined(__mips__).  This needs to be

#elif defined(__mips__)
# if defined(__mips16) || defined(__mips_micromips)
#  error
# endif

int cpu_signal_handler(int host_signum, void *pinfo,
                       void *puc)
{
   ...
}

#elif defined(__riscv)



r~

