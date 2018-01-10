Received: from eggs.gnu.org ([2001:4830:134:3::10]:53601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZ7qB-0007Ra-DX
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eZ7q8-0003cA-87
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:18:15 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2366 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eZ7q7-0003Zi-KO
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:18:12 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 10 Jan 2018 04:18:01 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB32AAB@DGGEMM505-MBS.china.huawei.com>
References: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1515516013-16604-1-git-send-email-jianjay.zhou@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 2/4][RFC] tap: do not close fd if only
 vhost failed to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>, Jason Wang <jasowang@redhat.com>

Sorry about missing to cc Jason.


Close the fd of the tap unconditionally when netdev_add tap,id=3Dnet0,vhost=
=3Don failed
in net_init_tap_one() will make the followed up device_add virtio-net-pci,n=
etdev=3Dnet0
failed too, which prints:

    TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD=20
    ioctl() failed: Bad file descriptor

This patch makes the followed up device_add be able to fall back to userspa=
ce virtio
when netdev_add failed with vhost turning on but vhost force flag does not =
set.

Here is the original discussion:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05205.html


This is a RFC version, if I'm wrong, please let me know, thanks!

PS: there're two places updated, see below.


> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Wednesday, January 10, 2018 12:40 AM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; imammedo@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gon=
glei
> (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.=
com>;
> Zhoujian (jay) <jianjay.zhou@huawei.com>
> Subject: [PATCH v5 2/4][RFC] tap: do not close fd if only vhost failed to
> initialize
>=20
> Making the followed up device_add to fall back to userspace virtio when
> netdev_add fails if vhost force flag does not set.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  net/tap.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..03f226f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -642,7 +642,8 @@ static void net_init_tap_one(const NetdevTapOptions *=
tap,
> NetClientState *peer,
>                               const char *model, const char *name,
>                               const char *ifname, const char *script,
>                               const char *downscript, const char *vhostfd=
name,
> -                             int vnet_hdr, int fd, Error **errp)
> +                             int vnet_hdr, int fd, Error **errp,
> +                             bool *vhost_init_failed)
>  {
>      Error *err =3D NULL;
>      TAPState *s =3D net_tap_fd_init(peer, model, name, fd, vnet_hdr); @@=
 -
> 687,6 +688,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap,
> NetClientState *peer,
>              vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err);
>              if (vhostfd =3D=3D -1) {
>                  error_propagate(errp, err);
> +                *vhost_init_failed =3D true;
>                  return;
>              }
>          } else {
> @@ -694,6 +696,7 @@ static void net_init_tap_one(const NetdevTapOptions *=
tap,
> NetClientState *peer,
>              if (vhostfd < 0) {
>                  error_setg_errno(errp, errno,
>                                   "tap: open vhost char device failed");
> +                *vhost_init_failed =3D true;
>                  return;
>              }
>              fcntl(vhostfd, F_SETFL, O_NONBLOCK); @@ -704,6 +707,7 @@ sta=
tic
> void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>          if (!s->vhost_net) {
>              error_setg(errp,
>                         "vhost-net requested but could not be initialized=
");
> +            *vhost_init_failed =3D true;
>              return;
>          }
>      } else if (vhostfdname) {
> @@ -748,6 +752,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>      Error *err =3D NULL;
>      const char *vhostfdname;
>      char ifname[128];
> +    bool vhost_init_failed =3D false;
>=20
>      assert(netdev->type =3D=3D NET_CLIENT_DRIVER_TAP);
>      tap =3D &netdev->u.tap;
> @@ -783,7 +788,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>=20
>          net_init_tap_one(tap, peer, "tap", name, NULL,
>                           script, downscript,
> -                         vhostfdname, vnet_hdr, fd, &err);
> +                         vhostfdname, vnet_hdr, fd, &err,
> + &vhost_init_failed);
>          if (err) {
>              error_propagate(errp, err);
>              return -1;
> @@ -835,7 +840,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>              net_init_tap_one(tap, peer, "tap", name, ifname,
>                               script, downscript,
>                               tap->has_vhostfds ? vhost_fds[i] : NULL,
> -                             vnet_hdr, fd, &err);
> +                             vnet_hdr, fd, &err, &vhost_init_failed);
>              if (err) {
>                  error_propagate(errp, err);
>                  goto free_fail;
> @@ -874,10 +879,12 @@ free_fail:
>=20
>          net_init_tap_one(tap, peer, "bridge", name, ifname,
>                           script, downscript, vhostfdname,
> -                         vnet_hdr, fd, &err);
> +                         vnet_hdr, fd, &err, &vhost_init_failed);
>          if (err) {
>              error_propagate(errp, err);
> -            close(fd);
> +            if (tap->has_vhostforce && tap->vhostforce && vhost_init_fai=
led)
> {
> +                close(fd);
> +            }

This should be:
       =20
        if (!vhost_init_failed || (tap->has_vhostforce && tap->vhostforce))=
 {
            close(fd);
        }

>              return -1;
>          }
>      } else {
> @@ -913,10 +920,14 @@ free_fail:
>              net_init_tap_one(tap, peer, "tap", name, ifname,
>                               i >=3D 1 ? "no" : script,
>                               i >=3D 1 ? "no" : downscript,
> -                             vhostfdname, vnet_hdr, fd, &err);
> +                             vhostfdname, vnet_hdr, fd, &err,
> +                             &vhost_init_failed);
>              if (err) {
>                  error_propagate(errp, err);
> -                close(fd);
> +                if (tap->has_vhostforce && tap->vhostforce &&
> +                        vhost_init_failed) {
> +                    close(fd);
> +                }

Same here, this should be:

         if (!vhost_init_failed || (tap->has_vhostforce && tap->vhostforce)=
) {
             close(fd);
         }

>                  return -1;
>              }
>          }
> --
> 1.8.3.1
>=20
