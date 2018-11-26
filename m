Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRK6d-0005hQ-6F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRK6Z-000257-6r
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:51:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRK6Z-00024k-0L
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:51:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so19691158wrt.7
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 08:51:26 -0800 (PST)
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<1543238443-4993-4-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <df2493fa-76ce-272c-dd39-731654a76dba@redhat.com>
Date: Mon, 26 Nov 2018 17:51:22 +0100
MIME-Version: 1.0
In-Reply-To: <1543238443-4993-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] vhost: restrict Linux dependency to
 kernel vhost
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 26/11/18 14:20, Paolo Bonzini wrote:
> vhost-user does not depend on Linux; it can run on any POSIX system.  Restrict
> vhost-kernel to Linux in hw/virtio/vhost-backend.c, everything else can be
> compiled on all POSIX systems.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  backends/Makefile.objs     |  5 ++---
>  default-configs/virtio.mak |  4 ++--
>  hw/net/vhost_net.c         |  2 +-
>  hw/virtio/Makefile.objs    |  5 +++--
>  hw/virtio/vhost-backend.c  | 11 +++++++++--
>  5 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> index 717fcbd..ff619d3 100644
> --- a/backends/Makefile.objs
> +++ b/backends/Makefile.objs
> @@ -9,10 +9,9 @@ common-obj-$(CONFIG_POSIX) += hostmem-file.o
>  common-obj-y += cryptodev.o
>  common-obj-y += cryptodev-builtin.o
>  
> -ifeq ($(CONFIG_VIRTIO),y)
> +ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
>  common-obj-y += cryptodev-vhost.o
> -common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += \
> -    cryptodev-vhost-user.o
> +common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
>  endif

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  
>  common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index 1304849..340050a 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -1,5 +1,5 @@
> -CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> -CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> +CONFIG_VHOST_USER_SCSI=$(CONFIG_VHOST_USER)
> +CONFIG_VHOST_USER_BLK=$(CONFIG_VHOST_USER)
>  CONFIG_VIRTIO=y
>  CONFIG_VIRTIO_9P=y
>  CONFIG_VIRTIO_BALLOON=y
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index fe6202a..2a300ee 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -193,7 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>      }
>  
>      /* Set sane init value. Override when guest acks. */
> -#ifdef CONFIG_VHOST_USER
> +#ifdef CONFIG_VHOST_NET_USER
>      if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>          features = vhost_user_get_acked_features(net->nc);
>          if (~net->dev.features & features) {
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index 1b2799c..e8eff80 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -9,9 +9,10 @@ obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
>  obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
>  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>  
> -obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
> +obj-$(CONFIG_VHOST_USER) += vhost-user.o
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
> +obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += vhost.o vhost-backend.o
> +common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))) += vhost-stub.o
>  endif
>  
> -common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
>  common-obj-$(CONFIG_ALL) += vhost-stub.o
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 7f09efa..b5d2e30 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -9,12 +9,14 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include <linux/vhost.h>
> -#include <sys/ioctl.h>
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-backend.h"
>  #include "qemu/error-report.h"
>  
> +#ifdef CONFIG_LINUX
> +#include <linux/vhost.h>
> +#include <sys/ioctl.h>
> +
>  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
>                               void *arg)
>  {
> @@ -265,18 +267,23 @@ static const VhostOps kernel_ops = {
>          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
>  };
> +#endif
>  
>  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
>  {
>      int r = 0;
>  
>      switch (backend_type) {
> +#ifdef CONFIG_LINUX
>      case VHOST_BACKEND_TYPE_KERNEL:
>          dev->vhost_ops = &kernel_ops;
>          break;
> +#endif
> +#ifdef CONFIG_VHOST_USER
>      case VHOST_BACKEND_TYPE_USER:
>          dev->vhost_ops = &user_ops;
>          break;
> +#endif
>      default:
>          error_report("Unknown vhost backend type");
>          r = -1;
> 
