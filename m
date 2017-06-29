Received: from eggs.gnu.org ([2001:4830:134:3::10]:37067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQUkw-0004xY-Dx
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQUkq-0007Nr-4C
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:24:54 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:45989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=346f73eb6=Paul.Durrant@citrix.com>)
	id 1dQUkp-0007L7-MD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:24:48 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 29 Jun 2017 08:24:41 +0000
Message-ID: <7ecfe394c646482faddf97a40bda944d@AMSPEX02CL03.citrite.net>
References: <alpine.DEB.2.10.1706281125330.2919@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1706281125330.2919@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] xenfb: remove xen_init_display
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, "kraxel@redhat.com" <kraxel@redhat.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 28 June 2017 19:37
> To: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
> Cc: sstabellini@kernel.org; peter.maydell@linaro.org; Anthony Perard
> <anthony.perard@citrix.com>; kraxel@redhat.com; Paul Durrant
> <Paul.Durrant@citrix.com>
> Subject: [PATCH v2] xenfb: remove xen_init_display "temporary" hack
>=20
> Initialize xenfb properly, as all other backends, from its own
> "initialise" function.
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> ---
> Changes in v2:
> - remove xen_init_display from xen_backend.h
> - handle cases where vkbd is missing
>=20
> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> index e76c0d8..3b0168b 100644
> --- a/hw/display/xenfb.c
> +++ b/hw/display/xenfb.c
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
> @@ -855,6 +855,8 @@ static int fb_init(struct XenDevice *xendev)
>  static int fb_initialise(struct XenDevice *xendev)
>  {
>      struct XenFB *fb =3D container_of(xendev, struct XenFB, c.xendev);
> +    struct XenDevice *xin;
> +    struct XenInput *in;

I think the scope of 'in' can be limited to the 'else' clause where it is u=
sed below.

>      struct xenfb_page *fb_page;
>      int videoram;
>      int rc;
> @@ -877,16 +879,16 @@ static int fb_initialise(struct XenDevice *xendev)
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
> +    fb->c.con =3D graphic_console_init(NULL, 0, &xenfb_ops, fb);
> +
> +    xin =3D xen_pv_find_xendev("vkbd", xen_domid, 0);
> +    if (xin =3D=3D NULL) {
> +        xen_pv_printf(xendev, 1, "xenfb is up, but vkbd is not present\n=
");
> +    } else {
> +        in =3D container_of(xin, struct XenInput, c.xendev);
> +        in->c.con =3D fb->c.con;

I notice that in->c.con is tested in input_initialise() and it will fail if=
 NULL, so there is an inherent race between the frontends and also processi=
ng of xenstore watches. That seems a little fragile at best, but the depend=
ency of input_initialise() on in->c.con is also somewhat bogus as the vkbd =
backend is created for xenfv machine types whereas xenfb is only there for =
xenpv machine types. I think this needs to be fixed before xenfb can be rel=
ied on to initialize correctly in all circumstances.

  Paul

> +        xen_be_check_state(xin);
>      }
> -#endif
>=20
>      if (xenstore_read_fe_int(xendev, "feature-update", &fb-
> >feature_update) =3D=3D -1)
>  	fb->feature_update =3D 0;
> @@ -972,42 +974,3 @@ static const GraphicHwOps xenfb_ops =3D {
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
