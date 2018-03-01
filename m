Received: from eggs.gnu.org ([2001:4830:134:3::10]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1erDEr-0003wj-QJ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1erDEo-0000tR-Bz
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:42:29 -0500
Received: from [45.249.212.255] (port=54076 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1erDEn-0000nl-W3
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 20:42:26 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Thu, 1 Mar 2018 01:42:10 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473ABB5102@DGGEMM505-MBS.china.huawei.com>
References: <1517921624-14756-1-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1517921624-14756-1-git-send-email-jianjay.zhou@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Ping ...

> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Tuesday, February 06, 2018 8:54 PM
> To: qemu-devel@nongnu.org
> Cc: jasowang@redhat.com; mst@redhat.com; imammedo@redhat.com; Huangweidon=
g (C)
> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gon=
glei
> (Arei) <arei.gonglei@huawei.com>; Zhoujian (jay) <jianjay.zhou@huawei.com=
>
> Subject: [PATCH v4] tap: setting error appropriately when calling
> net_init_tap_one()
>=20
> If netdev_add tap,id=3Dnet0,...,vhost=3Don failed in net_init_tap_one(), =
the
> followed up device_add virtio-net-pci,netdev=3Dnet0 will fail too, prints=
:
>=20
>    TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
>    ioctl() failed: Bad file descriptor
>=20
> The reason is that the fd of tap is closed when error occured after calli=
ng
> net_init_tap_one().
>=20
> The fd should be closed when calling net_init_tap_one failed:
>    - if tap_set_sndbuf() failed
>    - if tap_set_sndbuf() succeeded but vhost failed to open or
>      initialize with vhostforce flag on
> The fd should not be closed just because vhost failed to open or initiali=
ze
> but without vhostforce flag. So the followed up device_add can fall back =
to
> userspace virtio successfully.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
> v4: - reduce duplication
>     - close the fd by caller
>     - tweak the title
>=20
> v3: - set errp appropriately
> ---
>  include/net/vhost_net.h |  3 +++
>  net/tap.c               | 24 ++++++++++++++++++------
>  2 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h index
> afc1499..77e4739 100644
> --- a/include/net/vhost_net.h
> +++ b/include/net/vhost_net.h
> @@ -4,6 +4,9 @@
>  #include "net/net.h"
>  #include "hw/virtio/vhost-backend.h"
>=20
> +#define VHOST_NET_INIT_FAILED \
> +    "vhost-net requested but could not be initialized"
> +
>  struct vhost_net;
>  typedef struct vhost_net VHostNetState;
>=20
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..14d230f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -686,14 +686,23 @@ static void net_init_tap_one(const NetdevTapOptions
> *tap, NetClientState *peer,
>          if (vhostfdname) {
>              vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err);
>              if (vhostfd =3D=3D -1) {
> -                error_propagate(errp, err);
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_propagate(errp, err);
> +                } else {
> +                    warn_report_err(err);
> +                }
>                  return;
>              }
>          } else {
>              vhostfd =3D open("/dev/vhost-net", O_RDWR);
>              if (vhostfd < 0) {
> -                error_setg_errno(errp, errno,
> -                                 "tap: open vhost char device failed");
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_setg_errno(errp, errno,
> +                                     "tap: open vhost char device failed=
");
> +                } else {
> +                    warn_report("tap: open vhost char device failed: %s"=
,
> +                                strerror(errno));
> +                }
>                  return;
>              }
>              fcntl(vhostfd, F_SETFL, O_NONBLOCK); @@ -702,12 +711,15 @@
> static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState
> *peer,
>=20
>          s->vhost_net =3D vhost_net_init(&options);
>          if (!s->vhost_net) {
> -            error_setg(errp,
> -                       "vhost-net requested but could not be initialized=
");
> +            if (tap->has_vhostforce && tap->vhostforce) {
> +                error_setg(errp, VHOST_NET_INIT_FAILED);
> +            } else {
> +                warn_report(VHOST_NET_INIT_FAILED);
> +            }
>              return;
>          }
>      } else if (vhostfdname) {
> -        error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> +        warn_report("vhostfd(s)=3D is not valid without vhost");
>      }
>  }
>=20
> --
> 1.8.3.1
>=20
