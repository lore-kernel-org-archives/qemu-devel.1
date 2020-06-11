Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4104C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB1E20656
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzPKDuqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1E20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjJrf-0007yy-SS
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 05:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjJqw-0007YG-5b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:50:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:51300)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjJqu-0001S6-S2
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 05:50:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id u13so4384093wml.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=X0SVFBD78fLbKhaKNWJwY01qaBtpmAjglqTvJa24q4Q=;
 b=zzPKDuqNK764EddlwGhBsiSaPZHJ8t8QWt7ZG0nJfiIBhjzOLF16U0rlVhMnyI7kF0
 MS3Zi47jEKGNrBHcyomUMH8wMHIiKPW5wnPTU1ERIq59bZd1cm6A5f+2SzzvZJqIQgde
 90A8USMoc+3t3eQsXNSBk9q2Qi1UAjXpM4yIFyh/pHNVDp3GnUXTB/WVHFXPI81Mshht
 f3P9aTDUg5V3NYYCzKfMlxGIUhcfVeWZKIEWz897EUickHyxeRr/QD5az7WnymDrXL3D
 idS3AZH4esTxrj6F5JmrhYH+AhPYaEhWerzWWQyqp/fm75OtqtU6HxLVMRWgvanPMWT2
 Kpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=X0SVFBD78fLbKhaKNWJwY01qaBtpmAjglqTvJa24q4Q=;
 b=qkXgJBPJb7pz4tnSxnQCLkOLoIKHw+3yswzYA5hHPmej+hYazNBveMYzFD6HtDkh14
 Cm/T1mDeRdc7b3/XaZRFFlrs3eBgIkmTCcIAsMzH0tQ3pQ3qYoGpJiB2ojRu18XNq0Rm
 NFQWHvd0Uk+Onk31mnuOb2DgPgNAv3Gb4KqnFSTbId1V/r02D3aX/S5mEMhETprppbBn
 /C/5y/mu0DAxJ/aOlXjYLWPomHEcALFw0jHNaL5Jk4Czipsn/6Bo7v3G3o9UbWIQdDAF
 lbIDwSITRyuelQIiThu1EjxLQAjOFuKjkHsu8pF/foBkagzf5EwJzbAWQmqtI/l7s7bB
 5UcA==
X-Gm-Message-State: AOAM532vS7GwDm6hLjTAAgQiRYSUUckYC00/kXjqEDdsjOKMMpnKRxQO
 a16nUsf8Toh7R/UplMp+dudOhg==
X-Google-Smtp-Source: ABdhPJyuV1GcJpI90dvNBSThYNT3WhzHEMDev6yr8t3fvvDViAjEHglv7FO/gCiUkJM3f8sMZbOTjg==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr7375759wmf.4.1591869020713; 
 Thu, 11 Jun 2020 02:50:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e15sm3416191wme.9.2020.06.11.02.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 02:50:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 636911FF7E;
 Thu, 11 Jun 2020 10:50:18 +0100 (BST)
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1591015405-19651-5-git-send-email-aleksandar.qemu.devel@gmail.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PULL 4/6] target/mips: Add more CP0 register for save/restore
In-reply-to: <1591015405-19651-5-git-send-email-aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 10:50:18 +0100
Message-ID: <87h7vi3p9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> From: Huacai Chen <zltjiangshi@gmail.com>
>
> Add more CP0 register for save/restore, including: EBase, XContext,
> PageGrain, PWBase, PWSize, PWField, PWCtl, Config*, KScratch1~KScratch6.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Message-Id: <1588501221-1205-6-git-send-email-chenhc@lemote.com>

It seems while our mips cross build has been broken this commit has
caused a build regression:

  make docker-test-build@debian-mips-cross J=3D30

Results in:

  /tmp/qemu-test/src/target/mips/kvm.c: In function 'kvm_mips_put_cp0_regis=
ters':
  /tmp/qemu-test/src/target/mips/kvm.c:412:49: error: 'CP0C6_BPPASS' undecl=
ared (first use in this function); did you mean 'CP0C3_LPA'?
   #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
                                                   ^~~~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macro =
'KVM_REG_MIPS_CP0_CONFIG6_MASK'
                                     KVM_REG_MIPS_CP0_CONFIG6_MASK);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:412:49: note: each undeclared identi=
fier is reported only once for each function it appears in
   #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
                                                   ^~~~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macro =
'KVM_REG_MIPS_CP0_CONFIG6_MASK'
                                     KVM_REG_MIPS_CP0_CONFIG6_MASK);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:413:52: error: 'CP0C6_KPOS' undeclar=
ed (first use in this function); did you mean 'CP0C3_IPLV'?
                                            (0x3fU << CP0C6_KPOS) | \
                                                      ^~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macro =
'KVM_REG_MIPS_CP0_CONFIG6_MASK'
                                     KVM_REG_MIPS_CP0_CONFIG6_MASK);
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:414:49: error: 'CP0C6_KE' undeclared=
 (first use in this function); did you mean 'CP0C4_AE'?
                                            (1U << CP0C6_KE) | \
                                                   ^~~~~~~~
  /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macro =
'KVM_REG_MIPS_CP0_CONFIG6_MASK'
                                     KVM_REG_MIPS_CP0_CONFIG6_MASK);


> ---
>  target/mips/kvm.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/mips/machine.c |   6 +-
>  2 files changed, 216 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index de3e26e..96cfa10 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -245,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int ir=
q, int level)
>      (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
>=20=20
>  #define KVM_REG_MIPS_CP0_INDEX          MIPS_CP0_32(0, 0)
> +#define KVM_REG_MIPS_CP0_RANDOM         MIPS_CP0_32(1, 0)
>  #define KVM_REG_MIPS_CP0_CONTEXT        MIPS_CP0_64(4, 0)
>  #define KVM_REG_MIPS_CP0_USERLOCAL      MIPS_CP0_64(4, 2)
>  #define KVM_REG_MIPS_CP0_PAGEMASK       MIPS_CP0_32(5, 0)
> +#define KVM_REG_MIPS_CP0_PAGEGRAIN      MIPS_CP0_32(5, 1)
> +#define KVM_REG_MIPS_CP0_PWBASE         MIPS_CP0_64(5, 5)
> +#define KVM_REG_MIPS_CP0_PWFIELD        MIPS_CP0_64(5, 6)
> +#define KVM_REG_MIPS_CP0_PWSIZE         MIPS_CP0_64(5, 7)
>  #define KVM_REG_MIPS_CP0_WIRED          MIPS_CP0_32(6, 0)
> +#define KVM_REG_MIPS_CP0_PWCTL          MIPS_CP0_32(6, 6)
>  #define KVM_REG_MIPS_CP0_HWRENA         MIPS_CP0_32(7, 0)
>  #define KVM_REG_MIPS_CP0_BADVADDR       MIPS_CP0_64(8, 0)
>  #define KVM_REG_MIPS_CP0_COUNT          MIPS_CP0_32(9, 0)
> @@ -258,13 +264,22 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int ir=
q, int level)
>  #define KVM_REG_MIPS_CP0_CAUSE          MIPS_CP0_32(13, 0)
>  #define KVM_REG_MIPS_CP0_EPC            MIPS_CP0_64(14, 0)
>  #define KVM_REG_MIPS_CP0_PRID           MIPS_CP0_32(15, 0)
> +#define KVM_REG_MIPS_CP0_EBASE          MIPS_CP0_64(15, 1)
>  #define KVM_REG_MIPS_CP0_CONFIG         MIPS_CP0_32(16, 0)
>  #define KVM_REG_MIPS_CP0_CONFIG1        MIPS_CP0_32(16, 1)
>  #define KVM_REG_MIPS_CP0_CONFIG2        MIPS_CP0_32(16, 2)
>  #define KVM_REG_MIPS_CP0_CONFIG3        MIPS_CP0_32(16, 3)
>  #define KVM_REG_MIPS_CP0_CONFIG4        MIPS_CP0_32(16, 4)
>  #define KVM_REG_MIPS_CP0_CONFIG5        MIPS_CP0_32(16, 5)
> +#define KVM_REG_MIPS_CP0_CONFIG6        MIPS_CP0_32(16, 6)
> +#define KVM_REG_MIPS_CP0_XCONTEXT       MIPS_CP0_64(20, 0)
>  #define KVM_REG_MIPS_CP0_ERROREPC       MIPS_CP0_64(30, 0)
> +#define KVM_REG_MIPS_CP0_KSCRATCH1      MIPS_CP0_64(31, 2)
> +#define KVM_REG_MIPS_CP0_KSCRATCH2      MIPS_CP0_64(31, 3)
> +#define KVM_REG_MIPS_CP0_KSCRATCH3      MIPS_CP0_64(31, 4)
> +#define KVM_REG_MIPS_CP0_KSCRATCH4      MIPS_CP0_64(31, 5)
> +#define KVM_REG_MIPS_CP0_KSCRATCH5      MIPS_CP0_64(31, 6)
> +#define KVM_REG_MIPS_CP0_KSCRATCH6      MIPS_CP0_64(31, 7)
>=20=20
>  static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t reg_id,
>                                         int32_t *addr)
> @@ -394,6 +409,29 @@ static inline int kvm_mips_get_one_ureg64(CPUState *=
cs, uint64_t reg_id,
>                                           (1U << CP0C5_UFE) | \
>                                           (1U << CP0C5_FRE) | \
>                                           (1U << CP0C5_UFR))
> +#define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
> +                                         (0x3fU << CP0C6_KPOS) | \
> +                                         (1U << CP0C6_KE) | \
> +                                         (1U << CP0C6_VTLBONLY) | \
> +                                         (1U << CP0C6_LASX) | \
> +                                         (1U << CP0C6_SSEN) | \
> +                                         (1U << CP0C6_DISDRTIME) | \
> +                                         (1U << CP0C6_PIXNUEN) | \
> +                                         (1U << CP0C6_SCRAND) | \
> +                                         (1U << CP0C6_LLEXCEN) | \
> +                                         (1U << CP0C6_DISVC) | \
> +                                         (1U << CP0C6_VCLRU) | \
> +                                         (1U << CP0C6_DCLRU) | \
> +                                         (1U << CP0C6_PIXUEN) | \
> +                                         (1U << CP0C6_DISBLKLYEN) | \
> +                                         (1U << CP0C6_UMEMUALEN) | \
> +                                         (1U << CP0C6_SFBEN) | \
> +                                         (1U << CP0C6_FLTINT) | \
> +                                         (1U << CP0C6_VLTINT) | \
> +                                         (1U << CP0C6_DISBTB) | \
> +                                         (3U << CP0C6_STPREFCTL) | \
> +                                         (1U << CP0C6_INSTPREF) | \
> +                                         (1U << CP0C6_DATAPREF))

It seems a lot of the defines here aren't in this commit. Was one missed?

--=20
Alex Benn=C3=A9e

