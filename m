Received: from eggs.gnu.org ([209.51.188.92]:59997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt9sR-0002Fo-HI
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gt9sQ-00077O-9X
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:35:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gt9sQ-000773-4a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:35:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id v10so1913193qtp.8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 03:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-7-marcandre.lureau@redhat.com>
	<20190211110102.GO27585@redhat.com>
In-Reply-To: <20190211110102.GO27585@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 11 Feb 2019 12:35:42 +0100
Message-ID: <CAMxuvayTu102TKx0sf1j-JxnUhL6TpT8ze_pGpcT9R6mtEE=bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi
On Mon, Feb 11, 2019 at 12:01 PM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>
> On Fri, Feb 08, 2019 at 12:23:50PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Create a vhost-user-backend object that holds a connection to a
> > vhost-user backend and can be referenced from virtio devices that
> > support it. See later patches for input & gpu usage.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/sysemu/vhost-user-backend.h |  60 ++++++++
> >  backends/vhost-user.c               | 213 ++++++++++++++++++++++++++++
> >  MAINTAINERS                         |   2 +
> >  backends/Makefile.objs              |   3 +-
> >  4 files changed, 277 insertions(+), 1 deletion(-)
> >  create mode 100644 include/sysemu/vhost-user-backend.h
> >  create mode 100644 backends/vhost-user.c
> >
> > diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/vhost=
-user-backend.h
> > new file mode 100644
> > index 0000000000..60f811cae7
> > --- /dev/null
> > +++ b/include/sysemu/vhost-user-backend.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * QEMU vhost-user backend
> > + *
> > + * Copyright (C) 2018 Red Hat Inc
> > + *
> > + * Authors:
> > + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +#ifndef QEMU_VHOST_USER_BACKEND_H
> > +#define QEMU_VHOST_USER_BACKEND_H
> > +
> > +#include "qom/object.h"
> > +#include "exec/memory.h"
> > +#include "qemu/option.h"
> > +#include "qemu/bitmap.h"
> > +#include "hw/virtio/vhost.h"
> > +#include "hw/virtio/vhost-user.h"
> > +#include "chardev/char-fe.h"
> > +#include "io/channel.h"
> > +
> > +#define TYPE_VHOST_USER_BACKEND "vhost-user-backend"
> > +#define VHOST_USER_BACKEND(obj) \
> > +    OBJECT_CHECK(VhostUserBackend, (obj), TYPE_VHOST_USER_BACKEND)
> > +#define VHOST_USER_BACKEND_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(VhostUserBackendClass, (obj), TYPE_VHOST_USER_BAC=
KEND)
> > +#define VHOST_USER_BACKEND_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(VhostUserBackendClass, (klass), TYPE_VHOST_USER=
_BACKEND)
> > +
> > +typedef struct VhostUserBackend VhostUserBackend;
> > +typedef struct VhostUserBackendClass VhostUserBackendClass;
> > +
> > +struct VhostUserBackendClass {
> > +    ObjectClass parent_class;
> > +};
> > +
> > +struct VhostUserBackend {
> > +    /* private */
> > +    Object parent;
> > +
> > +    char *cmd;
>
> This field doesn't appear to be used any more

Good catch! thanks

>
> > +    char *chr_name;
> > +
> > +    CharBackend chr;
> > +    VhostUserState vhost_user;
> > +    struct vhost_dev dev;
> > +    QIOChannel *child;
> > +    VirtIODevice *vdev;
> > +    bool started;
> > +    bool completed;
> > +};
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
