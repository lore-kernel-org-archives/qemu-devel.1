Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUWX8-0003q2-Kh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUWX7-0006pU-Fr
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:44:06 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 12:43:57 +0000
Message-ID: <d5bf17f689a34e69b9e3b7b92bcfe4fd@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-5-paul.durrant@citrix.com>
	<20181129184841.GJ14786@perard.uk.xensource.com>
	<589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
In-Reply-To: <589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 04/18] xen: create xenstore areas for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+paul.durrant=3Dcitrix.com@nongnu.org] On Behalf Of Paul Durrant
> Sent: 05 December 2018 12:05
> To: Anthony Perard <anthony.perard@citrix.com>
> Cc: Kevin Wolf <kwolf@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-devel@nongnu.org;
> Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org
> Subject: Re: [Qemu-devel] [PATCH 04/18] xen: create xenstore areas for
> XenDevice-s
>=20
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 29 November 2018 18:49
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> > devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>=
;
> > Kevin Wolf <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> > Subject: Re: [PATCH 04/18] xen: create xenstore areas for XenDevice-s
> >
> > On Wed, Nov 21, 2018 at 03:11:57PM +0000, Paul Durrant wrote:
> > > This patch adds a new source module, xen-bus-helper.c, which builds o=
n
> > > basic libxenstore primitives to provide functions to create (setting
> > > permissions appropriately) and destroy xenstore areas, and functions
> to
> > > 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
> > > these primitives [1] to initialize and destroy the frontend and
> backend
> > > areas for a XenDevice during realize and unrealize respectively.
> > >
> > > The 'xen-qdisk' implementation is extended with a 'get_name' method
> that
> > > returns the VBD number. This number is reqired to 'name' the xenstore
> >
> >                                          ^ required
> >
>=20
> Ok.
>=20
> > > diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> > > new file mode 100644
> > > index 0000000000..d9ee2ed6a0
> > > --- /dev/null
> > > +++ b/hw/xen/xen-bus-helper.c
> > [...]
> > > +void xs_node_destroy(struct xs_handle *xsh, const char *node)
> > > +{
> > > +    xs_rm(xsh, XBT_NULL, node);
> >
> > We should check for error, and grab errno.
> >
>=20
> I'll make all of them fill in an Error *
>=20
> > > +}
> > > +
> > > +void xs_node_vprintf(struct xs_handle *xsh, const char *node,
> > > +                     const char *key, const char *fmt, va_list ap)
> > > +{
> > > +    char *path, *value;
> > > +
> > > +    path =3D (strlen(node) !=3D 0) ? g_strdup_printf("%s/%s", node, =
key)
> :
> > > +        g_strdup(key);
> >
> > A comment would be helpful to findout how to use that function,
> > especialy the fact that with node=3D"", we write to $key instead of
> > $node/$key.
>=20
> Ok, I'll add comments into the header.
>=20
> >
> > > +    value =3D g_strdup_vprintf(fmt, ap);
> >
> > Looks like g_vasprintf() would be better, since it returns the lenght a=
s
> > well.
> >
>=20
> Yes.

I tried this and it appears not to exist in the version of glib in my envir=
onment so I guess I'll stick with g_strdup_printf().

  Paul

>=20
> > > +
> > > +    xs_write(xsh, XBT_NULL, path, value, strlen(value));
> >
> > You should check for failures, and grab errno.
> >
> > > +    g_free(value);
> > > +    g_free(path);
> > > +}
> > > +
> > > +int xs_node_vscanf(struct xs_handle *xsh, const char *node, const
> char
> > *key,
> > > +                   const char *fmt, va_list ap)
> > > +{
> > > +    char *path, *value;
> > > +    int rc;
> > > +
> > > +    path =3D (strlen(node) !=3D 0) ? g_strdup_printf("%s/%s", node, =
key)
> :
> > > +        g_strdup(key);
> > > +
> > > +    value =3D xs_read(xsh, XBT_NULL, path, NULL);
> >
> > The xenstore.h isn't clear about failure of this function, it is
> > supposed to return a malloced value. Do we actually need to check if
> value
> > is NULL?
>=20
> The comment above xs_read() in xs.c is:
>=20
> /* Get the value of a single file, nul terminated.
>  * Returns a malloced value: call free() on it after use.
>  * len indicates length in bytes, not including the nul.
>  */
>=20
> and I think we should check it for NULL before passing it to vsscanf().
>=20
> >
> > > +
> > > +    rc =3D value ? vsscanf(value, fmt, ap) : EOF;
> > > +
> > > +    free(value);
> > > +    g_free(path);
> > > +
> > > +    return rc;
> > > +}
> > > +
> > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > index dede2d914a..663aa8e117 100644
> > > --- a/hw/xen/xen-bus.c
> > > +++ b/hw/xen/xen-bus.c
> > [...]
> >
> > > +static void xen_device_backend_destroy(XenDevice *xendev)
> > > +{
> > > +    XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> > > +
> > > +    if (!xendev->backend_path) {
> > > +        return;
> > > +    }
> > > +
> > > +    g_assert(xenbus->xsh);
> > > +
> > > +    xs_node_destroy(xenbus->xsh, xendev->backend_path);
> > > +    g_free(xendev->backend_path);
> >
> > It would be nice to also set backend_path to NULL.
> >
>=20
> Yes, it should be for idempotency.
>=20
> > > diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus=
-
> > helper.h
> > > new file mode 100644
> > > index 0000000000..53570650db
> > > --- /dev/null
> > > +++ b/include/hw/xen/xen-bus-helper.h
> > > @@ -0,0 +1,26 @@
> > > +/*
> > > + * Copyright (c) Citrix Systems Inc.
> > > + * All rights reserved.
> > > + */
> > > +
> > > +#ifndef HW_XEN_BUS_HELPER_H
> > > +#define HW_XEN_BUS_HELPER_H
> >
> > That should probably include xen_common.h, to have `enum xenbus_state`,
> > `struct xs_handle`, ..
>=20
> Ok.
>=20
> >
> > > +const char *xs_strstate(enum xenbus_state state);
> > > +
> > > +void xs_node_create(struct xs_handle *xsh, const char *node,
> > > +                    struct xs_permissions perms[],
> > > +                    unsigned int nr_perms, Error **errp);
> > > +void xs_node_destroy(struct xs_handle *xsh, const char *node);
> > > +
> > > +void xs_node_vprintf(struct xs_handle *xsh, const char *node,
> > > +                     const char *key, const char *fmt, va_list ap);
> > > +void xs_node_printf(struct xs_handle *xsh, const char *node, const
> char
> > *key,
> > > +                    const char *fmt, ...);
> >
> > This prototype needs GCC_FMT_ATTR(), that's the printf format
> > __attribute__.
> >
> > > +
> > > +int xs_node_vscanf(struct xs_handle *xsh, const char *node, const
> char
> > *key,
> > > +                   const char *fmt, va_list ap);
> > > +int xs_node_scanf(struct xs_handle *xsh, const char *node, const cha=
r
> > *key,
> > > +                  const char *fmt, ...);
> >
> > Maybe here as well.
>=20
> Will do.
>=20
>  Paul
>=20
> >
> >
> > --
> > Anthony PERARD
