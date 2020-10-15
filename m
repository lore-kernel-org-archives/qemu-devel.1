Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF183C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD1C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxo2PRHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD1C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7y7-0002IT-J9
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT7hT-0005L4-BO; Thu, 15 Oct 2020 14:10:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT7hR-0002kW-ET; Thu, 15 Oct 2020 14:10:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so4747100wrq.2;
 Thu, 15 Oct 2020 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J9GoQMqEWOq9Cqz3aBJf9K5ddKtc3fEhjQajnACJrPk=;
 b=bxo2PRHRvzgVUMnOjETqwHQCGhVSV+JAEGkzMb3Es9K8Hk+gVVSyvrWNGLVwMWyj8h
 S7sExRCTqnC/Hiy9CA6Sw4f17Vn/3UBanJkOpq/0h51Zn2khT4iiCqCEGN42gLjmlRYj
 tGfcPA8Zt257M5tFVxscyZ6DEcd3MlU+E4QOFoAvPkO9OKOIfPTby6gq4MAkdFF1xozq
 BWCv0eeF34p62Dz8toI5ZwDL2v8Wl7y0fq2S3kuLXMIqL5pUqBmPOoH8N62/wOf0S85K
 JR3H3dvjr45rBh3Vg4f1s/yVMD5Lf5aetYMR4fwT5viItGoGWSg/PqODPRvWy8BPk0L6
 RnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J9GoQMqEWOq9Cqz3aBJf9K5ddKtc3fEhjQajnACJrPk=;
 b=D9G4BAL1fa4vWM5R5Ij8GAcB/aqDKp2ua4xKaTjA2NmyxFNh3P7X5TlMLAETgEQ6iW
 hHpVhOYvzhRsHBSOSn7tflYeaHb0d3+XC/RymNWHoVJmCrUBXgQRjYsDtFI53+UD+sOI
 an1j08voQ3cvOQFNYly0IKoO3nm3xWYBbCIDb7KTQm52AcTm0Qk1NhRLC51Jrt6IpyaY
 +wt8hDdJGz0kL6sGlMy4LnmXciYmCzNpKH866hsJp9wHslyTAMa2KXWo2mIGMXdSCXqS
 uhKeFdXtC1mgaBHYdDDJBKw4FiTGpzZZJqXrIwH5fmBfY4M5QQ5xLgzFvAXeOvK2izVf
 betA==
X-Gm-Message-State: AOAM530KKoz4ruYGVP2odY57TNNLOjmJI9ClImqsS3zJ/B990khSYUOc
 U0XwbCfADFYOtQxpe8rGWzU=
X-Google-Smtp-Source: ABdhPJz2OscdZTz5zE7UGRt6x/a8VILlM73OPN0yC0puXN/I4/qsmyNLbOhgkltwCNWM6EXbSYyVSg==
X-Received: by 2002:a5d:6a4f:: with SMTP id t15mr5644171wrw.126.1602785398883; 
 Thu, 15 Oct 2020 11:09:58 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j17sm32016wrw.68.2020.10.15.11.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 11:09:58 -0700 (PDT)
Subject: Re: [PATCH] hw/intc: Rename NIOS2 kconfig as ALTERA_IIC
To: qemu-devel@nongnu.org, Sandra Loosemore <sandra@codesourcery.com>,
 Julian Brown <julian@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>
References: <20201007130015.2531633-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1d3635e5-f8d7-2336-910c-107e21a0cd32@amsat.org>
Date: Thu, 15 Oct 2020 20:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007130015.2531633-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Marek Vasut <marex@denx.de>, qemu-trivial@nongnu.org,
 Chris Wulff <crwulff@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 10/7/20 3:00 PM, Philippe Mathieu-Daudé wrote:
> The 'NIOS2' Kconfig symbol is used to select an generic interrupt
> controller, and has not much to do with the Nios2 target.
> Rename the symbol as 'ALTERA_IIC'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/intc/Kconfig     | 3 +++
>   hw/intc/meson.build | 2 +-
>   hw/nios2/Kconfig    | 7 ++-----
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
> index d07954086a..d940c09cde 100644
> --- a/hw/intc/Kconfig
> +++ b/hw/intc/Kconfig
> @@ -73,3 +73,6 @@ config SIFIVE_CLINT
>   
>   config SIFIVE_PLIC
>       bool
> +
> +config ALTERA_IIC
> +    bool
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index 3f82cc230a..47c6726b8e 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -37,7 +37,7 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_plic.c'))
>   specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
>   specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gic.c'))
> -specific_ss.add(when: 'CONFIG_NIOS2', if_true: files('nios2_iic.c'))
> +specific_ss.add(when: 'CONFIG_ALTERA_IIC', if_true: files('nios2_iic.c'))
>   specific_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
>   specific_ss.add(when: 'CONFIG_OMPIC', if_true: files('ompic.c'))
>   specific_ss.add(when: 'CONFIG_OPENPIC_KVM', if_true: files('openpic_kvm.c'))
> diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
> index b10ea640da..95e72186af 100644
> --- a/hw/nios2/Kconfig
> +++ b/hw/nios2/Kconfig
> @@ -1,12 +1,9 @@
>   config NIOS2_10M50
>       bool
> -    select NIOS2
> +    select ALTERA_IIC
>       select SERIAL
>       select ALTERA_TIMER
>   
>   config NIOS2_GENERIC_NOMMU
>       bool
> -    select NIOS2
> -
> -config NIOS2
> -    bool
> +    select ALTERA_IIC
> 

