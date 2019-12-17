Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB24FC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF812072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCGZOck3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF812072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih42M-0000yt-Kg
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:00:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ih41e-0000Tp-Ml
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ih41c-0003c1-JU
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:59:57 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33136
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ih41c-0003Zg-Fs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 22:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576555195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwWppAKOfNTFEnnvfZjvsN9MoW5LxNTi05dy1t1kYlA=;
 b=JCGZOck38zyuIA2CuWgZ4oebl1sC4O0UkvdXmpi5iQ3atoQVc7oB817wXDO8dTzUEUmyBp
 GG45RVSomqLGz4knMcT0liv7IngYjflb+vaybzKfcDWLWGBOEIKzfJXZ8QuQFzfQQAi90U
 J66wqhJHEXpoOlspZ9JlcT13YPEqymk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-fvXZHvftN7uj_iVwACZGdw-1; Mon, 16 Dec 2019 22:59:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so4798351wrw.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 19:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BsFlRQA2laQDHLWT9QV2tGDbvSRJB0QSQfKAchW2ajQ=;
 b=n7CeoumnGNQSeklDdnlsyxBUqRU9ThBGIfucFU2UnbjheUoVXHeThKdL0cpb1A7SuN
 Vd4nwHustdPqeddPwWkydvI2cneIVtBbm8785aAOxwFh9hkPqkzn0SGq5qV3V4X/9KF0
 gAGT0ebItJH/1+tc6Ph+4+O7zP1FT8j0T8u322kEq0LzJFWo0RwRk+AxMknznhVfhLRt
 dWIrExuRkuHJ69/JbSTgq8wqdYLVcdAcYm3bTqiZXLOcYnjyen/17jVYb2IY7zXSv0yB
 F7V8hF/kpvVWqRedZo8gYvyIuorQlMP3EXXRFeEfjwse0/CxHuQCsDwhvO6c8pTh3/mI
 cPEw==
X-Gm-Message-State: APjAAAWMkICtjjzhXFs6SiVCn7CCMGQkzUuFIljHPsR2Ic1adZQUc1/k
 IKI5W0Fndd2QxYoMgNM9L/reZzdlFaQQaQTEFhlrwRNKtrvwG0k9KQwVp3uJpF0TR6R7Ek9ETUW
 DE0+yae55Ppm1+h4=
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr33150406wro.209.1576555191488; 
 Mon, 16 Dec 2019 19:59:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyo8sU9qyaPSpLDK498Q5j2i5mN4axHXC/ipNaVG9g5Ug0KHLXWxTRZuVbDPEyxDUWc6y3s8A==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr33150379wro.209.1576555191101; 
 Mon, 16 Dec 2019 19:59:51 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c68sm1498429wme.13.2019.12.16.19.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 19:59:50 -0800 (PST)
Subject: Re: [PATCH v2 02/28] cputlb: Use trace_mem_get_info instead of
 trace_mem_build_info
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf26dd5a-b507-a357-258d-dbb53230614c@redhat.com>
Date: Tue, 17 Dec 2019 04:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216221158.29572-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: fvXZHvftN7uj_iVwACZGdw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/16/19 11:11 PM, Richard Henderson wrote:
> In the cpu_ldst templates, we already require a MemOp, and it
> is cleaner and clearer to pass that instead of 3 separate
> arguments describing the memory operation.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu_ldst_template.h          | 22 +++++++++++-----------
>   include/exec/cpu_ldst_useronly_template.h | 12 ++++++------
>   2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_tem=
plate.h
> index 54b5e858ce..0ad5de3ef9 100644
> --- a/include/exec/cpu_ldst_template.h
> +++ b/include/exec/cpu_ldst_template.h
> @@ -86,9 +86,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>       RES_TYPE res;
>       target_ulong addr;
>       int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> +    MemOp op =3D MO_TE | SHIFT;
>   #if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false=
, mmu_idx);
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>   #endif
>  =20
> @@ -96,9 +96,9 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUAr=
chState *env,
>       entry =3D tlb_entry(env, mmu_idx, addr);
>       if (unlikely(entry->ADDR_READ !=3D
>                    (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>           res =3D glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, a=
ddr,
> -                                                            oi, retaddr)=
;
> +                                                               oi, retad=
dr);
>       } else {
>           uintptr_t hostaddr =3D addr + entry->addend;
>           res =3D glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
> @@ -125,9 +125,9 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>       int res;
>       target_ulong addr;
>       int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> -#if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, false,=
 mmu_idx);
> +    MemOp op =3D MO_TE | MO_SIGN | SHIFT;

Good, the sign-extend is easier to review this way (than 'true').

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +#ifndef SOFTMMU_CODE_ACCESS
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, false);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>   #endif
>  =20
> @@ -135,7 +135,7 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPU=
ArchState *env,
>       entry =3D tlb_entry(env, mmu_idx, addr);
>       if (unlikely(entry->ADDR_READ !=3D
>                    (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op & ~MO_SIGN, mmu_idx);
>           res =3D (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
>                                  MMUSUFFIX)(env, addr, oi, retaddr);
>       } else {
> @@ -167,9 +167,9 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>       CPUTLBEntry *entry;
>       target_ulong addr;
>       int mmu_idx =3D CPU_MMU_INDEX;
> -    TCGMemOpIdx oi;
> +    MemOp op =3D MO_TE | SHIFT;
>   #if !defined(SOFTMMU_CODE_ACCESS)
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true,=
 mmu_idx);
> +    uint16_t meminfo =3D trace_mem_get_info(op, mmu_idx, true);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>   #endif
>  =20
> @@ -177,7 +177,7 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUA=
rchState *env,
>       entry =3D tlb_entry(env, mmu_idx, addr);
>       if (unlikely(tlb_addr_write(entry) !=3D
>                    (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
> -        oi =3D make_memop_idx(SHIFT, mmu_idx);
> +        TCGMemOpIdx oi =3D make_memop_idx(op, mmu_idx);
>           glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
>                                                        retaddr);
>       } else {
> diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu=
_ldst_useronly_template.h
> index dbdc7a845d..e5a3d1983a 100644
> --- a/include/exec/cpu_ldst_useronly_template.h
> +++ b/include/exec/cpu_ldst_useronly_template.h
> @@ -70,8 +70,8 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *en=
v, abi_ptr ptr)
>       ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
>       clear_helper_retaddr();
>   #else
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, false=
,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, false);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>       ret =3D glue(glue(ld, USUFFIX), _p)(g2h(ptr));
>   #endif
> @@ -102,8 +102,8 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *=
env, abi_ptr ptr)
>       ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
>       clear_helper_retaddr();
>   #else
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, true, MO_TE, false,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | MO_SIGN | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, false);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>       ret =3D glue(glue(lds, SUFFIX), _p)(g2h(ptr));
>       qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
> @@ -131,8 +131,8 @@ static inline void
>   glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
>                                         RES_TYPE v)
>   {
> -    uint16_t meminfo =3D trace_mem_build_info(SHIFT, false, MO_TE, true,
> -                                            MMU_USER_IDX);
> +    MemOp op =3D MO_TE | SHIFT;
> +    uint16_t meminfo =3D trace_mem_get_info(op, MMU_USER_IDX, true);
>       trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
>       glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
>       qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
>=20


