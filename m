Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AF32072B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqThJcWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AF32072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiOLp-0000jE-Lm
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiOKR-00084W-5V
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiOKP-0002Rm-Dv
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37347)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiOKN-0002O2-I8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:52:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so10414422wmf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=E1PN6cQWeXRZc3l6I7VZSJvD0NGLRFurgjcc3a1V/3Q=;
 b=JqThJcWkem3LAegx0eCnSjy/1hjviAKjdxD1wIcsLdKN6wmZhOSfoMSV9VB7Kcg4AY
 EpEzgVCDgUlL3mWrJv1uYcKmUtZKHS9Hcjql+jg2X/ldcJBKgOILccKVX7o2/AnixFXV
 zROmS4yj/sDJK44XGhgow1PLq6zGVUwB6abAQc2Jl7mDSmo5GyREhLAp2/4s3+Y9wPME
 N/Z+bYQiNYcHrKcFcoxiHn06LS757I8Dbfeezrx93WzhciodTxFeLvMMrbrBZbxs50YY
 Pn+sgBMPEW31y1reyPz6ehVoKK7RII+NCKTHj1AUQ4mo7VyKte1ml2ahOMxpBbWegzxt
 M7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=E1PN6cQWeXRZc3l6I7VZSJvD0NGLRFurgjcc3a1V/3Q=;
 b=s7LXQdBVKiSj6wGEGP/zPokLS88Dkh3fGVZg+3N/Zsxcfa5tlrBPzMtAZJ4Zkxzqzx
 IirG2lDsQYmKMDzbT/1mvi5173tgkIPesymFRWyFXijb69w4gUoEbh5BoGH6YuVAVNBE
 4xL9P0dc4gS/zUurJU8zlUtOgx7AV6EsNiG+AAItc5A+dEe5u4Rti92sFJw21jwfDho/
 q0RMcG5SF+O2mKZsRi++os1HFVDdf7ugl892cEy/+lWWx85zTv5Gb28BgKTgby3gXcB6
 LBrcA7mDmQw+OgaOfCA45uz/TZdCIYlZWhRsgU5nD/t7PviEAC70Is3qfv8oWBadIXx8
 6J8A==
X-Gm-Message-State: APjAAAVGcbpIAwUdwHeKdrY7TLxmHz4KmTTpZkDJtIkIoVfFAUSqwpFo
 0gEPBEfUaTikhWequxg0REeG31wFbJk=
X-Google-Smtp-Source: APXvYqw/oVDjAzfKrPdjFdN7oWVVYPzC4sTTxcgZArhiGoEQiqH5WrpQ2SsEEZyRe1kV2i1L1ZdP4A==
X-Received: by 2002:a1c:28d4:: with SMTP id
 o203mr18150433wmo.123.1576871562527; 
 Fri, 20 Dec 2019 11:52:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f16sm10948867wrm.65.2019.12.20.11.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:52:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D92241FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 19:52:40 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-28-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 27/28] cputlb: Remove support for MMU_MODE*_SUFFIX
In-reply-to: <20191216221158.29572-28-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:52:40 +0000
Message-ID: <8736debwqf.fsf@linaro.org>
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

> All users have now been converted to cpu_*_mmuidx_ra.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst.h | 230 ----------------------------------------
>  1 file changed, 230 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 0f3c49a005..cf4652bf48 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -271,236 +271,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr a=
ddr, uint32_t val,
>  void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
>                         int mmu_idx, uintptr_t retaddr);
>=20=20
> -#ifdef MMU_MODE0_SUFFIX
> -#define CPU_MMU_INDEX 0
> -#define MEMSUFFIX MMU_MODE0_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif
> -
> -#if (NB_MMU_MODES >=3D 2) && defined(MMU_MODE1_SUFFIX)
> -#define CPU_MMU_INDEX 1
> -#define MEMSUFFIX MMU_MODE1_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif
> -
> -#if (NB_MMU_MODES >=3D 3) && defined(MMU_MODE2_SUFFIX)
> -
> -#define CPU_MMU_INDEX 2
> -#define MEMSUFFIX MMU_MODE2_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 3) */
> -
> -#if (NB_MMU_MODES >=3D 4) && defined(MMU_MODE3_SUFFIX)
> -
> -#define CPU_MMU_INDEX 3
> -#define MEMSUFFIX MMU_MODE3_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 4) */
> -
> -#if (NB_MMU_MODES >=3D 5) && defined(MMU_MODE4_SUFFIX)
> -
> -#define CPU_MMU_INDEX 4
> -#define MEMSUFFIX MMU_MODE4_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 5) */
> -
> -#if (NB_MMU_MODES >=3D 6) && defined(MMU_MODE5_SUFFIX)
> -
> -#define CPU_MMU_INDEX 5
> -#define MEMSUFFIX MMU_MODE5_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 6) */
> -
> -#if (NB_MMU_MODES >=3D 7) && defined(MMU_MODE6_SUFFIX)
> -
> -#define CPU_MMU_INDEX 6
> -#define MEMSUFFIX MMU_MODE6_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 7) */
> -
> -#if (NB_MMU_MODES >=3D 8) && defined(MMU_MODE7_SUFFIX)
> -
> -#define CPU_MMU_INDEX 7
> -#define MEMSUFFIX MMU_MODE7_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 8) */
> -
> -#if (NB_MMU_MODES >=3D 9) && defined(MMU_MODE8_SUFFIX)
> -
> -#define CPU_MMU_INDEX 8
> -#define MEMSUFFIX MMU_MODE8_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 9) */
> -
> -#if (NB_MMU_MODES >=3D 10) && defined(MMU_MODE9_SUFFIX)
> -
> -#define CPU_MMU_INDEX 9
> -#define MEMSUFFIX MMU_MODE9_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 10) */
> -
> -#if (NB_MMU_MODES >=3D 11) && defined(MMU_MODE10_SUFFIX)
> -
> -#define CPU_MMU_INDEX 10
> -#define MEMSUFFIX MMU_MODE10_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 11) */
> -
> -#if (NB_MMU_MODES >=3D 12) && defined(MMU_MODE11_SUFFIX)
> -
> -#define CPU_MMU_INDEX 11
> -#define MEMSUFFIX MMU_MODE11_SUFFIX
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif /* (NB_MMU_MODES >=3D 12) */
> -
> -#if (NB_MMU_MODES > 12)
> -#error "NB_MMU_MODES > 12 is not supported for now"
> -#endif /* (NB_MMU_MODES > 12) */
> -
>  /* these access are slower, they must be as rare as possible */
>  #define CPU_MMU_INDEX (cpu_mmu_index(env, false))
>  #define MEMSUFFIX _data


--=20
Alex Benn=C3=A9e

