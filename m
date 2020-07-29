Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6FFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E8D2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4TnumHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E8D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qiS-00022n-7d
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0qhZ-0001C5-Ok
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:21:18 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k0qhU-0003dG-5c
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:21:14 -0400
Received: by mail-ed1-x544.google.com with SMTP id a8so18128363edy.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x5NhGqJcQdDjCfeklYPaB2fm5gZDKdUsJXSHVn4cjWI=;
 b=g4TnumHLFiPw69btZ3yqwrHBSYRAHCwRkgrV4AxTLmOAuVk2XMSODIvzqlDfKvVFDO
 Fxy4QvCBCArsH6cRMdmVqpo2wUtnrLaC3wLu6+OHwL9Rg0IQSbENZfttyeGM8ZhH87Rp
 G3l/8zIcPc12vXGhoCMUJZlBDNXkCeGntXL2FoCA21GgZNl8DPTktHEs0vKOLWb1OHlp
 UA/lE3JXqORgPZaI4aiBE3TFti/GHzUOBR9y3y5VjRYm3miALo91Y6ITUb5hJfmoOMfW
 w1j80aK9yG8JU3i22HjDJJhMku6UuIIJizO7Z703Y1T8OjcWT8IiqQq403lfHloWURIA
 yU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x5NhGqJcQdDjCfeklYPaB2fm5gZDKdUsJXSHVn4cjWI=;
 b=GAZw2gHbY6fImx294yvfWg0EBdhblNmJA3AQK/PNOEgKmBeim3MpdcF5kg1oB0cEla
 nR1ZzPY9qzC2vSIBclC4QejqpX7w/Zb/r1zhpMu5U5vpq5JugvOZyGzXEKr0s02ZlWbj
 3wkAwr9cq5EZ8wGckwClsDO3R7DVU3YYYanG9IFxRnlgEgRm5KUNuqogpp3eHxaYG18Q
 9B8bMZT/aIAQ62WUclxumCXCmTD3U0zshixWqbtFR/GKbYBAZ0ooD7V4QibzgF32XFRV
 TlDqCjdmPXq/QBQ+1/3VzHgngnvzfd4JCkXffdknLztz7KZL2TRpYSdYDUZI/JzX3Ffg
 iADw==
X-Gm-Message-State: AOAM530IqwNQRkgelz3TW38OlCfFw3CWHVOzrH0EmNDlOrb5VcQ2n89P
 ai45UnvGMhbToMkJji/Jb+is0GMb
X-Google-Smtp-Source: ABdhPJxozP6ntsSRzvVkwwnTeVxciuFt7+nrgX/Bmb/s4LG8CZfn53njVCFWEL9SPEz63WXai/+XIw==
X-Received: by 2002:a50:a6d0:: with SMTP id f16mr23061367edc.7.1596046870635; 
 Wed, 29 Jul 2020 11:21:10 -0700 (PDT)
Received: from [192.168.1.39] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id b10sm1481439edr.13.2020.07.29.11.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 11:21:10 -0700 (PDT)
Subject: Re: [PATCH 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200727214608.32710-1-deller@gmx.de>
 <20200727214608.32710-2-deller@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a559501-3a8a-f778-6058-5407043bd1f7@amsat.org>
Date: Wed, 29 Jul 2020 20:21:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200727214608.32710-2-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 11:46 PM, Helge Deller wrote:
> The hppa_hardware.h file is shared with SeaBIOS. Sync it.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/hppa_hardware.h | 6 ++++++
>  hw/hppa/lasi.c          | 2 --
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
> index 4a2fe2df60..cdb7fa6240 100644
> --- a/hw/hppa/hppa_hardware.h
> +++ b/hw/hppa/hppa_hardware.h
> @@ -17,6 +17,7 @@
>  #define LASI_UART_HPA   0xffd05000
>  #define LASI_SCSI_HPA   0xffd06000
>  #define LASI_LAN_HPA    0xffd07000
> +#define LASI_RTC_HPA    0xffd09000

I find the line you are removing cleaner:

-#define LASI_RTC_HPA    (LASI_HPA + 0x9000)

"Offset in the LASI memory region".

Anyway not a blocker.

Having these values sorted would help.

>  #define LASI_LPT_HPA    0xffd02000
>  #define LASI_AUDIO_HPA  0xffd04000
>  #define LASI_PS2KBD_HPA 0xffd08000
> @@ -37,10 +38,15 @@
>  #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
>  #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)
> 
> +/* QEMU fw_cfg interface port */
> +#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
> +
>  #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
>  #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
> 
>  #define HPPA_MAX_CPUS   8       /* max. number of SMP CPUs */
>  #define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */
> 
> +#define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS internal) */
> +
>  #endif
> diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
> index 19974034f3..ffcbb988b8 100644
> --- a/hw/hppa/lasi.c
> +++ b/hw/hppa/lasi.c
> @@ -54,8 +54,6 @@
>  #define LASI_CHIP(obj) \
>      OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)
> 
> -#define LASI_RTC_HPA    (LASI_HPA + 0x9000)
> -
>  typedef struct LasiState {
>      PCIHostState parent_obj;
> 
> --
> 2.21.3
> 
> 


