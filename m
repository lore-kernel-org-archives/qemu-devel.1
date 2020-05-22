Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD467C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81514205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDpb7mhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81514205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9N6-0001hW-H1
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jc9M1-00009c-U8
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:12:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27231
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jc9M1-0001hn-3P
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590160376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=esPhA5uPa52ZkKLU+VzHjUqOZ2ccRyG0jIhcXa9X9os=;
 b=aDpb7mhSfNGCEfCoQEkoBFJ/JhzAiWpS5E0lATtEk5mU8UocFsPYg/8pkGLn3hr5K7cQXb
 R5f8E9eTmKeG3QnrRymQwIRZ8iWsBB7lNxZL7ikh/jXnMLHTVfPcNCActWfispA3GsfEpS
 DBRuQTaEiuCYj1kbmpF3tGUCuNxsovQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-x93QalW4Mg2TU46u3eHXDw-1; Fri, 22 May 2020 11:12:52 -0400
X-MC-Unique: x93QalW4Mg2TU46u3eHXDw-1
Received: by mail-wr1-f69.google.com with SMTP id d16so4494263wrv.18
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 08:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=esPhA5uPa52ZkKLU+VzHjUqOZ2ccRyG0jIhcXa9X9os=;
 b=b4Ssuqvp1wvI+Jcj6OAFvU+5LsAdT2mIi5QBbKEqWOgrG7nn2CqgLjwtyxxxsxshk3
 vEPAuFGuQXTUD+aUXrs7p+KJsKYb7a+gjWRPbHpSkkRpIhRkV6TRITUmRJd8dybcsWaS
 59pvur/KYzscG2u+GLVGqycCgbCfXVPW7xaT8I8YWegrGw7i/Nfnjfiwxz4Yc/5l3fZl
 7TNlMLzqbvWUP14NiCLpa0LL3vSPU+VGI5P9dCuVUCypgFSTUsXvFIdYM1PlPUOLP4nw
 WZDayurBxXzSc81IX2aUaLM3tbtEqeMZOroDVx3dmmw8cdO5kj1EppmdBvx8fk/x/bJt
 Sa9A==
X-Gm-Message-State: AOAM532AisIyeW0rX/4Ln8lheXaLM35uGefhwsHCjh/UD6H0uIjQb/8+
 JJZtacQ6GvtybqkCd1Vs29rfGROoG5Kdr6DGkXQ1Nh6EQQmFrESm3yTq4OkDYPYx8RXES5VFJaB
 X3lIkVM7k0ttmxAU=
X-Received: by 2002:a7b:c205:: with SMTP id x5mr14437135wmi.135.1590160371351; 
 Fri, 22 May 2020 08:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSXgJaVmQVhbh5oua1UP9kTbA0+y5AKSl1+bMKoEgJMWuZ7Lr9XCnTkvWj3JjYiOen6+l5lg==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr14437106wmi.135.1590160371130; 
 Fri, 22 May 2020 08:12:51 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n13sm9570037wrs.2.2020.05.22.08.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2020 08:12:50 -0700 (PDT)
Subject: Re: [PATCH v3 11/11] hw/semihosting: Make the feature depend of TCG, 
 and allow to disable it
To: qemu-devel@nongnu.org
References: <20200521195911.19685-1-philmd@redhat.com>
 <20200521195911.19685-12-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7e59175e-86f7-98f8-392b-929796ec877a@redhat.com>
Date: Fri, 22 May 2020 17:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200521195911.19685-12-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:01:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 9:59 PM, Philippe Mathieu-Daudé wrote:
> The semihosting feature is only meaningful when using TCG.
> 
> Do not enable it by default, and let the few targets requiring
> it to manually select it.
> The targets restricted to TCG that previously selected it
> (see commit 16932bb761e52c2 'introduce CONFIG_SEMIHOSTING')
> are left unmodified; however the selection is moved to the
> target Kconfig.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3: Fixed odd hidden \xC2 UTF-8 chars:
> 
> Traceback (most recent call last):
>   File "qemu/scripts/minikconf.py", line 355, in parse_file
>     self.src = fp.read()
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 21: ordinal not in range(128)
> ---
>  default-configs/arm-softmmu.mak         | 1 -
>  default-configs/lm32-softmmu.mak        | 2 --
>  default-configs/m68k-softmmu.mak        | 2 --
>  default-configs/mips-softmmu-common.mak | 3 ---
>  default-configs/nios2-softmmu.mak       | 2 --
>  default-configs/xtensa-softmmu.mak      | 2 --
>  hw/semihosting/Kconfig                  | 4 +++-
>  target/arm/Kconfig                      | 2 ++
>  target/lm32/Kconfig                     | 2 ++
>  target/m68k/Kconfig                     | 2 ++
>  target/mips/Kconfig                     | 2 ++
>  target/nios2/Kconfig                    | 2 ++
>  target/riscv/Kconfig                    | 2 ++
>  target/xtensa/Kconfig                   | 2 ++
>  14 files changed, 17 insertions(+), 13 deletions(-)
>  create mode 100644 target/arm/Kconfig
>  create mode 100644 target/lm32/Kconfig
>  create mode 100644 target/m68k/Kconfig
>  create mode 100644 target/mips/Kconfig
>  create mode 100644 target/nios2/Kconfig
>  create mode 100644 target/riscv/Kconfig
>  create mode 100644 target/xtensa/Kconfig
> 
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 8fc09a4a51..f6044f1121 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -40,6 +40,5 @@ CONFIG_MICROBIT=y
>  CONFIG_FSL_IMX25=y
>  CONFIG_FSL_IMX7=y
>  CONFIG_FSL_IMX6UL=y
> -CONFIG_SEMIHOSTING=y
>  CONFIG_ALLWINNER_H3=y
>  CONFIG_ACPI_APEI=y
> diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
> index 115b3e34c9..6d259665d6 100644
> --- a/default-configs/lm32-softmmu.mak
> +++ b/default-configs/lm32-softmmu.mak
> @@ -4,8 +4,6 @@
>  #
>  #CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
>  
> -CONFIG_SEMIHOSTING=y
> -
>  # Boards:
>  #
>  CONFIG_LM32=y
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
> index 6629fd2aa3..4fef4bd731 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for m68k-softmmu
>  
> -CONFIG_SEMIHOSTING=y
> -
>  # Boards:
>  #
>  CONFIG_AN5206=y
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
> index da29c6c0b2..6c0904b200 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -1,8 +1,5 @@
>  # Common mips*-softmmu CONFIG defines
>  
> -# CONFIG_SEMIHOSTING is always required on this architecture
> -CONFIG_SEMIHOSTING=y
> -
>  CONFIG_ISA_BUS=y
>  CONFIG_PCI=y
>  CONFIG_PCI_DEVICES=y
> diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
> index 1bc4082ea9..e130d024e6 100644
> --- a/default-configs/nios2-softmmu.mak
> +++ b/default-configs/nios2-softmmu.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for nios2-softmmu
>  
> -CONFIG_SEMIHOSTING=y
> -
>  # Boards:
>  #
>  CONFIG_NIOS2_10M50=y
> diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
> index 4fe1bf00c9..49e4c9da88 100644
> --- a/default-configs/xtensa-softmmu.mak
> +++ b/default-configs/xtensa-softmmu.mak
> @@ -1,7 +1,5 @@
>  # Default configuration for Xtensa
>  
> -CONFIG_SEMIHOSTING=y
> -
>  # Boards:
>  #
>  CONFIG_XTENSA_SIM=y
> diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
> index efe0a30734..30befcdd21 100644
> --- a/hw/semihosting/Kconfig
> +++ b/hw/semihosting/Kconfig
> @@ -1,3 +1,5 @@
>  
> +# default is 'n'
>  config SEMIHOSTING
> -       bool
> +    bool
> +    depends on TCG
> diff --git a/target/arm/Kconfig b/target/arm/Kconfig
> new file mode 100644
> index 0000000000..035592dd86
> --- /dev/null
> +++ b/target/arm/Kconfig
> @@ -0,0 +1,2 @@
> +config SEMIHOSTING
> +    default y if TCG

This patch is incorrect, because previously the feature was selected for
system-mode only, and now it is selected in user-mode too.

[...]


