Received: from eggs.gnu.org ([2001:4830:134:3::10]:34967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=35449720d=Paul.Durrant@citrix.com>)
	id 1dTO2h-0003ZH-6Z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=35449720d=Paul.Durrant@citrix.com>)
	id 1dTO2d-0003T8-Vb
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:51:11 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:8300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=35449720d=Paul.Durrant@citrix.com>)
	id 1dTO2d-0003Sd-HG
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:51:07 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Fri, 7 Jul 2017 07:51:03 +0000
Message-ID: <0ea9c9d615c84813a8f2cdb098a0f78e@AMSPEX02CL01.citrite.net>
References: <alpine.DEB.2.10.1707061641460.2919@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1707061641460.2919@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] xenfb: remove xen_init_display
 "temporary" hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>, Owen
	Smith <owen.smith@citrix.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 07 July 2017 00:48
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: sstabellini@kernel.org; peter.maydell@linaro.org; Anthony Perard
> <anthony.perard@citrix.com>; kraxel@redhat.com; Paul Durrant
> <Paul.Durrant@citrix.com>; Owen Smith <owen.smith@citrix.com>
> Subject: [PATCH v3] xenfb: remove xen_init_display "temporary" hack
>=20
> Initialize xenfb properly, as all other backends, from its own
> "initialise" function.
>=20
> Remove the dependency of vkbd on vfb: use
> qemu_console_lookup_by_index
> to find the principal console (to get the size of the screen) instead of
> relying on a vfb backend to be available (which adds a dependency
> between the two).
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> ---
> Note that this patch conflicts with Owen's series
> (http://secure-web.cisco.com/1jP-
> CKLunauJRBQedgDNfgct9mtg_pNYLJWNBDT-
> zM4mg5Am27ioYBmyUMxhbMGM-97-
> en9LEKERq7K7PwzK4kZBJPu8kasnucJpwQLHGLR1ZwG8yq6QbP-
> RZeThfWp42NwZdDfCV4gMKbZJgmcMEA9Vh4i3YlDjFbj8UtWwVNBCFiVYwpL
> iMtPnfwwfoPhs0Ejm-ylu-jvLn6qqqxntDe1wQ8OXB2Q-
> PvqCLVV55pmM3cgmnYKy2curl0CpByIQe0JtMcKS8aReLRVAFPGLMMw/http
> %3A%2F%2Fmarc.info%2F%3Fl%3Dqemu-
> devel%26m%3D149908803419893%26w%3D2). However it
> should be very easy to rebase one on top of the other.
>=20
> Changes in v3:
> - use qemu_console_lookup_by_index to find the console from
>   xenfb_mouse_event
> - remove con from struct common and add it to struct XenFB
> - remove in->c.con check from input_initialise

Thanks. All looks good now :-)

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

>=20
> Changes in v2:
> - remove xen_init_display from xen_backend.h
> - handle cases where vkbd is missing
>=20
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index e76c0d8..df8b78f 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
> @@ -46,7 +46,6 @@
>  struct common {
>      struct XenDevice  xendev;  /* must be first */
>      void              *page;
> -    QemuConsole       *con;
>  };
>=20
>  struct XenInput {
> @@ -61,6 +60,7 @@ struct XenInput {
>=20
>  struct XenFB {
>      struct common     c;
> +    QemuConsole       *con;
>      size_t            fb_len;
>      int               row_stride;
>      int               depth;
> @@ -71,7 +71,6 @@ struct XenFB {
>      int               fbpages;
>      int               feature_update;
>      int               bug_trigger;
> -    int               have_console;
>      int               do_resize;
>=20
>      struct {
> @@ -80,6 +79,7 @@ struct XenFB {
>      int               up_count;
>      int               up_fullscreen;
>  };
> +static const GraphicHwOps xenfb_ops;
>=20
>  /* -------------------------------------------------------------------- =
*/
>=20
> @@ -306,10 +306,18 @@ static void xenfb_mouse_event(void *opaque,
>  			      int dx, int dy, int dz, int button_state)
>  {
>      struct XenInput *xenfb =3D opaque;
> -    DisplaySurface *surface =3D qemu_console_surface(xenfb->c.con);
> -    int dw =3D surface_width(surface);
> -    int dh =3D surface_height(surface);
> -    int i;
> +    QemuConsole *con =3D qemu_console_lookup_by_index(0);
> +    DisplaySurface *surface;
> +    int dw, dh, i;
> +
> +    if (!con) {
> +        xen_pv_printf(&xenfb->c.xendev, 0, "No QEMU console available");
> +        return;
> +    }
> +
> +    surface =3D qemu_console_surface(con);
> +    dw =3D surface_width(surface);
> +    dh =3D surface_height(surface);
>=20
>      trace_xenfb_mouse_event(opaque, dx, dy, dz, button_state,
>                              xenfb->abs_pointer_wanted);
> @@ -344,11 +352,6 @@ static int input_initialise(struct XenDevice *xendev=
)
>      struct XenInput *in =3D container_of(xendev, struct XenInput, c.xend=
ev);
>      int rc;
>=20
> -    if (!in->c.con) {
> -        xen_pv_printf(xendev, 1, "ds not set (yet)\n");
> -        return -1;
> -    }
> -
>      rc =3D common_bind(&in->c);
>      if (rc !=3D 0)
>  	return rc;
> @@ -608,7 +611,7 @@ static int xenfb_configure_fb(struct XenFB *xenfb,
> size_t fb_len_lim,
>   */
>  static void xenfb_guest_copy(struct XenFB *xenfb, int x, int y, int w, i=
nt h)
>  {
> -    DisplaySurface *surface =3D qemu_console_surface(xenfb->c.con);
> +    DisplaySurface *surface =3D qemu_console_surface(xenfb->con);
>      int line, oops =3D 0;
>      int bpp =3D surface_bits_per_pixel(surface);
>      int linesize =3D surface_stride(surface);
> @@ -642,7 +645,7 @@ static void xenfb_guest_copy(struct XenFB *xenfb,
> int x, int y, int w, int h)
>          xen_pv_printf(&xenfb->c.xendev, 0, "%s: oops: convert %d -> %d
> bpp?\n",
>                        __FUNCTION__, xenfb->depth, bpp);
>=20
> -    dpy_gfx_update(xenfb->c.con, x, y, w, h);
> +    dpy_gfx_update(xenfb->con, x, y, w, h);
>  }
>=20
>  #ifdef XENFB_TYPE_REFRESH_PERIOD
> @@ -728,7 +731,7 @@ static void xenfb_update(void *opaque)
>              surface =3D qemu_create_displaysurface(xenfb->width, xenfb->=
height);
>              break;
>          }
> -        dpy_gfx_replace_surface(xenfb->c.con, surface);
> +        dpy_gfx_replace_surface(xenfb->con, surface);
>          xen_pv_printf(&xenfb->c.xendev, 1,
>                        "update: resizing: %dx%d @ %d bpp%s\n",
>                        xenfb->width, xenfb->height, xenfb->depth,
> @@ -877,16 +880,7 @@ static int fb_initialise(struct XenDevice *xendev)
>      if (rc !=3D 0)
>  	return rc;
>=20
> -#if 0  /* handled in xen_init_display() for now */
> -    if (!fb->have_console) {
> -        fb->c.ds =3D graphic_console_init(xenfb_update,
> -                                        xenfb_invalidate,
> -                                        NULL,
> -                                        NULL,
> -                                        fb);
> -        fb->have_console =3D 1;
> -    }
> -#endif
> +    fb->con =3D graphic_console_init(NULL, 0, &xenfb_ops, fb);
>=20
>      if (xenstore_read_fe_int(xendev, "feature-update", &fb-
> >feature_update) =3D=3D -1)
>  	fb->feature_update =3D 0;
> @@ -972,42 +966,3 @@ static const GraphicHwOps xenfb_ops =3D {
>      .gfx_update  =3D xenfb_update,
>      .update_interval =3D xenfb_update_interval,
>  };
> -
> -/*
> - * FIXME/TODO: Kill this.
> - * Temporary needed while DisplayState reorganization is in flight.
> - */
> -void xen_init_display(int domid)
> -{
> -    struct XenDevice *xfb, *xin;
> -    struct XenFB *fb;
> -    struct XenInput *in;
> -    int i =3D 0;
> -
> -wait_more:
> -    i++;
> -    main_loop_wait(true);
> -    xfb =3D xen_pv_find_xendev("vfb", domid, 0);
> -    xin =3D xen_pv_find_xendev("vkbd", domid, 0);
> -    if (!xfb || !xin) {
> -        if (i < 256) {
> -            usleep(10000);
> -            goto wait_more;
> -        }
> -        xen_pv_printf(NULL, 1, "displaystate setup failed\n");
> -        return;
> -    }
> -
> -    /* vfb */
> -    fb =3D container_of(xfb, struct XenFB, c.xendev);
> -    fb->c.con =3D graphic_console_init(NULL, 0, &xenfb_ops, fb);
> -    fb->have_console =3D 1;
> -
> -    /* vkbd */
> -    in =3D container_of(xin, struct XenInput, c.xendev);
> -    in->c.con =3D fb->c.con;
> -
> -    /* retry ->init() */
> -    xen_be_check_state(xin);
> -    xen_be_check_state(xfb);
> -}
> diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
> index 79aef4e..31d2f25 100644
> --- a/hw/xenpv/xen_machine_pv.c
> +++ b/hw/xenpv/xen_machine_pv.c
> @@ -94,9 +94,6 @@ static void xen_init_pv(MachineState *machine)
>=20
>      /* config cleanup hook */
>      atexit(xen_config_cleanup);
> -
> -    /* setup framebuffer */
> -    xen_init_display(xen_domid);
>  }
>=20
>  static void xenpv_machine_init(MachineClass *mc)
> diff --git a/include/hw/xen/xen_backend.h
> b/include/hw/xen/xen_backend.h
> index 852c2ea..8a6fbcb 100644
> --- a/include/hw/xen/xen_backend.h
> +++ b/include/hw/xen/xen_backend.h
> @@ -55,8 +55,6 @@ extern struct XenDevOps xen_netdev_ops;       /*
> xen_nic.c         */
>  extern struct XenDevOps xen_usb_ops;          /* xen-usb.c         */
>  #endif
>=20
> -void xen_init_display(int domid);
> -
>  /* configuration (aka xenbus setup) */
>  void xen_config_cleanup(void);
>  int xen_config_dev_blk(DriveInfo *disk);
