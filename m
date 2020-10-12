Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D618C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E40C208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANoYbZyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E40C208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRt4i-0004Fl-Vt
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRt36-0003JM-Vk; Mon, 12 Oct 2020 04:19:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRt33-0006IB-Tl; Mon, 12 Oct 2020 04:19:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so18060703wrp.10;
 Mon, 12 Oct 2020 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TBVtEIOPaf3BKOl2HmBXMs84E8Ai4CEarpJhljrr4RI=;
 b=ANoYbZyDgg/2oSOqUlCCTcW4xDapBS/DHQLwVN6bIgqheiNmLx8H0vrhISh2fRIaGQ
 k26bs9i3+0IuEHwfnLKjgCPb1/2JDc8jejbni1mNE0hLiNMCKLxLJbiSHc3SevMAcMmz
 GUeYkc8mn7NmneeymDdp5vqudC1ZxdYEIwkLHthBxBIxNvBiJJ63qkHEKGd+bBPQV2i6
 K1EX7emazCo+gGCyHXLANJJu3fH7lVyJ9mPhZHXpYovN8iY3bdsJG7pWPRhArOPpGS0w
 jyvgLLG17hMSLr5jDHM+YDDFLXDbaEXmWS35QJU4FiIgcyR9lirzgPQ3RTYDUDXMp684
 OZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TBVtEIOPaf3BKOl2HmBXMs84E8Ai4CEarpJhljrr4RI=;
 b=XQ5SMVkq39flAgVQq1igpC3kL3MRBdOOvpLTUC+Wbvlmjwlzq3twWIv/3eveA1+UTw
 LqQy5BpWRO5BJRJ6zzrF3TvFGHESRzfv1d2oUxbUwLlr2EnevP6J80isU//J86ptpOeg
 E7yEH4qISYIKrQXM0mYMqfnOfpmgQggQdUmHiP69fkvMXy4B9rn7vDAI80lLrk4GffUH
 mRMMy17LJkKT15ktWkZf4dCE7iWEPAMjiicaMYjj7HJDu1qtLkh/SLPp3WoPcFx1Bv/v
 kT9E5/FGsSo8XYk/yH5peZcjmg4s8jQ526Bg8xeYHZduBaS1FveelMHNjyEE98VnV3b7
 dSQQ==
X-Gm-Message-State: AOAM533L+fPtovafAwIpBRAJpVxKAwma7To0gV00kOY1KWfGNGJHXT3d
 8cD9ZV0kR2/pNjd/WJX/uDYJE6SdWdE=
X-Google-Smtp-Source: ABdhPJxEqgx3fyzAfPkN7NoTtFQOapn1JChdA5kPpXxBRGewMjjpDILxOdJ4hdRX8VCW+My4NAnVrA==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr28233141wrw.389.1602490751284; 
 Mon, 12 Oct 2020 01:19:11 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q4sm23503822wru.65.2020.10.12.01.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 01:19:10 -0700 (PDT)
Subject: Re: [PATCH 2/4] hw/pci-host/prep: Remove legacy PReP machine
 temporary workaround
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201012071906.3301481-1-f4bug@amsat.org>
 <20201012071906.3301481-3-f4bug@amsat.org>
 <4822e2ff-95a1-ce6e-574d-ae980c2c8abc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6af814b6-b452-895f-dd8e-d46631e83361@amsat.org>
Date: Mon, 12 Oct 2020 10:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <4822e2ff-95a1-ce6e-574d-ae980c2c8abc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 9:28 AM, Thomas Huth wrote:
> On 12/10/2020 09.19, Philippe Mathieu-Daudé wrote:
>> The legacy PReP machine has been removed in commit b2ce76a0730
>> ("hw/ppc/prep: Remove the deprecated "prep" machine and the
>> OpenHackware BIOS"). This temporary workaround is no more
>> required, remove it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/prep.c | 32 +++++++++++---------------------
>>   1 file changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
>> index 80dfb67da43..064593d1e52 100644
>> --- a/hw/pci-host/prep.c
>> +++ b/hw/pci-host/prep.c
>> @@ -75,7 +75,6 @@ struct PRePPCIState {
>>       RavenPCIState pci_dev;
>>   
>>       int contiguous_map;
>> -    bool is_legacy_prep;
>>   };
>>   
>>   #define BIOS_SIZE (1 * MiB)
>> @@ -229,24 +228,18 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
>>       MemoryRegion *address_space_mem = get_system_memory();
>>       int i;
>>   
>> -    if (s->is_legacy_prep) {
>> -        for (i = 0; i < PCI_NUM_PINS; i++) {
>> -            sysbus_init_irq(dev, &s->pci_irqs[i]);
>> -        }
>> -    } else {
>> -        /*
>> -         * According to PReP specification section 6.1.6 "System Interrupt
>> -         * Assignments", all PCI interrupts are routed via IRQ 15
>> -         */
>> -        s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
>> -        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
>> -                                &error_fatal);
>> -        qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
>> -        sysbus_init_irq(dev, &s->or_irq->out_irq);
>> +    /*
>> +     * According to PReP specification section 6.1.6 "System Interrupt
>> +     * Assignments", all PCI interrupts are routed via IRQ 15.
>> +     */
> 
> Since you're changing the indentation of these lines anyway, I think you
> could also simply squash patch 1 into this one here (just a matter of taste,
> though).

Then the diff is not trivial to review :/

> 
>> +    s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
>> +    object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
>> +                            &error_fatal);
>> +    qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
>> +    sysbus_init_irq(dev, &s->or_irq->out_irq);
>>   
>> -        for (i = 0; i < PCI_NUM_PINS; i++) {
>> -            s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
>> -        }
>> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>> +        s->pci_irqs[i] = qdev_get_gpio_in(DEVICE(s->or_irq), i);
>>       }
>>   
>>       qdev_init_gpio_in(d, raven_change_gpio, 1);
>> @@ -403,9 +396,6 @@ static Property raven_pcihost_properties[] = {
>>       DEFINE_PROP_UINT32("elf-machine", PREPPCIState, pci_dev.elf_machine,
>>                          EM_NONE),
>>       DEFINE_PROP_STRING("bios-name", PREPPCIState, pci_dev.bios_name),
>> -    /* Temporary workaround until legacy prep machine is removed */
>> -    DEFINE_PROP_BOOL("is-legacy-prep", PREPPCIState, is_legacy_prep,
>> -                     false),
>>       DEFINE_PROP_END_OF_LIST()
>>   };
>>   
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!

