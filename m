Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB2C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 09:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBDB2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQy8nguU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBDB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg4Zb-0000Zh-MJ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg4Y9-0007hB-9s
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 05:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg4Y8-0002oU-6t
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 05:49:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg4Y7-0002nC-RX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 05:49:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id u8so1401945wmm.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zUy5FMZLopmOCCAsFNI3/285Wur+YHkm+VqA7tRJ9zE=;
 b=kQy8nguU5N0vcpkgb41TF76DvAtBjMNEzojluxcxX3kbUEJQBu4tHr/TQpRG6IklkQ
 t+UsBG7zLcCq+JoOPC02UwywoKTtsMCodmL5jUo0G/p0PNfGbGVj/BMLjy+tMJiQj0jO
 rh6WbPAZdGS6Q+oYm1bRM1ziOG0pmT3zROVB9LBeGItYEgWKonpEuKcDF2Jo5oxRTa4w
 tIzysXQfuvJnw5UBKY2nhBHsEnZQOLBS3OqyU/P/lBuYMwkxKY4X3A2df3PafFQ0qqQt
 iy+88uQKNdnQFzxQg4qKicfPHjkz1gIUw1+wW63G0rxRonTAr8jsdYNKYa6+aUwRlMt4
 i3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zUy5FMZLopmOCCAsFNI3/285Wur+YHkm+VqA7tRJ9zE=;
 b=SZgjXNj4cI4dEwJ36h6Rb2LQLKoA2FEiPUn4HUiGx7Fswiu4OQST01Cmst2caAujsh
 hjpksLIdCBK2WEMj7gA//XkSTVs3ibveLrXDKax8G3wdppZF3pgsw70vpurzmwKsRYsy
 6jSzZsgprYzDCU0xJTXYKLM3nuGXdkk/Zom1D+qxo9LIj8meipXhyg7RFbOKDGeeh94V
 1eZUNmY+cey2bm3LniU7O7ueAZ4dgT1eH05WsGkk/QHGaUvOeEMcr+xaIF6nzwb8MiNQ
 1x5jFGyFqEz1cGGyFcD8uQMT7Sg2n81Sso+4CGc11pB1p9Kixtb6hDAkNuSzWT6VlLPo
 GWUg==
X-Gm-Message-State: APjAAAXYPMQt3aKPb8BrCOlBPopeRUZWaUMjI1QFC8tDwpUKaOYc/mn4
 GCskMUOJibHVHiTbATbu7DLcMg==
X-Google-Smtp-Source: APXvYqxTMOD4id6c9MT5sZSk/WOg1512ndHUDaD3uqSgMK1Dm0jrhR6W9TywuHUjwnKk0Qb43QGFhA==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr2080419wmf.162.1561542546351; 
 Wed, 26 Jun 2019 02:49:06 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id b5sm10997017wrq.61.2019.06.26.02.49.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 02:49:05 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-3-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7ba318d0-1701-39de-acee-d1a51385977d@linaro.org>
Date: Wed, 26 Jun 2019 11:49:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-3-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 02/14] target/arm/cpu: Ensure we can use
 the pmu with kvm
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> We first convert the pmu property from a static property to one with
> its own accessors. Then we use the set accessor to check if the PMU is
> supported when using KVM. Indeed a 32-bit KVM host does not support
> the PMU, so this check will catch an attempt to use it at property-set
> time.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/cpu.c     | 30 +++++++++++++++++++++++++-----
>  target/arm/kvm.c     |  9 +++++++++
>  target/arm/kvm_arm.h | 13 +++++++++++++
>  3 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 376db154f008..858f668d226e 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -759,10 +759,6 @@ static Property arm_cpu_has_el3_property =
>  static Property arm_cpu_cfgend_property =
>              DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
>  
> -/* use property name "pmu" to match other archs and virt tools */
> -static Property arm_cpu_has_pmu_property =
> -            DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
> -
>  static Property arm_cpu_has_vfp_property =
>              DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
>  
> @@ -785,6 +781,29 @@ static Property arm_cpu_pmsav7_dregion_property =
>                                             pmsav7_dregion,
>                                             qdev_prop_uint32, uint32_t);
>  
> +static bool arm_get_pmu(Object *obj, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    return cpu->has_pmu;
> +}
> +
> +static void arm_set_pmu(Object *obj, bool value, Error **errp)
> +{
> +    ARMCPU *cpu = ARM_CPU(obj);
> +
> +    if (value) {
> +        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
> +            error_setg(errp, "'pmu' feature not supported by KVM on this host");
> +            return;
> +        }
> +        set_feature(&cpu->env, ARM_FEATURE_PMU);
> +    } else {
> +        unset_feature(&cpu->env, ARM_FEATURE_PMU);
> +    }
> +    cpu->has_pmu = value;
> +}
> +
>  static void arm_get_init_svtor(Object *obj, Visitor *v, const char *name,
>                                 void *opaque, Error **errp)
>  {
> @@ -859,7 +878,8 @@ void arm_cpu_post_init(Object *obj)
>      }
>  
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
> -        qdev_property_add_static(DEVICE(obj), &arm_cpu_has_pmu_property,
> +        cpu->has_pmu = true;
> +        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu,
>                                   &error_abort);

This doesn't look right.

The static property is only enabled here if the cpu is known to support the
PMU, and thus the only useful setting is -cpu foo,pmu=off.  Which means that
the extra checking that you do in the dynamic property is unused.

It seems like you need to be checking for the PMU earlier, e.g. in
kvm_arm_get_host_cpu_features.


r~

