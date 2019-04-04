Received: from eggs.gnu.org ([209.51.188.92]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <radoslaw.biernacki@linaro.org>) id 1hBy5U-0003hm-2o
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <radoslaw.biernacki@linaro.org>) id 1hBy5S-0002Gn-93
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:51:08 -0400
Received: from mail-yw1-xc29.google.com ([2607:f8b0:4864:20::c29]:37816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <radoslaw.biernacki@linaro.org>)
	id 1hBy5P-0002DD-3M
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:51:04 -0400
Received: by mail-yw1-xc29.google.com with SMTP id w66so679260ywd.4
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 01:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552644466-24625-1-git-send-email-hongbo.zhang@linaro.org>
	<1552644466-24625-2-git-send-email-hongbo.zhang@linaro.org>
	<CAKv+Gu-aZeYwegzFQ7pPqvm28ySR5xC6rZh8FBvQaWiNykgPEg@mail.gmail.com>
	<CAHmQWvD8byf+4=J7+rnU9CiGRKnuA4NnRPHRw1Zki4-m4anwOA@mail.gmail.com>
	<CAKv+Gu9cWgkH-ZTDQ42_HnN-LfAMoL-k7ysd1Hz07RrP+Pp94g@mail.gmail.com>
	<CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
In-Reply-To: <CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
From: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
Date: Thu, 4 Apr 2019 15:50:49 +0700
Message-ID: <CAEK-wKnY=VutLC6Ke=UeuswfxGkGohahhxwFiq=kqRdT-W0rPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>

There is one additional need which we just discovered with Fu Wei.
We need second secure UART for RAS and MM from EL0.
I'm adding a patch here (not sure if addresses and IRQ's are in your style
so please check those).
I will adapt FW to your changes in next patch.

>From fbc84e29b966f94a27fe84195987e6ba0c55c1bc Mon Sep 17 00:00:00 2001
From: Radoslaw Biernacki <radoslaw.biernacki@gmail.com>
Date: Thu, 4 Apr 2019 14:41:21 +0700
Subject: [PATCH] Add 2nd secure uart Rebase of Fu Wei patch

---
 hw/arm/sbsa-ref.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 6b26111840..dcfb34ff5b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -67,6 +67,7 @@ enum {
     SBSA_PCIE_ECAM,
     SBSA_GPIO,
     SBSA_SECURE_UART,
+    SBSA_SECURE_UART_MM,
     SBSA_SECURE_MEM,
     SBSA_AHCI,
     SBSA_EHCI,
@@ -105,7 +106,9 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
     [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
-    [SBSA_SMMU] =               { 0x60040000, 0x00020000 },
+    /* The UART is a secure UART for S-EL0 OS testing */
+    [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
+    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
@@ -126,8 +129,9 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_PCIE] = 3, /* ... to 6 */
     [SBSA_GPIO] = 7,
     [SBSA_SECURE_UART] = 8,
-    [SBSA_AHCI] = 9,
-    [SBSA_EHCI] = 10,
+    [SBSA_SECURE_UART_MM] = 9,
+    [SBSA_AHCI] = 10,
+    [SBSA_EHCI] = 11,
 };

 /*
@@ -645,6 +649,7 @@ static void sbsa_ref_init(MachineState *machine)
     create_uart(vms, pic, SBSA_UART, sysmem, serial_hd(0));

     create_uart(vms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
+    create_uart(vms, pic, SBSA_SECURE_UART_MM, secure_sysmem,
serial_hd(2));

     create_rtc(vms, pic);

-- 
2.17.1


On Thu, 4 Apr 2019 at 15:27, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

> I would like to wait for more days to see if there are any further
> comments, and if no I will send another iteration with memory map
> slightly changed.
>
> On Wed, 20 Mar 2019 at 18:27, Ard Biesheuvel <ard.biesheuvel@linaro.org>
> wrote:
> >
> > On Mon, 18 Mar 2019 at 03:39, Hongbo Zhang <hongbo.zhang@linaro.org>
> wrote:
> > >
> > > On Fri, 15 Mar 2019 at 18:41, Ard Biesheuvel <
> ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Fri, 15 Mar 2019 at 11:08, Hongbo Zhang <hongbo.zhang@linaro.org>
> wrote:
> > > > >
> > > > > For the Aarch64, there is one machine 'virt', it is primarily
> meant to
> > > > > run on KVM and execute virtualization workloads, but we need an
> > > > > environment as faithful as possible to physical hardware, for
> supporting
> > > > > firmware and OS development for pysical Aarch64 machines.
> > > > >
> > > > > This patch introduces new machine type 'sbsa-ref' with main
> features:
> > > > >  - Based on 'virt' machine type.
> > > > >  - A new memory map.
> > > > >  - CPU type cortex-a57.
> > > > >  - EL2 and EL3 are enabled.
> > > > >  - GIC version 3.
> > > > >  - System bus AHCI controller.
> > > > >  - System bus EHCI controller.
> > > >
> > > > Hello Hongbo,
> > > >
> > > > Apologies for bringing this up now, but I seem to remember that the
> > > > EHCI does not support 64-bit DMA. Did you run into any issues with
> > > > this? Or was this fixed in QEMU in the mean time?
> > > >
> > > Hi Ard,
> > > Which EHCI do you mean?
> > > This time I use a newly introduced system bus EHCI, commit 114529f7
> > > and I only tested USB mouse and key board, didn't test DMA function.
> > >
> >
> > The host controller doesn't work without DMA, so if mouse and keyboard
> > worked for you, and no DRAM exists below the 4 GB mark, this has
> > apparently been fixed in QEMU.
>
