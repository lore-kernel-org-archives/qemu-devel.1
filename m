Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17AC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BD420732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdEsBTG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BD420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVdYT-0005jd-9M
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 10:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iVdXf-0005EG-8M
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iVdXd-0000HL-S1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:29:46 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iVdXd-0000Gm-Jp
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 10:29:45 -0500
Received: by mail-wr1-x441.google.com with SMTP id z10so11403659wrs.12
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p+KJN6w9Lw0Sogc64X+XNrKaC4BrvFqMXa1bERRbuLs=;
 b=pdEsBTG1mdI8qQRuKcFILjBxDLeTQ5IApIqLp7qhq8fyJOvWtq/SCxodG63YtUhzYx
 lgUd1MdCPOTUmiVaSOOGIYl98pyUQFiAJBF7J1AxdK1MJr6x4qhNaU4rfFlhYsHnKH/g
 q2v900iBuUYv2ld/PbUNrnOj2QnbOMlVJXCm1TQ26WqHYtDeYzNg4P9ywo2NDcisU22T
 qiBPQrx1VqXtd6QWzeoGmQv9RVxwfKP5cOA+Fk2vZyyMrlnMJql/B+9DaktfeKSCYXvV
 28t0I8iW5ScpqRddqANoy/JW1yOR9p/qeiAXPw0u/pJDDtMt5Zs/0GGNjtRzYGyUmDAs
 Eslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p+KJN6w9Lw0Sogc64X+XNrKaC4BrvFqMXa1bERRbuLs=;
 b=QFnXa6RAyo9xcPuhgjHEQjIhAyhgIqhFam1vgHBnDfek3JSfAWXWiu6iSxUL48q+/3
 k8xkO35OhHYK1VJq1Doru4wNeRkF6jbH3DZNRqav1UA4XWELPaHB2wN0JqypIlpDrTJQ
 L8NwmmEo1WxaWNP4o4ShmE1yVymZXg59K7HbIXdpIw+Ir6Z5vrD2PCRi1edJdiqzQHlM
 JuJGQ+PnJnGLycI8B7d3hFQkF/65tYwCCpe7OYCDCPtVV2lp9hghUcPlCRvjx//ezGT8
 0EKrBEmTUpeF4h7F3Jaq3ShXr1kXH/rENLcWltuCU0SiQG61lWSzLZPeJULToHpGsLxT
 plrA==
X-Gm-Message-State: APjAAAVbfPilAnosKC24g9CPVmerLfM553aFJ5VLcdlcvKiu0i62IhBo
 +0rXdOHXy01p4eUdVtNYszjP8g==
X-Google-Smtp-Source: APXvYqxDWcZofeCFRXaUsuH9eWJvqTQt8rJ4fzWmMtUn5IZJfipA6nyVBVVnuTI58xMra757iSI1mQ==
X-Received: by 2002:adf:fe0b:: with SMTP id n11mr15193079wrr.218.1573831783040; 
 Fri, 15 Nov 2019 07:29:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y19sm10883376wmd.29.2019.11.15.07.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:29:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8930C1FF87;
 Fri, 15 Nov 2019 15:29:40 +0000 (GMT)
References: <20191115131623.322-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/arm: Clean up arm_cpu_vq_map_next_smaller asserts
In-reply-to: <20191115131623.322-1-richard.henderson@linaro.org>
Date: Fri, 15 Nov 2019 15:29:40 +0000
Message-ID: <87tv755fa3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Coverity reports, in sve_zcr_get_valid_len,
>
> "Subtract operation overflows on operands
> arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
>
> First, fix the aarch32 stub version to not return 0, but to
> simply assert unreachable.  Because that nonsense return value
> does exactly what Coverity reports.
>
> Second, 1 is the minimum value that can be returned from the
> aarch64 version of arm_cpu_vq_map_next_smaller, but that is
> non-obvious from the set of asserts in the function.  Begin by
> asserting that 2 is the minimum input, and finish by asserting
> that we did in fact find a set bit in the bitmap.  Bit 0 is
> always set, so we must be able to find that.
>
> Reported-by: Coverity (CID 1407217)
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h   |  4 +++-
>  target/arm/cpu64.c | 11 +++++++++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e1a66a2d1c..d89e727d7b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -190,7 +190,9 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uin=
t32_t vq);
>  # define ARM_MAX_VQ    1
>  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
>  static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t=
 vq)
> -{ return 0; }
> +{
> +    g_assert_not_reached();
> +}
>  #endif
>
>  typedef struct ARMVectorReg {
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 68baf0482f..83ff8c8713 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -466,11 +466,18 @@ uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, u=
int32_t vq)
>       * We allow vq =3D=3D ARM_MAX_VQ + 1 to be input because the caller =
may want
>       * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
>       * function always returns the next smaller than the input.
> +     *
> +     * Similarly, vq =3D=3D 2 is the minimum input because 1 is the mini=
mum
> +     * output that makes sense.
>       */
> -    assert(vq && vq <=3D ARM_MAX_VQ + 1);
> +    assert(vq >=3D 2 && vq <=3D ARM_MAX_VQ + 1);
>
>      bitnum =3D find_last_bit(cpu->sve_vq_map, vq - 1);
> -    return bitnum =3D=3D vq - 1 ? 0 : bitnum + 1;
> +
> +    /* We always have vq =3D=3D 1 present in sve_vq_map.  */
> +    assert(bitnum < vq - 1);
> +
> +    return bitnum + 1;
>  }
>
>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *=
name,


--
Alex Benn=C3=A9e

