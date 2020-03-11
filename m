Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D893C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6305020727
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCtuBLj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6305020727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Ak-0006pO-Jp
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1sD-00085Z-W1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jC1sC-00044C-Iz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jC1sC-00042x-AF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:58:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id r7so3240266wmg.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=DyujtRVJDUvGTz1RJPeCTZdw8b14i6MgtBnZu1r0+e8=;
 b=SCtuBLj9aTwra9v/S9xQ4+uuUSvnoKyg5wj3a+V/5tmoPseCyWWS8ZPTRm3f3+xnZC
 ZspixT2ANiiA4roY4+FVRSE4JSHPUPk0J5K8fE3YkTiFw3aEPgdjiu/wJpdybtvyQ4IR
 OKbP9VqKG5wPKi5dmH1h3XvyKguPfB6HcZJ6mpMzy3envfyI7qbPfzVjaKKwitBfCJVx
 YKgx362RPpT2BliLnxf3WYBUb7QuPGzNKSjC9PMWD4rCMa802MQ4eL3RllckLdVdBipS
 GVFTEEv81b5lFK2OzBCVKvMUyjusac3UQ0mj8zBs7PK1DDPdgFC+WALSwV2R1sVMNSKh
 a96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=DyujtRVJDUvGTz1RJPeCTZdw8b14i6MgtBnZu1r0+e8=;
 b=odiHzbOwVPtVyp1K3TQV10iB8fsKPnTjK9RJso7jGf7qcIHfbN2FqQY/KibDDKx0Kl
 rZAOKIRg3DdS90gOHcU5AseHIymzpjODT0L5DGoZrzSFHe+0D1lw5Fv+yxmuQiTMvXnD
 FIbEdIIDFhTutzmGQ6TIMu3MiA9GxMaDqpj8BFtzlUHPNIerGZM3b5jYguH7go1xCuzL
 EBwHRLU3Q6X3zMK6xubzo3F2KoUszvWOA5zZk3SnAkCbiDxRX1e0rt74/yvvA9Q6la88
 uBSe8guzt3GMv0aQkBs4FZUh3x0oMyaCvNSS8cOOh3qrRJLQVD28i2pYGTbAPXoHzQWC
 f3rg==
X-Gm-Message-State: ANhLgQ2ywSpPt0NjbSyjpmFOTgsJtlb6+LN61fPwoLxUzhuwDlwW56b3
 OzpS9E87fZUyTjFBs2oXboNL+g==
X-Google-Smtp-Source: ADFU+vvHNlBalzpclENNbNmu0hp0dq1zOb/OtNND0Z3mjg4RFbHV71L86+mH4ArHDjyHhSdwk8xWyg==
X-Received: by 2002:a05:600c:22d9:: with SMTP id
 25mr122743wmg.41.1583935091041; 
 Wed, 11 Mar 2020 06:58:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm7468162wmi.40.2020.03.11.06.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 06:58:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 250861FF7E;
 Wed, 11 Mar 2020 13:58:09 +0000 (GMT)
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
 <20200310213203.18730-11-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v7 10/18] hw/arm/allwinner-h3: add Boot ROM support
In-reply-to: <20200310213203.18730-11-nieklinnenbank@gmail.com>
Date: Wed, 11 Mar 2020 13:58:09 +0000
Message-ID: <87eetzgfim.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> A real Allwinner H3 SoC contains a Boot ROM which is the
> first code that runs right after the SoC is powered on.
> The Boot ROM is responsible for loading user code (e.g. a bootloader)
> from any of the supported external devices and writing the downloaded
> code to internal SRAM. After loading the SoC begins executing the code
> written to SRAM.
>
> This commits adds emulation of the Boot ROM firmware setup functionality
> by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
> 64KiB, we limit the size to 32KiB because the real H3 Boot ROM also rejec=
ts
> sizes larger than 32KiB. For reference, this behaviour is documented
> by the Linux Sunxi project wiki at:
>
>   https://linux-sunxi.org/BROM#U-Boot_SPL_limitations
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>  include/hw/arm/allwinner-h3.h | 21 +++++++++++++++++++++
>  hw/arm/allwinner-h3.c         | 18 ++++++++++++++++++
>  hw/arm/orangepi.c             |  5 +++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
> index f9b9a02373..d338003724 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -46,6 +46,7 @@
>  #include "hw/sd/allwinner-sdhost.h"
>  #include "hw/net/allwinner-sun8i-emac.h"
>  #include "target/arm/cpu.h"
> +#include "sysemu/block-backend.h"
>=20=20
>  /**
>   * Allwinner H3 device list
> @@ -129,4 +130,24 @@ typedef struct AwH3State {
>      MemoryRegion sram_c;
>  } AwH3State;
>=20=20
> +/**
> + * Emulate Boot ROM firmware setup functionality.
> + *
> + * A real Allwinner H3 SoC contains a Boot ROM
> + * which is the first code that runs right after
> + * the SoC is powered on. The Boot ROM is responsible
> + * for loading user code (e.g. a bootloader) from any
> + * of the supported external devices and writing the
> + * downloaded code to internal SRAM. After loading the SoC
> + * begins executing the code written to SRAM.
> + *
> + * This function emulates the Boot ROM by copying 32 KiB
> + * of data from the given block device and writes it to
> + * the start of the first internal SRAM memory.
> + *
> + * @s: Allwinner H3 state object pointer
> + * @blk: Block backend device object pointer
> + */
> +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk);
> +
>  #endif /* HW_ARM_ALLWINNER_H3_H */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index d1245d2b01..56b5c563a8 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -29,6 +29,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/usb/hcd-ehci.h"
> +#include "hw/loader.h"
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/allwinner-h3.h"
>=20=20
> @@ -170,6 +171,23 @@ enum {
>      AW_H3_GIC_NUM_SPI       =3D 128
>  };
>=20=20
> +void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk)
> +{
> +    const int64_t rom_size =3D 32 * KiB;
> +    uint8_t *buffer =3D g_new0(uint8_t, rom_size);

There is an opportunity to use g_autofree here so you can skip..

> +    g_free(buffer);
> +}
> +
<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

