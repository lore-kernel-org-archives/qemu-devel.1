Received: from eggs.gnu.org ([2001:4830:134:3::10]:60991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJh4U-0003VT-KM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fJh4T-0000xZ-I9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:13:30 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fJh4T-0000wX-BT
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:13:29 -0400
Received: by mail-wm0-x244.google.com with SMTP id l1-v6so15875896wmb.2
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 08:13:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180517092513.735-5-kraxel@redhat.com>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-5-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 May 2018 17:13:27 +0200
Message-ID: <CAJ+F1CJ85w4hgeDGCvNjs0TvfEcGprW1GYW6q4Hk=Wy4phHkxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] bochs-display: add pcie support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, May 17, 2018 at 11:25 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Could you explain where the 0x80 offset comes from?


>  hw/display/bochs-display.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 9ea6f798f4..23dbf57b8f 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -254,6 +254,7 @@ static void bochs_display_realize(PCIDevice *dev, Err=
or **errp)
>  {
>      BochsDisplayState *s =3D BOCHS_DISPLAY(dev);
>      Object *obj =3D OBJECT(dev);
> +    int ret;
>
>      s->con =3D graphic_console_init(DEVICE(dev), 0, &bochs_display_gfx_o=
ps, s);
>
> @@ -280,6 +281,12 @@ static void bochs_display_realize(PCIDevice *dev, Er=
ror **errp)
>      pci_register_bar(&s->pci, 0, PCI_BASE_ADDRESS_MEM_PREFETCH, &s->vram=
);
>      pci_register_bar(&s->pci, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio=
);
>
> +    if (pci_bus_is_express(pci_get_bus(dev))) {
> +        dev->cap_present |=3D QEMU_PCI_CAP_EXPRESS;
> +        ret =3D pcie_endpoint_cap_init(dev, 0x80);
> +        assert(ret > 0);
> +    }
> +
>      memory_region_set_log(&s->vram, true, DIRTY_MEMORY_VGA);
>  }
>
> @@ -341,6 +348,7 @@ static const TypeInfo bochs_display_type_info =3D {
>      .instance_init  =3D bochs_display_init,
>      .class_init     =3D bochs_display_class_init,
>      .interfaces     =3D (InterfaceInfo[]) {
> +        { INTERFACE_PCIE_DEVICE },
>          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>          { },
>      },
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
