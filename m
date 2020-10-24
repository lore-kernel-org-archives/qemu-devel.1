Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18092C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DD221D41
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ey7ZorEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DD221D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQNI-0001KB-NY
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQLk-0008B9-G5
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:41:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWQLi-0005La-NP
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 16:41:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id i1so7064048wro.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6Mr17l8VfyhGrc0KNJNBlvGPa19WCLB3o3sh4voxDsk=;
 b=ey7ZorEJSwBIaKorhRz3PdHhYx3a/QAw6h38dJePkPceyF3w2zSup4vHUljyjM8K+5
 aFayYQpHduU0Qxieose9hyHvzZ2A5ZLhKiW0zdNVVeq/3shDVUinDjHH7992CCvKHG4G
 k8/U9e7h75xbV4xv2r90CsGrF909/fWhbf4PdnC3VskkxZvbIXA5fDxIDAmNa+fpqRs9
 qAz6fpxPB+QthCTn7OS7Wd2qehczn882O8jXpEb7/O4yFgiAyvBGNA8SFkfWlZ58v0HK
 hRNOjC9N9h2BN0EWaEjYneJO73B0M/fZFQH/McPe6i0kYUI5xIWCah87nXvSDSTJgYZK
 x7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Mr17l8VfyhGrc0KNJNBlvGPa19WCLB3o3sh4voxDsk=;
 b=ce/pIdXPqG2QMBcqPoQSQhj/kWvV1c/Hvo1r7gXn2FyOS6NLyj9tCBzu5SYuN7FPh2
 1XJNvfgt+cCEKncRN6qImTNimatIKxPd1ScAOtpJaV5QYDNYfQ9dT8spQJfsnnqCGbB6
 fmtuE1eiDZTBiFl2egA0rZEow8R5KRaGY5nW9T+9pWJXIrjicN1k1ZjEUqNJuMCJf0ix
 OlHCMi8P0XBhZ+I5gDwHQZ3IyXSnhU9L95UykuJI9y3JAXBCru0FzEMCvWJYC3S06Jty
 FAs/AI7zpy7jpMrRfCTC8jNrHtS10/neiDUZ7BhrgPZgwVQdStn6RRLmbx6/kFDxUEa/
 gR2Q==
X-Gm-Message-State: AOAM5327a2BQYfVfKrvBkgynqEoKUeXcHQX1vv0wumrW5Gm/vj3y9oLZ
 9I+jmhPYXN+BTU7x59hstio=
X-Google-Smtp-Source: ABdhPJyPpuZcGayxvjMWBHAhDWEAdV3EE7aZ3k9VK/mqnl3zOVV55ymlZlANrtsOxvIBHmh1LgrrmQ==
X-Received: by 2002:adf:e885:: with SMTP id d5mr9392237wrm.100.1603572073433; 
 Sat, 24 Oct 2020 13:41:13 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x81sm12574170wmb.11.2020.10.24.13.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:41:12 -0700 (PDT)
Subject: Re: [PATCH] sabre: increase number of PCI bus IRQs from 32 to 64
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 atar4qemu@gmail.com
References: <20201011081347.2146-1-mark.cave-ayland@ilande.co.uk>
 <eee17b95-c1ba-cb6b-f687-2ef6e87c80e0@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d89d2dac-484b-7e1c-9bed-27b929614e71@amsat.org>
Date: Sat, 24 Oct 2020 22:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <eee17b95-c1ba-cb6b-f687-2ef6e87c80e0@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 11:27 AM, Mark Cave-Ayland wrote:
> On 11/10/2020 09:13, Mark Cave-Ayland wrote:
> 
>> The rework of the sabre IRQs in commit 6864fa3897 "sun4u: update PCI 
>> topology to
>> include simba PCI bridges" changed the IRQ routing so that both PCI 
>> and legacy
>> OBIO IRQs are routed through the sabre PCI host bridge to the CPU.
>>
>> Unfortunately this commit failed to increase the number of PCI bus IRQs
>> accordingly meaning that access to the legacy IRQs OBIO (irqnum >= 
>> 0x20) would
>> overflow the PCI bus IRQ array causing strange failures running 
>> qemu-system-sparc64
>> in NetBSD.
>>
>> Reported-by: Harold Gutch <logix@foobar.franken.de>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1838658
>> Fixes: 6864fa3897 ("sun4u: update PCI topology to include simba PCI 
>> bridges")
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/pci-host/sabre.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
>> index 5ac6283623..ffdba1d865 100644
>> --- a/hw/pci-host/sabre.c
>> +++ b/hw/pci-host/sabre.c
>> @@ -396,7 +396,7 @@ static void sabre_realize(DeviceState *dev, Error 
>> **errp)
>>                                        pci_sabre_set_irq, 
>> pci_sabre_map_irq, s,
>>                                        &s->pci_mmio,
>>                                        &s->pci_ioport,
>> -                                     0, 32, TYPE_PCI_BUS);
>> +                                     0, 0x40, TYPE_PCI_BUS);
>>       pci_create_simple(phb->bus, 0, TYPE_SABRE_PCI_DEVICE);
> 
> Applied to my qemu-sparc branch.

FWIW I spent some time looking at this, and your patch is indeed
the simplest fix in the current state of this model.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> 
> ATB,
> 
> Mark.
> 


