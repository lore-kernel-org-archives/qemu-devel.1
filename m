Received: from eggs.gnu.org ([209.51.188.92]:33034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gsDT7-0003E6-RR
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gsDT6-0000XY-Go
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:13:53 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gsDT6-0000K1-Ar
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:13:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id m9so3009355qkl.4
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 13:13:16 -0800 (PST)
Date: Fri, 8 Feb 2019 16:13:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190208161032-mutt-send-email-mst@kernel.org>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208112357.31615-12-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/13] Add vhost-user-input-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Feb 08, 2019 at 12:23:55PM +0100, Marc-André Lureau wrote:
> Add a new virtio-input device, which connects to a vhost-user
> backend.
> 
> vhost-user-input is similar to virtio-input-host, it is wrapped by
> vhost-user-input-pci. Instead of reading configuration directly from
> an input device / evdev, it reads it over vhost-user protocol with
> INPUT_GET_CONFIG message. Then vhost-user-backend takes care of
> interfacing the virtio device with the backend, for the queue & events
> processing.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>


I wonder what do others think of this from interface POV.  It's
*exactly* the same as virtio input from guest POV just a different
backend.  Would it be better to instead just have a vhost-user property
within virtio input specifying the chardev?


> ---
>  include/hw/virtio/virtio-input.h |  14 +++++
>  hw/input/vhost-user-input.c      | 104 +++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user-input-pci.c |  53 ++++++++++++++++
>  MAINTAINERS                      |   1 +
>  default-configs/virtio.mak       |   1 +
>  hw/input/Makefile.objs           |   1 +
>  hw/virtio/Makefile.objs          |   1 +
>  7 files changed, 175 insertions(+)
>  create mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input-pci.c
> 
> diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
> index 054c38836f..4fca03e796 100644
> --- a/include/hw/virtio/virtio-input.h
> +++ b/include/hw/virtio/virtio-input.h
> @@ -2,6 +2,7 @@
>  #define QEMU_VIRTIO_INPUT_H
>  
>  #include "ui/input.h"
> +#include "sysemu/vhost-user-backend.h"
>  
>  /* ----------------------------------------------------------------- */
>  /* virtio input protocol                                             */
> @@ -42,11 +43,18 @@ typedef struct virtio_input_event virtio_input_event;
>  #define VIRTIO_INPUT_HOST_GET_PARENT_CLASS(obj) \
>          OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_INPUT_HOST)
>  
> +#define TYPE_VHOST_USER_INPUT   "vhost-user-input"
> +#define VHOST_USER_INPUT(obj)                              \
> +    OBJECT_CHECK(VHostUserInput, (obj), TYPE_VHOST_USER_INPUT)
> +#define VHOST_USER_INPUT_GET_PARENT_CLASS(obj)             \
> +    OBJECT_GET_PARENT_CLASS(obj, TYPE_VHOST_USER_INPUT)
> +
>  typedef struct VirtIOInput VirtIOInput;
>  typedef struct VirtIOInputClass VirtIOInputClass;
>  typedef struct VirtIOInputConfig VirtIOInputConfig;
>  typedef struct VirtIOInputHID VirtIOInputHID;
>  typedef struct VirtIOInputHost VirtIOInputHost;
> +typedef struct VHostUserInput VHostUserInput;
>  
>  struct VirtIOInputConfig {
>      virtio_input_config               config;
> @@ -98,6 +106,12 @@ struct VirtIOInputHost {
>      int                               fd;
>  };
>  
> +struct VHostUserInput {
> +    VirtIOInput                       parent_obj;
> +
> +    VhostUserBackend                  *vhost;
> +};
> +
>  void virtio_input_send(VirtIOInput *vinput, virtio_input_event *event);
>  void virtio_input_init_config(VirtIOInput *vinput,
>                                virtio_input_config *config);
> diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
> new file mode 100644
> index 0000000000..2ea1e50ab7
> --- /dev/null
> +++ b/hw/input/vhost-user-input.c
> @@ -0,0 +1,104 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu-common.h"
> +
> +#include "hw/qdev.h"
> +#include "hw/virtio/virtio-input.h"
> +
> +static void vhost_input_realize(DeviceState *dev, Error **errp)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(dev);
> +    VirtIOInput *vinput = VIRTIO_INPUT(dev);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    virtio_input_config *config;
> +    int i, ret;
> +
> +    if (!vhi->vhost) {
> +        error_setg(errp, "'vhost-user' property is required");
> +        return;
> +    }
> +
> +    if (vhost_user_backend_dev_init(vhi->vhost, vdev, 2, errp) == -1) {
> +        return;
> +    }
> +
> +    ret = vhost_user_input_get_config(&vhi->vhost->dev, &config);
> +    if (ret < 0) {
> +        error_setg(errp, "failed to get input config");
> +        return;
> +    }
> +    for (i = 0; i < ret; i++) {
> +        virtio_input_add_config(vinput, &config[i]);
> +    }
> +    g_free(config);
> +}
> +
> +static void vhost_input_change_active(VirtIOInput *vinput)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(vinput);
> +
> +    if (vinput->active) {
> +        vhost_user_backend_start(vhi->vhost);
> +    } else {
> +        vhost_user_backend_stop(vhi->vhost);
> +    }
> +}
> +
> +static const VMStateDescription vmstate_vhost_input = {
> +    .name = "vhost-user-input",
> +    .unmigratable = 1,
> +};
> +
> +static void vhost_input_class_init(ObjectClass *klass, void *data)
> +{
> +    VirtIOInputClass *vic = VIRTIO_INPUT_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->vmsd           = &vmstate_vhost_input;
> +    vic->realize       = vhost_input_realize;
> +    vic->change_active = vhost_input_change_active;
> +}
> +
> +static void vhost_input_init(Object *obj)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
> +    VirtIOInput *vinput = VIRTIO_INPUT(obj);
> +    struct virtio_input_config vhost_input_config[] = { { /* empty list */ } };
> +
> +    virtio_input_init_config(vinput, vhost_input_config);
> +
> +    vhi->vhost = VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
> +    object_property_add_alias(obj, "chardev",
> +                              OBJECT(vhi->vhost), "chardev", &error_abort);
> +}
> +
> +static void vhost_input_finalize(Object *obj)
> +{
> +    VHostUserInput *vhi = VHOST_USER_INPUT(obj);
> +
> +    object_unref(OBJECT(vhi->vhost));
> +}
> +
> +static const TypeInfo vhost_input_info = {
> +    .name          = TYPE_VHOST_USER_INPUT,
> +    .parent        = TYPE_VIRTIO_INPUT,
> +    .instance_size = sizeof(VHostUserInput),
> +    .instance_init = vhost_input_init,
> +    .instance_finalize = vhost_input_finalize,
> +    .class_init    = vhost_input_class_init,
> +};
> +
> +/* ----------------------------------------------------------------- */
> +
> +static void vhost_input_register_types(void)
> +{
> +    type_register_static(&vhost_input_info);
> +}
> +
> +type_init(vhost_input_register_types)
> diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-pci.c
> new file mode 100644
> index 0000000000..3d1b7a85fd
> --- /dev/null
> +++ b/hw/virtio/vhost-user-input-pci.c
> @@ -0,0 +1,53 @@
> +/*
> + * This work is licensed under the terms of the GNU LGPL, version 2 or
> + * later.  See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-input.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "virtio-pci.h"
> +
> +typedef struct VHostUserInputPCI VHostUserInputPCI;
> +
> +#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci-base"
> +
> +#define VHOST_USER_INPUT_PCI(obj) \
> +    OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
> +
> +struct VHostUserInputPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserInput vhi;
> +};
> +
> +static void vhost_user_input_pci_instance_init(Object *obj)
> +{
> +    VHostUserInputPCI *dev = VHOST_USER_INPUT_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vhi, sizeof(dev->vhi),
> +                                TYPE_VHOST_USER_INPUT);
> +
> +    object_property_add_alias(obj, "chardev",
> +                              OBJECT(&dev->vhi), "chardev",
> +                              &error_abort);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
> +    .base_name = TYPE_VHOST_USER_INPUT_PCI,
> +    .generic_name = "vhost-user-input-pci",
> +    .transitional_name = "vhost-user-input-pci-transitional",
> +    .non_transitional_name = "vhost-user-input-pci-non-transitional",
> +    .parent = TYPE_VIRTIO_INPUT_PCI,
> +    .instance_size = sizeof(VHostUserInputPCI),
> +    .instance_init = vhost_user_input_pci_instance_init,
> +};
> +
> +static void vhost_user_input_pci_register(void)
> +{
> +    virtio_pci_types_register(&vhost_user_input_pci_info);
> +}
> +
> +type_init(vhost_user_input_pci_register)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e077fe788d..5dfc9531bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1467,6 +1467,7 @@ L: qemu-s390x@nongnu.org
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
> +F: hw/input/vhost-user-input.c
>  F: hw/input/virtio-input*.c
>  F: include/hw/virtio/virtio-input.h
>  
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index ecb4420e74..5f5266ef8b 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -13,3 +13,4 @@ CONFIG_SCSI=y
>  CONFIG_VIRTIO_SCSI=y
>  CONFIG_VIRTIO_SERIAL=y
>  CONFIG_VIRTIO_INPUT_HOST=$(CONFIG_LINUX)
> +CONFIG_VHOST_USER_INPUT=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO_INPUT))
> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
> index c8b00f71ec..9511e3102f 100644
> --- a/hw/input/Makefile.objs
> +++ b/hw/input/Makefile.objs
> @@ -11,6 +11,7 @@ common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input.o
>  common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
>  ifeq ($(CONFIG_LINUX),y)
>  common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-host.o
> +common-obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input.o
>  endif
>  
>  obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index d335dd0a6a..7462051ba3 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -14,6 +14,7 @@ obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>  ifeq ($(CONFIG_VIRTIO_PCI),y)
>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
>  obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
> +obj-$(CONFIG_VHOST_USER_INPUT) += vhost-user-input-pci.o
>  obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
>  obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-pci.o
>  obj-$(CONFIG_VIRTIO_INPUT_HOST) += virtio-input-host-pci.o
> -- 
> 2.20.1.519.g8feddda32c
