Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0AC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA420731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxxxCZC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA420731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTis1-0007tq-Fn
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiqy-0006sL-8w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiqw-0003jC-Uz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:18:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTiqw-0003j4-I5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:18:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id d15so1609763wrx.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wjzMsQFWMuczVHaxFD+2PR77xvg8KQSYCG6kk8sgW1g=;
 b=SxxxCZC/Z4tCrj8mycZuosYue2xu/qGwzVVeBz93UTxtVbM2T2Z+/GXVSttW0iPJXL
 FltdhydIit09HzSAg7lc+y6uwlzX5RLV/OZOtCTC8IyeX1OA8XuxNTk7pAyqNLfJTYUC
 bcpyIzcQA2O4k51YTOWAlQL5p1de2JklFxxLpBKTTOl+NkC+a4kwUHVX5qSfZrhbBDMB
 +zFSWtmTa3wzIcfmc5xDt15x3QYaVkDsGm3Bf9UiborfjGIGXe7LW1W7RmvOCzcGlr0T
 xJIgtBGalUlJ4/8V3Znxr1FH5D7vBBwx5c+UrShDpAUhjitGrpuT9ngxZnLUG74lSerH
 0J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wjzMsQFWMuczVHaxFD+2PR77xvg8KQSYCG6kk8sgW1g=;
 b=KjaEBh2bZjhWmaaStcHp1+JenBQKzpScRqOIc/inBIlt2WgnrgrRM2HdGoCmXawnvb
 WnXXmGztmTWTLK1kfDcl2SqmrLMNLDCtGAr4prBJdOxg4qozoZikd8R1wW+cc1CgLhur
 nvfPG2tuM3JTyD+LxERFSHaM+h6Z9m5XBiFWXn2Y48bBFEPm5KX7+ccIcdf0cpY0jEoF
 IyLha09CzMBHTFbbaMNfeHOCwJCPaRxeX/xiP5XAYcPUoSso2vL0iIgwZyKgc6BcErC7
 Lax1adjabfGolghxKqXLnXAlt0OIXpBMrqa0chgeIdUyHRQSjIspxats7+I5kYrXWM8W
 rFbg==
X-Gm-Message-State: AGi0PuZf0TQJNuzfSO/PMfIwaFoN62A8LYTVksyjHWMUyCX7/gp90a/T
 tvpVFCEuS8GOuM7PczAL6f/cgzsBYHo=
X-Google-Smtp-Source: APiQypI545fSNed9bdutxUgPk2eMDBm2ckLLgH0np77or7IqmxEB4vb/4Tyh7h25VigzxAJaXXKBpQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr38211789wrw.228.1588151880708; 
 Wed, 29 Apr 2020 02:18:00 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id x13sm6966550wmc.5.2020.04.29.02.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 02:18:00 -0700 (PDT)
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: Huacai Chen <chenhuacai@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
 <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
 <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
 <CAHiYmc5R8icimeJ3i=E-8_uUWpRMUUH67xZKFk04CrjgXKHgcQ@mail.gmail.com>
 <CAAhV-H6tTU0jLfFFotrfCE_4sQKB0UEhKbxoGQrOhqzVBvo35g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d7b79c9-8d95-93ef-e0c3-ddccf5b46a84@amsat.org>
Date: Wed, 29 Apr 2020 11:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6tTU0jLfFFotrfCE_4sQKB0UEhKbxoGQrOhqzVBvo35g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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

On 4/29/20 3:52 AM, Huacai Chen wrote:
> Hi, Philippe and Aleksandar,
> 
> I'm not refusing to change my patch, but I have two questions:
> 1, Why we should identify Loongson-3 to deliver IP3? It seems that
> deliver all IPs (IP2~IP7) unconditionally is harmless as well.
> 2, How to identify Loongson-3 by Config6/Config7? Loongson-3 is not
> the only processor which has Config6/Config7.
Please don't top-post on technical lists, it makes the conversation
harder to follow.

This code is modelling the device, not KVM.

Commit b1bd8b28cca is not very verbose. I wonder why not delivering all 
IRQs to kvm_mips_set_interrupt, that would make this patch simpler.

I think the problem in QEMU MIPS IRQ delivery is one implementation is 
in cpu_mips_irq_request() while another one (vectored IRQ) in 
cpu_mips_hw_interrupts_pending (see 138afb024bb) and KVM is also in the 
middle.

And I see you selected CP0C3_VInt in the R4 definition... so what is 
delivered here?

> 
> Huacai
> 
> On Wed, Apr 29, 2020 at 2:58 AM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>>
>> уто, 28. апр 2020. у 10:21 chen huacai <zltjiangshi@gmail.com> је написао/ла:
>>>
>>> Hi, Philippe,
>>>
>>> On Mon, Apr 27, 2020 at 5:57 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> On 4/27/20 11:33 AM, Huacai Chen wrote:
>>>>> Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
>>>>> IP2 delivery as well, because Loongson-3 based machine use both IRQ2

"IP3 delivery as well"?

>>>>> (CPU's IP2) and IRQ3 (CPU's IP3).
>>>>>
>>>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>>>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>>> ---
>>>>>   hw/mips/mips_int.c | 6 ++----
>>>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
>>>>> index 796730b..5526219 100644
>>>>> --- a/hw/mips/mips_int.c
>>>>> +++ b/hw/mips/mips_int.c
>>>>> @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
>>>>>       if (level) {
>>>>>           env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
>>>>>
>>>>> -        if (kvm_enabled() && irq == 2) {
>>>>> +        if (kvm_enabled() && (irq == 2 || irq == 3))
>>>>
>>>> Shouldn't we check env->CP0_Config6 (or Config7) has the required
>>>> feature first?
>>> I'm sorry that I can't understand IRQ delivery has something to do
>>> with Config6/Config7, to identify Loongson-3?
>>>
>>
>> Obviously, yes.
>>
>> Thanks,
>> Aleksandar
>>
>>
>>>>
>>>>>               kvm_mips_set_interrupt(cpu, irq, level);
>>>>> -        }
>>>>>
>>>>>       } else {
>>>>>           env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
>>>>>
>>>>> -        if (kvm_enabled() && irq == 2) {
>>>>> +        if (kvm_enabled() && (irq == 2 || irq == 3))
>>>>>               kvm_mips_set_interrupt(cpu, irq, level);
>>>>> -        }
>>>>>       }
>>>>>
>>>>>       if (env->CP0_Cause & CP0Ca_IP_mask) {
>>>>>
>>>
>>>
>>>
>>> --
>>> Huacai Chen
> 

