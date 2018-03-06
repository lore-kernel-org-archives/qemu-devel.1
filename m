Received: from eggs.gnu.org ([2001:4830:134:3::10]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1et7lk-0007AI-57
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1et7lg-000368-WD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1et7lg-00034m-R5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:16:16 -0500
References: <20180306051125.32812-1-linzhecheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b0e44031-9d2f-6558-d839-1e2e7073fe9c@redhat.com>
Date: Tue, 6 Mar 2018 16:15:50 +0800
MIME-Version: 1.0
In-Reply-To: <20180306051125.32812-1-linzhecheng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tap: delete tap(net client) if
 net_init_tap_one failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, qemu-devel@nongnu.org
Cc: wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 2018=E5=B9=B403=E6=9C=8806=E6=97=A5 13:11, linzhecheng wrote:
> If net_init_tap_one failed but net_tap_fd_init succeeded, we should
> delete the TAPState *s without vhostforce and has_vhostforce flag.
>
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Applied and queued for stable.

Thanks

>
> diff --git a/net/tap.c b/net/tap.c
> index 2b3a36f9b5..1cb8eaf31f 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -651,7 +651,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>       tap_set_sndbuf(s->fd, tap, &err);
>       if (err) {
>           error_propagate(errp, err);
> -        return;
> +        goto fail;
>       }
>  =20
>       if (tap->has_fd || tap->has_fds) {
> @@ -688,6 +688,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>               if (vhostfd =3D=3D -1) {
>                   if (tap->has_vhostforce && tap->vhostforce) {
>                       error_propagate(errp, err);
> +                    goto fail;
>                   } else {
>                       warn_report_err(err);
>                   }
> @@ -699,6 +700,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>                   if (tap->has_vhostforce && tap->vhostforce) {
>                       error_setg_errno(errp, errno,
>                                        "tap: open vhost char device fai=
led");
> +                    goto fail;
>                   } else {
>                       warn_report("tap: open vhost char device failed: =
%s",
>                                   strerror(errno));
> @@ -713,6 +715,7 @@ static void net_init_tap_one(const NetdevTapOptions=
 *tap, NetClientState *peer,
>           if (!s->vhost_net) {
>               if (tap->has_vhostforce && tap->vhostforce) {
>                   error_setg(errp, VHOST_NET_INIT_FAILED);
> +                goto fail;
>               } else {
>                   warn_report(VHOST_NET_INIT_FAILED);
>               }
> @@ -720,7 +723,11 @@ static void net_init_tap_one(const NetdevTapOption=
s *tap, NetClientState *peer,
>           }
>       } else if (vhostfdname) {
>           error_setg(errp, "vhostfd(s)=3D is not valid without vhost");
> +        goto fail;
>       }
> +    return;
> +fail:
> +    qemu_del_net_client(&s->nc);
>   }
>  =20
>   static int get_fds(char *str, char *fds[], int max)
