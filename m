Received: from eggs.gnu.org ([2001:4830:134:3::10]:49539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT19W-00041M-HW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT19R-0005ie-Vv
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT19R-0005ht-N6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 03:24:37 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499250206.git.maozy.fnst@cn.fujitsu.com>
	<e1eb4e611b444bf3abeeb072e87fbd2fd291045d.1499250206.git.maozy.fnst@cn.fujitsu.com>
Date: Thu, 06 Jul 2017 09:24:34 +0200
In-Reply-To: <e1eb4e611b444bf3abeeb072e87fbd2fd291045d.1499250206.git.maozy.fnst@cn.fujitsu.com>
	(Mao Zhongyi's message of "Wed, 5 Jul 2017 19:01:57 +0800")
Message-ID: <877ezm9gel.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 4/4] net/socket: Improve -net socket
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> When -net socket fails, it first reports a specific error, then
> a generic one, like this:
>
>     $ qemu-system-x86_64 -net socket,
>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>     qemu-system-x86_64: -net socket: Device 'socket' could not be initialized
>
> Convert net_socket_*_init() to Error to get rid of the superfluous second
> error message. After the patch, the effect like this:
>
>     $ qemu-system-x86_64 -net socket,
>     qemu-system-x86_64: -net socket: exactly one of fd=, listen=, connect=, mcast= or udp= is required
>
> At the same time, add many explicit error handling message when it fails.

Suggest "This also fixes a few silent failures to report an error."

Perhaps Jason can touch this up for you.

> Cc: jasowang@redhat.com
> Cc: armbru@redhat.com
> Cc: berrange@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  net/socket.c | 92 +++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 44 insertions(+), 48 deletions(-)
>
> diff --git a/net/socket.c b/net/socket.c
> index 1d4c515..ca1878f 100644
> --- a/net/socket.c
> +++ b/net/socket.c
[...]
> @@ -746,7 +742,7 @@ int net_init_socket(const Netdev *netdev, const char *name,
>          /* if sock->localaddr is missing, it has been initialized to "all bits
>           * zero" */
>          if (net_socket_mcast_init(peer, "socket", name, sock->mcast,
> -            sock->localaddr) == -1) {
> +            sock->localaddr, errp) < 0) {

Indent like this:

                                     sock->localaddr, errp) < 0) {

Perhaps Jason can touch this up for you.

>              return -1;
>          }
>          return 0;
> @@ -754,11 +750,11 @@ int net_init_socket(const Netdev *netdev, const char *name,
>  
>      assert(sock->has_udp);
>      if (!sock->has_localaddr) {
> -        error_report("localaddr= is mandatory with udp=");
> +        error_setg(errp, "localaddr= is mandatory with udp=");
>          return -1;
>      }
> -    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr) ==
> -        -1) {
> +    if (net_socket_udp_init(peer, "socket", name, sock->udp, sock->localaddr,
> +        errp) < 0) {

Likewise.

>          return -1;
>      }
>      return 0;

With the indentation fixed:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
