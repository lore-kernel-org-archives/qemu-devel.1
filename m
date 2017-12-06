Received: from eggs.gnu.org ([2001:4830:134:3::10]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCY-0000pH-Pp
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCS-0000mH-Mq
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCS-0000kR-8Y
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JGGP5047710
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:43 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epnw5sse7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:43 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:41 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:31 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-39-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/55] net: fix check for number of parameters
 to -netdev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jens Freimann <jfreimann@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Jens Freimann <jfreimann@redhat.com>

Since commit 0f8c289ad "net: fix -netdev socket,fd= for UDP sockets"
we allow more than one parameter for -netdev socket. But now
we run into an assert when no parameter at all is specified

> qemu-system-x86_64 -netdev socket
socket.c:729: net_init_socket: Assertion `sock->has_udp' failed.

Fix this by reverting the change of the if condition done in 0f8c289ad.

Cc: Jason Wang <jasowang@redhat.com>
Cc: qemu-stable@nongnu.org
Fixes: 0f8c289ad539feb5135c545bea947b310a893f4b
Reported-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit ff86d5762552787f1fcb7da695ec4f8c1be754b4)
 Conflicts:
	net/socket.c
* drop context dep on 0522a959
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6664a75aa4..95060e5ca2 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -674,8 +674,8 @@ int net_init_socket(const Netdev *netdev, const char *name,
     assert(netdev->type == NET_CLIENT_DRIVER_SOCKET);
     sock = &netdev->u.socket;
 
-    if (sock->has_listen + sock->has_connect + sock->has_mcast +
-        sock->has_udp > 1) {
+    if (sock->has_fd + sock->has_listen + sock->has_connect + sock->has_mcast +
+        sock->has_udp != 1) {
         error_report("exactly one of listen=, connect=, mcast= or udp="
                      " is required");
         return -1;
-- 
2.11.0
