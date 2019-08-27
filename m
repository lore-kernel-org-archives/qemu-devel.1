Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC6FC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE8C20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 18:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T8zsZ8we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE8C20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gaz-0007AP-Tu
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 14:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2gZp-0006eV-Kf
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2gZn-0002Gi-LZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:52:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2gZn-0002FW-8b
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:52:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id 196so14677377pfz.8
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7gXsY1D0PE8Un3fsC55E/pTH3zEl33nhH0yw5zo3lJU=;
 b=T8zsZ8weNVNBZz2rjkcPnShfOWlY3WQ9d1uQzn2u+0joZ3uP3is1BKXTuQQuFPmkZu
 +BKwqjp2kRTpga95FLEMDADxI/n2qBQEMgeo22N0jJn4SH++apQi7cLEl49sGIwn5bAQ
 OhslJaQOWtU5Kla7Fs+FIEkavYjoYBczCNRx3mNNXs/6mVfwvEVqR+e6ZZXGKe2Eu00m
 PAxBOY+gE3J9HuBd1BfVPMPE9MXJtuSSUYkd19wcc5DJEXy1nJwNsmtTuPWFkKoFCYhx
 MPwBTjIg5lcZrG0bVPhVghqDAzKG94eGzwK86pGK3CSbd5gVd2CkSujH8zUGxmSH1Cbx
 SbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7gXsY1D0PE8Un3fsC55E/pTH3zEl33nhH0yw5zo3lJU=;
 b=eBHAYS6dj7Nm2wKp08qHtjjvtJQTpXSWPnnGi5WQWyNyLhgS58SVKCgRjzXh2FJJ2E
 TZOb1qmduqyh/XTESS93qX0jYrf7/MGHof08x8zefJ+uakMNhEund2H5U6KoA0DFbeHb
 CE+djUKHvYNF9sn2R9DefcL0DHV8mt61Jo4Ua4PizYRMklZfaxu+YZHP0fP+liF8F6Dr
 0eydPK+uZc4+n87bvHW8sxFrH6OnCe0lrO3Lm0fpLgasdCZFFtvPaZ5Xoe8BvwXvZ6z6
 PSql94W5SKmTiptMnsyul82xwciw0ziFpJlKuKGvYB067cks67JUxrHZGyO2467W6CZ/
 NklQ==
X-Gm-Message-State: APjAAAVHGHGGPjUjN4OBDqMld7jON1vkTsgRkgDC96pvj1WP+WehOOPx
 3hu3lKVH1IbLxk0P3lnXMximzA==
X-Google-Smtp-Source: APXvYqymIcKOvmdgVCL7HGUuAz3wgKOfwyqOzedcRvHidY0Ly0LOFMjQP3epmTnt6Bd4hWU3teP11A==
X-Received: by 2002:a63:947:: with SMTP id 68mr23047243pgj.212.1566931937723; 
 Tue, 27 Aug 2019 11:52:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b30sm17953pfr.117.2019.08.27.11.52.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 11:52:16 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1566898663-25858-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1566898663-25858-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <64b614b6-cb05-bd16-dd0b-1ffbdc7db94a@linaro.org>
Date: Tue, 27 Aug 2019 11:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566898663-25858-2-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v6 1/3] target/ppc: Optimize emulation of
 vpkpx instruction
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 2:37 AM, Stefan Brankovic wrote:
> +    for (i = 0; i < 4; i++) {
> +        switch (i) {
> +        case 0:
> +            /*
> +             * Get high doubleword of vA to perfrom 6-5-5 pack of pixels
> +             * 1 and 2.
> +             */
> +            get_avr64(avr, VA, true);
> +            tcg_gen_movi_i64(result, 0x0ULL);
> +            break;
> +        case 1:
> +            /*
> +             * Get low doubleword of vA to perfrom 6-5-5 pack of pixels
> +             * 3 and 4.
> +             */
> +            get_avr64(avr, VA, false);
> +            break;
> +        case 2:
> +            /*
> +             * Get high doubleword of vB to perfrom 6-5-5 pack of pixels
> +             * 5 and 6.
> +             */
> +            get_avr64(avr, VB, true);
> +            tcg_gen_movi_i64(result, 0x0ULL);
> +            break;
> +        case 3:
> +            /*
> +             * Get low doubleword of vB to perfrom 6-5-5 pack of pixels
> +             * 7 and 8.
> +             */
> +            get_avr64(avr, VB, false);
> +            break;
> +        }
> +        /* Perform the packing for 2 pixels(each iteration for 1). */
> +        tcg_gen_movi_i64(tmp, 0x0ULL);
> +        for (j = 0; j < 2; j++) {
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 3));
> +            tcg_gen_andi_i64(shifted, shifted, mask1 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 6));
> +            tcg_gen_andi_i64(shifted, shifted, mask2 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +
> +            tcg_gen_shri_i64(shifted, avr, (j * 16 + 9));
> +            tcg_gen_andi_i64(shifted, shifted, mask3 << (j * 16));
> +            tcg_gen_or_i64(tmp, tmp, shifted);
> +        }
> +        if ((i == 0) || (i == 2)) {
> +            tcg_gen_shli_i64(tmp, tmp, 32);
> +        }
> +        tcg_gen_or_i64(result, result, tmp);
> +        if (i == 1) {
> +            /* Place packed pixels 1:4 to high doubleword of vD. */
> +            tcg_gen_mov_i64(result1, result);
> +        }
> +        if (i == 3) {
> +            /* Place packed pixels 5:8 to low doubleword of vD. */
> +            tcg_gen_mov_i64(result2, result);
> +        }
> +    }
> +    set_avr64(VT, result1, true);
> +    set_avr64(VT, result2, false);

I really have a hard time believing that it is worthwhile to inline all of this
code.  By my count this is 82 non-move opcodes.  That is a *lot* of inline
expansion.

However, I can well imagine that the existing out-of-line helper is less than
optimal.

> -void helper_vpkpx(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> -{
> -    int i, j;
> -    ppc_avr_t result;
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    const ppc_avr_t *x[2] = { a, b };
> -#else
> -    const ppc_avr_t *x[2] = { b, a };
> -#endif
> -
> -    VECTOR_FOR_INORDER_I(i, u64) {
> -        VECTOR_FOR_INORDER_I(j, u32) {
> -            uint32_t e = x[i]->u32[j];

Double indirect loads?

> -
> -            result.u16[4 * i + j] = (((e >> 9) & 0xfc00) |
> -                                     ((e >> 6) & 0x3e0) |
> -                                     ((e >> 3) & 0x1f));

Store to temporary ...

> -        }
> -    }
> -    *r = result;

... and then copy?

Try replacing the existing helper with something like the following.


r~



static inline uint64_t pkpx_1(uint64_t a, int shr, int shl)
{
    uint64_t r;

    r  = ((a >> (shr + 9)) & 0x3f) << shl;
    r |= ((a >> (shr + 6)) & 0x1f) << shl;
    r |= ((a >> (shr + 3)) & 0x1f) << shl;

    return r;
}

static inline uint64_t pkpx_2(uint64_t ah, uint64_t al)
{
    return pkpx_1(ah, 32, 48)
         | pkpx_1(ah,  0, 32)
         | pkpx_1(al, 32, 16)
         | pkpx_1(al,  0,  0);
}

void helper_vpkpx(uint64_t *r, uint64_t *a, uint64_t *b)
{
    uint64_t rh = pkpx_2(a->VsrD(0), a->VsrD(1));
    uint64_t rl = pkpx_2(b->VsrD(0), b->VsrD(1));
    r->VsrD(0) = rh;
    r->VsrD(1) = rl;
}

