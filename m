Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B946C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48BEB20657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jjql/pYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48BEB20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZI5I-0005RX-Af
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI4L-0004uG-Lr
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:54:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42654
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZI4K-00046E-Ew
 for qemu-devel@nongnu.org; Thu, 14 May 2020 13:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589478891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UERrffn8MJyBRRUgab8PoLDWUqyOVcDcG9vuznHTgcA=;
 b=Jjql/pYQiUuKZFYiK3lLns85zEFhUhQLrj8fDDWPKQvtCcnz9NCbKvkvxoug1ulm3Vdgfq
 GnURF/Dgxu4kXfCzbXPm3DZoI2dyOwLeNt8TYzgyXFV5e+FXatk5P5yrbNOIOPNkKhaWw8
 RINZL9FtXK5hHWdIe7lPRbojSWGbGJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-w9qgToe0PhmPaSRb5Ty2fA-1; Thu, 14 May 2020 13:54:49 -0400
X-MC-Unique: w9qgToe0PhmPaSRb5Ty2fA-1
Received: by mail-wr1-f69.google.com with SMTP id e14so1927924wrv.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 10:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UERrffn8MJyBRRUgab8PoLDWUqyOVcDcG9vuznHTgcA=;
 b=eT0ZxkYS2ur3Cq/varZS19AOC1i/rNrNRAnz6t4zze5LcRuSFoEEPpTL5dvVYqNZC5
 do/pALC3aD4HQHvkmzp1l9eV+Zpd1KNhQJymiRvT8nR0eJOr0IXKsw5ujqOzT5mSMZFN
 gKcOIyWD1cYu79EbyechStyVLO/9FwZWmbVKQydbYqBE9cOeunz6gVu/0EVnZlOi680+
 gFbPLJqfzvTrW0kr7N8LV83yrDNrpsl/lXUOPs6ahE4wyQhNp8zMnRWHfRHefUOxYgkH
 827daLe5T/FuSrcTa7icX04gVqIHyUg8OLhURlJ2ZXCb4rzyyUgt9fPX45irtOzJzHnE
 T7MA==
X-Gm-Message-State: AOAM530QQCx0YCvRj+61F5E0qsk758tm7YF2bOVkldt0qv2cgcczFNjI
 AOU2E1jcBwLJEuURsB4itkfovxzJlzHfkFqn7D+MbL1hR4dOOquxsngpufNMvSdAU13feMBW6k8
 a/n2iMXl8rHwvlpQ=
X-Received: by 2002:adf:fa92:: with SMTP id h18mr6812996wrr.260.1589478888232; 
 Thu, 14 May 2020 10:54:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWLcwJf2D8EAAi4SfuuvfYMsbhMS6grI+zLTlAueQvUpzy6aHsGwSODqEYnA7n53eUGq2Fmw==
X-Received: by 2002:adf:fa92:: with SMTP id h18mr6812972wrr.260.1589478887998; 
 Thu, 14 May 2020 10:54:47 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g10sm4795105wrx.4.2020.05.14.10.54.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2020 10:54:47 -0700 (PDT)
Subject: Re: [PATCH v2 2/9] target/riscv: Don't overwrite the reset vector
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1588878756.git.alistair.francis@wdc.com>
 <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <01168f32-c21c-b9fd-cb9c-06511e28bd20@redhat.com>
Date: Thu, 14 May 2020 19:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <44d0486b0fd156a756af544866dd7d19609b1aa6.1588878756.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 12:05:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 9:13 PM, Alistair Francis wrote:
> If the reset vector is set in the init function don't set it again in
> realise.

typo "realize".

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 059d71f2c7..8f837edf8d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -111,6 +111,14 @@ static void set_feature(CPURISCVState *env, int feature)
>       env->features |= (1ULL << feature);
>   }
>   
> +static int get_resetvec(CPURISCVState *env)
> +{
> +#ifndef CONFIG_USER_ONLY
> +    return env->resetvec;
> +#endif
> +    return 0;

Don't you get an error about double return? Maybe use #else?

> +}
> +
>   static void set_resetvec(CPURISCVState *env, int resetvec)
>   {
>   #ifndef CONFIG_USER_ONLY
> @@ -123,7 +131,6 @@ static void riscv_any_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>       set_priv_version(env, PRIV_VERSION_1_11_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>   }
>   
>   #if defined(TARGET_RISCV32)
> @@ -140,7 +147,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>       set_priv_version(env, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
> @@ -150,7 +156,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>       set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
> @@ -160,7 +165,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
>       set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
>   
> @@ -169,7 +173,6 @@ static void rv32imafcu_nommu_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
>       set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
>   
> @@ -187,7 +190,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>       set_priv_version(env, PRIV_VERSION_1_09_1);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
> @@ -197,7 +199,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
>       set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_MMU);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
> @@ -207,7 +208,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>       CPURISCVState *env = &RISCV_CPU(obj)->env;
>       set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
>       set_priv_version(env, PRIV_VERSION_1_10_0);
> -    set_resetvec(env, DEFAULT_RSTVEC);
>       set_feature(env, RISCV_FEATURE_PMP);
>   }
>   
> @@ -399,7 +399,9 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>       }
>   
>       set_priv_version(env, priv_version);
> -    set_resetvec(env, DEFAULT_RSTVEC);
> +    if (!get_resetvec(env)) {
> +        set_resetvec(env, DEFAULT_RSTVEC);
> +    }
>   
>       if (cpu->cfg.mmu) {
>           set_feature(env, RISCV_FEATURE_MMU);
> 


