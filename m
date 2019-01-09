Received: from eggs.gnu.org ([209.51.188.92]:54733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gh4AN-0000ju-IJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 22:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gh4AL-0003QP-7Y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 22:04:27 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gh4AG-0003J4-6p
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 22:04:21 -0500
Received: by mail-lj1-x244.google.com with SMTP id q2-v6so5185151lji.10
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 19:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20190108155354.8591-1-kraxel@redhat.com>
	<20190108155354.8591-5-kraxel@redhat.com>
In-Reply-To: <20190108155354.8591-5-kraxel@redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 9 Jan 2019 11:03:59 +0800
Message-ID: <CAHmQWvDXFZ=PJdCM2VLjjcFpd9gcO6zd0PvyNC8JvEpg3TU3Gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 4/5] hw/usb: Add generic sys-bus EHCI
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

Thanks, Gerd.

On Tue, 8 Jan 2019 at 23:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Hongbo Zhang <hongbo.zhang@linaro.org>
>
> This patch introduces a new system bus generic EHCI controller.
> For the system bus EHCI controller, we've already had "xlnx",
> "exynos4210", "tegra2", "ppc4xx" and "fusbh200", they are specific and
> only suitable for their own platforms, platforms such as an Arm server,
> may need a generic system bus EHCI controller, this patch creates it,
> and the kernel driver ehci_platform.c works well on it.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> Message-id: 1546077657-22637-1-git-send-email-hongbo.zhang@linaro.org
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-ehci.h        |  1 +
>  hw/usb/hcd-ehci-sysbus.c | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 0bc364b286..cd30b5d5e0 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -342,6 +342,7 @@ typedef struct EHCIPCIState {
>
>
>  #define TYPE_SYS_BUS_EHCI "sysbus-ehci-usb"
> +#define TYPE_PLATFORM_EHCI "platform-ehci-usb"
>  #define TYPE_EXYNOS4210_EHCI "exynos4210-ehci-usb"
>  #define TYPE_TEGRA2_EHCI "tegra2-ehci-usb"
>  #define TYPE_PPC4xx_EHCI "ppc4xx-ehci-usb"
> diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
> index 3b83beb140..331faf8bc3 100644
> --- a/hw/usb/hcd-ehci-sysbus.c
> +++ b/hw/usb/hcd-ehci-sysbus.c
> @@ -94,6 +94,22 @@ static const TypeInfo ehci_type_info = {
>      .class_size    = sizeof(SysBusEHCIClass),
>  };
>
> +static void ehci_platform_class_init(ObjectClass *oc, void *data)
> +{
> +    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    sec->capsbase = 0x0;
> +    sec->opregbase = 0x20;
> +    set_bit(DEVICE_CATEGORY_USB, dc->categories);
> +}
> +
> +static const TypeInfo ehci_platform_type_info = {
> +    .name          = TYPE_PLATFORM_EHCI,
> +    .parent        = TYPE_SYS_BUS_EHCI,
> +    .class_init    = ehci_platform_class_init,
> +};
> +
>  static void ehci_xlnx_class_init(ObjectClass *oc, void *data)
>  {
>      SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
> @@ -245,6 +261,7 @@ static const TypeInfo ehci_fusbh200_type_info = {
>  static void ehci_sysbus_register_types(void)
>  {
>      type_register_static(&ehci_type_info);
> +    type_register_static(&ehci_platform_type_info);
>      type_register_static(&ehci_xlnx_type_info);
>      type_register_static(&ehci_exynos4210_type_info);
>      type_register_static(&ehci_tegra2_type_info);
> --
> 2.9.3
>
