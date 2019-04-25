Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F3C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73EE2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73EE2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58431 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfHX-0000Dn-0X
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:23:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfGL-00089g-J8
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:22:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJfGK-0002pv-Ey
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:22:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJfGK-0002pS-8K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:22:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id f7so7999421wrs.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oN1gTjcDDn35eS9dJ/AKEVa5Nwz7Po5+FmnnWoiCwqA=;
	b=LH5PldL6rZH7fzUvaYielHmUQ+qL5IJuoW+IO6K8H53dA4Nf2ODdMPB00Kssa29HfQ
	QwfLnGzxBIYk0hZk1EvahJuRJgTlOgITOS9ga3VUjKZxRKiPGM7MrtNpLqWADUPjYd0V
	RjimSjyJDtqKVPWlUPMvPXOpZFcYNHfFkrLbmDTVPahEL7rxxqfbdayU8e8yQDT6xgoG
	4BJUobU9pTq4ttyTBMkaRIDm+kfb6ct/K2W8QUIxtFprEb20QJlfjbVzh/Yt9FbN557L
	VjXuOPNT1NhW6ag5DjAV7QuCbgCWORfNYHclwELsTp7gU5NnsPEF+HfVhI8ZCXu1Mx+r
	8Zrw==
X-Gm-Message-State: APjAAAUqcw0nQ2ubyZ1tdqC9Nz5Fec7QwvujxuO5ANyERotdlsAdg0FO
	RCe59W378ZoTq/GPDzCzzzQReQ==
X-Google-Smtp-Source: APXvYqyoVgTv/6J27leNbubWMKdMr1xMEKibNeKi3NQqO4AOf+/vfnZvm/uHeXCuukSCZjv2yC7aiA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr12258776wrw.68.1556202127195; 
	Thu, 25 Apr 2019 07:22:07 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	n18sm18853950wrt.16.2019.04.25.07.22.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 07:22:06 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-7-thuth@redhat.com>
	<cf39902b-267a-ea7e-c513-fa0c9abf639c@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f362864d-b8f7-687d-1397-03769202cd4f@redhat.com>
Date: Thu, 25 Apr 2019 16:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cf39902b-267a-ea7e-c513-fa0c9abf639c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 06/29] hw/arm: Express
 dependencies of integratorcp with Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425142203.tSoA_YXW0CbE5O1_UktTgm5J6e9Z8pjRQqBxduQ0k_Q@z>

On 4/25/19 4:14 PM, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 4/18/19 8:00 PM, Thomas Huth wrote:
>> This patch is slightly based on earlier work by Ákos Kovács (i.e.
>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak | 8 +-------
>>  hw/arm/Kconfig                  | 8 ++++++++
>>  hw/display/Kconfig              | 1 +
>>  3 files changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>> index 50a4be3cad..6195b75f48 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -9,6 +9,7 @@ CONFIG_PCI_TESTDEV=y
>>  
>>  CONFIG_EXYNOS4=y
>>  CONFIG_HIGHBANK=y
>> +CONFIG_INTEGRATOR=y
>>  
>>  CONFIG_VGA=y
>>  CONFIG_NAND=y
>> @@ -33,7 +34,6 @@ CONFIG_ADS7846=y
>>  CONFIG_MAX111X=y
>>  CONFIG_SSI_SD=y
>>  CONFIG_SSI_M25P80=y
>> -CONFIG_SMC91C111=y
>>  CONFIG_ALLWINNER_EMAC=y
>>  CONFIG_IMX_FEC=y
>>  CONFIG_FTGMAC100=y
>> @@ -50,10 +50,7 @@ CONFIG_ARM11MPCORE=y
>>  CONFIG_NETDUINO2=y
>>  
>>  CONFIG_PL041=y
>> -CONFIG_PL050=y
> 
> You remove this device but it is used by the realview/versatile/vexpress
> (you add it to these machines later in patch 11).

My worry is the unlikely event of someone checking out a new branch
after this patch and before patch 11, and disable CONFIG_INTEGRATOR,
then these 3 machines would fail to build.

Since it is very unlikely:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>>  CONFIG_PL080=y
>> -CONFIG_PL110=y
> 
> Ditto,
> 
>> -CONFIG_PL181=y
> 
> Ditto.
> 
>>  CONFIG_PL190=y
>>  CONFIG_PL330=y
>>  CONFIG_CADENCE=y
>> @@ -113,9 +110,6 @@ CONFIG_VERSATILE_I2C=y
>>  CONFIG_PCI_EXPRESS=y
>>  CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
>>  
>> -CONFIG_INTEGRATOR=y
>> -CONFIG_INTEGRATOR_DEBUG=y
>> -
>>  CONFIG_ALLWINNER_A10_PIT=y
>>  CONFIG_ALLWINNER_A10_PIC=y
>>  CONFIG_ALLWINNER_A10=y
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 0ba377ac18..ad3b1f9b40 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -32,6 +32,14 @@ config HIGHBANK
>>  
>>  config INTEGRATOR
>>      bool
>> +    select ARM_TIMER
>> +    select INTEGRATOR_DEBUG
>> +    select PL011 # UART
>> +    select PL031 # RTC
>> +    select PL050 # keyboard/mouse
>> +    select PL110 # pl111 LCD controller
>> +    select PL181 # display
>> +    select SMC91C111
>>  
>>  config MAINSTONE
>>      bool
>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
>> index 72be57a403..a11815c9af 100644
>> --- a/hw/display/Kconfig
>> +++ b/hw/display/Kconfig
>> @@ -21,6 +21,7 @@ config JAZZ_LED
>>  
>>  config PL110
>>      bool
>> +    select FRAMEBUFFER
>>  
>>  config SII9022
>>      bool
>>

