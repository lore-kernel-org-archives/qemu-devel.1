Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEBC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F1B206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stIIBEXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiO6s-0001Ce-3Y
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO65-0000bj-3y
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiO61-00059M-Nd
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:38:00 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiO61-000544-Dw
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:37:57 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so10522671wrr.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4GguzwsmwoD0JTdKyIcA7bii08Y6aH+q/XXyjIEKACk=;
 b=stIIBEXmp1kd6S9SNOPzmd9yg9HiWNgp5qlrGq5TIL1Wy+mvNQMHjcyLFXiudROu/M
 pcTORJmnC1HLyqyuR8uFPVrQ06HL3Wi8gVEUNl+g9X8w1ipljSIhRIwQZGK1gDJ+5Fra
 FX/tM4BHI3xeKQAjtsDdnVLvqpNa/UpUt3n0xn3/B2LTe8n7dOo6xSppYq7JD+wfz9uw
 3QTTpio9Zsit4qV7SEoRkQjwituF9gm9Yp9fDpmSjsza2PF9ap7v8+G7y8hnV3WiAm5V
 p5uzA757TNkMaRDJv1tn/kwr6RLrDHre1U8i+0tpdb9F9E+dCBMACgALpCJ/cRm91olM
 kcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=4GguzwsmwoD0JTdKyIcA7bii08Y6aH+q/XXyjIEKACk=;
 b=AbSkkluolxA+PpZ1prG7JGUFWUwq/i01OTdzTT6QXjDHW51jnV5inCVPlWXa4pABTm
 QurM8CzzhIapvUgd49XuVCdjFdSG3FmqxKSmHLdIcgkfsST2aSPxpgczWXQd1uiNbEJU
 lQGlMDyMBUO4S7b4NmzaVOQF6En0oZ7hmdrlhvSYNbMXk/95tF/vqtDo5iLJ9qMgFr2u
 Dm83B7Hn32XmtKCUEYU9IuduilhTa5keZMdxXc2ojL2BOoCOuaAFKBYi9rtCaMX25QJW
 LQBzGHJy9SbQKlymqNZh0Cq7Mgq+blFoMGumGjHJJSG3PikaDApHrH3cz9wS68IBXj19
 3lGw==
X-Gm-Message-State: APjAAAVCRS+dtg8Jhh6ONOiItvOFB2Sw+7d3UVEeMTr237wfAIcJ72Fe
 QWCIdfpKeSK1EB3AY6v+PxgvNg==
X-Google-Smtp-Source: APXvYqz6aDtpN8kQ5yWs5JQoEMgsvVxeNV4loRJacat64Dga0p1gC4Te9D8fKmeiLMRGQBQUvVf7fg==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr17062111wru.220.1576870675343; 
 Fri, 20 Dec 2019 11:37:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h2sm11423791wrt.45.2019.12.20.11.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:37:54 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4833B1FF87;
 Fri, 20 Dec 2019 19:37:53 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-25-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 24/28] target/mips: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
In-reply-to: <20191216221158.29572-25-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:37:53 +0000
Message-ID: <87bls2bxf2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The separate suffixed functions were used to construct
> some do_##insn function switched on mmu_idx.  The interface
> is exactly identical to the *_mmuidx_ra functions.  Replace
> them directly and remove the constructions.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/mips/cpu.h       |   4 -
>  target/mips/op_helper.c | 182 +++++++++++++---------------------------
>  2 files changed, 60 insertions(+), 126 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index ca00f41daf..c218ccc4a8 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1147,10 +1147,6 @@ extern uint32_t cpu_rddsp(uint32_t mask_num, CPUMI=
PSState *env);
>   * MMU modes definitions. We carefully match the indices with our
>   * hflags layout.
>   */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _super
> -#define MMU_MODE2_SUFFIX _user
> -#define MMU_MODE3_SUFFIX _error
>  #define MMU_USER_IDX 2
>=20=20
>  static inline int hflags_mmu_index(uint32_t hflags)
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 18fcee4a78..79d44da6fa 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -52,69 +52,6 @@ static void raise_exception(CPUMIPSState *env, uint32_=
t exception)
>      do_raise_exception(env, exception, 0);
>  }
>=20=20
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    return (type) cpu_##insn##_data_ra(env, addr, retaddr);             \
> -}
> -#else
> -#define HELPER_LD(name, insn, type)                                     \
> -static inline type do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             int mem_idx, uintptr_t retaddr)            \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0: return (type) cpu_##insn##_kernel_ra(env, addr, retaddr);   \
> -    case 1: return (type) cpu_##insn##_super_ra(env, addr, retaddr);    \
> -    default:                                                            \
> -    case 2: return (type) cpu_##insn##_user_ra(env, addr, retaddr);     \
> -    case 3: return (type) cpu_##insn##_error_ra(env, addr, retaddr);    \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_LD(lw, ldl, int32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_LD(ld, ldq, int64_t)
> -#endif
> -#undef HELPER_LD
> -
> -#if defined(CONFIG_USER_ONLY)
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    cpu_##insn##_data_ra(env, addr, val, retaddr);                      \
> -}
> -#else
> -#define HELPER_ST(name, insn, type)                                     \
> -static inline void do_##name(CPUMIPSState *env, target_ulong addr,      \
> -                             type val, int mem_idx, uintptr_t retaddr)  \
> -{                                                                       \
> -    switch (mem_idx) {                                                  \
> -    case 0:                                                             \
> -        cpu_##insn##_kernel_ra(env, addr, val, retaddr);                \
> -        break;                                                          \
> -    case 1:                                                             \
> -        cpu_##insn##_super_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    default:                                                            \
> -    case 2:                                                             \
> -        cpu_##insn##_user_ra(env, addr, val, retaddr);                  \
> -        break;                                                          \
> -    case 3:                                                             \
> -        cpu_##insn##_error_ra(env, addr, val, retaddr);                 \
> -        break;                                                          \
> -    }                                                                   \
> -}
> -#endif
> -HELPER_ST(sb, stb, uint8_t)
> -HELPER_ST(sw, stl, uint32_t)
> -#if defined(TARGET_MIPS64)
> -HELPER_ST(sd, stq, uint64_t)
> -#endif
> -#undef HELPER_ST
> -
>  /* 64 bits arithmetic for 32 bits hosts */
>  static inline uint64_t get_HILO(CPUMIPSState *env)
>  {
> @@ -379,12 +316,12 @@ target_ulong helper_##name(CPUMIPSState *env, targe=
t_ulong arg, int mem_idx)  \
>      }                                                                   =
      \
>      env->CP0_LLAddr =3D do_translate_address(env, arg, 0, GETPC());     =
        \
>      env->lladdr =3D arg;                                                =
        \
> -    env->llval =3D do_##insn(env, arg, mem_idx, GETPC());               =
        \
> +    env->llval =3D cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  =
        \
>      return env->llval;                                                  =
      \
>  }
> -HELPER_LD_ATOMIC(ll, lw, 0x3)
> +HELPER_LD_ATOMIC(ll, ldl, 0x3)
>  #ifdef TARGET_MIPS64
> -HELPER_LD_ATOMIC(lld, ld, 0x7)
> +HELPER_LD_ATOMIC(lld, ldq, 0x7)
>  #endif
>  #undef HELPER_LD_ATOMIC
>  #endif
> @@ -400,42 +337,42 @@ HELPER_LD_ATOMIC(lld, ld, 0x7)
>  void helper_swl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 24), mem_idx, GETPC()=
);
>=20=20
>      if (GET_LMASK(arg2) <=3D 2) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 16=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK(arg2) <=3D 1) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK(arg2) =3D=3D 0) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>=20=20
>  void helper_swr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>=20=20
>      if (GET_LMASK(arg2) >=3D 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK(arg2) >=3D 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 1=
6),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK(arg2) =3D=3D 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 2=
4),
> +                          mem_idx, GETPC());
>      }
>  }
>=20=20
> @@ -453,82 +390,82 @@ void helper_swr(CPUMIPSState *env, target_ulong arg=
1, target_ulong arg2,
>  void helper_sdl(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)(arg1 >> 56), mem_idx, GETPC()=
);
>=20=20
>      if (GET_LMASK64(arg2) <=3D 6) {
> -        do_sb(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 1), (uint8_t)(arg1 >> 48=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 5) {
> -        do_sb(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 2), (uint8_t)(arg1 >> 40=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 4) {
> -        do_sb(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 3), (uint8_t)(arg1 >> 32=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 3) {
> -        do_sb(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 4), (uint8_t)(arg1 >> 24=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 2) {
> -        do_sb(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 5), (uint8_t)(arg1 >> 16=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 1) {
> -        do_sb(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 6), (uint8_t)(arg1 >> 8),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) <=3D 0) {
> -        do_sb(env, GET_OFFSET(arg2, 7), (uint8_t)arg1, mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, 7), (uint8_t)arg1,
> +                          mem_idx, GETPC());
>      }
>  }
>=20=20
>  void helper_sdr(CPUMIPSState *env, target_ulong arg1, target_ulong arg2,
>                  int mem_idx)
>  {
> -    do_sb(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
> +    cpu_stb_mmuidx_ra(env, arg2, (uint8_t)arg1, mem_idx, GETPC());
>=20=20
>      if (GET_LMASK64(arg2) >=3D 1) {
> -        do_sb(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -1), (uint8_t)(arg1 >> 8=
),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) >=3D 2) {
> -        do_sb(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 16), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -2), (uint8_t)(arg1 >> 1=
6),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) >=3D 3) {
> -        do_sb(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 24), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -3), (uint8_t)(arg1 >> 2=
4),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) >=3D 4) {
> -        do_sb(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 32), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -4), (uint8_t)(arg1 >> 3=
2),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) >=3D 5) {
> -        do_sb(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 40), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -5), (uint8_t)(arg1 >> 4=
0),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) >=3D 6) {
> -        do_sb(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 48), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -6), (uint8_t)(arg1 >> 4=
8),
> +                          mem_idx, GETPC());
>      }
>=20=20
>      if (GET_LMASK64(arg2) =3D=3D 7) {
> -        do_sb(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 56), mem_idx,
> -              GETPC());
> +        cpu_stb_mmuidx_ra(env, GET_OFFSET(arg2, -7), (uint8_t)(arg1 >> 5=
6),
> +                          mem_idx, GETPC());
>      }
>  }
>  #endif /* TARGET_MIPS64 */
> @@ -546,14 +483,14 @@ void helper_lwm(CPUMIPSState *env, target_ulong add=
r, target_ulong reglist,
>=20=20
>          for (i =3D 0; i < base_reglist; i++) {
>              env->active_tc.gpr[multiple_regs[i]] =3D
> -                (target_long)do_lw(env, addr, mem_idx, GETPC());
> +                (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC=
());
>              addr +=3D 4;
>          }
>      }
>=20=20
>      if (do_r31) {
> -        env->active_tc.gpr[31] =3D (target_long)do_lw(env, addr, mem_idx,
> -                                                    GETPC());
> +        env->active_tc.gpr[31] =3D
> +            (target_long)cpu_ldl_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>=20=20
> @@ -567,14 +504,14 @@ void helper_swm(CPUMIPSState *env, target_ulong add=
r, target_ulong reglist,
>          target_ulong i;
>=20=20
>          for (i =3D 0; i < base_reglist; i++) {
> -            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_i=
dx,
> -                  GETPC());
> +            cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_reg=
s[i]],
> +                              mem_idx, GETPC());
>              addr +=3D 4;
>          }
>      }
>=20=20
>      if (do_r31) {
> -        do_sw(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stw_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GE=
TPC());
>      }
>  }
>=20=20
> @@ -589,14 +526,15 @@ void helper_ldm(CPUMIPSState *env, target_ulong add=
r, target_ulong reglist,
>          target_ulong i;
>=20=20
>          for (i =3D 0; i < base_reglist; i++) {
> -            env->active_tc.gpr[multiple_regs[i]] =3D do_ld(env, addr, me=
m_idx,
> -                                                         GETPC());
> +            env->active_tc.gpr[multiple_regs[i]] =3D
> +                cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>              addr +=3D 8;
>          }
>      }
>=20=20
>      if (do_r31) {
> -        env->active_tc.gpr[31] =3D do_ld(env, addr, mem_idx, GETPC());
> +        env->active_tc.gpr[31] =3D
> +            cpu_ldq_mmuidx_ra(env, addr, mem_idx, GETPC());
>      }
>  }
>=20=20
> @@ -610,14 +548,14 @@ void helper_sdm(CPUMIPSState *env, target_ulong add=
r, target_ulong reglist,
>          target_ulong i;
>=20=20
>          for (i =3D 0; i < base_reglist; i++) {
> -            do_sd(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_i=
dx,
> -                  GETPC());
> +            cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[multiple_reg=
s[i]],
> +                              mem_idx, GETPC());
>              addr +=3D 8;
>          }
>      }
>=20=20
>      if (do_r31) {
> -        do_sd(env, addr, env->active_tc.gpr[31], mem_idx, GETPC());
> +        cpu_stq_mmuidx_ra(env, addr, env->active_tc.gpr[31], mem_idx, GE=
TPC());
>      }
>  }
>  #endif


--=20
Alex Benn=C3=A9e

