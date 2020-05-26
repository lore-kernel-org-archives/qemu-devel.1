Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA50C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3902084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCJddw6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3902084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXKj-0000pq-CB
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdXJh-00006K-Le
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:00:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdXJf-0003la-6j
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:00:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id i15so19904585wrx.10
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6ljs56qZaMwBlCbaq7gUcLmkUzUynFO0aa1hNwwJm/8=;
 b=SCJddw6em1xV9JSIrUzmF/JiJlFtlfiYc1U4GX/eNfRVI1jFf0hdZQt05zXMv4GXRh
 4eQWKW/E7N3pldL6K8FyeyefrDQyOQqREDHAGNwv+js9Ujy8l6b78rhgIDF7rcIpSuBH
 4RqhPbwiDdcei/AyJCMwoXm20h+R18hd/A84v8boAMXGF8xk+4+2fwZjJYfPrThI7iJm
 Xo+Yy4D+p75EQyrP63BoPqbEfU7DyXb+v6QVaEvrHduj7dM8ynqBsvwMUKikiHfuFNuY
 GoE9+CR0tbn8X+ckb5hh2A47CozxC86aJQ6SrZcS3m2JplqIVY/29KiKlOYbfaWVFYGu
 gY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6ljs56qZaMwBlCbaq7gUcLmkUzUynFO0aa1hNwwJm/8=;
 b=qWIQxVp+UdIcbO6qkcrnvlop7p/L4ICA9JJeVVonjq/RlFMn5Je0bUsFV5OGXFcGGL
 JH9fN7YxNrDYbefUk60cuhOf9zvLVa5Emnv264H4MjVLFbi0dVGoSqf7jWfX9LrXIRgP
 z1eYLb74n4LgdUW4KZup5kPd4iVA/XH2B4nqt+I9cSB+Dyjfe40nDgA0ETQtk6K7ARqS
 iqKhAzUaesmxgZNjvugdUlpoMUjfmSJM/g3GWDmcJqD0d9uYAciDStrgU/V3HtXSTfta
 lQNWnl4RWZusiToQX4Q8H6i5VhcFHj28N6t9hF+ooiMczqOjoElC4YfU9NCFAF38rCRQ
 roOg==
X-Gm-Message-State: AOAM531IKAyQdbf1q/0B2WPjfxAo/npcuS06FhTGYQrld0bdoUCYDiP6
 5WSOwVv0CNHFAfDg3ucaKPiyUBdV0X0letYOPLc=
X-Google-Smtp-Source: ABdhPJzedNR3O8E9N2dlt3hy6Z+IdLZORpM7Af+f7yIaAwxBNL3gKOrbZmCnecTp2U5ZRnQBetWFSkpZG4auSBkHgKI=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr19194927wrq.162.1590490813660; 
 Tue, 26 May 2020 04:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <20200526104726.11273-7-f4bug@amsat.org>
In-Reply-To: <20200526104726.11273-7-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 12:59:59 +0200
Message-ID: <CAHiYmc69Y+ETD7fhKA+7MfXo+1k+XS9sCGcHx_rHD7o9oUefGg@mail.gmail.com>
Subject: Re: [PATCH 06/14] hw/pci-host/bonito: Map the different PCI ranges
 more detailled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:47 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Better describe the Bonito64 MEM HI/LO and I/O PCI ranges,
> add more PCI regions as unimplemented.
>
> Message-id: <20200510210128.18343-10-f4bug@amsat.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index f09bb1c6a8..52015cc2a7 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -39,6 +39,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/pci.h"
>  #include "hw/irq.h"
> @@ -82,7 +83,7 @@
>  #define BONITO_PCILO1_BASE      0x14000000
>  #define BONITO_PCILO2_BASE      0x18000000
>  #define BONITO_PCIHI_BASE       0x20000000
> -#define BONITO_PCIHI_SIZE       0x20000000
> +#define BONITO_PCIHI_SIZE       0x60000000
>  #define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE -=
 1)
>  #define BONITO_PCIIO_BASE       0x1fd00000
>  #define BONITO_PCIIO_BASE_VA    0xbfd00000
> @@ -605,14 +606,26 @@ static void bonito_pcihost_realize(DeviceState *dev=
, Error **errp)
>  {
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>      BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(dev);
> +    MemoryRegion *pcimem_lo_alias =3D g_new(MemoryRegion, 3);
>
> -    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIL=
O_SIZE);
> +    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIH=
I_SIZE);
>      phb->bus =3D pci_register_root_bus(dev, "pci",
>                                       pci_bonito_set_irq, pci_bonito_map_=
irq,
>                                       dev, &bs->pci_mem, get_system_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> -    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
> -                                &bs->pci_mem);
> +
> +    for (size_t i =3D 0; i < 3; i++) {
> +        char *name =3D g_strdup_printf("pci.lomem%zu", i);
> +
> +        memory_region_init_alias(&pcimem_lo_alias[i], NULL, name,
> +                                 &bs->pci_mem, i * 64 * MiB, 64 * MiB);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    BONITO_PCILO_BASE + i * 64 * MiB,
> +                                    &pcimem_lo_alias[i]);
> +        g_free(name);
> +    }
> +
> +    create_unimplemented_device("pci.io", BONITO_PCIIO_BASE, 1 * MiB);
>  }
>
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> @@ -620,6 +633,8 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      PCIBonitoState *s =3D PCI_BONITO(dev);
>      SysBusDevice *sysbus =3D SYS_BUS_DEVICE(s->pcihost);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
> +    BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(s->pcihost);
> +    MemoryRegion *pcimem_alias =3D g_new(MemoryRegion, 1);
>
>      /*
>       * Bonito North Bridge, built on FPGA,
> @@ -652,6 +667,7 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      sysbus_init_mmio(sysbus, &s->iomem_ldma);
>      sysbus_mmio_map(sysbus, 3, 0x1fe00200);
>
> +    /* PCI copier */
>      memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>                            "cop", 0x100);
>      sysbus_init_mmio(sysbus, &s->iomem_cop);
> @@ -669,6 +685,14 @@ static void bonito_realize(PCIDevice *dev, Error **e=
rrp)
>      sysbus_init_mmio(sysbus, &s->bonito_localio);
>      sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
>
> +    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
> +                             &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
> +    memory_region_add_subregion(get_system_memory(),
> +                                BONITO_PCIHI_BASE, pcimem_alias);
> +    create_unimplemented_device("PCI_2",
> +                                (hwaddr)BONITO_PCIHI_BASE + BONITO_PCIHI=
_SIZE,
> +                                2 * GiB);
> +
>      /* set the default value of north bridge pci config */
>      pci_set_word(dev->config + PCI_COMMAND, 0x0000);
>      pci_set_word(dev->config + PCI_STATUS, 0x0000);
> --
> 2.21.3
>

