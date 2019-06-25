Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22B6C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8209720659
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 07:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+NMfU+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8209720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfg6V-0002KT-Rc
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 03:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41151)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfg5b-0001q0-Or
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfg5a-0002BF-Nc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:42:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfg5Z-00028Q-6D
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 03:42:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id x4so16611488wrt.6
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2s5Npqs6ABsXpmiSmq0845R3+8uM/BxBmNlwowaZrXc=;
 b=m+NMfU+SibqoI0A6jAPBPjUmDB+hrgDAou8uLr8n6tMuNfMpIFAPsSrdwD0X2sOw3M
 BUTYKSlt5m+FIcSNy/YU+CBvhlQ96ZzFRneVHMbZ5JYutKg/CX05WasO16PYov1Y04xu
 cah//Au0K0wgVFGy114AxcLODx0wNNKeKaSuaSBgtZq3zx08yrJyLCWr+6/+kOSB9lnu
 WDvb8x1N2dREP55IeY6NRWrg6vrmQd8b0pd57NP1NjLLfbwuDifBi6cyM3jdaxQnXuIe
 Au6E0LJZ1JobEjfYrB9nvuUFMilbIbmKumQXA7Duv24JrixhUNySxKfwEjweOhNHZgbS
 rkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=2s5Npqs6ABsXpmiSmq0845R3+8uM/BxBmNlwowaZrXc=;
 b=IyGS53hHl7k1KZajK0FXoUYSupl2Nn3gGxosZ3LdnhkM6SzDwtGMUZQ4IPPv2W21v8
 TrMHDZVqN9/LM6++lEzwfzcIXaWkYCJzIvWFi0Bk6+KIW4qRDbXjLDOmkwZQOA4swdTo
 pFOgZj7Onz9g76VRcGRKzomVm2KlNfBHECXgxXg2hOB8ta7RSYdr9fBqQOor/NDmfbk8
 fRC9mK41XE+z7JkOrFGlv2inc5dWY5+tw0VGNPWmcmCiTX6cTG21PCctPML79s4ZLn0C
 mk1VHony98U7YACfLG20R/vX1VTvkB83CnadauaQsNs/aSljNedJcgeqYxP6lTVuti4F
 9FQQ==
X-Gm-Message-State: APjAAAVOZ4JzniNXasKWKKTftqSfDj4xEpeRfWdYjRH/8VsVnwGxQUy+
 Sg9v723UN5F6lyyeSxSEiL8=
X-Google-Smtp-Source: APXvYqxtbnXehwQtdqYTpZ+37A6JyH9mkvTNlGkgONQ+3tpEyDGbwYIKIPo4qxRYMKlLzxPmXiZx3g==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr15688410wrw.177.1561448519441; 
 Tue, 25 Jun 2019 00:41:59 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id g10sm11363937wrw.60.2019.06.25.00.41.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 00:41:58 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-8-f4bug@amsat.org>
 <CAL1e-=gNKxSt9qAEGx4akJULMNE1KK2OF5X3wfSO=WUfnC5KSw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <cdf34023-c08a-c5f3-0bee-5998849536a7@amsat.org>
Date: Tue, 25 Jun 2019 09:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gNKxSt9qAEGx4akJULMNE1KK2OF5X3wfSO=WUfnC5KSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 07/10] hw/mips/gt64xxx_pci: Align the
 pci0-mem size
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 2:43 AM, Aleksandar Markovic wrote:
> 
> On Jun 25, 2019 12:44 AM, "Philippe Mathieu-Daudé" <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
>>
>> One byte is missing, use an aligned size.
>>
>>     (qemu) info mtree
>>     memory-region: pci0-mem
>>       0000000000000000-00000000fffffffe (prio 0, i/o): pci0-mem
>>                                       ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>>
>> ---
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>

Thanks!

> I agree with this change, but do we have similar situations in QEMU code
> elsewhere?

Good reflex :)

We have the Jazz boards:

address-space: rc4030-dma
  0000000000000000-00000000fffffffe (prio 0, i/o): rc4030.dma

address-space: dp8393x
  0000000000000000-00000000fffffffe (prio 0, i/o): rc4030.dma

>>  hw/mips/gt64xxx_pci.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
>> index 815ef0711d..2fa313f498 100644
>> --- a/hw/mips/gt64xxx_pci.c
>> +++ b/hw/mips/gt64xxx_pci.c
>> @@ -23,6 +23,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>  #include "qemu/log.h"
>>  #include "hw/hw.h"
>>  #include "hw/mips/mips.h"
>> @@ -1201,7 +1202,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
>>      dev = qdev_create(NULL, TYPE_GT64120_PCI_HOST_BRIDGE);
>>      d = GT64120_PCI_HOST_BRIDGE(dev);
>>      phb = PCI_HOST_BRIDGE(dev);
>> -    memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem",
> UINT32_MAX);
>> +    memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", 4 * GiB);
>>      address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
>>      phb->bus = pci_register_root_bus(dev, "pci",
>>                                       gt64120_pci_set_irq,
> gt64120_pci_map_irq,
>> --
>> 2.19.1
>>
>>
> 

