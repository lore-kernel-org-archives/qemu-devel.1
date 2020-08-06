Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E083221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5pO49Jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E083221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ngv-0002rE-J2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ngC-0002Ni-9v
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:44:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3ngA-00084r-Od
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:44:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so606wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=er2wHwzUkxcMi1XvMJRb8yy0JtypYu5j1wJyRkuS+2I=;
 b=H5pO49JjBqnBxaooCYYiPlx6uIA4R1a6scNRgi5yPLYI/x41VJ2h0H477yjbB//IVt
 B2ppeoxYNSyVVHy5jfzSk1TgC/JdJt6Xz65Hg7F59StV3b4KZ4ZUPqP/Zt9M7iMZ+mz8
 tx0gfNAOiejBc2a0CLXe1BaponoEC7k9el+yv8vanX5QIEkCyvla5XVnK0g1lsYi3zc9
 yQzW3pk/h+/0/IBkSDqt2bilqbcklEFPL8eG2UirVxwH3sqnd6zdpSU0UdO/75L7MFXZ
 AtJVT8gsBlOq1GB7thH7qQEjlXNgj1DYZbT97jFTG9DXPoSHOyxQN6mJj1CtEi/i0AYP
 buSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=er2wHwzUkxcMi1XvMJRb8yy0JtypYu5j1wJyRkuS+2I=;
 b=X9yDNff6zbjMDsRbZTvD8cc8tUmrGbs3+iuiPWTFi9rm81yP4rAxwTn1euGXnH3nk+
 s8KxAb0RkOXpQblwChgDg6YxQTcvaZ9TjvwmgUCLZVwdVueBteMrvgVYgGRvqqmuvwo2
 Y6ISlNtXJiaNukYMkb8jrQrrWfrUCWpY6uu0abjE+VlGM/lgsPOqMrcSDpFm/+SX3ZAv
 JPdMl621htpEMwRSJkDIBicT9V6QVWB7bTR/2D1Kmpdkqs67EMuN3nyfzdQCNKVXCv+g
 g7KRuUNczDi9I1bwtBqRdfe9XBzOA0gY/TZSA/jnBwqLegrn7D/G6Kt1rPnis9zJHEXA
 fXiQ==
X-Gm-Message-State: AOAM5303T2BqU+rCeQnKM+MUrFl2iUGtpayviO8+FfppTu4dqRLiFFfH
 p/0k1MdfjfNHVWvqpV568Ts=
X-Google-Smtp-Source: ABdhPJwWm0Iu4szKbZp9HUTI0W3O4KyxXYghDSQ/xw+CeFAps53yxctyrGTqiLttA2HsonfVQYt0Lw==
X-Received: by 2002:a1c:1bce:: with SMTP id b197mr9706004wmb.32.1596750240885; 
 Thu, 06 Aug 2020 14:44:00 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id f63sm7954559wmf.9.2020.08.06.14.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 14:44:00 -0700 (PDT)
Subject: Re: [PATCH 095/143] meson: convert hw/sd
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-96-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f4c200b6-b280-126a-11b3-573f2fc3a65d@amsat.org>
Date: Thu, 6 Aug 2020 23:43:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1596741379-12902-96-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 9:15 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/Makefile.objs    |  1 -
>  hw/meson.build      |  1 +
>  hw/sd/Makefile.objs | 12 ------------
>  hw/sd/meson.build   | 12 ++++++++++++
>  4 files changed, 13 insertions(+), 13 deletions(-)
>  delete mode 100644 hw/sd/Makefile.objs
>  create mode 100644 hw/sd/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index e50eb04..6f9c0b7 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -25,7 +25,6 @@ devices-dirs-y += pci/
>  devices-dirs-$(CONFIG_PCI) += pci-bridge/ pci-host/
>  devices-dirs-y += pcmcia/
>  devices-dirs-$(CONFIG_SCSI) += scsi/
> -devices-dirs-y += sd/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/meson.build b/hw/meson.build
> index 7564426..a73f4ae 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -2,6 +2,7 @@ subdir('core')
>  subdir('mem')
>  subdir('nubus')
>  subdir('rtc')
> +subdir('sd')
>  subdir('semihosting')
>  subdir('smbios')
>  subdir('ssi')
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> deleted file mode 100644
> index 0d1df17..0000000
> --- a/hw/sd/Makefile.objs
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -common-obj-$(CONFIG_PL181) += pl181.o
> -common-obj-$(CONFIG_SSI_SD) += ssi-sd.o
> -common-obj-$(CONFIG_SD) += sd.o core.o sdmmc-internal.o
> -common-obj-$(CONFIG_SDHCI) += sdhci.o
> -common-obj-$(CONFIG_SDHCI_PCI) += sdhci-pci.o
> -
> -common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sdhost.o
> -common-obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
> -common-obj-$(CONFIG_OMAP) += omap_mmc.o
> -common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
> -common-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
> -common-obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
> diff --git a/hw/sd/meson.build b/hw/sd/meson.build
> new file mode 100644
> index 0000000..b43e59b
> --- /dev/null
> +++ b/hw/sd/meson.build
> @@ -0,0 +1,12 @@
> +softmmu_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
> +softmmu_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c', 'sdmmc-internal.c'))
> +softmmu_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
> +softmmu_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
> +softmmu_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-memcard.c'))
> +softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_mmc.c'))
> +softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
> +softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
> +softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
> +softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


