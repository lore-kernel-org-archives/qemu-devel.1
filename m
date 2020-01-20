Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941EC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450CA2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSW0BDFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450CA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSpt-0002lL-Eq
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSp2-0001ry-9c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSox-0003Uu-Ki
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:54:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSox-0003Ub-H7
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579510447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcUWlkCWYm+B82kQolu+iBZJUsgNWRNpBXbgzj6/bU8=;
 b=aSW0BDFkBWgPoQ/22Ep0B43X1MYin7tDsRlNKnuy7cLfkj5UqW+s4W3NuGNp3EJ04yjptf
 Um6ZrpUai5JQ0YwjYXIJDCN2QhvcJfjiQfaW0SWN1OOrdCNclm3SykhyVMxU/nrDktH6x6
 kmSmvBE2kb0yb96cWwswTYUogT0Vqmc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WF9ohW9xPba2dJQ0Y6KmGw-1; Mon, 20 Jan 2020 03:54:05 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so1921664wmf.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H+3J/mgNK3IYuTMG4fMJ6P2u/JF4NAUCxQkk+bVNuf0=;
 b=cqgbOo8ZZzWi4GP+X4YUcou5J1QDya156C+58ItatuStPSJooRoP1Em1c7XRHwf1/m
 ELL+Rfny+KHG6I6dKyaODx8YI9ZpMrBOERA/PMfBJOgxNGJW+VJe6mXeZFCAXHmrf1HC
 V3x9970AHyiNrAbhs4/vR5sCHeQEtEdq6fNVACIAkiPHa2bdkN7ulTxULUH8/+n4Xm0f
 4NJVj8+VfmzE6n/ChGx5BhztIQiIEavxnpSzABA1ZhlypW2/6iX0ergsqJMcPqRpUHbL
 HOmKXgJ9BLAqMjDBsUq7iVaOWTiOYJIQ24W97zAIwTrqepVeMFoDtWISPfwr8dHMS8R1
 BBng==
X-Gm-Message-State: APjAAAX56wCcizec4ZYtuR1EnBuNrFKcVQ2PcFCuIm6GFlkFJa3br7a6
 qsci4aaWtzGTowb2FrMGg3uXoLL5bL5x42UCJkoz6+rqkGoA/BQrcESb49/bVnfzhqU4F9udU3W
 46Kb5EHfdCZiYqhc=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr18721120wme.177.1579510444102; 
 Mon, 20 Jan 2020 00:54:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQhO3HXE7WNAW0CoPnucpohZzox6lU+qBisu6SJ7XS9OlN4o2dXyAvnZdbDN0Hmw1nfRUiIg==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr18721103wme.177.1579510443773; 
 Mon, 20 Jan 2020 00:54:03 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u16sm3299442wmj.41.2020.01.20.00.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:54:03 -0800 (PST)
Subject: Re: [PATCH 3/9] cputlb: Pass CPUTLBDescFast to tlb_n_entries and
 sizeof_tlb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6fa80ff7-85cd-cc11-c1ca-654b2dc5d2cc@redhat.com>
Date: Mon, 20 Jan 2020 09:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109024907.2730-4-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: WF9ohW9xPba2dJQ0Y6KmGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 3:49 AM, Richard Henderson wrote:
> We do not need the entire CPUArchState to compute these values.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   accel/tcg/cputlb.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e4a8ed9534..49c605b6d8 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,14 +80,14 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_o=
n_cpu_data));
>   QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>   #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>  =20
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
>   {
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +    return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
>   }
>  =20
> -static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
> +static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
>   {
> -    return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
> +    return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
>   }
>  =20
>   static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
> @@ -156,7 +156,7 @@ static void tlb_dyn_init(CPUArchState *env)
>   static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>   {
>       CPUTLBDesc *desc =3D &env_tlb(env)->d[mmu_idx];
> -    size_t old_size =3D tlb_n_entries(env, mmu_idx);
> +    size_t old_size =3D tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>       size_t rate;
>       size_t new_size =3D old_size;
>       int64_t now =3D get_clock_realtime();
> @@ -236,7 +236,8 @@ static void tlb_flush_one_mmuidx_locked(CPUArchState =
*env, int mmu_idx)
>       env_tlb(env)->d[mmu_idx].large_page_addr =3D -1;
>       env_tlb(env)->d[mmu_idx].large_page_mask =3D -1;
>       env_tlb(env)->d[mmu_idx].vindex =3D 0;
> -    memset(env_tlb(env)->f[mmu_idx].table, -1, sizeof_tlb(env, mmu_idx))=
;
> +    memset(env_tlb(env)->f[mmu_idx].table, -1,
> +           sizeof_tlb(&env_tlb(env)->f[mmu_idx]));
>       memset(env_tlb(env)->d[mmu_idx].vtable, -1,
>              sizeof(env_tlb(env)->d[0].vtable));
>   }
> @@ -622,7 +623,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1=
, ram_addr_t length)
>       qemu_spin_lock(&env_tlb(env)->c.lock);
>       for (mmu_idx =3D 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
>           unsigned int i;
> -        unsigned int n =3D tlb_n_entries(env, mmu_idx);
> +        unsigned int n =3D tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
>  =20
>           for (i =3D 0; i < n; i++) {
>               tlb_reset_dirty_range_locked(&env_tlb(env)->f[mmu_idx].tabl=
e[i],
>=20


