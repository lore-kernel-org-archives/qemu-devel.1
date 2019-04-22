Received: from eggs.gnu.org ([209.51.188.92]:56280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hIPD9-0002Ws-VU
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 23:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hIP2G-0007nI-Do
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 22:50:25 -0400
References: <20190416184624.15397-1-dan.streetman@canonical.com>
	<20190416184624.15397-2-dan.streetman@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9f3dac2a-15fe-8463-6aee-f6916b8d5e1c@redhat.com>
Date: Mon, 22 Apr 2019 10:50:15 +0800
MIME-Version: 1.0
In-Reply-To: <20190416184624.15397-2-dan.streetman@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] add VirtIONet vhost_stopped flag to
 prevent multiple stops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Streetman <dan.streetman@canonical.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org


On 2019/4/17 =E4=B8=8A=E5=8D=882:46, Dan Streetman wrote:
> From: Dan Streetman <ddstreet@canonical.com>
>
> Buglink: https://launchpad.net/bugs/1823458
>
> There is a race condition when using the vhost-user driver, between a g=
uest
> shutdown and the vhost-user interface being closed.  This is explained =
in
> more detail at the bug link above; the short explanation is the vhost-u=
ser
> device can be closed while the main thread is in the middle of stopping
> the vhost_net.  In this case, the main thread handling shutdown will
> enter virtio_net_vhost_status() and move into the n->vhost_started (els=
e)
> block, and call vhost_net_stop(); while it is running that function,
> another thread is notified that the vhost-user device has been closed,
> and (indirectly) calls into virtio_net_vhost_status() also.


I think we need figure out why there are multiple vhost_net_stop() calls=20
simultaneously. E.g vhost-user register fd handlers like:

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_chr_fe_set_handlers(&s->=
chr, NULL, NULL,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net_vhost_user_event, NULL,=
 nc0->name,=20
NULL,
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true);

which uses default main context, so it should only be called only in=20
main thread.

Thanks


>   Since the
> vhost_net status hasn't yet changed, the second thread also enters
> the n->vhost_started block, and also calls vhost_net_stop().  This
> causes problems for the second thread when it tries to stop the network
> that's already been stopped.
>
> This adds a flag to the struct that's atomically set to prevent more th=
an
> one thread from calling vhost_net_stop().  The atomic_fetch_inc() is li=
kely
> overkill and probably could be done with a simple check-and-set, but
> since it's a race condition there would still be a (very, very) small
> window without using an atomic to set it.
>
> Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> ---
>   hw/net/virtio-net.c            | 3 ++-
>   include/hw/virtio/virtio-net.h | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index ffe0872fff..d36f50d5dd 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -13,6 +13,7 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/iov.h"
> +#include "qemu/atomic.h"
>   #include "hw/virtio/virtio.h"
>   #include "net/net.h"
>   #include "net/checksum.h"
> @@ -240,7 +241,7 @@ static void virtio_net_vhost_status(VirtIONet *n, u=
int8_t status)
>                            "falling back on userspace virtio", -r);
>               n->vhost_started =3D 0;
>           }
> -    } else {
> +    } else if (atomic_fetch_inc(&n->vhost_stopped) =3D=3D 0) {
>           vhost_net_stop(vdev, n->nic->ncs, queues);
>           n->vhost_started =3D 0;
>       }
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> index b96f0c643f..d03fd933d0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -164,6 +164,7 @@ struct VirtIONet {
>       uint8_t nouni;
>       uint8_t nobcast;
>       uint8_t vhost_started;
> +    int vhost_stopped;
>       struct {
>           uint32_t in_use;
>           uint32_t first_multi;
