Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A054C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07C20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3vV9-0007iz-4k
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vUL-0007BR-Rd; Fri, 07 Aug 2020 02:04:21 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:59125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3vUJ-0002s4-8m; Fri, 07 Aug 2020 02:04:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 2DA594DEA462;
 Fri,  7 Aug 2020 08:04:14 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 08:04:14 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e01aa0e3-b7fe-4aed-af8c-7f033ac38043,
 9C6B65F6CFD3D723D723CC07BEDAC6F805E88D1E) smtp.auth=clg@kaod.org
Subject: Re: [PATCH for-5.2 08/19] aspeed/sdhci: Fix reset sequence
To: Joel Stanley <joel@jms.id.au>
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-9-clg@kaod.org>
 <CACPK8Xcy-OzbQ4oiLaq96VzROSsmnmSAa0dytRcCVp2ot+mQnw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5684768c-c14d-5113-f029-f5bb9fbe6c86@kaod.org>
Date: Fri, 7 Aug 2020 08:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xcy-OzbQ4oiLaq96VzROSsmnmSAa0dytRcCVp2ot+mQnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 07b7b11a-7a08-46fd-a484-abd79837466c
X-Ovh-Tracer-Id: 17212194825916156710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepjeekudeuudevleegudeugeekleffveeludejteffiedvledvgfekueefudehheefnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:04:16
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

On 8/7/20 1:42 AM, Joel Stanley wrote:
> On Thu, 6 Aug 2020 at 13:21, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
>> the bit is cleared by HW. Add definitions for the default value of
>> this register and fix the reset sequence by clearing the RESET bit.
> 
> This is mentioned in the datasheet but I couldn't find if software
> depends on the behaviour. Were you just trying to make the model more
> accurate?

Yes. The AMI FW for the palmetto is requiring this : 


U-Boot 1.1.6 (Oct 27 2016 - 10:46:29)

DRAM:  446 MiB
Found SPI Chip Numonyx n25q256 
Flash: 32 MiB
MMC:   ast_sd: 0
Environment Read 1 time
Net:   ast_eth0
DRAM ECC disabled
Hit Esc key to stop autoboot:  0 
Image to be booted is 1
conf @ /dev/mtdblock1 Address 20050000
Found Root File System @ /dev/mtdblock2
root @ /dev/mtdblock2 Address 20120000
extlog @ /dev/mtdblock3 Address 20cd0000
www @ /dev/mtdblock4 Address 20d90000
Un-Protect Flash Bank # 1
Booting from Primary side
Booting from MODULE_PIMAGE ...
Bootargs = [root=/dev/mtdblock2 ro ip=none console=ttyS4,38400 rootfstype=cramfs bigphysarea=8192 imagebooted=1]
## Booting image at 20ae0040 ...
   Image Name:   Linux-2.6.28.10-ami
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1943652 Bytes = 1.9 MiB
   Load Address: 40008000
   Entry Point:  40008000
   Verifying Checksum ... OK
OK

Starting kernel ...

Uncompressing Linux............................................................................................................................. done, booting the kernel.
Linux version 2.6.28.10-ami (root@viswa-desk) (gcc version 4.5.1 (Sourcery G++ Lite 2010.09-50) ) #1 Thu Oct 27 10:45:59 EDT 2016
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
CPU: VIVT data cache, VIVT instruction cache
Machine: AST2400EVB



> 
>>  #define ASPEED_SDHCI_INFO            0x00
>> -#define  ASPEED_SDHCI_INFO_RESET     0x00030000
>> +#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
>> +#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
>> +#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
>>  #define ASPEED_SDHCI_DEBOUNCE        0x04
>>  #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
>>  #define ASPEED_SDHCI_BUS             0x08
>> @@ -67,6 +69,9 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
>>      AspeedSDHCIState *sdhci = opaque;
>>
>>      switch (addr) {
>> +    case ASPEED_SDHCI_INFO:
>> +        sdhci->regs[TO_REG(addr)] = (uint32_t)val & ~ASPEED_SDHCI_INFO_RESET;
> 
> I think bits 24 and 25 should be writable too?

ok. I will take a look.
> 
>         sdhci->regs[TO_REG(addr)] = (uint32_t)val &
> ~(ASPEED_SDHCI_INFO_RESET | ASPEED_SDHCI_INFO_SLOT10 |
> ASPEED_SDHCI_INFO_SLOT1);
> 
>> +
>>      case ASPEED_SDHCI_SDIO_140:
>>          sdhci->slots[0].capareg = (uint64_t)(uint32_t)val;
>>          break;
>> @@ -155,7 +160,8 @@ static void aspeed_sdhci_reset(DeviceState *dev)
>>      AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
>>
>>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
>> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] = ASPEED_SDHCI_INFO_RESET;
>> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =
>> +        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;
> 
> If we want to be super strict this is true for the "sd" devices, but
> the "emmc" device in the ast2600 only sets slot0. I don't think this
> distinction is important to model though.

OK. we can add different reset arrays depending on the SoC. 

C.

>>      sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] = ASPEED_SDHCI_DEBOUNCE_RESET;
>>  }
>>
>> --
>> 2.25.4
>>


