Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C535AC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EACD20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqEEaPEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EACD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlfq-0001Ad-Pl
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlbi-0006FU-9H
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlbg-0007wg-P6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:16:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iHlbc-0007qP-5K; Tue, 08 Oct 2019 05:16:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id j11so12685423wrp.1;
 Tue, 08 Oct 2019 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qy5vG9d8A0ZFCwKW+DYqH3Fxpig7YpU0ZQA4+9Q03cQ=;
 b=bqEEaPEw5TpUWZXa70yM6mnEZRTfwoz9cWHxaSd6zyA/kRs1gvouqUl9371a9cI7mu
 SaQN3PGQEoUr6CGvhnZvZcdiLMGNxNZ8HTZH/3mpPrekreVhsPYFXpwieJ/2hqdhmN95
 28wNyFi5GMR3MR1ZoS8r2nwoTxw+9ywXMnGzlbyZHFaSkM7lziZrUxPlaqRl5OjMkDTX
 Dyp2nZhoh9N9YX3LSKO2AQrYTMgLdvXdmFcSUHNUvAUNDOVGGlg08gZbPhSCxDfMR+QL
 HF4Sj7ZswOHNca/0RuO3aWcfEE+JRN072RvMaKgqP/cnRYM/3q2vPVOAYwLjz0CP3MO3
 pOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qy5vG9d8A0ZFCwKW+DYqH3Fxpig7YpU0ZQA4+9Q03cQ=;
 b=XEcFO6UQGqshR+BgBTGLHVaf8txHqM4Fk6caYK4x762JADvTPCR3u6xIsBUFJNDEl9
 A8JMUyxCT8AsYMaI2cxVp2F1pscTnPyCfruzjdYXlM/Lyv5cqh8ogAh8W3a+KE62aRS2
 tyEM7VUr1O1x8EjuEjhctvLe3Ka0eDsA+rpVrO1BpiuqrSYSfNZlpHtDz19PQ1EzD5m9
 xgPYGRE2OJf7WJdGqU4QGVZL8zYWHTANfy5VziF1VscPSg28K+M6WKUhBeQrRfg2VHZ7
 N8eu3bASPd6KvPft3SEfiCddJ559/lJ5w1kvZcJWUtBcmTGjUAmiBk4i9mvCnJ1opw5C
 YWgw==
X-Gm-Message-State: APjAAAXDawSUpxIL93XMsYg1ovOG/vkpZ7xEMiyZRluVVSyXRYXjL7x9
 wCKWbHdp8c4/kIkbi1bOQYo=
X-Google-Smtp-Source: APXvYqy8OgmQ8c2bW/W7lZLVHqliwf7XXXtHBWnlIOfBVZDNnptQrN5BC65FE53/2gjnnIwpLIkUPA==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr26227042wrq.78.1570526190426; 
 Tue, 08 Oct 2019 02:16:30 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id r18sm3192522wme.48.2019.10.08.02.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 02:16:29 -0700 (PDT)
Subject: Re: [PATCH 10/14] hw/arm/raspi: Define various blocks base addresses
To: Esteban Bosse <estebanbosse@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Zolt=c3=a1n_Baldaszti?=
 <bztemail@gmail.com>
References: <20190904171315.8354-1-f4bug@amsat.org>
 <20190904171315.8354-11-f4bug@amsat.org>
 <ba3fb4d4-0726-28ae-608b-95354107c2e6@amsat.org>
 <40ddb83824dc19adea584fa8597884e5bdec0d11.camel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1957080-1822-636b-6037-9b6559ad46b0@amsat.org>
Date: Tue, 8 Oct 2019 11:16:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <40ddb83824dc19adea584fa8597884e5bdec0d11.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/19 5:27 PM, Esteban Bosse wrote:
> El vie, 06-09-2019 a las 12:07 +0200, Philippe Mathieu-Daudé escribió:
>> On 9/4/19 7:13 PM, Philippe Mathieu-Daudé wrote:
>>> The Raspberry firmware is closed-source. While running it, it
>>> accesses various I/O registers. Logging these accesses as UNIMP
>>> (unimplemented) help to understand what the firmware is doing
>>> (ideally we want it able to boot a Linux kernel).
>>>
>>> Document various blocks we might use later.
>>>
>>> Adresses and names based on:
>>> https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>   include/hw/arm/raspi_platform.h | 49 +++++++++++++++++++++++++++
>>> ------
>>>   1 file changed, 40 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/hw/arm/raspi_platform.h
>>> b/include/hw/arm/raspi_platform.h
>>> index 069edab526..c6f4985522 100644
>>> --- a/include/hw/arm/raspi_platform.h
>>> +++ b/include/hw/arm/raspi_platform.h
>>> @@ -25,42 +25,73 @@
>>>   #ifndef HW_ARM_RASPI_PLATFORM_H
>>>   #define HW_ARM_RASPI_PLATFORM_H
>>>   
>>> -#define MCORE_OFFSET            0x0000   /* Fake frame buffer
>>> device
>>> -                                          * (the multicore sync
>>> block) */
>>> -#define IC0_OFFSET              0x2000
>>> +#define MSYNC_OFFSET            0x0000   /* Multicore Sync Block
>>> */
>>> +#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2
>>> TX */
>>> +#define INTE_OFFSET             0x2000   /* VC Interrupt
>>> controller */
>>>   #define ST_OFFSET               0x3000   /* System Timer */
>>> +#define TXP_OFFSET              0x4000
>>> +#define JPEG_OFFSET             0x5000
>>>   #define MPHI_OFFSET             0x6000   /* Message-based Parallel
>>> Host Intf. */
>>>   #define DMA_OFFSET              0x7000   /* DMA controller,
>>> channels 0-14 */
>>> -#define ARM_OFFSET              0xB000   /* BCM2708 ARM control
>>> block */
>>> +#define ARBA_OFFSET             0x9000
>>> +#define BRDG_OFFSET             0xa000
>>> +#define ARM_OFFSET              0xB000   /* ARM control block */
>>>   #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>>>   #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt
>>> controller */
>>> -#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0
>>> and 1 */
>>> +#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0
>>> and 1 (SP804) */
>>>   #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0
>>> (ARM) Semaphores
>>>                                                         * Doorbells
>>> & Mailboxes */
>>>   #define PM_OFFSET               0x100000 /* Power Management,
>>> Reset controller
>>>                                             * and Watchdog registers
>>> */
>>>   #define CPRMAN_OFFSET           0x101000 /* Clock Management */
>>> +#define A2W_OFFSET              0x102000
>>>   #define AVS_OFFSET              0x103000 /* Audio Video Standard
>>> */
>>>   #define RNG_OFFSET              0x104000
>>>   #define GPIO_OFFSET             0x200000
>>> -#define UART0_OFFSET            0x201000
>>> -#define MMCI0_OFFSET            0x202000
>>> -#define I2S_OFFSET              0x203000
>>> -#define SPI0_OFFSET             0x204000
>>> +#define UART0_OFFSET            0x201000 /* PL011 */
>>> +#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
>>> +#define I2S_OFFSET              0x203000 /* PCM */
>>> +#define SPI0_OFFSET             0x204000 /* SPI master */
>>>   #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
>>> +#define PIXV0_OFFSET            0x206000
>>> +#define PIXV1_OFFSET            0x207000
>>> +#define DPI_OFFSET              0x208000
>>> +#define DSI0_OFFSET             0x209000 /* Display Serial
>>> Interface */
>>> +#define PWM_OFFSET              0x20c000
>>> +#define PERM_OFFSET             0x20d000
>>> +#define TEC_OFFSET              0x20e000
>>>   #define OTP_OFFSET              0x20f000
>>> +#define SLIM_OFFSET             0x100000 /* SLIMbus */
>>> +#define CPG_OFFSET              0x110000
>>>   #define AVSP_OFFSET             0x130000
>>
>> These should be:
>>
>> #define SLIM_OFFSET             0x210000 /* SLIMbus */
>> #define CPG_OFFSET              0x211000
>> #define AVSP_OFFSET             0x213000
>>
>>>   #define BSC_SL_OFFSET           0x214000 /* SPI slave */
> Looking in
> https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map I
> found that 0x214000 is the "bootrom" register, why the difference?

This chipset family can have various SPI slave interfaces, but this one 
in particular is used by the VideoCore bootloader to load the ARM bootrom.

This file is generic to the chipset, so declaring BSC_SL_OFFSET here is 
OK IMO. Since the "bootrom" is specific to the bootloader, the 
definition should go into hw/arm/raspi.c such:

#define RASPI4_BOOTROM_OFFSET BSC_SL_OFFSET

>>> +#define THERMAL_OFFSET          0x212000
>>>   #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2
>>> */
>>>   #define EMMC1_OFFSET            0x300000
>>> +#define EMMC2_OFFSET            0x340000
>>> +#define HVS_OFFSET              0x400000
> In github describe 7E400000 as ddrv register, ddrv is the same as HVS?

https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map 
describes the VideoCore IV, this region appears unregistered.

The raspi4 uses the VideoCore VI. HVS means High-speed Video Scaler.
I assume this is a new block added to the VI core, Andrew might confirm.

>>>   #define SMI_OFFSET              0x600000
>>> +#define DSI1_OFFSET             0x700000
>>> +#define UCAM_OFFSET             0x800000
>>> +#define CMI_OFFSET              0x802000
>>>   #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
>>>   #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
>>> +#define VECA_OFFSET             0x806000
>>> +#define PIXV2_OFFSET            0x807000
>>> +#define HDMI_OFFSET             0x808000
>>> +#define HDCP_OFFSET             0x809000
>>> +#define ARBR0_OFFSET            0x80a000
>>>   #define DBUS_OFFSET             0x900000
>>>   #define AVE0_OFFSET             0x910000
>>>   #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller
>>> */
>>> +#define V3D_OFFSET              0xc00000
>>>   #define SDRAMC_OFFSET           0xe00000
>>> +#define L2CC_OFFSET             0xe01000 /* Level 2 Cache
>>> controller */
>>> +#define L1CC_OFFSET             0xe02000 /* Level 1 Cache
>>> controller */
>>> +#define ARBR1_OFFSET            0xe04000
>>>   #define DMA15_OFFSET            0xE05000 /* DMA controller,
>>> channel 15 */
>>> +#define DCRC_OFFSET             0xe07000
>>> +#define AXIP_OFFSET             0xe08000
>>>   
>>>   /* GPU interrupts */
>>>   #define INTERRUPT_TIMER0               0
>>>
> 

