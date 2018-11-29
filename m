Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSRNK-0006Nb-Cy
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:49:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86438351b=anthony.perard@citrix.com>)
	id 1gSRNJ-0000SM-EQ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:49:22 -0500
Date: Thu, 29 Nov 2018 18:48:41 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181129184841.GJ14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-5-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-5-paul.durrant@citrix.com>
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
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:11:57PM +0000, Paul Durrant wrote:
> This patch adds a new source module, xen-bus-helper.c, which builds on
> basic libxenstore primitives to provide functions to create (setting
> permissions appropriately) and destroy xenstore areas, and functions to
> 'printf' and 'scanf' nodes therein. The main xen-bus code then uses
> these primitives [1] to initialize and destroy the frontend and backend
> areas for a XenDevice during realize and unrealize respectively.
> 
> The 'xen-qdisk' implementation is extended with a 'get_name' method that
> returns the VBD number. This number is reqired to 'name' the xenstore

                                         ^ required

> diff --git a/hw/xen/xen-bus-helper.c b/hw/xen/xen-bus-helper.c
> new file mode 100644
> index 0000000000..d9ee2ed6a0
> --- /dev/null
> +++ b/hw/xen/xen-bus-helper.c
[...]
> +void xs_node_destroy(struct xs_handle *xsh, const char *node)
> +{
> +    xs_rm(xsh, XBT_NULL, node);

We should check for error, and grab errno.

> +}
> +
> +void xs_node_vprintf(struct xs_handle *xsh, const char *node,
> +                     const char *key, const char *fmt, va_list ap)
> +{
> +    char *path, *value;
> +
> +    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
> +        g_strdup(key);

A comment would be helpful to findout how to use that function,
especialy the fact that with node="", we write to $key instead of
$node/$key.

> +    value = g_strdup_vprintf(fmt, ap);

Looks like g_vasprintf() would be better, since it returns the lenght as
well.

> +
> +    xs_write(xsh, XBT_NULL, path, value, strlen(value));

You should check for failures, and grab errno.

> +    g_free(value);
> +    g_free(path);
> +}
> +
> +int xs_node_vscanf(struct xs_handle *xsh, const char *node, const char *key,
> +                   const char *fmt, va_list ap)
> +{
> +    char *path, *value;
> +    int rc;
> +
> +    path = (strlen(node) != 0) ? g_strdup_printf("%s/%s", node, key) :
> +        g_strdup(key);
> +
> +    value = xs_read(xsh, XBT_NULL, path, NULL);

The xenstore.h isn't clear about failure of this function, it is
supposed to return a malloced value. Do we actually need to check if value
is NULL?

> +
> +    rc = value ? vsscanf(value, fmt, ap) : EOF;
> +
> +    free(value);
> +    g_free(path);
> +
> +    return rc;
> +}
> +
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index dede2d914a..663aa8e117 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
[...]

> +static void xen_device_backend_destroy(XenDevice *xendev)
> +{
> +    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> +
> +    if (!xendev->backend_path) {
> +        return;
> +    }
> +
> +    g_assert(xenbus->xsh);
> +
> +    xs_node_destroy(xenbus->xsh, xendev->backend_path);
> +    g_free(xendev->backend_path);

It would be nice to also set backend_path to NULL.

> diff --git a/include/hw/xen/xen-bus-helper.h b/include/hw/xen/xen-bus-helper.h
> new file mode 100644
> index 0000000000..53570650db
> --- /dev/null
> +++ b/include/hw/xen/xen-bus-helper.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.
> + */
> +
> +#ifndef HW_XEN_BUS_HELPER_H
> +#define HW_XEN_BUS_HELPER_H

That should probably include xen_common.h, to have `enum xenbus_state`,
`struct xs_handle`, ..

> +const char *xs_strstate(enum xenbus_state state);
> +
> +void xs_node_create(struct xs_handle *xsh, const char *node,
> +                    struct xs_permissions perms[],
> +                    unsigned int nr_perms, Error **errp);
> +void xs_node_destroy(struct xs_handle *xsh, const char *node);
> +
> +void xs_node_vprintf(struct xs_handle *xsh, const char *node,
> +                     const char *key, const char *fmt, va_list ap);
> +void xs_node_printf(struct xs_handle *xsh, const char *node, const char *key,
> +                    const char *fmt, ...);

This prototype needs GCC_FMT_ATTR(), that's the printf format
__attribute__.

> +
> +int xs_node_vscanf(struct xs_handle *xsh, const char *node, const char *key,
> +                   const char *fmt, va_list ap);
> +int xs_node_scanf(struct xs_handle *xsh, const char *node, const char *key,
> +                  const char *fmt, ...);

Maybe here as well.


-- 
Anthony PERARD
