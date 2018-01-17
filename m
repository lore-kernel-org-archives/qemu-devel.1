Received: from eggs.gnu.org ([2001:4830:134:3::10]:45451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebfqx-00022l-Gk
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebfqt-0002c1-Ju
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:01:35 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2308 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ebfqs-0002Zn-L8
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 00:01:31 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 17 Jan 2018 05:01:16 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB4A1C9@DGGEMM505-MBS.china.huawei.com>
References: <1516111613-18988-1-git-send-email-jianjay.zhou@huawei.com>
	<1516111613-18988-2-git-send-email-jianjay.zhou@huawei.com>
	<20180116184039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180116184039-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/4] cryptodev: add vhost-user as a new
 cryptodev backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, longpeng <longpeng2@huawei.com>

> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+jianjay.zhou=3Dhuawei.com@nongnu.org] On Behalf Of Michael S. Tsi=
rkin
> Sent: Wednesday, January 17, 2018 12:41 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: pasic@linux.vnet.ibm.com; Huangweidong (C) <weidong.huang@huawei.com>=
;
> xin.zeng@intel.com; qemu-devel@nongnu.org; Gonglei (Arei)
> <arei.gonglei@huawei.com>; roy.fan.zhang@intel.com; stefanha@redhat.com;
> pbonzini@redhat.com; longpeng <longpeng2@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v3 1/4] cryptodev: add vhost-user as a n=
ew
> cryptodev backend
>=20
> On Tue, Jan 16, 2018 at 10:06:50PM +0800, Jay Zhou wrote:
> > From: Gonglei <arei.gonglei@huawei.com>
> >
> > Usage:
> >  -chardev socket,id=3Dcharcrypto0,path=3D/path/to/your/socket
> >  -object cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dcharcrypto0
> >  -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0
> >
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > ---
> >  backends/Makefile.objs           |   4 +
> >  backends/cryptodev-vhost-user.c  | 333
> +++++++++++++++++++++++++++++++++++++++
> >  backends/cryptodev-vhost.c       |  73 +++++++++
> >  include/sysemu/cryptodev-vhost.h | 154 ++++++++++++++++++
> >  qemu-options.hx                  |  21 +++
> >  vl.c                             |   4 +
> >  6 files changed, 589 insertions(+)
> >  create mode 100644 backends/cryptodev-vhost-user.c  create mode
> > 100644 backends/cryptodev-vhost.c  create mode 100644
> > include/sysemu/cryptodev-vhost.h
> >
> > diff --git a/backends/Makefile.objs b/backends/Makefile.objs index
> > 0400799..9e1fb76 100644
> > --- a/backends/Makefile.objs
> > +++ b/backends/Makefile.objs
> > @@ -8,3 +8,7 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-file.o
> >
> >  common-obj-y +=3D cryptodev.o
> >  common-obj-y +=3D cryptodev-builtin.o
> > +
> > +ifeq ($(CONFIG_VIRTIO),y)
> > +common-obj-$(CONFIG_LINUX) +=3D cryptodev-vhost.o
> > +cryptodev-vhost-user.o endif
>=20
> Shouldn't this depend on CONFIG_VHOST_USER?

Yes, you're right. Will fix it soon.

Regards,
Jay

>=20
>=20
> > diff --git a/backends/cryptodev-vhost-user.c
> > b/backends/cryptodev-vhost-user.c new file mode 100644 index
> > 0000000..4e63ece
> > --- /dev/null
> > +++ b/backends/cryptodev-vhost-user.c
> > @@ -0,0 +1,333 @@
> > +/*
> > + * QEMU Cryptodev backend for QEMU cipher APIs
> > + *
> > + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > + *
> > + * Authors:
> > + *    Gonglei <arei.gonglei@huawei.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> <http://www.gnu.org/licenses/>.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/boards.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/qerror.h"
> > +#include "qemu/error-report.h"
> > +#include "standard-headers/linux/virtio_crypto.h"
> > +#include "sysemu/cryptodev-vhost.h"
> > +#include "chardev/char-fe.h"
> > +
> > +
> > +/**
> > + * @TYPE_CRYPTODEV_BACKEND_VHOST_USER:
> > + * name of backend that uses vhost user server  */ #define
> > +TYPE_CRYPTODEV_BACKEND_VHOST_USER "cryptodev-vhost-user"
> > +
> > +#define CRYPTODEV_BACKEND_VHOST_USER(obj) \
> > +    OBJECT_CHECK(CryptoDevBackendVhostUser, \
> > +                 (obj), TYPE_CRYPTODEV_BACKEND_VHOST_USER)
> > +
> > +
> > +typedef struct CryptoDevBackendVhostUser {
> > +    CryptoDevBackend parent_obj;
> > +
> > +    CharBackend chr;
> > +    char *chr_name;
> > +    bool opened;
> > +    CryptoDevBackendVhost *vhost_crypto[MAX_CRYPTO_QUEUE_NUM];
> > +} CryptoDevBackendVhostUser;
> > +
> > +static int
> > +cryptodev_vhost_user_running(
> > +             CryptoDevBackendVhost *crypto) {
> > +    return crypto ? 1 : 0;
> > +}
> > +
> > +static void cryptodev_vhost_user_stop(int queues,
> > +                          CryptoDevBackendVhostUser *s) {
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < queues; i++) {
> > +        if (!cryptodev_vhost_user_running(s->vhost_crypto[i])) {
> > +            continue;
> > +        }
> > +
> > +        if (s->vhost_crypto) {
> > +            cryptodev_vhost_cleanup(s->vhost_crypto[i]);
> > +            s->vhost_crypto[i] =3D NULL;
> > +        }
> > +    }
> > +}
> > +
> > +static int
> > +cryptodev_vhost_user_start(int queues,
> > +                         CryptoDevBackendVhostUser *s) {
> > +    CryptoDevBackendVhostOptions options;
> > +    CryptoDevBackend *b =3D CRYPTODEV_BACKEND(s);
> > +    int max_queues;
> > +    size_t i;
> > +
> > +    for (i =3D 0; i < queues; i++) {
> > +        if (cryptodev_vhost_user_running(s->vhost_crypto[i])) {
> > +            continue;
> > +        }
> > +
> > +        options.opaque =3D &s->chr;
> > +        options.backend_type =3D VHOST_BACKEND_TYPE_USER;
> > +        options.cc =3D b->conf.peers.ccs[i];
> > +        s->vhost_crypto[i] =3D cryptodev_vhost_init(&options);
> > +        if (!s->vhost_crypto[i]) {
> > +            error_report("failed to init vhost_crypto for queue %lu", =
i);
> > +            goto err;
> > +        }
> > +
> > +        if (i =3D=3D 0) {
> > +            max_queues =3D
> > +              cryptodev_vhost_get_max_queues(s->vhost_crypto[i]);
> > +            if (queues > max_queues) {
> > +                error_report("you are asking more queues than
> supported: %d",
> > +                             max_queues);
> > +                goto err;
> > +            }
> > +        }
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    cryptodev_vhost_user_stop(i + 1, s);
> > +    return -1;
> > +}
> > +
> > +static Chardev *
> > +cryptodev_vhost_claim_chardev(CryptoDevBackendVhostUser *s,
> > +                                    Error **errp) {
> > +    Chardev *chr;
> > +
> > +    if (s->chr_name =3D=3D NULL) {
> > +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> > +                   "chardev", "a valid character device");
> > +        return NULL;
> > +    }
> > +
> > +    chr =3D qemu_chr_find(s->chr_name);
> > +    if (chr =3D=3D NULL) {
> > +        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > +                  "Device '%s' not found", s->chr_name);
> > +        return NULL;
> > +    }
> > +
> > +    return chr;
> > +}
> > +
> > +static void cryptodev_vhost_user_event(void *opaque, int event) {
> > +    CryptoDevBackendVhostUser *s =3D opaque;
> > +    CryptoDevBackend *b =3D CRYPTODEV_BACKEND(s);
> > +    Error *err =3D NULL;
> > +    int queues =3D b->conf.peers.queues;
> > +
> > +    assert(queues < MAX_CRYPTO_QUEUE_NUM);
> > +
> > +    switch (event) {
> > +    case CHR_EVENT_OPENED:
> > +        if (cryptodev_vhost_user_start(queues, s) < 0) {
> > +            exit(1);
> > +        }
> > +        b->ready =3D true;
> > +        break;
> > +    case CHR_EVENT_CLOSED:
> > +        b->ready =3D false;
> > +        cryptodev_vhost_user_stop(queues, s);
> > +        break;
> > +    }
> > +
> > +    if (err) {
> > +        error_report_err(err);
> > +    }
> > +}
> > +
> > +static void cryptodev_vhost_user_init(
> > +             CryptoDevBackend *backend, Error **errp) {
> > +    int queues =3D backend->conf.peers.queues;
> > +    size_t i;
> > +    Error *local_err =3D NULL;
> > +    Chardev *chr;
> > +    CryptoDevBackendClient *cc;
> > +    CryptoDevBackendVhostUser *s =3D
> > +                      CRYPTODEV_BACKEND_VHOST_USER(backend);
> > +
> > +    chr =3D cryptodev_vhost_claim_chardev(s, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    s->opened =3D true;
> > +
> > +    for (i =3D 0; i < queues; i++) {
> > +        cc =3D cryptodev_backend_new_client(
> > +                  "cryptodev-vhost-user", NULL);
> > +        cc->info_str =3D g_strdup_printf("cryptodev-vhost-user%lu to %=
s ",
> > +                                       i, chr->label);
> > +        cc->queue_index =3D i;
> > +
> > +        backend->conf.peers.ccs[i] =3D cc;
> > +
> > +        if (i =3D=3D 0) {
> > +            if (!qemu_chr_fe_init(&s->chr, chr, &local_err)) {
> > +                error_propagate(errp, local_err);
> > +                return;
> > +            }
> > +        }
> > +    }
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
> > +                     cryptodev_vhost_user_event, NULL, s, NULL,
> > + true);
> > +
> > +    backend->conf.crypto_services =3D
> > +                         1u << VIRTIO_CRYPTO_SERVICE_CIPHER |
> > +                         1u << VIRTIO_CRYPTO_SERVICE_HASH |
> > +                         1u << VIRTIO_CRYPTO_SERVICE_MAC;
> > +    backend->conf.cipher_algo_l =3D 1u << VIRTIO_CRYPTO_CIPHER_AES_CBC=
;
> > +    backend->conf.hash_algo =3D 1u << VIRTIO_CRYPTO_HASH_SHA1; }
> > +
> > +static int64_t cryptodev_vhost_user_sym_create_session(
> > +           CryptoDevBackend *backend,
> > +           CryptoDevBackendSymSessionInfo *sess_info,
> > +           uint32_t queue_index, Error **errp) {
> > +    return 0;
> > +}
> > +
> > +static int cryptodev_vhost_user_sym_close_session(
> > +           CryptoDevBackend *backend,
> > +           uint64_t session_id,
> > +           uint32_t queue_index, Error **errp) {
> > +    return 0;
> > +}
> > +
> > +static int cryptodev_vhost_user_sym_operation(
> > +                 CryptoDevBackend *backend,
> > +                 CryptoDevBackendSymOpInfo *op_info,
> > +                 uint32_t queue_index, Error **errp) {
> > +    return VIRTIO_CRYPTO_OK;
> > +}
> > +
> > +static void cryptodev_vhost_user_cleanup(
> > +             CryptoDevBackend *backend,
> > +             Error **errp)
> > +{
> > +    CryptoDevBackendVhostUser *s =3D
> > +                      CRYPTODEV_BACKEND_VHOST_USER(backend);
> > +    size_t i;
> > +    int queues =3D backend->conf.peers.queues;
> > +    CryptoDevBackendClient *cc;
> > +
> > +    cryptodev_vhost_user_stop(queues, s);
> > +
> > +    for (i =3D 0; i < queues; i++) {
> > +        cc =3D backend->conf.peers.ccs[i];
> > +        if (cc) {
> > +            cryptodev_backend_free_client(cc);
> > +            backend->conf.peers.ccs[i] =3D NULL;
> > +        }
> > +    }
> > +}
> > +
> > +static void cryptodev_vhost_user_set_chardev(Object *obj,
> > +                                    const char *value, Error **errp)
> > +{
> > +    CryptoDevBackendVhostUser *s =3D
> > +                      CRYPTODEV_BACKEND_VHOST_USER(obj);
> > +
> > +    if (s->opened) {
> > +        error_setg(errp, QERR_PERMISSION_DENIED);
> > +    } else {
> > +        g_free(s->chr_name);
> > +        s->chr_name =3D g_strdup(value);
> > +    }
> > +}
> > +
> > +static char *
> > +cryptodev_vhost_user_get_chardev(Object *obj, Error **errp) {
> > +    CryptoDevBackendVhostUser *s =3D
> > +                      CRYPTODEV_BACKEND_VHOST_USER(obj);
> > +    Chardev *chr =3D qemu_chr_fe_get_driver(&s->chr);
> > +
> > +    if (chr && chr->label) {
> > +        return g_strdup(chr->label);
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void cryptodev_vhost_user_instance_int(Object *obj) {
> > +    object_property_add_str(obj, "chardev",
> > +                            cryptodev_vhost_user_get_chardev,
> > +                            cryptodev_vhost_user_set_chardev,
> > +                            NULL);
> > +}
> > +
> > +static void cryptodev_vhost_user_finalize(Object *obj) {
> > +    CryptoDevBackendVhostUser *s =3D
> > +                      CRYPTODEV_BACKEND_VHOST_USER(obj);
> > +
> > +    qemu_chr_fe_deinit(&s->chr, false);
> > +
> > +    g_free(s->chr_name);
> > +}
> > +
> > +static void
> > +cryptodev_vhost_user_class_init(ObjectClass *oc, void *data) {
> > +    CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_CLASS(oc);
> > +
> > +    bc->init =3D cryptodev_vhost_user_init;
> > +    bc->cleanup =3D cryptodev_vhost_user_cleanup;
> > +    bc->create_session =3D cryptodev_vhost_user_sym_create_session;
> > +    bc->close_session =3D cryptodev_vhost_user_sym_close_session;
> > +    bc->do_sym_op =3D cryptodev_vhost_user_sym_operation;
> > +}
> > +
> > +static const TypeInfo cryptodev_vhost_user_info =3D {
> > +    .name =3D TYPE_CRYPTODEV_BACKEND_VHOST_USER,
> > +    .parent =3D TYPE_CRYPTODEV_BACKEND,
> > +    .class_init =3D cryptodev_vhost_user_class_init,
> > +    .instance_init =3D cryptodev_vhost_user_instance_int,
> > +    .instance_finalize =3D cryptodev_vhost_user_finalize,
> > +    .instance_size =3D sizeof(CryptoDevBackendVhostUser),
> > +};
> > +
> > +static void
> > +cryptodev_vhost_user_register_types(void)
> > +{
> > +    type_register_static(&cryptodev_vhost_user_info);
> > +}
> > +
> > +type_init(cryptodev_vhost_user_register_types);
> > diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
> > new file mode 100644 index 0000000..2c7df3f
> > --- /dev/null
> > +++ b/backends/cryptodev-vhost.c
> > @@ -0,0 +1,73 @@
> > +/*
> > + * QEMU Cryptodev backend for QEMU cipher APIs
> > + *
> > + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > + *
> > + * Authors:
> > + *    Gonglei <arei.gonglei@huawei.com>
> > + *    Jay Zhou <jianjay.zhou@huawei.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> <http://www.gnu.org/licenses/>.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qmp/qerror.h"
> > +#include "sysemu/cryptodev-vhost.h"
> > +
> > +
> > +uint64_t
> > +cryptodev_vhost_get_max_queues(
> > +                        CryptoDevBackendVhost *crypto) {
> > +    return crypto->dev.max_queues;
> > +}
> > +
> > +void cryptodev_vhost_cleanup(CryptoDevBackendVhost *crypto) {
> > +    vhost_dev_cleanup(&crypto->dev);
> > +    g_free(crypto);
> > +}
> > +
> > +struct CryptoDevBackendVhost *
> > +cryptodev_vhost_init(
> > +             CryptoDevBackendVhostOptions *options) {
> > +    int r;
> > +    CryptoDevBackendVhost *crypto;
> > +
> > +    crypto =3D g_new(CryptoDevBackendVhost, 1);
> > +    crypto->dev.max_queues =3D 1;
> > +    crypto->dev.nvqs =3D 1;
> > +    crypto->dev.vqs =3D crypto->vqs;
> > +
> > +    crypto->cc =3D options->cc;
> > +
> > +    crypto->dev.protocol_features =3D 0;
> > +    crypto->backend =3D -1;
> > +
> > +    /* vhost-user needs vq_index to initiate a specific queue pair */
> > +    crypto->dev.vq_index =3D crypto->cc->queue_index *
> > + crypto->dev.nvqs;
> > +
> > +    r =3D vhost_dev_init(&crypto->dev, options->opaque, options-
> >backend_type, 0);
> > +    if (r < 0) {
> > +        goto fail;
> > +    }
> > +
> > +    return crypto;
> > +fail:
> > +    g_free(crypto);
> > +    return NULL;
> > +}
> > diff --git a/include/sysemu/cryptodev-vhost.h
> > b/include/sysemu/cryptodev-vhost.h
> > new file mode 100644
> > index 0000000..fb26b86
> > --- /dev/null
> > +++ b/include/sysemu/cryptodev-vhost.h
> > @@ -0,0 +1,154 @@
> > +/*
> > + * QEMU Crypto Device Common Vhost Implement
> > + *
> > + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> > + *
> > + * Authors:
> > + *    Gonglei <arei.gonglei@huawei.com>
> > + *    Jay Zhou <jianjay.zhou@huawei.com>
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> <http://www.gnu.org/licenses/>.
> > + *
> > + */
> > +#ifndef CRYPTODEV_VHOST_H
> > +#define CRYPTODEV_VHOST_H
> > +
> > +#include "qemu-common.h"
> > +#include "hw/virtio/vhost.h"
> > +#include "hw/virtio/vhost-backend.h"
> > +#include "chardev/char.h"
> > +
> > +#include "sysemu/cryptodev.h"
> > +
> > +
> > +typedef struct CryptoDevBackendVhostOptions {
> > +    VhostBackendType backend_type;
> > +    void *opaque;
> > +    int total_queues;
> > +    CryptoDevBackendClient *cc;
> > +} CryptoDevBackendVhostOptions;
> > +
> > +typedef struct CryptoDevBackendVhost {
> > +    struct vhost_dev dev;
> > +    struct vhost_virtqueue vqs[1];
> > +    int backend;
> > +    CryptoDevBackendClient *cc;
> > +} CryptoDevBackendVhost;
> > +
> > +/**
> > + * cryptodev_vhost_get_max_queues:
> > + * @crypto: the cryptodev backend common vhost object
> > + *
> > + * Get the maximum queue number of @crypto.
> > + *
> > + *
> > + * Returns: the maximum queue number
> > + */
> > +uint64_t
> > +cryptodev_vhost_get_max_queues(
> > +                        CryptoDevBackendVhost *crypto);
> > +
> > +
> > +/**
> > + * cryptodev_vhost_init:
> > + * @options: the common vhost object's option
> > + *
> > + * Creates a new cryptodev backend common vhost object
> > + *
> > + ** The returned object must be released with
> > + * cryptodev_vhost_cleanup() when no
> > + * longer required
> > + *
> > + * Returns: the cryptodev backend common vhost object  */ struct
> > +CryptoDevBackendVhost * cryptodev_vhost_init(
> > +             CryptoDevBackendVhostOptions *options);
> > +
> > +/**
> > + * cryptodev_vhost_cleanup:
> > + * @crypto: the cryptodev backend common vhost object
> > + *
> > + * Clean the resouce associated with @crypto that realizaed
> > + * by cryptodev_vhost_init()
> > + *
> > + */
> > +void cryptodev_vhost_cleanup(
> > +                        CryptoDevBackendVhost *crypto);
> > +
> > +/**
> > + * cryptodev_get_vhost:
> > + * @cc: the client object for each queue
> > + * @b: the cryptodev backend common vhost object
> > + * @queue: the cryptodev backend queue index
> > + *
> > + * Gets a new cryptodev backend common vhost object based on
> > + * @b and @queue
> > + *
> > + * Returns: the cryptodev backend common vhost object  */
> > +CryptoDevBackendVhost * cryptodev_get_vhost(CryptoDevBackendClient
> > +*cc,
> > +                            CryptoDevBackend *b,
> > +                            uint16_t queue);
> > +/**
> > + * cryptodev_vhost_start:
> > + * @dev: the virtio crypto object
> > + * @total_queues: the total count of queue
> > + *
> > + * Starts the vhost crypto logic
> > + *
> > + * Returns: 0 for success, negative for errors  */ int
> > +cryptodev_vhost_start(VirtIODevice *dev, int total_queues);
> > +
> > +/**
> > + * cryptodev_vhost_stop:
> > + * @dev: the virtio crypto object
> > + * @total_queues: the total count of queue
> > + *
> > + * Stops the vhost crypto logic
> > + *
> > + */
> > +void cryptodev_vhost_stop(VirtIODevice *dev, int total_queues);
> > +
> > +/**
> > + * cryptodev_vhost_virtqueue_mask:
> > + * @dev: the virtio crypto object
> > + * @queue: the cryptodev backend queue index
> > + * @idx: the virtqueue index
> > + * @mask: mask or not (true or false)
> > + *
> > + * Mask/unmask events for @idx virtqueue on @dev device
> > + *
> > + */
> > +void cryptodev_vhost_virtqueue_mask(VirtIODevice *dev,
> > +                                           int queue,
> > +                                           int idx, bool mask);
> > +
> > +/**
> > + * cryptodev_vhost_virtqueue_pending:
> > + * @dev: the virtio crypto object
> > + * @queue: the cryptodev backend queue index
> > + * @idx: the virtqueue index
> > + *
> > + * Test and clear event pending status for @idx virtqueue on @dev devi=
ce.
> > + * Should be called after unmask to avoid losing events.
> > + *
> > + * Returns: true for success, false for errors  */ bool
> > +cryptodev_vhost_virtqueue_pending(VirtIODevice *dev,
> > +                                              int queue, int idx);
> > +
> > +#endif /* CRYPTODEV_VHOST_H */
> > diff --git a/qemu-options.hx b/qemu-options.hx index 678181c..97db5bc
> > 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4170,6 +4170,27 @@ which specify the queue number of cryptodev back=
end,
> the default of
> >     [...]
> >  @end example
> >
> > +@item -object
> > +cryptodev-vhost-user,id=3D@var{id},chardev=3D@var{chardevid}[,queues=
=3D@var
> > +{queues}]
> > +
> > +Creates a vhost-user cryptodev backend, backed by a chardev
> @var{chardevid}.
> > +The @var{id} parameter is a unique ID that will be used to reference
> > +this cryptodev backend from the @option{virtio-crypto} device.
> > +The chardev should be a unix domain socket backed one. The vhost-user
> > +uses a specifically defined protocol to pass vhost ioctl replacement
> > +messages to an application on the other end of the socket.
> > +The @var{queues} parameter is optional, which specify the queue
> > +number of cryptodev backend for multiqueue vhost-user, the default of
> @var{queues} is 1.
> > +
> > +@example
> > +
> > + # qemu-system-x86_64 \
> > +   [...] \
> > +       -chardev socket,id=3Dchardev0,path=3D/path/to/socket \
> > +       -object cryptodev-vhost-user,id=3Dcryptodev0,chardev=3Dchardev0=
 \
> > +       -device virtio-crypto-pci,id=3Dcrypto0,cryptodev=3Dcryptodev0 \
> > +   [...]
> > +@end example
> > +
> >  @item -object
> > secret,id=3D@var{id},data=3D@var{string},format=3D@var{raw|base64}[,key=
id=3D@v
> > ar{secretid},iv=3D@var{string}]  @item -object
> > secret,id=3D@var{id},file=3D@var{filename},format=3D@var{raw|base64}[,k=
eyid=3D
> > @var{secretid},iv=3D@var{string}]
> >
> > diff --git a/vl.c b/vl.c
> > index f1c52fe..3e9d86f 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2867,6 +2867,10 @@ static bool object_create_initial(const char *ty=
pe)
> >          return false;
> >      }
> >
> > +    if (g_str_equal(type, "cryptodev-vhost-user")) {
> > +        return false;
> > +    }
> > +
> >      /*
> >       * return false for concrete netfilters since
> >       * they depend on netdevs already existing
> > --
> > 1.8.3.1
> >
