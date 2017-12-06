Received: from eggs.gnu.org ([2001:4830:134:3::10]:49536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCV-0000lO-Hg
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCS-0000lX-7J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50258
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCR-0000ke-Vb
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:44 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JE9Qm024373
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:43 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epm4y6tuj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:43 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 14:17:42 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:30 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-38-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/55] net/socket: fix coverity issue
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

This fixes coverity issue CID1005339.

Make sure that saddr is not used uninitialized if the
mcast parameter is NULL.

Cc: qemu-stable@nongnu.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit bb160b571fe469b03228d4502c75a18045978a74)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index 18af2ab5f3..6664a75aa4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -369,7 +369,7 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
     net_socket_read_poll(s, true);
 
     /* mcast: save bound address as dst */
-    if (is_connected) {
+    if (is_connected && mcast != NULL) {
         s->dgram_dst = saddr;
         snprintf(nc->info_str, sizeof(nc->info_str),
                  "socket: fd=%d (cloned mcast=%s:%d)",
-- 
2.11.0
