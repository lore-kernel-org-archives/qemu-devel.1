Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B1C206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXZG/Jdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B1C206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9DD-0005hw-7c
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj9Bx-0004da-LY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:27:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34733)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj9Bw-0003bL-Sb
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:27:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id r7so4108443wro.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=69CwjwJJLC41nXkjD+0k/B3NrwJNBgAQC1krp6ngFPI=;
 b=TXZG/JdgNYDQ/fBE3Cw9hk6vmI2jKQM6RceqkRlYMZHlfHa7+NP8BT6ZpryXW+tKme
 dIIrEFg5BHmTA+9cGQb3qELV6qmJBdlYhL/394O8eMvMlUUym2dQ5XjmuREsteWaokJ/
 //WTxwlt1qiA4vzdueY9SuWLyGfu+mSSsTG2rnhtMcRZ3jbjrGnuafdws6xHgF8Fj8Na
 LSW+aN53IxrAySSj+259R3v8HdSNHtf+0ndULy330UYOS5mgKRGvcn+seTyeJFBJAH5E
 aCRz7CyYlJxkqNTsn6JTPspcObFx2pykyXN2uKfReVe+wMUWSyoDwsh8seNwixa/iOz2
 R6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=69CwjwJJLC41nXkjD+0k/B3NrwJNBgAQC1krp6ngFPI=;
 b=p0se80s006JFD0eCtZkI06ZsSa+kZwy5ElCVn7QQPrYzjBLBeNwmpHqRRkFe80YXQx
 RCUq4zFKrOX0+adH93oTYw0qvDH0HxFIadmL/84R5JIes3K7/3r1odEUopdK4TJjC7N2
 8iJqLHjoqIR1K3/mjuv7M9oCCFdMo3MJ0l867w8i8x3OymWCVPkIzLtrkcUBkOon7DGf
 me3FhYoy+sFz69gkwiySiptfLpFDAoMY4GY34c4BdqE8AVFSLQJrjLsUWJR4TJeGwi6e
 H11DbNJE+VlK2rHP2fc3i9UwZRItW6IYd24KyX7cPpByu17lIuBZGWIcRezayrT2Ralx
 yjIw==
X-Gm-Message-State: AOAM530hyfMWLBphICM+aS+JG5v4oRJ2e+AZRqtVsz+cGpV+MSYxW8lu
 QwoUGWVQ9hfN7TS0YMmx4AI=
X-Google-Smtp-Source: ABdhPJxBfdmEaqxSv1EjgwRMczwdJG3SrcWK4BcYdi4D3HZOQiDMv7qeQd48gP5dfX/oIUPGAl6ozg==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr6056778wrt.341.1591828041170; 
 Wed, 10 Jun 2020 15:27:21 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id u3sm1608695wrw.89.2020.06.10.15.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 15:27:20 -0700 (PDT)
Subject: Re: [PATCH] net: tulip: Set PCI revision to match dec21143
To: Sven Schnelle <svens@stackframe.org>
References: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
 <203b5328-b473-119c-4122-8f775f390ad0@amsat.org>
 <20200610211310.GA26448@t470p.stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0ce463c4-164a-9618-a8dc-001273b1fde0@amsat.org>
Date: Thu, 11 Jun 2020 00:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200610211310.GA26448@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org,
 Marek Vasut <marek.vasut@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 11:13 PM, Sven Schnelle wrote:
> On Mon, Jun 08, 2020 at 12:17:11AM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> Hi Sven, could you review thiw one-line patch?
>>
>> On 4/18/20 2:25 AM, Marek Vasut wrote:
>>> The tulip driver claims to emulate dec21143 and it does not emulate dec21142.
>>> The dec21142 and dec21143 can be discerned by the PCI revision register,
>>> where dec21142 reports value < 0x20 and dec21143 value >= 0x20. E.g. the
>>> U-Boot 'tulip' driver also only supports dec21143 and verifies that the
>>> PCI revision ID is >= 0x20, otherwise refuses to operate such a card.
>>>
>>> This patch sets the PCI revision ID to 0x20 to match the dec21143 and
>>> thus also permits e.g. U-Boot to work with the tulip emulation.
>>>
>>> Fixes: 34ea023d4b95 ("net: add tulip (dec21143) driver")
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>> Cc: Marc-AndrÃƒÂ© Lureau <marcandre.lureau@redhat.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>> Cc: Prasad J Pandit <pjp@fedoraproject.org>
>>> Cc: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>  hw/net/tulip.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>>> index 1295f51d07..ffb6c2479a 100644
>>> --- a/hw/net/tulip.c
>>> +++ b/hw/net/tulip.c
>>> @@ -962,6 +962,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
>>>  
>>>      pci_conf = s->dev.config;
>>>      pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
>>> +    /* Anything with revision < 0x20 is DC21142, anything >= 0x20 is DC21143 */
>>> +    pci_conf[PCI_REVISION_ID] = 0x20;
>>>  
>>>      s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
>>>      tulip_fill_eeprom(s);
>>>
>>
> 
> The intel datasheet for the DEC21143 lists only Rev IDs > 30 for this particular family:
> 
> 21143-PB,TB,PC,TC - 0x30
> 21143-PD,TD - x041
> 
> but maybe older DEC chips used 0x20 - don't know. The most interesting question is
> whether ancient OS' like HP-UX or Windows XP would still work with this patch, but
> i don't have test images at hand right now.

So the question is whether your HP-UX/WinXP images also boot with a
DEC21142 (you aimed to model a DEC21143, and it is tested anyway).

Marek, suggestion:

Make pci_tulip_realize() abstract, add dec21142 and dec21143 models as
you suggested, making 'tulip' an alias of dec21142 for backward
compatibility. You can then use the dec21143.

