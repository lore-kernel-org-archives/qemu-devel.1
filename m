Received: from eggs.gnu.org ([2001:4830:134:3::10]:43478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkWnc-0000HQ-9C
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkWna-0002Vu-Bs
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:38:28 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:34443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkWna-0002VF-5U
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:38:26 -0400
Received: by mail-vk0-x244.google.com with SMTP id d124so141385vkf.1
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20170823135113.25769-1-kraxel@redhat.com>
In-Reply-To: <20170823135113.25769-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 23 Aug 2017 14:38:13 +0000
Message-ID: <CAJ+F1CLtURFmjV6JYDtN6AX4_1F9JLAc8WcR62safC4yJQbNfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Aug 23, 2017 at 3:52 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> qemu uses wheel-up/down button events for mouse wheel input, however
> linux applications typically want REL_WHEEL events.
>
> This fixes wheel with linux guests. Tested with X11/wayland, and
> windows virtio-input driver.
>
> Based on a patch from Marc.
> Added property to enable/disable wheel axis.
> TODO: add compat properties for old machine types.
>

I guess this patch isn't enough to handle migration? Why not modify
hw/compat.h with this patch?


> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

Otherwise looks good to me

---
>  include/hw/virtio/virtio-input.h |   1 +
>  hw/input/virtio-input-hid.c      | 119
> +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 115 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-input.h
> b/include/hw/virtio/virtio-input.h
> index 91df57eca4..054c38836f 100644
> --- a/include/hw/virtio/virtio-input.h
> +++ b/include/hw/virtio/virtio-input.h
> @@ -89,6 +89,7 @@ struct VirtIOInputHID {
>      QemuInputHandler                  *handler;
>      QemuInputHandlerState             *hs;
>      int                               ledstate;
> +    bool                              wheel_axis;
>  };
>
>  struct VirtIOInputHost {
> diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
> index 46c038110c..79ab92e89f 100644
> --- a/hw/input/virtio-input-hid.c
> +++ b/hw/input/virtio-input-hid.c
> @@ -190,6 +190,7 @@ static void virtio_input_key_config(VirtIOInput
> *vinput,
>  static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src=
,
>                                        InputEvent *evt)
>  {
> +    VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(dev);
>      VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
>      virtio_input_event event;
>      int qcode;
> @@ -215,7 +216,14 @@ static void virtio_input_handle_event(DeviceState
> *dev, QemuConsole *src,
>          break;
>      case INPUT_EVENT_KIND_BTN:
>          btn =3D evt->u.btn.data;
> -        if (keymap_button[btn->button]) {
> +        if (vhid->wheel_axis && (btn->button =3D=3D INPUT_BUTTON_WHEEL_U=
P ||
> +                                 btn->button =3D=3D INPUT_BUTTON_WHEEL_D=
OWN))
> {
> +            event.type  =3D cpu_to_le16(EV_REL);
> +            event.code  =3D cpu_to_le16(REL_WHEEL);
> +            event.value =3D cpu_to_le32(btn->button =3D=3D INPUT_BUTTON_=
WHEEL_UP
> +                                      ? 1 : -1);
> +            virtio_input_send(vinput, &event);
> +        } else if (keymap_button[btn->button]) {
>              event.type  =3D cpu_to_le16(EV_KEY);
>              event.code  =3D cpu_to_le16(keymap_button[btn->button]);
>              event.value =3D cpu_to_le32(btn->down ? 1 : 0);
> @@ -407,7 +415,7 @@ static QemuInputHandler virtio_mouse_handler =3D {
>      .sync  =3D virtio_input_handle_sync,
>  };
>
> -static struct virtio_input_config virtio_mouse_config[] =3D {
> +static struct virtio_input_config virtio_mouse_config_v1[] =3D {
>      {
>          .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
>          .size      =3D sizeof(VIRTIO_ID_NAME_MOUSE),
> @@ -432,13 +440,53 @@ static struct virtio_input_config
> virtio_mouse_config[] =3D {
>      { /* end of list */ },
>  };
>
> +static struct virtio_input_config virtio_mouse_config_v2[] =3D {
> +    {
> +        .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
> +        .size      =3D sizeof(VIRTIO_ID_NAME_MOUSE),
> +        .u.string  =3D VIRTIO_ID_NAME_MOUSE,
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_ID_DEVIDS,
> +        .size      =3D sizeof(struct virtio_input_devids),
> +        .u.ids     =3D {
> +            .bustype =3D const_le16(BUS_VIRTUAL),
> +            .vendor  =3D const_le16(0x0627), /* same we use for usb hid
> devices */
> +            .product =3D const_le16(0x0002),
> +            .version =3D const_le16(0x0002),
> +        },
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
> +        .subsel    =3D EV_REL,
> +        .size      =3D 2,
> +        .u.bitmap  =3D {
> +            (1 << REL_X) | (1 << REL_Y),
> +            (1 << (REL_WHEEL - 8))
> +        },
> +    },
> +    { /* end of list */ },
> +};
> +
> +static Property virtio_mouse_properties[] =3D {
> +    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_mouse_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props  =3D virtio_mouse_properties;
> +}
> +
>  static void virtio_mouse_init(Object *obj)
>  {
>      VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(obj);
>      VirtIOInput *vinput =3D VIRTIO_INPUT(obj);
>
>      vhid->handler =3D &virtio_mouse_handler;
> -    virtio_input_init_config(vinput, virtio_mouse_config);
> +    virtio_input_init_config(vinput, vhid->wheel_axis
> +                             ? virtio_mouse_config_v2
> +                             : virtio_mouse_config_v1);
>      virtio_input_key_config(vinput, keymap_button,
>                              ARRAY_SIZE(keymap_button));
>  }
> @@ -448,6 +496,7 @@ static const TypeInfo virtio_mouse_info =3D {
>      .parent        =3D TYPE_VIRTIO_INPUT_HID,
>      .instance_size =3D sizeof(VirtIOInputHID),
>      .instance_init =3D virtio_mouse_init,
> +    .class_init    =3D virtio_mouse_class_init,
>  };
>
>  /* ----------------------------------------------------------------- */
> @@ -459,7 +508,7 @@ static QemuInputHandler virtio_tablet_handler =3D {
>      .sync  =3D virtio_input_handle_sync,
>  };
>
> -static struct virtio_input_config virtio_tablet_config[] =3D {
> +static struct virtio_input_config virtio_tablet_config_v1[] =3D {
>      {
>          .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
>          .size      =3D sizeof(VIRTIO_ID_NAME_TABLET),
> @@ -496,13 +545,72 @@ static struct virtio_input_config
> virtio_tablet_config[] =3D {
>      { /* end of list */ },
>  };
>
> +static struct virtio_input_config virtio_tablet_config_v2[] =3D {
> +    {
> +        .select    =3D VIRTIO_INPUT_CFG_ID_NAME,
> +        .size      =3D sizeof(VIRTIO_ID_NAME_TABLET),
> +        .u.string  =3D VIRTIO_ID_NAME_TABLET,
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_ID_DEVIDS,
> +        .size      =3D sizeof(struct virtio_input_devids),
> +        .u.ids     =3D {
> +            .bustype =3D const_le16(BUS_VIRTUAL),
> +            .vendor  =3D const_le16(0x0627), /* same we use for usb hid
> devices */
> +            .product =3D const_le16(0x0003),
> +            .version =3D const_le16(0x0002),
> +        },
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
> +        .subsel    =3D EV_ABS,
> +        .size      =3D 1,
> +        .u.bitmap  =3D {
> +            (1 << ABS_X) | (1 << ABS_Y),
> +        },
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_EV_BITS,
> +        .subsel    =3D EV_REL,
> +        .size      =3D 2,
> +        .u.bitmap  =3D {
> +            0,
> +            (1 << (REL_WHEEL - 8))
> +        },
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_ABS_INFO,
> +        .subsel    =3D ABS_X,
> +        .size      =3D sizeof(virtio_input_absinfo),
> +        .u.abs.min =3D const_le32(INPUT_EVENT_ABS_MIN),
> +        .u.abs.max =3D const_le32(INPUT_EVENT_ABS_MAX),
> +    },{
> +        .select    =3D VIRTIO_INPUT_CFG_ABS_INFO,
> +        .subsel    =3D ABS_Y,
> +        .size      =3D sizeof(virtio_input_absinfo),
> +        .u.abs.min =3D const_le32(INPUT_EVENT_ABS_MIN),
> +        .u.abs.max =3D const_le32(INPUT_EVENT_ABS_MAX),
> +    },
> +    { /* end of list */ },
> +};
> +
> +static Property virtio_tablet_properties[] =3D {
> +    DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_tablet_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->props  =3D virtio_tablet_properties;
> +}
> +
>  static void virtio_tablet_init(Object *obj)
>  {
>      VirtIOInputHID *vhid =3D VIRTIO_INPUT_HID(obj);
>      VirtIOInput *vinput =3D VIRTIO_INPUT(obj);
>
>      vhid->handler =3D &virtio_tablet_handler;
> -    virtio_input_init_config(vinput, virtio_tablet_config);
> +    virtio_input_init_config(vinput, vhid->wheel_axis
> +                             ? virtio_tablet_config_v2
> +                             : virtio_tablet_config_v1);
>      virtio_input_key_config(vinput, keymap_button,
>                              ARRAY_SIZE(keymap_button));
>  }
> @@ -512,6 +620,7 @@ static const TypeInfo virtio_tablet_info =3D {
>      .parent        =3D TYPE_VIRTIO_INPUT_HID,
>      .instance_size =3D sizeof(VirtIOInputHID),
>      .instance_init =3D virtio_tablet_init,
> +    .class_init    =3D virtio_tablet_class_init,
>  };
>
>  /* ----------------------------------------------------------------- */
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
