Received: from eggs.gnu.org ([2001:4830:134:3::10]:36582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJmd-0002gt-Fz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duJmX-0008TZ-9M
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:55 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:49691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duJmW-0008SH-Rs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:45:49 -0400
Received: by mail-wm0-f51.google.com with SMTP id e71so106169wmg.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 07:45:48 -0700 (PDT)
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-25-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fde2c35e-d0ce-4380-f271-3fa18865ea36@redhat.com>
Date: Tue, 19 Sep 2017 16:45:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 24/27] libvhost-user: add glib source helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 23/08/2017 18:20, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.h |  32 +++++++
>  contrib/libvhost-user/libvhost-user-glib.c | 145 +++++++++++++++++++++++++++++
>  contrib/libvhost-user/Makefile.objs        |   2 +-
>  3 files changed, 178 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/libvhost-user/libvhost-user-glib.h
>  create mode 100644 contrib/libvhost-user/libvhost-user-glib.c
> 
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
> new file mode 100644
> index 0000000000..a4b30824a1
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
> +    GMainLoop *loop;
> +    GHashTable *fdmap; /* fd -> gsource */
> +} VugDev;
> +
> +void vug_init(VugDev *dev, int socket, GMainLoop *loop,
> +              vu_panic_cb panic, const VuDevIface *iface);
> +void vug_deinit(VugDev *dev);
> +
> +#endif /* LIBVHOST_USER_GLIB_H */
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
> new file mode 100644
> index 0000000000..13e095b8e7
> --- /dev/null
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -0,0 +1,145 @@
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
> +typedef struct vus_gsrc {
> +    GSource parent;
> +    VuDev *dev;
> +    GPollFD gfd;
> +} vus_gsrc_t;
> +
> +static gboolean
> +vus_gsrc_prepare(GSource *src, gint *timeout)
> +{
> +    g_assert(timeout);
> +
> +    *timeout = -1;
> +    return FALSE;
> +}
> +
> +static gboolean
> +vus_gsrc_check(GSource *src)
> +{
> +    vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
> +
> +    g_assert(vus_src);
> +
> +    return vus_src->gfd.revents & vus_src->gfd.events;
> +}
> +
> +static gboolean
> +vus_gsrc_dispatch(GSource *src, GSourceFunc cb, gpointer data)
> +{
> +    vus_gsrc_t *vus_src = (vus_gsrc_t *)src;
> +
> +    g_assert(vus_src);
> +
> +    ((vu_watch_cb)cb) (vus_src->dev, vus_src->gfd.revents, data);
> +
> +    return G_SOURCE_CONTINUE;
> +}
> +
> +static GSourceFuncs vus_gsrc_funcs = {
> +    vus_gsrc_prepare,
> +    vus_gsrc_check,
> +    vus_gsrc_dispatch,
> +    NULL
> +};
> +
> +static GSource *
> +vug_source_new(VuDev *dev, int fd, GIOCondition cond,
> +               vu_watch_cb vu_cb, gpointer data)
> +{
> +    GSource *vus_gsrc;
> +    vus_gsrc_t *vus_src;
> +    guint id;
> +
> +    g_assert(dev);
> +    g_assert(fd >= 0);
> +    g_assert(vu_cb);
> +
> +    vus_gsrc = g_source_new(&vus_gsrc_funcs, sizeof(vus_gsrc_t));
> +    g_source_set_callback(vus_gsrc, (GSourceFunc) vu_cb, data, NULL);
> +    vus_src = (vus_gsrc_t *)vus_gsrc;
> +    vus_src->dev = dev;
> +    vus_src->gfd.fd = fd;
> +    vus_src->gfd.events = cond;
> +
> +    g_source_add_poll(vus_gsrc, &vus_src->gfd);
> +    id = g_source_attach(vus_gsrc, NULL);
> +    g_assert(id);
> +    g_source_unref(vus_gsrc);
> +
> +    return vus_gsrc;
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
> +void
> +vug_init(VugDev *dev, int socket, GMainLoop *loop,
> +         vu_panic_cb panic, const VuDevIface *iface)
> +{
> +    g_assert(dev);
> +    g_assert(loop);
> +    g_assert(iface);
> +
> +    vu_init(&dev->parent, socket, panic, set_watch, remove_watch, iface);
> +    dev->loop = loop;
> +    dev->fdmap = g_hash_table_new_full(NULL, NULL, NULL,
> +                                       (GDestroyNotify) g_source_destroy);
> +}
> +
> +void
> +vug_deinit(VugDev *dev)
> +{
> +    g_assert(dev);
> +
> +    g_hash_table_unref(dev->fdmap);
> +}
> diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/Makefile.objs
> index cef1ad6e31..ef3778edd4 100644
> --- a/contrib/libvhost-user/Makefile.objs
> +++ b/contrib/libvhost-user/Makefile.objs
> @@ -1 +1 @@
> -libvhost-user-obj-y = libvhost-user.o
> +libvhost-user-obj-y += libvhost-user.o libvhost-user-glib.o
> 

Whatever you do with patch 13, the code here will be fine, so

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
