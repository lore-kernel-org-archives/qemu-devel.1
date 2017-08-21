Received: from eggs.gnu.org ([2001:4830:134:3::10]:58821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djvsx-0006zX-9x
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 19:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1djvsu-0001kS-3k
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 19:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1djvst-0001kL-RA
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 19:13:28 -0400
Date: Mon, 21 Aug 2017 16:13:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1501081831-9587-3-git-send-email-owen.smith@citrix.com>
Message-ID: <alpine.DEB.2.10.1708211612360.12143@sstabellini-ThinkPad-X260>
References: <1501081831-9587-1-git-send-email-owen.smith@citrix.com>
	<1501081831-9587-3-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 2/2 v3] xenfb: Add
 [feature|request]-raw-pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Owen Smith <owen.smith@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org, anthony.perard@citrix.com

On Wed, 26 Jul 2017, Owen Smith wrote:
> Writes "feature-raw-pointer" during init to indicate the backend
> can pass raw unscaled values for absolute axes to the frontend.
> Frontends set "request-raw-pointer" to indicate the backend should
> not attempt to scale absolute values to console size.
> "request-raw-pointer" is only valid if "request-abs-pointer" is
> also set. Raw unscaled pointer values are in the range [0, 0x7fff]
> 
> "feature-raw-pointer" and "request-raw-pointer" added to Xen
> header in commit 7868654ff7fe5e4a2eeae2b277644fa884a5031e
> 
> Signed-off-by: Owen Smith <owen.smith@citrix.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/display/xenfb.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index e412753..f397f9a 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -50,6 +50,7 @@ struct common {
>  struct XenInput {
>      struct common c;
>      int abs_pointer_wanted; /* Whether guest supports absolute pointer */
> +    int raw_pointer_wanted; /* Whether guest supports raw (unscaled) pointer */
>      QemuInputHandlerState *qkbd;
>      QemuInputHandlerState *qmou;
>      int mouse_axes[INPUT_AXIS__MAX];
> @@ -380,21 +381,23 @@ static void xenfb_mouse_sync(DeviceState *dev)
>                              in->abs_pointer_wanted);
>  
>      if (in->abs_pointer_wanted) {
> -        QemuConsole *con = qemu_console_lookup_by_index(0);
> -        DisplaySurface *surface;
> -        int dw, dh;
> -
> -        if (!con) {
> -            xen_pv_printf(&in->c.xendev, 0, "No QEMU console available");
> -            return;
> -        }
> +        if (!in->raw_pointer_wanted) {
> +            QemuConsole *con = qemu_console_lookup_by_index(0);
> +            DisplaySurface *surface;
> +            int dw, dh;
> +
> +            if (!con) {
> +                xen_pv_printf(&in->c.xendev, 0, "No QEMU console available");
> +                return;
> +            }
>  
> -        surface = qemu_console_surface(con);
> -        dw = surface_width(surface);
> -        dh = surface_height(surface);
> +            surface = qemu_console_surface(con);
> +            dw = surface_width(surface);
> +            dh = surface_height(surface);
>  
> -        dx = dx * (dw - 1) / 0x7fff;
> -        dy = dy * (dh - 1) / 0x7fff;
> +            dx = dx * (dw - 1) / 0x7fff;
> +            dy = dy * (dh - 1) / 0x7fff;
> +        }
>  
>          xenfb_send_position(in, dx, dy, dz);
>      } else {
> @@ -428,6 +431,7 @@ static QemuInputHandler xenfb_rel_mouse = {
>  static int input_init(struct XenDevice *xendev)
>  {
>      xenstore_write_be_int(xendev, "feature-abs-pointer", 1);
> +    xenstore_write_be_int(xendev, "feature-raw-pointer", 1);
>      return 0;
>  }
>  
> @@ -451,6 +455,13 @@ static void input_connected(struct XenDevice *xendev)
>                               &in->abs_pointer_wanted) == -1) {
>          in->abs_pointer_wanted = 0;
>      }
> +    if (xenstore_read_fe_int(xendev, "request-raw-pointer",
> +                             &in->raw_pointer_wanted) == -1) {
> +        in->raw_pointer_wanted = 0;
> +    }
> +    if (in->raw_pointer_wanted && !in->abs_pointer_wanted) {
> +        xen_pv_printf(xendev, 0, "raw pointer set without absolute pointer.");
> +    }
>  
>      if (in->qkbd) {
>          qemu_input_handler_unregister(in->qkbd);
> -- 
> 2.1.4
> 
