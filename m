Received: from eggs.gnu.org ([2001:4830:134:3::10]:53919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fDhNo-0003vB-Ar
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fDhNl-0008EG-5X
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:20:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fDhNk-0008Cu-Vs
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:20:37 -0400
References: <1525073205-22394-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <344c0609-0fed-2fe1-1415-24b09e7731f9@redhat.com>
Date: Wed, 2 May 2018 10:20:21 +0800
MIME-Version: 1.0
In-Reply-To: <1525073205-22394-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Fix memory leak in net_param_nic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>



On 2018=E5=B9=B404=E6=9C=8830=E6=97=A5 15:26, Thomas Huth wrote:
> The early exits in case of errors leak the memory allocated for nd_id.
> Fix it by using a "goto out" to the cleanup at the end of the function
> instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/net.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/net.c b/net/net.c
> index 29f8398..65457b7 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1502,11 +1502,12 @@ static int net_param_nic(void *dummy, QemuOpts =
*opts, Error **errp)
>           g_free(mac);
>           if (ret) {
>               error_setg(errp, "invalid syntax for ethernet address");
> -            return -1;
> +            goto out;
>           }
>           if (is_multicast_ether_addr(ni->macaddr.a)) {
>               error_setg(errp, "NIC cannot have multicast MAC address")=
;
> -            return -1;
> +            ret =3D -1;
> +            goto out;
>           }
>       }
>       qemu_macaddr_default_if_unset(&ni->macaddr);
> @@ -1518,6 +1519,7 @@ static int net_param_nic(void *dummy, QemuOpts *o=
pts, Error **errp)
>           nb_nics++;
>       }
>  =20
> +out:
>       g_free(nd_id);
>       return ret;
>   }

Applied, thanks.
