Received: from eggs.gnu.org ([209.51.188.92]:34222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gs47y-0004hT-PN
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gs47v-00024Q-5w
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gs47u-0001xR-FP
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:15:23 -0500
Received: by mail-wm1-x341.google.com with SMTP id z5so3014541wmf.0
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20190207165449.6125-1-marcandre.lureau@redhat.com>
	<20190207165449.6125-6-marcandre.lureau@redhat.com>
	<20190207122432-mutt-send-email-mst@kernel.org>
	<CAMxuvaw1XW33zVxYb7sGLVXABBOrO_x206X1sffvYnJ5-Ge9gA@mail.gmail.com>
	<20190207141559-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190207141559-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 8 Feb 2019 12:15:08 +0100
Message-ID: <CAJ+F1C+o-BamEGDRo4VqZbr+KgNm3A4nzkg3g-ZwLQzD+h5qAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/12] Add vhost-user-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Feb 7, 2019 at 8:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 07, 2019 at 07:29:20PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Feb 7, 2019 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
> > >
> > > On Thu, Feb 07, 2019 at 05:54:42PM +0100, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Create a vhost-user-backend object that holds a connection to a
> > > > vhost-user backend and can be referenced from virtio devices that
> > > > support it. See later patches for input & gpu usage.
> > > >
> > > > A chardev must be specified to communicate with the vhost-user
> > > > backend, ex: -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock -objec=
t
> > > > vhost-user-backend,id=3Dvuid,chardev=3Dchar0.
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > So having an internal object that can maintain runtime state
> > > might be a good idea. However I don't yet really see
> > > what kind of property could such an object have that
> > > the char device couldn't.>
> > > I could see value if user did not have to specify
> > > a completely separate device.
> > >
> > > Consider:
> > >
> > > -chardev socket,id=3Dchar0,path=3D/tmp/foo.sock
> > > -object vhost-user-backend,id=3Dvuid,chardev=3Dchar0
> > > -device vhost-user-input-pci,vhost-user=3Dvuid
> > >
> > >
> > > There's 3 times vhost-user here, and nothing actually says it's
> > > virtio-input, that is implicit :(
> > >
> > > So I feel CLI needs to change.  But I do think the idea of
> > > an object in between does have some potential.
> >
> > Ok, I dropped the -object from CLI. It can be added later if needed.
> >
> > It makes some sense imho to wrap all the configuration/documentation
> > in a backend object. But since we have only chardev=3D now (cmd=3D is
> > being postponed), and I can only speculate on what could come next,
> > let's just have it as internal helper for now.
> >
> > I'll adjust/resend this series, this will also impact the -gpu and
> > libvirt series.
>
> But, can we make it so that these devices are created using
> -device virtio-gpu-pci etc?
> This is not a vhost user device, vhost user is the backend.

I am not sure I understand your question. I updated the series so that
vhost-user-backend is an internal helper object (created by
vhost-user-{input,gpu}-pci devices, not exposed to the CLI).

>
>
> > >
> > > Consider virtio net which now has modern, legacy and transitional
> > > variants. How is vhost-user-X type going to scale there?
> > > That's a problem worth solving IMHO.
> > >
> > > Also, there's a problem right now in that if backend
> > > connects before device is available (e.g. because we
> > > want to hotplug the device later) then we can not
> > > validate the backend. So it will fail way later.
> > > I am not sure how much do we want to validate,
> > > but if e.g. it's a different device type completely,
> > > that seems like a reasonable thing to validate.
> > >
> > > So I do see potential in a vhost user backend object
> > > but then it has to encapsulate all vhost user things,
> > > such that you can connect a virtio device to a
> > > vhost user object.
> > >
> > >
> > >
> > >
> > >
> > > > ---
> > > >  include/sysemu/vhost-user-backend.h |  60 +++++++
> > > >  backends/vhost-user.c               | 244 ++++++++++++++++++++++++=
++++
> > > >  vl.c                                |   3 +-
> > > >  MAINTAINERS                         |   2 +
> > > >  backends/Makefile.objs              |   3 +-
> > > >  qemu-options.hx                     |  20 +++
> > > >  6 files changed, 330 insertions(+), 2 deletions(-)
> > > >  create mode 100644 include/sysemu/vhost-user-backend.h
> > > >  create mode 100644 backends/vhost-user.c
> > > >
> > > > diff --git a/include/sysemu/vhost-user-backend.h b/include/sysemu/v=
host-user-backend.h
> > > > new file mode 100644
> > > > index 0000000000..60f811cae7
> > > > --- /dev/null
> > > > +++ b/include/sysemu/vhost-user-backend.h
> > > > @@ -0,0 +1,60 @@
> > > > +/*
> > > > + * QEMU vhost-user backend
> > > > + *
> > > > + * Copyright (C) 2018 Red Hat Inc
> > > > + *
> > > > + * Authors:
> > > > + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
> > > > + * See the COPYING file in the top-level directory.
> > > > + */
> > > > +#ifndef QEMU_VHOST_USER_BACKEND_H
> > > > +#define QEMU_VHOST_USER_BACKEND_H
> > > > +
> > > > +#include "qom/object.h"
> > > > +#include "exec/memory.h"
> > > > +#include "qemu/option.h"
> > > > +#include "qemu/bitmap.h"
> > > > +#include "hw/virtio/vhost.h"
> > > > +#include "hw/virtio/vhost-user.h"
> > > > +#include "chardev/char-fe.h"
> > > > +#include "io/channel.h"
> > > > +
> > > > +#define TYPE_VHOST_USER_BACKEND "vhost-user-backend"
> > > > +#define VHOST_USER_BACKEND(obj) \
> > > > +    OBJECT_CHECK(VhostUserBackend, (obj), TYPE_VHOST_USER_BACKEND)
> > > > +#define VHOST_USER_BACKEND_GET_CLASS(obj) \
> > > > +    OBJECT_GET_CLASS(VhostUserBackendClass, (obj), TYPE_VHOST_USER=
_BACKEND)
> > > > +#define VHOST_USER_BACKEND_CLASS(klass) \
> > > > +    OBJECT_CLASS_CHECK(VhostUserBackendClass, (klass), TYPE_VHOST_=
USER_BACKEND)
> > > > +
> > > > +typedef struct VhostUserBackend VhostUserBackend;
> > > > +typedef struct VhostUserBackendClass VhostUserBackendClass;
> > > > +
> > > > +struct VhostUserBackendClass {
> > > > +    ObjectClass parent_class;
> > > > +};
> > > > +
> > > > +struct VhostUserBackend {
> > > > +    /* private */
> > > > +    Object parent;
> > > > +
> > > > +    char *cmd;
> > > > +    char *chr_name;
> > > > +
> > > > +    CharBackend chr;
> > > > +    VhostUserState vhost_user;
> > > > +    struct vhost_dev dev;
> > > > +    QIOChannel *child;
> > > > +    VirtIODevice *vdev;
> > > > +    bool started;
> > > > +    bool completed;
> > > > +};
> > > > +
> > > > +int vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice =
*vdev,
> > > > +                                unsigned nvqs, Error **errp);
> > > > +void vhost_user_backend_start(VhostUserBackend *b);
> > > > +void vhost_user_backend_stop(VhostUserBackend *b);
> > > > +
> > > > +#endif
> > > > diff --git a/backends/vhost-user.c b/backends/vhost-user.c
> > > > new file mode 100644
> > > > index 0000000000..bf39c0751d
> > > > --- /dev/null
> > > > +++ b/backends/vhost-user.c
> > > > @@ -0,0 +1,244 @@
> > > > +/*
> > > > + * QEMU vhost-user backend
> > > > + *
> > > > + * Copyright (C) 2018 Red Hat Inc
> > > > + *
> > > > + * Authors:
> > > > + *  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > + *
> > > > + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
> > > > + * See the COPYING file in the top-level directory.
> > > > + */
> > > > +
> > > > +
> > > > +#include "qemu/osdep.h"
> > > > +#include "hw/qdev.h"
> > > > +#include "qapi/error.h"
> > > > +#include "qapi/qmp/qerror.h"
> > > > +#include "qemu/error-report.h"
> > > > +#include "qom/object_interfaces.h"
> > > > +#include "sysemu/vhost-user-backend.h"
> > > > +#include "sysemu/kvm.h"
> > > > +#include "io/channel-command.h"
> > > > +#include "hw/virtio/virtio-bus.h"
> > > > +
> > > > +static bool
> > > > +ioeventfd_enabled(void)
> > > > +{
> > > > +    return kvm_enabled() && kvm_eventfds_enabled();
> > > > +}
> > > > +
> > > > +int
> > > > +vhost_user_backend_dev_init(VhostUserBackend *b, VirtIODevice *vde=
v,
> > > > +                            unsigned nvqs, Error **errp)
> > > > +{
> > > > +    int ret;
> > > > +
> > > > +    assert(!b->vdev && vdev);
> > > > +
> > > > +    if (!ioeventfd_enabled()) {
> > > > +        error_setg(errp, "vhost initialization failed: requires kv=
m");
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    if (!vhost_user_init(&b->vhost_user, &b->chr, errp)) {
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    b->vdev =3D vdev;
> > > > +    b->dev.nvqs =3D nvqs;
> > > > +    b->dev.vqs =3D g_new(struct vhost_virtqueue, nvqs);
> > > > +
> > > > +    ret =3D vhost_dev_init(&b->dev, &b->vhost_user, VHOST_BACKEND_=
TYPE_USER, 0);
> > > > +    if (ret < 0) {
> > > > +        error_setg_errno(errp, -ret, "vhost initialization failed"=
);
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > > +void
> > > > +vhost_user_backend_start(VhostUserBackend *b)
> > > > +{
> > > > +    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
> > > > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > > > +    int ret, i ;
> > > > +
> > > > +    if (b->started) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!k->set_guest_notifiers) {
> > > > +        error_report("binding does not support guest notifiers");
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    ret =3D vhost_dev_enable_notifiers(&b->dev, b->vdev);
> > > > +    if (ret < 0) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    ret =3D k->set_guest_notifiers(qbus->parent, b->dev.nvqs, true=
);
> > > > +    if (ret < 0) {
> > > > +        error_report("Error binding guest notifier");
> > > > +        goto err_host_notifiers;
> > > > +    }
> > > > +
> > > > +    b->dev.acked_features =3D b->vdev->guest_features;
> > > > +    ret =3D vhost_dev_start(&b->dev, b->vdev);
> > > > +    if (ret < 0) {
> > > > +        error_report("Error start vhost dev");
> > > > +        goto err_guest_notifiers;
> > > > +    }
> > > > +
> > > > +    /* guest_notifier_mask/pending not used yet, so just unmask
> > > > +     * everything here.  virtio-pci will do the right thing by
> > > > +     * enabling/disabling irqfd.
> > > > +     */
> > > > +    for (i =3D 0; i < b->dev.nvqs; i++) {
> > > > +        vhost_virtqueue_mask(&b->dev, b->vdev,
> > > > +                             b->dev.vq_index + i, false);
> > > > +    }
> > > > +
> > > > +    b->started =3D true;
> > > > +    return;
> > > > +
> > > > +err_guest_notifiers:
> > > > +    k->set_guest_notifiers(qbus->parent, b->dev.nvqs, false);
> > > > +err_host_notifiers:
> > > > +    vhost_dev_disable_notifiers(&b->dev, b->vdev);
> > > > +}
> > > > +
> > > > +void
> > > > +vhost_user_backend_stop(VhostUserBackend *b)
> > > > +{
> > > > +    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(b->vdev)));
> > > > +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
> > > > +    int ret =3D 0;
> > > > +
> > > > +    if (!b->started) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    vhost_dev_stop(&b->dev, b->vdev);
> > > > +
> > > > +    if (k->set_guest_notifiers) {
> > > > +        ret =3D k->set_guest_notifiers(qbus->parent,
> > > > +                                     b->dev.nvqs, false);
> > > > +        if (ret < 0) {
> > > > +            error_report("vhost guest notifier cleanup failed: %d"=
, ret);
> > > > +        }
> > > > +    }
> > > > +    assert(ret >=3D 0);
> > > > +
> > > > +    vhost_dev_disable_notifiers(&b->dev, b->vdev);
> > > > +    b->started =3D false;
> > > > +}
> > > > +
> > > > +static void
> > > > +vhost_user_backend_complete(UserCreatable *uc, Error **errp)
> > > > +{
> > > > +    VhostUserBackend *b =3D VHOST_USER_BACKEND(uc);
> > > > +    Chardev *chr;
> > > > +
> > > > +    if (!b->chr_name) {
> > > > +        error_setg(errp, "You must specificy 'chardev'.");
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    chr =3D qemu_chr_find(b->chr_name);
> > > > +    if (chr =3D=3D NULL) {
> > > > +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > > > +                  "Chardev '%s' not found", b->chr_name);
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (!qemu_chr_fe_init(&b->chr, chr, errp)) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    b->completed =3D true;
> > > > +    /* could vhost_dev_init() happen here, so early vhost-user mes=
sage
> > > > +     * can be exchanged */
> > > > +}
> > > > +
> > > > +static void set_chardev(Object *obj, const char *value, Error **er=
rp)
> > > > +{
> > > > +    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
> > > > +
> > > > +    if (b->completed) {
> > > > +        error_setg(errp, QERR_PERMISSION_DENIED);
> > > > +    } else {
> > > > +        g_free(b->chr_name);
> > > > +        b->chr_name =3D g_strdup(value);
> > > > +    }
> > > > +}
> > > > +
> > > > +static char *get_chardev(Object *obj, Error **errp)
> > > > +{
> > > > +    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
> > > > +    Chardev *chr =3D qemu_chr_fe_get_driver(&b->chr);
> > > > +
> > > > +    if (chr && chr->label) {
> > > > +        return g_strdup(chr->label);
> > > > +    }
> > > > +
> > > > +    return NULL;
> > > > +}
> > > > +
> > > > +static void vhost_user_backend_init(Object *obj)
> > > > +{
> > > > +    object_property_add_str(obj, "chardev", get_chardev, set_chard=
ev, NULL);
> > > > +}
> > > > +
> > > > +static void vhost_user_backend_finalize(Object *obj)
> > > > +{
> > > > +    VhostUserBackend *b =3D VHOST_USER_BACKEND(obj);
> > > > +
> > > > +    g_free(b->dev.vqs);
> > > > +    g_free(b->chr_name);
> > > > +
> > > > +    vhost_user_cleanup(&b->vhost_user);
> > > > +    qemu_chr_fe_deinit(&b->chr, true);
> > > > +
> > > > +    if (b->child) {
> > > > +        object_unref(OBJECT(b->child));
> > > > +    }
> > > > +}
> > > > +
> > > > +static bool
> > > > +vhost_user_backend_can_be_deleted(UserCreatable *uc)
> > > > +{
> > > > +    return true;
> > > > +}
> > > > +
> > > > +static void
> > > > +vhost_user_backend_class_init(ObjectClass *oc, void *data)
> > > > +{
> > > > +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> > > > +
> > > > +    ucc->complete =3D vhost_user_backend_complete;
> > > > +    ucc->can_be_deleted =3D vhost_user_backend_can_be_deleted;
> > > > +}
> > > > +
> > > > +static const TypeInfo vhost_user_backend_info =3D {
> > > > +    .name =3D TYPE_VHOST_USER_BACKEND,
> > > > +    .parent =3D TYPE_OBJECT,
> > > > +    .instance_size =3D sizeof(VhostUserBackend),
> > > > +    .instance_init =3D vhost_user_backend_init,
> > > > +    .instance_finalize =3D vhost_user_backend_finalize,
> > > > +    .class_size =3D sizeof(VhostUserBackendClass),
> > > > +    .class_init =3D vhost_user_backend_class_init,
> > > > +    .interfaces =3D (InterfaceInfo[]) {
> > > > +        { TYPE_USER_CREATABLE },
> > > > +        { }
> > > > +    }
> > > > +};
> > > > +
> > > > +static void register_types(void)
> > > > +{
> > > > +    type_register_static(&vhost_user_backend_info);
> > > > +}
> > > > +
> > > > +type_init(register_types);
> > > > diff --git a/vl.c b/vl.c
> > > > index 9e4dba7f92..43012ee6a3 100644
> > > > --- a/vl.c
> > > > +++ b/vl.c
> > > > @@ -2784,7 +2784,8 @@ static bool object_create_initial(const char =
*type, QemuOpts *opts)
> > > >      }
> > > >
> > > >  #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
> > > > -    if (g_str_equal(type, "cryptodev-vhost-user")) {
> > > > +    if (g_str_equal(type, "cryptodev-vhost-user") ||
> > > > +        g_str_equal(type, "vhost-user-backend")) {
> > > >          return false;
> > > >      }
> > > >  #endif
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 16b6264412..e077fe788d 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1424,6 +1424,8 @@ F: hw/*/*vhost*
> > > >  F: docs/interop/vhost-user.json
> > > >  F: docs/interop/vhost-user.txt
> > > >  F: contrib/vhost-user-*/
> > > > +F: backends/vhost-user.c
> > > > +F: include/sysemu/vhost-user-backend.h
> > > >
> > > >  virtio
> > > >  M: Michael S. Tsirkin <mst@redhat.com>
> > > > diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> > > > index 717fcbdae4..a5ec0bf907 100644
> > > > --- a/backends/Makefile.objs
> > > > +++ b/backends/Makefile.objs
> > > > @@ -12,7 +12,8 @@ common-obj-y +=3D cryptodev-builtin.o
> > > >  ifeq ($(CONFIG_VIRTIO),y)
> > > >  common-obj-y +=3D cryptodev-vhost.o
> > > >  common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) +=3D =
\
> > > > -    cryptodev-vhost-user.o
> > > > +    cryptodev-vhost-user.o \
> > > > +    vhost-user.o
> > > >  endif
> > > >
> > > >  common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
> > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > index 06ef1a7c5c..24315a4cda 100644
> > > > --- a/qemu-options.hx
> > > > +++ b/qemu-options.hx
> > > > @@ -4203,6 +4203,26 @@ secondary:
> > > >  If you want to know the detail of above command line, you can read
> > > >  the colo-compare git log.
> > > >
> > > > +@item -object vhost-user-backend,id=3Did=3D@var{id},chardev=3D@var=
{chardevid}
> > > > +
> > > > +Create a vhost-user-backend object that holds a connection to a
> > > > +vhost-user backend and can be referenced from virtio/vhost-user
> > > > +devices that support it.
> > > > +
> > > > +The @var{id} parameter is a unique ID that will be used to referen=
ce
> > > > +this vhost-user backend from the @option{vhost-user} device. The
> > > > +@var{chardev} parameter is the unique ID of a character device bac=
kend
> > > > +that provides the connection to the vhost-user slave process. (Sin=
ce 3.2)
> > > > +
> > > > +@example
> > > > +
> > > > + # qemu-system-x86_64 \
> > > > +   [...] \
> > > > +   -object vhost-user-backend,id=3Dvuid,chardev=3Dchar0 \
> > > > +   -device vhost-user-input-pci,vhost-user=3Dvuid
> > > > +   [...]
> > > > +@end example
> > > > +
> > > >  @item -object cryptodev-backend-builtin,id=3D@var{id}[,queues=3D@v=
ar{queues}]
> > > >
> > > >  Creates a cryptodev backend which executes crypto opreation from
> > > > --
> > > > 2.20.1.519.g8feddda32c
>


--=20
Marc-Andr=C3=A9 Lureau
