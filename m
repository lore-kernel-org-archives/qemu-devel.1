Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF113C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F4C206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3+ySZKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F4C206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDNFB-0000eh-TZ
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 02:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNDo-000820-T0
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNDj-0004nw-S9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:58:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:38726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDNDj-0004me-Kt
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:57:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id z5so7954959pfn.5
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 23:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:references:to:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZuSLm3EpGn6g8p/v8boVm3rlFCHXOMYcg0Q8qSP25Lo=;
 b=v3+ySZKmDfWZACXUKE/wUabg2XlpwVO5E6TUgy4F0UOFaDEF6wmB+RAOnodvkT8VPe
 4i5SZh411ZfDuuIYzLgEd3tu/SrQmM/3TUusk4UvfypIaw/GS3LhqtATp3JP0wF/ly64
 2PqEqjXYy07BWZu0A+dIm9vs5+sUmPXVS4tdxCuuZ4Sg9KgpcBmPV7kD5TXGDDzxBQAA
 tFeUnD8C2j9cz1B9hsk8SFQhznOnQiVaZbtwZhkDlDmj6MUGiX8bpiuwKbrNcNPLWy/C
 z/mKbS39Mfj3aQKXMvCxinOgdoPeLpQ/j8r0R8C4rzxtsXs4vDgxy4tGMfJf40WgSOAo
 9/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:to:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZuSLm3EpGn6g8p/v8boVm3rlFCHXOMYcg0Q8qSP25Lo=;
 b=WEAcvOaDUloFx0lJsQEBdDqGfXbm9aLoVjc+0Benw+LNDh0d0Gxmd/F4zQZc8Ln889
 wUv9MgurEDUrRRh9BYWJtKUzgoCZ9/y1b2mfaU2bn3nxVxDPvdNRokBVFPzGVc4w1Dsh
 5wjk4/fc/C0K3FBSdOZlSqy1cPoMbF9N+Kj2KdlEXUWS9W8vkisXJ0Umo+wiQCa9aVM8
 DKvWc75KFSZgNXP71N/Mceu5cMYdHxVVOeq3pjBMe11QIoFqHCb5dWtaeZYVs73HLF7G
 9BSOrABcdI8tt9OhSqcW16um1CIPOm5idDH2bNBU0koQ0EuPxS/6MRq1r79Fi9hwRs6G
 LHcQ==
X-Gm-Message-State: ANhLgQ28cMItrLAwEbAZtxOBAPhjaT38ix/tgTyCkHTHSG82F8SsWYyI
 GdFGUVYmwaxqU36EsjMA7lO0YjjtOBI=
X-Google-Smtp-Source: ADFU+vtdZwT+CZ+yX7hJRK4z+C9/N+TzqQ9D2Y3bLdxArXLqB3lYBBNOGUTdJXWi2Gha9FcEWA87IQ==
X-Received: by 2002:a63:b21b:: with SMTP id x27mr21382410pge.310.1584255478362; 
 Sat, 14 Mar 2020 23:57:58 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 67sm2058492pfe.168.2020.03.14.23.57.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 23:57:57 -0700 (PDT)
Subject: Re: [PATCH v5 48/60] target/riscv: vector mask-register logical
 instructions
References: <86d7d5d0-37c9-e1c3-49d5-984d40e9c4a9@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>, liuzhiwei <zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
X-Forwarded-Message-Id: <86d7d5d0-37c9-e1c3-49d5-984d40e9c4a9@linaro.org>
Message-ID: <4d8c2d9f-8c26-db73-ce87-002c0118ef4e@linaro.org>
Date: Sat, 14 Mar 2020 23:57:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <86d7d5d0-37c9-e1c3-49d5-984d40e9c4a9@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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

Ho hum, failed to send to the list first time.


-------- Forwarded Message --------
Subject: Re: [PATCH v5 48/60] target/riscv: vector mask-register logical
instructions
Date: Sat, 14 Mar 2020 23:41:59 -0700
From: Richard Henderson <richard.henderson@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>

[ Patch didn't make it to the list, so reviewing

https://github.com/romanheros/qemu/commit/8c782677c21909f80c481cfd7ab58c076761642c
]

This is ok as-is, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But you can do better.

> 
> /* Vector Mask-Register Logical Instructions */
> #define GEN_MM_TRANS(NAME)                                         \
> static bool trans_##NAME(DisasContext *s, arg_r *a)                \
> {                                                                  \
>     if (vext_check_isa_ill(s, RVV)) {                              \
>         uint32_t data = 0;                                         \
>         gen_helper_gvec_4_ptr * fn = gen_helper_##NAME;            \
>         data = FIELD_DP32(data, VDATA, MLEN, s->mlen);             \
>         data = FIELD_DP32(data, VDATA, LMUL, s->lmul);             \
>         tcg_gen_gvec_4_ptr(vreg_ofs(s, a->rd), vreg_ofs(s, 0),     \
>             vreg_ofs(s, a->rs1), vreg_ofs(s, a->rs2),              \
>             cpu_env, 0, s->vlen / 8, data, fn);                    \
>         return true;                                               \
>     }                                                              \
>     return false;                                                  \
> }
> GEN_MM_TRANS(vmand_mm)
> GEN_MM_TRANS(vmnand_mm)
> GEN_MM_TRANS(vmandnot_mm)
> GEN_MM_TRANS(vmxor_mm)
> GEN_MM_TRANS(vmor_mm)
> GEN_MM_TRANS(vmnor_mm)
> GEN_MM_TRANS(vmornot_mm)
> GEN_MM_TRANS(vmxnor_mm)

For vl_eq_vlmax, we should use gvec.

For mlen == 1, nothing more is needed, as all bits are significant.  For mlen >
1, we can use

  tcg_gen_gvec_andi(MO_64, vreg_ofs(s, a->rd),
                    vreg_ofs(s, a->rd),
                    pred_mlen_masks[log2_mlen],
                    s->vlen / 8, s->vlen / 8);

where pred_mlen_masks[] are as discussed vs 49/60 (vmpopc).

It might be worth noticing vmclr.mm, which of course does not require that andi.

> /* Vector Mask-Register Logical Instructions */
> #define GEN_VEXT_MASK_VV(NAME, OP)                        \
> void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>         void *vs2, CPURISCVState *env, uint32_t desc)     \
> {                                                         \
>     uint32_t mlen = vext_mlen(desc);                      \
>     uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;   \
>     uint32_t vl = env->vl;                                \
>     uint32_t i;                                           \
>     int a, b;                                             \
>     for (i = 0; i < vl; i++) {                            \
>         a = vext_elem_mask(vs1, mlen, i);                 \
>         b = vext_elem_mask(vs2, mlen, i);                 \
>         vext_set_elem_mask(vd, mlen, i, OP(b, a));        \
>     }                                                     \
>     if (i == 0) {                                         \
>         return;                                           \
>     }                                                     \
>     for (; i < vlmax; i++) {                              \
>         vext_set_elem_mask(vd, mlen, i, 0);               \
>     }                                                     \
> }
> #define DO_NAND(N, M)  (!(N & M))
> #define DO_ANDNOT(N, M)  (N & !M)
> #define DO_NOR(N, M)  (!(N | M))
> #define DO_ORNOT(N, M)  (N | !M)
> #define DO_XNOR(N, M)  (!(N ^ M))

Again, these operations can be done in units of uint64_t, applying the
pred_msize_mask and the residual "rmask" that I mentoned wrt vmpopc.

This would mean that you'd want bitwise, not logical nots above in your DO_*
macros.


r~

