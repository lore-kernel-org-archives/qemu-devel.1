Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C4C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95ADE20833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBhY8doO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ADE20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsjW-0003Wn-RT
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsUN-0002gv-4c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsUL-0007Pj-78
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:02 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsUK-0007KF-U2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so9494484wma.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=T66yQ6m/u+i0sjA+UMK2rLqwipYfS8HuG6jfn9XXg4g=;
 b=MBhY8doORaSmFNRc36o5PjFExgON5q7ef9VvUd1AM95+hgsaP0ElITbBq5NDmbYtlA
 uDiLxT4VU5N5h2pbvclrkKMnYBTlJE46JcSzNT3fSdXebqgeo32eQYgqO7/jsOzyGpvU
 SZXsywkBEQM0ciJ0zY/8kSKD9xp6cXb8IS2RKUVUfBkmXTFulGkTaYl5woOPFvGfxFdD
 0XrlX5z7wYCnZ4Hsby3iwYM4LEemrLIIEsuZiAzwSfr37qNq9aFeRRgg5tzBLnTKJhGt
 X9Q399NqLIUV8u0MBAZjpfXOIjF1IE2dwInh9OqG7BWHu2uMxCILDvZCnYhpL3MFBdzl
 HVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=T66yQ6m/u+i0sjA+UMK2rLqwipYfS8HuG6jfn9XXg4g=;
 b=aHTgxQmcwUitshoTpSGVmCA0yPAVou1TFVRm/WlHSUqVffTWwuM+rWsBAGQbSD/Mw6
 UcGA6NtOzCD9xjxhcBJZN47Uub0mo/nf0hMgRoFOey8Pj4rW44EPpfnFWVTU7xT6BDo8
 V1Z60coZJ5ZSjp4tebWp5foFI64ZGJ7RmXu1aq3tVr66HcgexDfPedltm02TnDV+qB/q
 o7oRSIYY99gt0E9/6B34RoMaBrO9EaI3Tz2XZ2BMo+fZsxjo5rvPyUapPPa1WQ8tPUR9
 oqP1HjaAbW4SZ/NFxtWda60s7+T6nbGPIZApOlo78TggKV+lkPW6nji6qfaZSGiwwyLa
 K+2w==
X-Gm-Message-State: APjAAAXyELF87YYX5c5WoZT2y2ZxdIxVoAHiapHK+b92M1KhyBEZqWLz
 U/F1kFiyfqrMbH8ANtNLelxrEg==
X-Google-Smtp-Source: APXvYqzhZt8tOPpvgEncrhEi32cLUxNZpk/sk9baaFRb2jfuBqkYpNd9Tx2hJNR2FLE/ebyjHi5YaA==
X-Received: by 2002:a1c:a5c1:: with SMTP id
 o184mr18447978wme.145.1560781193853; 
 Mon, 17 Jun 2019 07:19:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o13sm23781164wra.92.2019.06.17.07.19.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:19:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E557E1FF87;
 Mon, 17 Jun 2019 15:19:52 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-17-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-17-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:19:52 +0100
Message-ID: <87k1dk9tvb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 16/23] target/arm: Make
 arm_deliver_fault() static
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This function is now only called within op_helper.c.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

(although if we move the tlb related bits that might be different)

> ---
>  target/arm/internals.h | 3 ---
>  target/arm/op_helper.c | 5 +++--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 37ca493635..06e676bf62 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -767,9 +767,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, in=
t size,
>                        bool probe, uintptr_t retaddr);
>  #endif
>
> -void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
> -                       int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
> -
>  /* Return true if the stage 1 translation regime is using LPAE format pa=
ge
>   * tables */
>  bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx=
);
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index e43c99ebf0..63bce32810 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -127,8 +127,9 @@ static inline uint32_t merge_syn_data_abort(uint32_t =
template_syn,
>      return syn;
>  }
>
> -void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
> -                       int mmu_idx, ARMMMUFaultInfo *fi)
> +static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
> +                                            MMUAccessType access_type,
> +                                            int mmu_idx, ARMMMUFaultInfo=
 *fi)
>  {
>      CPUARMState *env =3D &cpu->env;
>      int target_el;


--
Alex Benn=C3=A9e

