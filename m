Received: from eggs.gnu.org ([2001:4830:134:3::10]:46202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRE7t-0003f3-Lp
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eRE7p-0007Ce-FB
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:23:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eRE7p-0007BV-7I
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 04:23:49 -0500
References: <1513148690-23440-1-git-send-email-jianjay.zhou@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <217eb906-023e-b3ff-8f65-1af84655ca25@redhat.com>
Date: Tue, 19 Dec 2017 17:23:34 +0800
MIME-Version: 1.0
In-Reply-To: <1513148690-23440-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vhost-user: quit infinite loop while
 used memslots is more than the backend limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, arei.gonglei@huawei.com, marcandre.lureau@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com



On 2017=E5=B9=B412=E6=9C=8813=E6=97=A5 15:04, Jay Zhou wrote:
> Steps to 100% reproduce:
> (1) start a VM with two VFIO 82599 PCI NICs successfully
> (2) hot plug a RAM, which is attached successfully
> (3) hot plug another RAM, which is attached successfully
> (4) hot plug a vhost-user NIC, which is attached successfully
> (5) hot plug another vhost-user NIC, which is hanged
>
> then the qemu process infinitely and quickly print the logs below:
>      [...]
>      vhost backend memory slots limit is less than current number of pr=
esent memory slots
>      failed to init vhost_net for queue 0
>      vhost backend memory slots limit is less than current number of pr=
esent memory slots
>      failed to init vhost_net for queue 0
>      vhost backend memory slots limit is less than current number of pr=
esent memory slots
>      failed to init vhost_net for queue 0
>      [...]
>
> and the cpu utilization of the systemd-journal process on host is 100%,
> the reason is clear:
>      "used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hde=
v)"
> is true in vhost_dev_init, and the main thread in the infinite do and
> while loop in net_vhost_user_init.
>
> One way is to increase the vhost backend memory slots limit, some
> discussions are here:
>      https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04572.htm=
l
>
> I think if
>      "used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hde=
v)"
> is true, it does not make sense to try to initialize the vhost-user aga=
in
> and again, because the main thread can not handle other qmps at all,
> which means it can not reduce the number of memslots, it must be failed
> at last.

You should include the reason why we hit infinite loop in the commit=20
log, and what's more important, is this issue specific to memslots only?=20
What if you hit errors other than this in vhost_dev_init() for=20
vhost-user? Is this better to disable event source in this case?

Thanks

>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>   hw/virtio/vhost.c         | 3 +++
>   include/hw/virtio/vhost.h | 2 ++
>   net/vhost-user.c          | 5 +++++
>   3 files changed, 10 insertions(+)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e4290ce..1cc4a18 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -47,6 +47,8 @@ static unsigned int used_memslots;
>   static QLIST_HEAD(, vhost_dev) vhost_devices =3D
>       QLIST_HEAD_INITIALIZER(vhost_devices);
>  =20
> +bool used_memslots_exceeded;
> +
>   bool vhost_has_free_slot(void)
>   {
>       unsigned int slots_limit =3D ~0U;
> @@ -1254,6 +1256,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *=
opaque,
>       if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit=
(hdev)) {
>           error_report("vhost backend memory slots limit is less"
>                   " than current number of present memory slots");
> +        used_memslots_exceeded =3D true;
>           r =3D -1;
>           goto fail;
>       }
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 467dc77..bcc66d9 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -6,6 +6,8 @@
>   #include "hw/virtio/virtio.h"
>   #include "exec/memory.h"
>  =20
> +extern bool used_memslots_exceeded;
> +
>   /* Generic structures common for any vhost based device. */
>   struct vhost_virtqueue {
>       int kick;
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index c23927c..8b7bfff 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -17,6 +17,7 @@
>   #include "qemu/error-report.h"
>   #include "qmp-commands.h"
>   #include "trace.h"
> +#include "include/hw/virtio/vhost.h"
>  =20
>   typedef struct VhostUserState {
>       NetClientState nc;
> @@ -311,6 +312,10 @@ static int net_vhost_user_init(NetClientState *pee=
r, const char *device,
>           qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>                                    net_vhost_user_event, NULL, nc0->nam=
e, NULL,
>                                    true);
> +        if (used_memslots_exceeded) {
> +            error_report("used memslots exceeded the backend limit, qu=
it loop");
> +            return -1;
> +        }
>       } while (!s->started);
>  =20
>       assert(s->vhost_net);
