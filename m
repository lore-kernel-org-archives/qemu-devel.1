Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCA6FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E4E2067B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv0RwlQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E4E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhQy-0006WY-NM
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pdurrant@gmail.com>) id 1iKhPp-0005ka-Co
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pdurrant@gmail.com>) id 1iKhPo-0003Zp-2P
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37649)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pdurrant@gmail.com>) id 1iKhPn-0003ZT-RC
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id p1so14112526pgi.4
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 04:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LOhxSmhltHVmCHIgrxp16EKj8XAolAsY7/5MxXVPJeg=;
 b=qv0RwlQfuyAV06Rt87qK/UWtE06kLYJBl1B7flH3oYBYMZ3WBvvlBjWzQIAO17RosM
 pWkGzHPPdw+nL4xc2/rX4dsVOjYbVG3eZ2AiWCwNH/M7Eyka4Fa12UVP9hZsbCSHZjKe
 4aoy2dhnK4C5KifXK6Qvf/gd5EszL0madtYJd3fsd1wHPpgLEbgsXkMcr0a8l6a312Yc
 FJPEYir3JsQ3j/xOB3WAySj5fuJowgpL8vNDsSiIDoKRZZNwBDm+k2mdAVG2uk8CgCt1
 4arQqvc4oo5+56fvSgC+2XsAndZRThn3zBTxGN6W7zxoQDzdvXkpJz43BTbw4h4/HgPa
 HnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LOhxSmhltHVmCHIgrxp16EKj8XAolAsY7/5MxXVPJeg=;
 b=hpVLaGy2VJ5EnFoOrrbJOa6cBIhFw0/ijqTIaoh8sV+/meDg5b/mqVTzJ1/5dtH9rN
 NUhnc5grbXjPto8wgrDBQdYR3QXutYmThNDKEMWIKdZjkDk4lIvSlTT/c/egchkuv56g
 DGo0TtsFy4by8NJs+rVP3j+9mlzSUKx4MKkfNGtTNp3C1uylz3Df56IcuxKbAlPtN9u7
 XQEdTKbChJbACj8wuEM41/pxmoavk6LUHnJdTSJQNGvD9Aaf5HAkKqGd1BXABibtedp8
 GYtYArpfX2ebqpZhI+NEkOOY7SteQtnEiJia+LXftjFDL1xDi4fC5QTt0I5JWPkwTYFy
 l3iA==
X-Gm-Message-State: APjAAAX9bbcgWy94vR/LRZ2YuV6mkQj9+uZATZcaBwa7Xd2UtoLKgShg
 934vDsTg1Cj0s8FSLa8ZKjvOoYw6py3tRkFNBWo=
X-Google-Smtp-Source: APXvYqx/K3HVs2y8kHeKYg41IQD9q1KLMW4BxhnkYePE6OPi6UiZwMnm8IQr0qxQpi9GF6ZNT6tQ0S1OQNNMywxKpWQ=
X-Received: by 2002:a17:90a:e001:: with SMTP id
 u1mr4460927pjy.102.1571225066213; 
 Wed, 16 Oct 2019 04:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-28-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-28-philmd@redhat.com>
From: Paul Durrant <pdurrant@gmail.com>
Date: Wed, 16 Oct 2019 12:24:15 +0100
Message-ID: <CACCGGhDsJ==Z_rVRNJ28N_p3Ar=dtbPZcgMaXiw=cLEvAiYSKQ@mail.gmail.com>
Subject: Re: [PATCH 27/32] hw/pci-host/piix: Define and use the PIIX IRQ Route
 Control Registers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 17:34, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The IRQ Route Control registers definitions belong to the PIIX
> chipset. We were only defining the 'A' register. Define the other
> B, C and D registers, and use them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Xen change...

Acked-by: Paul Durrant <paul@xen.org>

> ---
>  hw/i386/xen/xen-hvm.c         | 5 +++--
>  hw/mips/gt64xxx_pci.c         | 4 ++--
>  hw/pci-host/piix.c            | 9 ++++-----
>  include/hw/southbridge/piix.h | 6 ++++++
>  4 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 6b5e5bb7f5..4ce2fb9c89 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -14,6 +14,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/i386/pc.h"
> +#include "hw/southbridge/piix.h"
>  #include "hw/irq.h"
>  #include "hw/hw.h"
>  #include "hw/i386/apic-msidef.h"
> @@ -156,8 +157,8 @@ void xen_piix_pci_write_config_client(uint32_t addres=
s, uint32_t val, int len)
>              v =3D 0;
>          }
>          v &=3D 0xf;
> -        if (((address + i) >=3D 0x60) && ((address + i) <=3D 0x63)) {
> -            xen_set_pci_link_route(xen_domid, address + i - 0x60, v);
> +        if (((address + i) >=3D PIIX_PIRQCA) && ((address + i) <=3D PIIX=
_PIRQCD)) {
> +            xen_set_pci_link_route(xen_domid, address + i - PIIX_PIRQCA,=
 v);
>          }
>      }
>  }
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index c277398c0d..5cab9c1ee1 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -1013,12 +1013,12 @@ static void gt64120_pci_set_irq(void *opaque, int=
 irq_num, int level)
>
>      /* now we change the pic irq level according to the piix irq mapping=
s */
>      /* XXX: optimize */
> -    pic_irq =3D piix4_dev->config[0x60 + irq_num];
> +    pic_irq =3D piix4_dev->config[PIIX_PIRQCA + irq_num];
>      if (pic_irq < 16) {
>          /* The pic level is the logical OR of all the PCI irqs mapped to=
 it. */
>          pic_level =3D 0;
>          for (i =3D 0; i < 4; i++) {
> -            if (pic_irq =3D=3D piix4_dev->config[0x60 + i]) {
> +            if (pic_irq =3D=3D piix4_dev->config[PIIX_PIRQCA + i]) {
>                  pic_level |=3D pci_irq_levels[i];
>              }
>          }
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
> index 3770575c1a..a450fc726e 100644
> --- a/hw/pci-host/piix.c
> +++ b/hw/pci-host/piix.c
> @@ -61,7 +61,6 @@ typedef struct I440FXState {
>  #define PIIX_NUM_PIC_IRQS       16      /* i8259 * 2 */
>  #define PIIX_NUM_PIRQS          4ULL    /* PIRQ[A-D] */
>  #define XEN_PIIX_NUM_PIRQS      128ULL
> -#define PIIX_PIRQC              0x60
>
>  typedef struct PIIX3State {
>      PCIDevice dev;
> @@ -468,7 +467,7 @@ static void piix3_set_irq_level_internal(PIIX3State *=
piix3, int pirq, int level)
>      int pic_irq;
>      uint64_t mask;
>
> -    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
> +    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
>      if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
>          return;
>      }
> @@ -482,7 +481,7 @@ static void piix3_set_irq_level(PIIX3State *piix3, in=
t pirq, int level)
>  {
>      int pic_irq;
>
> -    pic_irq =3D piix3->dev.config[PIIX_PIRQC + pirq];
> +    pic_irq =3D piix3->dev.config[PIIX_PIRQCA + pirq];
>      if (pic_irq >=3D PIIX_NUM_PIC_IRQS) {
>          return;
>      }
> @@ -501,7 +500,7 @@ static void piix3_set_irq(void *opaque, int pirq, int=
 level)
>  static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
>  {
>      PIIX3State *piix3 =3D opaque;
> -    int irq =3D piix3->dev.config[PIIX_PIRQC + pin];
> +    int irq =3D piix3->dev.config[PIIX_PIRQCA + pin];
>      PCIINTxRoute route;
>
>      if (irq < PIIX_NUM_PIC_IRQS) {
> @@ -530,7 +529,7 @@ static void piix3_write_config(PCIDevice *dev,
>                                 uint32_t address, uint32_t val, int len)
>  {
>      pci_default_write_config(dev, address, val, len);
> -    if (ranges_overlap(address, len, PIIX_PIRQC, 4)) {
> +    if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
>          PIIX3State *piix3 =3D PIIX3_PCI_DEVICE(dev);
>          int pic_irq;
>
> diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.=
h
> index 79ebe0089b..9c92c37a4d 100644
> --- a/include/hw/southbridge/piix.h
> +++ b/include/hw/southbridge/piix.h
> @@ -18,6 +18,12 @@ I2CBus *piix4_pm_init(PCIBus *bus, int devfn, uint32_t=
 smb_io_base,
>                        qemu_irq sci_irq, qemu_irq smi_irq,
>                        int smm_enabled, DeviceState **piix4_pm);
>
> +/* PIRQRC[A:D]: PIRQx Route Control Registers */
> +#define PIIX_PIRQCA 0x60
> +#define PIIX_PIRQCB 0x61
> +#define PIIX_PIRQCC 0x62
> +#define PIIX_PIRQCD 0x63
> +
>  /*
>   * Reset Control Register: PCI-accessible ISA-Compatible Register at add=
ress
>   * 0xcf9, provided by the PCI/ISA bridge (PIIX3 PCI function 0, 8086:700=
0).
> --
> 2.21.0
>

