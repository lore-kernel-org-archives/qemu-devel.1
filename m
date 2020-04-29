Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C29FC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEE82083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6hjytiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEE82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThut-0002JZ-Ez
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:18:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jThni-0000oB-HP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jThn4-0006Gp-3R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:10:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jThn3-0006CC-Le
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:09:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id f13so1299829wrm.13
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SQMvIY6Rzy196kWaMSU4wdT7eSSaYjqcVdc3MdEkhhg=;
 b=d6hjytiCqo1uJrhbU7HEJZgQg/57aPPrMpOmRFKWIYz8MY8HJbTPqzaailzc5B+IvC
 NsCWBoXzL3lydL2SaZ1tvusQfB8y2J4TzTa79apdTH5go6mz5H92t9AUu19hsafKHSdK
 twTDQLOJZMXUuE65haRlDn6g0a6MgMidw0MJH67xg+YdWlvfEOGdfDiEacZdwhyr0qqL
 CY2KtqAN8jRhN7dCRwM5hOrMSpIjserdDTMWXTqwzW4vGtLbXATmNy6f7GrA5Gtez0HE
 qYxh9DXhbBzub/1Cm7HgoSz+CgLoB6wAychOdDOD/WkhEXw3GA7qtchb1Zanynf5XGZ0
 6Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SQMvIY6Rzy196kWaMSU4wdT7eSSaYjqcVdc3MdEkhhg=;
 b=r4kuqHz4h6OrwcC34r2EitpAUFDqgkL3ycxhJIMdW/DiO0hP3w6tmdyfGZMYQEWSv6
 bbNRj0rMKxx/9BJjahKGMmdgH23VBeShm+WlpcYp54Yya5MW4ASOq7dYX5Nv/++m9fck
 mNaVmfsaRKb0Re1akb18HDEoleI4vKLevaXLmuZrfVA37i8N7yCPJ7HjSLAsSnrM4FLk
 6++J7QHh6psEe9/wkm/OSeDfmHnCE/eiLPpGqj1q8YMGbSUXg99cdc4pSQeGFX8cUD/G
 9cZgg+1JYpJTq9sMm7PdvFPY4VnsIZoTYGHRa2bXVWCwiZDMSBH0UgXAkrM+GjWYkQ98
 v68A==
X-Gm-Message-State: AGi0PublWLhronMSv6dxsfXUq41ToCNmQZAgrZsPGKLAwMexI16oPLxJ
 MYXJI6yyYKwwQVA8kKWlmfVxN66MqY0=
X-Google-Smtp-Source: APiQypLsRA7tqgtqgIlBT/QiXxLUEONlBYL/973MZfEfIW4ESjeA0OgZA5SnMWYPooYNd6E9g+Jjjw==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr36932431wrc.214.1588147795645; 
 Wed, 29 Apr 2020 01:09:55 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id u188sm6802684wmg.37.2020.04.29.01.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 01:09:54 -0700 (PDT)
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: Huacai Chen <chenhuacai@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
 <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
 <CABDp7Vq-YX0LWU3iM=oygpcKzoS8cmXG6mvTQ5Gm_PbQsQMAgw@mail.gmail.com>
 <CAHiYmc6zFjBtgXRv=8+dqnbDtZqKqiwSDwEi0wKqJmJnys_y0g@mail.gmail.com>
 <CAAhV-H6NFV7hbaOp8BwPck3FWm5ZHBpuoA9FDmN6tby5LcoTeg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a791f90b-a2a5-6665-59b5-212f98c7afc8@amsat.org>
Date: Wed, 29 Apr 2020 10:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6NFV7hbaOp8BwPck3FWm5ZHBpuoA9FDmN6tby5LcoTeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::441
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
Cc: chen huacai <zltjiangshi@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 5:51 AM, Huacai Chen wrote:
> Hi, Aleksandar,
> 
> I've tried translate.google.com, and documents are available here:
> Loongson-3A R1 (Loongson-3A1000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf
> (Chinese Version)
> 
> Loongson-3A R2 (Loongson-3A2000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)
> 
> Loongson-3A R3 (Loongson-3A3000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf
> (Chinese Version)
> User Manual Part 2:
> http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
> http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf
> (Chinese Version)
> 
> Loongson-3A R4 (Loongson-3A4000)
> User Manual Part 1:
> http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
> http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
> User Manual Part 2:
> I'm sorry that it is unavailable now.

Thanks for the translations!

Since we can only review Loongson-3A R3, are there specific features 
from R4 you need that are not available in R3?

> 
> On Wed, Apr 29, 2020 at 2:37 AM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>>
>> Huacai,
>>
>> Can you please do machine translation of the document?
>>
>> It can be done via translate.google.com (it accepts pdf files, but
>> does not have download feature, and workaround is to "print to pdf"...
>>
>> Thanks in advance!
>> Aleksandar
>>
>> уто, 28. апр 2020. у 10:26 chen huacai <zltjiangshi@gmail.com> је написао/ла:
>>>
>>> Hi, Philippe,
>>>
>>> On Tue, Apr 28, 2020 at 2:34 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Hi Huacai,
>>>>
>>>> On 4/27/20 11:33 AM, Huacai Chen wrote:
>>>>> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
>>>>> R1/R2. Loongson-3A R4 is the newest and its ISA is almost the superset
>>>>> of all others. To reduce complexity, we just define a "Loongson-3A" CPU
>>>>> which is corresponding to Loongson-3A R4. Loongson-3A has CONFIG6 and
>>>>> CONFIG7, so add their bit-fields as well.
>>>>
>>>> Is there a public datasheet for R4? (If possible in English).
>>> I'm sorry that we only have Chinese datasheet in www.loongson.cn.
>>>
>>>>
>>>>>
>>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>> ---
>>>>>   target/mips/cpu.h                | 28 ++++++++++++++++++++++
>>>>>   target/mips/internal.h           |  2 ++
>>>>>   target/mips/mips-defs.h          |  7 ++++--
>>>>>   target/mips/translate.c          |  2 ++
>>>>>   target/mips/translate_init.inc.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>>>>   5 files changed, 88 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
>>>>> index 94d01ea..0b3c987 100644
>>>>> --- a/target/mips/cpu.h
>>>>> +++ b/target/mips/cpu.h
>>>>> @@ -940,7 +940,35 @@ struct CPUMIPSState {
>>>>>   #define CP0C5_UFR          2
>>>>>   #define CP0C5_NFExists     0
>>>>>       int32_t CP0_Config6;
>>>>> +    int32_t CP0_Config6_rw_bitmask;
>>>>> +#define CP0C6_BPPASS          31
>>>>> +#define CP0C6_KPOS            24
>>>>> +#define CP0C6_KE              23
>>>>> +#define CP0C6_VTLBONLY        22
>>>>> +#define CP0C6_LASX            21
>>>>> +#define CP0C6_SSEN            20
>>>>> +#define CP0C6_DISDRTIME       19
>>>>> +#define CP0C6_PIXNUEN         18
>>>>> +#define CP0C6_SCRAND          17
>>>>> +#define CP0C6_LLEXCEN         16
>>>>> +#define CP0C6_DISVC           15
>>>>> +#define CP0C6_VCLRU           14
>>>>> +#define CP0C6_DCLRU           13
>>>>> +#define CP0C6_PIXUEN          12
>>>>> +#define CP0C6_DISBLKLYEN      11
>>>>> +#define CP0C6_UMEMUALEN       10
>>>>> +#define CP0C6_SFBEN           8
>>>>> +#define CP0C6_FLTINT          7
>>>>> +#define CP0C6_VLTINT          6
>>>>> +#define CP0C6_DISBTB          5
>>>>> +#define CP0C6_STPREFCTL       2
>>>>> +#define CP0C6_INSTPREF        1
>>>>> +#define CP0C6_DATAPREF        0
>>>>>       int32_t CP0_Config7;
>>>>> +    int64_t CP0_Config7_rw_bitmask;
>>>>> +#define CP0C7_NAPCGEN       2
>>>>> +#define CP0C7_UNIMUEN       1
>>>>> +#define CP0C7_VFPUCGEN      0
>>>>>       uint64_t CP0_LLAddr;
>>>>>       uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>>>>>       int32_t CP0_MAARI;
>>>>> diff --git a/target/mips/internal.h b/target/mips/internal.h
>>>>> index 1bf274b..7853cb1 100644
>>>>> --- a/target/mips/internal.h
>>>>> +++ b/target/mips/internal.h
>>>>> @@ -36,7 +36,9 @@ struct mips_def_t {
>>>>>       int32_t CP0_Config5;
>>>>>       int32_t CP0_Config5_rw_bitmask;
>>>>>       int32_t CP0_Config6;
>>>>> +    int32_t CP0_Config6_rw_bitmask;
>>>>>       int32_t CP0_Config7;
>>>>> +    int32_t CP0_Config7_rw_bitmask;
>>>>>       target_ulong CP0_LLAddr_rw_bitmask;
>>>>>       int CP0_LLAddr_shift;
>>>>>       int32_t SYNCI_Step;
>>>>> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
>>>>> index a831bb4..c2c96db 100644
>>>>> --- a/target/mips/mips-defs.h
>>>>> +++ b/target/mips/mips-defs.h
>>>>> @@ -51,8 +51,9 @@
>>>>>    */
>>>>>   #define INSN_LOONGSON2E   0x0001000000000000ULL
>>>>>   #define INSN_LOONGSON2F   0x0002000000000000ULL
>>>>> -#define INSN_VR54XX       0x0004000000000000ULL
>>>>> -#define INSN_R5900        0x0008000000000000ULL
>>>>> +#define INSN_LOONGSON3A   0x0004000000000000ULL
>>>>> +#define INSN_VR54XX       0x0008000000000000ULL
>>>>> +#define INSN_R5900        0x0010000000000000ULL
>>>>>   /*
>>>>>    *   bits 56-63: vendor-specific ASEs
>>>>>    */
>>>>> @@ -94,6 +95,8 @@
>>>>>   /* Wave Computing: "nanoMIPS" */
>>>>>   #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
>>>>>
>>>>> +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
>>>>> +
>>>>>   /*
>>>>>    * Strictly follow the architecture standard:
>>>>>    * - Disallow "special" instruction handling for PMON/SPIM.
>>>>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>>>>> index 25b595a..2caf4cb 100644
>>>>> --- a/target/mips/translate.c
>>>>> +++ b/target/mips/translate.c
>>>>> @@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
>>>>>       env->CP0_Config5 = env->cpu_model->CP0_Config5;
>>>>>       env->CP0_Config5_rw_bitmask = env->cpu_model->CP0_Config5_rw_bitmask;
>>>>>       env->CP0_Config6 = env->cpu_model->CP0_Config6;
>>>>> +    env->CP0_Config6_rw_bitmask = env->cpu_model->CP0_Config6_rw_bitmask;
>>>>>       env->CP0_Config7 = env->cpu_model->CP0_Config7;
>>>>> +    env->CP0_Config7_rw_bitmask = env->cpu_model->CP0_Config7_rw_bitmask;
>>>>>       env->CP0_LLAddr_rw_bitmask = env->cpu_model->CP0_LLAddr_rw_bitmask
>>>>>                                    << env->cpu_model->CP0_LLAddr_shift;
>>>>>       env->CP0_LLAddr_shift = env->cpu_model->CP0_LLAddr_shift;
>>>>> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
>>>>> index 6d145a9..a32412d 100644
>>>>> --- a/target/mips/translate_init.inc.c
>>>>> +++ b/target/mips/translate_init.inc.c
>>>>> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =
>>>>>           .mmu_type = MMU_TYPE_R4000,
>>>>>       },
>>>>>       {
>>>>> +        .name = "Loongson-3A",
>>>>> +        .CP0_PRid = 0x14C000,
>>>>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
>>>>> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
>>>>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
>>>>> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
>>>>> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
>>>>> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
>>>>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
>>>>> +        .CP0_Config2 = MIPS_CONFIG2,
>>>>> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
>>>>> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
>>>>> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
>>>>> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
>>>>> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
>>>>> +        .CP0_Config4_rw_bitmask = 0,
>>>>> +        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_NFExists) | (1 << 18),
>>>>> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
>>>>> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
>>>>> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
>>>>> +        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) | (1 << CP0C6_SFBEN) |
>>>>> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>> +        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
>>>>> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) | (1 << CP0C6_LASX) |
>>>>> +                                  (1 << CP0C6_SSEN) | (1 << CP0C6_DISDRTIME) |
>>>>> +                                  (1 << CP0C6_PIXNUEN) | (1 << CP0C6_SCRAND) |
>>>>> +                                  (1 << CP0C6_LLEXCEN) | (1 << CP0C6_DISVC) |
>>>>> +                                  (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
>>>>> +                                  (1 << CP0C6_PIXUEN) | (1 << CP0C6_DISBLKLYEN) |
>>>>> +                                  (1 << CP0C6_UMEMUALEN) | (1 << CP0C6_SFBEN) |
>>>>> +                                  (1 << CP0C6_FLTINT) | (1 << CP0C6_VLTINT) |
>>>>> +                                  (1 << CP0C6_DISBTB) | (3 << CP0C6_STPREFCTL) |
>>>>> +                                  (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
>>>>> +        .CP0_Config7 = 0,
>>>>> +        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) | \
>>>>> +                                  (1 << CP0C7_VFPUCGEN),
>>>>> +        .CP0_LLAddr_rw_bitmask = 1,
>>>>> +        .SYNCI_Step = 16,
>>>>> +        .CCRes = 2,
>>>>> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
>>>>> +        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
>>>>> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
>>>>> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64),
>>>>> +        .CP1_fcr31 = 0,
>>>>> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>>>>> +        .SEGBITS = 48,
>>>>> +        .PABITS = 48,
>>>>> +        .insn_flags = CPU_LOONGSON3A,
>>>>> +        .mmu_type = MMU_TYPE_R4000,
>>>>> +    },
>>>>> +    {
>>>>>           /* A generic CPU providing MIPS64 DSP R2 ASE features.
>>>>>              FIXME: Eventually this should be replaced by a real CPU model. */
>>>>>           .name = "mips64dspr2",
>>>>>
>>>
>>>
>>>
>>> --
>>> Huacai Chen
> 

