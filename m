Received: from eggs.gnu.org ([209.51.188.92]:36464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjii-0008Cl-UN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjjig-0001Hl-OB
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:50:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjjig-0001AE-9M
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:50:54 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-27-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ce1a208-43b5-4def-f498-4ec7f98d05ed@redhat.com>
Date: Wed, 16 Jan 2019 12:50:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-27-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 26/37] scsi: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> This lets you disable SCSI altogether with "CONFIG_SCSI=n".

Sorry for my ignorant question, but: Can we really disable SCSI if the
Kconfig files use "select SCSI" all over the place? I'd rather expect
that "CONFIG_SCSI=n" only works if we only use "depends on SCSI" everywhere?

I'm fine if we use select SCSI in this patch, but maybe the commit
message should be tweaked in case you can not really disable SCSI like
this anymore?

 Thomas


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/scsi/Kconfig       | 12 ++++++++++++
>  hw/scsi/Makefile.objs |  2 +-
>  hw/usb/Kconfig        |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index 812a12522b..7a9d373382 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -5,24 +5,29 @@ config LSI_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config MPTSAS_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config MEGASAS_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config VMW_PVSCSI_SCSI_PCI
>      bool
>      default y
>      depends on PCI
> +    select SCSI
>  
>  config ESP
>      bool
> +    select SCSI
>  
>  config ESP_PCI
>      bool
> @@ -30,8 +35,15 @@ config ESP_PCI
>      depends on PCI
>      select ESP
>  
> +config SPAPR_VSCSI
> +    bool
> +    depends on PSERIES
> +    select SCSI
> +
>  config VIRTIO_SCSI
>      bool
> +    default y
> +    select SCSI
>  
>  config VHOST_USER_SCSI
>      bool
> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
> index 45167baeaf..54b36ed8b1 100644
> --- a/hw/scsi/Makefile.objs
> +++ b/hw/scsi/Makefile.objs
> @@ -6,7 +6,7 @@ common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
>  common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
>  common-obj-$(CONFIG_ESP) += esp.o
>  common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
> -obj-$(CONFIG_PSERIES) += spapr_vscsi.o
> +obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
>  
>  ifeq ($(CONFIG_VIRTIO_SCSI),y)
>  obj-y += virtio-scsi.o virtio-scsi-dataplane.o
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 0b8f41040e..db46c56cc8 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -52,11 +52,13 @@ config USB_STORAGE_BOT
>      bool
>      default y
>      depends on USB
> +    select SCSI
>  
>  config USB_STORAGE_UAS
>      bool
>      default y
>      depends on USB
> +    select SCSI
>  
>  config USB_AUDIO
>      bool
> 
