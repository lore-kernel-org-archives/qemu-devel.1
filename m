Received: from eggs.gnu.org ([2001:4830:134:3::10]:42868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC6-0003eh-0B
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC2-0001RE-RL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59547
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC2-0001QV-Jw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jfF4079907
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:42 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm790nm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:41 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:41 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:37 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-44-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 43/67] net: fix sending of data with -net
 socket, listen backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The use of -net socket,listen was broken in the following
commit

  commit 16a3df403b10c4ac347159e39005fd520b2648bb
  Author: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
  Date:   Fri May 13 15:35:19 2016 +0800

    net/net: Add SocketReadState for reuse codes

    This function is from net/socket.c, move it to net.c and net.h.
    Add SocketReadState to make others reuse net_fill_rstate().
    suggestion from jason.

This refactored the state out of NetSocketState into a
separate SocketReadState. This refactoring requires
that a callback is provided to be triggered upon
completion of a packet receive from the guest.

The patch only registered this callback in the codepaths
hit by -net socket,connect, not -net socket,listen. So
as a result packets sent by the guest in the latter case
get dropped on the floor.

This bug is hidden because net_fill_rstate() silently
does nothing if the callback is not set.

This patch adds in the middle callback registration
and also adds an assert so that QEMU aborts if there
are any other codepaths hit which are missing the
callback.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit e79cd4068063ea2859199002a049010a11202939)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/net.c    | 5 ++---
 net/socket.c | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index d51cb29..19b4d9e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1648,9 +1648,8 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
             if (rs->index >= rs->packet_len) {
                 rs->index = 0;
                 rs->state = 0;
-                if (rs->finalize) {
-                    rs->finalize(rs);
-                }
+                assert(rs->finalize);
+                rs->finalize(rs);
             }
             break;
         }
diff --git a/net/socket.c b/net/socket.c
index 3f98eef..dcae1ae 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -522,6 +522,7 @@ static int net_socket_listen_init(NetClientState *peer,
     s->fd = -1;
     s->listen_fd = fd;
     s->nc.link_down = true;
+    net_socket_rs_init(&s->rs, net_socket_rs_finalize);
 
     qemu_set_fd_handler(s->listen_fd, net_socket_accept, NULL, s);
     return 0;
-- 
1.9.1
