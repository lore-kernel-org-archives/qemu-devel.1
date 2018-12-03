Received: from eggs.gnu.org ([2001:4830:134:3::10]:34832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTpQq-0004RA-Eh
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTpQo-0002L5-MR
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:42:44 -0500
Date: Mon, 3 Dec 2018 14:42:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203144231.GK14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-6-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-6-paul.durrant@citrix.com>
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
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:11:58PM +0000, Paul Durrant wrote:
> A Xen PV frontend communicates its state to the PV backend by writing to
> the 'state' key in the frontend area in xenstore. It is therefore
> necessary for a XenDevice implementation to be notified whenever the
> value of this key changes.
> 
> This patch adds code to do this as follows:
> 
> - an 'fd handler' is registered on the libxenstore handle which will be
>   triggered whenever a 'watch' event occurs
> - primitives are added to xen-bus-helper to add or remove watch events
> - a list of Notifier objects is added to XenBus to provide a mechanism
>   to call the appropriate 'watch handler' when its associated event
>   occurs
> 
> The xen-qisk implementation is extended with a 'frontend_changed' method,

"The xen-qdisk"

> which calls as-yet stub 'connect' and 'disconnect' functions when the
> relevant frontend state transitions occur. A subsequent patch will supply
> a full implementation for these functions.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/block/xen-qdisk.c b/hw/block/xen-qdisk.c
> index 0859643f7d..35f7b70480 100644
> --- a/hw/block/xen-qdisk.c
> +++ b/hw/block/xen-qdisk.c
> +static void xen_qdisk_frontend_changed(XenDevice *xendev,
> +                                       enum xenbus_state frontend_state,
> +                                       Error **errp)
> +{
> +    XenQdiskDevice *qdiskdev = XEN_QDISK_DEVICE(xendev);
> +    enum xenbus_state backend_state = xen_device_backend_get_state(xendev);
> +    Error *local_err = NULL;
> +
> +    switch (frontend_state) {
> +    case XenbusStateInitialised:
> +    case XenbusStateConnected:
> +        if (backend_state == XenbusStateConnected) {
> +            break;
> +        }
> +
> +        xen_qdisk_disconnect(qdiskdev, &error_fatal);

Do we want to crash (actually exit) QEMU when disconnect failed?

> +        xen_qdisk_connect(qdiskdev, &local_err);
> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +            break;
> +        }
> +
> +        xen_device_backend_set_state(xendev, XenbusStateConnected);
> +        break;
> +
> +    case XenbusStateClosing:
> +        xen_device_backend_set_state(xendev, XenbusStateClosing);
> +        break;
> +
> +    case XenbusStateClosed:
> +        xen_qdisk_disconnect(qdiskdev, &error_fatal);
> +        xen_device_backend_set_state(xendev, XenbusStateClosed);
> +        break;
> +
> +    default:
> +        break;
> +    }
> +}
> +
> diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> index d9ee2ed6a0..b44acc8047 100644
> --- a/hw/xen/xen-bus-helper.c
> +++ b/hw/xen/xen-bus-helper.c
> @@ -122,3 +122,31 @@ int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
>  
>      return rc;
>  }
> +
> +void xs_node_watch(struct xs_handle *xsh, const char *node, const char *key,
> +                   char *token, Error **errp)
> +{
> +    char *path;
> +
> +    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
> +        g_strdup(key);
> +
> +    if (!xs_watch(xsh, path, token)) {
> +        error_setg_errno(errp, errno, "failed to watch path '%s'", path);
> +    }
> +
> +    g_free(path);
> +}
> +
> +void xs_node_unwatch(struct xs_handle *xsh, const char *node,
> +                     const char *key, const char *token)
> +{
> +    char *path;
> +
> +    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
> +        g_strdup(key);
> +
> +    xs_unwatch(xsh, path, token);

I think we should check for error from xs_unwatch as well.

> +
> +    g_free(path);
> +}
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index 663aa8e117..99988f8568 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> +static XenWatch *xen_bus_add_watch(XenBus *xenbus, const char *node,
> +                                   const char *key, XenWatchHandler handler,
> +                                   void *opaque, Error **errp)
> +{
> +    XenWatch *watch = g_new0(XenWatch, 1);
> +    QemuUUID uuid;
> +    Error *local_err = NULL;
> +
> +    qemu_uuid_generate(&uuid);
> +    watch->token = qemu_uuid_unparse_strdup(&uuid);
> +
> +    trace_xen_bus_add_watch(node, key, watch->token);
> +
> +    watch->node = g_strdup(node);
> +    watch->key = g_strdup(key);
> +    watch->handler = handler;
> +    watch->opaque = opaque;
> +    watch->notifier.notify = watch_notify;
> +
> +    notifier_list_add(&xenbus->watch_notifiers, &watch->notifier);
> +
> +    xs_node_watch(xenbus->xsh, node, key, watch->token, &local_err);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +
> +        notifier_remove(&watch->notifier);
> +
> +        g_free(watch->token);
> +        g_free(watch->key);
> +        g_free(watch->node);
> +
> +        g_free(watch);

It would be better to have a function that will free/dispose of a
XenWatch, or maybe simply calling xen_bus_remove_watch here might be
enough.

> +        watch = NULL;

You could return NULL instead.

> +    }
> +
> +    return watch;
> +}
> +
> +static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch)
> +{
> +    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
> +
> +    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch->token);
> +
> +    notifier_remove(&watch->notifier);
> +
> +    g_free(watch->token);
> +    g_free(watch->key);
> +    g_free(watch->node);
> +
> +    g_free(watch);
> +}

> +static void xen_bus_watch(void *opaque)
> +{
> +    XenBus *xenbus = opaque;
> +    char **v;
> +    const char *token;
> +    unsigned int n;
> +
> +    g_assert(xenbus->xsh);
> +
> +    v = xs_read_watch(xenbus->xsh, &n);

What is the n for?
Also, maybe you wanted to call xs_check_watch instead? (In a loop, until
EGAIN)

> +    if (!v) {
> +        return;
> +    }
> +
> +    token = v[XS_WATCH_TOKEN];
> +
> +    trace_xen_bus_watch(token);
> +
> +    notifier_list_notify(&xenbus->watch_notifiers, (void *)token);
> +
> +    free(v);
> +}
> +
>  static void xen_bus_realize(BusState *bus, Error **errp)
>  {
>      XenBus *xenbus = XEN_BUS(bus);
> @@ -230,12 +419,24 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
>          error_propagate(errp, local_err);
>          error_prepend(errp, "failed to create frontend: ");
>      }
> +
> +    xendev->frontend_state_watch =
> +        xen_bus_add_watch(xenbus, xendev->frontend_path, "state",
> +                          xen_device_frontend_changed, xendev, &local_err);

You can't reuse local_err here, *local_err must be null (It isn't
exactly written like this, but that what I understand from reading
qapi/error.h).

Maybe you meant to return when the previous function failed (call of
xs_node_create)?

> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "failed to watch frontend state: ");
> +    }
>  }

Thanks,

-- 
Anthony PERARD
