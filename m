Received: from eggs.gnu.org ([2001:4830:134:3::10]:52450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dSu7b-0007xb-F8
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dSu7Y-0000Ju-8w
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dSu7Y-0000Jo-06
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 19:54:12 -0400
Date: Wed, 5 Jul 2017 16:54:09 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1499087861-2132-3-git-send-email-owen.smith@citrix.com>
Message-ID: <alpine.DEB.2.10.1707051643190.2919@sstabellini-ThinkPad-X260>
References: <1499087861-2132-1-git-send-email-owen.smith@citrix.com>
	<1499087861-2132-3-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/2 v2] xenfb: Allow vkbd to connect
 without a DisplayState
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
>  			      int dx, int dy, int dz, int button_state)
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

Shouldn't this be:

  if (xenfb->abs_pointer_wanted || xenfb->raw_pointer_wanted)

?
It it possible to have raw_pointer_wanted && !abs_pointer_wanted? If
not, we should check at connection or initialization time.


> -	xenfb_send_position(xenfb,
> -			    dx * (dw - 1) / 0x7fff,
> -			    dy * (dh - 1) / 0x7fff,
> -			    dz);
> +        xenfb_send_position(xenfb, x, y, dz);
>      else
>  	xenfb_send_motion(xenfb, dx, dy, dz);
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
> -        xen_pv_printf(xendev, 1, "ds not set (yet)\n");
> -        return -1;
> +        char *vfb = xenstore_read_str(NULL, "device/vfb");

Isn't it better to do xenstore_read_str("device", "vfb") ?


> +        if (vfb == NULL) {
> +            /* there is no vfb, run vkbd on its own */
> +        } else {

if (vfb != NULL)


> +            free(vfb);

g_free


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
