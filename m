Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227F3C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29172064B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNj/8Y+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29172064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxbM-0000Tu-53
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhx9S-0004xU-9c
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhx9M-00082G-79
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:19:23 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhx9K-0007o7-OG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:19:19 -0400
Received: by mail-ot1-x343.google.com with SMTP id x21so13624138otq.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M0bHov4AsMs+15g5Y8TaVCAZ0ewX/G2VwigLTPONJMo=;
 b=BNj/8Y+lyNYGiJCjI29HgDCsVw4KziBSXGJ1hYmClENkCGgghV3vXS7vzk63zl5ckQ
 cUoTZQlnzvnHBLzYbaJq8UW7TfGabi3cxVYFy4xc/OIR2+Nn5Clu7sQFDLR0uLUjtZ+P
 IUdpq/ot6/V02mAusbTUcTdWOVdFDadjWNqJRES/Uzp/5n0RovL2j5Cof1ZSzdl+Bs3s
 g0V59s6k74tOUXdxG8MTcBWhwE9eWRE6cWipqDkAeidw8bUUkwMHh1nmdtQ3bvOJpikj
 Qnzr2kNuW1p2483Se+eqNx9mn2R0MaQsbSJntUa0cEe4rvwGPNSGqpFjOsXWu+6qIQ9t
 AaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M0bHov4AsMs+15g5Y8TaVCAZ0ewX/G2VwigLTPONJMo=;
 b=nDXSDFzzkuNEtHnciXJ/Hatdj7DOA523RQOZudXte+f6TsPjHKhvKg2xnlit+1DAO/
 Ce8L39/92JC05KuodQBFXUsGjKZMePH55D7qekPddCNytGdbt9af2UVmczm9eWIMekFs
 6rrFiUh+9nNgP0NMb9EWtKjDiz3gBgggVMwUT/NNdn0n+0tSiSp8bbCbugHbIhy20ycU
 uLGIaphu5onC3hiOCD6LFuE35F5PvUq5VMis70tcMiPu5fSSiBYftUcDZAwH3lsXEOZM
 Y6zbiE7nQzcA3rAtBAApQ1H9tjh2nVf6XiTy2paCaNJSXXEv998JW9/TCUS+m5XIj+TW
 j9gg==
X-Gm-Message-State: APjAAAU0CP+6yVzyBWVQjGyy5ZonuLmFxnTQMtNJN841er85c+xBLcJB
 nPkGUUhHX0+w4P/8b7PFyh3x8UFKeyrZsSO71ykR7icpuqM=
X-Google-Smtp-Source: APXvYqwHuA8HP24RqwJBTdwMTPlFOjtMiwLr9po+7+31BfDmCVmLSk55HmmdRFm0DjbMCyHcAYSAahdCUUusDXIIgU0=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20759321otk.232.1561990743623; 
 Mon, 01 Jul 2019 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:18:52 +0100
Message-ID: <CAFEAcA8qi7zRiLwDP38cPax=gAfEK8WQm0i9ZxDLXeESqh79Wg@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v9 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 30 Jun 2019 at 11:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.
>
> This patch introduces new machine type 'sbsa-ref' with main features:
>  - Based on 'virt' machine type.
>  - A new memory map.
>  - CPU type cortex-a57.
>  - EL2 and EL3 are enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus EHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - No virtio deivces.
>  - No fw_cfg device.
>  - No ACPI table supplied.
>  - Only minimal device tree nodes.
>
> Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> it should supply ACPI tables to load OS, the minimal device tree nodes
> supplied from this platform are only to pass the dynamic info reflecting
> command line input to firmware, not for loading OS.
>
> To make the review easier, this task is split into two patches, the
> fundamental sceleton part and the peripheral devices part, this patch is
> the first part.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Kconfig                  |  16 +++
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/sbsa-ref.c               | 281 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 299 insertions(+)
>  create mode 100644 hw/arm/sbsa-ref.c
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 1f2e0e7..f9fdb73 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -19,6 +19,7 @@ CONFIG_SX1=y
>  CONFIG_NSERIES=y
>  CONFIG_STELLARIS=y
>  CONFIG_REALVIEW=y
> +CONFIG_SBSA_REF=y
>  CONFIG_VERSATILE=y
>  CONFIG_VEXPRESS=y
>  CONFIG_ZYNQ=y

Adding CONFIG_SBSA_REF=y here is what makes the board
model available for the 32-bit-only qemu-system-arm.
If you put it in aarch64-softmmu.mak instead it will
be correctly restricted to the 64-bit binary.

> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 9aced9d..18e47b2 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -184,6 +184,22 @@ config REALVIEW
>      select DS1338 # I2C RTC+NVRAM
>      select USB_OHCI
>
> +config SBSA_REF
> +    bool
> +    imply PCI_DEVICES
> +    select A15MPCORE

This looks like a leftover from the virt config?

> +    select AHCI
> +    select ARM_SMMUV3
> +    select GPIO_KEY
> +    select PCI_EXPRESS
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select PL011 # UART
> +    select PL031 # RTC
> +    select PL061 # GPIO
> +    select PLATFORM_BUS

I don't think you use the platform-bus either, do you?

> +    select USB_EHCI_SYSBUS
> +
>  config SABRELITE
>      bool
>      select FSL_IMX6

thanks
-- PMM

