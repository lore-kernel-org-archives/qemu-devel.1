Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eBhXN-000804-EO
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:34:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <darren.kenny@oracle.com>) id 1eBhXK-0007TK-4Y
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:34:01 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:29033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <darren.kenny@oracle.com>)
	id 1eBhXJ-0007Rq-Te
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:33:58 -0500
Date: Mon, 6 Nov 2017 13:33:49 +0000
From: Darren Kenny <darren.kenny@oracle.com>
Message-ID: <20171106133349.3ddquhwe72axdtjl@starbug-vm.ie.oracle.com>
References: <20171106132805.19986-1-jfreimann@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20171106132805.19986-1-jfreimann@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net/socket: fix coverity issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jens Freimann <jfreimann@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, jasowang@redhat.com

Hi Jan,

On Mon, Nov 06, 2017 at 02:28:05PM +0100, Jens Freimann wrote:
>This fixes coverity issue CID1005339.
>
>Make sure that saddr is not used uninitialized if the
>mcast parameter is NULL.
>
>Cc: qemu-stable@nongnu.org
>Reported-by: Peter Maydell <peter.maydell@linaro.org>
>Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>---
> net/socket.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/socket.c b/net/socket.c
>index e6b471c63d..51eaea67a0 100644
>--- a/net/socket.c
>+++ b/net/socket.c
>@@ -332,7 +332,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>                                                 const char *mcast,
>                                                 Error **errp)
> {
>-    struct sockaddr_in saddr;
>+    struct sockaddr_in saddr = { 0 };

Based on:

   https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04946.html

It would appear that the use of {} to initialize the struct is
preferred over {0}.

Thanks,

Darren.

>     int newfd;
>     NetClientState *nc;
>     NetSocketState *s;
>@@ -373,7 +373,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
>     net_socket_read_poll(s, true);
>
>     /* mcast: save bound address as dst */
>-    if (is_connected) {
>+    if (is_connected && mcast != NULL) {
>         s->dgram_dst = saddr;
>         snprintf(nc->info_str, sizeof(nc->info_str),
>                  "socket: fd=%d (cloned mcast=%s:%d)",
>-- 
>2.13.6
>
>
