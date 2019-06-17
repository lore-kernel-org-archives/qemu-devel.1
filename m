Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D674C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3562084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3562084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvXY-0002pf-Qz
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hcvTl-0000ul-30
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hcvTg-0006Ws-EU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:31:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hcvTc-0006DQ-0C
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:31:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so2796172wrs.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 10:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bt/y/6v9gaarGIpBg2i2ZbUcsSv56GqqzKtOM4GHSkA=;
 b=X2iI/cuI9KnMNps9JlETaF7bX7CAF/4tlQ38+lVBRTNeTnpXz/uT5z8m1X4EI7o35T
 ULZh1mJJsEn9zCGEZC3/LrF6e82WIO4CkmrHFlmkbEmu6gZsIWRaY/9riiuk8rd5TriL
 vzsbJ4FJotEGP3MvdeiNcX0KPfMN98Uv3CupETtHRBSQnrwxeh8+W4x4m2DaPe8lcyqG
 dryJX7UB0wDvkWbXilAsM5rjL2RVPy8lbEoHFfrAYaCQrbJe0ZLNG9ed/GFK8IXpsiYe
 +Ilo8HwJQlUwafPvOj9emAQe4EwCHcqzrPCxRDd/n1znCSu6j7cvDe1yP8xfLNAMj8sw
 zPQg==
X-Gm-Message-State: APjAAAXRZfW4DnVhgoWEgugT/cwhiNaABl0xBHXD+HeQ2mhrull2wyNc
 vYelSi0LSQkL0H6zStm7y8jVLlwxiTM=
X-Google-Smtp-Source: APXvYqxiE8NzmKMGKE76DkeRnWfYTPcv9n8pWbFlWC2gw4odzS+/UdD4GADnTdHvUIpryg4LEZ6f/A==
X-Received: by 2002:a05:6000:12cd:: with SMTP id
 l13mr10924829wrx.196.1560792667164; 
 Mon, 17 Jun 2019 10:31:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id d18sm15147540wrb.90.2019.06.17.10.31.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 10:31:06 -0700 (PDT)
To: Liran Alon <liran.alon@oracle.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
 <20190615004256.16367-7-pbonzini@redhat.com>
 <78981CC5-F222-4E52-95B8-ED8BBE68CC35@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb431539-e3dc-a23f-12da-76b7bd52abf7@redhat.com>
Date: Mon, 17 Jun 2019 19:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <78981CC5-F222-4E52-95B8-ED8BBE68CC35@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 6/7] KVM: i386: Add support for save and
 restore nested state
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
Cc: qemu-devel@nongnu.org, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/06/19 03:14, Liran Alon wrote:
>> @@ -1368,6 +1369,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>     if (has_xsave) {
>>         env->xsave_buf = qemu_memalign(4096, sizeof(struct kvm_xsave));
>>     }
>> +
>> +    nested_state_len = kvm_max_nested_state_length();
>> +    if (nested_state_len > 0) {
>> +        assert(nested_state_len >= offsetof(struct kvm_nested_state, data));
>> +        env->nested_state = g_malloc0(nested_state_len);
> 
> Paolo, why have you removed setting “env->nested_state->size = max_nested_state_len;”?

Because I confused the "nested_state_len == 0" check in
kvm_put_nested_state with "env->nested_state->size == 0".

> In addition, in my next patch-series I also added the following code here which is required:
> 
> +        if (IS_INTEL_CPU(env)) {
> +            struct kvm_vmx_nested_state_hdr *vmx_hdr =
> +                &env->nested_state->hdr.vmx_hdr;
> +
> +            vmx_hdr->vmxon_pa = -1ull;
> +            vmx_hdr->vmcs12_pa = -1ull;
> +        }

Looks good.

>> +    }
>> +
>>     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
> 
> Note: In my next patch-series I have also added a new kvm_arch_destroy_vcpu() method which is called from kvm_destroy_vcpu().
> Similar to how kvm_arch_init_vcpu() is called from kvm_init_vcpu().
> I use it to free both cpu->kvm_msr_buf and env->nested_state.

Looks good too.

>>
>>     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
>> @@ -3125,6 +3133,41 @@ static int kvm_get_debugregs(X86CPU *cpu)
>>     return 0;
>> }
>>
>> +static int kvm_put_nested_state(X86CPU *cpu)
>> +{
>> +    CPUX86State *env = &cpu->env;
>> +    uint32_t nested_state_len = kvm_max_nested_state_length();
>> +
>> +    if (nested_state_len == 0) {
>> +        return 0;
>> +    }
>> +
>> +    assert(env->nested_state->size <= nested_state_len);
>> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_NESTED_STATE, env->nested_state);
>> +}
>> +
>> +static int kvm_get_nested_state(X86CPU *cpu)
>> +{
>> +    CPUX86State *env = &cpu->env;
>> +    uint32_t nested_state_len = kvm_max_nested_state_length();
>> +
>> +    if (nested_state_len == 0) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * It is possible that migration restored a smaller size into
>> +     * nested_state->size than what our kernel supports.
>> +     * We preserve migration origin nested_state->size for
>> +     * the call to KVM_SET_NESTED_STATE but wish that our next call
>> +     * to KVM_GET_NESTED_STATE will use the maximum size supported by
>> +     * the kernel we're running on.
>> +     */
>> +    env->nested_state->size = nested_state_len;
>> +
>> +    return kvm_vcpu_ioctl(CPU(cpu), KVM_GET_NESTED_STATE, env->nested_state);
>> +}
>> +
>> int kvm_arch_put_registers(CPUState *cpu, int level)
>> {
>>     X86CPU *x86_cpu = X86_CPU(cpu);
>> @@ -3132,6 +3175,11 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
>>
>>     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>>
>> +    ret = kvm_put_nested_state(x86_cpu);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>>     if (level >= KVM_PUT_RESET_STATE) {
>>         ret = kvm_put_msr_feature_control(x86_cpu);
>>         if (ret < 0) {
>> @@ -3247,6 +3295,10 @@ int kvm_arch_get_registers(CPUState *cs)
>>     if (ret < 0) {
>>         goto out;
>>     }
>> +    ret = kvm_get_nested_state(cpu);
>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>>     ret = 0;
>>  out:
>>     cpu_sync_bndcs_hflags(&cpu->env);
>> diff --git a/target/i386/machine.c b/target/i386/machine.c
>> index 41460be54b..45dbae6054 100644
>> --- a/target/i386/machine.c
>> +++ b/target/i386/machine.c
>> @@ -246,6 +246,15 @@ static int cpu_pre_save(void *opaque)
>>         env->segs[R_SS].flags &= ~(env->segs[R_SS].flags & DESC_DPL_MASK);
>>     }
>>
>> +#ifdef CONFIG_KVM
>> +    /* Verify we have nested virtualization state from kernel if required */
>> +    if (is_nested_virt_enabled(env) && !env->nested_state) {
>> +        error_report("Guest enabled nested virtualization but kernel "
>> +                     "do not support saving nested state");
>> +        return -EINVAL;
>> +    }
>> +#endif
>> +
>>     return 0;
>> }
>>
>> @@ -909,6 +918,176 @@ static const VMStateDescription vmstate_tsc_khz = {
>>     }
>> };
>>
>> +#ifdef CONFIG_KVM
>> +static bool vmx_vmcs12_needed(void *opaque)
>> +{
>> +    struct kvm_nested_state *nested_state = opaque;
>> +    return (nested_state->size > offsetof(struct kvm_nested_state,
>> +                                          vmx.data[0].vmcs12));
> 
> Do you prefer this compared to checking explicitly? i.e. by:
> return (nested_state->vmx.vmcs12_pa != -1ull);

I think I do, it guarantees that we don't serialize gibberish from
vmx.data[0] and it's consistent with the vmx_shadow_vmcs12_needed check.

>> +static bool nested_state_needed(void *opaque)
>> +{
>> +    X86CPU *cpu = opaque;
>> +    CPUX86State *env = &cpu->env;
>> +
>> +    return (is_vmx_enabled(env) && vmx_nested_state_needed(env->nested_state)) ||
>> +           (is_svm_enabled(env) && svm_nested_state_needed(env->nested_state));
>> +}
> 
> As I specified in an earlier email in this patch-series, this is not entirely accurate.
> In case vCPU is running L2 and entered SMM, then is_vmx_enabled() will return false because CR4 is set to 0 on entering SMM.
> I consider deeming nested_state needed in case hflags specifies guest is in SMM mode. Any objection?

See other answer, let's fix it in patch 7 instead.

Paolo

