Received: from eggs.gnu.org ([2001:4830:134:3::10]:33825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dxE6w-0000MX-Me
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dxE6q-0005Ta-Im
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dxE6q-0005QE-9q
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:18:48 -0400
Date: Wed, 27 Sep 2017 17:18:41 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170927151841.y67de64eqbcmwye5@dhcp-192-218.str.redhat.com>
References: <20170926125952.7601-1-jfreimann@redhat.com>
	<bf8065b4-e61b-7fea-9798-37aaabc73bce@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf8065b4-e61b-7fea-9798-37aaabc73bce@cn.fujitsu.com>
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

On Tue, Sep 26, 2017 at 02:38:33PM +0000, Mao Zhongyi wrote:
>
>Hi, Jens
>
>
>On 09/26/2017 08:59 PM, Jens Freimann wrote:
>>Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
>>we allow more than one parameter for -netdev socket. But now
>>we run into an assert when no parameter at all is specified
>>
>>>qemu-system-x86_64 -net socket
>>socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.
>>
>>Change the check and error message to reflect that at least
>>one of the options has to be specified. An example for when we need
>>more than on is when we hand in a UDP socket. Then we have fd= and udp=
>
>s/on/one
>
>>as parameters.
>>
>>Cc: Jason Wang <jasowang@redhat.com>
>>Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
>>Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>>---
>>v1->v2:
>>- add check to prevent listen= and connect= being used at the same time
>>
>> net/socket.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>>diff --git a/net/socket.c b/net/socket.c
>>index e6b471c63d..74a2eff2e0 100644
>>--- a/net/socket.c
>>+++ b/net/socket.c
>>@@ -695,13 +695,18 @@ int net_init_socket(const Netdev *netdev, const char *name,
>>     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
>>     sock = &netdev->u.socket;
>>
>>-    if (sock->has_listen + sock->has_connect + sock->has_mcast +
>>-        sock->has_udp > 1) {
>>-        error_setg(errp, "exactly one of listen=, connect=, mcast= or udp="
>>+    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
>>+        sock->has_udp == 0) {
>>+        error_setg(errp, "at least one of fd=, listen=, connect=, mcast= or udp="
>>                    " is required");
>>         return -1;
>>     }
>
>Looks like this allow "listen" and "mcast" can be used at the same time?
>I'm not sure.
>
>the original:
>if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
>    sock->has_udp != 1)
>
>It means that only one of these elements can be used to a QEmu instance at
>the same time, i.e these elements are mutually exclusive. After this patch,
>are some cases missing?
>
>It's just my personal understanding, please judge. :)

Looking at this again and re-testing with the (not yet applied) pxe
test for vhost-user bridge, I think we can just revert this check back
to != 1. More than one parameters is not needed. 

I'll send a patch with only this change.

Thanks for the review!

regards,
Jens 
