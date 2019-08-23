Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DFC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18F921726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4bOPx0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18F921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BlE-0006VN-KY
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Bjm-0005Ob-5i
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1Bjk-0002UT-Rg
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:44:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1Bjk-0002Sf-KM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:44:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id c34so9157362otb.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F/d8B342O1qFhviNMOHfA1h6dqxCEf60Anv3ylTyp98=;
 b=I4bOPx0+lvKGZ/P4U99rmEkeinS2mn4vfoeMnhXr3IqTh2dTtSrk0ozWuKlRofSSf/
 oMH6+ct8YeRGlmHE7Jh5nbGaCXNiSgd5sx8jFhW/fgkigiDDZh7ZBCek2P3KZqjhLlHw
 kVo9OmhY/UCCz++SDKkdfGttRMjrciVPgy4Nh4uZ0Zjjr9cCOBOlLBNhgR2dhyWug7EE
 vXo9uQcR03e79V5UEeAiWnr2shcx9D5puYWYuka0l8a86CM1fTt7QBgwhhiKjTrlgZc3
 umMvb/PJ6RUYd9m2oeVCjc+20Pib7lQfOum3BXFV1NhDyfaEQsIqttXrpp7Rlv0zOa5M
 CoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F/d8B342O1qFhviNMOHfA1h6dqxCEf60Anv3ylTyp98=;
 b=qQyLQnHdWEGPeJJQ+YPLXKZ8XUclklZwdwT7u6c9hcysVuHE28ZvUl27rh+RQeBaVT
 NI8lVbtGQwlb9MVGgeJh2htTUPfKo+D4lR6d/MmfG+hhOV0IhOifV2LOq3V3qo1WZUqh
 ERTS3Dct9yYubAWAQZ6rGHPGJ7z4hGd2ZnfaeTiERtK04DVNyAt41kVccEzrGtWHv7TO
 ltbs8R/MQricUjREtimF3QGfeI6xwCv9FNwtBglI3uTg0auxfzIRApUKJTQGjCF/vnWX
 Im81omHkLfu4B2Glu08hJfwa0/cEfUqDVpWMO6f8feRS2m5fqR7naHR2xKQQ54y3p5SM
 ueqw==
X-Gm-Message-State: APjAAAX1heHOyN2trBQ2xbnNA2lLV/UjSGZ54AS6Kk5QqTNE+89ds5T8
 5MjB8/Lr+tU0E2UA08JRVhRLv00NvraD6Yr860Ja5A==
X-Google-Smtp-Source: APXvYqzoLNLMQMp3Q7Bp87+bVUn9p6bkHCmr/TGg4yvqUTS0GDOfjBQDApyOvMCww52Atknsq5xObv3hx2Hv44miPes=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr1853667otf.97.1566575063551; 
 Fri, 23 Aug 2019 08:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566573576.git.alistair.francis@wdc.com>
 <066a2c520c38b0c175c052d6a3385d5661764833.1566573576.git.alistair.francis@wdc.com>
In-Reply-To: <066a2c520c38b0c175c052d6a3385d5661764833.1566573576.git.alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 16:44:12 +0100
Message-ID: <CAFEAcA8G8ufziwwLLWo6BQZtAHWjzt_3XMMveuMMxknKSgChNA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 7/7] target/riscv: Use
 TB_FLAGS_MSTATUS_FS for floating point
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 16:37, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> Use the TB_FLAGS_MSTATUS_FS macro when enabling floating point in the tb
> flags.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index eb7b5b0af3..0347be453b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -301,7 +301,7 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
>  #else
>      *flags = cpu_mmu_index(env, 0);
>      if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= env->mstatus & MSTATUS_FS;
> +        *flags |= TB_FLAGS_MSTATUS_FS;
>      }
>  #endif

The old code was setting the bit in flags only if
it was also set in env->mstatus; the new code sets
the bit unconditionally -- deliberate change ?

thanks
-- PMM

