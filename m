Received: from eggs.gnu.org ([2001:4830:134:3::10]:57355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZ2o-0005m5-8O
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZ2n-0006nO-0X
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:24:58 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 15:24:49 +0000
Message-ID: <3a7d2ac2743c4206ae3588e2527121f0@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-6-paul.durrant@citrix.com>
	<20181203144231.GK14786@perard.uk.xensource.com>
In-Reply-To: <20181203144231.GK14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 05/18] xen: add xenstore watcher
 infratructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 03 December 2018 14:43
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 05/18] xen: add xenstore watcher infratructure
>=20
> On Wed, Nov 21, 2018 at 03:11:58PM +0000, Paul Durrant wrote:
> > A Xen PV frontend communicates its state to the PV backend by writing t=
o
> > the 'state' key in the frontend area in xenstore. It is therefore
> > necessary for a XenDevice implementation to be notified whenever the
> > value of this key changes.
> >
> > This patch adds code to do this as follows:
> >
> > - an 'fd handler' is registered on the libxenstore handle which will be
> >   triggered whenever a 'watch' event occurs
> > - primitives are added to xen-bus-helper to add or remove watch events
> > - a list of Notifier objects is added to XenBus to provide a mechanism
> >   to call the appropriate 'watch handler' when its associated event
> >   occurs
> >
> > The xen-qisk implementation is extended with a 'frontend_changed'
> method,
>=20
> "The xen-qdisk"

It's xen-block now :-)

>=20
> > which calls as-yet stub 'connect' and 'disconnect' functions when the
> > relevant frontend state transitions occur. A subsequent patch will
> supply
> > a full implementation for these functions.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> > index 0859643f7d..35f7b70480 100644
> > --- a/hw/block/xen-qdisk.c
> > +++ b/hw/block/xen-qdisk.c
> > +static void xen_qdisk_frontend_changed(XenDevice *xendev,
> > +                                       enum xenbus_state
> frontend_state,
> > +                                       Error **errp)
> > +{
> > +    XenQdiskDevice *qdiskdev =3D XEN_QDISK_DEVICE(xendev);
> > +    enum xenbus_state backend_state =3D
> xen_device_backend_get_state(xendev);
> > +    Error *local_err =3D NULL;
> > +
> > +    switch (frontend_state) {
> > +    case XenbusStateInitialised:
> > +    case XenbusStateConnected:
> > +        if (backend_state =3D=3D XenbusStateConnected) {
> > +            break;
> > +        }
> > +
> > +        xen_qdisk_disconnect(qdiskdev, &error_fatal);
>=20
> Do we want to crash (actually exit) QEMU when disconnect failed?
>=20

Ok, I'll propagate.

> > +        xen_qdisk_connect(qdiskdev, &local_err);
> > +        if (local_err) {
> > +            error_propagate(errp, local_err);
> > +            break;
> > +        }
> > +
> > +        xen_device_backend_set_state(xendev, XenbusStateConnected);
> > +        break;
> > +
> > +    case XenbusStateClosing:
> > +        xen_device_backend_set_state(xendev, XenbusStateClosing);
> > +        break;
> > +
> > +    case XenbusStateClosed:
> > +        xen_qdisk_disconnect(qdiskdev, &error_fatal);
> > +        xen_device_backend_set_state(xendev, XenbusStateClosed);
> > +        break;
> > +
> > +    default:
> > +        break;
> > +    }
> > +}
> > +
> > diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> > index d9ee2ed6a0..b44acc8047 100644
> > --- a/hw/xen/xen-bus-helper.c
> > +++ b/hw/xen/xen-bus-helper.c
> > @@ -122,3 +122,31 @@ int xs_node_scanf(struct xs_handle *xsh, const cha=
r
> *node, const char *key,
> >
> >      return rc;
> >  }
> > +
> > +void xs_node_watch(struct xs_handle *xsh, const char *node, const char
> *key,
> > +                   char *token, Error **errp)
> > +{
> > +    char *path;
> > +
> > +    path =3D (strlen(node) !=3D 0) ? g_strdup_printf("%s/%s", node, ke=
y) :
> > +        g_strdup(key);
> > +
> > +    if (!xs_watch(xsh, path, token)) {
> > +        error_setg_errno(errp, errno, "failed to watch path '%s'",
> path);
> > +    }
> > +
> > +    g_free(path);
> > +}
> > +
> > +void xs_node_unwatch(struct xs_handle *xsh, const char *node,
> > +                     const char *key, const char *token)
> > +{
> > +    char *path;
> > +
> > +    path =3D (strlen(node) !=3D 0) ? g_strdup_printf("%s/%s", node, ke=
y) :
> > +        g_strdup(key);
> > +
> > +    xs_unwatch(xsh, path, token);
>=20
> I think we should check for error from xs_unwatch as well.

Yes.

>=20
> > +
> > +    g_free(path);
> > +}
> > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > index 663aa8e117..99988f8568 100644
> > --- a/hw/xen/xen-bus.c
> > +++ b/hw/xen/xen-bus.c
> > +static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
> > +                                   const char *key, XenWatchHandler
> handler,
> > +                                   void *opaque, Error **errp)
> > +{
> > +    XenWatch *watch =3D g_new0(XenWatch, 1);
> > +    QemuUUID uuid;
> > +    Error *local_err =3D NULL;
> > +
> > +    qemu_uuid_generate(&uuid);
> > +    watch->token =3D qemu_uuid_unparse_strdup(&uuid);
> > +
> > +    trace_xen_bus_add_watch(node, key, watch->token);
> > +
> > +    watch->node =3D g_strdup(node);
> > +    watch->key =3D g_strdup(key);
> > +    watch->handler =3D handler;
> > +    watch->opaque =3D opaque;
> > +    watch->notifier.notify =3D watch_notify;
> > +
> > +    notifier_list_add(&xenbus->watch_notifiers, &watch->notifier);
> > +
> > +    xs_node_watch(xenbus->xsh, node, key, watch->token, &local_err);
> > +
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +
> > +        notifier_remove(&watch->notifier);
> > +
> > +        g_free(watch->token);
> > +        g_free(watch->key);
> > +        g_free(watch->node);
> > +
> > +        g_free(watch);
>=20
> It would be better to have a function that will free/dispose of a
> XenWatch, or maybe simply calling xen_bus_remove_watch here might be
> enough.

True. Too much cut'n'paste.

>=20
> > +        watch =3D NULL;
>=20
> You could return NULL instead.
>=20
> > +    }
> > +
> > +    return watch;
> > +}
> > +
> > +static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch)
> > +{
> > +    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
> > +
> > +    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch-
> >token);
> > +
> > +    notifier_remove(&watch->notifier);
> > +
> > +    g_free(watch->token);
> > +    g_free(watch->key);
> > +    g_free(watch->node);
> > +
> > +    g_free(watch);
> > +}
>=20
> > +static void xen_bus_watch(void *opaque)
> > +{
> > +    XenBus *xenbus =3D opaque;
> > +    char **v;
> > +    const char *token;
> > +    unsigned int n;
> > +
> > +    g_assert(xenbus->xsh);
> > +
> > +    v =3D xs_read_watch(xenbus->xsh, &n);
>=20
> What is the n for?
> Also, maybe you wanted to call xs_check_watch instead? (In a loop, until
> EGAIN)

I don't need the loop. The 'n' is the length of the vector but xs_check_wat=
ch() does what I need.

>=20
> > +    if (!v) {
> > +        return;
> > +    }
> > +
> > +    token =3D v[XS_WATCH_TOKEN];
> > +
> > +    trace_xen_bus_watch(token);
> > +
> > +    notifier_list_notify(&xenbus->watch_notifiers, (void *)token);
> > +
> > +    free(v);
> > +}
> > +
> >  static void xen_bus_realize(BusState *bus, Error **errp)
> >  {
> >      XenBus *xenbus =3D XEN_BUS(bus);
> > @@ -230,12 +419,24 @@ static void xen_device_frontend_create(XenDevice
> *xendev, Error **errp)
> >          error_propagate(errp, local_err);
> >          error_prepend(errp, "failed to create frontend: ");
> >      }
> > +
> > +    xendev->frontend_state_watch =3D
> > +        xen_bus_add_watch(xenbus, xendev->frontend_path, "state",
> > +                          xen_device_frontend_changed, xendev,
> &local_err);
>=20
> You can't reuse local_err here, *local_err must be null (It isn't
> exactly written like this, but that what I understand from reading
> qapi/error.h).

Oh, the code should have bailed on the first error.

  Paul

>=20
> Maybe you meant to return when the previous function failed (call of
> xs_node_create)?
>=20
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "failed to watch frontend state: ");
> > +    }
> >  }
>=20
> Thanks,
>=20
> --
> Anthony PERARD
