Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6429207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAqZBtQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6429207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQJD-0006qY-Us
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKQ4n-0002R3-IT; Mon, 21 Sep 2020 13:58:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKQ4k-0002CJ-0H; Mon, 21 Sep 2020 13:58:08 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so13743089wrs.5;
 Mon, 21 Sep 2020 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UlxmOjXuOR+ZkFFBxFLY+lAZ2WLFKoQ4QLYdAyvOkrI=;
 b=EAqZBtQLFQyYdnzJQeTbg5Z/67BBZQqtNtmD4B47InMD1RjhE9AObzntVtcpk7Hhss
 EFV1iDXzi88370Z0Jt3JUw/24xrNpAFWglkzR42SX5pcZLiugJ23+btwir5xRvu0a1us
 UY5Ajrx/ShhIRFuErrfEDJVxWEcznd2JMa4DELIw9i9D2qwh8zX3uvrmdEgBpMrAOzOf
 4dAzUjxFBAjIp0c5sLs7vs/RJU8ObFr1Vyt4WCRtD6nwsIoQSFJSySdmn6OEeEssFDFV
 TFKSolr/3kQ0AWDraRwm/TfOhAXBAQWm8x3VVDuJpwDR0KqKy8UvtZ473ebASuftqPug
 BBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UlxmOjXuOR+ZkFFBxFLY+lAZ2WLFKoQ4QLYdAyvOkrI=;
 b=mbCZZA01OP/P51omY3EBiZy49Cl1Pw6HzMwdG+I1vT9oS8sEGJuzcCusWyAZaIP853
 wrR0w+/ySe+liL9enY3nXq4d3PFnHH5/9+MaUskZby6bP9ktePh/tEigaOzYMK0VlNQq
 v8R9Gb1VW9Dp3Gf+LPt3kxESUkwvFs8WTFgcGKQ8OQwCqxtBfxJWckOD7Y2VgPwq5M+V
 XirlOV43WKnvHWnCzeO1A9AJmzRJJp3z9jG+WUXOP6VMlhFTR/ySG5nT5pIngfREvCnQ
 cifGsGkFdDa1TeSY8+IUwPIDt+WsrA+BTJpjqRgJSsvGfNefEEzZaakGLrm5qK3xDNUG
 3V+g==
X-Gm-Message-State: AOAM531zKB+l3ZTAJXC1og/YjNLL0j9tcS8UgtAWltcBIEHKOQCBGqbw
 j7jt5D2O6rjm8cpUOsgIY5DwA1ZeOCA=
X-Google-Smtp-Source: ABdhPJzVC2oNVI0hoRuzr1P7NMonkuQ8Yf6ON8YbBptXvSM+W8+3BspMzSEMkEBFHfyW+lbiAijlPw==
X-Received: by 2002:adf:eb8f:: with SMTP id t15mr916368wrn.417.1600711083837; 
 Mon, 21 Sep 2020 10:58:03 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id e1sm22781149wrp.49.2020.09.21.10.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 10:58:03 -0700 (PDT)
Subject: Re: [PATCH 4/6] sparc32-ledma: don't reference nd_table directly
 within the device
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-5-mark.cave-ayland@ilande.co.uk>
 <0ea7090a-34f0-d437-1c7d-34570b529943@amsat.org>
 <c9ae2d9d-4a4e-8b68-1f58-4e1fe3bbd55a@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4bab3a2c-919b-621e-5ba8-6a124f8c642e@amsat.org>
Date: Mon, 21 Sep 2020 19:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c9ae2d9d-4a4e-8b68-1f58-4e1fe3bbd55a@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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

On 9/21/20 7:08 PM, Mark Cave-Ayland wrote:
> On 21/09/2020 10:57, Philippe Mathieu-Daudé wrote:
> 
>> Hi Mark,
>>
>> On 9/20/20 10:20 AM, Mark Cave-Ayland wrote:
>>> Instead use qdev_set_nic_properties() to configure the on-board NIC at the
>>> sun4m machine level.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  hw/dma/sparc32_dma.c |  5 -----
>>>  hw/sparc/sun4m.c     | 21 +++++++++++++--------
>>>  2 files changed, 13 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
>>> index 2cbe331959..b643b413c5 100644
>>> --- a/hw/dma/sparc32_dma.c
>>> +++ b/hw/dma/sparc32_dma.c
>>> @@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>>>  {
>>>      LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
>>>      SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
>>> -    NICInfo *nd = &nd_table[0];
>>>  
>>> -    /* FIXME use qdev NIC properties instead of nd_table[] */
>>> -    qemu_check_nic_model(nd, TYPE_LANCE);
>>> -
>>> -    qdev_set_nic_properties(DEVICE(lance), nd);
>>>      object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
>>>      sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
>>>  }
>>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>>> index 947b69d159..ed5f3ccd9f 100644
>>> --- a/hw/sparc/sun4m.c
>>> +++ b/hw/sparc/sun4m.c
>>> @@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>>>  
>>>  static void *sparc32_dma_init(hwaddr dma_base,
>>>                                hwaddr esp_base, qemu_irq espdma_irq,
>>> -                              hwaddr le_base, qemu_irq ledma_irq)
>>> +                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
>>
>> Instead of passing NICInfo to sparc32_dma_init,
>> shouldn't you extract the lance code from it?
> 
> Hi Philippe,
> 
> I'm not sure I understand what you mean here? The sparc32-dma device is realised
> within the sparc32_dma_init() function and qdev_set_nic_properties() must be called
> before realise happens.
> 
> If you can explain a bit more about how you think it can be separated out then I can
> take a look.

Sorry I guess I got confused by the 2 different sparc32_dma_init()
functions.

Since ledma always expose lance, maybe you can use:

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 2cbe331959a..9a907a30373 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -336,18 +336,14 @@ static void sparc32_ledma_device_init(Object *obj)
                           "ledma-mmio", DMA_SIZE);

     object_initialize_child(obj, "lance", &ls->lance, TYPE_LANCE);
+    qdev_alias_all_properties(DEVICE(&ls->lance), obj);
 }

This way you set the properties directly on the ledma and only
have to sysbus_map lance.

> 
> 
> ATB,
> 
> Mark.
> 

