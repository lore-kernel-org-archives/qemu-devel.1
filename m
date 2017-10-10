Received: from eggs.gnu.org ([2001:4830:134:3::10]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xIS-0008Ht-PU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xIO-0006Qy-PS
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:22:20 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:50662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1xIO-0006Qp-Fd
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:22:16 -0400
Received: by mail-wm0-f51.google.com with SMTP id u138so6727108wmu.5
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:22:16 -0700 (PDT)
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
	<20170919165226.23022-26-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d512cc6-ecbb-7cef-2b4c-36441b5ee614@redhat.com>
Date: Tue, 10 Oct 2017 18:22:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170919165226.23022-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 25/27] libvhost-user: add glib source
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: felipe@nutanix.com, changpeng.liu@intel.com, f4bug@amsat.org

On 19/09/2017 18:52, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Maybe a few lines would help here, like

This file implements a bridge from the vu_init API of libvhost-user to
GSource, so that libvhost-user can be used inside a GLib main loop.

Paolo

> ---
>  contrib/libvhost-user/libvhost-user-glib.h |  32 ++++++
>  contrib/libvhost-user/libvhost-user-glib.c | 154 +++++++++++++++++++++++++++++
>  contrib/libvhost-user/Makefile.objs        |   2 +-
>  3 files changed, 187 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/libvhost-user/libvhost-user-glib.h
>  create mode 100644 contrib/libvhost-user/libvhost-user-glib.c
> 
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
> new file mode 100644
> index 0000000000..6b2110b94c
> --- /dev/null
> +++ b/contrib/libvhost-user/libvhost-user-glib.h
> @@ -0,0 +1,32 @@
> +/*
> + * Vhost User library
> + *
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + * Copyright (c) 2017 Red Hat, Inc.
> + *
> + * Authors:
> + *  Marc-André Lureau <mlureau@redhat.com>
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef LIBVHOST_USER_GLIB_H
> +#define LIBVHOST_USER_GLIB_H
> +
> +#include <glib.h>
> +#include "libvhost-user.h"
> +
> +typedef struct VugDev {
> +    VuDev parent;
> +
> +    GHashTable *fdmap; /* fd -> gsource */
> +    GSource *src;
> +} VugDev;
> +
> +void vug_init(VugDev *dev, int socket,
> +              vu_panic_cb panic, const VuDevIface *iface);
> +void vug_deinit(VugDev *dev);
> +
> +#endif /* LIBVHOST_USER_GLIB_H */
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
> new file mode 100644
> index 0000000000..545f089587
> --- /dev/null
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -0,0 +1,154 @@
> +/*
> + * Vhost User library
> + *
> + * Copyright (c) 2016 Nutanix Inc. All rights reserved.
> + * Copyright (c) 2017 Red Hat, Inc.
> + *
> + * Authors:
> + *  Marc-André Lureau <mlureau@redhat.com>
> + *  Felipe Franciosi <felipe@nutanix.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "libvhost-user-glib.h"
> +
> +/* glib event loop integration for libvhost-user and misc callbacks */
> +
> +G_STATIC_ASSERT((int)G_IO_IN == (int)VU_WATCH_IN);
> +G_STATIC_ASSERT((int)G_IO_OUT == (int)VU_WATCH_OUT);
> +G_STATIC_ASSERT((int)G_IO_PRI == (int)VU_WATCH_PRI);
> +G_STATIC_ASSERT((int)G_IO_ERR == (int)VU_WATCH_ERR);
> +G_STATIC_ASSERT((int)G_IO_HUP == (int)VU_WATCH_HUP);
> +
> +typedef struct VugSrc {
> +    GSource parent;
> +    VuDev *dev;
> +    GPollFD gfd;
> +} VugSrc;
> +
> +static gboolean
> +vug_src_prepare(GSource *gsrc, gint *timeout)
> +{
> +    g_assert(timeout);
> +
> +    *timeout = -1;
> +    return FALSE;
> +}
> +
> +static gboolean
> +vug_src_check(GSource *gsrc)
> +{
> +    VugSrc *src = (VugSrc *)gsrc;
> +
> +    g_assert(src);
> +
> +    return src->gfd.revents & src->gfd.events;
> +}
> +
> +static gboolean
> +vug_src_dispatch(GSource *gsrc, GSourceFunc cb, gpointer data)
> +{
> +    VugSrc *src = (VugSrc *)gsrc;
> +
> +    g_assert(src);
> +
> +    ((vu_watch_cb)cb)(src->dev, src->gfd.revents, data);
> +
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static GSourceFuncs vug_src_funcs = {
> +    vug_src_prepare,
> +    vug_src_check,
> +    vug_src_dispatch,
> +    NULL
> +};
> +
> +static GSource *
> +vug_source_new(VuDev *dev, int fd, GIOCondition cond,
> +               vu_watch_cb vu_cb, gpointer data)
> +{
> +    GSource *gsrc;
> +    VugSrc *src;
> +    guint id;
> +
> +    g_assert(dev);
> +    g_assert(fd >= 0);
> +    g_assert(vu_cb);
> +
> +    gsrc = g_source_new(&vug_src_funcs, sizeof(VugSrc));
> +    g_source_set_callback(gsrc, (GSourceFunc)vu_cb, data, NULL);
> +    src = (VugSrc *)gsrc;
> +    src->dev = dev;
> +    src->gfd.fd = fd;
> +    src->gfd.events = cond;
> +
> +    g_source_add_poll(gsrc, &src->gfd);
> +    id = g_source_attach(gsrc, NULL);
> +    g_assert(id);
> +    g_source_unref(gsrc);
> +
> +    return gsrc;
> +}
> +
> +static void
> +set_watch(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb, void *pvt)
> +{
> +    GSource *src;
> +    VugDev *dev;
> +
> +    g_assert(vu_dev);
> +    g_assert(fd >= 0);
> +    g_assert(cb);
> +
> +    dev = container_of(vu_dev, VugDev, parent);
> +    src = vug_source_new(vu_dev, fd, vu_evt, cb, pvt);
> +    g_hash_table_replace(dev->fdmap, GINT_TO_POINTER(fd), src);
> +}
> +
> +static void
> +remove_watch(VuDev *vu_dev, int fd)
> +{
> +    VugDev *dev;
> +
> +    g_assert(vu_dev);
> +    g_assert(fd >= 0);
> +
> +    dev = container_of(vu_dev, VugDev, parent);
> +    g_hash_table_remove(dev->fdmap, GINT_TO_POINTER(fd));
> +}
> +
> +
> +static void vug_watch(VuDev *dev, int condition, void *data)
> +{
> +    if (!vu_dispatch(dev) != 0) {
> +        dev->panic(dev, "Error processing vhost message");
> +    }
> +}
> +
> +void
> +vug_init(VugDev *dev, int socket,
> +         vu_panic_cb panic, const VuDevIface *iface)
> +{
> +    g_assert(dev);
> +    g_assert(iface);
> +
> +    vu_init(&dev->parent, socket, panic, set_watch, remove_watch, iface);
> +    dev->fdmap = g_hash_table_new_full(NULL, NULL, NULL,
> +                                       (GDestroyNotify) g_source_destroy);
> +
> +    dev->src = vug_source_new(&dev->parent, socket, G_IO_IN, vug_watch, NULL);
> +}
> +
> +void
> +vug_deinit(VugDev *dev)
> +{
> +    g_assert(dev);
> +
> +    g_hash_table_unref(dev->fdmap);
> +    g_source_unref(dev->src);
> +}
> diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
> index cef1ad6e31..ef3778edd4 100644
> --- a/contrib/libvhost-user/Makefile.objs
> +++ b/contrib/libvhost-user/Makefile.objs
> @@ -1 +1 @@
> -libvhost-user-obj-y = libvhost-user.o
> +libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
