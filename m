Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27A4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C5B20772
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C5B20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OMo-0003H7-QH
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k5OM2-0002i2-AR; Tue, 11 Aug 2020 03:05:50 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:54875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k5OM0-0000J5-6Z; Tue, 11 Aug 2020 03:05:50 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.114])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 5B59B55F4896;
 Tue, 11 Aug 2020 09:05:42 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 11 Aug
 2020 09:05:41 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0012edcea11-bf7b-4ef4-8153-29df96bb1c3b,
 2C2967226A14075CAA5C60435B1EAB2FE94086EE) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 08/19] aspeed/sdhci: Fix reset sequence
To: Joel Stanley <joel@jms.id.au>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-9-clg@kaod.org>
 <CACPK8Xcy-OzbQ4oiLaq96VzROSsmnmSAa0dytRcCVp2ot+mQnw@mail.gmail.com>
 <6ed71987-6247-2098-4e48-9c5d59a74353@kaod.org>
 <CACPK8Xfx+TQezEisV9Tbew7SpoGu0N-tvwNWq+3-t1Y1bA6dXQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2261f934-37b4-6425-ccae-8f53f7c6e7ac@kaod.org>
Date: Tue, 11 Aug 2020 09:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xfx+TQezEisV9Tbew7SpoGu0N-tvwNWq+3-t1Y1bA6dXQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: eeed7dde-532b-49c5-92c7-666068a257e3
X-Ovh-Tracer-Id: 4847562050579237670
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeelgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 03:05:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Eddie James <eajames@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/11/20 1:20 AM, Joel Stanley wrote:
> On Mon, 10 Aug 2020 at 17:16, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 8/7/20 1:42 AM, Joel Stanley wrote:
>>> On Thu, 6 Aug 2020 at 13:21, Cédric Le Goater <clg@kaod.org> wrote:
>>>>
>>>> BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
>>>> the bit is cleared by HW. Add definitions for the default value of
>>>> this register and fix the reset sequence by clearing the RESET bit.
>>>
>>> This is mentioned in the datasheet but I couldn't find if software
>>> depends on the behaviour. Were you just trying to make the model more
>>> accurate?
>>>
>>>>  #define ASPEED_SDHCI_INFO            0x00
>>>> -#define  ASPEED_SDHCI_INFO_RESET     0x00030000
>>>> +#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
>>>> +#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
>>>> +#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
>>>>  #define ASPEED_SDHCI_DEBOUNCE        0x04
>>>>  #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>>>>  #define ASPEED_SDHCI_BUS             0x08
>>>> @@ -67,6 +69,9 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
>>>>      AspeedSDHCIState *sdhci = opaque;
>>>>
>>>>      switch (addr) {
>>>> +    case ASPEED_SDHCI_INFO:
>>>> +        sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
>>>
>>> I think bits 24 and 25 should be writable too?
>>>
>>>         sdhci->regs[TO_REG(addr)] = (uint32_t)val &
>>> ~(ASPEED_SDHCI_INFO_RESET | ASPEED_SDHCI_INFO_SLOT10 |
>>> ASPEED_SDHCI_INFO_SLOT1);
>>>
>>>> +
>>>>      case ASPEED_SDHCI_SDIO_140:
>>>>          sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
>>>>          break;
>>>> @@ -155,7 +160,8 @@ static void aspeed_sdhci_reset(DeviceState *dev)
>>>>      AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
>>>>
>>>>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
>>>> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
>>>> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =
>>>> +        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;
>>>
>>> If we want to be super strict this is true for the "sd" devices, but
>>> the "emmc" device in the ast2600 only sets slot0. I don't think this
>>> distinction is important to model though.
>>
>> Both slots seems to be activated on all three SoCs. Am I looking at the
>> wrong controller ?
> 
> Yes. the "SD/SDIO Host Controller" have both slots. The "eMMC
> controller" at 0x1E750000 on the ast2600 has just the one slot.

I forgot that one.

> We have a property for the number of slots, so we could do something like this:
> 
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -159,12 +159,15 @@ static void aspeed_sdhci_realize(DeviceState
> *dev, Error **errp)
>  static void aspeed_sdhci_reset(DeviceState *dev)
>  {
>      AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
> +    uint32_t slots = ASPEED_SDHCI_INFO_SLOT0;
> 
>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> 
> +    if (sdhci->num_slots == 2)
> +        slots |= ASPEED_SDHCI_INFO_SLOT1;
> +

I think this is fine. The alternative would be an object class but it
would be a bit overkill. 

Thanks,

C. 
  
>      /* Same default value on AST2400, AST2500 and AST2600 SoCs */
> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =
> -        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;
> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = slots;
>      sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
>  }
> 


