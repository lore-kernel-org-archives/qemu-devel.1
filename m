Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2231C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C7920735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 05:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ1b1wqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C7920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1N3-0006s8-U3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1MK-0006RQ-D1
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:52:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1MJ-0004Ys-9u
 for qemu-devel@nongnu.org; Mon, 11 May 2020 01:52:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id g14so5944976wme.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=462f2OuJJXinybiWqUpUzujWwlIAZiGVzrgw6i7oSUY=;
 b=BQ1b1wqhUT6LpNdYGg9G87oeQsluXIYBDgTNRgr3TNhbpXncWfcIa31UTn3nhyIKaZ
 +ljoghgNQCzXc36T3bfE/Lnb2oK2IafmR2WsHWlHxynN6uD+6FqXV2WE/Rvf7qa6PlnR
 vTmnLaxYon0W3iWyex4V7+xQeWyo7ONQOYfHC7XD4EnqlCQOVpK04A13QHZinX0KGuq7
 EtMSzvyL59VwZUiIB2BWMgsgdz3OFckK+QpMiXbEw4IhgZa1wco1zL4KrOtB7+Vhd/r0
 aSDMNMGiHvdwtRooyY85fkmy4IIasV4NskLEzFf8so3JmRykjbxl/MlEy4hWaGTgTOxv
 nl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=462f2OuJJXinybiWqUpUzujWwlIAZiGVzrgw6i7oSUY=;
 b=IrsIMSlbqU+5wkpdYEn8yED+APqs3HogfR5GSdRf1R6ftJSSimGND2KnMB91m5Tgq2
 LBqzvMSsqyNWuw4ey0o9EwwS5rcKDIuZPaL9xOw3Roj6DmdqpeUX/KAayj/KIwErcZQa
 PLMHwFINfLLJX0kqNDGH40po5I/527qA0WmBah2DUbuYW7RqoEY3LSV+TvGSjHCSj2jQ
 B0sesN2K+aGT5sXcGRJrGr8EKvsAwO5iaEHv60OgH1Tq2Hp2tL3TgBRdiTBDxNx5zQU4
 qCVOEo5ESqFed4m1G+/sbTWz+npFTlD//bILTyXrqO2+j++karwVpY3xOd0DczlB9qQU
 nskA==
X-Gm-Message-State: AGi0PuZPB1IHpwTldGAmpbte6IcPq9zDlnheFcUxaeirXw0BSSkF/x/M
 t8pfnU1owL1rnVLH30s2mdYmPE/f64aw0ghYZzI=
X-Google-Smtp-Source: APiQypJpAW8PWfn7tY+kw56l6FP7j0gxiBLwN2DbjgyckY6EjscQbAOtGnaNjJPZsfIpH0Azew6OWSdMVpWUaYn82bs=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr32257316wmc.168.1589176329744; 
 Sun, 10 May 2020 22:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-9-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-9-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 07:51:50 +0200
Message-ID: <CAHiYmc45ayKzTg75375S5vJktcmQXu=qSKztzmxQ3RoVuaBz_Q@mail.gmail.com>
Subject: Re: [PATCH 08/12] hw/pci-host/bonito: Map all the Bonito64 I/O range
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> To ease following guest accesses to the Bonito64 chipset,
> map its I/O range as UnimplementedDevice.
> We can now see the accesses to unimplemented peripheral
> using the '-d unimp' command line option.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 3 +++
>  hw/pci-host/Kconfig  | 1 +
>  2 files changed, 4 insertions(+)
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 7ed462ffb5..9761780f44 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -48,6 +48,7 @@
>  #include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
>  #include "exec/address-spaces.h"
> +#include "hw/misc/unimp.h"
>
>  /* #define DEBUG_BONITO */
>
> @@ -644,6 +645,8 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      sysbus_init_mmio(sysbus, &phb->data_mem);
>      sysbus_mmio_map(sysbus, 2, BONITO_SPCICONFIG_BASE);
>
> +    create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SI=
ZE);
> +
>      memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s=
,
>                            "ldma", 0x100);
>      sysbus_init_mmio(sysbus, &s->iomem_ldma);
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 8db41edc7e..036a61877a 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -58,4 +58,5 @@ config PCI_EXPRESS_DESIGNWARE
>
>  config PCI_BONITO
>      select PCI
> +    select UNIMP
>      bool
> --
> 2.21.3
>

