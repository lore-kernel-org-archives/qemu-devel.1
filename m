Received: from eggs.gnu.org ([209.51.188.92]:49200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9LS-0000Z0-OK
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9LQ-0007J8-LT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:01:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gt9LO-0007Cm-JT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:01:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FF5E7F6C8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 11:01:25 +0000 (UTC)
Date: Mon, 11 Feb 2019 11:01:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211110102.GO27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208112357.31615-7-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 06/13] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Feb 08, 2019 at 12:23:50PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Create a vhost-user-backend object that holds a connection to a
> vhost-user backend and can be referenced from virtio devices that
> support it. See later patches for input & gpu usage.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/vhost-user-backend.h |  60 ++++++++
>  backends/vhost-user.c               | 213 ++++++++++++++++++++++++++++
>  MAINTAINERS                         |   2 +
>  backends/Makefile.objs              |   3 +-
>  4 files changed, 277 insertions(+), 1 deletion(-)
>  create mode 100644 include/sysemu/vhost-user-backend.h
>  create mode 100644 backends/vhost-user.c
>=20
> diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost=
-user-backend.h
> new file mode 100644
> index 0000000000..60f811cae7
> --- /dev/null
> +++ b/include/sysemu/vhost-user-backend.h
> @@ -0,0 +1,60 @@
> +/*
> + * QEMU vhost-user backend
> + *
> + * Copyright (C) 2018 Red Hat Inc
> + *
> + * Authors:
> + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef QEMU_VHOST_USER_BACKEND_H
> +#define QEMU_VHOST_USER_BACKEND_H
> +
> +#include "qom/object.h"
> +#include "exec/memory.h"
> +#include "qemu/option.h"
> +#include "qemu/bitmap.h"
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-user.h"
> +#include "chardev/char-fe.h"
> +#include "io/channel.h"
> +
> +#define TYPE_VHOST_USER_BACKEND "vhost-user-backend"
> +#define VHOST_USER_BACKEND(obj) \
> +    OBJECT_CHECK(VhostUserBackend, (obj), TYPE_VHOST_USER_BACKEND)
> +#define VHOST_USER_BACKEND_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(VhostUserBackendClass, (obj), TYPE_VHOST_USER_BAC=
KEND)
> +#define VHOST_USER_BACKEND_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(VhostUserBackendClass, (klass), TYPE_VHOST_USER=
_BACKEND)
> +
> +typedef struct VhostUserBackend VhostUserBackend;
> +typedef struct VhostUserBackendClass VhostUserBackendClass;
> +
> +struct VhostUserBackendClass {
> +    ObjectClass parent_class;
> +};
> +
> +struct VhostUserBackend {
> +    /* private */
> +    Object parent;
> +
> +    char *cmd;

This field doesn't appear to be used any more

> +    char *chr_name;
> +
> +    CharBackend chr;
> +    VhostUserState vhost_user;
> +    struct vhost_dev dev;
> +    QIOChannel *child;
> +    VirtIODevice *vdev;
> +    bool started;
> +    bool completed;
> +};

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
