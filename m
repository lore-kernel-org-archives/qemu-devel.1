Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535D2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A662076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQNyB6B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A662076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTick-00034A-6w
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiae-0000gh-AI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiYO-00040p-G2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:01:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiYN-00040Q-VH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:58:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id h4so1115684wmb.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+JJiHga6enBSPy4Z0jIURbXqsKuRNYMHVVnsrcs642Q=;
 b=OQNyB6B+C/iOOUJe2OjzLjgrAuGUvoTRHhJApqSvQl1yNT4p+ZxnkEhUohhyXwDNcA
 rrt+LWrBwPQK4mLpWy+dp/zU6487kDXGdvK6zIYhmhTupWL13bbH0MbSmTvvDmRWQanr
 NmRgdPW9FnVRQdEN7Q/3TZsmrzNmxKuRgi5MBFHB5xhex17tacNGrb7oCOWuKdA3vMf3
 3WEbBQAs2v+U+R6zK23XVO4Z9AIu3+UE5ApHfo+geOmB48lFCXTN01RtGdEcRhkAnKfb
 0IPr6apYXlue/4qh3GixlbqEqXpZjfrunOz0npAFo/PIPgrS38nS9xINhwgSKFNwgg1l
 D5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+JJiHga6enBSPy4Z0jIURbXqsKuRNYMHVVnsrcs642Q=;
 b=VbQiSRdu2g9/8At3m/lJU2x03LzbeqpBxTnOqP/wP5c2lk14AcN9Jy12z/niqI1DKN
 UXtH/4v7H7ly6e2S1xjKO6oTw3j5aBOPuMeNadpKLV9rre7rRVetZeu1sQ+0SijsFTAN
 OJaho8NwIkp8E8VAjqiPvfoNxK13IEyL04REkJww8noCkQhsTVOJAOaDLKa6IVMkgBug
 AFXVWjHCLSrkLr+WA/8Vya4BL7rlWsdq2o1k7jj+MRMdRoHpIkJi1AkurNODe79yYl7y
 oMRd0BVmz4B3yHUkb26MitMFncvCA5GIZ/N+Mluu8riinNvVk20avIroZCysLONdkU2F
 tQ4g==
X-Gm-Message-State: AGi0PuaiZt2ghy3BlJwwmnEr1V9DJ9+22VgUxTe7LRuwJHBFFUMDNEWH
 ixMekWgJ+w9FH8zTuXUh9ok=
X-Google-Smtp-Source: APiQypIKKSbOg7JpBNEWZYlCXXOfh42aFvWzm9gDy+SxuxjY5Ybj2stFEHXCDiuIaHnG0QeDdeyEkg==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr2203244wml.144.1588150730350; 
 Wed, 29 Apr 2020 01:58:50 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id s18sm30898169wra.94.2020.04.29.01.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 01:58:49 -0700 (PDT)
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1b333c6-e9a0-aabc-9ec2-b9bcb2007211@amsat.org>
Date: Wed, 29 Apr 2020 10:58:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7NS_KCTuYQYvZeseNEZh56FBFz97kEj4KK-NsBDMJotQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

On 4/29/20 10:27 AM, Huacai Chen wrote:
> Hi, Philippe,
> 
> The major differences of R3 and R4 are:
> 1, R4 has complete MIPS VZ ASE (while R3 is incomplete), so very
> usable for KVM host;

So you need to set CP0C3_VZ.

> 2, R4 has MSA ASE while R3 hasn't;

So you need to set CP0C5_MSAEn.

> 3, R4 has cpucfg, rdcsr and wrcsr instructions (similar to cpuid,
> rdmsr and wrmsr in X86).

OK, these are not implemented.

[...]

>>>>>>> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
>>>>>>> index 6d145a9..a32412d 100644
>>>>>>> --- a/target/mips/translate_init.inc.c
>>>>>>> +++ b/target/mips/translate_init.inc.c
>>>>>>> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =
>>>>>>>            .mmu_type = MMU_TYPE_R4000,
>>>>>>>        },
>>>>>>>        {
>>>>>>> +        .name = "Loongson-3A",
>>>>>>> +        .CP0_PRid = 0x14C000,
>>>>>>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
>>>>>>> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
>>>>>>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
>>>>>>> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
>>>>>>> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
>>>>>>> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
>>>>>>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
>>>>>>> +        .CP0_Config2 = MIPS_CONFIG2,
>>>>>>> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
>>>>>>> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
>>>>>>> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
>>>>>>> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
>>>>>>> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
>>>>>>> +        .CP0_Config4_rw_bitmask = 0,
>>>>>>> +        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << 18),
>>>>>>> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
>>>>>>> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
>>>>>>> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
>>>>>>> +        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 << CP0C6_SFBEN) |
>>>>>>> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>>>> +        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
>>>>>>> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) | (1 << CP0C6_LASX) |
>>>>>>> +                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISDRTIME) |
>>>>>>> +                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_SCRAND) |
>>>>>>> +                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_DISVC) |
>>>>>>> +                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
>>>>>>> +                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DISBLKLYEN) |
>>>>>>> +                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6_SFBEN) |
>>>>>>> +                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VLTINT) |
>>>>>>> +                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_STPREFCTL) |
>>>>>>> +                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>>>> +        .CP0_Config7 = 0,
>>>>>>> +        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) | \
>>>>>>> +                                  (1 << CP0C7_VFPUCGEN),
>>>>>>> +        .CP0_LLAddr_rw_bitmask = 1,
>>>>>>> +        .SYNCI_Step = 16,
>>>>>>> +        .CCRes = 2,
>>>>>>> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
>>>>>>> +        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
>>>>>>> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
>>>>>>> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
>>>>>>> +        .CP1_fcr31 = 0,
>>>>>>> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>>>>>>> +        .SEGBITS = 48,
>>>>>>> +        .PABITS = 48,
>>>>>>> +        .insn_flags = CPU_LOONGSON3A,
>>>>>>> +        .mmu_type = MMU_TYPE_R4000,
>>>>>>> +    },
>>>>>>> +    {
>>>>>>>            /* A generic CPU providing MIPS64 DSP R2 ASE features.
>>>>>>>               FIXME: Eventually this should be replaced by a real CPU model. */
>>>>>>>            .name = "mips64dspr2",
>>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Huacai Chen
>>>
> 

