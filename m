Received: from eggs.gnu.org ([209.51.188.92]:39432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnHK-0001QG-If
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hHnHJ-0008TH-Ja
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hHnHJ-0008RF-DK
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:31:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id a184so8719122wma.2
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 03:31:24 -0700 (PDT)
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f1355f2-3508-3f0a-512b-8b97fbda9ae1@redhat.com>
Date: Sat, 20 Apr 2019 12:31:21 +0200
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-3-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 02/29] hw/ide/ahci: Add a
 Kconfig switch for the AHDI-ICH9 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Rob Herring <robh@kernel.org>, qemu-block@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>, Antony Pavlov <antonynpavlov@gmail.com>, Alistair Francis <alistair@alistair23.me>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Some of our machines (like the ARM cubieboard) use CONFIG_AHCI for an AHCI
> sysbus device, but do not use CONFIG_PCI since they do not feature a PCI
> bus. With CONFIG_AHCI but without CONFIG_PCI, currently linking fails:
> 
>     ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>     hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>     hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>     hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>     hw/ide/ich.c:147: undefined reference to `msi_init'
>     ../hw/ide/ich.o: In function `pci_ich9_uninit':
>     hw/ide/ich.c:158: undefined reference to `msi_uninit'
>     ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
> 
> We must only compile ich.c if CONFIG_PCI is available, too, so introduce a
> new config switch for this device.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/ide/Kconfig       | 6 +++++-
>  hw/ide/Makefile.objs | 2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> index ab47b6a7a3..5d9106b1ac 100644
> --- a/hw/ide/Kconfig
> +++ b/hw/ide/Kconfig
> @@ -43,10 +43,14 @@ config MICRODRIVE
>      select IDE_QDEV
>  
>  config AHCI
> +    bool
> +    select IDE_QDEV
> +
> +config AHCI_ICH9
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> -    select IDE_QDEV
> +    select AHCI
>  
>  config IDE_SII3112
>      bool
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index a142add90e..faf04e0209 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) += mmio.o
>  common-obj-$(CONFIG_IDE_VIA) += via.o
>  common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
>  common-obj-$(CONFIG_AHCI) += ahci.o
> -common-obj-$(CONFIG_AHCI) += ich.o
> +common-obj-$(CONFIG_AHCI_ICH9) += ich.o
>  common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
>  common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
> 
