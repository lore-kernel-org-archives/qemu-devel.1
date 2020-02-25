Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BF5C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B0A20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB3Qr7Dw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B0A20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aYZ-0005Bv-Db
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aC8-000099-Dc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6aC7-0005Kj-77
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:24:16 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6aC7-0005KD-1J
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:24:15 -0500
Received: by mail-ot1-x342.google.com with SMTP id p8so11986966oth.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ot8NRkQt35gxhegDfjY2Ls4qHNEIri5ew5LERrF3RU0=;
 b=UB3Qr7DwCstya4xBCGfwY6Y+XPOK7S1am82iGO/rXQEnq3e+zViMENgIrQFnps6ITW
 NlY8LJW1QvfKjq7liQbzFdX/lXKIVB3H4qv7/sp5AvqwV6mI/vJbMhTEK8s0eRhneYE2
 2uYfZqh7FvLPrRtMWD//IBcRnMjNWrsaMcFxldhhms8PHyrtnFPlyL4OtbGJ0yZ5JrSV
 vypUZC4HFAt3BPPaaeT8dXzx6ZGNQrOcKKb0kn7/Nnjaykgx4q/8S4wU45uzasL2YrPj
 yjPrYPx/W+tRvcz2YU0N2ZKgY6pygi1x66GlLFyedKmHr0qEzfbodEXXrnsrBmuYG0T6
 aMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ot8NRkQt35gxhegDfjY2Ls4qHNEIri5ew5LERrF3RU0=;
 b=SfE7I8xvilbgRSMa+YmKEDpQVu0jL/zDI+fXsAYQbN1A3af4WTkPu2KxVnZmsyciRy
 7qOKNghAyTk1Z5yjJvIuxKO0PUtyZQ57Jsl5wXXEMAXlZo5fNYb8pQG0NKBJePQHcR/y
 kJbLUDy7dpNNYTh8HuuW5+vcmu95Gr2yAMBRaiUWDwQeiGOm2CJ945Zf/c8EShXVRMtm
 pBs2QwnbX6JYawX+p33OpypAUkvNO5yNn9IrSzbz8RwTI/AYnG4tKMQ/pE8wKs0IgtOR
 5ITxoBHiL6WE9c+jYRVg9gKtx6XHa1rbtggzilarGJv+QQbfZK5Xb85sdncWo3S4cRJy
 mJsg==
X-Gm-Message-State: APjAAAU3BPxDp5IyK0wyG5VT0l0hpl6iR9p/h8j70dYvfYm2zEEwvExj
 gCGT/NoM+D2uLH0pVHov3elML4mPRCnM2krwW5vG8A==
X-Google-Smtp-Source: APXvYqyPn562kWFQQjg1uqGwr/sGxJv2QwcY/BMvOvCpN8eIzRr6hpLv1v15/aIdkp37eF5BgUVgpyRGa+o+yIukLtw=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr45019832ota.232.1582637052673; 
 Tue, 25 Feb 2020 05:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20200224222232.13807-1-richard.henderson@linaro.org>
 <20200224222232.13807-6-richard.henderson@linaro.org>
In-Reply-To: <20200224222232.13807-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 13:24:01 +0000
Message-ID: <CAFEAcA9WZbZj_hPemTGr+Rkh--VmZt1eis189+ExuPVNipgo_A@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] target/arm: Improve ID_AA64PFR0 FP/SIMD
 validation
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 22:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When sanity checking id_aa64pfr0, use the raw FP and SIMD fields,
> because the values must match.  Delay the test until we've finished
> modifying the id_aa64pfr0 register.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5be4c25809..f10f34b655 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1427,17 +1427,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          return;
>      }
>
> -    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> -        cpu->has_vfp != cpu->has_neon) {
> -        /*
> -         * This is an architectural requirement for AArch64; AArch32 is
> -         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
> -         */
> -        error_setg(errp,
> -                   "AArch64 CPUs must have both VFP and Neon or neither");
> -        return;
> -    }
> -
>      if (!cpu->has_vfp) {
>          uint64_t t;
>          uint32_t u;
> @@ -1537,6 +1526,18 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          cpu->isar.mvfr0 = u;
>      }
>
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> +        FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, FP) !=
> +        FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, ADVSIMD)) {
> +        /*
> +         * This is an architectural requirement for AArch64.  Not only
> +         * both vfp and advsimd or neither, but further both must
> +         * support fp16 or neither.
> +         */
> +        error_setg(errp, "AArch64 CPUs must match VFP and NEON");
> +        return;
> +    }
> +
>      if (arm_feature(env, ARM_FEATURE_M) && !cpu->has_dsp) {
>          uint32_t u;

This check is supposed to be "did the user accidentally specify
some incompatible settings on their '-cpu,+this,-that' option?".
By making it check the actual ID register values, you're turning
it into also a check on "does the implementation specify sane
ID register values", which (a) is useful for TCG but ought to
be an assert and (b) we shouldn't be checking for KVM in case
the h/w is giving us dubious ID values.

thanks
-- PMM

