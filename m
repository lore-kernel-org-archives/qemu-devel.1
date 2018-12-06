Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUstv-0000xs-5P
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUstr-0002Z0-0s
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:37:07 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 6 Dec 2018 12:36:52 +0000
Message-ID: <66fe7ee71e9642d3bbbda0f4f900c799@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-16-paul.durrant@citrix.com>
	<20181204153510.GW14786@perard.uk.xensource.com>
In-Reply-To: <20181204153510.GW14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 15/18] xen: add a mechanism to
 automatically create XenDevice-s...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 04 December 2018 15:35
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 15/18] xen: add a mechanism to automatically create
> XenDevice-s...
>=20
> On Wed, Nov 21, 2018 at 03:12:08PM +0000, Paul Durrant wrote:
> > +    xen_backend_device_create(BUS(xenbus), type, name, opts,
> &local_err);
> > +    qobject_unref(opts);
> > +
> > +    if (local_err) {
> > +        const char *msg =3D error_get_pretty(local_err);
> > +
> > +        error_report("failed to create '%s' device '%s': %s", type,
> name,
> > +                     msg);
> > +        error_free(local_err);
>=20
> You can use error_reportf_err() instead of those three calls. I may have
> only suggest error_report_err in a previous patch, but error_reportf_err
> does the error_prepend as well.
>=20

Ah. I'll go back over the patches and use that where necessary.

> > +    }
> > +}
> > +
> > +static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
> > +{
> > +    char *domain_path =3D g_strdup_printf("backend/%s/%u", type,
> xen_domid);
> > +    char **backend;
> > +    unsigned int i, n;
> > +
> > +    trace_xen_bus_type_enumerate(type);
> > +
> > +    backend =3D xs_directory(xenbus->xsh, XBT_NULL, domain_path, &n);
> > +    if (!backend) {
>=20
> domain_path isn't free here, you probably want a `goto out` which would
> free everything.

Ok.

>=20
> > +        return;
> > +    }
> > +
> > @@ -193,6 +302,17 @@ static void xen_bus_realize(BusState *bus, Error
> **errp)
> >      notifier_list_init(&xenbus->watch_notifiers);
> >      qemu_set_fd_handler(xs_fileno(xenbus->xsh), xen_bus_watch, NULL,
> >                          xenbus);
> > +
> > +    module_call_init(MODULE_INIT_XEN_BACKEND);
> > +
> > +    xenbus->backend_watch =3D
> > +        xen_bus_add_watch(xenbus, "", /* domain root node */
> > +                          "backend", xen_bus_enumerate, xenbus,
> &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "failed to set up enumeration watch: ");
>=20
> You should use error_propagate_prepend instead
> error_propagate;error_prepend. And it looks like there is the same
> mistake in other patches that I haven't notice.
>=20

Oh, I didn't know about that one either... I've only seen the separate call=
s used elsewhere.

> Also you probably want goto fail here.
>=20

Not sure about that. Whilst the bus scan won't happen, it doesn't mean devi=
ces can't be added via QMP.

>=20
> > +static void xen_device_backend_changed(void *opaque)
> > +{
> > +    XenDevice *xendev =3D opaque;
> > +    const char *type =3D object_get_typename(OBJECT(xendev));
> > +    enum xenbus_state state;
> > +    unsigned int online;
> > +
> > +    trace_xen_device_backend_changed(type, xendev->name);
> > +
> > +    if (xen_device_backend_scanf(xendev, "state", "%u", &state) !=3D 1=
) {
> > +        state =3D XenbusStateUnknown;
> > +    }
> > +
> > +    xen_device_backend_set_state(xendev, state);
>=20
> It's kind of weird to set the internal state base on the external one
> that something else may have modified. Shouldn't we check that it is
> fine for something else to modify the state and that it is a correct
> transition?

The only thing (apart from this code) that's going to have perms to write t=
he backend state is the toolstack... which is, of course, be definition tru=
sted.

>=20
> Also aren't we going in a loop by having QEMU set the state, then the
> watch fires again? (Not really a loop since the function _set_state
> check for changes.

No. It's de-bounced inside the set_state function.

>=20
> Also maybe we should watch for the state changes only when something
> else like libxl creates (ask for) the backend, and ignore changes when
> QEMU did it itself.

I don't think it's necessary to add that complexity.

>=20
> > +
> > +    if (xen_device_backend_scanf(xendev, "online", "%u", &online) !=3D=
 1)
> {
> > +        online =3D 0;
> > +    }
> > +
> > +    xen_device_backend_set_online(xendev, !!online);
> > +
> > +    /*
> > +     * If a backend is still 'online' then its state should be cycled
> > +     * back round to InitWait in order for a new frontend instance to
> > +     * connect. This may happen when, for example, a frontend driver i=
s
> > +     * re-installed or updated.
> > +     * If a backend id not 'online' then the device should be
> destroyed.
>=20
> s/id/is/

Ok.

>=20
> > +     */
> > +    if (xendev->backend_online &&
> > +        xendev->backend_state =3D=3D XenbusStateClosed) {
> > +        xen_device_backend_set_state(xendev, XenbusStateInitWait);
> > +    } else if (!xendev->backend_online &&
> > +               (xendev->backend_state =3D=3D XenbusStateClosed ||
> > +                xendev->backend_state =3D=3D XenbusStateInitialising |=
|
> > +                xendev->backend_state =3D=3D XenbusStateInitWait ||
> > +                xendev->backend_state =3D=3D XenbusStateUnknown)) {
> > +        object_unparent(OBJECT(xendev));
> > +    }
> > +}
> > +
> >  static void xen_device_backend_create(XenDevice *xendev, Error **errp)
> >  {
> >      XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> > @@ -289,12 +463,38 @@ static void xen_device_backend_create(XenDevice
> *xendev, Error **errp)
> >          error_propagate(errp, local_err);
> >          error_prepend(errp, "failed to create backend: ");
>=20
> It looks like there is a missing return here.
>=20
> >      }
> > +
> > +    xendev->backend_state_watch =3D
> > +        xen_bus_add_watch(xenbus, xendev->backend_path,
> > +                          "state", xen_device_backend_changed,
> > +                          xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "failed to watch backend state: ");
>=20
> You should return here, as local_err mustn't be reused.
>=20
> > +    }
> > +
> > +    xendev->backend_online_watch =3D
> > +        xen_bus_add_watch(xenbus, xendev->backend_path,
> > +                          "online", xen_device_backend_changed,
> > +                          xendev, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        error_prepend(errp, "failed to watch backend online: ");
>=20
> You probably want a return here, in case there is more code added after.

Yes, there should be returns in all three cases above.

>=20
> > +    }
>=20
> Other instances of error_propagate;error_prepend to be replaced by
> error_propagate_prepend.

Yes, will do.

  Paul

>=20
> >  }
> >
>=20
> Thanks,
>=20
> --
> Anthony PERARD
