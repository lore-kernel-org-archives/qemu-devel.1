Received: from eggs.gnu.org ([2001:4830:134:3::10]:37023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVIVs-0002Fo-Cv
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVIVn-0001bY-CX
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 10:58:00 -0500
Date: Fri, 7 Dec 2018 15:57:45 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207155745.GI18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-6-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/18] xen: add xenstore watcher
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Thu, Dec 06, 2018 at 03:08:31PM +0000, Paul Durrant wrote:
> @@ -36,6 +54,12 @@ static void xen_block_unrealize(XenDevice *xendev, Error **errp)
>  
>      trace_xen_block_unrealize(type, vdev->disk, vdev->partition);
>  
> +    /* Disconnect from the frontend in case this has not already happened */
> +    xen_block_disconnect(xendev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);

If xen_block_disconnect fails, local_err is going to be reuse below. If
it's fine to try unrealize, then `local_err=NULL` is probably enough.

> +    }
> +
>      if (blockdev_class->unrealize) {
>          blockdev_class->unrealize(blockdev, &local_err);
>          if (local_err) {

[...]

> +static void xen_bus_remove_watch(XenBus *xenbus, XenWatch *watch,
> +                                 Error **errp)
> +{
> +    Error *local_err = NULL;
> +
> +    trace_xen_bus_remove_watch(watch->node, watch->key, watch->token);
> +
> +    xs_node_unwatch(xenbus->xsh, watch->node, watch->key, watch->token,
> +                    &local_err);

You could simply pass `errp' directly instead of having `local_err'.

> +
> +    notifier_remove(&watch->notifier);
> +    free_watch(watch);
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +}
> +

-- 
Anthony PERARD
