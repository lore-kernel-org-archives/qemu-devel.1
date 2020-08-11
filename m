Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C462C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8A320771
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTpdHORB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8A320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WqO-0001VI-Bv
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5WpW-0000eH-Sa
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:08:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k5WpV-00073b-CD
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:08:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id f12so11999838wru.13
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YaydI5DnqVIOEZI+zE7mxYIoADSmEKTlSCzmKqHz+yQ=;
 b=WTpdHORBhLxFCoYSRP0FF7m5Xx4osthDD34qhVF4clApj1uV8wSCIZCirv4RGMnYBL
 AW5YqobAbSeVeaiLQ4toIw3OzSuCC0LnP35MsPwSOT274US1tI0a0R1g23xWi+3LTUSK
 Ho2izp/IBTSmBSLAOCRp0CFiadmoD3DjDiCytBY4YP0HPMAF0lYU7cTgQYAVC4yy9qRm
 QJRd8ovZ4eeEiekibg/DbRvLg+ZLBRlfxEGogN3MO7Nb/K6Ygg/zsHxaGtw7RR97h5kW
 Xsal++RlcPHG73WEq4iXKyf12sFGkpoNW9/VLi9/KxyahoXBjQjd3DFpgysw3esxedR2
 gAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YaydI5DnqVIOEZI+zE7mxYIoADSmEKTlSCzmKqHz+yQ=;
 b=ahmT3W0MYygGA+vrVz1lfqnBmvz/+SNpPkhzORl9kWwhLzqMmVLMZNdr/lvBiatjNI
 A2JZJbLS2tRfdDPsZ6WA/GKe4JvDuXMhZ56XYhxODNvrsoXulAB9sz8BQdKEVV/lUiLN
 6c5gDUMZnx8yTIpHa6zRBz5aavGjhcrqRF2KdIR+0jf78N5rUNjxKFUZcCWxIxVoKuFi
 w0gcYFIRBxpXA8G/Or4WyG80r+cCK98q70RfDBb0hXToq3ym2C7Aax+YgREuGLWWZG8N
 jvSiIiExSTFaRMVuIYevWLWVq/tplDqK1q329IVsBrYJEl5B5sNvNjZw+imnp5qeFkdT
 zeIQ==
X-Gm-Message-State: AOAM531CTH5Jj/usf09UYcdMVcX3PHvyOYIZE8s52I9+zqe4Zo9qrfeY
 Csk1DXfYqlZ7QEozx52Dnq8=
X-Google-Smtp-Source: ABdhPJy7Q68sKUCwmSQ2fyKHPxfroGy5P1zyjAylS/iJF4UA2cMkb9f7LIwZFVVm9BV1oLhKNYNqug==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr28602737wrc.194.1597162127677; 
 Tue, 11 Aug 2020 09:08:47 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 15sm5633451wmo.33.2020.08.11.09.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:08:46 -0700 (PDT)
Subject: Re: [PATCH 114/147] meson: convert hw/gpio
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-115-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd5b25ab-0374-d2c5-5eab-d4aebc585119@amsat.org>
Date: Tue, 11 Aug 2020 18:08:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597079345-42801-115-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

On 8/10/20 7:08 PM, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/Makefile.objs      |  1 -
>  hw/gpio/Makefile.objs | 12 ------------
>  hw/gpio/meson.build   | 12 ++++++++++++
>  hw/meson.build        |  1 +
>  4 files changed, 13 insertions(+), 13 deletions(-)
>  delete mode 100644 hw/gpio/Makefile.objs
>  create mode 100644 hw/gpio/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index a2c2f6d..c04dfe5 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -8,7 +8,6 @@ devices-dirs-y += char/
>  devices-dirs-y += cpu/
>  devices-dirs-y += display/
>  devices-dirs-y += dma/
> -devices-dirs-y += gpio/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/gpio/Makefile.objs b/hw/gpio/Makefile.objs
> deleted file mode 100644
> index 3cfc261..0000000
> --- a/hw/gpio/Makefile.objs
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -common-obj-$(CONFIG_MAX7310) += max7310.o
> -common-obj-$(CONFIG_PL061) += pl061.o
> -common-obj-$(CONFIG_PUV3) += puv3_gpio.o
> -common-obj-$(CONFIG_ZAURUS) += zaurus.o
> -common-obj-$(CONFIG_E500) += mpc8xxx.o
> -common-obj-$(CONFIG_GPIO_KEY) += gpio_key.o
> -
> -common-obj-$(CONFIG_OMAP) += omap_gpio.o
> -common-obj-$(CONFIG_IMX) += imx_gpio.o
> -common-obj-$(CONFIG_RASPI) += bcm2835_gpio.o
> -common-obj-$(CONFIG_NRF51_SOC) += nrf51_gpio.o
> -common-obj-$(CONFIG_ASPEED_SOC) += aspeed_gpio.o
> diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
> new file mode 100644
> index 0000000..6bcdfa6
> --- /dev/null
> +++ b/hw/gpio/meson.build
> @@ -0,0 +1,12 @@
> +softmmu_ss.add(when: 'CONFIG_E500', if_true: files('mpc8xxx.c'))
> +softmmu_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
> +softmmu_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
> +softmmu_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
> +softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_gpio.c'))
> +softmmu_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
> +
> +softmmu_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
> +softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
> +softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
> +softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
> +softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
> diff --git a/hw/meson.build b/hw/meson.build
> index f9e5adf..52577c3 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,4 +1,5 @@
>  subdir('core')
> +subdir('gpio')
>  subdir('hyperv')
>  subdir('i2c')
>  subdir('ide')
> 


