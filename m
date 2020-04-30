Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48676C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDAF2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 20:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWDVh0PK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDAF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUGHi-0005Qp-S0
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 16:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUGCO-0008To-6b
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUGCM-0002HO-Ed
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:54:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUGCI-0002BN-N6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 16:54:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id 18so474945pfv.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=r3pia5pLAp5t5+qZDXgrLBjQhTafThCii8XgzCKJyHg=;
 b=JWDVh0PKCi7WFxr/q50mOH/U14/09vFOWngA67p7f1kyUdYK+YH1/ncnxR8o60fmwJ
 4DIVurvRhyBNej8w+2WsVBtUfS81vD6x5PAZYuSHQDZSNQc9WbDvNHYdcQxEmEKrG6Oc
 hsXhMHnVUOCMcwsfm7yxJgcDuLQA8TK0X2Lg6rirtKvwsJDkWMgiBQ5pQyzAmFcRLkrw
 UiVMNZasOX1MxTW5a+UosyQyJGiKZ6rXA/dxpr6QU5YtgNes/P36A/+uZR8Lt/8rvbHU
 1Y1AZibxT4xYe4zfdm+GlK6qX+Y1+siZ8h8RhxqmGiHmdwNpD7+Ce6zDfTuzvt3dGu1M
 K0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r3pia5pLAp5t5+qZDXgrLBjQhTafThCii8XgzCKJyHg=;
 b=g2wXhfkiYGShzgXrWibxrjnjhWmhJ7/aF1R4AumrpbLAA8ThCocAcENJm9JIIif4vO
 NEXt5i9dxJ/YL01y9kRzV5WsFL8HZX9wAeT4GqxqPpISNzDIHYsfotM8lNk8Gn+uQmZ5
 LFzRXf7DLngyhZqhB4o+APg//fukefBXW8hCzvQCNOVxebjRdssD3QCx4EhGYeBgcIwz
 0T/zlOzc0Ikl43IAynnz5OsieYXGvZundcYdpqcAerNK5GSNX3skdlng0/4P06f63R0J
 hhgjG/LkJWzLZrvd9l0i7qHpFpdXdiMxhFA5xUH/43keNk9Am4dXd2rftZPV1kTQQbz0
 sy6A==
X-Gm-Message-State: AGi0PuZGPOZUM1itBNJk5HeRI61YHC8WgjDHKVkhd6/yzYlSa0n+kr9i
 rxjmCxh6uKJPCXppXuL76gxsDdIOiwU=
X-Google-Smtp-Source: APiQypJ+5UVvRvbwaPCHJYyitGVEvGQxxJTSgjqnCXT8Vo90DTIshfIyQJ0HgHwu6Kn4cNMlOlLnqw==
X-Received: by 2002:aa7:96e8:: with SMTP id i8mr656812pfq.222.1588280054411;
 Thu, 30 Apr 2020 13:54:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id a129sm577660pfb.102.2020.04.30.13.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 13:54:13 -0700 (PDT)
Subject: Re: [PATCH 23/36] target/arm: Convert Neon 64-bit element 3-reg-same
 insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <366a2e79-d963-bfdc-fcc6-2a63026fa1db@linaro.org>
Date: Thu, 30 Apr 2020 13:54:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430181003.21682-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::442
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
> +
> +    rn = tcg_temp_new_i64();
> +    rm = tcg_temp_new_i64();
> +    rd = tcg_temp_new_i64();
> +
> +    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
> +        neon_load_reg64(rn, a->vn + pass);
> +        neon_load_reg64(rm, a->vm + pass);
> +        fn(rd, rm, rn);
> +        neon_store_reg64(rd, a->vd + pass);
> +    }
> +
> +    tcg_temp_free_i64(rn);
> +    tcg_temp_free_i64(rm);
> +    tcg_temp_free_i64(rd);
> +
> +    return true;
> +}
> +
> +#define DO_3SAME_64(INSN, FUNC)                                         \
> +    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
> +    {                                                                   \
> +        return do_3same_64(s, a, FUNC);                                 \
> +    }

You can morph this into the gvec interface like so:

#define DO_3SAME_64(INSN, FUNC) \
    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,
                                uint32_t rn_ofs, uint32_t rm_ofs,
                                uint32_t oprsz, uint32_t maxsz)
    {
        static const GVecGen3 op = { .fni8 = FUNC };
        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,
                       oprsz, maxsz, &op);
    }
    DO_3SAME(INSN, gen_##INSN##_3s)

The .fni8 function tells gvec that we have a helper that processes the
operation in 8 byte chunks.  It will handle the pass loop for you.

There's also a .fni4 member, for those neon helpers that operate on 4-byte
quantities, fwiw.


r~

