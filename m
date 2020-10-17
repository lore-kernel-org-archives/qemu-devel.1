Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230ECC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DECD206CB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 09:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PobnPlvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DECD206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTioX-0000nD-Hl
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 05:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTimb-0008WA-5D; Sat, 17 Oct 2020 05:45:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTimZ-0000cR-G8; Sat, 17 Oct 2020 05:45:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id f21so5698720wml.3;
 Sat, 17 Oct 2020 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rFSaJhFlwaC3iQPHSmq6T1LzjIxyDt5ZiqitfDD4EaE=;
 b=PobnPlvd+OiSzPCda3HzoNDd/XT8itk0wQfn1TuIeJB38m6ZltYzXK0NEPeVRI532/
 R3FYSeFmX8ltpbnQETKut3Cf8FJpz3nBri2JjOxGLzsOL7XfWayydNODuv0OcVEciMg0
 2ltipK7TYlBXp/sQyuLGKfWDSXag0PoQhXW7na2uY6k7TiiKvYNn3oEPOCSTvxSlQ2w/
 NkHU1g78d1b3M3taakqN8pj6o0oBDByjE8Smq4mEpPBa4EqVVTjYUrVjfRwpuOTSeXFd
 sHIcATfqoBhUDxomwwY/L5iPb523Zix5vj98obV9va8q2EyvkEcYDGI2MOwQAEvyIHf3
 eRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rFSaJhFlwaC3iQPHSmq6T1LzjIxyDt5ZiqitfDD4EaE=;
 b=j5ppTBzRrTuqFN31tJiOWom6kJSPvmO0A39EQs4HcoXVMZRkjdrSFf02yzLVjLtjEk
 1MqLPihSC4Og2K/Iu+vXT9lK8f3AUKQE2ajomJhJbpygGvlngHiLeZCuS6Xq0kbIf+pp
 zs7hIc1+EAHFTeMLK3pHNn3aJz8Vjg9maYIS6XlVEYGZGwM67bEjUxuPZXJ9GKc5OUG2
 x3swsBGxqePlHSrIQLM1hPC7Fz+JjtwsyJW50p5M+0I28Xak6exc4Bqpmf9DVVxcGK2Y
 4DedUCJ27LzbrL4ZY/Wxv1wBTuMfwGEfBvo3cd5r2zpky8fXkdTHb5YU/x4bQPbZUH+B
 uceQ==
X-Gm-Message-State: AOAM530XFH7YXwQEmpC8j66ueS/z/tE2SpzkHcppvnJP9CPLSkL3r9G+
 ST56KvtOrH3FFMi2H261b08=
X-Google-Smtp-Source: ABdhPJzaWoznahnh6opy+9xrYK2PpUGfaFDfndcvsgX/IsNHEmJBRxQBpY6YhLxZjT8SbgDxGMnbwg==
X-Received: by 2002:a05:600c:1149:: with SMTP id
 z9mr8312921wmz.180.1602927945245; 
 Sat, 17 Oct 2020 02:45:45 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id h3sm7920432wrw.78.2020.10.17.02.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 02:45:44 -0700 (PDT)
Subject: Re: [PATCH 4/5] ppc405_boards: use qdev properties instead of legacy
 m48t59_init() function
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
 <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8efee931-3314-7f3a-395b-3b840acdab90@amsat.org>
Date: Sat, 17 Oct 2020 11:45:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, hpoussin@reactos.org,
 qemu-ppc@nongnu.org, atar4qemu@gmail.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 10:38 PM, BALATON Zoltan via wrote:
> On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/ppc/ppc405_boards.c | 10 +++++++++-
>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
>> index 6198ec1035..4687715b15 100644
>> --- a/hw/ppc/ppc405_boards.c
>> +++ b/hw/ppc/ppc405_boards.c
>> @@ -28,6 +28,8 @@
>> #include "qemu-common.h"
>> #include "cpu.h"
>> #include "hw/ppc/ppc.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/sysbus.h"
>> #include "ppc405.h"
>> #include "hw/rtc/m48t59.h"
>> #include "hw/block/flash.h"
>> @@ -145,6 +147,8 @@ static void ref405ep_init(MachineState *machine)
>>     char *filename;
>>     ppc4xx_bd_info_t bd;
>>     CPUPPCState *env;
>> +    DeviceState *dev;
>> +    SysBusDevice *s;
>>     qemu_irq *pic;
>>     MemoryRegion *bios;
>>     MemoryRegion *sram = g_new(MemoryRegion, 1);
>> @@ -227,7 +231,11 @@ static void ref405ep_init(MachineState *machine)
>>     /* Register FPGA */
>>     ref405ep_fpga_init(sysmem, 0xF0300000);
>>     /* Register NVRAM */
>> -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
>> +    dev = qdev_new("sysbus-m48t08");
>> +    qdev_prop_set_int32(dev, "base-year", 1968);
> 
> Is there anything that uses other than 1968 as base year? If not this 
> could be the default in the device so you don't need these set prop 
> calls here and in sun machines.
> 
> The only other place this device is used seems to be ppc/prep machine 
> that uses the isa version but does not set a base year. Is that a bug? 
> The original prep machine removed in b2ce76a0730 used 2000 but that's 
> unlikely as well as these machines predate that.

=)

> Anyway, the sysbus and 
> isa versions are different

They shouldn't, it is the same chipset, wired differently.

> so their default base-year could be set 
> independently and then boards won't need to set this propery and may be 
> could use qdev_create_simple instead or whatever that was renamed to.

Agreed.

Preferably following Zoltan's suggestion:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Regards,
> BALATON Zoltan
> 
>> +    s = SYS_BUS_DEVICE(dev);
>> +    sysbus_realize_and_unref(s, &error_fatal);
>> +    sysbus_mmio_map(s, 0, 0xF0000000);
>>     /* Load kernel */
>>     linux_boot = (kernel_filename != NULL);
>>     if (linux_boot) {
>>
> 

