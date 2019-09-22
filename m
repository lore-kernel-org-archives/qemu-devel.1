Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8436EC4360D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 02:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509ED20820
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 02:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwCIyVms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509ED20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBrQi-0000Ky-QT
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 22:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBrPt-0008IS-0x
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 22:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iBrPr-0002Lf-ND
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 22:16:00 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iBrPr-0002LZ-Gy; Sat, 21 Sep 2019 22:15:59 -0400
Received: by mail-yb1-xb43.google.com with SMTP id t15so4132136ybg.7;
 Sat, 21 Sep 2019 19:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AM8w3LjGApQcfz+NpJm2Y4h+PzcZPMv96dW0YgWjkVA=;
 b=FwCIyVmsPnyx/9URJC5sjb33ALDbZ1aCOwCq81yc7x4cWwIxrcU8NJhU3/7qvNzK30
 Wz/N584qkjl71AmR+14dcIhxr8YTXxD70c2ktuHZviqIESqHXW1ohL7ZFAeoA9FPTQrT
 dwSoXBibAO9zp65V1jm5u+XJbKwpNFtV6yHtoxdrdQFMcKA4wVXc454PIq3brIH9jAfV
 +L3mUI7UN4M+Vam05t51tTO7jVvr3qy7egCz+GBK7TB7bAy/l3gzcYpsso51QAY0cMD3
 VGIv+m7s3nPu6Ma3E+7VnvPmNCgxIhcn88iW/UMvwnZ8YSfjIyFfv8wCfMJQCxhzZPfM
 hhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AM8w3LjGApQcfz+NpJm2Y4h+PzcZPMv96dW0YgWjkVA=;
 b=SfKweCYhI6dLIL5HRWvi53rysJTIPc2sUXLESVlAtuEi8sAGVtFCPN3fV0qoNgXFkC
 eOOcw+Rxd4O5aKybSUA94DcYs6v7sWoFLg1/41cdT4UTZSeanfnB6mNhypuT0AZYJw1s
 TBD7AlQrGK8f/RDnHXi6YNn4P76cSCgunZHY8Qa3mMD7YBze3nVhtZ2ecSO8ntAJ0RwD
 N4KNqKwePjhBzd0oowDN9VLWKQy7y8tfhwmp1AQs2DGiy2sS1OYEmF5YwdgBfbHIGsKf
 AWG5z097PQYGSJzAgW/+Gfnzv3SuVKPzqPhjLf0um99qslBlbwncg6jhyBP0h4xQF8uO
 kr6w==
X-Gm-Message-State: APjAAAX6GoR7WbP49apvUoz/01Ak4hjnI3bQdoGM4Tq8F8M8JzOptFa+
 7cvcfiAR0poq8BgcFVWcEDu0GjHo/PKejzvzAQY=
X-Google-Smtp-Source: APXvYqwQBSMtazlqFj2eiaEJqe7kcfs18gXyPM0kz4JE+zyR4IItdTZmTlZ7MXd4RIfVBJSNZrQkeAK2heac96Y0EKg=
X-Received: by 2002:a25:9b85:: with SMTP id v5mr3385816ybo.65.1569118558803;
 Sat, 21 Sep 2019 19:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
In-Reply-To: <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 22 Sep 2019 10:15:46 +0800
Message-ID: <CAEUhbmWu_OTGmUBTcMg9uvm36-fDQheSSiwH5mjnokJSrLvoBA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Sep 21, 2019 at 6:16 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > On Fri, Sep 20, 2019 at 6:36 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
> > > from the ARM Virt board and the implementation is based on the ARM Virt
> > > board. This allows users to specify flash files from the command line.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  hw/riscv/Kconfig        |  1 +
> > >  hw/riscv/virt.c         | 81 +++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/riscv/virt.h |  3 ++
> > >  3 files changed, 85 insertions(+)
> > >
> > > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > > index fb19b2df3a..b12660b9f8 100644
> > > --- a/hw/riscv/Kconfig
> > > +++ b/hw/riscv/Kconfig
> > > @@ -36,4 +36,5 @@ config RISCV_VIRT
> > >      select SERIAL
> > >      select VIRTIO_MMIO
> > >      select PCI_EXPRESS_GENERIC_BRIDGE
> > > +    select PFLASH_CFI01
> > >      select SIFIVE
> > > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > > index d36f5625ec..ca002ecea7 100644
> > > --- a/hw/riscv/virt.c
> > > +++ b/hw/riscv/virt.c
> > > @@ -26,6 +26,7 @@
> > >  #include "hw/boards.h"
> > >  #include "hw/loader.h"
> > >  #include "hw/sysbus.h"
> > > +#include "hw/qdev-properties.h"
> > >  #include "hw/char/serial.h"
> > >  #include "target/riscv/cpu.h"
> > >  #include "hw/riscv/riscv_hart.h"
> > > @@ -61,12 +62,72 @@ static const struct MemmapEntry {
> > >      [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
> > >      [VIRT_UART0] =       { 0x10000000,         0x100 },
> > >      [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
> > > +    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
> > >      [VIRT_DRAM] =        { 0x80000000,           0x0 },
> > >      [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
> > >      [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
> > >      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
> > >  };
> > >
> > > +#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> > > +
> > > +static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
> > > +                                       const char *name,
> > > +                                       const char *alias_prop_name)
> > > +{
> > > +    /*
> > > +     * Create a single flash device.  We use the same parameters as
> > > +     * the flash devices on the ARM virt board.
> > > +     */
> > > +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
> > > +
> > > +    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
> > > +    qdev_prop_set_uint8(dev, "width", 4);
> > > +    qdev_prop_set_uint8(dev, "device-width", 2);
> > > +    qdev_prop_set_bit(dev, "big-endian", false);
> > > +    qdev_prop_set_uint16(dev, "id0", 0x89);
> > > +    qdev_prop_set_uint16(dev, "id1", 0x18);
> > > +    qdev_prop_set_uint16(dev, "id2", 0x00);
> > > +    qdev_prop_set_uint16(dev, "id3", 0x00);
> > > +    qdev_prop_set_string(dev, "name", name);
> >
> > alias_prop_name is unused? ARM virt has 2 more calls in the same function here.
>
> Yep, you are right. I have removed this.

Any reason of removing this?

>
> >
> > > +
> > > +    return PFLASH_CFI01(dev);
> > > +}
> > > +
> > > +static void virt_flash_create(RISCVVirtState *s)
> > > +{
> > > +    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
> > > +    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
> >
> > I don't think we should mirror what is used on ARM virt board to
> > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
> > they need distinguish secure and non-secure. For sifive_u, only one is
> > enough.
>
> I went back and forward about 1 or 2. Two seems more usable as maybe
> someone wants to include two pflash files? The Xilinx machine also has
> two so I'm kind of used to 2, but I'm not really fussed.
>
> Unless anyone else wants two I will change it to 1.

Regards,
Bin

