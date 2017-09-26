Received: from eggs.gnu.org ([2001:4830:134:3::10]:39988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dwr36-00013f-IA
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:41:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dwr33-0008RX-Tm
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:41:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64460
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dwr33-0008NS-H6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:41:21 -0400
References: <20170926125952.7601-1-jfreimann@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <bf8065b4-e61b-7fea-9798-37aaabc73bce@cn.fujitsu.com>
Date: Tue, 26 Sep 2017 22:38:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170926125952.7601-1-jfreimann@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] net: fix check for number of parameters to
 -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com


Hi, Jens


On 09/26/2017 08:59 PM, Jens Freimann wrote:
> Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
> we allow more than one parameter for -netdev socket. But now
> we run into an assert when no parameter at all is specified
>
>> qemu-system-x86_64 -net socket
> socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.
>
> Change the check and error message to reflect that at least
> one of the options has to be specified. An example for when we need
> more than on is when we hand in a UDP socket. Then we have fd= and udp=

s/on/one

> as parameters.
>
> Cc: Jason Wang <jasowang@redhat.com>
> Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
> Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
> v1->v2:
> - add check to prevent listen= and connect= being used at the same time
>
>  net/socket.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index e6b471c63d..74a2eff2e0 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -695,13 +695,18 @@ int net_init_socket(const Netdev *netdev, const char *name,
>      assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
>      sock = &netdev->u.socket;
>
> -    if (sock->has_listen + sock->has_connect + sock->has_mcast +
> -        sock->has_udp > 1) {
> -        error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
> +    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
> +        sock->has_udp == 0) {
> +        error_setg(errp, "at least one of fd=, listen=, connect=, mcast= or udp="
>                     " is required");
>          return -1;
>      }

Looks like this allow "listen" and "mcast" can be used at the same time?
I'm not sure.

the original:
if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
     sock->has_udp != 1)

It means that only one of these elements can be used to a QEmu instance at
the same time, i.e these elements are mutually exclusive. After this patch,
are some cases missing?

It's just my personal understanding, please judge. :)

Thanks,
Mao


>
> +    if (sock->has_listen && sock->has_connect) {
> +        error_setg(errp, "listen= and connect= can't be used together");
> +        return -1;
> +    }
> +
>      if (sock->has_localaddr && !sock->has_mcast && !sock->has_udp) {
>          error_setg(errp, "localaddr= is only valid with mcast= or udp=");
>          return -1;
>
