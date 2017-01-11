Received: from eggs.gnu.org ([2001:4830:134:3::10]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR9H0-0003qn-Bp
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cR9Gw-0000P9-Ch
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:08:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cR9Gw-0000OB-72
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 22:08:22 -0500
References: <1484076114-5594-1-git-send-email-peter.maydell@linaro.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c217fffb-36ac-9f3f-6b97-1a827fcc9a22@redhat.com>
Date: Wed, 11 Jan 2017 11:08:16 +0800
MIME-Version: 1.0
In-Reply-To: <1484076114-5594-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tap: fix memory leak on failure in
 net_init_tap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>



On 2017=E5=B9=B401=E6=9C=8811=E6=97=A5 03:21, Peter Maydell wrote:
> Commit 091a6b2ac fixed most of the memory leaks in failure
> paths in net_init_tap() reported by Coverity (CID 1356216),
> but missed one. Fix it by deferring the allocation of
> fds and vhost_fds until after the error check.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   net/tap.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index b6896a7..6248e85 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -788,8 +788,8 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               return -1;
>           }
>       } else if (tap->has_fds) {
> -        char **fds =3D g_new0(char *, MAX_TAP_QUEUES);
> -        char **vhost_fds =3D g_new0(char *, MAX_TAP_QUEUES);
> +        char **fds;
> +        char **vhost_fds;
>           int nfds, nvhosts;
>  =20
>           if (tap->has_ifname || tap->has_script || tap->has_downscript=
 ||
> @@ -801,6 +801,9 @@ int net_init_tap(const Netdev *netdev, const char *=
name,
>               return -1;
>           }
>  =20
> +        fds =3D g_new0(char *, MAX_TAP_QUEUES);
> +        vhost_fds =3D g_new0(char *, MAX_TAP_QUEUES);
> +
>           nfds =3D get_fds(tap->fds, fds, MAX_TAP_QUEUES);
>           if (tap->has_vhostfds) {
>               nvhosts =3D get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUE=
UES);

Applied to -net.

Thanks
