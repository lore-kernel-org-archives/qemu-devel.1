Received: from eggs.gnu.org ([2001:4830:134:3::10]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dStwD-00042m-GX
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dStw9-0004fw-EA
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dStw9-0004fX-4z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:42:25 -0400
Date: Wed, 5 Jul 2017 16:42:21 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1499087861-2132-2-git-send-email-owen.smith@citrix.com>
Message-ID: <alpine.DEB.2.10.1707051601260.2919@sstabellini-ThinkPad-X260>
References: <1499087861-2132-1-git-send-email-owen.smith@citrix.com>
	<1499087861-2132-2-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2 v2] xenfb: Use qemu_input_handler_*
 calls directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xen.org, sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com

On Mon, 3 Jul 2017, Owen Smith wrote:
> The xenvkbd input device uses functions from input-legacy.c
> Use the appropriate qemu_input_handler_* functions instead
> of calling functions in input-legacy.c that in turn call
> the correct functions.
> The bulk of this patch removes the extra layer of calls
> by moving the required structure members into the XenInput
> struct.
> 
> Signed-off-by: Owen Smith <owen.smith@citrix.com>
> ---
>  hw/display/xenfb.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 113 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index e76c0d8..88815df 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -27,6 +27,7 @@
>  #include "qemu/osdep.h"
>  
>  #include "hw/hw.h"
> +#include "ui/input.h"
>  #include "ui/console.h"
>  #include "hw/xen/xen_backend.h"
>  
> @@ -54,7 +55,14 @@ struct XenInput {
>      int abs_pointer_wanted; /* Whether guest supports absolute pointer */
>      int button_state;       /* Last seen pointer button state */
>      int extended;
> -    QEMUPutMouseEntry *qmouse;
> +    /* kbd */
> +    QemuInputHandler hkbd;
> +    QemuInputHandlerState *qkbd;
> +    /* mouse */
> +    QemuInputHandler hmouse;
> +    QemuInputHandlerState *qmouse;
> +    int axis[INPUT_AXIS__MAX];
> +    int buttons;
>  };
>  
>  #define UP_QUEUE 8
> @@ -293,6 +301,21 @@ static void xenfb_key_event(void *opaque, int scancode)
>      xenfb_send_key(xenfb, down, scancode2linux[scancode]);
>  }
>  
> +static void xenfb_legacy_key_event(DeviceState *dev, QemuConsole *src,
> +                                   InputEvent *evt)
> +{
> +    struct XenInput *in = (struct XenInput *)dev;
> +    int scancodes[3], i, count;
> +    InputKeyEvent *key = evt->u.key.data;
> +
> +    count = qemu_input_key_value_to_scancode(key->key,
> +                                             key->down,
> +                                             scancodes);
> +    for (i = 0; i < count; ++i) {
> +        xenfb_key_event(in, scancodes[i]);
> +    }
> +}
>  /*
>   * Send a mouse event from the client to the guest OS
>   *
> @@ -333,6 +356,70 @@ static void xenfb_mouse_event(void *opaque,
>      xenfb->button_state = button_state;
>  }
>  
> +static void xenfb_legacy_mouse_event(DeviceState *dev, QemuConsole *src,
> +                                     InputEvent *evt)
> +{
> +    static const int bmap[INPUT_BUTTON__MAX] = {
> +        [INPUT_BUTTON_LEFT]   = MOUSE_EVENT_LBUTTON,
> +        [INPUT_BUTTON_MIDDLE] = MOUSE_EVENT_MBUTTON,
> +        [INPUT_BUTTON_RIGHT]  = MOUSE_EVENT_RBUTTON,
> +    };
> +    struct XenInput *in = (struct XenInput *)dev;
> +    InputBtnEvent *btn;
> +    InputMoveEvent *move;
> +
> +    switch (evt->type) {
> +    case INPUT_EVENT_KIND_BTN:
> +        btn = evt->u.btn.data;
> +        if (btn->down) {
> +            in->buttons |= bmap[btn->button];
> +        } else {
> +            in->buttons &= ~bmap[btn->button];
> +        }
> +        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_UP) {
> +            xenfb_mouse_event(in,
> +                              in->axis[INPUT_AXIS_X],
> +                              in->axis[INPUT_AXIS_Y],
> +                              -1,
> +                              in->buttons);
> +        }
> +        if (btn->down && btn->button == INPUT_BUTTON_WHEEL_DOWN) {
> +            xenfb_mouse_event(in,
> +                              in->axis[INPUT_AXIS_X],
> +                              in->axis[INPUT_AXIS_Y],
> +                              1,
> +                              in->buttons);
> +        }

Why are we sending the WHEEL events from here rather than from
xenfb_legacy_mouse_sync?

Can't we add WHEEL_UP/DOWN to bmap? Unless it is due to a quirk
somewhere, I would store the wheel events in in->buttons or a new field,
then I would send the event to the other end from
xenfb_legacy_mouse_sync. You might have to reset the wheel event in
xenfb_legacy_mouse_sync, because, differently from the buttons, I don't
think we are going to get a corresponding "up" event.


> +        break;
> +    case INPUT_EVENT_KIND_ABS:
> +        move = evt->u.abs.data;
> +        in->axis[move->axis] = move->value;
> +        break;
> +    case INPUT_EVENT_KIND_REL:
> +        move = evt->u.rel.data;
> +        in->axis[move->axis] += move->value;
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +static void xenfb_legacy_mouse_sync(DeviceState *dev)
> +{
> +    struct XenInput *in = (struct XenInput *)dev;
> +
> +    xenfb_mouse_event(in,
> +                      in->axis[INPUT_AXIS_X],
> +                      in->axis[INPUT_AXIS_Y],
> +                      0,
> +                      in->buttons);
> +
> +    if (!in->abs_pointer_wanted) {
> +        in->axis[INPUT_AXIS_X] = 0;
> +        in->axis[INPUT_AXIS_Y] = 0;
> +    }

I think we should take the opportunity to rework and simplify
xenfb_mouse_event: we shouldn't keep track of the button state twice, in
in->buttons and in->button_state. I would get rid of the logic in
xenfb_mouse_event that attempts to figure out if a button was already
down before and just send the event.


> +}
> +
>  static int input_init(struct XenDevice *xendev)
>  {
>      xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
> @@ -353,7 +440,6 @@ static int input_initialise(struct XenDevice *xendev)
>      if (rc != 0)
>  	return rc;
>  
> -    qemu_add_kbd_event_handler(xenfb_key_event, in);
>      return 0;
>  }
>  
> @@ -366,24 +452,43 @@ static void input_connected(struct XenDevice *xendev)
>          in->abs_pointer_wanted = 0;
>      }
>  
> +    if (in->qkbd) {
> +        qemu_input_handler_unregister(in->qkbd);
> +    }
>      if (in->qmouse) {
> -        qemu_remove_mouse_event_handler(in->qmouse);
> +        qemu_input_handler_unregister(in->qmouse);
>      }

Is there a reason for these checks? I realize we already had one here,
but shouldn't input_disconnect already take care of removing the
handlers?


>      trace_xenfb_input_connected(xendev, in->abs_pointer_wanted);
> -    in->qmouse = qemu_add_mouse_event_handler(xenfb_mouse_event, in,
> -					      in->abs_pointer_wanted,
> -					      "Xen PVFB Mouse");
> +
> +    in->hkbd.name = "legacy-kbd";
> +    in->hkbd.mask = INPUT_EVENT_MASK_KEY;
> +    in->hkbd.event = xenfb_legacy_key_event;
> +    in->qkbd = qemu_input_handler_register((DeviceState *)in,
> +                                           &in->hkbd);
> +    qemu_input_handler_activate(in->qkbd);
> +
> +    in->hmouse.name = "Xen PVFB Mouse";
> +    in->hmouse.mask = INPUT_EVENT_MASK_BTN |
> +        (in->abs_pointer_wanted ? INPUT_EVENT_MASK_ABS : INPUT_EVENT_MASK_REL);
> +    in->hmouse.event = xenfb_legacy_mouse_event;
> +    in->hmouse.sync = xenfb_legacy_mouse_sync;
> +    in->qmouse = qemu_input_handler_register((DeviceState *)in,
> +                                             &in->hmouse);
> +    qemu_input_handler_activate(in->qmouse);
>  }
>  
>  static void input_disconnect(struct XenDevice *xendev)
>  {
>      struct XenInput *in = container_of(xendev, struct XenInput, c.xendev);
>  
> +    if (in->qkbd) {
> +        qemu_input_handler_unregister(in->qkbd);
> +        in->qkbd = NULL;
> +    }
>      if (in->qmouse) {
> -	qemu_remove_mouse_event_handler(in->qmouse);
> +        qemu_input_handler_unregister(in->qmouse);
>  	in->qmouse = NULL;

Please align this correctly since you are at it


>      }
> -    qemu_add_kbd_event_handler(NULL, NULL);
>      common_unbind(&in->c);
>  }
>  
> -- 
> 2.1.4
> 
