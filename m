Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B429C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163342085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 12:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="KkVH1djy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163342085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfl1v-0004ni-EA
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 08:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cminyard@mvista.com>) id 1hfkzu-0003iY-76
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cminyard@mvista.com>) id 1hfkzs-0000La-9S
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:56:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cminyard@mvista.com>) id 1hfkzq-0000Ii-8c
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 08:56:28 -0400
Received: by mail-ot1-x343.google.com with SMTP id i4so17358788otk.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vPteK/90oLMkdk0+mBOgpJ2bbRQsbrKDklpwRkFe6vw=;
 b=KkVH1djyxcNeowAx7rGtynF4SDd/cccep6cQZuBxnWagLrT/lzng5ZqxNWjKgoJEas
 CrPdXptuilILslaM+V2f/msiqxL8LTUh65O21oZXerZYJgreL+BHJnlx6OUg+rXT8cnb
 PEC9WTSa6oL/7uOr6QNMamJBHSjnfQk9wdAlymxX+iXVjLV6BN3V/FL/NHQ9Ew7KAaOp
 lGit8B2EfTZTM7ESroDl+3cEcPXnoxLXycgkBVWps/7fSyXAXgDRoYRB4ID//zza35gj
 EqYHllkEyexMRrBm+kG0TsssocAk8juTkRMGd/L+VuJYtLJrpbFVsOKbmSaEm1ck9sYb
 AwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=vPteK/90oLMkdk0+mBOgpJ2bbRQsbrKDklpwRkFe6vw=;
 b=IALTb4VWNg7RsvQMvOpWs3c0ippaIDH0a6LodWgQAUBYD5Fyf/F0vj9dZjqWuREpva
 WRpuk08JSOEkfgpm80EMcVqiikyLj0gFmUesRpoI5SMvtJxcU6hxb/n8pFjp4PxxAfn7
 Z6gA2NV3S/xXnaUJ2GsV9aS5+hFIe7MXy7LKm8OjnsAQ1tVKPIYez5PURi5rBxnRl15q
 F1gL9PNMnljw8SJfHHP6Ra+LWIBglnw9F8PJl8OZWxEBeciLaGri2AVGgN1ybK6QyQ+h
 qEgDj6D9HcEAEZCHuv1dckqfAE+CrNXVcTf6M0jXSAC2I7NuiJKi/YcxNK6Axtp8y93c
 9Bog==
X-Gm-Message-State: APjAAAWgDr9fffKL/HieiwQqGvU5fvmBDjM8UsnV0Q3imXdnVvEw5Eae
 /KzBdS2PToFfXWHIoTCU5mz0aQ==
X-Google-Smtp-Source: APXvYqyUt8lRuCVqHWgvWhoqzioWWBhqyQmyfFNF/IDmPM0fuKPqXoh8D1jOLriz5wmcy3XKgYMlEQ==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr83770136otc.27.1561467384960; 
 Tue, 25 Jun 2019 05:56:24 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:686e:97ca:5163:b01e])
 by smtp.gmail.com with ESMTPSA id a18sm4979653otf.67.2019.06.25.05.56.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 05:56:24 -0700 (PDT)
Date: Tue, 25 Jun 2019 07:56:23 -0500
From: Corey Minyard <cminyard@mvista.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20190625125623.GF5565@minyard.net>
References: <cover.1561028123.git.balaton@eik.bme.hu>
 <046ddebb7ec8db48c4e877ee444ec1c41e385a74.1561028123.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046ddebb7ec8db48c4e877ee444ec1c41e385a74.1561028123.git.balaton@eik.bme.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v5 2/2] ati-vga: Implement DDC and EDID
 info from monitor
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
Reply-To: cminyard@mvista.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 12:55:23PM +0200, BALATON Zoltan wrote:
> This adds DDC support to ati-vga and connects i2c-ddc to it. This
> allows at least MacOS with an ATI ndrv, Linux radeonfb and MorphOS to
> get monitor EDID info (although MorphOS splash screen is not displayed
> and radeonfb needs additional tables from vgabios-rv100). Xorg needs
> additional support from VESA vgabios, it's missing INT10 0x4F15
> function (see
> https://gitlab.freedesktop.org/xorg/xserver/blob/master/hw/xfree86/vbe/vbe.c)
> without which no DDC is available that also prevents loading the
> accelerated X driver.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

This patch also looks good, and thanks to Gerd for reviewing.

I didn't see the followup documentation patch that Gerd suggested, did
I miss that?

Also, how would you like to handle these?

Thanks,

-corey

> ---
>  hw/display/Kconfig    |  2 ++
>  hw/display/ati.c      | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  hw/display/ati_int.h  |  5 +++++
>  hw/display/ati_regs.h |  2 ++
>  4 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 910dccb2f7..cbdf7b1a67 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -130,3 +130,5 @@ config ATI_VGA
>      default y if PCI_DEVICES
>      depends on PCI
>      select VGA
> +    select BITBANG_I2C
> +    select DDC
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 76595d9511..61e351a024 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "ui/console.h"
> +#include "hw/display/i2c-ddc.h"
>  #include "trace.h"
>  
>  #define ATI_DEBUG_HW_CURSOR 0
> @@ -215,6 +216,24 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>      }
>  }
>  
> +static uint64_t ati_i2c(bitbang_i2c_interface *i2c, uint64_t data, int base)
> +{
> +    bool c = (data & BIT(base + 17) ? !!(data & BIT(base + 1)) : 1);
> +    bool d = (data & BIT(base + 16) ? !!(data & BIT(base)) : 1);
> +
> +    bitbang_i2c_set(i2c, BITBANG_I2C_SCL, c);
> +    d = bitbang_i2c_set(i2c, BITBANG_I2C_SDA, d);
> +
> +    data &= ~0xf00ULL;
> +    if (c) {
> +        data |= BIT(base + 9);
> +    }
> +    if (d) {
> +        data |= BIT(base + 8);
> +    }
> +    return data;
> +}
> +
>  static inline uint64_t ati_reg_read_offs(uint32_t reg, int offs,
>                                           unsigned int size)
>  {
> @@ -266,7 +285,16 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>      case DAC_CNTL:
>          val = s->regs.dac_cntl;
>          break;
> -/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case GPIO_VGA_DDC:
> +        val = s->regs.gpio_vga_ddc;
> +        break;
> +    case GPIO_DVI_DDC:
> +        val = s->regs.gpio_dvi_ddc;
> +        break;
> +    case GPIO_MONID ... GPIO_MONID + 3:
> +        val = ati_reg_read_offs(s->regs.gpio_monid,
> +                                addr - GPIO_MONID, size);
> +        break;
>      case PALETTE_INDEX:
>          /* FIXME unaligned access */
>          val = vga_ioport_read(&s->vga, VGA_PEL_IR) << 16;
> @@ -497,7 +525,28 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>          s->regs.dac_cntl = data & 0xffffe3ff;
>          s->vga.dac_8bit = !!(data & DAC_8BIT_EN);
>          break;
> -/*    case GPIO_MONID: FIXME hook up DDC I2C here */
> +    case GPIO_VGA_DDC:
> +        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            /* FIXME: Maybe add a property to select VGA or DVI port? */
> +        }
> +        break;
> +    case GPIO_DVI_DDC:
> +        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            s->regs.gpio_dvi_ddc = ati_i2c(s->bbi2c, data, 0);
> +        }
> +        break;
> +    case GPIO_MONID ... GPIO_MONID + 3:
> +        /* FIXME What does Radeon have here? */
> +        if (s->dev_id == PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            /* Rage128p accesses DDC used to get EDID on these pins */
> +            ati_reg_write_offs(&s->regs.gpio_monid,
> +                               addr - GPIO_MONID, data, size);
> +            if ((s->regs.gpio_monid & BIT(25)) &&
> +                addr <= GPIO_MONID + 2 && addr + size > GPIO_MONID + 2) {
> +                s->regs.gpio_monid = ati_i2c(s->bbi2c, s->regs.gpio_monid, 1);
> +            }
> +        }
> +        break;
>      case PALETTE_INDEX ... PALETTE_INDEX + 3:
>          if (size == 4) {
>              vga_ioport_write(&s->vga, VGA_PEL_IR, (data >> 16) & 0xff);
> @@ -788,6 +837,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
>          vga->cursor_draw_line = ati_cursor_draw_line;
>      }
>  
> +    /* ddc, edid */
> +    I2CBus *i2cbus = i2c_init_bus(DEVICE(s), "ati-vga.ddc");
> +    s->bbi2c = bitbang_i2c_init(i2cbus);
> +    I2CSlave *i2cddc = I2C_SLAVE(qdev_create(BUS(i2cbus), TYPE_I2CDDC));
> +    i2c_set_slave_address(i2cddc, 0x50);
> +
>      /* mmio register space */
>      memory_region_init_io(&s->mm, OBJECT(s), &ati_mm_ops, s,
>                            "ati.mmregs", 0x4000);
> @@ -813,6 +868,7 @@ static void ati_vga_exit(PCIDevice *dev)
>      ATIVGAState *s = ATI_VGA(dev);
>  
>      graphic_console_close(s->vga.con);
> +    g_free(s->bbi2c);
>  }
>  
>  static Property ati_vga_properties[] = {
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index 2f426064cf..51465f5630 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -10,6 +10,7 @@
>  #define ATI_INT_H
>  
>  #include "hw/pci/pci.h"
> +#include "hw/i2c/bitbang_i2c.h"
>  #include "vga_int.h"
>  
>  /*#define DEBUG_ATI*/
> @@ -35,6 +36,9 @@ typedef struct ATIVGARegs {
>      uint32_t crtc_gen_cntl;
>      uint32_t crtc_ext_cntl;
>      uint32_t dac_cntl;
> +    uint32_t gpio_vga_ddc;
> +    uint32_t gpio_dvi_ddc;
> +    uint32_t gpio_monid;
>      uint32_t crtc_h_total_disp;
>      uint32_t crtc_h_sync_strt_wid;
>      uint32_t crtc_v_total_disp;
> @@ -83,6 +87,7 @@ typedef struct ATIVGAState {
>      uint16_t cursor_size;
>      uint32_t cursor_offset;
>      QEMUCursor *cursor;
> +    bitbang_i2c_interface *bbi2c;
>      MemoryRegion io;
>      MemoryRegion mm;
>      ATIVGARegs regs;
> diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
> index 923bfd33ce..1ec3498b73 100644
> --- a/hw/display/ati_regs.h
> +++ b/hw/display/ati_regs.h
> @@ -37,6 +37,8 @@
>  #define CRTC_GEN_CNTL                           0x0050
>  #define CRTC_EXT_CNTL                           0x0054
>  #define DAC_CNTL                                0x0058
> +#define GPIO_VGA_DDC                            0x0060
> +#define GPIO_DVI_DDC                            0x0064
>  #define GPIO_MONID                              0x0068
>  #define I2C_CNTL_1                              0x0094
>  #define PALETTE_INDEX                           0x00b0
> -- 
> 2.13.7
> 

