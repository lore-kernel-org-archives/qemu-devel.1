Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A05C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D4C2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4C2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoTx-0003IR-L4
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jkoT3-0002jW-NA; Mon, 15 Jun 2020 08:44:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3782 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jkoT1-0004oj-1m; Mon, 15 Jun 2020 08:44:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 495E6EAAC7A4DFB7662D;
 Mon, 15 Jun 2020 20:43:46 +0800 (CST)
Received: from [10.173.222.233] (10.173.222.233) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 15 Jun 2020 20:43:36 +0800
Subject: Re: [PATCH v3] target/arm/cpu: adjust virtual time for arm cpu
To: Andrew Jones <drjones@redhat.com>
References: <20200608121243.2076-1-fangying1@huawei.com>
 <20200608124952.lwmko6hmtuckbnlw@kamzik.brq.redhat.com>
 <f9ddeb87-c91b-aeba-e376-9c185fe2264d@huawei.com>
 <20200610074026.4hm7bmeci2q6drbn@kamzik.brq.redhat.com>
From: Ying Fang <fangying1@huawei.com>
Message-ID: <48f572a1-e5f9-cb26-604c-47e9692fdbc6@huawei.com>
Date: Mon, 15 Jun 2020 20:43:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610074026.4hm7bmeci2q6drbn@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:43:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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



On 6/10/2020 3:40 PM, Andrew Jones wrote:
> On Wed, Jun 10, 2020 at 09:32:06AM +0800, Ying Fang wrote:
>>
>>
>> On 6/8/2020 8:49 PM, Andrew Jones wrote:
>>> On Mon, Jun 08, 2020 at 08:12:43PM +0800, Ying Fang wrote:
>>>> From: fangying <fangying1@huawei.com>
>>>>
>>>> Virtual time adjustment was implemented for virt-5.0 machine type,
>>>> but the cpu property was enabled only for host-passthrough and
>>>> max cpu model. Let's add it for arm cpu which has the generic timer
>>>> feature enabled.
>>>>
>>>> Suggested-by: Andrew Jones <drjones@redhat.com>
>>>
>>> This isn't true. I did suggest the way to arrange the code, after
>>> Peter suggested to move the kvm_arm_add_vcpu_properties() call to
>>> arm_cpu_post_init(), but I didn't suggest making this change in general,
>>> which is what this tag means. In fact, I've argued that it's pretty
>> I'm quite sorry for adding it here.
> 
> No problem.
> 
>>> pointless to do this, since KVM users should be using '-cpu host' or
>>> '-cpu max' anyway. Since I don't need credit for the code arranging,
>> As discussed in thread [1], there is a situation where a 'custom' cpu mode
>> is needed for us to keep instruction set compatibility so that migration can
>> be done, just like x86 does.
> 
> I understand the motivation. But, as I've said, KVM doesn't work that way.
> 
>> And we are planning to add support for it if
>> nobody is currently doing that.
> 
> Great! I'm looking forward to seeing the KVM patches. Especially since,
> without the KVM patches, the 'custom' CPU model isn't a custom CPU model,
> it's just a misleading way to use host passthrough. Indeed, I'm a bit
> opposed to allowing anything other than '-cpu host' and '-cpu max' (with
> features explicitly enabled/disabled, e.g. -cpu host,pmu=off) to work
> until KVM actually works with CPU models. Otherwise, how do we know the
> difference between a model that actually works and one that is just
> misleadingly named?
Yes you are right here.
My colleague zhanghailiang and me are now working on it. We will post 
the patch set soon.
> 
> Thanks,
> drew
> 
>>
>> Thanks.
>> Ying
>>
>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00022.html
>>> please just drop the tag. Peter can maybe do that on merge though. Also,
>>> despite not agreeing that we need this change today, as there's nothing
>>> wrong with it and it looks good to me
>>>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>>
>>> Thanks,
>>> drew
>>>
>>>> Signed-off-by: Ying Fang <fangying1@huawei.com>
>>>>
>>>> ---
>>>> v3:
>>>> - set kvm-no-adjvtime property in kvm_arm_add_vcpu_properties
>>>>
>>>> v2:
>>>> - move kvm_arm_add_vcpu_properties into arm_cpu_post_init
>>>>
>>>> v1:
>>>> - initial commit
>>>> - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08518.html
>>>>
>>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>>> index 32bec156f2..5b7a36b5d7 100644
>>>> --- a/target/arm/cpu.c
>>>> +++ b/target/arm/cpu.c
>>>> @@ -1245,6 +1245,10 @@ void arm_cpu_post_init(Object *obj)
>>>>        if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
>>>>            qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
>>>>        }
>>>> +
>>>> +    if (kvm_enabled()) {
>>>> +        kvm_arm_add_vcpu_properties(obj);
>>>> +    }
>>>>    }
>>>>    static void arm_cpu_finalizefn(Object *obj)
>>>> @@ -2029,7 +2033,6 @@ static void arm_max_initfn(Object *obj)
>>>>        if (kvm_enabled()) {
>>>>            kvm_arm_set_cpu_features_from_host(cpu);
>>>> -        kvm_arm_add_vcpu_properties(obj);
>>>>        } else {
>>>>            cortex_a15_initfn(obj);
>>>> @@ -2183,7 +2186,6 @@ static void arm_host_initfn(Object *obj)
>>>>        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>>>>            aarch64_add_sve_properties(obj);
>>>>        }
>>>> -    kvm_arm_add_vcpu_properties(obj);
>>>>        arm_cpu_post_init(obj);
>>>>    }
>>>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>>>> index cbc5c3868f..778cecc2e6 100644
>>>> --- a/target/arm/cpu64.c
>>>> +++ b/target/arm/cpu64.c
>>>> @@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
>>>>        if (kvm_enabled()) {
>>>>            kvm_arm_set_cpu_features_from_host(cpu);
>>>> -        kvm_arm_add_vcpu_properties(obj);
>>>>        } else {
>>>>            uint64_t t;
>>>>            uint32_t u;
>>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>> index 4bdbe6dcac..eef3bbd1cc 100644
>>>> --- a/target/arm/kvm.c
>>>> +++ b/target/arm/kvm.c
>>>> @@ -194,17 +194,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
>>>>    /* KVM VCPU properties should be prefixed with "kvm-". */
>>>>    void kvm_arm_add_vcpu_properties(Object *obj)
>>>>    {
>>>> -    if (!kvm_enabled()) {
>>>> -        return;
>>>> -    }
>>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>>> +    CPUARMState *env = &cpu->env;
>>>> -    ARM_CPU(obj)->kvm_adjvtime = true;
>>>> -    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
>>>> -                             kvm_no_adjvtime_set);
>>>> -    object_property_set_description(obj, "kvm-no-adjvtime",
>>>> -                                    "Set on to disable the adjustment of "
>>>> -                                    "the virtual counter. VM stopped time "
>>>> -                                    "will be counted.");
>>>> +    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
>>>> +        cpu->kvm_adjvtime = true;
>>>> +        object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
>>>> +                                 kvm_no_adjvtime_set);
>>>> +        object_property_set_description(obj, "kvm-no-adjvtime",
>>>> +                                        "Set on to disable the adjustment of "
>>>> +                                        "the virtual counter. VM stopped time "
>>>> +                                        "will be counted.");
>>>> +    }
>>>>    }
>>>>    bool kvm_arm_pmu_supported(CPUState *cpu)
>>>> -- 
>>>> 2.23.0
>>>>
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 

