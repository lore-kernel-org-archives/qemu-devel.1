Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FBB206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqmhBAQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FBB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVfX-0003FK-Ni
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVeK-0001Wf-KI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVci-0002r9-QH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:12:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jTVci-0002py-Bl
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:10:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so4097835wmc.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Hh9g3OvLgj7bdbZU/WOPKLwA7dm0ZqxH+zemTSNDoRs=;
 b=sqmhBAQpnb/p6JL/HukZP8WJNjSj54NBTo/P/nIcJU5h3EyPgvdHlg/Ogl+aqLY7aA
 ncMMDcKxGqHYfolX4wqbylAP6YybDwhrZ/Wsy5vRlNIykQ7Q8Wa2YQqlvquvH9i+N4mv
 SP8kGUp+5ucwaae2kTjes7U0C2JPMrudYUOfYVispqeQ2zbS6i0fVlmSlwpE6SuqD4ie
 k9hfLD7zY4/BC7jaeHyJlsSuX5FxnRFSQVil7eIJRgUyGVvkFfaCUwcFVbVFoTsdWZ7u
 UBm+FruL+MmUdR0Th/7KwJ8PjIa1kwLR1O/Tme2LK51o2jdMrmdRuUyiR7ML2Ck3GFPA
 Y4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Hh9g3OvLgj7bdbZU/WOPKLwA7dm0ZqxH+zemTSNDoRs=;
 b=r3dZ9Ri35eTDeLKduYHm4dsfkrkT43JetTbedPn7AUvX/uXD+HhpC4fGPA6qwDj2fJ
 LZxi9ej292fu9dWgAVaRRnQF3wKFc+Ynd785A2dqHgD6Fk4fvfrJ5VqfmyI1e//a+/0s
 V4sQ2X+gP0Q3k12Adjtsluvq+d9soys3Kv8xR0oHZDKxhK1HJdS7XwuFhHCrKXQDZQuK
 39SnRWZZD1Qw/x2D06Fsg0C28O8gzQU8KXP9KapY/Aay836Vl7Kx1ZEvjndyEvGRkodE
 U9AX3aIUBbZOtv2KAOJJ+5ohvsGhEJY7zy684/KnlkfyprsiuWCNsnDdUBHGIaPdWdNG
 2AxA==
X-Gm-Message-State: AGi0PuYJmJLbkvLQsBu0jEI9PziikrVeTOnXq/YVdOL1gaXajpuKEbtr
 9Z9Tdv/dcmH+05v3soq/25c0M0VDLSAeWBxo3S4=
X-Google-Smtp-Source: APiQypKs4bmyn+KvCN5FChz+bWtUnU+YQtP2poN9DD4WeJMEOqspJ10arpBzpoAj8ZYYxwm84UcNfqysnWqGRUHDyHg=
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr5950795wme.159.1588101026687; 
 Tue, 28 Apr 2020 12:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-5-git-send-email-chenhc@lemote.com>
In-Reply-To: <1587979995-17717-5-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 28 Apr 2020 21:10:14 +0200
Message-ID: <CAHiYmc7xZ3TVphhxxTgtEqx2L2pDPsvjXZzXQ-bMQx5U2UuwdQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 5/7] target/mips: Add more CP0 register for
 save/restore
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 27. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:36 Huacai Chen <=
zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Add more CP0 register for save/restore, including: EBase, XContext,
> PageGrain, PWBase, PWSize, PWField, PWCtl, Config*, KScratch1~KScratch6.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  target/mips/kvm.c     | 212 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/mips/machine.c |   2 +
>  2 files changed, 214 insertions(+)
>
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index de3e26e..96cfa10 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -245,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int ir=
q, int level)
>      (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
>
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
>
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
>
>  static inline int kvm_mips_change_one_reg(CPUState *cs, uint64_t reg_id,
>                                            int32_t *addr, int32_t mask)
> @@ -729,6 +767,11 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, =
int level)
>          DPRINTF("%s: Failed to put CP0_INDEX (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_=
Random);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_RANDOM (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
>                                   &env->CP0_Context);
>      if (err < 0) {
> @@ -747,11 +790,40 @@ static int kvm_mips_put_cp0_registers(CPUState *cs,=
 int level)
>          DPRINTF("%s: Failed to put CP0_PAGEMASK (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
> +                               &env->CP0_PageGrain);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PAGEGRAIN (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
> +                               &env->CP0_PWBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWBASE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
> +                               &env->CP0_PWField);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWField (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
> +                               &env->CP0_PWSize);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWSIZE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_W=
ired);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_WIRED (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_P=
WCtl);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_PWCTL (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_put_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_=
HWREna);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_HWRENA (%d)\n", __func__, err);
> @@ -799,6 +871,11 @@ static int kvm_mips_put_cp0_registers(CPUState *cs, =
int level)
>          DPRINTF("%s: Failed to put CP0_PRID (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0=
_EBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_EBASE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG,
>                                    &env->CP0_Config0,
>                                    KVM_REG_MIPS_CP0_CONFIG_MASK);
> @@ -841,12 +918,61 @@ static int kvm_mips_put_cp0_registers(CPUState *cs,=
 int level)
>          DPRINTF("%s: Failed to change CP0_CONFIG5 (%d)\n", __func__, err=
);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_change_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6,
> +                                  &env->CP0_Config6,
> +                                  KVM_REG_MIPS_CP0_CONFIG6_MASK);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to change CP0_CONFIG6 (%d)\n", __func__, err=
);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
> +                                 &env->CP0_XContext);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_XCONTEXT (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
>                                   &env->CP0_ErrorEPC);
>      if (err < 0) {
>          DPRINTF("%s: Failed to put CP0_ERROREPC (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
> +                                 &env->CP0_KScratch[0]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH1 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
> +                                 &env->CP0_KScratch[1]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH2 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
> +                                 &env->CP0_KScratch[2]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH3 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
> +                                 &env->CP0_KScratch[3]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH4 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
> +                                 &env->CP0_KScratch[4]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH5 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_put_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
> +                                 &env->CP0_KScratch[5]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to put CP0_KSCRATCH6 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
>
>      return ret;
>  }
> @@ -862,6 +988,11 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_INDEX (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_RANDOM, &env->CP0_=
Random);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_RANDOM (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_CONTEXT,
>                                   &env->CP0_Context);
>      if (err < 0) {
> @@ -880,11 +1011,40 @@ static int kvm_mips_get_cp0_registers(CPUState *cs=
)
>          DPRINTF("%s: Failed to get CP0_PAGEMASK (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PAGEGRAIN,
> +                               &env->CP0_PageGrain);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PAGEGRAIN (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWBASE,
> +                               &env->CP0_PWBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWBASE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWFIELD,
> +                               &env->CP0_PWField);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWFIELD (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_PWSIZE,
> +                               &env->CP0_PWSize);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWSIZE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_WIRED, &env->CP0_W=
ired);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_WIRED (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_PWCTL, &env->CP0_P=
WCtl);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_PWCtl (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_HWRENA, &env->CP0_=
HWREna);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_HWRENA (%d)\n", __func__, err);
> @@ -932,6 +1092,11 @@ static int kvm_mips_get_cp0_registers(CPUState *cs)
>          DPRINTF("%s: Failed to get CP0_PRID (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_EBASE, &env->CP0=
_EBase);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_EBASE (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG, &env->CP0_=
Config0);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_CONFIG (%d)\n", __func__, err);
> @@ -962,12 +1127,59 @@ static int kvm_mips_get_cp0_registers(CPUState *cs=
)
>          DPRINTF("%s: Failed to get CP0_CONFIG5 (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_reg(cs, KVM_REG_MIPS_CP0_CONFIG6, &env->CP0=
_Config6);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_CONFIG6 (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_XCONTEXT,
> +                                 &env->CP0_XContext);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_XCONTEXT (%d)\n", __func__, err);
> +        ret =3D err;
> +    }
>      err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_ERROREPC,
>                                   &env->CP0_ErrorEPC);
>      if (err < 0) {
>          DPRINTF("%s: Failed to get CP0_ERROREPC (%d)\n", __func__, err);
>          ret =3D err;
>      }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH1,
> +                                 &env->CP0_KScratch[0]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH1 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH2,
> +                                 &env->CP0_KScratch[1]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH2 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH3,
> +                                 &env->CP0_KScratch[2]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH3 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH4,
> +                                 &env->CP0_KScratch[3]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH4 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH5,
> +                                 &env->CP0_KScratch[4]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH5 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
> +    err =3D kvm_mips_get_one_ulreg(cs, KVM_REG_MIPS_CP0_KSCRATCH6,
> +                                 &env->CP0_KScratch[5]);
> +    if (err < 0) {
> +        DPRINTF("%s: Failed to get CP0_KSCRATCH6 (%d)\n", __func__, err)=
;
> +        ret =3D err;
> +    }
>
>      return ret;
>  }
> diff --git a/target/mips/machine.c b/target/mips/machine.c
> index 8d5b18b..a84aefc 100644
> --- a/target/mips/machine.c
> +++ b/target/mips/machine.c
> @@ -289,6 +289,8 @@ const VMStateDescription vmstate_mips_cpu =3D {
>          VMSTATE_INT32(env.CP0_Config1, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config2, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config3, MIPSCPU),
> +        VMSTATE_INT32(env.CP0_Config4, MIPSCPU),
> +        VMSTATE_INT32(env.CP0_Config5, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config6, MIPSCPU),
>          VMSTATE_INT32(env.CP0_Config7, MIPSCPU),
>          VMSTATE_UINT64(env.CP0_LLAddr, MIPSCPU),
> --
> 2.7.0
>

Huacai,

You need to bump two fields in VMStateDescription any time you add new fiel=
ds.

This means two instances of "19" should be changed to "20" here:

const VMStateDescription vmstate_mips_cpu =3D {
.name =3D "cpu",
.version_id =3D 19,
.minimum_version_id =3D 19,
.post_load =3D cpu_post_load,
.fields =3D (VMStateField[]) {

Thanks,
Aleksandar

