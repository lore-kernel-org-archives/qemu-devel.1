Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B3C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:31:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD852075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STemXnZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD852075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8R4b-0007vn-V6
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8R0K-0003ij-7t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8R0H-0002MZ-GJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:27:27 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:38015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8R0H-0002Kc-0U
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:27:25 -0400
Received: by mail-qt1-x844.google.com with SMTP id j31so3223989qta.5
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G5F7mh6JKW+aDUMg9J6kxcIbyqtf8/3eFQmGQ7rpxrU=;
 b=STemXnZ6OL3jkTfPnJfZrPg80woQIU+ozyyzuJTMTHj11jCEP3fqdfSF8SIINgM4GS
 bkucw0npmQWRXfm4Ch3mA1oR2JKxO6SOBF732VXcE3e2W9dQ6mzXmukEItqW3Zx7dN4b
 v3hRyF6nIMesWGxqpJF9cFxXNc1CAJyrBwUYNV4X32KscA5FCZNn6YMTcCQJlBYhGrD7
 L/GL6zJLAa7jfTP/9rEoHQWR8iovStIShhALFEUeqSllGGIZnaaUr+yEOm5KgBtvXE4O
 uZevv2kP8Mw0J2ymUUGmkuDkw4Xi5SgNdfYE5By7k3zh0pmGeo8LXZycwkXSQTAhLs0i
 h5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5F7mh6JKW+aDUMg9J6kxcIbyqtf8/3eFQmGQ7rpxrU=;
 b=GSv7AmLMTDEOGyjBCrDITu/mhu8fnX3nJuOMax5I7fTZCJ7MaLMC1tGnHwf/Otfov8
 6sIOF/iaZD9h/yZ1bCIttdOuA0Lsx1sgNPF5zHxQsOyGuaD9u/g7m210YR1+d9JOroai
 QAyItuXWj7na/oc3UWdNGltfASBpmCviW8e8Bfv+Z6s72vqp0BpYifJ4RTG+Q5nY+/Kl
 uv14U1o8NLWByE4EE2vjQ5kUKK038sa5fqR36Dx7ru/Yvrt01yUcix22YKFzCRwWHo9Q
 +8YyrrKY7olDJ6VRpyDAW9IoX2TWPJf02rdw3St4rhYjvkR7BHB7vTa6e+zDEl+ODT1K
 zumg==
X-Gm-Message-State: APjAAAUVUa+MqiCxNK3P/AC4e83om1Chmeo/2FEnvnvOuL81k0XFv+lk
 6V4kE9OpZuiF9r5ibcWbqapycg==
X-Google-Smtp-Source: APXvYqxGL9RLZ/xwDBXush0m97r1mwQvMEF9N2xsXEprI3923/b2ox7HLz3k/wZ/fg3J0kgocleEKA==
X-Received: by 2002:a0c:e6e4:: with SMTP id m4mr26399193qvn.96.1568302043402; 
 Thu, 12 Sep 2019 08:27:23 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id t26sm11111168qkt.10.2019.09.12.08.27.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 08:27:22 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-9-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1e707c9c-e74e-8a21-11f7-6ce8d09cf06d@linaro.org>
Date: Thu, 12 Sep 2019 11:27:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-9-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v2 08/17] RISC-V: add vector extension
 integer instructions part1, add/sub/adc/sbc
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
>  #define VECTOR_HELPER(name) HELPER(glue(vector_, name))
> +#define SIGNBIT8    (1 << 7)
> +#define SIGNBIT16   (1 << 15)
> +#define SIGNBIT32   (1 << 31)
> +#define SIGNBIT64   ((uint64_t)1 << 63)

Perhaps make up your mind if you want signed or unsigned values?  Perhaps just
use or redefine INT<N>_MIN instead?

> +static int64_t extend_gpr(target_ulong reg)
> +{
> +    return sign_extend(reg, sizeof(target_ulong) * 8);
> +}

Note wrt usage:
+                extend_rs1 = (uint64_t)extend_gpr(env->gpr[rs1]);

This is equivalent to "extend_rs1 = (target_long)env->gpr[rs1]".

I don't see how this helper function is helping, really.
Also, pass gprs by value, not by index.

> +static inline int vector_get_carry(CPURISCVState *env, int width, int lmul,
> +    int index)
> +{
> +    int mlen = width / lmul;
> +    int idx = (index * mlen) / 8;
> +    int pos = (index * mlen) % 8;
> +
> +    return (env->vfp.vreg[0].u8[idx] >> pos) & 0x1;
> +}

Any reason not to re-use vector_elem_mask?

> +static inline uint64_t u64xu64_lh(uint64_t a, uint64_t b)
> +{
> +    uint64_t hi_64, carry;
> +
> +    /* first get the whole product in {hi_64, lo_64} */
> +    uint64_t a_hi = a >> 32;
> +    uint64_t a_lo = (uint32_t)a;
> +    uint64_t b_hi = b >> 32;
> +    uint64_t b_lo = (uint32_t)b;
> +
> +    /*
> +     * a * b = (a_hi << 32 + a_lo) * (b_hi << 32 + b_lo)
> +     *               = (a_hi * b_hi) << 64 + (a_hi * b_lo) << 32 +
> +     *                 (a_lo * b_hi) << 32 + a_lo * b_lo
> +     *               = {hi_64, lo_64}
> +     * hi_64 = ((a_hi * b_lo) << 32 + (a_lo * b_hi) << 32 + (a_lo * b_lo)) >> 64
> +     *       = (a_hi * b_lo) >> 32 + (a_lo * b_hi) >> 32 + carry
> +     * carry = ((uint64_t)(uint32_t)(a_hi * b_lo) +
> +     *           (uint64_t)(uint32_t)(a_lo * b_hi) + (a_lo * b_lo) >> 32) >> 32
> +     */
> +
> +    carry =  ((uint64_t)(uint32_t)(a_hi * b_lo) +
> +              (uint64_t)(uint32_t)(a_lo * b_hi) +
> +              ((a_lo * b_lo) >> 32)) >> 32;
> +
> +    hi_64 = a_hi * b_hi +
> +            ((a_hi * b_lo) >> 32) + ((a_lo * b_hi) >> 32) +
> +            carry;
> +
> +    return hi_64;
> +}

Use mulu64().

> +static inline int64_t s64xu64_lh(int64_t a, uint64_t b)
> +{
> +    uint64_t abs_a = a;
> +    uint64_t lo_64, hi_64;
> +
> +    if (a < 0) {
> +        abs_a =  ~a + 1;

 abs_a = -a

> +static inline int64_t s64xs64_lh(int64_t a, int64_t b)
> +{
> +    uint64_t abs_a = a, abs_b = b;
> +    uint64_t lo_64, hi_64;
> +
> +    if (a < 0) {
> +        abs_a =  ~a + 1;
> +    }
> +    if (b < 0) {
> +        abs_b = ~b + 1;
> +    }
> +    lo_64 = abs_a * abs_b;
> +    hi_64 = u64xu64_lh(abs_a, abs_b);
> +
> +    if ((a ^ b) & SIGNBIT64) {
> +        lo_64 = ~lo_64;
> +        hi_64 = ~hi_64;
> +        if (lo_64 == UINT64_MAX) {
> +            lo_64 = 0;
> +            hi_64 += 1;
> +        } else {
> +            lo_64 += 1;
> +        }
> +    }
> +    return hi_64;
> +}

Use muls64().


> +void VECTOR_HELPER(vadc_vvm)(CPURISCVState *env, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
> +{
> +    int i, j, vl;
> +    uint32_t lmul, width, src1, src2, dest, vlmax, carry;
> +
> +    vl    = env->vfp.vl;
> +    lmul  = vector_get_lmul(env);
> +    width   = vector_get_width(env);
> +    vlmax = vector_get_vlmax(env);
> +
> +    if (vector_vtype_ill(env) || vector_overlap_carry(lmul, rd)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return;
> +    }
> +    vector_lmul_check_reg(env, lmul, rs1, false);
> +    vector_lmul_check_reg(env, lmul, rs2, false);
> +    vector_lmul_check_reg(env, lmul, rd, false);
> +
> +    for (i = 0; i < vlmax; i++) {
> +        src1 = rs1 + (i / (VLEN / width));
> +        src2 = rs2 + (i / (VLEN / width));
> +        dest = rd + (i / (VLEN / width));
> +        j = i % (VLEN / width);
> +        if (i < env->vfp.vstart) {
> +            continue;

Again, hoist.

> +        } else if (i < vl) {

I would think this too could be moved into the loop condition.

> +            switch (width) {
> +            case 8:
> +                carry = vector_get_carry(env, width, lmul, i);
> +                env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
> +                    + env->vfp.vreg[src2].u8[j] + carry;
> +                break;
> +            case 16:
> +                carry = vector_get_carry(env, width, lmul, i);
> +                env->vfp.vreg[dest].u16[j] = env->vfp.vreg[src1].u16[j]
> +                    + env->vfp.vreg[src2].u16[j] + carry;
> +                break;
> +            case 32:
> +                carry = vector_get_carry(env, width, lmul, i);
> +                env->vfp.vreg[dest].u32[j] = env->vfp.vreg[src1].u32[j]
> +                    + env->vfp.vreg[src2].u32[j] + carry;
> +                break;
> +            case 64:
> +                carry = vector_get_carry(env, width, lmul, i);
> +                env->vfp.vreg[dest].u64[j] = env->vfp.vreg[src1].u64[j]
> +                    + env->vfp.vreg[src2].u64[j] + carry;
> +                break;
> +            default:
> +                riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +                break;
> +            }
> +        } else {
> +            vector_tail_common(env, dest, j, width);

With this tail clearing being done as a loop of its own, which would devolve to
memset on a little-endian host.


> +        }
> +    }
> +    env->vfp.vstart = 0;
> +}
> +void VECTOR_HELPER(vadc_vxm)(CPURISCVState *env, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
> +{

Watch the spacing between functions.
Pass gpr rs1 by value.

> +void VECTOR_HELPER(vadc_vim)(CPURISCVState *env, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
> +{
...
> +                env->vfp.vreg[dest].u8[j] = sign_extend(rs1, 5)

Pass the immediate as a sign-extended immediate to begin with, not as an
unsigned 5-bit field.

All of the rest of the helpers are about the same.

Consider creating a helper function that contains the basic outline of the
vector processing, and takes a (set of) function pointers that perform the
operation.  With optimization, compiler inlining should produce the same code
as you have here without having to replicate quite so much code for each
helper.  You can also fix a bug in the basic outline in one place instead of
hundreds.


r~

