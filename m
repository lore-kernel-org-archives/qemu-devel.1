Received: from eggs.gnu.org ([2001:4830:134:3::10]:51023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elmqY-00088r-8m
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1elmqU-0007iT-9r
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:30:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2257 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1elmqT-0007ht-UP
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 21:30:54 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 14 Feb 2018 02:30:42 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB94B53@DGGEMM505-MBS.china.huawei.com>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<f50145f0696050167fbfde1656a687d42954f258.1516538887.git.arei.gonglei@huawei.com>
	<20180213183154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180213183154-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v6 1/4] cryptodev: add vhost-user as a new
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, February 14, 2018 12:46 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; stefanha@redhat.com; pasic@linux.vnet.ibm.com=
;
> longpeng <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.=
com;
> Gonglei (Arei) <arei.gonglei@huawei.com>; wangxin (U)
> <wangxinxin.wang@huawei.com>
> Subject: Re: [PATCH v6 1/4] cryptodev: add vhost-user as a new cryptodev
> backend
>=20
> On Sun, Jan 21, 2018 at 08:54:47PM +0800, Jay Zhou wrote:
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
>=20
> This test is problematic: clang build triggers an error:
> > /home/petmay01/linaro/qemu-for-merges/backends/cryptodev-vhost-user.c:8=
6:16:
> > error: address of array 's->vhost_crypto' will always evaluate to
> > 'true' [-Werror,-Wpointer-bool-conversion]
> >         if (s->vhost_crypto) {
> >         ~~  ~~~^~~~~~~~~~~~

This line should be

            if (s->vhost_crypto[i]) {
>=20
> I really don't see how this could do the right thing, which makes me susp=
ect
> that either you did not test stop, or you always have all queues enabled.
>=20
> Pls test a config with some queues disabled.
>=20
> In particular this machinery needs some unit tests to catch errors like t=
his.

Okay, will do more tests, sorry about that.

Regards,
Jay

>=20
>=20
> --
> MST
