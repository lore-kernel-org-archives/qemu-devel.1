Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 530A5206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBxpMjpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530A5206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLq1-0005UM-Fo
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLpD-0004J4-VR
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLpC-0004I4-CA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:12:27 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiLpC-0004G1-2P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:12:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so10146663wrh.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=kDBaAcVOCGfiNZOMydGsbOx+i/UwgMxst3L8rRjBDKM=;
 b=JBxpMjpoSUqabqxyjVhip4UhXJNYlbAlT0w6wghF6+S+aycZu60AShxQ8ZJ3CT1ZBM
 N/VjL44csVBSiJPjkyiqTeP7CN5IlvwOfYC+olFh2UMNhgZ1SAJzEAdrPFvb2xcEKiET
 pSnK1DzmuP2/gpnlba7z5YYAL8iqw6FloKaLp3DdHU0z7o0GW6bf3XJK6Wb0dzEqXvbK
 AtDg78TfRMJhc5tSO3BF+oUu1WIhwQtSjYmcIXB5Omc3A6zo1TPP8/bX5EWpDmqSzLGY
 8aL8Sp71Ll7zS80HBScaDw3LifhioTGCCiK88G5w8EAvTo8Krpr28HuOcJygCo7S57P7
 G8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kDBaAcVOCGfiNZOMydGsbOx+i/UwgMxst3L8rRjBDKM=;
 b=CRtKaQ8ZB+jBIRwx7hmpdMhdORXB+iHL6N4QZgNq83TZsjER1tTa0BS8VO8igFQiiz
 jqhN8a9fjn72pkCVilkcJWNJ1etrQ2E6LLHQOMnMvFHJBQgXZ/dzTKH/MGukY4vrlPR8
 wBeWecHdZgt+qNRIGNojMTaDvQne6eTddqKFVUmFgmJ+3DhOEs+pIOmGT3H+f3W2HKcR
 2CcFgm5M/WMZDXFtK/W3kNeRk9dFe7kQdPU/yZEn/JeLbjdOBe6ZMLa7nyu2EHrXK9Y+
 rmDqYyULRcZEnRBquFIh5n1OIiAC9outohQ/gsEohvn7gHyR4GrtFKFks7XmqXxQBK3M
 Seiw==
X-Gm-Message-State: APjAAAXdm1bSmPVNWH0S0QuHmuCmgn38fU0TPTcD2iujsI2SJz+KEgeU
 o8uMUcIFON5ld25rXOF8/ykMzKfzyKo=
X-Google-Smtp-Source: APXvYqwp6U3nzT6GxJ3/fFqOE8wirMreSyoePNH8qELDaVIbtuYHM6TpsvG7WQ/QjfHDYKZ6tKFEQw==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr16160908wrp.1.1576861943629; 
 Fri, 20 Dec 2019 09:12:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x10sm10927373wrp.58.2019.12.20.09.12.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:12:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 97C081FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 17:12:21 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/28] translator: Use cpu_ld*_code instead of
 open-coding
In-reply-to: <20191216221158.29572-6-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:12:21 +0000
Message-ID: <87woaqdiq2.fsf@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The DO_LOAD macros replicate the distinction already performed
> by the cpu_ldst.h functions.  Use them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst.h   | 11 ---------
>  include/exec/translator.h | 48 +++++++++++----------------------------
>  2 files changed, 13 insertions(+), 46 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index cf8af36dbc..399ff6c3da 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -129,11 +129,6 @@ static inline void clear_helper_retaddr(void)
>  #include "exec/cpu_ldst_useronly_template.h"
>  #undef MEMSUFFIX
>=20=20
> -/*
> - * Code access is deprecated in favour of translator_ld* functions
> - * (see translator.h). However there are still users that need to
> - * converted so for now these stay.
> - */
>  #define MEMSUFFIX _code
>  #define CODE_ACCESS
>  #define DATA_SIZE 1
> @@ -455,12 +450,6 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr ad=
dr, uint64_t val,
>  #undef CPU_MMU_INDEX
>  #undef MEMSUFFIX
>=20=20
> -/*
> - * Code access is deprecated in favour of translator_ld* functions
> - * (see translator.h). However there are still users that need to
> - * converted so for now these stay.
> - */
> -
>  #define CPU_MMU_INDEX (cpu_mmu_index(env, true))
>  #define MEMSUFFIX _code
>  #define SOFTMMU_CODE_ACCESS
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 459dd72aab..638e1529c5 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -148,41 +148,19 @@ void translator_loop_temp_check(DisasContextBase *d=
b);
>  /*
>   * Translator Load Functions
>   *
> - * These are intended to replace the old cpu_ld*_code functions and
> - * are mandatory for front-ends that have been migrated to the common
> - * translator_loop. These functions are only intended to be called
> - * from the translation stage and should not be called from helper
> - * functions. Those functions should be converted to encode the
> - * relevant information at translation time.
> + * These are intended to replace the direct usage of the cpu_ld*_code
> + * functions and are mandatory for front-ends that have been migrated
> + * to the common translator_loop. These functions are only intended
> + * to be called from the translation stage and should not be called
> + * from helper functions. Those functions should be converted to encode
> + * the relevant information at translation time.
>   */
>=20=20
> -#ifdef CONFIG_USER_ONLY
> -
> -#define DO_LOAD(type, name, shift)               \
> -    do {                                         \
> -        set_helper_retaddr(1);                   \
> -        ret =3D name ## _p(g2h(pc));               \
> -        clear_helper_retaddr();                  \
> -    } while (0)
> -
> -#else
> -
> -#define DO_LOAD(type, name, shift)                          \
> -    do {                                                    \
> -        int mmu_idx =3D cpu_mmu_index(env, true);             \
> -        TCGMemOpIdx oi =3D make_memop_idx(shift, mmu_idx);    \
> -        ret =3D helper_ret_ ## name ## _cmmu(env, pc, oi, 0); \
> -    } while (0)
> -
> -#endif
> -
> -#define GEN_TRANSLATOR_LD(fullname, name, type, shift, swap_fn)         \
> +#define GEN_TRANSLATOR_LD(fullname, type, load_fn, swap_fn)             \
>      static inline type                                                  \
>      fullname ## _swap(CPUArchState *env, abi_ptr pc, bool do_swap)      \
>      {                                                                   \
> -        type ret;                                                       \
> -        DO_LOAD(type, name, shift);                                     \
> -                                                                        \
> +        type ret =3D load_fn(env, pc);                                  =
  \
>          if (do_swap) {                                                  \
>              ret =3D swap_fn(ret);                                       =
  \
>          }                                                               \
> @@ -195,11 +173,11 @@ void translator_loop_temp_check(DisasContextBase *d=
b);
>          return fullname ## _swap(env, pc, false);                       \
>      }
>=20=20
> -GEN_TRANSLATOR_LD(translator_ldub, ldub, uint8_t, 0, /* no swap */ )
> -GEN_TRANSLATOR_LD(translator_ldsw, ldsw, int16_t, 1, bswap16)
> -GEN_TRANSLATOR_LD(translator_lduw, lduw, uint16_t, 1, bswap16)
> -GEN_TRANSLATOR_LD(translator_ldl, ldl, uint32_t, 2, bswap32)
> -GEN_TRANSLATOR_LD(translator_ldq, ldq, uint64_t, 3, bswap64)
> +GEN_TRANSLATOR_LD(translator_ldub, uint8_t, cpu_ldub_code, /* no swap */)
> +GEN_TRANSLATOR_LD(translator_ldsw, int16_t, cpu_ldsw_code, bswap16)
> +GEN_TRANSLATOR_LD(translator_lduw, uint16_t, cpu_lduw_code, bswap16)
> +GEN_TRANSLATOR_LD(translator_ldl, uint32_t, cpu_ldl_code, bswap32)
> +GEN_TRANSLATOR_LD(translator_ldq, uint64_t, cpu_ldq_code, bswap64)
>  #undef GEN_TRANSLATOR_LD
>=20=20
>  #endif  /* EXEC__TRANSLATOR_H */


--=20
Alex Benn=C3=A9e

