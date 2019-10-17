Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DAECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B384620820
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSA4LEIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B384620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7UM-0001TB-6z
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6uk-0006Mu-6C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL6ui-0001Pd-0P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:38:06 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL6uh-0001P2-MR
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:38:03 -0400
Received: by mail-oi1-x244.google.com with SMTP id a15so2381212oic.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5G9r6wNQ769esd5T7l5Ce2TQZH/wdZ6lVaYX6fTcKkU=;
 b=SSA4LEIP7oEIYMhYT/vZt4xHxNfuSuyY9hD+PgHsDS+DKZ4RNhr6tgshWOeyagtTXw
 scwG42TQ9uTTncbKmjvdQbgRpySnXrr3rPsGwMnRBfwjTN56KalsFrW4VwBcaeuMEsd4
 LfMnbyFPqlLTlzuIbf8IzzdaM7fju8JfY7mDJTV8OZAvbOH0t2xYtsnIoYrAqB482xzD
 EDZbY25qNeILmj/deHQaZdgw8PrVi39Tpz9KKwX/1OJGrpC25MHuPCwER0ZaXz2nChS7
 ZIdzBwDKe2sml2VKBNBJW5fNnLxdIAdsEEwxVsQK5IMAIBUnDZJIa4exIwjaLpW2j4TG
 wgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5G9r6wNQ769esd5T7l5Ce2TQZH/wdZ6lVaYX6fTcKkU=;
 b=JFUj7xF3Wg5j9ExQFofRo4B8G3kcClIoxrQDJIqotdCvQqsIVfOOj6UofMpPJEE+qv
 A6wvdeSUnbRziG4y6VqzP5fD16Qh44xsaBwZljVgmLbAy+XaltSpzcjF3e0Ge+5O4owh
 ZbXPiRfAcYhBmGXl7bKz3RWlK+2WlSgtf67zv26RypxhhJAgg7TNcdFe7y9zgj+VL/Ej
 dQJBJTdoesrQjXEpeoVW/O2WmoyOH1J54QZQREN4y6sVeUUJEmzfcD0Y0OEFgMvKc7gd
 jgYYoQmOaRI7GZlDjYEmPi6VnALPBtz8Z2CsV1V2FyYZpFuGlZKcSQ5iiQl0/ERU+vJL
 CuBg==
X-Gm-Message-State: APjAAAWjsWfe88tdngk6dy1BhOog45GKdCideSu65Ihr5v1LdNrk4d/J
 QTrF33f7cKH9P+aPQdfyM3MbV772aaXWfRrpiVY=
X-Google-Smtp-Source: APXvYqxF1cZr7IBzDy02cdJY8R78Lr3d0NCfQrdmuvXZsFFdIryiIxQvsL5Jduw26CfEMyU9N6CfeRHgOQtGpwvKruw=
X-Received: by 2002:aca:62d5:: with SMTP id w204mr3523370oib.136.1571323082817; 
 Thu, 17 Oct 2019 07:38:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 07:38:02
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-11-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-11-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 16:38:02 +0200
Message-ID: <CAL1e-=g9Eyg3eeiDd=og=byEfzK1G-zF4PK8ujc3wSPXNztC8w@mail.gmail.com>
Subject: Re: [PATCH 10/32] piix4: add a i8259 interrupt controller as
 specified in datasheet
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002dc82705951c2a53"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002dc82705951c2a53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>
> Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4 gpio ou=
t.
> Remove i8259 instanciated in malta board, to not have it twice.
>
> We can also remove the now unused piix4_init() function.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Message-Id: <20171216090228.28505-8-hpoussin@reactos.org>
> [PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/piix4.c       | 41 ++++++++++++++++++++++++++++++-----------
>  hw/mips/mips_malta.c | 32 +++++++++++++-------------------
>  include/hw/i386/pc.h |  1 -
>  3 files changed, 43 insertions(+), 31 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
> index 6e2d9b9774..1cfc51335a 100644
> --- a/hw/isa/piix4.c
> +++ b/hw/isa/piix4.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "hw/irq.h"
>  #include "hw/i386/pc.h"
>  #include "hw/pci/pci.h"
>  #include "hw/isa/isa.h"
> @@ -36,6 +37,8 @@ PCIDevice *piix4_dev;
>
>  typedef struct PIIX4State {
>      PCIDevice dev;
> +    qemu_irq cpu_intr;
> +    qemu_irq *isa;
>
>      /* Reset Control Register */
>      MemoryRegion rcr_mem;
> @@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4 =3D {
>      }
>  };
>
> +static void piix4_request_i8259_irq(void *opaque, int irq, int level)
> +{
> +    PIIX4State *s =3D opaque;
> +    qemu_set_irq(s->cpu_intr, level);
> +}
> +
> +static void piix4_set_i8259_irq(void *opaque, int irq, int level)
> +{
> +    PIIX4State *s =3D opaque;
> +    qemu_set_irq(s->isa[irq], level);
> +}
> +
>  static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
>                              unsigned int len)
>  {
> @@ -126,30 +141,34 @@ static void piix4_realize(PCIDevice *pci_dev, Error
> **errp)
>  {
>      DeviceState *dev =3D DEVICE(pci_dev);
>      PIIX4State *s =3D DO_UPCAST(PIIX4State, dev, pci_dev);
> +    ISABus *isa_bus;
> +    qemu_irq *i8259_out_irq;
>
> -    if (!isa_bus_new(dev, pci_address_space(pci_dev),
> -                     pci_address_space_io(pci_dev), errp)) {
> +    isa_bus =3D isa_bus_new(dev, pci_address_space(pci_dev),
> +                          pci_address_space_io(pci_dev), errp);
> +    if (!isa_bus) {
>          return;
>      }
>
> +    qdev_init_gpio_in_named(dev, piix4_set_i8259_irq, "isa",
> ISA_NUM_IRQS);
> +    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
> +
>      memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
>                            "reset-control", 1);
>      memory_region_add_subregion_overlap(pci_address_space_io(pci_dev),
> 0xcf9,
>                                          &s->rcr_mem, 1);
>
> +    /* initialize i8259 pic */
> +    i8259_out_irq =3D qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
> +    s->isa =3D i8259_init(isa_bus, *i8259_out_irq);
> +
> +    /* initialize ISA irqs */
> +    isa_bus_irqs(isa_bus, s->isa);
> +
>      piix4_dev =3D pci_dev;
>      qemu_register_reset(piix4_reset, s);
>  }
>
> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)
> -{
> -    PCIDevice *d;
> -
> -    d =3D pci_create_simple_multifunction(bus, devfn, true, "PIIX4");
> -    *isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(d), "isa.0"));
> -    return d->devfn;
> -}
> -
>  static void piix4_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4d9c64b36a..7d25ab6c23 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -97,7 +97,7 @@ typedef struct {
>      SysBusDevice parent_obj;
>
>      MIPSCPSState cps;
> -    qemu_irq *i8259;
> +    qemu_irq i8259[16];
>  } MaltaState;
>
>  static ISADevice *pit;
> @@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)
>      int64_t kernel_entry, bootloader_run_addr;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> -    qemu_irq *isa_irq;
>      qemu_irq cbus_irq, i8259_irq;
> +    PCIDevice *pci;
>      int piix4_devfn;
>      I2CBus *smbus;
>      DriveInfo *dinfo;
> @@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState *machine)
>      /* Board ID =3D 0x420 (Malta Board with CoreLV) */
>      stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
>
> -    /*
> -     * We have a circular dependency problem: pci_bus depends on isa_irq=
,
> -     * isa_irq is provided by i8259, i8259 depends on ISA, ISA depends
> -     * on piix4, and piix4 depends on pci_bus.  To stop the cycle we hav=
e
> -     * qemu_irq_proxy() adds an extra bit of indirection, allowing us
> -     * to resolve the isa_irq -> i8259 dependency after i8259 is
> initialized.
> -     */
> -    isa_irq =3D qemu_irq_proxy(&s->i8259, 16);
> -
>      /* Northbridge */
> -    pci_bus =3D gt64120_register(isa_irq);
> +    pci_bus =3D gt64120_register(s->i8259);
>
>      /* Southbridge */
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>
> -    piix4_devfn =3D piix4_init(pci_bus, &isa_bus, 80);
> +    pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
> +                                          true, "PIIX4");
> +    dev =3D DEVICE(pci);
> +    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> +    piix4_devfn =3D pci->devfn;
>
> -    /*
> -     * Interrupt controller
> -     * The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2
> -     */
> -    s->i8259 =3D i8259_init(isa_bus, i8259_irq);
> +    /* Interrupt controller */
> +    qdev_connect_gpio_out_named(dev, "intr", 0, i8259_irq);
> +    for (int i =3D 0; i < ISA_NUM_IRQS; i++) {
> +        s->i8259[i] =3D qdev_get_gpio_in_named(dev, "isa", i);
> +    }
>
> -    isa_bus_irqs(isa_bus, s->i8259);
>      pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);
>      pci_create_simple(pci_bus, piix4_devfn + 2, "piix4-usb-uhci");
>      smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x1100,
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 09e74e7764..a95eab0d8a 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -282,7 +282,6 @@ PCIBus *i440fx_init(const char *host_type, const char
> *pci_type,
>  PCIBus *find_i440fx(void);
>  /* piix4.c */
>  extern PCIDevice *piix4_dev;
> -int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
>
>  /* pc_sysfw.c */
>  void pc_system_flash_create(PCMachineState *pcms);
> --
> 2.21.0
>
>
>

--0000000000002dc82705951c2a53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">From: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:h=
poussin@reactos.org">hpoussin@reactos.org</a>&gt;<br>
<br>
Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4 gpio out.=
<br>
Remove i8259 instanciated in malta board, to not have it twice.<br>
<br>
We can also remove the now unused piix4_init() function.<br>
<br>
Acked-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redh=
at.com</a>&gt;<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini=
@redhat.com</a>&gt;<br>
Signed-off-by: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos=
.org">hpoussin@reactos.org</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20171216090228.28505-8-hpoussin@reactos.o=
rg">20171216090228.28505-8-hpoussin@reactos.org</a>&gt;<br>
[PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 41 +++++++++++++++++++++++=
+++++++<wbr>-----------<br>
=C2=A0hw/mips/mips_malta.c | 32 +++++++++++++-----------------<wbr>--<br>
=C2=A0include/hw/i386/pc.h |=C2=A0 1 -<br>
=C2=A03 files changed, 43 insertions(+), 31 deletions(-)<br>
<br></blockquote><div><br></div><div><div id=3D"cvcmsg_16dbfeb33c93ed97" cl=
ass=3D"yh  " style=3D"border-top-left-radius:0px;border-top-right-radius:0p=
x;margin-bottom:11px;overflow:visible"><div class=3D"Vh" id=3D"cvcfullmsg_1=
6dbfeb33c93ed97"><div id=3D"cvcmsgbod_16dbfeb33c93ed97" class=3D"aj"><div c=
lass=3D"Ni"><div class=3D"ni pi " dir=3D"ltr"><p dir=3D"ltr">Reviewed-by: A=
leksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com" target=3D"=
_blank">amarkovic@wavecomp.com</a>&gt;</p><div style=3D"clear:both"></div><=
/div><div style=3D"clear:both"></div><div><div class=3D"M j T b hc Aj S" ta=
bindex=3D"0"><div class=3D"V j hf"></div></div></div><div style=3D"clear:bo=
th"></div></div></div></div></div><div id=3D"cvcmsg_16dbfecd588da1f7" class=
=3D"yh" style=3D"margin-bottom:11px"><div class=3D"Vh" id=3D"cvcfullmsg_16d=
bfecd588da1f7"><div class=3D"M j Zi Mi  " tabindex=3D"0"><div id=3D"cvcrepl=
y_16dbfecd588da1f7" class=3D"M j T b hc xh S  " tabindex=3D"0"><div class=
=3D"V j td"></div></div></div></div></div></div><div><br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c<br>
index 6e2d9b9774..1cfc51335a 100644<br>
--- a/hw/isa/piix4.c<br>
+++ b/hw/isa/piix4.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/i386/pc.h&quot;<br>
=C2=A0#include &quot;hw/pci/pci.h&quot;<br>
=C2=A0#include &quot;hw/isa/isa.h&quot;<br>
@@ -36,6 +37,8 @@ PCIDevice *piix4_dev;<br>
<br>
=C2=A0typedef struct PIIX4State {<br>
=C2=A0 =C2=A0 =C2=A0PCIDevice dev;<br>
+=C2=A0 =C2=A0 qemu_irq cpu_intr;<br>
+=C2=A0 =C2=A0 qemu_irq *isa;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Reset Control Register */<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion rcr_mem;<br>
@@ -94,6 +97,18 @@ static const VMStateDescription vmstate_piix4 =3D {<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
<br>
+static void piix4_request_i8259_irq(void *opaque, int irq, int level)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D opaque;<br>
+=C2=A0 =C2=A0 qemu_set_irq(s-&gt;cpu_intr, level);<br>
+}<br>
+<br>
+static void piix4_set_i8259_irq(void *opaque, int irq, int level)<br>
+{<br>
+=C2=A0 =C2=A0 PIIX4State *s =3D opaque;<br>
+=C2=A0 =C2=A0 qemu_set_irq(s-&gt;isa[irq], level);<br>
+}<br>
+<br>
=C2=A0static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int len)<br>
=C2=A0{<br>
@@ -126,30 +141,34 @@ static void piix4_realize(PCIDevice *pci_dev, Error *=
*errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *dev =3D DEVICE(pci_dev);<br>
=C2=A0 =C2=A0 =C2=A0PIIX4State *s =3D DO_UPCAST(PIIX4State, dev, pci_dev);<=
br>
+=C2=A0 =C2=A0 ISABus *isa_bus;<br>
+=C2=A0 =C2=A0 qemu_irq *i8259_out_irq;<br>
<br>
-=C2=A0 =C2=A0 if (!isa_bus_new(dev, pci_address_space(pci_dev),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0pci_address_space_io(pci_dev), errp)) {<br>
+=C2=A0 =C2=A0 isa_bus =3D isa_bus_new(dev, pci_address_space(pci_dev),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 pci_address_space_io(pci_dev), errp);<br>
+=C2=A0 =C2=A0 if (!isa_bus) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 qdev_init_gpio_in_named(dev, piix4_set_i8259_irq, &quot;isa&=
quot;, ISA_NUM_IRQS);<br>
+=C2=A0 =C2=A0 qdev_init_gpio_out_named(dev, &amp;s-&gt;cpu_intr, &quot;int=
r&quot;, 1);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(&amp;s-&gt;rcr_<wbr>mem, OBJECT(d=
ev), &amp;piix4_rcr_ops, s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;reset-control&quot;, 1);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_<wbr>overlap(pci_address_sp=
ace_io(<wbr>pci_dev), 0xcf9,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&a=
mp;s-&gt;rcr_mem, 1);<br>
<br>
+=C2=A0 =C2=A0 /* initialize i8259 pic */<br>
+=C2=A0 =C2=A0 i8259_out_irq =3D qemu_allocate_irqs(piix4_<wbr>request_i825=
9_irq, s, 1);<br>
+=C2=A0 =C2=A0 s-&gt;isa =3D i8259_init(isa_bus, *i8259_out_irq);<br>
+<br>
+=C2=A0 =C2=A0 /* initialize ISA irqs */<br>
+=C2=A0 =C2=A0 isa_bus_irqs(isa_bus, s-&gt;isa);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0piix4_dev =3D pci_dev;<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(piix4_<wbr>reset, s);<br>
=C2=A0}<br>
<br>
-int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn)<br>
-{<br>
-=C2=A0 =C2=A0 PCIDevice *d;<br>
-<br>
-=C2=A0 =C2=A0 d =3D pci_create_simple_<wbr>multifunction(bus, devfn, true,=
 &quot;PIIX4&quot;);<br>
-=C2=A0 =C2=A0 *isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>DEVICE(d), &quo=
t;isa.0&quot;));<br>
-=C2=A0 =C2=A0 return d-&gt;devfn;<br>
-}<br>
-<br>
=C2=A0static void piix4_class_init(ObjectClass *klass, void *data)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 4d9c64b36a..7d25ab6c23 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -97,7 +97,7 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0SysBusDevice parent_obj;<br>
<br>
=C2=A0 =C2=A0 =C2=A0MIPSCPSState cps;<br>
-=C2=A0 =C2=A0 qemu_irq *i8259;<br>
+=C2=A0 =C2=A0 qemu_irq i8259[16];<br>
=C2=A0} MaltaState;<br>
<br>
=C2=A0static ISADevice *pit;<br>
@@ -1235,8 +1235,8 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0int64_t kernel_entry, bootloader_run_addr;<br>
=C2=A0 =C2=A0 =C2=A0PCIBus *pci_bus;<br>
=C2=A0 =C2=A0 =C2=A0ISABus *isa_bus;<br>
-=C2=A0 =C2=A0 qemu_irq *isa_irq;<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq cbus_irq, i8259_irq;<br>
+=C2=A0 =C2=A0 PCIDevice *pci;<br>
=C2=A0 =C2=A0 =C2=A0int piix4_devfn;<br>
=C2=A0 =C2=A0 =C2=A0I2CBus *smbus;<br>
=C2=A0 =C2=A0 =C2=A0DriveInfo *dinfo;<br>
@@ -1407,30 +1407,24 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0/* Board ID =3D 0x420 (Malta Board with CoreLV) */<br>
=C2=A0 =C2=A0 =C2=A0stl_p(memory_region_get_ram_<wbr>ptr(bios_copy) + 0x10,=
 0x00000420);<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* We have a circular dependency problem: pci_bus depen=
ds on isa_irq,<br>
-=C2=A0 =C2=A0 =C2=A0* isa_irq is provided by i8259, i8259 depends on ISA, =
ISA depends<br>
-=C2=A0 =C2=A0 =C2=A0* on piix4, and piix4 depends on pci_bus.=C2=A0 To sto=
p the cycle we have<br>
-=C2=A0 =C2=A0 =C2=A0* qemu_irq_proxy() adds an extra bit of indirection, a=
llowing us<br>
-=C2=A0 =C2=A0 =C2=A0* to resolve the isa_irq -&gt; i8259 dependency after =
i8259 is initialized.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 isa_irq =3D qemu_irq_proxy(&amp;s-&gt;i8259, 16);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* Northbridge */<br>
-=C2=A0 =C2=A0 pci_bus =3D gt64120_register(isa_irq);<br>
+=C2=A0 =C2=A0 pci_bus =3D gt64120_register(s-&gt;i8259);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Southbridge */<br>
=C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ARRAY_SIZE(hd));<br>
<br>
-=C2=A0 =C2=A0 piix4_devfn =3D piix4_init(pci_bus, &amp;isa_bus, 80);<br>
+=C2=A0 =C2=A0 pci =3D pci_create_simple_<wbr>multifunction(pci_bus, PCI_DE=
VFN(10, 0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 t=
rue, &quot;PIIX4&quot;);<br>
+=C2=A0 =C2=A0 dev =3D DEVICE(pci);<br>
+=C2=A0 =C2=A0 isa_bus =3D ISA_BUS(qdev_get_child_bus(<wbr>dev, &quot;isa.0=
&quot;));<br>
+=C2=A0 =C2=A0 piix4_devfn =3D pci-&gt;devfn;<br>
<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Interrupt controller<br>
-=C2=A0 =C2=A0 =C2=A0* The 8259 is attached to the MIPS CPU INT0 pin, ie in=
terrupt 2<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 s-&gt;i8259 =3D i8259_init(isa_bus, i8259_irq);<br>
+=C2=A0 =C2=A0 /* Interrupt controller */<br>
+=C2=A0 =C2=A0 qdev_connect_gpio_out_named(<wbr>dev, &quot;intr&quot;, 0, i=
8259_irq);<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ISA_NUM_IRQS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;i8259[i] =3D qdev_get_gpio_in_named(dev,=
 &quot;isa&quot;, i);<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 isa_bus_irqs(isa_bus, s-&gt;i8259);<br>
=C2=A0 =C2=A0 =C2=A0pci_piix4_ide_init(pci_bus, hd, piix4_devfn + 1);<br>
=C2=A0 =C2=A0 =C2=A0pci_create_simple(pci_bus, piix4_devfn + 2, &quot;piix4=
-usb-uhci&quot;);<br>
=C2=A0 =C2=A0 =C2=A0smbus =3D piix4_pm_init(pci_bus, piix4_devfn + 3, 0x110=
0,<br>
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index 09e74e7764..a95eab0d8a 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -282,7 +282,6 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,<br>
=C2=A0PCIBus *find_i440fx(void);<br>
=C2=A0/* piix4.c */<br>
=C2=A0extern PCIDevice *piix4_dev;<br>
-int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);<br>
<br>
=C2=A0/* pc_sysfw.c */<br>
=C2=A0void pc_system_flash_create(<wbr>PCMachineState *pcms);<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--0000000000002dc82705951c2a53--

