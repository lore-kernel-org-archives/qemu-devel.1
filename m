Received: from eggs.gnu.org ([2001:4830:134:3::10]:46602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLq6-0001Sh-UQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLq3-0008NR-OD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:20:26 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fDLq3-0008NH-IS
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 23:20:23 -0400
Received: by mail-qt0-x241.google.com with SMTP id h2-v6so13406414qtp.7
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 20:20:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525073205-22394-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e9c443a6-fe73-6816-8e01-54e87ed913e4@amsat.org>
Date: Tue, 1 May 2018 00:20:10 -0300
MIME-Version: 1.0
In-Reply-To: <1525073205-22394-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net: Fix memory leak in net_param_nic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 04/30/2018 04:26 AM, Thomas Huth wrote:
> The early exits in case of errors leak the memory allocated for nd_id.
> Fix it by using a "goto out" to the cleanup at the end of the function
> instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  net/net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/net.c b/net/net.c
> index 29f8398..65457b7 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1502,11 +1502,12 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
>          g_free(mac);
>          if (ret) {
>              error_setg(errp, "invalid syntax for ethernet address");
> -            return -1;
> +            goto out;
>          }
>          if (is_multicast_ether_addr(ni->macaddr.a)) {
>              error_setg(errp, "NIC cannot have multicast MAC address");
> -            return -1;
> +            ret = -1;
> +            goto out;
>          }
>      }
>      qemu_macaddr_default_if_unset(&ni->macaddr);
> @@ -1518,6 +1519,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
>          nb_nics++;
>      }
>  
> +out:
>      g_free(nd_id);
>      return ret;
>  }
> 
