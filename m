Received: from eggs.gnu.org ([2001:4830:134:3::10]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldir-00025B-HZ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldio-0001Iy-EW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:46:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56164 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eldio-0001Hq-8N
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:46:22 -0500
Date: Tue, 13 Feb 2018 18:46:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180213183154-mutt-send-email-mst@kernel.org>
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<f50145f0696050167fbfde1656a687d42954f258.1516538887.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f50145f0696050167fbfde1656a687d42954f258.1516538887.git.arei.gonglei@huawei.com>
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
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

On Sun, Jan 21, 2018 at 08:54:47PM +0800, Jay Zhou wrote:
> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
> new file mode 100644
> index 0000000..4e63ece
> --- /dev/null
> +++ b/backends/cryptodev-vhost-user.c
> @@ -0,0 +1,333 @@
> +/*
> + * QEMU Cryptodev backend for QEMU cipher APIs
> + *
> + * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + * Authors:
> + *    Gonglei <arei.gonglei@huawei.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/boards.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qemu/error-report.h"
> +#include "standard-headers/linux/virtio_crypto.h"
> +#include "sysemu/cryptodev-vhost.h"
> +#include "chardev/char-fe.h"
> +
> +
> +/**
> + * @TYPE_CRYPTODEV_BACKEND_VHOST_USER:
> + * name of backend that uses vhost user server
> + */
> +#define TYPE_CRYPTODEV_BACKEND_VHOST_USER "cryptodev-vhost-user"
> +
> +#define CRYPTODEV_BACKEND_VHOST_USER(obj) \
> +    OBJECT_CHECK(CryptoDevBackendVhostUser, \
> +                 (obj), TYPE_CRYPTODEV_BACKEND_VHOST_USER)
> +
> +
> +typedef struct CryptoDevBackendVhostUser {
> +    CryptoDevBackend parent_obj;
> +
> +    CharBackend chr;
> +    char *chr_name;
> +    bool opened;
> +    CryptoDevBackendVhost *vhost_crypto[MAX_CRYPTO_QUEUE_NUM];
> +} CryptoDevBackendVhostUser;
> +
> +static int
> +cryptodev_vhost_user_running(
> +             CryptoDevBackendVhost *crypto)
> +{
> +    return crypto ? 1 : 0;
> +}
> +
> +static void cryptodev_vhost_user_stop(int queues,
> +                          CryptoDevBackendVhostUser *s)
> +{
> +    size_t i;
> +
> +    for (i = 0; i < queues; i++) {
> +        if (!cryptodev_vhost_user_running(s->vhost_crypto[i])) {
> +            continue;
> +        }
> +
> +        if (s->vhost_crypto) {
> +            cryptodev_vhost_cleanup(s->vhost_crypto[i]);
> +            s->vhost_crypto[i] = NULL;
> +        }
> +    }
> +}

This test is problematic: clang build triggers an error:
> /home/petmay01/linaro/qemu-for-merges/backends/cryptodev-vhost-user.c:86:16:
> error: address of array 's->vhost_crypto' will always evaluate to
> 'true' [-Werror,-Wpointer-bool-conversion]
>         if (s->vhost_crypto) {
>         ~~  ~~~^~~~~~~~~~~~

I really don't see how this could do the right thing, which
makes me suspect that either you did not test stop, or
you always have all queues enabled.

Pls test a config with some queues disabled.

In particular this machinery needs some unit tests
to catch errors like this.


-- 
MST
