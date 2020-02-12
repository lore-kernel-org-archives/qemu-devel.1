Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477FCC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06AC206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP1x651M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06AC206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lJ8-0003K4-2j
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:15:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1lII-0002Ty-8N
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1lIF-0007pv-Hi
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:14:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1lIF-0007pa-CW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581488078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tALMYiBvct199cchxKean5Lb2l0kAMjB6HqdcL83mc=;
 b=JP1x651MLCYKTlU0HVYqeukLEXxYWHs7ifkKVy8DWcFN9irqe2KUaljR/d867Z4m5dVz3/
 Gzsm/o1Aoxe5h6k02HZSi5Z6DVM3D+o23+JWAinubvs5lK8cVs64NEp/B2P8SoEYak29kv
 ih31E10ueDbqk5kPNBvFUCIwLVNSW/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-D7c_3Wl_MxScj7QYmy83zA-1; Wed, 12 Feb 2020 01:14:36 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so522398wma.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 22:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4tALMYiBvct199cchxKean5Lb2l0kAMjB6HqdcL83mc=;
 b=Mw+y1zSHuuwlp8hqVBhGQEG20Z8m59y7cBnkmyz5h3vhqYGrheq6DiDMuM6OVLCQR6
 5O7aK/KCm3hqvKAYDgcjHJHALav5KRPzHbkdazmObBOfcOXuxHOBk7wPbtzeNQGdV9fY
 J1Mmwj2sG8RH31aIx7zvZSzr5bXLHyvj5PVIT+Eh2NcvyUCzOk7qD5dvL5Kizlyf62Uo
 2z9aluDLEegVBJ0UThvhVOpfL9h9T3gEe+VYuM+2ZgNC2/z4Vq3YeP3XAhRB05KZlN51
 IQYZhTXjHiuDpce8fuBS8T60VBoSOGCJYQypOHNiUmhy4LyyYtd1leKV4Nrv2eY7lKvN
 +LwQ==
X-Gm-Message-State: APjAAAX9ZqamCq1HpxwmTZ7Ct/SR4P1Hu+05dp9JN9heuFliRlCCDUR6
 rsonRYMVMGVkFYCcW0JmJmR6LQf4pqXtc0RZh3OpRxLu67CbBV0zcGwoBH3mlnKvuOlf1wVE7DL
 8GWkxYZwvvNefs0U=
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr11089045wmf.189.1581488075559; 
 Tue, 11 Feb 2020 22:14:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzR3LBZYFdYyRMwkVq6+L3SoW82PW046YO+uc6kia4EhvaR4Zt2YZOHx8z6Ucg02y4puouuIA==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr11088985wmf.189.1581488074928; 
 Tue, 11 Feb 2020 22:14:34 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c13sm8336846wrn.46.2020.02.11.22.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 22:14:34 -0800 (PST)
Subject: Re: [PATCH 2/2] target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200212025145.24300-1-richard.henderson@linaro.org>
 <20200212025145.24300-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc402827-e966-18b9-2d29-3ec4902fae63@redhat.com>
Date: Wed, 12 Feb 2020 07:14:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212025145.24300-3-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: D7c_3Wl_MxScj7QYmy83zA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, tsimpson@quicinc.com, alex.bennee@linaro.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 3:51 AM, Richard Henderson wrote:
> Now that we can pass 7 parameters, do not encode register
> operands within simd_data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper-sve.h    |  45 +++++++----
>   target/arm/sve_helper.c    | 157 ++++++++++++++-----------------------
>   target/arm/translate-sve.c |  68 ++++++----------
>   3 files changed, 114 insertions(+), 156 deletions(-)
> 
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 9e79182ab4..bd8b91bdb6 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -1099,25 +1099,40 @@ DEF_HELPER_FLAGS_6(sve_fcadd_s, TCG_CALL_NO_RWG,
>   DEF_HELPER_FLAGS_6(sve_fcadd_d, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fmls_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fnmls_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>   
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG, void, env, ptr, i32)
> -DEF_HELPER_FLAGS_3(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG, void, env, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_h, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_7(sve_fcmla_zpzzz_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, ptr, ptr, i32)
>   
>   DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>   DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index fdfa652094..33b5a54a47 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -3372,23 +3372,11 @@ DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_float64)
>   
>   #undef DO_ZPZ_FP
>   
> -/* 4-operand predicated multiply-add.  This requires 7 operands to pass
> - * "properly", so we need to encode some of the registers into DESC.
> - */
> -QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 20 > 32);
> -
> -static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
> +                            float_status *status, uint32_t desc,
>                               uint16_t neg1, uint16_t neg3)
>   {
>       intptr_t i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       do {
> @@ -3401,45 +3389,42 @@ static void do_fmla_zpzzz_h(CPUARMState *env, void *vg, uint32_t desc,
>                   e1 = *(uint16_t *)(vn + H1_2(i)) ^ neg1;
>                   e2 = *(uint16_t *)(vm + H1_2(i));
>                   e3 = *(uint16_t *)(va + H1_2(i)) ^ neg3;
> -                r = float16_muladd(e1, e2, e3, 0, &env->vfp.fp_status_f16);
> +                r = float16_muladd(e1, e2, e3, 0, status);
>                   *(uint16_t *)(vd + H1_2(i)) = r;
>               }
>           } while (i & 63);
>       } while (i != 0);
>   }
>   
> -void HELPER(sve_fmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_h(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0);
>   }
>   
> -void HELPER(sve_fmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0);
>   }
>   
> -void HELPER(sve_fnmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_h(env, vg, desc, 0x8000, 0x8000);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0x8000, 0x8000);
>   }
>   
> -void HELPER(sve_fnmls_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmls_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_h(env, vg, desc, 0, 0x8000);
> +    do_fmla_zpzzz_h(vd, vn, vm, va, vg, status, desc, 0, 0x8000);
>   }
>   
> -static void do_fmla_zpzzz_s(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_s(void *vd, void *vn, void *vm, void *va, void *vg,
> +                            float_status *status, uint32_t desc,
>                               uint32_t neg1, uint32_t neg3)
>   {
>       intptr_t i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       do {
> @@ -3452,45 +3437,42 @@ static void do_fmla_zpzzz_s(CPUARMState *env, void *vg, uint32_t desc,
>                   e1 = *(uint32_t *)(vn + H1_4(i)) ^ neg1;
>                   e2 = *(uint32_t *)(vm + H1_4(i));
>                   e3 = *(uint32_t *)(va + H1_4(i)) ^ neg3;
> -                r = float32_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                r = float32_muladd(e1, e2, e3, 0, status);
>                   *(uint32_t *)(vd + H1_4(i)) = r;
>               }
>           } while (i & 63);
>       } while (i != 0);
>   }
>   
> -void HELPER(sve_fmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_s(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0);
>   }
>   
> -void HELPER(sve_fmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0);
>   }
>   
> -void HELPER(sve_fnmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_s(env, vg, desc, 0x80000000, 0x80000000);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0x80000000, 0x80000000);
>   }
>   
> -void HELPER(sve_fnmls_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmls_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_s(env, vg, desc, 0, 0x80000000);
> +    do_fmla_zpzzz_s(vd, vn, vm, va, vg, status, desc, 0, 0x80000000);
>   }
>   
> -static void do_fmla_zpzzz_d(CPUARMState *env, void *vg, uint32_t desc,
> +static void do_fmla_zpzzz_d(void *vd, void *vn, void *vm, void *va, void *vg,
> +                            float_status *status, uint32_t desc,
>                               uint64_t neg1, uint64_t neg3)
>   {
>       intptr_t i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       do {
> @@ -3503,31 +3485,35 @@ static void do_fmla_zpzzz_d(CPUARMState *env, void *vg, uint32_t desc,
>                   e1 = *(uint64_t *)(vn + i) ^ neg1;
>                   e2 = *(uint64_t *)(vm + i);
>                   e3 = *(uint64_t *)(va + i) ^ neg3;
> -                r = float64_muladd(e1, e2, e3, 0, &env->vfp.fp_status);
> +                r = float64_muladd(e1, e2, e3, 0, status);
>                   *(uint64_t *)(vd + i) = r;
>               }
>           } while (i & 63);
>       } while (i != 0);
>   }
>   
> -void HELPER(sve_fmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_d(env, vg, desc, 0, 0);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, 0);
>   }
>   
> -void HELPER(sve_fmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                              void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, 0);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, 0);
>   }
>   
> -void HELPER(sve_fnmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_d(env, vg, desc, INT64_MIN, INT64_MIN);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, INT64_MIN, INT64_MIN);
>   }
>   
> -void HELPER(sve_fnmls_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fnmls_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
> -    do_fmla_zpzzz_d(env, vg, desc, 0, INT64_MIN);
> +    do_fmla_zpzzz_d(vd, vn, vm, va, vg, status, desc, 0, INT64_MIN);
>   }
>   
>   /* Two operand floating-point comparison controlled by a predicate.
> @@ -3809,22 +3795,13 @@ void HELPER(sve_fcadd_d)(void *vd, void *vn, void *vm, void *vg,
>    * FP Complex Multiply
>    */
>   
> -QEMU_BUILD_BUG_ON(SIMD_DATA_SHIFT + 22 > 32);
> -
> -void HELPER(sve_fcmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fcmla_zpzzz_h)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
>       intptr_t j, i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot = simd_data(desc);
>       bool flip = rot & 1;
>       float16 neg_imag, neg_real;
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       neg_imag = float16_set_sign(0, (rot & 2) != 0);
> @@ -3851,32 +3828,25 @@ void HELPER(sve_fcmla_zpzzz_h)(CPUARMState *env, void *vg, uint32_t desc)
>   
>               if (likely((pg >> (i & 63)) & 1)) {
>                   d = *(float16 *)(va + H1_2(i));
> -                d = float16_muladd(e2, e1, d, 0, &env->vfp.fp_status_f16);
> +                d = float16_muladd(e2, e1, d, 0, status);
>                   *(float16 *)(vd + H1_2(i)) = d;
>               }
>               if (likely((pg >> (j & 63)) & 1)) {
>                   d = *(float16 *)(va + H1_2(j));
> -                d = float16_muladd(e4, e3, d, 0, &env->vfp.fp_status_f16);
> +                d = float16_muladd(e4, e3, d, 0, status);
>                   *(float16 *)(vd + H1_2(j)) = d;
>               }
>           } while (i & 63);
>       } while (i != 0);
>   }
>   
> -void HELPER(sve_fcmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fcmla_zpzzz_s)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
>       intptr_t j, i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot = simd_data(desc);
>       bool flip = rot & 1;
>       float32 neg_imag, neg_real;
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       neg_imag = float32_set_sign(0, (rot & 2) != 0);
> @@ -3903,32 +3873,25 @@ void HELPER(sve_fcmla_zpzzz_s)(CPUARMState *env, void *vg, uint32_t desc)
>   
>               if (likely((pg >> (i & 63)) & 1)) {
>                   d = *(float32 *)(va + H1_2(i));
> -                d = float32_muladd(e2, e1, d, 0, &env->vfp.fp_status);
> +                d = float32_muladd(e2, e1, d, 0, status);
>                   *(float32 *)(vd + H1_2(i)) = d;
>               }
>               if (likely((pg >> (j & 63)) & 1)) {
>                   d = *(float32 *)(va + H1_2(j));
> -                d = float32_muladd(e4, e3, d, 0, &env->vfp.fp_status);
> +                d = float32_muladd(e4, e3, d, 0, status);
>                   *(float32 *)(vd + H1_2(j)) = d;
>               }
>           } while (i & 63);
>       } while (i != 0);
>   }
>   
> -void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
> +void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
> +                               void *vg, void *status, uint32_t desc)
>   {
>       intptr_t j, i = simd_oprsz(desc);
> -    unsigned rd = extract32(desc, SIMD_DATA_SHIFT, 5);
> -    unsigned rn = extract32(desc, SIMD_DATA_SHIFT + 5, 5);
> -    unsigned rm = extract32(desc, SIMD_DATA_SHIFT + 10, 5);
> -    unsigned ra = extract32(desc, SIMD_DATA_SHIFT + 15, 5);
> -    unsigned rot = extract32(desc, SIMD_DATA_SHIFT + 20, 2);
> +    unsigned rot = simd_data(desc);
>       bool flip = rot & 1;
>       float64 neg_imag, neg_real;
> -    void *vd = &env->vfp.zregs[rd];
> -    void *vn = &env->vfp.zregs[rn];
> -    void *vm = &env->vfp.zregs[rm];
> -    void *va = &env->vfp.zregs[ra];
>       uint64_t *g = vg;
>   
>       neg_imag = float64_set_sign(0, (rot & 2) != 0);
> @@ -3955,12 +3918,12 @@ void HELPER(sve_fcmla_zpzzz_d)(CPUARMState *env, void *vg, uint32_t desc)
>   
>               if (likely((pg >> (i & 63)) & 1)) {
>                   d = *(float64 *)(va + H1_2(i));
> -                d = float64_muladd(e2, e1, d, 0, &env->vfp.fp_status);
> +                d = float64_muladd(e2, e1, d, 0, status);
>                   *(float64 *)(vd + H1_2(i)) = d;
>               }
>               if (likely((pg >> (j & 63)) & 1)) {
>                   d = *(float64 *)(va + H1_2(j));
> -                d = float64_muladd(e4, e3, d, 0, &env->vfp.fp_status);
> +                d = float64_muladd(e4, e3, d, 0, status);
>                   *(float64 *)(vd + H1_2(j)) = d;
>               }
>           } while (i & 63);
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index b35bad245e..7607593f6b 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3950,40 +3950,30 @@ static bool trans_FCADD(DisasContext *s, arg_FCADD *a)
>   
>   typedef void gen_helper_sve_fmla(TCGv_env, TCGv_ptr, TCGv_i32);

You can remove that typedef now.

>   
> -static bool do_fmla(DisasContext *s, arg_rprrr_esz *a, gen_helper_sve_fmla *fn)
> +static bool do_fmla(DisasContext *s, arg_rprrr_esz *a,
> +                    gen_helper_gvec_5_ptr *fn)
>   {
> -    if (fn == NULL) {
> +    if (a->esz == 0) {
>           return false;
>       }
> -    if (!sve_access_check(s)) {
> -        return true;
> +    if (sve_access_check(s)) {
> +        unsigned vsz = vec_full_reg_size(s);
> +        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
> +        tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           pred_full_reg_offset(s, a->pg),
> +                           status, vsz, vsz, 0, fn);
> +        tcg_temp_free_ptr(status);
>       }
> -
> -    unsigned vsz = vec_full_reg_size(s);
> -    unsigned desc;
> -    TCGv_i32 t_desc;
> -    TCGv_ptr pg = tcg_temp_new_ptr();
> -
> -    /* We would need 7 operands to pass these arguments "properly".
> -     * So we encode all the register numbers into the descriptor.
> -     */
> -    desc = deposit32(a->rd, 5, 5, a->rn);
> -    desc = deposit32(desc, 10, 5, a->rm);
> -    desc = deposit32(desc, 15, 5, a->ra);
> -    desc = simd_desc(vsz, vsz, desc);
> -
> -    t_desc = tcg_const_i32(desc);
> -    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
> -    fn(cpu_env, pg, t_desc);
> -    tcg_temp_free_i32(t_desc);
> -    tcg_temp_free_ptr(pg);
>       return true;
>   }
>   
>   #define DO_FMLA(NAME, name) \
>   static bool trans_##NAME(DisasContext *s, arg_rprrr_esz *a)          \
>   {                                                                    \
> -    static gen_helper_sve_fmla * const fns[4] = {                    \
> +    static gen_helper_gvec_5_ptr * const fns[4] = {                  \
>           NULL, gen_helper_sve_##name##_h,                             \
>           gen_helper_sve_##name##_s, gen_helper_sve_##name##_d         \
>       };                                                               \
> @@ -3999,7 +3989,8 @@ DO_FMLA(FNMLS_zpzzz, fnmls_zpzzz)
>   
>   static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
>   {
> -    static gen_helper_sve_fmla * const fns[3] = {
> +    static gen_helper_gvec_5_ptr * const fns[4] = {
> +        NULL,
>           gen_helper_sve_fcmla_zpzzz_h,
>           gen_helper_sve_fcmla_zpzzz_s,
>           gen_helper_sve_fcmla_zpzzz_d,
> @@ -4010,25 +4001,14 @@ static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
>       }
>       if (sve_access_check(s)) {
>           unsigned vsz = vec_full_reg_size(s);
> -        unsigned desc;
> -        TCGv_i32 t_desc;
> -        TCGv_ptr pg = tcg_temp_new_ptr();
> -
> -        /* We would need 7 operands to pass these arguments "properly".
> -         * So we encode all the register numbers into the descriptor.
> -         */
> -        desc = deposit32(a->rd, 5, 5, a->rn);
> -        desc = deposit32(desc, 10, 5, a->rm);
> -        desc = deposit32(desc, 15, 5, a->ra);
> -        desc = deposit32(desc, 20, 2, a->rot);
> -        desc = sextract32(desc, 0, 22);
> -        desc = simd_desc(vsz, vsz, desc);
> -
> -        t_desc = tcg_const_i32(desc);
> -        tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
> -        fns[a->esz - 1](cpu_env, pg, t_desc);
> -        tcg_temp_free_i32(t_desc);
> -        tcg_temp_free_ptr(pg);
> +        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
> +        tcg_gen_gvec_5_ptr(vec_full_reg_offset(s, a->rd),
> +                           vec_full_reg_offset(s, a->rn),
> +                           vec_full_reg_offset(s, a->rm),
> +                           vec_full_reg_offset(s, a->ra),
> +                           pred_full_reg_offset(s, a->pg),
> +                           status, vsz, vsz, a->rot, fns[a->esz]);
> +        tcg_temp_free_ptr(status);
>       }
>       return true;
>   }
> 


