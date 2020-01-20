Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E738A2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 13:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIc5fBei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E738A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXF6-0003JA-4E
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itXEG-0002Xg-55
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itXEF-00062a-1j
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:36:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itXEE-00061u-Qw
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:36:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id w15so29655469wru.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 05:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vRN84Jl9tbGUzXGqo6qoYhjzT52eSeIsYUJQ8egx89M=;
 b=vIc5fBeigYnSQXMaM62U86xD6mCdIXo2omJKvUCv6W6JnC17/HREKPyyT+EF8K1xBh
 arKEk8BqPCQ768iBf+zqJsGv0zaG3kUob1mFeTRD8+bRLoPs2Et0DWLC7cRWGg4khiIp
 tSAHaQi8hcCMUkwbRZduyE81TacL8gQ5jiuorkD92zPjzSE7cHRzSzzzh9YiGcPStOTG
 zEbXxRfF/v5ULFcAz3sjBlDLI8iXGC1o3wtL61eoBsVdQEsyGgjBc8hEf/cv0+C0hUWv
 w6V5MDnueN814qvPuiXVdKbHrGxR33agrhlIIUUwzFbDObWw92/lccmd5rrRmAPJXGrF
 PlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vRN84Jl9tbGUzXGqo6qoYhjzT52eSeIsYUJQ8egx89M=;
 b=kkyDYniEdh/1PAJWqhbdm1TxR3G6QClcpA3qDKQ/TOjWZz9hxc09yXviyh/XtFhXyH
 SRq+7SvsDM+XKUdUx3zDsqWJWRoahEZ/C6e8Qea147UyMhWXkFH6T8sEndQVs53vFY7A
 boOBPDIm7v+Sdcg4gOdPNH9t5cnpaPXSgQ8CQJtN1J3SU7rYFflEaczAAZb8rkWo+rir
 NHUWVOTBxMAgl+1hdDGch/GzXmcPMDCkswisuwHYLjSm3SnsGMEKmDTVOC19Lk38cF1+
 FVjpkSvDcUKxpPldkQ+G+3ZE9MbYAe7HCriZJNjrXtD8SkpyzWaYmCatAwsDnyhGIY5u
 ikXQ==
X-Gm-Message-State: APjAAAWkcG5zFjG5F2+vTjsY+ZfRpS8aHKI8oHQwmwCAC8X35ETryBka
 6OtLulDU8mHYPffUaJW9f5CmqYm+LLM=
X-Google-Smtp-Source: APXvYqyxRIlVnlGDICNVWpS6LjrUxmIYhUAvWICQEaA709w/d0YHe7GDgiegQh6UJi39LYeEZ+4dkw==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr18183636wrm.402.1579527389602; 
 Mon, 20 Jan 2020 05:36:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v14sm47272269wrm.28.2020.01.20.05.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 05:36:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 850711FF87;
 Mon, 20 Jan 2020 13:36:27 +0000 (GMT)
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-4-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/9] cputlb: Pass CPUTLBDescFast to tlb_n_entries and
 sizeof_tlb
In-reply-to: <20200109024907.2730-4-richard.henderson@linaro.org>
Date: Mon, 20 Jan 2020 13:36:27 +0000
Message-ID: <87k15m2qsk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

> We do not need the entire CPUArchState to compute these values.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/cputlb.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e4a8ed9534..49c605b6d8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,14 +80,14 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_o=
n_cpu_data));
>  QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>  #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>=20=20
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
>  {
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +    return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
>  }
>=20=20
> -static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
>  {
> -    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
> +    return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
>  }
>=20=20
>  static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
> @@ -156,7 +156,7 @@ static void tlb_dyn_init(CPUArchState *env)
>  static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>  {
>      CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
> -    size_t old_size =3D tlb_n_entries(env, mmu_idx);
> +    size_t old_size =3D tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>      size_t rate;
>      size_t new_size =3D old_size;
>      int64_t now =3D get_clock_realtime();
> @@ -236,7 +236,8 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState =
*env, int mmu_idx)
>      env_tlb(env)->d[mmu_idx].large_page_addr =3D -1;
>      env_tlb(env)->d[mmu_idx].large_page_mask =3D -1;
>      env_tlb(env)->d[mmu_idx].vindex =3D 0;
> -    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx));
> +    memset(env_tlb(env)->f[mmu_idx].table, -1,
> +           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
>      memset(env_tlb(env)->d[mmu_idx].vtable, -1,
>             sizeof(env_tlb(env)->d[0].vtable));
>  }
> @@ -622,7 +623,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1=
, ram_addr_t length)
>      qemu_spin_lock(&env_tlb(env)->c.lock);
>      for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>          unsigned int i;
> -        unsigned int n =3D tlb_n_entries(env, mmu_idx);
> +        unsigned int n =3D tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>=20=20
>          for (i =3D 0; i < n; i++) {
>              tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].table=
[i],


--=20
Alex Benn=C3=A9e

