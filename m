Received: from eggs.gnu.org ([2001:4830:134:3::10]:59029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eizYd-0007Le-PE
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eizYT-0004lo-T3
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eizYT-0004iV-KC
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:28:45 -0500
References: <1517565055-14588-1-git-send-email-jianjay.zhou@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6228a861-c224-c326-6052-985bca0c8b33@redhat.com>
Date: Tue, 6 Feb 2018 17:28:36 +0800
MIME-Version: 1.0
In-Reply-To: <1517565055-14588-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tap: close fd conditionally when error
 occured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com



On 2018=E5=B9=B402=E6=9C=8802=E6=97=A5 17:50, Jay Zhou wrote:
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
>   net/tap.c | 44 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..c46ab14 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -651,7 +651,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>       tap_set_sndbuf(s->fd, tap, &err);
>       if (err) {
>           error_propagate(errp, err);
> -        return;
> +        goto error;
>       }
>  =20
>       if (tap->has_fd || tap->has_fds) {
> @@ -686,15 +686,26 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>           if (vhostfdname) {
>               vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err);
>               if (vhostfd =3D=3D -1) {
> -                error_propagate(errp, err);
> -                return;
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_propagate(errp, err);
> +                    goto error;
> +                } else {
> +                    warn_report_err(err);
> +                    return;
> +                }
>               }
>           } else {
>               vhostfd =3D open("/dev/vhost-net", O_RDWR);
>               if (vhostfd < 0) {
> -                error_setg_errno(errp, errno,
> -                                 "tap: open vhost char device failed")=
;
> -                return;
> +                if (tap->has_vhostforce && tap->vhostforce) {
> +                    error_setg_errno(errp, errno,
> +                                     "tap: open vhost char device fail=
ed");
> +                    goto error;
> +                } else {
> +                    warn_report("tap: open vhost char device failed: %=
s",
> +                                strerror(errno));
> +                    return;
> +                }
>               }
>               fcntl(vhostfd, F_SETFL, O_NONBLOCK);
>           }
> @@ -702,12 +713,23 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>  =20
>           s->vhost_net =3D vhost_net_init(&options);
>           if (!s->vhost_net) {
> -            error_setg(errp,
> -                       "vhost-net requested but could not be initializ=
ed");
> -            return;
> +            if (tap->has_vhostforce && tap->vhostforce) {
> +                error_setg(errp,
> +                           "vhost-net requested but could not be initi=
alized");
> +                goto error;
> +            } else {
> +                warn_report("vhost-net requested but could not be init=
ialized");
> +                return;
> +            }

Can we reduce the duplication by doing such in a common error label?

>           }
>       } else if (vhostfdname) {
> -        error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> +        warn_report("vhostfd(s)=3D is not valid without vhost");
> +        return;
> +    }
> +
> +error:
> +    if (!tap->has_fd && !tap->has_fds) {
> +        close(fd);

I believe you can do this in the caller by setting errp appropriately=20
(e.g don't set it when we only need a warn).

Thanks

>       }
>   }
>  =20
> @@ -877,7 +899,6 @@ free_fail:
>                            vnet_hdr, fd, &err);
>           if (err) {
>               error_propagate(errp, err);
> -            close(fd);
>               return -1;
>           }
>       } else {
> @@ -916,7 +937,6 @@ free_fail:
>                                vhostfdname, vnet_hdr, fd, &err);
>               if (err) {
>                   error_propagate(errp, err);
> -                close(fd);
>                   return -1;
>               }
>           }
