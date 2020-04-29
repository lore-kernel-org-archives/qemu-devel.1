Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAD5C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DD920731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFtrgc9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DD920731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTj3U-00014j-GL
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTj2l-0000Ya-4r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTj2k-0007Gr-IW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTj2k-0007Fx-3P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:30:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so1231919wma.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4QGJae0BCqMZU2OL7B8SvOTCFE3T5r49zHG+H+abWMM=;
 b=dFtrgc9rP4dnQ4j5qLYC1xAEBsq2dZ6R/mpg1d0TVBLRQidkGd/hA02CEiVVywKJVF
 pVROMtP2corngwM5Ytna4QjgWUwfXRP9WaSgX/3I7CWa3abiBZaEiV0M1WB+N8r8+jL5
 KG0H+q5MQ5UiIVgou5HxdX2+altUoxQmtE+hk5Kj9dzM5ds2w8K/vgyD5rw5uJGnQF+y
 vG+6bxE9JT6mCZJXqV3JHh6dDVfWrjgPEnY3VI8vfblXSaqjaYKBZF7ecZaj8aDhX/ok
 Wd6UJW312UPLPx8Z2UniP6poFnATbC8Vp1kNQgKR3rNxXtXxaaAEG6nGE+Vx2tqWwHsE
 PwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4QGJae0BCqMZU2OL7B8SvOTCFE3T5r49zHG+H+abWMM=;
 b=AzJ5R5VNCVLHdmOwXMX9gMCgtW1N2JAyQ67hqO9dDKXEC7u5LljnC6MNGryocdSZbF
 R8uEG+tw26xznO3s1ogAhM+W2+/+PsvL3qJHYjXnalmT7D8b+qq1GS2RtcgFw2FcuHtg
 YCZz3zJR2XxPLVT3J1gvQ+KDHyeQK4B+7O+kug85I2obWMuLPQ51qHPY9imN/Kcpz2u2
 NgzCvwkHI0TyImUfCQLqAt0fwBemUkZWCDEKcrqFpP/5Tzw6WIGb+0q0kLAKrVK9Yb/g
 kvQvkLlUXX7AbPfrq1QKXtdraOYuQS23yiJqz6TWrPMyBQRhEJBcwxNs83Y07Nlgldm9
 tPVQ==
X-Gm-Message-State: AGi0PuaSDoujaSycFBMyqrVY2AjT5/hGnZ1qg3ZplFiFDXU2hqflhAN8
 0Uev/SIAqxLjDBRxyGgnar8=
X-Google-Smtp-Source: APiQypKm9VkOKxwGR82ZGcncPN7oiNJzI4dwkK+Us58cAz564/RE4AOXMV8n1yQTRDSKWopJc5BLoA==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr2167409wma.24.1588152612786; 
 Wed, 29 Apr 2020 02:30:12 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id q18sm6519769wmj.11.2020.04.29.02.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 02:30:12 -0700 (PDT)
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: Huacai Chen <chenhuacai@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
 <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
 <CABDp7Vq-YX0LWU3iM=oygpcKzoS8cmXG6mvTQ5Gm_PbQsQMAgw@mail.gmail.com>
 <CAHiYmc6zFjBtgXRv=8+dqnbDtZqKqiwSDwEi0wKqJmJnys_y0g@mail.gmail.com>
 <CAAhV-H6NFV7hbaOp8BwPck3FWm5ZHBpuoA9FDmN6tby5LcoTeg@mail.gmail.com>
 <a791f90b-a2a5-6665-59b5-212f98c7afc8@amsat.org>
 <CAAhV-H7NS_KCTuYQYvZeseNEZh56FBFz97kEj4KK-NsBDMJotQ@mail.gmail.com>
 <a1b333c6-e9a0-aabc-9ec2-b9bcb2007211@amsat.org>
 <CAAhV-H5_0Nn-omF+_+6T1mbtnFC-3VHTOgvAPfbc44Fnv0px_Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c133fe4a-03a9-c3c5-540b-31fd0283d62d@amsat.org>
Date: Wed, 29 Apr 2020 11:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5_0Nn-omF+_+6T1mbtnFC-3VHTOgvAPfbc44Fnv0px_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 11:25 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> I think that this CPU definition is for Guest, not for Host (Maybe I'm wrong?).

OK, it was not obvious to me (I haven't received the cover letter of 
this series).
The code you modified is used by both host emulation and guest 
virtualization.

If you want to only add a guest cpu type, you should name it 
"Loongson-3A virtualized" and can restrict with:

   if (kvm_enabled()) {
     add_guest_cpu();
   }

But cleaner is to add the host cpu regardless, and in cpu_state_reset() 
restrict when virtualized:

   if (kvm_enabled()) {
     /* disable host features on guest */
     env->CP0_Config3 &= ~CP0C3_VZ;
     ...
   }

> 
> On Wed, Apr 29, 2020 at 4:58 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 4/29/20 10:27 AM, Huacai Chen wrote:
>>> Hi, Philippe,
>>>
>>> The major differences of R3 and R4 are:
>>> 1, R4 has complete MIPS VZ ASE (while R3 is incomplete), so very
>>> usable for KVM host;
>>
>> So you need to set CP0C3_VZ.
> If the definition is for Guest, I think CP0C3_VZ should not be set in
> CP0_Config3, because only the Host can see VZ ASE.
> 
>>
>>> 2, R4 has MSA ASE while R3 hasn't;
>>
>> So you need to set CP0C5_MSAEn.
> I have already set CP0C5_MSAEn CP0_Config5_rw_bitmask, but I don't
> think it should be set in CP0_Config5 because MSA is disabled by
> default.
> 
>>
>>> 3, R4 has cpucfg, rdcsr and wrcsr instructions (similar to cpuid,
>>> rdmsr and wrmsr in X86).
>>
>> OK, these are not implemented.

I was looking at TCG emulation, now I understand why you don't mind 
about them there.

>>
>> [...]
>>
>>>>>>>>> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
>>>>>>>>> index 6d145a9..a32412d 100644
>>>>>>>>> --- a/target/mips/translate_init.inc.c
>>>>>>>>> +++ b/target/mips/translate_init.inc.c
>>>>>>>>> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =
>>>>>>>>>             .mmu_type = MMU_TYPE_R4000,
>>>>>>>>>         },
>>>>>>>>>         {
>>>>>>>>> +        .name = "Loongson-3A",
>>>>>>>>> +        .CP0_PRid = 0x14C000,
>>>>>>>>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
>>>>>>>>> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
>>>>>>>>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
>>>>>>>>> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
>>>>>>>>> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
>>>>>>>>> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
>>>>>>>>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
>>>>>>>>> +        .CP0_Config2 = MIPS_CONFIG2,
>>>>>>>>> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
>>>>>>>>> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
>>>>>>>>> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
>>>>>>>>> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
>>>>>>>>> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
>>>>>>>>> +        .CP0_Config4_rw_bitmask = 0,
>>>>>>>>> +        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << 18),
>>>>>>>>> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
>>>>>>>>> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
>>>>>>>>> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
>>>>>>>>> +        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 << CP0C6_SFBEN) |
>>>>>>>>> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>>>>>> +        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
>>>>>>>>> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) | (1 << CP0C6_LASX) |
>>>>>>>>> +                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISDRTIME) |
>>>>>>>>> +                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_SCRAND) |
>>>>>>>>> +                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_DISVC) |
>>>>>>>>> +                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
>>>>>>>>> +                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DISBLKLYEN) |
>>>>>>>>> +                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6_SFBEN) |
>>>>>>>>> +                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VLTINT) |
>>>>>>>>> +                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_STPREFCTL) |
>>>>>>>>> +                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>>>>>> +        .CP0_Config7 = 0,
>>>>>>>>> +        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) | \
>>>>>>>>> +                                  (1 << CP0C7_VFPUCGEN),
>>>>>>>>> +        .CP0_LLAddr_rw_bitmask = 1,
>>>>>>>>> +        .SYNCI_Step = 16,
>>>>>>>>> +        .CCRes = 2,
>>>>>>>>> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
>>>>>>>>> +        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
>>>>>>>>> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
>>>>>>>>> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
>>>>>>>>> +        .CP1_fcr31 = 0,
>>>>>>>>> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>>>>>>>>> +        .SEGBITS = 48,
>>>>>>>>> +        .PABITS = 48,
>>>>>>>>> +        .insn_flags = CPU_LOONGSON3A,
>>>>>>>>> +        .mmu_type = MMU_TYPE_R4000,
>>>>>>>>> +    },
>>>>>>>>> +    {
>>>>>>>>>             /* A generic CPU providing MIPS64 DSP R2 ASE features.
>>>>>>>>>                FIXME: Eventually this should be replaced by a real CPU model. */
>>>>>>>>>             .name = "mips64dspr2",
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Huacai Chen
>>>>>
>>>
> 

