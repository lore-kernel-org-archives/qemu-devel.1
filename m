Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5877C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82353208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82353208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heFch-0004qQ-Pt
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 05:14:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39435)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heFXy-0000XB-Rd
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:09:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heFWD-0002nU-Lm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:09:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heFWD-0002Wk-GI
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:07:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so5774825wre.7
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 02:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EX3ZdPVdYwHsJfI1gqJSGjN5uoaqhIFz8DprGDtRLCk=;
 b=pOrwSaiCqGzde1uJnonA44lddSK2I+aeHIffEWvhtd7v0Sl7ZnV/z50F0cKi6Wp7B2
 VYSVTJCPQjcdH0GYXkW5NPe+zpyq6Cz9ypVZGD8cV6iWqvoPzRMkWkFn5Ndhs2Bj1PiA
 wfyW1jhBWk0Nv9YGim+RNszod8Q6yA2HK5rJbI0bx4W9fjNUnGNQZrdDYViGxYeKV2H3
 drkW1LbMJ50qbeMDkz+xTxQnDr5faMalS4y2TNnafZYAtT2xRPaFW7X9xt5NnElzoMTJ
 PbskcMwxkHEeLXulbhSRLI2tM0VISf2iPVlLd0c56ndC1v4msARxfgm7m9n5iI2kRJ8m
 w2tg==
X-Gm-Message-State: APjAAAXlVKouJyIC3K+1o9MpM/48byuB/8HeRc3tVYvopHNygPi3BuA7
 OTPtn3BAC77fxSmzROgongnekXV3iyE=
X-Google-Smtp-Source: APXvYqyvgEPkGwk9P8TGBp+6PlnftfPV9o7++rnCaMDJGa00dzkrIjyOXeTZcXX3gFI4iB1DfZvELw==
X-Received: by 2002:adf:e311:: with SMTP id b17mr3649359wrj.11.1561108016634; 
 Fri, 21 Jun 2019 02:06:56 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id j189sm2986700wmb.48.2019.06.21.02.06.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 02:06:56 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20190621065242.32535-1-joel@jms.id.au>
 <6aec047c-81bd-e179-6fad-4bee896ea7a2@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <21bd02d0-d051-e730-bfb9-bca2f57babe8@redhat.com>
Date: Fri, 21 Jun 2019 11:06:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6aec047c-81bd-e179-6fad-4bee896ea7a2@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2] aspeed: Link SCU to the watchdog
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 10:25 AM, Cédric Le Goater wrote:
> On 21/06/2019 08:52, Joel Stanley wrote:
>> The ast2500 uses the watchdog to reset the SDRAM controller. This
>> operation is usually performed by u-boot's memory training procedure,
>> and it is enabled by setting a bit in the SCU and then causing the
>> watchdog to expire. Therefore, we need the watchdog to be able to
>> access the SCU's register space.
>>
>> This causes the watchdog to not perform a system reset when the bit is
>> set. In the future it could perform a reset of the SDMC model.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> 
> I was keeping this patch in my tree (hence the Sob) hoping that
> someone could find the time to study the reset question. But this 
> patch is useful as it is and I think we should merge it.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks,
> 
> C.
> 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> v2: rebase on upstream, rework commit message
>> ---
>>  hw/arm/aspeed_soc.c              |  2 ++
>>  hw/watchdog/wdt_aspeed.c         | 20 ++++++++++++++++++++
>>  include/hw/watchdog/wdt_aspeed.h |  1 +
>>  3 files changed, 23 insertions(+)
>>
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index a2ea8c748449..ddd5dfacd7d6 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -155,6 +155,8 @@ static void aspeed_soc_init(Object *obj)
>>                                sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
>>          qdev_prop_set_uint32(DEVICE(&s->wdt[i]), "silicon-rev",
>>                                      sc->info->silicon_rev);
>> +        object_property_add_const_link(OBJECT(&s->wdt[i]), "scu",
>> +                                       OBJECT(&s->scu), &error_abort);
>>      }
>>  
>>      sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
>> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
>> index 4a8409f0daf5..57fe24ae6b1f 100644
>> --- a/hw/watchdog/wdt_aspeed.c
>> +++ b/hw/watchdog/wdt_aspeed.c
>> @@ -44,6 +44,9 @@
>>  
>>  #define WDT_RESTART_MAGIC               0x4755
>>  
>> +#define SCU_RESET_CONTROL1              (0x04 / 4)
>> +#define    SCU_RESET_SDRAM              BIT(0)
>> +
>>  static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
>>  {
>>      return s->regs[WDT_CTRL] & WDT_CTRL_ENABLE;
>> @@ -222,6 +225,13 @@ static void aspeed_wdt_timer_expired(void *dev)
>>  {
>>      AspeedWDTState *s = ASPEED_WDT(dev);
>>  
>> +    /* Do not reset on SDRAM controller reset */
>> +    if (s->scu->regs[SCU_RESET_CONTROL1] & SCU_RESET_SDRAM) {

This would be cleaner as an static inlined function in
"hw/misc/aspeed_scu.h" IMO, maybe 'bool scu_sdram_is_reset()'.

Anyway the patch looks sane:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> +        timer_del(s->timer);
>> +        s->regs[WDT_CTRL] = 0;
>> +        return;
>> +    }
>> +
>>      qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
>>      watchdog_perform_action();
>>      timer_del(s->timer);
>> @@ -233,6 +243,16 @@ static void aspeed_wdt_realize(DeviceState *dev, Error **errp)
>>  {
>>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>>      AspeedWDTState *s = ASPEED_WDT(dev);
>> +    Error *err = NULL;
>> +    Object *obj;
>> +
>> +    obj = object_property_get_link(OBJECT(dev), "scu", &err);
>> +    if (!obj) {
>> +        error_propagate(errp, err);
>> +        error_prepend(errp, "required link 'scu' not found: ");
>> +        return;
>> +    }
>> +    s->scu = ASPEED_SCU(obj);
>>  
>>      if (!is_supported_silicon_rev(s->silicon_rev)) {
>>          error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
>> diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
>> index 88d8be4f78d6..daef0c0e230b 100644
>> --- a/include/hw/watchdog/wdt_aspeed.h
>> +++ b/include/hw/watchdog/wdt_aspeed.h
>> @@ -27,6 +27,7 @@ typedef struct AspeedWDTState {
>>      MemoryRegion iomem;
>>      uint32_t regs[ASPEED_WDT_REGS_MAX];
>>  
>> +    AspeedSCUState *scu;
>>      uint32_t pclk_freq;
>>      uint32_t silicon_rev;
>>      uint32_t ext_pulse_width_mask;
>>
> 
> 

