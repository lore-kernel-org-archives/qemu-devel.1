Received: from eggs.gnu.org ([209.51.188.92]:41520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goo3W-0005tu-8l
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1goo3V-0002x4-CL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 06:29:22 -0500
Date: Wed, 30 Jan 2019 12:29:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1548841387-7670-5-git-send-email-thuth@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1901301224420.42161@zero.eik.bme.hu>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH 4/5] ppc: Express dependencies of the
 Sam460EX machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com, qemu-ppc@nongnu.org

Hello,

On Wed, 30 Jan 2019, Thomas Huth wrote:
> Most of the dependencies are now directly selected by the SAM460EX
> switch. We can drop CONFIG_VGA_CIRRUS since this device is already
> selected automatically when CONFIG_PCI_DEVICES is set.
>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> default-configs/ppc-softmmu.mak | 10 ----------
> hw/display/Kconfig              |  1 +
> hw/ppc/Kconfig                  | 12 ++++++++++++
> hw/usb/Kconfig                  |  2 +-
> 4 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
> index 513a8e9..5265d8a 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -25,16 +25,6 @@ CONFIG_PCI_EXPRESS=y
>
> # For Sam460ex
> CONFIG_SAM460EX=y
> -CONFIG_USB_EHCI_SYSBUS=y
> -CONFIG_SM501=y
> -CONFIG_DDC=y
> -CONFIG_IDE_SII3112=y
> -CONFIG_I2C=y
> -CONFIG_AT24C=y
> -CONFIG_BITBANG_I2C=y
> -CONFIG_M41T80=y
> -CONFIG_VGA_CIRRUS=y
> -CONFIG_SMBUS_EEPROM=y
>
> # For Macs
> CONFIG_MAC_OLDWORLD=y
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index c784fe8..f8e6136 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -76,6 +76,7 @@ config MILKYMIST_TMU2
> config SM501
>     bool
>     depends on I2C
> +    select DDC
>
> config TCX
>     bool
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index f6b4206..8bd25ed 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -24,9 +24,21 @@ config PPC440
>
> config PPC4XX
>     bool
> +    select BITBANG_I2C
> +    select PCI
>
> config SAM460EX
>     bool
> +    select AT24C

I don't recognise this as needed. Is it for dependency of something?

> +    select PFLASH_CFI01
> +    select IDE_SII3112
> +    select ISA_BUS          # FIXME: Currently required for IDE_SII3112

This is not really a dependency of SII3112 but of ide/core so this maybe 
this belongs to IDE config?

Otherwise I don't care much if it still compiles so

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Regards,
BALATON Zoltan

> +    select M41T80
> +    select PPC440
> +    select SM501
> +    select SMBUS_EEPROM
> +    select USB_EHCI_SYSBUS
> +    select USB_OHCI
>
> config PREP
>     bool
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index a1b7acb..871ea47 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -21,7 +21,7 @@ config USB_EHCI
>
> config USB_EHCI_SYSBUS
>     bool
> -    select USB
> +    select USB_EHCI
>
> config USB_XHCI
>     bool
>
