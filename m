Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064C2C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2733205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="vr9uFPnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2733205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVqvm-0001FN-Se
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1jVquq-0000Lq-0U
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:18:52 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1jVqum-0000T9-2R
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:18:49 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ms17so577980pjb.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JbI+e13gU7cocawc+/J0NJrPu5VsWoJanb9VT1L+xb4=;
 b=vr9uFPnB0sUj47LfFT1+5L3uoU1mv2EI2QohRLfvqN60yeBZYY3WdQrxiePvVDFQAv
 b8kGzUP/+rLMXpBvUvV1gMVOYXMYtjqNnPrFu5LkBVB0zNL9dCpvOW3S8F5+nJqgSURG
 OPorfwJAAucO6TANvuhJjQFtNt9VeOu2Oi8xRM2zwHvSWXZCNx9jaqiekuODzhh77eRw
 kAFS1Y1uN1q29g1jCJXocG/E5or4gC+/qHvU1/Ysy1RuGum3iGlCZMFBiMv4e+u7Ro9w
 u56ynC5JWXQJPh1fugcTV2phfbgc7AZrw/PYJV/gPyPrN+znHl5jgAiFGiCiViXNtLGP
 2Tlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=JbI+e13gU7cocawc+/J0NJrPu5VsWoJanb9VT1L+xb4=;
 b=WElbqs8+bvYqxWWuayAuTMgQrx8S2RyIElRW1eMNAAVuzgFBzCMUqGz85v40cmlqYd
 OjBlctasKG8ZVMYsOkpjbLxfnteFT2IUJVLbKe3MbRcq4ddc0IPzy9mQd0qtXfuEQddz
 Ya0DsQ1icFbEchZmCvyJ14dEDzMY0haRUN07UpXdmxPKzIJi8gqDhmPFFzKUmuvS9Uz2
 cNjVNsH8jVDsBR0IuGzlwh8xpcszWzJ0IdIGXWBZyPoDJfIyrmR/rCtwprJDSO3GnW+8
 bWS7RShl1u/Z5ar+ZQMXpEi+LXBbQ4WBUuYw9AWV/YAWpgJ/MCDVHhk8a73A9NeKPh4Q
 Z61A==
X-Gm-Message-State: AGi0PuZe9uYSQfGtxcaW1plwBLSMi5pW8YsIOREpNXjaT0wDMS/ZlmKN
 u2xNhwQA7iCaR+SFWhKwH/AB9A==
X-Google-Smtp-Source: APiQypJREouxqDfpZ8KwmI/BkyxF1b0NbMYNbH16+0vScyzNTlz2+oDFvQAl6L64xq1LEcH7RT4DfQ==
X-Received: by 2002:a17:90a:25ea:: with SMTP id
 k97mr1122573pje.122.1588659524911; 
 Mon, 04 May 2020 23:18:44 -0700 (PDT)
Received: from [192.168.10.94] (124-171-87-207.dyn.iinet.net.au.
 [124.171.87.207])
 by smtp.gmail.com with ESMTPSA id x10sm771977pgq.79.2020.05.04.23.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 23:18:44 -0700 (PDT)
Subject: Re: [PATCH qemu] spapr: Add PVR setting capability
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200417041105.63563-1-aik@ozlabs.ru>
 <20200504133027.4f5a18f8@bahia.lan>
 <15bdf96d-c617-665e-09cd-f4f0e0f107e4@ozlabs.ru>
 <20200505055007.GD218517@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <7f7467ea-7919-f642-5bbe-083c34a018f5@ozlabs.ru>
Date: Tue, 5 May 2020 16:18:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505055007.GD218517@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=aik@ozlabs.ru; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 05/05/2020 15:50, David Gibson wrote:
> On Tue, May 05, 2020 at 10:56:17AM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 04/05/2020 21:30, Greg Kurz wrote:
>>> On Fri, 17 Apr 2020 14:11:05 +1000
>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>
>>>> At the moment the VCPU init sequence includes setting PVR which in case of
>>>> KVM-HV only checks if it matches the hardware PVR mask as PVR cannot be
>>>> virtualized by the hardware. In order to cope with various CPU revisions
>>>> only top 16bit of PVR are checked which works for minor revision updates.
>>>>
>>>> However in every CPU generation starting POWER7 (at least) there were CPUs
>>>> supporting the (almost) same POWER ISA level but having different top
>>>> 16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
>>>> with a new PVR family. We would normally add the PVR mask for the new one
>>>> too, the problem with it is that although the physical machines exist,
>>>> P9+ is not going to be released as a product, and this situation is likely
>>>> to repeat in the future.
>>>>
>>>> Instead of adding every new CPU family in QEMU, this adds a new sPAPR
>>>> machine capability to force PVR setting/checking. It is "on" by default
>>>> to preserve the existing behavior. When "off", it is the user's
>>>> responsibility to specify the correct CPU.
>>>>
>>>
>>> I don't quite understand the motivation for this... what does this
>>> buy us ?
>>
>> I answered that part in another mail in this thread, shortly this is to
>> make QEMU work with HV KVM on unknown-to-QEMU CPU family (0x004f0000).
>>
>>
>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>> ---
>>>>  include/hw/ppc/spapr.h |  5 ++++-
>>>>  hw/ppc/spapr.c         |  1 +
>>>>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>>>>  target/ppc/kvm.c       | 16 ++++++++++++++--
>>>>  4 files changed, 37 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>>> index e579eaf28c05..5ccac4d56871 100644
>>>> --- a/include/hw/ppc/spapr.h
>>>> +++ b/include/hw/ppc/spapr.h
>>>> @@ -81,8 +81,10 @@ typedef enum {
>>>>  #define SPAPR_CAP_CCF_ASSIST            0x09
>>>>  /* Implements PAPR FWNMI option */
>>>>  #define SPAPR_CAP_FWNMI                 0x0A
>>>> +/* Implements PAPR PVR option */
>>>> +#define SPAPR_CAP_PVR                   0x0B
>>>>  /* Num Caps */
>>>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
>>>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
>>>>  
>>>>  /*
>>>>   * Capability Values
>>>> @@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>>>>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>>>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>>>>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>>>> +extern const VMStateDescription vmstate_spapr_cap_pvr;
>>>>  
>>>>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>>>>  {
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 841b5ec59b12..ecc74c182b9f 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>>>      smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>>>> +    smc->default_caps.caps[SPAPR_CAP_PVR] = SPAPR_CAP_ON;
>>>>      spapr_caps_add_properties(smc, &error_abort);
>>>>      smc->irq = &spapr_irq_dual;
>>>>      smc->dr_phb_enabled = true;
>>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>>> index eb54f9422722..398b72b77f9f 100644
>>>> --- a/hw/ppc/spapr_caps.c
>>>> +++ b/hw/ppc/spapr_caps.c
>>>> @@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>>>>      }
>>>>  }
>>>>  
>>>> +static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>>>> +{
>>>> +    if (val) {
>>>> +        return;
>>>> +    }
>>>> +    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is supported");
>>>> +}
>>>> +
>>>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>>      [SPAPR_CAP_HTM] = {
>>>>          .name = "htm",
>>>> @@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>>          .type = "bool",
>>>>          .apply = cap_fwnmi_apply,
>>>>      },
>>>> +    [SPAPR_CAP_PVR] = {
>>>> +        .name = "pvr",
>>>> +        .description = "Enforce PVR in KVM",
>>>> +        .index = SPAPR_CAP_PVR,
>>>> +        .get = spapr_cap_get_bool,
>>>> +        .set = spapr_cap_set_bool,
>>>> +        .type = "bool",
>>>> +        .apply = cap_pvr_apply,
>>>> +    },
>>>>  };
>>>>  
>>>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>>>> @@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>>>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>>>> +SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
>>>>  
>>>>  void spapr_caps_init(SpaprMachineState *spapr)
>>>>  {
>>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>>> index 03d0667e8f94..a4adc29b6522 100644
>>>> --- a/target/ppc/kvm.c
>>>> +++ b/target/ppc/kvm.c
>>>> @@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>>>>      CPUPPCState *cenv = &cpu->env;
>>>>      int ret;
>>>> +    SpaprMachineState *spapr;
>>>>  
>>>
>>> We generally try to avoid adding such explicit dependencies to the
>>> machine code within the target directory... A virtual hypervisor
>>> hook could possibly do the trick but this would require to set
>>> PowerPCCPU::vhyp before kvm_arch_init_vcpu() gets called, eg.
>>> when the vCPU is created in spapr_create_vcpu() rather than
>>> when it gets realized.
>>
>> The only thing kvm_arch_sync_sregs() does is setting PVR, and it does
>> not do even that for Book3E so there is dependency already, mine at
>> least explicit :)
>>
>> I am really not sure what setting PVR buys us, KVM PR will take
>> anything,
> 
> PR will take anything, but it changes the behaviour.  Basically PR
> will try to match its behaviour to the PVR you specify.  It can't
> entirely succeeed in all cases, of course, but that's PR for you.
>
> From an API point of view, the idea is that setting the PVR here
> specifies the model you want the vcpu to appear to be.  But, KVM is
> free to say "can't do that".


Except pseries does not care what the CPU appears to be and uses
KVM_REG_PPC_ARCH_COMPAT instead.

So, is this a no? Thanks,


> 
>> KVM HV will only take the same family PVR and reject others
>> while it could still run more configurations, let's say -cpu POWER8 on
>> actual POWER9 machine. Dunno. The capability seems a harmless way of
>> relaxing this restriction. Thanks,
>>
>>
>>
>>
>>>
>>>>      /* Synchronize sregs with kvm */
>>>>      ret = kvm_arch_sync_sregs(cpu);
>>>>      if (ret) {
>>>>          if (ret == -EINVAL) {
>>>>              error_report("Register sync failed... If you're using kvm-hv.ko,"
>>>> -                         " only \"-cpu host\" is possible");
>>>> +                         " only \"-cpu host\" is supported");
>>>> +        }
>>>> +        /*
>>>> +         * The user chose not to set PVR which makes sense if we are running
>>>> +         * on a CPU with known ISA level but unknown PVR.
>>>> +         */
>>>> +        spapr = (SpaprMachineState *)
>>>> +            object_dynamic_cast(OBJECT(qdev_get_machine()), TYPE_SPAPR_MACHINE);
>>>> +
>>>> +        if (spapr && spapr->eff.caps[SPAPR_CAP_PVR] == SPAPR_CAP_OFF) {
>>>> +            ret = 0;
>>>> +        } else {
>>>> +            return ret;
>>>>          }
>>>> -        return ret;
>>>>      }
>>>>  
>>>>      switch (cenv->mmu_model) {
>>>
>>
> 

-- 
Alexey

