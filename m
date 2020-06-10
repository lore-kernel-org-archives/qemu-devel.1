Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319A4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E769820760
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDCoH0gN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E769820760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj9OK-0002gk-7L
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marek.vasut@gmail.com>)
 id 1jj9Nd-0002B7-DT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:39:33 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46780)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marek.vasut@gmail.com>)
 id 1jj9Nc-00062Z-Ds
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 18:39:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id x6so4071553wrm.13
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ctwy84B0Ps38b/n7BLFAgvQzJxu3kVJsUqV8zLFHdok=;
 b=SDCoH0gNTHvy7VzkwYsA45b0UW2vt1Aimf7/OE6GxP01CfSekxs8KLwAZk9jsdqO2B
 +ayxfJ4kJ4UTVbJWghJFf7D8+RSq7RhD302vBTPvcAYknRvJKSYeQZlrmqem/cgMmENr
 4zUhrWLGiaVxeb98FEgUD1BFUj/gGtSHfMxDGfHapKqHznnD8iRE039K2qiVgoepaGS/
 LRwwoGEc0z48CUMyKLfIOxoEim6J4E5C7K2iozyXQ+o2wP29q/3jVcKnkK0UhD/C1ZcH
 j9WLcGAbjOt+g1/OOHouaaqXVB22ry6yVPgoRDqBzQ8U65GMcC8eieX224j6UYgIOK/d
 6pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ctwy84B0Ps38b/n7BLFAgvQzJxu3kVJsUqV8zLFHdok=;
 b=l0CFSP7nqt11IfGEuYMrfHDo0EOZ8v++UkolN2H20oIQC2lNkUEZ6dH35GmD8NJ8ti
 1CBJz2fx/JTll6yUiQOz3cjgyG6qxvbfq3XbQfNvEHDUsuPV5JkK225HwJ2RdAw2YoIk
 MYciZ/UyYVIog+TZcId2SuJY9lf3V32Ui03ndF5b8NL8B/RAQaf8+YhsVUHHFiSoM5FG
 CxEmPx5LvWkXSuYNKx5b9iMQ8RVZt7mCAouQu1nhIXUdg4jPYHX4EapkY0cQLL3bMQWf
 4AdpgR3dCrjHdS5RZLnOkosXcwLp8QdSNjgLp/j49gYK56RRXafOqKXIAXDFg/c7Jg8l
 WiDQ==
X-Gm-Message-State: AOAM530tomtj9D/kExv4j/qXiwjkj53k2z6fpsCYOdP0WvagFu/y6CJT
 uU1yZVEE7LvjEHcre6NO0vY=
X-Google-Smtp-Source: ABdhPJz4mRCOIbbVi8I5ZHz3XctFHLrxbxYCGb6B0keVcWE8vB7qDjYPpxkyZST0ag+d8cX4Rhnq0g==
X-Received: by 2002:a5d:6b86:: with SMTP id n6mr5897733wrx.167.1591828765138; 
 Wed, 10 Jun 2020 15:39:25 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
 by smtp.gmail.com with ESMTPSA id
 b8sm1765168wrm.35.2020.06.10.15.39.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 15:39:24 -0700 (PDT)
Subject: Re: [PATCH] net: tulip: Set PCI revision to match dec21143
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Sven Schnelle <svens@stackframe.org>
References: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
 <203b5328-b473-119c-4122-8f775f390ad0@amsat.org>
 <20200610211310.GA26448@t470p.stackframe.org>
 <0ce463c4-164a-9618-a8dc-001273b1fde0@amsat.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <dd0c0b6f-a857-464b-cbb2-4f9588857b63@gmail.com>
Date: Thu, 11 Jun 2020 00:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <0ce463c4-164a-9618-a8dc-001273b1fde0@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=marek.vasut@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 12:27 AM, Philippe Mathieu-Daudé wrote:
> On 6/10/20 11:13 PM, Sven Schnelle wrote:
>> On Mon, Jun 08, 2020 at 12:17:11AM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>>> Hi Sven, could you review thiw one-line patch?
>>>
>>> On 4/18/20 2:25 AM, Marek Vasut wrote:
>>>> The tulip driver claims to emulate dec21143 and it does not emulate dec21142.
>>>> The dec21142 and dec21143 can be discerned by the PCI revision register,
>>>> where dec21142 reports value < 0x20 and dec21143 value >= 0x20. E.g. the
>>>> U-Boot 'tulip' driver also only supports dec21143 and verifies that the
>>>> PCI revision ID is >= 0x20, otherwise refuses to operate such a card.
>>>>
>>>> This patch sets the PCI revision ID to 0x20 to match the dec21143 and
>>>> thus also permits e.g. U-Boot to work with the tulip emulation.
>>>>
>>>> Fixes: 34ea023d4b95 ("net: add tulip (dec21143) driver")
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>> Cc: Marc-AndrÃƒÂ© Lureau <marcandre.lureau@redhat.com>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>> Cc: Prasad J Pandit <pjp@fedoraproject.org>
>>>> Cc: Sven Schnelle <svens@stackframe.org>
>>>> ---
>>>>  hw/net/tulip.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
>>>> index 1295f51d07..ffb6c2479a 100644
>>>> --- a/hw/net/tulip.c
>>>> +++ b/hw/net/tulip.c
>>>> @@ -962,6 +962,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
>>>>  
>>>>      pci_conf = s->dev.config;
>>>>      pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
>>>> +    /* Anything with revision < 0x20 is DC21142, anything >= 0x20 is DC21143 */
>>>> +    pci_conf[PCI_REVISION_ID] = 0x20;
>>>>  
>>>>      s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
>>>>      tulip_fill_eeprom(s);
>>>>
>>>
>>
>> The intel datasheet for the DEC21143 lists only Rev IDs > 30 for this particular family:
>>
>> 21143-PB,TB,PC,TC - 0x30
>> 21143-PD,TD - x041
>>
>> but maybe older DEC chips used 0x20 - don't know. The most interesting question is
>> whether ancient OS' like HP-UX or Windows XP would still work with this patch, but
>> i don't have test images at hand right now.
> 
> So the question is whether your HP-UX/WinXP images also boot with a
> DEC21142 (you aimed to model a DEC21143, and it is tested anyway).
> 
> Marek, suggestion:
> 
> Make pci_tulip_realize() abstract, add dec21142 and dec21143 models as
> you suggested, making 'tulip' an alias of dec21142 for backward
> compatibility. You can then use the dec21143.

I don't have any way to test dec21142 , I only have dec21143 support in
U-Boot. U-Boot actually checks for this revision field and does not work
with dec21142 , so these older models must be somehow incompatible.
Hence, if we model only the dec21143 anyway, we should set that revision
ID to model it fully.

