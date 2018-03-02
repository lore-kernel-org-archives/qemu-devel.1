Received: from eggs.gnu.org ([2001:4830:134:3::10]:44647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ereDH-0005h7-TR
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ereDE-00084y-Iy
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:30:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ereDE-00084O-CX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 01:30:36 -0500
References: <1517921624-14756-1-git-send-email-jianjay.zhou@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f7db96ba-8c02-d26e-3b75-56a81c0e3c47@redhat.com>
Date: Fri, 2 Mar 2018 14:30:29 +0800
MIME-Version: 1.0
In-Reply-To: <1517921624-14756-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] tap: setting error appropriately when
 calling net_init_tap_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org
Cc: weidong.huang@huawei.com, mst@redhat.com, arei.gonglei@huawei.com, imammedo@redhat.com, wangxinxin.wang@huawei.com



On 2018=E5=B9=B402=E6=9C=8806=E6=97=A5 20:53, Jay Zhou wrote:
> If netdev_add tap,id=3Dnet0,...,vhost=3Don failed in net_init_tap_one()=
,
> the followed up device_add virtio-net-pci,netdev=3Dnet0 will fail
> too, prints:
>
>     TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
>     ioctl() failed: Bad file descriptor
>
> The reason is that the fd of tap is closed when error occured after
> calling net_init_tap_one().
>
> The fd should be closed when calling net_init_tap_one failed:
>     - if tap_set_sndbuf() failed
>     - if tap_set_sndbuf() succeeded but vhost failed to open or
>       initialize with vhostforce flag on
> The fd should not be closed just because vhost failed to open or
> initialize but without vhostforce flag. So the followed up
> device_add can fall back to userspace virtio successfully.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
> v4: - reduce duplication
>      - close the fd by caller
>      - tweak the title
>
> v3: - set errp appropriately
> ---
>   include/net/vhost_net.h |  3 +++
>   net/tap.c               | 24 ++++++++++++++++++------
>   2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
> index afc1499..77e4739 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -4,6 +4,9 @@
>   #include "net/net.h"
>   #include "hw/virtio/vhost-backend.h"
>  =20
> +#define VHOST_NET_INIT_FAILED \
> +    "vhost-net requested but could not be initialized"
> +
>   struct vhost_net;
>   typedef struct vhost_net VHostNetState;
>  =20
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..14d230f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -686,14 +686,23 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>           if (vhostfdname) {
>               vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err);
>               if (vhostfd =3D=3D -1) {
> -                error_propagate(errp, err);
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_propagate(errp, err);
> +                } else {
> +                    warn_report_err(err);
> +                }
>                   return;
>               }
>           } else {
>               vhostfd =3D open("/dev/vhost-net", O_RDWR);
>               if (vhostfd < 0) {
> -                error_setg_errno(errp, errno,
> -                                 "tap: open vhost char device failed")=
;
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_setg_errno(errp, errno,
> +                                     "tap: open vhost char device fail=
ed");
> +                } else {
> +                    warn_report("tap: open vhost char device failed: %=
s",
> +                                strerror(errno));
> +                }
>                   return;
>               }
>               fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> @@ -702,12 +711,15 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>  =20
>           s->vhost_net =3D vhost_net_init(&options);
>           if (!s->vhost_net) {
> -            error_setg(errp,
> -                       "vhost-net requested but could not be initializ=
ed");
> +            if (tap->has_vhostforce && tap->vhostforce) {
> +                error_setg(errp, VHOST_NET_INIT_FAILED);
> +            } else {
> +                warn_report(VHOST_NET_INIT_FAILED);
> +            }
>               return;
>           }
>       } else if (vhostfdname) {
> -        error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> +        warn_report("vhostfd(s)=3D is not valid without vhost");

Do we need to keep the error here consider it was a wrong command line=20
parameter?

Thanks

>       }
>   }
>  =20
