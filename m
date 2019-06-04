Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D40C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0638024437
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 14:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHkEenlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0638024437
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYAOR-0004iV-S3
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 10:26:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYANe-0004Rg-Br
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYANd-0006em-6L
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:25:38 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYANc-0006bu-VR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 10:25:37 -0400
Received: by mail-ot1-x341.google.com with SMTP id r21so7222244otq.6
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cxuZKhYyjlC6800erOOHS2B0CuO6yYsPiAuYSuVeUgo=;
	b=RHkEenlr8FQtrSOKpzjw3tcN0z03skwPDP8esibfKa+VY8znSecl+ejYqsn9P7Yu2N
	clPBh3CfUkOjjqC+Sqt2AosVl50w9uoGH/B6dmxBcYmsYgNSBzpdIjf2ItJLf+/yF4Sj
	a6PJea/aiC9DMVdt27MGsmozAP41Zz999x5q54qL6XqKTWDOxzgISjbw83gPYV5JsyO4
	9oPGPxqUOxCxO1xk7zMZMMJACf6duo1frrBkF2FX32C/GF0FcuNOBQ978QxRCfMexT8b
	T3bfSZHcwhGLhcjZ09CNDAy3KiA4xMwnfu4XMe6R4FfjzhjBJFhHIua9eaqJQxCrBty1
	O0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cxuZKhYyjlC6800erOOHS2B0CuO6yYsPiAuYSuVeUgo=;
	b=kB/UoviEv/FnRxxxxjMnN42P28JrpIzAkEEynuK9/Ij8Ec2Ev2WbJhz+VZXfxcSn3z
	MOMnYIpqwwE1F+QWEKSXI+A0A2Es0sV2ZQGpEM9pqKlJlgiD49JwVGwv+ty67V8fEmEJ
	E5Yp87i/5TMxNlcJXy9Su5L6+/bIf9dxpreOCkHzWCphg4ROOmMeDx9oYk6qKEXLLoGZ
	d21f1FqKlF1yYdlePtElHSeJV1IT1Trcv5J+IT13aVoj0CFC4h634YPzTAa4sh+YpLyL
	nuVZtMQUt/tsqOMYRK3ky2LSvuWMHKncxGtmldkq9x6PuPh6hW4q3Vcjn/o3k6SyoeEU
	4gjA==
X-Gm-Message-State: APjAAAV+SOwkGPZu0imsNeW3Aofsdv7BC6+0VAnQiuFmvtLc8w8IY0lV
	r6Jftq6syAuCzHA4ZLUrh2Jwxw==
X-Google-Smtp-Source: APXvYqzeao9XNwqnXnguyqJMnz/BI84DiSYp+qHT8UYbgz2eH+DNQ+Qr+gS1OPv0Qg4Fn5oDe/Gmtw==
X-Received: by 2002:a9d:2963:: with SMTP id d90mr5285204otb.126.1559658335108; 
	Tue, 04 Jun 2019 07:25:35 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	e24sm1494635otp.14.2019.06.04.07.25.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 07:25:34 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190531134315.4109-1-richard.henderson@linaro.org>
	<20190531134315.4109-17-richard.henderson@linaro.org>
	<1c0e8496-6005-f875-a7ee-5913a485fd08@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <afee2e51-ad52-dddc-bf3e-d5f463606443@linaro.org>
Date: Tue, 4 Jun 2019 09:25:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1c0e8496-6005-f875-a7ee-5913a485fd08@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v16 16/23] Add rx-softmmu
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/19 1:38 AM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 5/31/19 3:43 PM, Richard Henderson wrote:
>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Message-Id: <20190516055244.95559-10-ysato@users.sourceforge.jp>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/sysemu/arch_init.h     | 1 +
>>  arch_init.c                    | 2 ++
>>  configure                      | 8 ++++++++
>>  default-configs/rx-softmmu.mak | 3 +++
>>  hw/Kconfig                     | 1 +
>>  5 files changed, 15 insertions(+)
>>  create mode 100644 default-configs/rx-softmmu.mak
>>
>> diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
>> index 10cbafe970..3f4f844f7b 100644
>> --- a/include/sysemu/arch_init.h
>> +++ b/include/sysemu/arch_init.h
>> @@ -25,6 +25,7 @@ enum {
>>      QEMU_ARCH_NIOS2 = (1 << 17),
>>      QEMU_ARCH_HPPA = (1 << 18),
>>      QEMU_ARCH_RISCV = (1 << 19),
>> +    QEMU_ARCH_RX = (1 << 20),
>>  };
>>  
>>  extern const uint32_t arch_type;
>> diff --git a/arch_init.c b/arch_init.c
>> index f4f3f610c8..cc25ddd7ca 100644
>> --- a/arch_init.c
>> +++ b/arch_init.c
>> @@ -74,6 +74,8 @@ int graphic_depth = 32;
>>  #define QEMU_ARCH QEMU_ARCH_PPC
>>  #elif defined(TARGET_RISCV)
>>  #define QEMU_ARCH QEMU_ARCH_RISCV
>> +#elif defined(TARGET_RX)
>> +#define QEMU_ARCH QEMU_ARCH_RX
>>  #elif defined(TARGET_S390X)
>>  #define QEMU_ARCH QEMU_ARCH_S390X
>>  #elif defined(TARGET_SH4)
>> diff --git a/configure b/configure
>> index 6cdcfb2dc3..7e5477e487 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7605,6 +7605,11 @@ case "$target_name" in
>>      gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
>>      target_compiler=$cross_cc_riscv64
>>    ;;
>> +  rx)
>> +    TARGET_ARCH=rx
>> +    bflt="yes"
>> +    target_compiler=$cross_cc_rx
>> +  ;;
>>    sh4|sh4eb)
>>      TARGET_ARCH=sh4
>>      bflt="yes"
>> @@ -7825,6 +7830,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
>>    riscv*)
>>      disas_config "RISCV"
>>    ;;
>> +  rx)
>> +    disas_config "RX"
>> +  ;;
>>    s390*)
>>      disas_config "S390"
>>    ;;
>> diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
>> new file mode 100644
>> index 0000000000..a3eecefb11
>> --- /dev/null
>> +++ b/default-configs/rx-softmmu.mak
>> @@ -0,0 +1,3 @@
>> +# Default configuration for rx-softmmu
>> +
>> +CONFIG_RX_VIRT=y
>> diff --git a/hw/Kconfig b/hw/Kconfig
>> index 195f541e50..b0c7221240 100644
>> --- a/hw/Kconfig
>> +++ b/hw/Kconfig
>> @@ -54,6 +54,7 @@ source nios2/Kconfig
>>  source openrisc/Kconfig
>>  source ppc/Kconfig
>>  source riscv/Kconfig
>> +source rx/Kconfig
>>  source s390x/Kconfig
>>  source sh4/Kconfig
>>  source sparc/Kconfig
>>
> 
> Please squash in:
> 
> -- >8 --
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -26,6 +26,7 @@
>  #pragma GCC poison TARGET_PPC
>  #pragma GCC poison TARGET_PPC64
>  #pragma GCC poison TARGET_ABI32
> +#pragma GCC poison TARGET_RX
>  #pragma GCC poison TARGET_S390X
>  #pragma GCC poison TARGET_SH4
>  #pragma GCC poison TARGET_SPARC
> ---

Thanks, good catch.


r~


