Received: from eggs.gnu.org ([2001:4830:134:3::10]:60963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <al1img@gmail.com>) id 1dSKAX-0007GE-1Z
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <al1img@gmail.com>) id 1dSKAV-0005A7-E1
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:30:53 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:35856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <al1img@gmail.com>) id 1dSKAV-00059R-8W
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:30:51 -0400
Received: by mail-io0-x241.google.com with SMTP id h134so10811149iof.3
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 02:30:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499087861-2132-3-git-send-email-owen.smith@citrix.com>
References: <1499087861-2132-1-git-send-email-owen.smith@citrix.com>
	<1499087861-2132-3-git-send-email-owen.smith@citrix.com>
From: Oleksandr Grytsov <al1img@gmail.com>
Date: Tue, 4 Jul 2017 12:30:48 +0300
Message-ID: <CACvf2oWT9OUpGj5E4hoR+UM6WrADHTXYzoo7ap2XvTozJgPt6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/2 v2] xenfb: Allow vkbd to
 connect without a DisplayState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: qemu-devel@nongnu.org, anthony.perard@citrix.com, Stefano Stabellini <sstabellini@kernel.org>, kraxel@redhat.com, xen-devel@lists.xen.org

On Mon, Jul 3, 2017 at 4:17 PM, Owen Smith <owen.smith@citrix.com> wrote:
> If the vkbd device model is registered and the vfb device model
> is not registered, the backend will not transition to connected.
> If there is no DisplayState, then the absolute coordinates cannot
> be scaled, and will remain in the range [0, 0x7fff].
> Backend writes "feature-raw-pointer" to indicate that the backend
> supports reporting absolute position without rescaling.
> The frontend uses "request-raw-pointer" to request raw unscaled
> pointer values. If there is no DisplayState, the absolute values
> are always raw unscaled values.
>
> Signed-off-by: Owen Smith <owen.smith@citrix.com>
> ---
>  hw/display/xenfb.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index 88815df..d40af6e 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -53,6 +53,7 @@ struct common {
>  struct XenInput {
>      struct common c;
>      int abs_pointer_wanted; /* Whether guest supports absolute pointer */
> +    int raw_pointer_wanted; /* Whether guest supports unscaled pointer */
>      int button_state;       /* Last seen pointer button state */
>      int extended;
>      /* kbd */
> @@ -329,18 +330,22 @@ static void xenfb_mouse_event(void *opaque,
>                               int dx, int dy, int dz, int button_state)
>  {
>      struct XenInput *xenfb = opaque;
> -    DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
> -    int dw = surface_width(surface);
> -    int dh = surface_height(surface);
> -    int i;
> +    int i, x, y;
> +    if (xenfb->c.con && xenfb->raw_pointer_wanted != 1) {
> +        DisplaySurface *surface = qemu_console_surface(xenfb->c.con);
> +        int dw = surface_width(surface);
> +        int dh = surface_height(surface);
> +        x = dx * (dw - 1) / 0x7fff;
> +        y = dy * (dh - 1) / 0x7fff;
> +    } else {
> +        x = dx;
> +        y = dy;
> +    }
>
>      trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
>                              xenfb->abs_pointer_wanted);
>      if (xenfb->abs_pointer_wanted)
> -       xenfb_send_position(xenfb,
> -                           dx * (dw - 1) / 0x7fff,
> -                           dy * (dh - 1) / 0x7fff,
> -                           dz);
> +        xenfb_send_position(xenfb, x, y, dz);
>      else
>         xenfb_send_motion(xenfb, dx, dy, dz);
>
> @@ -423,6 +428,7 @@ static void xenfb_legacy_mouse_sync(DeviceState *dev)
>  static int input_init(struct XenDevice *xendev)
>  {
>      xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
> +    xenstore_write_be_int(xendev, "feature-raw-pointer", 1);
>      return 0;
>  }
>
> @@ -432,8 +438,14 @@ static int input_initialise(struct XenDevice *xendev)
>      int rc;
>
>      if (!in->c.con) {

It doesn't look like proper way. If I understand this condition
correctly, you are trying to
launch the vkbd backend even if there is no fb configured. It means
the vkbd backend
will be always startedeven if it is not needed.

I'm working on the patch which allows to launch vkbd backend separately from fb.
We need it to be able to launch our own backend in user space [1].

I think proper way is:
1. Add standalone vkbd configuration to xl.cfg.
2. Redesign xen_init_display in way it allows to start vkbd without vfb.

The item 1. will be in my patch.

> -        xen_pv_printf(xendev, 1, "ds not set (yet)\n");
> -        return -1;
> +        char *vfb = xenstore_read_str(NULL, "device/vfb");

This xenstore_read_str will not work as expected. I guess
this line will try to read entry from "(null)/device/vfb" which is
always doesn't exist. See xenstore_read_str implementation.

> +        if (vfb == NULL) {
> +            /* there is no vfb, run vkbd on its own */
> +        } else {
> +            free(vfb);
> +            xen_pv_printf(xendev, 1, "ds not set (yet)\n");
> +            return -1;
> +        }
>      }
>
>      rc = common_bind(&in->c);
> @@ -451,6 +463,10 @@ static void input_connected(struct XenDevice *xendev)
>                               &in->abs_pointer_wanted) == -1) {
>          in->abs_pointer_wanted = 0;
>      }
> +    if (xenstore_read_fe_int(xendev, "request-raw-pointer",
> +                             &in->raw_pointer_wanted) == -1) {
> +        in->raw_pointer_wanted = 0;
> +    }
>
>      if (in->qkbd) {
>          qemu_input_handler_unregister(in->qkbd);
> --
> 2.1.4
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> https://lists.xen.org/xen-devel

[1] http://marc.info/?l=qemu-devel&m=149266892429889&w=2
