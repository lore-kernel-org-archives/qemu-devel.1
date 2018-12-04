Received: from eggs.gnu.org ([2001:4830:134:3::10]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUCjM-0007cL-Ji
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gUCjG-0001r5-Nr
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:35:24 -0500
Date: Tue, 4 Dec 2018 15:35:10 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204153510.GW14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-16-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-16-paul.durrant@citrix.com>
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
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:12:08PM +0000, Paul Durrant wrote:
> +    xen_backend_device_create(BUS(xenbus), type, name, opts, &local_err);
> +    qobject_unref(opts);
> +
> +    if (local_err) {
> +        const char *msg = error_get_pretty(local_err);
> +
> +        error_report("failed to create '%s' device '%s': %s", type, name,
> +                     msg);
> +        error_free(local_err);

You can use error_reportf_err() instead of those three calls. I may have
only suggest error_report_err in a previous patch, but error_reportf_err
does the error_prepend as well.

> +    }
> +}
> +
> +static void xen_bus_type_enumerate(XenBus *xenbus, const char *type)
> +{
> +    char *domain_path = g_strdup_printf("backend/%s/%u", type, xen_domid);
> +    char **backend;
> +    unsigned int i, n;
> +
> +    trace_xen_bus_type_enumerate(type);
> +
> +    backend = xs_directory(xenbus->xsh, XBT_NULL, domain_path, &n);
> +    if (!backend) {

domain_path isn't free here, you probably want a `goto out` which would
free everything.

> +        return;
> +    }
> +
> @@ -193,6 +302,17 @@ static void xen_bus_realize(BusState *bus, Error **errp)
>      notifier_list_init(&xenbus->watch_notifiers);
>      qemu_set_fd_handler(xs_fileno(xenbus->xsh), xen_bus_watch, NULL,
>                          xenbus);
> +
> +    module_call_init(MODULE_INIT_XEN_BACKEND);
> +
> +    xenbus->backend_watch =
> +        xen_bus_add_watch(xenbus, "", /* domain root node */
> +                          "backend", xen_bus_enumerate, xenbus, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "failed to set up enumeration watch: ");

You should use error_propagate_prepend instead
error_propagate;error_prepend. And it looks like there is the same
mistake in other patches that I haven't notice.

Also you probably want goto fail here.


> +static void xen_device_backend_changed(void *opaque)
> +{
> +    XenDevice *xendev = opaque;
> +    const char *type = object_get_typename(OBJECT(xendev));
> +    enum xenbus_state state;
> +    unsigned int online;
> +
> +    trace_xen_device_backend_changed(type, xendev->name);
> +
> +    if (xen_device_backend_scanf(xendev, "state", "%u", &state) != 1) {
> +        state = XenbusStateUnknown;
> +    }
> +
> +    xen_device_backend_set_state(xendev, state);

It's kind of weird to set the internal state base on the external one
that something else may have modified. Shouldn't we check that it is
fine for something else to modify the state and that it is a correct
transition?

Also aren't we going in a loop by having QEMU set the state, then the
watch fires again? (Not really a loop since the function _set_state
check for changes.

Also maybe we should watch for the state changes only when something
else like libxl creates (ask for) the backend, and ignore changes when
QEMU did it itself.

> +
> +    if (xen_device_backend_scanf(xendev, "online", "%u", &online) != 1) {
> +        online = 0;
> +    }
> +
> +    xen_device_backend_set_online(xendev, !!online);
> +
> +    /*
> +     * If a backend is still 'online' then its state should be cycled
> +     * back round to InitWait in order for a new frontend instance to
> +     * connect. This may happen when, for example, a frontend driver is
> +     * re-installed or updated.
> +     * If a backend id not 'online' then the device should be destroyed.

s/id/is/

> +     */
> +    if (xendev->backend_online &&
> +        xendev->backend_state == XenbusStateClosed) {
> +        xen_device_backend_set_state(xendev, XenbusStateInitWait);
> +    } else if (!xendev->backend_online &&
> +               (xendev->backend_state == XenbusStateClosed ||
> +                xendev->backend_state == XenbusStateInitialising ||
> +                xendev->backend_state == XenbusStateInitWait ||
> +                xendev->backend_state == XenbusStateUnknown)) {
> +        object_unparent(OBJECT(xendev));
> +    }
> +}
> +
>  static void xen_device_backend_create(XenDevice *xendev, Error **errp)
>  {
>      XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> @@ -289,12 +463,38 @@ static void xen_device_backend_create(XenDevice *xendev, Error **errp)
>          error_propagate(errp, local_err);
>          error_prepend(errp, "failed to create backend: ");

It looks like there is a missing return here.

>      }
> +
> +    xendev->backend_state_watch =
> +        xen_bus_add_watch(xenbus, xendev->backend_path,
> +                          "state", xen_device_backend_changed,
> +                          xendev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "failed to watch backend state: ");

You should return here, as local_err mustn't be reused.

> +    }
> +
> +    xendev->backend_online_watch =
> +        xen_bus_add_watch(xenbus, xendev->backend_path,
> +                          "online", xen_device_backend_changed,
> +                          xendev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "failed to watch backend online: ");

You probably want a return here, in case there is more code added after.

> +    }

Other instances of error_propagate;error_prepend to be replaced by
error_propagate_prepend.

>  }
>  

Thanks,

-- 
Anthony PERARD
