Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dvMzv-0001QI-4D
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dvMzr-0000Yc-U5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:23:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dvMzr-0000Xp-Nz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:23:55 -0400
Date: Fri, 22 Sep 2017 14:23:49 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170922122349.ealia3zmrll3fj7j@localhost.localdomain>
References: <20170922080435.27342-1-jfreimann@redhat.com>
	<bef3e3f3-e5a6-5e00-64d8-211b89d396b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bef3e3f3-e5a6-5e00-64d8-211b89d396b4@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, maozy.fnst@cn.fujitsu.com

On Fri, Sep 22, 2017 at 08:32:47AM +0000, Jason Wang wrote:
>
>
>On 2017???09???22??? 16:04, Jens Freimann wrote:
>>Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
>>we allow more than one parameter for -netdev socket. But now
>>we run into an assert when no parameter at all is specified
>>
>>>qemu-system-x86_64 -netdev socket
>>socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.
>>
>>Change the check and error message to reflect that at least
>>one of the options has to be specified. An example for when we need
>>more than on is when we hand in a UDP socket. Then we have fd= and udp=
>>as parameters.
>>
>>Cc: Jason Wang <jasowang@redhat.com>
>>Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
>>Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>---
>>  net/socket.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/net/socket.c b/net/socket.c
>>index e6b471c63d..0a987bcf4f 100644
>>--- a/net/socket.c
>>+++ b/net/socket.c
>>@@ -695,9 +695,9 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>      assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
>>      sock = &netdev->u.socket;
>>-    if (sock->has_listen + sock->has_connect + sock->has_mcast +
>>-        sock->has_udp > 1) {
>>-        error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
>>+    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
>>+        sock->has_udp == 0) {
>>+        error_setg(errp, "at least one of fd=, listen=, connect=, mcast= or udp="
>>                     " is required");
>>          return -1;
>>      }
>
>Looks like this allows "listen" and "connect" to be used in the same 
>time which is wrong I think?

I think connect would be silently dropped because netdev_sock_init()
returns after the listen part is set up. 

There would be no warning/error message though, which is not nice. I
can add a check to prevent that listen and connect at the same time.


regards,
Jens 
