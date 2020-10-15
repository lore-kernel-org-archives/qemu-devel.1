Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9172073A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E04ckrM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9172073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT86s-0002zG-5f
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT7ni-0003e5-2u; Thu, 15 Oct 2020 14:16:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT7ng-0003fE-7T; Thu, 15 Oct 2020 14:16:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id p15so77272wmi.4;
 Thu, 15 Oct 2020 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yqQR97izdfxu1MtO/d3QJBJlyzmjifyUoAYszApGct4=;
 b=E04ckrM9iy0XRNxQe+ArtpR2J0ZjhIGYQf+c1+aPE044xGjNPs1EwWDTvGHT/3pN9b
 ugM8ezDJmOXC6jAMJcqrrQFp42vOB+/ywvJ/FY+q87KtcWD1Pu7A9Gyv9vn1RXwmqWrg
 Yy7zoRLEpWxyezlBAgDNBR3I18HJOFRcjlGoAVQ3sntXJGqMJSrHeS+8hUipdfKuDl8B
 QxPeNGVGrE5WkUJaElejupf2qTGd+BVHPzZGLHXhkA+Pd6Qu/I94CuoxsK0QcsSz8J1A
 PUtPdIbXGUKgzPSR53/GFoEo5mKW+W8Ss8dRgWOnl/mzR+DZwq7eEB3oXFDzN53XPuHr
 PHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yqQR97izdfxu1MtO/d3QJBJlyzmjifyUoAYszApGct4=;
 b=F2iY3fh//qU9MjleiSWK4YcXi4zN0/6tS3puJoVpHSNqe6UJ4TSNo3fj5eznto+4vi
 8JfOVojP3q8Wbxy11MDoDE9CbRZbXnuZXc7jv4mq6UNPHbLgIdAb+ZXOHhNZTxY98hoB
 3XmJmqDnEwltKjQutVBRCJrAoLiO+0oz13Ed60WvWxYkfuC58u2ukuItvlcbfP/UjqEh
 +HMvnDtpMrLulyopG6sTC6CEOqQoKBvij5/A7muxEmTQBnBjsUAvt4KhKgP2CdhJqv3Q
 p81EOuZMw8bsqOszHOOGYZh2kIFAMDMV+Q2U8HXrAG/uM0XnA9KPpf2qbFxYtnxkiI5w
 EsDA==
X-Gm-Message-State: AOAM53085EtoOgIsNAsv+QlLRWvrVyw+MOWnlRCJZPOatC0JYAJrX4By
 haw3UvuJtE3eggyNeUooNso=
X-Google-Smtp-Source: ABdhPJxE4XcNmzkpx43Tj4vTG8W34UFVRt9xk9MP2zgyZf9o/dCEse8Hl4bXPc+ASQVNbrdbDvtuNg==
X-Received: by 2002:a1c:4e05:: with SMTP id g5mr78945wmh.162.1602785786188;
 Thu, 15 Oct 2020 11:16:26 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q9sm77297wrd.57.2020.10.15.11.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 11:16:25 -0700 (PDT)
Subject: Re: [PATCH] ssi: Display chip select polarity in monitor 'info qtree'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200927091946.65491-1-f4bug@amsat.org>
 <290a4128-dd09-7f05-1f2d-0a0f607de28b@amsat.org>
Message-ID: <d3c12ed9-9a7c-ff67-e8fa-c290ff396726@amsat.org>
Date: Thu, 15 Oct 2020 20:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <290a4128-dd09-7f05-1f2d-0a0f607de28b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-1.019,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus for "Monitor" tree.

On 10/5/20 9:44 AM, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> Can you take this patch via your qemu-arm tree please?
> (most of SPI boards are ARM based)
> 
> On 9/27/20 11:19 AM, Philippe Mathieu-Daudé wrote:
>> It is sometime useful to verify a device chip select polarity
>> on a SPI bus. Since we have this information available, display
>> it in the 'info qtree' monitor output:
>>
>>    $ qemu-system-arm -M lm3s6965evb -monitor stdio -S
>>    (qemu) info qtree
>>    [...]
>>    dev: pl022, id ""
>>      gpio-out "sysbus-irq" 1
>>      mmio 0000000040008000/0000000000001000
>>      bus: ssi
>>        type SSI
>>        dev: ssd0323, id ""
>>          gpio-in "" 1
>>          gpio-in "ssi-gpio-cs" 1
>>          chip select polarity: high           <---
>>        dev: ssi-sd, id ""
>>          gpio-in "ssi-gpio-cs" 1
>>          chip select polarity: low            <---
>>          bus: sd-bus
>>            type sd-bus
>>            dev: sd-card, id ""
>>              spec_version = 2 (0x2)
>>              drive = "sd0"
>>              spi = true
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/ssi/ssi.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
>> index 4278d0e4440..4c9f8d66d23 100644
>> --- a/hw/ssi/ssi.c
>> +++ b/hw/ssi/ssi.c
>> @@ -17,6 +17,7 @@
>>   #include "migration/vmstate.h"
>>   #include "qemu/module.h"
>>   #include "qapi/error.h"
>> +#include "monitor/monitor.h"
>>   #include "qom/object.h"
>>   
>>   struct SSIBus {
>> @@ -26,10 +27,31 @@ struct SSIBus {
>>   #define TYPE_SSI_BUS "SSI"
>>   OBJECT_DECLARE_SIMPLE_TYPE(SSIBus, SSI_BUS)
>>   
>> +static void ssi_print_dev(Monitor *mon, DeviceState *dev, int indent)
>> +{
>> +    static const char *const polarity_s[] = {
>> +        [SSI_CS_NONE] = "unknown",
>> +        [SSI_CS_LOW]  = "low",
>> +        [SSI_CS_HIGH] = "high"
>> +    };
>> +    SSISlaveClass *ssc = SSI_SLAVE_GET_CLASS(dev);
>> +
>> +    monitor_printf(mon, "%*schip select polarity: %s\n",
>> +                   indent, "", polarity_s[ssc->cs_polarity]);
>> +}
>> +
>> +static void ssi_bus_class_init(ObjectClass *klass, void *data)
>> +{
>> +    BusClass *k = BUS_CLASS(klass);
>> +
>> +    k->print_dev = ssi_print_dev;
>> +}
>> +
>>   static const TypeInfo ssi_bus_info = {
>>       .name = TYPE_SSI_BUS,
>>       .parent = TYPE_BUS,
>>       .instance_size = sizeof(SSIBus),
>> +    .class_init = ssi_bus_class_init,
>>   };
>>   
>>   static void ssi_cs_default(void *opaque, int n, int level)
>>
> 

