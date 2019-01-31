Received: from eggs.gnu.org ([209.51.188.92]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJoT-0003Bx-UZ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpJoS-0004bP-Ae
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:23:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpJoS-0004bA-4X
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:23:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so4877959wrx.9
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:23:56 -0800 (PST)
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-41-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9589c65-57c5-f9e1-e6a2-2970f6070eee@redhat.com>
Date: Thu, 31 Jan 2019 22:23:53 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-41-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 40/52] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 1/25/19 11:06 AM, Paolo Bonzini wrote:
> This automatically removes the SCSI subsystem from the
> binary altogether if no controllers are selected.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/Kconfig       | 11 ++++++++++-
>  hw/scsi/Makefile.objs |  2 +-
>  hw/usb/Kconfig        |  2 ++
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> index c02d880..b9cf269 100644
> --- a/hw/scsi/Kconfig
> +++ b/hw/scsi/Kconfig
> @@ -5,24 +5,29 @@ config LSI_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select SCSI
>  
>  config MPTSAS_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select SCSI
>  
>  config MEGASAS_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select SCSI
>  
>  config VMW_PVSCSI_SCSI_PCI
>      bool
>      default y if PCI_DEVICES
>      depends on PCI
> +    select SCSI
>  
>  config ESP
>      bool
> +    select SCSI
>  
>  config ESP_PCI
>      bool
> @@ -34,10 +39,14 @@ config SPAPR_VSCSI
>      bool
>      default y
>      depends on PSERIES
> +    select SCSI
>  
>  config VIRTIO_SCSI
>      bool
> +    select SCSI
>  
>  config VHOST_USER_SCSI
>      bool
> -    default y if VHOST_USER && LINUX
> +    # Only PCI devices are provided for now
> +    default y if VIRTIO_PCI
> +    depends on VHOST_USER && LINUX
> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
> index 45167ba..54b36ed 100644
> --- a/hw/scsi/Makefile.objs
> +++ b/hw/scsi/Makefile.objs
> @@ -6,7 +6,7 @@ common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o

You missed:

-common-obj-y += scsi-disk.o emulation.o
-common-obj-y += scsi-generic.o scsi-bus.o
+common-obj-$(CONFIG_SCSI) += scsi-disk.o emulation.o
+common-obj-$(CONFIG_SCSI) += scsi-generic.o scsi-bus.o

>  common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
>  common-obj-$(CONFIG_ESP) += esp.o
>  common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
> -obj-$(CONFIG_PSERIES) += spapr_vscsi.o
> +obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
>  
>  ifeq ($(CONFIG_VIRTIO_SCSI),y)
>  obj-y += virtio-scsi.o virtio-scsi-dataplane.o
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index e20670a..a1b7acb 100644
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
