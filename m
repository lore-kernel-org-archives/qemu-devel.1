Received: from eggs.gnu.org ([2001:4830:134:3::10]:37077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eaz57-0007H9-Lc
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eaz52-0005dB-9h
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:21:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eaz52-0005cS-0H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:21:16 -0500
References: <1515742232-49096-1-git-send-email-jianjay.zhou@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2ec90e7e-0625-62c7-a5a8-3a8aee68114f@redhat.com>
Date: Mon, 15 Jan 2018 15:21:06 +0800
MIME-Version: 1.0
In-Reply-To: <1515742232-49096-1-git-send-email-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tap: close fd conditionally when error
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



On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 15:30, Jay Zhou wrote:
> If netdev_add tap,id=3Dnet0,vhost=3Don failed in net_init_tap_one(),
> the followed up device_add virtio-net-pci,netdev=3Dnet0 will fail
> too, prints:
>
>    TUNSETOFFLOAD ioctl() failed: Bad file descriptor TUNSETOFFLOAD
>    ioctl() failed: Bad file descriptor
>
> The reason is that the fd of tap is closed when error occured after
> calling net_init_tap_one().
>
> I think the fd should be closed in these two case:
>    1.tap_set_sndbuf() failed
>    2.tap_set_sndbuf() succeeded but vhost failed to initialize with
>      vhostforce flag on
> Meanwhile, the fd should not be closed just because vhost failed to
> initialize but without vhostforce flag. So the followed up device_add
> can fall back to userspace virtio successfully.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>   net/tap.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index 979e622..3ed72eb 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -651,6 +651,9 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>       tap_set_sndbuf(s->fd, tap, &err);
>       if (err) {
>           error_propagate(errp, err);
> +        if (!tap->has_fd && !tap->has_fds) {
> +            close(fd);
> +        }
>           return;
>       }
>  =20
> @@ -687,14 +690,14 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>               vhostfd =3D monitor_fd_param(cur_mon, vhostfdname, &err);
>               if (vhostfd =3D=3D -1) {
>                   error_propagate(errp, err);
> -                return;
> +                goto cleanup;
>               }
>           } else {
>               vhostfd =3D open("/dev/vhost-net", O_RDWR);
>               if (vhostfd < 0) {
>                   error_setg_errno(errp, errno,
>                                    "tap: open vhost char device failed"=
);
> -                return;
> +                goto cleanup;
>               }
>               fcntl(vhostfd, F_SETFL, O_NONBLOCK);
>           }
> @@ -704,11 +707,18 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
>           if (!s->vhost_net) {
>               error_setg(errp,
>                          "vhost-net requested but could not be initiali=
zed");

So error_setg() is not appropriate here consider it was not trated as an=20
error. We probably just need some warning.

> -            return;
> +            goto cleanup;
>           }
>       } else if (vhostfdname) {
>           error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
>       }
> +
> +cleanup:
> +    if (!tap->has_fd && !tap->has_fds && tap->has_vhostforce &&
> +        tap->vhostforce) {
> +        close(fd);

I would still let caller to decide whether or not to close the fd.

Thanks

> +    }
> +    return;
>   }
>  =20
>   static int get_fds(char *str, char *fds[], int max)
> @@ -877,7 +887,6 @@ free_fail:
>                            vnet_hdr, fd, &err);
>           if (err) {
>               error_propagate(errp, err);
> -            close(fd);
>               return -1;
>           }
>       } else {
> @@ -916,7 +925,6 @@ free_fail:
>                                vhostfdname, vnet_hdr, fd, &err);
>               if (err) {
>                   error_propagate(errp, err);
> -                close(fd);
>                   return -1;
>               }
>           }
