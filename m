Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62DEC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98868206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 00:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="EoezRDfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98868206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVlRP-0003Zv-Mo
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 20:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1jVlQ1-0002gT-FU
 for qemu-devel@nongnu.org; Mon, 04 May 2020 20:26:41 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1jVlPZ-0008Uv-39
 for qemu-devel@nongnu.org; Mon, 04 May 2020 20:26:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id x2so9368pfx.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zW98C8HLa05JvdIEwoMNGWohPI79/yUqf+RltTl0UnU=;
 b=EoezRDfT1u6NIPKiX2t+s++ZPE/snAPvWGBChgxaODQwira3yV02EaIsG29Cmqb6Uy
 KUL+DBkNc646NBHLq2jsGA9GufIT5cpWgc+ga9foJLQZuJFfzsHvkD+mG8lQW26O71i/
 Bjugrx3x2kyaXspgM3mqyJkFY2WCjfBrC6amQ87ziNFv6Y1qsmVYoNXeFRKqghUxeX5H
 5wEzzH//6ZIkIqhWcZqpXHo/EuUspmxiDgQY8Wb1bPoNr2kE3WUvUn77z8/OxoSnj4qe
 iSDjfD1NQVM+hU+jXMEQIezQaOsSRfn3tOmCz5Nq5mEj+Hgty4wX0evgUpPXe5gkI1vQ
 rG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zW98C8HLa05JvdIEwoMNGWohPI79/yUqf+RltTl0UnU=;
 b=P5JYunpqFNqEJvLCZDc44cWpQCsfHt9oA24eGwxlMVcz6milZe9Vdh8QEZA+JDnXLF
 CiECNEdVUQmfgCs1WZfh2aXUryPe5fkNiXUAKJ/TDZFSMSBR4N/+R8N8/KbpOJ63dh4G
 2G4dLGZzVpRE/xwAX11mOBjn/HId1ACp2ddHNGiSlwfWgTE1Yj7BfXqcIxDoKREWVLd9
 /B52kycAYFrdItt8EvyRo/IHILVvV6crjEZ81aQHfp5gaEkr9zayy/RJGJkPeSX2CDbL
 E2WwijOrYRJeBweLfTEZwqJ9rhoBuxjPjAP2h6mwDYgltZHB6FdvhaoIE25rqyl5L/Mo
 0DEQ==
X-Gm-Message-State: AGi0PuaiEThWHubwf7jl46wgJ0aAVbMXPTv0g/Rl9epqY53DbC5gv9p4
 n+bBRf1ETkp4lbmv7C2FnLcr4xn3bA4=
X-Google-Smtp-Source: APiQypKMgG6FRjXPnKlLAt/Vx5sL+4tDhFUKiVo0OzadhEo6fZj6Hl0jdSbV9jpLDcr/joHrC/JF7Q==
X-Received: by 2002:a63:491b:: with SMTP id w27mr776295pga.382.1588638366490; 
 Mon, 04 May 2020 17:26:06 -0700 (PDT)
Received: from [192.168.10.94] (124-171-87-207.dyn.iinet.net.au.
 [124.171.87.207])
 by smtp.gmail.com with ESMTPSA id d12sm151508pjx.1.2020.05.04.17.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 17:26:05 -0700 (PDT)
Subject: Re: [PATCH qemu] spapr: Add PVR setting capability
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
References: <20200417041105.63563-1-aik@ozlabs.ru>
 <20200504133027.4f5a18f8@bahia.lan>
 <19d43f25-f872-0075-d03d-98494360dfe2@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <7280b25b-8ce4-50e8-d037-fe321d5bb3d6@ozlabs.ru>
Date: Tue, 5 May 2020 10:26:01 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <19d43f25-f872-0075-d03d-98494360dfe2@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=aik@ozlabs.ru; helo=mail-pf1-x441.google.com
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 04/05/2020 21:38, Cédric Le Goater wrote:
> 
> 
> On 5/4/20 1:30 PM, Greg Kurz wrote:
>> On Fri, 17 Apr 2020 14:11:05 +1000
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>> At the moment the VCPU init sequence includes setting PVR which in case of
>>> KVM-HV only checks if it matches the hardware PVR mask as PVR cannot be
>>> virtualized by the hardware. In order to cope with various CPU revisions
>>> only top 16bit of PVR are checked which works for minor revision updates.
>>>
>>> However in every CPU generation starting POWER7 (at least) there were CPUs
>>> supporting the (almost) same POWER ISA level but having different top
>>> 16bits of PVR - POWER7+, POWER8E, POWER8NVL; this time we got POWER9+
>>> with a new PVR family. We would normally add the PVR mask for the new one
>>> too, the problem with it is that although the physical machines exist,
>>> P9+ is not going to be released as a product, and this situation is likely
>>> to repeat in the future.
>>>
>>> Instead of adding every new CPU family in QEMU, this adds a new sPAPR
>>> machine capability to force PVR setting/checking. It is "on" by default
>>> to preserve the existing behavior. When "off", it is the user's
>>> responsibility to specify the correct CPU.
>>>
>>
>> I don't quite understand the motivation for this... what does this
>> buy us ?
> 
> So we could use the command line options : 
> 
>  -cpu POWER8 -machine pseries,pvr=off
> 
> instead of
> 
>  -cpu host -machine pseries,max-cpu-compat=POWER8  
> 
> is that it ? 

This does not work for my case.

> 
> I am not sure I get it either.


QEMU has to know the host CPU family to work with HV KVM: QEMU reads
pvr, picks a CPU class and goes from there, the max-compat applies lot
later and does not affect the CPU class which QEMU chooses.

Now I have a machine ("swift") with 0x004F1100 and QEMU has no idea what
0x004Fxxxx is (but I know it is POWER9) and there is currently no way to
bypass the PVR check which QEMU requests from KVM which KVM PR passes
but KVM HV fails as it has to match. Adding a new CPU family to the
upstream QEMU makes no sense as there will only be a handful of those
ever. And forcing PVR does not buy us that much anyway.




> 
> 
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  include/hw/ppc/spapr.h |  5 ++++-
>>>  hw/ppc/spapr.c         |  1 +
>>>  hw/ppc/spapr_caps.c    | 18 ++++++++++++++++++
>>>  target/ppc/kvm.c       | 16 ++++++++++++++--
>>>  4 files changed, 37 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>>> index e579eaf28c05..5ccac4d56871 100644
>>> --- a/include/hw/ppc/spapr.h
>>> +++ b/include/hw/ppc/spapr.h
>>> @@ -81,8 +81,10 @@ typedef enum {
>>>  #define SPAPR_CAP_CCF_ASSIST            0x09
>>>  /* Implements PAPR FWNMI option */
>>>  #define SPAPR_CAP_FWNMI                 0x0A
>>> +/* Implements PAPR PVR option */
>>> +#define SPAPR_CAP_PVR                   0x0B
>>>  /* Num Caps */
>>> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
>>> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_PVR + 1)
>>>  
>>>  /*
>>>   * Capability Values
>>> @@ -912,6 +914,7 @@ extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>>>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>>>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
>>>  extern const VMStateDescription vmstate_spapr_cap_fwnmi;
>>> +extern const VMStateDescription vmstate_spapr_cap_pvr;
>>>  
>>>  static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
>>>  {
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 841b5ec59b12..ecc74c182b9f 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -4535,6 +4535,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
>>>      smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
>>> +    smc->default_caps.caps[SPAPR_CAP_PVR] = SPAPR_CAP_ON;
>>>      spapr_caps_add_properties(smc, &error_abort);
>>>      smc->irq = &spapr_irq_dual;
>>>      smc->dr_phb_enabled = true;
>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>> index eb54f9422722..398b72b77f9f 100644
>>> --- a/hw/ppc/spapr_caps.c
>>> +++ b/hw/ppc/spapr_caps.c
>>> @@ -525,6 +525,14 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr, uint8_t val,
>>>      }
>>>  }
>>>  
>>> +static void cap_pvr_apply(SpaprMachineState *spapr, uint8_t val, Error **errp)
>>> +{
>>> +    if (val) {
>>> +        return;
>>> +    }
>>> +    warn_report("If you're uing kvm-hv.ko, only \"-cpu host\" is supported");
>>> +}
>>> +
>>>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>      [SPAPR_CAP_HTM] = {
>>>          .name = "htm",
>>> @@ -633,6 +641,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>>>          .type = "bool",
>>>          .apply = cap_fwnmi_apply,
>>>      },
>>> +    [SPAPR_CAP_PVR] = {
>>> +        .name = "pvr",
>>> +        .description = "Enforce PVR in KVM",
>>> +        .index = SPAPR_CAP_PVR,
>>> +        .get = spapr_cap_get_bool,
>>> +        .set = spapr_cap_set_bool,
>>> +        .type = "bool",
>>> +        .apply = cap_pvr_apply,
>>> +    },
>>>  };
>>>  
>>>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
>>> @@ -773,6 +790,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>>>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>>>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>>>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
>>> +SPAPR_CAP_MIG_STATE(pvr, SPAPR_CAP_PVR);
>>>  
>>>  void spapr_caps_init(SpaprMachineState *spapr)
>>>  {
>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>> index 03d0667e8f94..a4adc29b6522 100644
>>> --- a/target/ppc/kvm.c
>>> +++ b/target/ppc/kvm.c
>>> @@ -466,15 +466,27 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>      PowerPCCPU *cpu = POWERPC_CPU(cs);
>>>      CPUPPCState *cenv = &cpu->env;
>>>      int ret;
>>> +    SpaprMachineState *spapr;
>>>  
>>
>> We generally try to avoid adding such explicit dependencies to the
>> machine code within the target directory... A virtual hypervisor
>> hook could possibly do the trick but this would require to set
>> PowerPCCPU::vhyp before kvm_arch_init_vcpu() gets called, eg.
>> when the vCPU is created in spapr_create_vcpu() rather than
>> when it gets realized.
>>
>>>      /* Synchronize sregs with kvm */
>>>      ret = kvm_arch_sync_sregs(cpu);
>>>      if (ret) {
>>>          if (ret == -EINVAL) {
>>>              error_report("Register sync failed... If you're using kvm-hv.ko,"
>>> -                         " only \"-cpu host\" is possible");
>>> +                         " only \"-cpu host\" is supported");
>>> +        }
> 
> we would still have the error above even if pvr=off ?


Yup. We would still print a message but continue, for the moment it is a
debugging tool. Thanks,



> 
> C. 
> 
>>> +        /*
>>> +         * The user chose not to set PVR which makes sense if we are running
>>> +         * on a CPU with known ISA level but unknown PVR.
>>> +         */
>>> +        spapr = (SpaprMachineState *)
>>> +            object_dynamic_cast(OBJECT(qdev_get_machine()), TYPE_SPAPR_MACHINE);
>>> +
>>> +        if (spapr && spapr->eff.caps[SPAPR_CAP_PVR] == SPAPR_CAP_OFF) {
>>> +            ret = 0;
>>> +        } else {
>>> +            return ret;
>>>          }
>>> -        return ret;
>>>      }
>>>  
>>>      switch (cenv->mmu_model) {
>>
>>

-- 
Alexey

