Received: from eggs.gnu.org ([2001:4830:134:3::10]:38869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fOCpC-0003oM-8W
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fOCp8-0003FP-D4
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:56:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fOCp8-0003EM-7K
	for qemu-devel@nongnu.org; Wed, 30 May 2018 21:56:18 -0400
References: <1527688331-9044-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4f60effa-ada2-9940-f844-ec9be7a18596@redhat.com>
Date: Thu, 31 May 2018 09:56:11 +0800
MIME-Version: 1.0
In-Reply-To: <1527688331-9044-1-git-send-email-wangyunjian@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tap: fix memory leak on success to create
 a tap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>, qemu-devel@nongnu.org
Cc: caihe@huawei.com



On 2018=E5=B9=B405=E6=9C=8830=E6=97=A5 21:52, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---

Looks good, but please add some commit log and cc qemu-stable with Fixes=20
tags.

Thanks

>   net/tap.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index de05f20..6d7710f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -803,7 +803,8 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>       } else if (tap->has_fds) {
>           char **fds;
>           char **vhost_fds;
> -        int nfds, nvhosts;
> +        int nfds =3D 0, nvhosts =3D 0;
> +        int ret =3D 0;
>  =20
>           if (tap->has_ifname || tap->has_script || tap->has_downscript=
 ||
>               tap->has_vnet_hdr || tap->has_helper || tap->has_queues |=
|
> @@ -823,6 +824,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               if (nfds !=3D nvhosts) {
>                   error_setg(errp, "The number of fds passed does not m=
atch "
>                              "the number of vhostfds passed");
> +                ret =3D -1;
>                   goto free_fail;
>               }
>           }
> @@ -831,6 +833,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               fd =3D monitor_fd_param(cur_mon, fds[i], &err);
>               if (fd =3D=3D -1) {
>                   error_propagate(errp, err);
> +                ret =3D -1;
>                   goto free_fail;
>               }
>  =20
> @@ -841,6 +844,7 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               } else if (vnet_hdr !=3D tap_probe_vnet_hdr(fd)) {
>                   error_setg(errp,
>                              "vnet_hdr not consistent across given tap =
fds");
> +                ret =3D -1;
>                   goto free_fail;
>               }
>  =20
> @@ -850,21 +854,21 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
>                                vnet_hdr, fd, &err);
>               if (err) {
>                   error_propagate(errp, err);
> +                ret =3D -1;
>                   goto free_fail;
>               }
>           }
> -        g_free(fds);
> -        g_free(vhost_fds);
> -        return 0;
>  =20
>   free_fail:
> +        for (i =3D 0; i < nvhosts; i++) {
> +            g_free(vhost_fds[i]);
> +        }
>           for (i =3D 0; i < nfds; i++) {
>               g_free(fds[i]);
> -            g_free(vhost_fds[i]);
>           }
>           g_free(fds);
>           g_free(vhost_fds);
> -        return -1;
> +        return ret;
>       } else if (tap->has_helper) {
>           if (tap->has_ifname || tap->has_script || tap->has_downscript=
 ||
>               tap->has_vnet_hdr || tap->has_queues || tap->has_vhostfds=
) {
