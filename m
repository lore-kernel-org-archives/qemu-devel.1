Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt1p-0002Gh-Ty
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt1m-00037x-4H
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:23 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:33741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cdt1l-00037D-U1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:25:22 -0500
Received: by mail-io0-x244.google.com with SMTP id 101so11421681iom.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:25:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <589a85b8.3c2b9d0a.b8e6.1434@mx.google.com>
References: <589a85b8.3c2b9d0a.b8e6.1434@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Feb 2017 14:25:18 +0800
Message-ID: <CAKXe6SKzTgXe0H27wySz1YgA1O-fq9Xg+dMxtAaTT7V1Bg+ScA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] usb: ehci: fix memory leak in ehci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Li Qiang <liqiang6-s@360.cn>

Ping...

2017-02-08 10:42 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> In usb_ehci_init function, it initializes 's->ipacket', but there
> is no corresponding function to free this. As the ehci can be hotplug
> and unplug, this will leak host memory leak. In order to make the
> hierarchy clean, we should add a ehci pci finalize function, then call
> the clean function in ehci device.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/usb/hcd-ehci-pci.c | 9 +++++++++
>  hw/usb/hcd-ehci.c     | 5 +++++
>  hw/usb/hcd-ehci.h     | 1 +
>  3 files changed, 15 insertions(+)
>
> diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
> index 5657705..6dedcb8 100644
> --- a/hw/usb/hcd-ehci-pci.c
> +++ b/hw/usb/hcd-ehci-pci.c
> @@ -89,6 +89,14 @@ static void usb_ehci_pci_init(Object *obj)
>      usb_ehci_init(s, DEVICE(obj));
>  }
>
> +static void usb_ehci_pci_finalize(Object *obj)
> +{
> +    EHCIPCIState *i = PCI_EHCI(obj);
> +    EHCIState *s = &i->ehci;
> +
> +    usb_ehci_finalize(s);
> +}
> +
>  static void usb_ehci_pci_exit(PCIDevice *dev)
>  {
>      EHCIPCIState *i = PCI_EHCI(dev);
> @@ -159,6 +167,7 @@ static const TypeInfo ehci_pci_type_info = {
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(EHCIPCIState),
>      .instance_init = usb_ehci_pci_init,
> +    .instance_finalize = usb_ehci_pci_finalize,
>      .abstract = true,
>      .class_init = ehci_class_init,
>  };
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 7622a3a..50ef817 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2545,6 +2545,11 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)
>                                  &s->mem_ports);
>  }
>
> +void usb_ehci_finalize(EHCIState *s)
> +{
> +    usb_packet_cleanup(&s->ipacket);
> +}
> +
>  /*
>   * vim: expandtab ts=4
>   */
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 3fd7038..938d8aa 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -323,6 +323,7 @@ struct EHCIState {
>  extern const VMStateDescription vmstate_ehci;
>
>  void usb_ehci_init(EHCIState *s, DeviceState *dev);
> +void usb_ehci_finalize(EHCIState *s);
>  void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp);
>  void usb_ehci_unrealize(EHCIState *s, DeviceState *dev, Error **errp);
>  void ehci_reset(void *opaque);
> --
> 1.8.3.1
>
>
