Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99928C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648162087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIF1zzJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648162087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXER-0002QJ-Hd
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itXCS-00013j-OI
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itXCR-0004li-Mi
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:34:40 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itXCR-0004l1-GD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:34:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id b6so29632692wrq.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f6PoHpT+qBoTLrZzPTTw3J48M83QjbzTnDqrIfnPzIw=;
 b=MIF1zzJknjSEuE2yAhQkBEyEeR2YVi1+EtmgIJ6puAZZ0bUh6VFj7YHeTvlgemOQpg
 qreQxhVEpmn/A67sqrMeHTzQ89se6czBIF2Gv4U0Bvwapmgh29cNEDDHOJ7lJfOc4XtH
 vUH3E3YP9kioR6bKextFZgFMDSqqhdElghy3J+GwQ6JCOeu/pdmqh4fncF7o3CDMdGNI
 DG1ojhv4JafR+X8+ISrOHc8+cKiWTh7LssA9qGHJVW+wMMiR5eOqgw/axfmpQnA15DwP
 w8V5mgtZjs+p+0mAJUOOW9KzBD5l2Wi+xnAySesAMhD84cpI7ktb+o22cgcZOYy2PFP3
 XbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f6PoHpT+qBoTLrZzPTTw3J48M83QjbzTnDqrIfnPzIw=;
 b=cY2k4bieeZ25bqMXKGE9w2kvzGKZRCsBOgM+jgtwHMQjsRL4elWJYpSm/gL7w9+UJY
 2WK2zIjuJG1Zv4qN03ufzFptSUFSAtBTZGuXFTgaJ0LnM66tIIfhLjuJQTzEWyG8pglY
 L/OahCdUKOW5Yuulg5sIpACKJgbPLnCP4xlhDpuOY7uIGUpU4eM5dQVXXClRIWzJch88
 n9mcwT/LKSoGIPWpv/69fCyFYRLnnX7UZjCwsCbsXWNQdzuIkJJCpLS13NC0xfNInNdE
 dOzJ4qXPLJ6a9X7GJyrSecLIg1Z0s+CzW0tv2pqPQRdDCDftWWH6SiAUEjDzna1qe8MN
 oTBg==
X-Gm-Message-State: APjAAAUm4i/PTmwMnEBwpDDvg1QVvK2y6rNU/MlnwKgK3KAW9H5PWaML
 Gc/kcXaeYwnh/xOtZB8O6slxWlfset0=
X-Google-Smtp-Source: APXvYqzmUih5zqoVpBN+4EMGcd9SH6UbG6Hi/ddaI+SwL8tSGuji1flVgt2DJdzgIL4NTvRGqsvCOQ==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr17970955wrt.366.1579527278290; 
 Mon, 20 Jan 2020 05:34:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w83sm22622966wmb.42.2020.01.20.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:34:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F32961FF87;
 Mon, 20 Jan 2020 13:34:35 +0000 (GMT)
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/9] cputlb: Make tlb_n_entries private to cputlb.c
In-reply-to: <20200109024907.2730-3-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 13:34:35 +0000
Message-ID: <87muai2qvo.fsf@linaro.org>
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
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There are no users of this function outside cputlb.c,
> and its interface will change in the next patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/cpu_ldst.h | 5 -----
>  accel/tcg/cputlb.c      | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index a46116167c..53de19753a 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -234,11 +234,6 @@ static inline uintptr_t tlb_index(CPUArchState *env,=
 uintptr_t mmu_idx,
>      return (addr >> TARGET_PAGE_BITS) & size_mask;
>  }
>=20=20
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> -{
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> -}
> -
>  /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
>  static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_id=
x,
>                                       target_ulong addr)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 1a81886e58..e4a8ed9534 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,6 +80,11 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on=
_cpu_data));
>  QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>  #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>=20=20
> +static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +{
> +    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +}
> +
>  static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
>  {
>      return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);


--=20
Alex Benn=C3=A9e

