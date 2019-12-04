Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D914C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9636F20674
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgzU/QBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9636F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icVUI-0004zL-J4
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 09:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icVS8-0003kk-OR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icVS7-0002Uq-Cc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:16:28 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icVS7-0002UT-2g
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 09:16:27 -0500
Received: by mail-wm1-x341.google.com with SMTP id u18so7149007wmc.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P+nz3wfcxONedD3W2LQnO8uhGvXwnLk4pwNHzcEtAkU=;
 b=EgzU/QBflyCstTgqWadvBfywmAvLBnG/Vy+2/C0tiV9M2MENUcC+oy7vYqmguuc78M
 arb2Nf2KRa15EOjP+1IyrLHE5e6uvGTGzKAYiCd4HjPCjMTHq96cSX0lnk8Izy4AjKI5
 UynoBoGFOhn6GHt02isCmdTKsmKIyxPTkZ8RqoE4MU3WxHWoquGeziZdN8VXsdXWU6Fn
 yHmFLIdNLNyHzF6o1d1mJ7fPLTgjQhOAZbi9vZFqjCt7Cbr5CXUZQVatUoUUN55biNvl
 rUGURqD5oNusUb+QeIbUHWEkC2GX6g3JtHWuuEBw2gMTIILuQnTPlNziAh6EsK6HdfFZ
 PNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P+nz3wfcxONedD3W2LQnO8uhGvXwnLk4pwNHzcEtAkU=;
 b=lje/RGSI2mxFfdJ+W72dRn9fuTPrtpFhj1lTsQ2mmF4sGQSfUw9fh6bQTrls+F6nY4
 PyXd7AReoVut6VA2ddZBhuxfFSuPHyxU714mutfTLUSbCnhFs+ZYPrTvOyn4SF5VPerT
 giWlTvMX7CbugGhjUYhU6bZ2kp4GpjalnbCPLSI9x0KCAZy4k/lklziuG5VOuP1qNLi8
 FdtbA2U3R+JsPao+O0PJRgxVAgif1NzizS81DELtgDl/X2qEwS9PMSATGzl8U9SWoOuM
 2ubK6uKBppslSuFEXbx5WvuxSExnNtuBLOCMiNNyd5JYHbJZEAuY0Bk7qEShiOo1mPeG
 RQCQ==
X-Gm-Message-State: APjAAAXJTLYGFBmBxKSXGr2QcgkUz/yS5I3HJR1gYXQ5Tp2Rm8TFskSH
 E0suPmOIfFYpxAO/SHt9jZTJiQ==
X-Google-Smtp-Source: APXvYqyZaSfy/5yy8F/PyTzZ7IHR+6dlhxtct91lUgCS/fp4/ZoPd8huq16veMqX+jx5LkjXeyMdlg==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr17505024wmi.18.1575468985732; 
 Wed, 04 Dec 2019 06:16:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k127sm7122934wmk.31.2019.12.04.06.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 06:16:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9858F1FF87;
 Wed,  4 Dec 2019 14:16:23 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-20-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 19/40] target/arm: Add regime_has_2_ranges
In-reply-to: <20191203022937.1474-20-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 14:16:23 +0000
Message-ID: <87blso89c8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/internals.h     | 16 ++++++++++++++++
>  target/arm/helper.c        | 23 ++++++-----------------
>  target/arm/translate-a64.c |  3 +--
>  3 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index d73615064c..1ca9a7cc78 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -837,6 +837,22 @@ static inline void arm_call_el_change_hook(ARMCPU *c=
pu)
>      }
>  }
>=20=20
> +/* Return true if this address translation regime has two ranges.  */
> +static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_Stage1_E0:
> +    case ARMMMUIdx_Stage1_E1:
> +    case ARMMMUIdx_EL10_0:
> +    case ARMMMUIdx_EL10_1:
> +    case ARMMMUIdx_EL20_0:
> +    case ARMMMUIdx_EL20_2:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>  /* Return true if this address translation regime is secure */
>  static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f86285ffbe..27adf24fa6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8885,15 +8885,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx =
mmu_idx, bool is_aa64,
>      }
>=20=20
>      if (is_aa64) {
> -        switch (regime_el(env, mmu_idx)) {
> -        case 1:
> -            if (!is_user) {
> -                xn =3D pxn || (user_rw & PAGE_WRITE);
> -            }
> -            break;
> -        case 2:
> -        case 3:
> -            break;
> +        if (regime_has_2_ranges(mmu_idx) && !is_user) {
> +            xn =3D pxn || (user_rw & PAGE_WRITE);
>          }
>      } else if (arm_feature(env, ARM_FEATURE_V7)) {
>          switch (regime_el(env, mmu_idx)) {
> @@ -9427,7 +9420,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState=
 *env, uint64_t va,
>                                          ARMMMUIdx mmu_idx)
>  {
>      uint64_t tcr =3D regime_tcr(env, mmu_idx)->raw_tcr;
> -    uint32_t el =3D regime_el(env, mmu_idx);
>      bool tbi, tbid, epd, hpd, using16k, using64k;
>      int select, tsz;
>=20=20
> @@ -9437,7 +9429,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState=
 *env, uint64_t va,
>       */
>      select =3D extract64(va, 55, 1);
>=20=20
> -    if (el > 1) {
> +    if (!regime_has_2_ranges(mmu_idx)) {
>          tsz =3D extract32(tcr, 0, 6);
>          using64k =3D extract32(tcr, 14, 1);
>          using16k =3D extract32(tcr, 15, 1);
> @@ -9593,10 +9585,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, t=
arget_ulong address,
>          param =3D aa64_va_parameters(env, address, mmu_idx,
>                                     access_type !=3D MMU_INST_FETCH);
>          level =3D 0;
> -        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mar=
k it
> -         * invalid.
> -         */
> -        ttbr1_valid =3D (el < 2);
> +        ttbr1_valid =3D regime_has_2_ranges(mmu_idx);
>          addrsize =3D 64 - 8 * param.tbi;
>          inputsize =3D 64 - param.tsz;
>      } else {
> @@ -11306,8 +11295,8 @@ static uint32_t rebuild_hflags_a64(CPUARMState *e=
nv, int el, int fp_el,
>=20=20
>      flags =3D FIELD_DP32(flags, TBFLAG_ANY, AARCH64_STATE, 1);
>=20=20
> -    /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -    if (regime_el(env, stage1) < 2) {
> +    /* Get control bits for tagged addresses.  */
> +    if (regime_has_2_ranges(mmu_idx)) {
>          ARMVAParameters p1 =3D aa64_va_parameters_both(env, -1, stage1);
>          tbid =3D (p1.tbi << 1) | p0.tbi;
>          tbii =3D tbid & ~((p1.tbid << 1) | p0.tbid);
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 885c99f0c9..d0b65c49e2 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -175,8 +175,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv=
_i64 dst,
>      if (tbi =3D=3D 0) {
>          /* Load unmodified address */
>          tcg_gen_mov_i64(dst, src);
> -    } else if (s->current_el >=3D 2) {
> -        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> +    } else if (!regime_has_2_ranges(s->mmu_idx)) {
>          /* Force tag byte to all zero */
>          tcg_gen_extract_i64(dst, src, 0, 56);
>      } else {


--=20
Alex Benn=C3=A9e

