Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E361C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162F32075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0aF8lYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162F32075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k43dS-0005oQ-7F
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 10:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k43ci-00050o-2g
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:45:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1k43cg-00077e-Be
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 10:45:31 -0400
Received: by mail-ot1-x342.google.com with SMTP id k12so1790683otr.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=K8SWbLxzcL3axd6Jd2bv0FfGo3b4oSekGNesWsTnJWQ=;
 b=n0aF8lYDcHOaA68GyGnlbCISYOSm0zl8F7O8f1pSVZ944TLtWI2pqVQKYbL38zdZEK
 cEAl0+hXRo/yNSNz1l2+zeBGfABNNjBvFq1MEFERNAfKAqTlYdK0JhzcXtmLv49gZl/m
 5nADIqEcY1ThSfBZZBRwpTyvyCF3guJEibfq+R0GiItwWEinTICsydixaJ6eu3TEle+m
 RmvUVQtXzAeJmTgDX/Rn5s8bcGh7fq2mWBCE/mSPbjgKMjO9yF56aYugrsCQpOsvDaKR
 VOY2zLuFEtFHt3mmk1mujiVoNu6squQcv6Zl3VRB+Y+ggki1FR7qOhIiEll38LoFUNzC
 0Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=K8SWbLxzcL3axd6Jd2bv0FfGo3b4oSekGNesWsTnJWQ=;
 b=dEZemLQkaY81p8KCSDsUVwnZCaxCrIPbLbm6Tm9vZoPp8O86/kF3G5OZf3LV+sllaH
 RnXWFsQK/2Xy2KWoVeGIkKj5D6jbp4CBjJZjCOnty2CIVmHSN2gF/E5K2QcPMXbaxjyj
 5XiL5cfNmO8vo9wGnwnk6SGMW2yb3ID98xDCVN1vv/6JIJfW07GIc++6RqxBP+8SZBcj
 B88n5fESa0YDe7tk/XuUa8iabxPkPqbotpX9Sbekx9nBVjocKpnK/Om9fR9CDx30KDv4
 Q7NOPuYoHSiOAUmrXTK6WwdkDrZZB8uMTg933YlD5THnsZd3Mnb8vdxmw46jDOZgdf4U
 yY8A==
X-Gm-Message-State: AOAM532dtsAsTcR2cjNtwJ48rBlFJ53ypJMm+QFo1FKKfxBXRlWf3YyH
 0slURkVIvnDHtm/hHsOkjvYIfBQ=
X-Google-Smtp-Source: ABdhPJwo93GjiNcs7TifD++BNYB6nKl1+DR8nUCP4McqPrNsi1f52LpQp40m+UqFpeaAzg2i45KWRQ==
X-Received: by 2002:a9d:1c9c:: with SMTP id l28mr12756807ota.127.1596811528924; 
 Fri, 07 Aug 2020 07:45:28 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
 by smtp.gmail.com with ESMTPSA id q189sm1803500oic.15.2020.08.07.07.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 07:45:28 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:c8ac:a9c:4367:4c28])
 by serve.minyard.net (Postfix) with ESMTPSA id 6784418055B;
 Fri,  7 Aug 2020 14:45:27 +0000 (UTC)
Date: Fri, 7 Aug 2020 09:45:26 -0500
From: Corey Minyard <minyard@acm.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 111/143] meson: convert hw/i2c
Message-ID: <20200807144526.GL2842@minyard.net>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <1596741379-12902-112-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596741379-12902-112-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x342.google.com
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
Reply-To: minyard@acm.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 09:15:47PM +0200, Paolo Bonzini wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/Makefile.objs     |  1 -
>  hw/i2c/Makefile.objs | 14 --------------
>  hw/i2c/meson.build   | 16 ++++++++++++++++
>  hw/meson.build       |  1 +
>  4 files changed, 17 insertions(+), 15 deletions(-)
>  delete mode 100644 hw/i2c/Makefile.objs
>  create mode 100644 hw/i2c/meson.build
> 
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 02c5c0d..22eb804 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -10,7 +10,6 @@ devices-dirs-y += display/
>  devices-dirs-y += dma/
>  devices-dirs-y += gpio/
>  devices-dirs-$(CONFIG_HYPERV) += hyperv/
> -devices-dirs-$(CONFIG_I2C) += i2c/
>  endif
>  
>  common-obj-y += $(devices-dirs-y)
> diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
> deleted file mode 100644
> index f2c61ea..0000000
> --- a/hw/i2c/Makefile.objs
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -common-obj-$(CONFIG_I2C) += core.o
> -common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
> -common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
> -common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
> -common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
> -common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
> -common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
> -common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
> -common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
> -common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
> -common-obj-$(CONFIG_NRF51_SOC) += microbit_i2c.o
> -common-obj-$(CONFIG_MPC_I2C) += mpc_i2c.o
> -common-obj-$(CONFIG_OMAP) += omap_i2c.o
> -common-obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> new file mode 100644
> index 0000000..3a51153
> --- /dev/null
> +++ b/hw/i2c/meson.build
> @@ -0,0 +1,16 @@
> +i2c_ss = ss.source_set()
> +i2c_ss.add(when: 'CONFIG_I2C', if_true: files('core.c'))
> +i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
> +i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
> +i2c_ss.add(when: 'CONFIG_ACPI_X86_ICH', if_true: files('smbus_ich9.c'))
> +i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_MPC_I2C', if_true: files('mpc_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('microbit_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_SMBUS_EEPROM', if_true: files('smbus_eeprom.c'))
> +i2c_ss.add(when: 'CONFIG_VERSATILE_I2C', if_true: files('versatile_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
> +softmmu_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
> diff --git a/hw/meson.build b/hw/meson.build
> index 4d7c31c6..983edc1 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -1,4 +1,5 @@
>  subdir('core')
> +subdir('i2c')
>  subdir('ide')
>  subdir('input')
>  subdir('intc')
> -- 
> 1.8.3.1
> 
> 
> 

