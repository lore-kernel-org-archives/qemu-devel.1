Received: from eggs.gnu.org ([2001:4830:134:3::10]:44226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1copmZ-000303-32
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1copmW-00010C-DZ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:10:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1copmW-0000zl-4u
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:10:52 -0400
References: <alpine.DEB.2.10.1703161241220.14378@sstabellini-ThinkPad-X260>
	<1489694518-16978-1-git-send-email-sstabellini@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90dea027-0cd8-f9bd-0265-b184f1e0e37a@redhat.com>
Date: Fri, 17 Mar 2017 12:10:46 +0100
MIME-Version: 1.0
In-Reply-To: <1489694518-16978-1-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/9] xen: do not build backends for
 targets that do not support xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, jgross@suse.com, groug@kaod.org, Stefano Stabellini <stefano@aporeto.com>, peter.maydell@linaro.org, rth@twiddle.net, stefanha@redhat.com



On 16/03/2017 21:01, Stefano Stabellini wrote:
> Change Makefile.objs to use CONFIG_XEN instead of CONFIG_XEN_BACKEND, so
> that the Xen backends are only built for targets that support Xen.
> 
> Set CONFIG_XEN in the toplevel Makefile to ensure that files that are
> built only once pick up Xen support properly.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>
> CC: groug@kaod.org
> CC: pbonzini@redhat.com
> CC: peter.maydell@linaro.org
> CC: rth@twiddle.net
> CC: stefanha@redhat.com
> ---
>  Makefile                 | 1 +
>  hw/block/Makefile.objs   | 2 +-
>  hw/char/Makefile.objs    | 2 +-
>  hw/display/Makefile.objs | 2 +-
>  hw/net/Makefile.objs     | 2 +-
>  hw/usb/Makefile.objs     | 2 +-
>  hw/xen/Makefile.objs     | 2 +-
>  7 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1c4c04f..b246138 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -26,6 +26,7 @@ endif
>  
>  CONFIG_SOFTMMU := $(if $(filter %-softmmu,$(TARGET_DIRS)),y)
>  CONFIG_USER_ONLY := $(if $(filter %-user,$(TARGET_DIRS)),y)
> +CONFIG_XEN := $(CONFIG_XEN_BACKEND)
>  CONFIG_ALL=y
>  -include config-all-devices.mak
>  -include config-all-disas.mak
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index d4c3ab7..e0ed980 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -4,7 +4,7 @@ common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
>  common-obj-$(CONFIG_NAND) += nand.o
>  common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
>  common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
> -common-obj-$(CONFIG_XEN_BACKEND) += xen_disk.o
> +common-obj-$(CONFIG_XEN) += xen_disk.o
>  common-obj-$(CONFIG_ECC) += ecc.o
>  common-obj-$(CONFIG_ONENAND) += onenand.o
>  common-obj-$(CONFIG_NVME_PCI) += nvme.o
> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
> index 6ea76fe..725fdc4 100644
> --- a/hw/char/Makefile.objs
> +++ b/hw/char/Makefile.objs
> @@ -7,7 +7,7 @@ common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
>  common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
>  common-obj-$(CONFIG_VIRTIO) += virtio-console.o
>  common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
> -common-obj-$(CONFIG_XEN_BACKEND) += xen_console.o
> +common-obj-$(CONFIG_XEN) += xen_console.o
>  common-obj-$(CONFIG_CADENCE) += cadence_uart.o
>  
>  obj-$(CONFIG_EXYNOS4) += exynos4210_uart.o
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index 063889b..3d02e8b 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -5,7 +5,7 @@ common-obj-$(CONFIG_JAZZ_LED) += jazz_led.o
>  common-obj-$(CONFIG_PL110) += pl110.o
>  common-obj-$(CONFIG_SSD0303) += ssd0303.o
>  common-obj-$(CONFIG_SSD0323) += ssd0323.o
> -common-obj-$(CONFIG_XEN_BACKEND) += xenfb.o
> +common-obj-$(CONFIG_XEN) += xenfb.o
>  
>  common-obj-$(CONFIG_VGA_PCI) += vga-pci.o
>  common-obj-$(CONFIG_VGA_ISA) += vga-isa.o
> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
> index 610ed3e..6a95d92 100644
> --- a/hw/net/Makefile.objs
> +++ b/hw/net/Makefile.objs
> @@ -1,5 +1,5 @@
>  common-obj-$(CONFIG_DP8393X) += dp8393x.o
> -common-obj-$(CONFIG_XEN_BACKEND) += xen_nic.o
> +common-obj-$(CONFIG_XEN) += xen_nic.o
>  
>  # PCI network cards
>  common-obj-$(CONFIG_NE2000_PCI) += ne2000.o
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 98b5c9d..5958be8 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -40,5 +40,5 @@ common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
>  common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
>  
>  ifeq ($(CONFIG_USB_LIBUSB),y)
> -common-obj-$(CONFIG_XEN_BACKEND) += xen-usb.o
> +common-obj-$(CONFIG_XEN) += xen-usb.o
>  endif
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 591cdc2..4be3ec9 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -1,5 +1,5 @@
>  # xen backend driver support
> -common-obj-$(CONFIG_XEN_BACKEND) += xen_backend.o xen_devconfig.o xen_pvdev.o
> +common-obj-$(CONFIG_XEN) += xen_backend.o xen_devconfig.o xen_pvdev.o
>  
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
> 

I'm queuing this for 2.9 as a bugfix, adding Xen things to various
softcore emulators makes no sense.

Paolo
