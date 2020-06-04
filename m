Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84C0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6B4206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6B4206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgk92-0001go-UN
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 03:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jgk7c-00017Q-IE; Thu, 04 Jun 2020 03:17:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37960 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jgk7Y-00087h-WA; Thu, 04 Jun 2020 03:17:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BC146BB46B7E2D1EB7C8;
 Thu,  4 Jun 2020 15:16:47 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.233) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Thu, 4 Jun 2020 15:16:37 +0800
Subject: Re: [PATCH v2] target/arm/cpu: adjust virtual time for arm cpu
To: Andrew Jones <drjones@redhat.com>
References: <20200603020208.2089-1-fangying1@huawei.com>
 <20200603082600.efes4srlft3xv2tq@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <df1422fc-968c-bf38-48f2-8eb87d236b80@huawei.com>
Date: Thu, 4 Jun 2020 15:16:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200603082600.efes4srlft3xv2tq@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 03:16:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 wu.wubin@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 6/3/2020 4:26 PM, Andrew Jones wrote:
> On Wed, Jun 03, 2020 at 10:02:08AM +0800, Ying Fang wrote:
>> Virtual time adjustment was implemented for virt-5.0 machine type,
>> but the cpu property was enabled only for host-passthrough and
>> max cpu model. Let's add it for arm cpu which has the gernic
>> timer feature enabled.
>>
>>
>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>>
>> ---
>> v2:
>> - move kvm_arm_add_vcpu_properties into arm_cpu_post_init
>>
>> v1:
>> - initial commit
>> - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08518.html
>>
>> ---
>>   target/arm/cpu.c   | 3 +--
>>   target/arm/cpu64.c | 1 -
>>   2 files changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 32bec156f2..1e9b7a51f2 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1244,6 +1244,7 @@ void arm_cpu_post_init(Object *obj)
>>   
>>       if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
>>           qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
>> +        kvm_arm_add_vcpu_properties(obj);
> 
> The name 'kvm_arm_add_vcpu_properties' says nothing about being specific
> to the timer. So this is either the wrong place for this function, or the
> function is named wrong. I'd say it's the wrong place, because, as the
> comment above kvm_arm_add_vcpu_properties() implies, the function is
> for all 'kvm-*' prefixed properties, not just timer related ones. It's
> true we don't have any others yet, but we will. I have plans to post
can't agree more.

> kvm-steal-time soon, and despite it also having 'time' in its name, it
> shouldn't depend on ARM_FEATURE_GENERIC_TIMER.
yes, that would be nice.

> 
> How about the below [untested] patch instead?
this patch is much more reasonable for me, thanks for your help.
I've tested it and it works fine.

> 
> Thanks,
> drew
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 32bec156f2d4..e9084f98ef10 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1245,6 +1245,10 @@ void arm_cpu_post_init(Object *obj)
>       if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
>           qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
>       }
> +
> +    if (kvm_enabled()) {
> +        kvm_arm_add_vcpu_properties()

should be kvm_arm_add_vcpu_properties(obj);

> +    }
>   }
>   
>   static void arm_cpu_finalizefn(Object *obj)
> @@ -2029,7 +2033,6 @@ static void arm_max_initfn(Object *obj)
>   
>       if (kvm_enabled()) {
>           kvm_arm_set_cpu_features_from_host(cpu);
> -        kvm_arm_add_vcpu_properties(obj);
>       } else {
>           cortex_a15_initfn(obj);
>   
> @@ -2183,7 +2186,6 @@ static void arm_host_initfn(Object *obj)
>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>           aarch64_add_sve_properties(obj);
>       }
> -    kvm_arm_add_vcpu_properties(obj);
>       arm_cpu_post_init(obj);
>   }
>   
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index cbc5c3868fce..778cecc2e6ca 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
>   
>       if (kvm_enabled()) {
>           kvm_arm_set_cpu_features_from_host(cpu);
> -        kvm_arm_add_vcpu_properties(obj);
>       } else {
>           uint64_t t;
>           uint32_t u;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4bdbe6dcac07..eef3bbd1cc2c 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -194,17 +194,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
>   /* KVM VCPU properties should be prefixed with "kvm-". */
>   void kvm_arm_add_vcpu_properties(Object *obj)
>   {
> -    if (!kvm_enabled()) {
> -        return;
> -    }
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    CPUARMState *env = &cpu->env;
>   
> -    ARM_CPU(obj)->kvm_adjvtime = true;
> -    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
> -                             kvm_no_adjvtime_set);
> -    object_property_set_description(obj, "kvm-no-adjvtime",
> -                                    "Set on to disable the adjustment of "
> -                                    "the virtual counter. VM stopped time "
> -                                    "will be counted.");
> +    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> +        cpu->kvm_adjvtime = true;
> +        object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
> +                                 kvm_no_adjvtime_set);
> +        object_property_set_description(obj, "kvm-no-adjvtime",
> +                                        "Set on to disable the adjustment of "
> +                                        "the virtual counter. VM stopped time "
> +                                        "will be counted.");
> +    }
>   }
>   
>   bool kvm_arm_pmu_supported(CPUState *cpu)
> 
> 
>>       }
>>   }
>>   
>> @@ -2029,7 +2030,6 @@ static void arm_max_initfn(Object *obj)
>>   
>>       if (kvm_enabled()) {
>>           kvm_arm_set_cpu_features_from_host(cpu);
>> -        kvm_arm_add_vcpu_properties(obj);
>>       } else {
>>           cortex_a15_initfn(obj);
>>   
>> @@ -2183,7 +2183,6 @@ static void arm_host_initfn(Object *obj)
>>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>>           aarch64_add_sve_properties(obj);
>>       }
>> -    kvm_arm_add_vcpu_properties(obj);
>>       arm_cpu_post_init(obj);
>>   }
>>   
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index cbc5c3868f..778cecc2e6 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
>>   
>>       if (kvm_enabled()) {
>>           kvm_arm_set_cpu_features_from_host(cpu);
>> -        kvm_arm_add_vcpu_properties(obj);
>>       } else {
>>           uint64_t t;
>>           uint32_t u;
>> -- 
>> 2.23.0
>>
>>
>>
> 
> 
> .
> 


