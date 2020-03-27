Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D030C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5237E2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 23:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o58RYMA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5237E2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHyoj-0007M6-He
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 19:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHyo3-0006vH-NQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHyo2-0008HS-JI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:54:31 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:40274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHyo2-0008De-9W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 19:54:30 -0400
Received: by mail-pj1-x102e.google.com with SMTP id kx8so4409775pjb.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8teJSBd/2vH4Yjy/oRQ/M8PIut7JOFl8nEOe7QgnKjU=;
 b=o58RYMA8iIp59Qi/CG8gmnDx2jErlIeG4lJFsYUL9k4vr7S1p7qRT75Mv7IBV4r/PB
 XMSJojzIu5cjUoeQqW4w+cSjV3JjeJYguLGrBROYaUCsj57I0g0hlr2CbY5YqsTjDZ4S
 rAvEuDcQd/cCpL2fKhY0O1ifjbRnT+2lbokw0N3ADRgjLUuSSycixMfJH2KPFP9Mtfx5
 vHnsk30ZrmTLSULNqZvvVXakVOTE2wfjfrHYtydwiREL2V0avt351TEN7K91cefjQl2i
 HMBl2HTObCvfygsIbxd31ft38gZmdXPdd+LlgMtTtconQRbf+D/P/sDIPDSEajUGkIAS
 p2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8teJSBd/2vH4Yjy/oRQ/M8PIut7JOFl8nEOe7QgnKjU=;
 b=BGiUWUBrliHfX1rpzTR/9JhWvrgApugGMMrhcLawd0Kq6tyQS6Y1cifSUPJFmzePnY
 xIUMRT8/reSW8qfQ56HzAJHTQE4B0uEZQsBH3PDvA6UOB59BIsAtqAlcvkPhG5MI1+Br
 X3qWxkI0pgfZR8RyJ4GCxjHDfo3T0vnPi42krt6bA5Lr8F76bbLdFC5empM2iSCBA75Z
 gkqHY9amUDh4D6z7w5XtkcW5AtNJLZHu7fHlF7sy6wwlQ3SICS3vq/P7ICBERf0PW0Ru
 KCZDOHGJ9ldiPm+QTn+79PluSmJNOrpuoAB4x/nAvBb/48UHrU3d0VDBEDo6NU5KqsSB
 n2jA==
X-Gm-Message-State: ANhLgQ0hrCrKa/++zFWcp+vGEni0VQJwGVO1HB1MJPwEHyjLYRLEirSM
 dox+NxRp+TPlXhE/4ZXT9GCa9A==
X-Google-Smtp-Source: ADFU+vub2NaOlBgQeT7J07XOFGYP6ZyQyaeISTRRumV5UW+kBj4bT8gBgpRv/joJRb2PhqFnOPKPYw==
X-Received: by 2002:a17:90a:37c6:: with SMTP id
 v64mr2074182pjb.20.1585353268687; 
 Fri, 27 Mar 2020 16:54:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id b25sm4912526pfp.201.2020.03.27.16.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 16:54:27 -0700 (PDT)
Subject: Re: [PATCH v6 10/61] target/riscv: vector single-width integer add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-11-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa027bb9-1427-7c91-c60e-b22c04115c2f@linaro.org>
Date: Fri, 27 Mar 2020 16:54:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-11-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> +    if (a->vm && s->vl_eq_vlmax) {
> +        gvec_fn(s->sew, vreg_ofs(s, a->rd),
> +            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
> +            MAXSZ(s), MAXSZ(s));

Indentation is off here.

> +static inline bool
> +do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
> +              gen_helper_opivx *fn)
> +{
> +    if (!opivx_check(s, a)) {
> +        return false;
> +    }
> +
> +    if (a->vm && s->vl_eq_vlmax) {
> +        TCGv_i64 src1 = tcg_temp_new_i64();
> +        TCGv tmp = tcg_temp_new();
> +
> +        gen_get_gpr(tmp, a->rs1);
> +        tcg_gen_ext_tl_i64(src1, tmp);
> +        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
> +                src1, MAXSZ(s), MAXSZ(s));
> +
> +        tcg_temp_free_i64(src1);
> +        tcg_temp_free(tmp);
> +        return true;
> +    } else {
> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
> +    }
> +    return true;
> +}

This final return is unreachable, and I'm sure some static analyzer (e.g.
Coverity) will complain.

Since the if-then has a return, we can drop the else like so:

    if (a->vm && s->vl_eq_vlmax) {
        ...
        return true;
    }
    return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

