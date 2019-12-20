Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3F020716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cag7x7UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3F020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLIg-0003kp-Qf
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:38:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLI0-00036O-KQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiLHz-0006Fk-6p
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:38:08 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiLHy-0006EM-UZ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:38:07 -0500
Received: by mail-wm1-x341.google.com with SMTP id d73so9582841wmd.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=t0fBSy540ALeODUpElbLeHYJvTHsmDRHvmRUMFcCUAo=;
 b=Cag7x7UZoeIXjUoLWxPv7kbuiSY45Hl5UReAhRnW8zrykwgRxQ8PB/0zTKHl2lxJbW
 +MENHtJqp88LLNbJbPMvhtG/trR8WjLzecf2tagycqTqT5ea8DckJvZaCqEYhAMH8HFD
 MucQYlVPHmDdymiz67cQbPWrBjuuoouu1cJs+SnLk0JDyvLxCZ7B/4+80opcrjVD6oQ4
 NACr80swW1s1qFj9VawVO6kTRDPl3nq/n4wuFbuJMRcKd2m9NJhLTy7zE+jGKg3/Tef4
 2ZW5zpQo0TvA+cbz3I8M/6LjI0SBUffWE+S7/mN1+5wzUh3LqT9l1Z9aBsMOU2l9Kyd2
 QA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t0fBSy540ALeODUpElbLeHYJvTHsmDRHvmRUMFcCUAo=;
 b=H9+bR7ZomT0oCCleev33GZlRyyreyHhfh4b/UTThXNCFOxepPVfRRmQuihIbIGajcr
 VSMXNe4iqBmfXNbS2jaWz99T6+KhDSpvdzXOosGioKSWgXUh/HE3gF7OZ3SD7ZliFhzG
 M8KmIrm7mBVs38s5sQOv8CRW9wge3oKd3pdszPEFFRKX6KBkoMkV4gg2naubEryksUhB
 1sARjEx46I9TbkK6mJvIgOyy6dRM6vtI8T2eV7TDtZRPB3MzkEpYF90KBuLz6/QOovxM
 ST/aL4j6kwgwPdMFZVI9Nc4GxodiW7SR5r6ijWZP7GKohmRDPU15ubXD1d4pNKbi//Rp
 +a2Q==
X-Gm-Message-State: APjAAAWTVzXG4s5N6epyhF7dq2JIGAHYT1s2HAVDSLHoxtS1gR7c+mqM
 QZCY39YRyynk2H7Nmh948+mKvi4bsF0=
X-Google-Smtp-Source: APXvYqyALYEGG5FTsW8Zln5U+euUBHLxkxFCS+AgcaO5doLzNMjdrftml0+8AJqOg4fDSF98XrFXYw==
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr16958560wmc.36.1576859884365; 
 Fri, 20 Dec 2019 08:38:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p18sm10661277wmb.8.2019.12.20.08.38.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 08:38:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 382A41FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 16:38:02 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/28] trace: Remove trace_mem_build_info_no_se_[bl]e
In-reply-to: <20191216221158.29572-4-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 16:38:02 +0000
Message-ID: <8736dfdkb9.fsf@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> It is easy for the atomic helpers to use trace_mem_build_info
> directly, without resorting to symbol pasting.  For this usage,
> we cannot use trace_mem_get_info, because the MemOp does not
> support 16-byte accesses.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/atomic_template.h | 67 +++++++++++++------------------------
>  trace/mem-internal.h        | 17 ----------
>  2 files changed, 24 insertions(+), 60 deletions(-)
>
> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index 837676231f..26969487d6 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -64,13 +64,10 @@
>     the ATOMIC_NAME macro, and redefined below.  */
>  #if DATA_SIZE =3D=3D 1
>  # define END
> -# define MEND _be /* either le or be would be fine */
>  #elif defined(HOST_WORDS_BIGENDIAN)
>  # define END  _be
> -# define MEND _be
>  #else
>  # define END  _le
> -# define MEND _le
>  #endif
>=20=20
>  ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
> @@ -79,8 +76,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target=
_ulong addr,
>      ATOMIC_MMU_DECLS;
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
>      DATA_TYPE ret;
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT, fals=
e,
> -                                                           ATOMIC_MMU_ID=
X);
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, false,

What is MEND meant to be? Shouldn't we use the appropriate MO_TE instead
of 0 for these helpers?

> +                                         ATOMIC_MMU_IDX);
>=20=20
>      atomic_trace_rmw_pre(env, addr, info);
>  #if DATA_SIZE =3D=3D 16
> @@ -99,8 +96,8 @@ ABI_TYPE ATOMIC_NAME(ld)(CPUArchState *env, target_ulon=
g addr EXTRA_ARGS)
>  {
>      ATOMIC_MMU_DECLS;
>      DATA_TYPE val, *haddr =3D ATOMIC_MMU_LOOKUP;
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT, fals=
e,
> -                                                           ATOMIC_MMU_ID=
X);
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, false,
> +                                         ATOMIC_MMU_IDX);
>=20=20
>      atomic_trace_ld_pre(env, addr, info);
>      val =3D atomic16_read(haddr);
> @@ -114,8 +111,8 @@ void ATOMIC_NAME(st)(CPUArchState *env, target_ulong =
addr,
>  {
>      ATOMIC_MMU_DECLS;
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT, true,
> -                                                          ATOMIC_MMU_IDX=
);
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, true,
> +                                         ATOMIC_MMU_IDX);
>=20=20
>      atomic_trace_st_pre(env, addr, info);
>      atomic16_set(haddr, val);
> @@ -130,8 +127,8 @@ ABI_TYPE ATOMIC_NAME(xchg)(CPUArchState *env, target_=
ulong addr,
>      ATOMIC_MMU_DECLS;
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
>      DATA_TYPE ret;
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT, fals=
e,
> -                                                          ATOMIC_MMU_IDX=
);
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, false,
> +                                         ATOMIC_MMU_IDX);
>=20=20
>      atomic_trace_rmw_pre(env, addr, info);
>      ret =3D atomic_xchg__nocheck(haddr, val);
> @@ -147,10 +144,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ul=
ong addr,       \
>      ATOMIC_MMU_DECLS;                                               \
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                           \
>      DATA_TYPE ret;                                                  \
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
> -                                                           false,   \
> -                                                           ATOMIC_MMU_ID=
X); \
> -                                                                    \
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, false,    \
> +                                         ATOMIC_MMU_IDX);           \
>      atomic_trace_rmw_pre(env, addr, info);                          \
>      ret =3D atomic_##X(haddr, val);                                   \
>      ATOMIC_MMU_CLEANUP;                                             \
> @@ -183,10 +178,8 @@ ABI_TYPE ATOMIC_NAME(X)(CPUArchState *env, target_ul=
ong addr,       \
>      ATOMIC_MMU_DECLS;                                               \
>      XDATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;                          \
>      XDATA_TYPE cmp, old, new, val =3D xval;                           \
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT,   \
> -                                                           false,   \
> -                                                           ATOMIC_MMU_ID=
X); \
> -                                                                    \
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, 0, false,    \
> +                                         ATOMIC_MMU_IDX);           \
>      atomic_trace_rmw_pre(env, addr, info);                          \
>      smp_mb();                                                       \
>      cmp =3D atomic_read__nocheck(haddr);                              \
> @@ -213,7 +206,6 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, new)
>  #endif /* DATA SIZE >=3D 16 */
>=20=20
>  #undef END
> -#undef MEND
>=20=20
>  #if DATA_SIZE > 1
>=20=20
> @@ -221,10 +213,8 @@ GEN_ATOMIC_HELPER_FN(umax_fetch, MAX,  DATA_TYPE, ne=
w)
>     within the ATOMIC_NAME macro.  */
>  #ifdef HOST_WORDS_BIGENDIAN
>  # define END  _le
> -# define MEND _le
>  #else
>  # define END  _be
> -# define MEND _be
>  #endif
>=20=20
>  ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
> @@ -233,9 +223,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, targ=
et_ulong addr,
>      ATOMIC_MMU_DECLS;
>      DATA_TYPE *haddr =3D ATOMIC_MMU_LOOKUP;
>      DATA_TYPE ret;
> -    uint16_t info =3D glue(trace_mem_build_info_no_se, MEND)(SHIFT,
> -                                                           false,
> -                                                           ATOMIC_MMU_ID=
X);
> +    uint16_t info =3D trace_mem_build_info(SHIFT, false, MO_BSWAP, false,
> +                                         ATOMIC_MMU_IDX);

These are fine with MO_BSWAP. So otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

