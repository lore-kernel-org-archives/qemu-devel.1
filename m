Received: from eggs.gnu.org ([2001:4830:134:3::10]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0mw-0000JK-Oi
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:58:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ea0ms-0001iA-Se
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:58:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ea0ms-0001hK-NW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:58:30 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 12 Jan 2018 15:56:55 +0100
Message-Id: <20180112145658.17121-2-maxime.coquelin@redhat.com>
In-Reply-To: <20180112145658.17121-1-maxime.coquelin@redhat.com>
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] vhost-user: fix multiple queue
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

The number of queues supported by the slave is queried with
message VHOST_USER_GET_QUEUE_NUM, not with message
VHOST_USER_GET_PROTOCOL_FEATURES.

Also, looking at master and slave implemntations, the payload
returned by the slave is the number of queue pairs supported
by the slave, not the number of queues.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 docs/interop/vhost-user.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index d49444e037..8a14191a1e 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -214,8 +214,8 @@ Multiple queue is treated as a protocol extension, hence the slave has to
 implement protocol features first. The multiple queues feature is supported
 only when the protocol feature VHOST_USER_PROTOCOL_F_MQ (bit 0) is set.
 
-The max number of queues the slave supports can be queried with message
-VHOST_USER_GET_PROTOCOL_FEATURES. Master should stop when the number of
+The max number of queue pairs the slave supports can be queried with message
+VHOST_USER_GET_QUEUE_NUM. Master should stop when the number of
 requested queues is bigger than that.
 
 As all queues share one connection, the master uses a unique index for each
@@ -537,7 +537,7 @@ Master message types
       Master payload: N/A
       Slave payload: u64
 
-      Query how many queues the backend supports. This request should be
+      Query how many queue pairs the backend supports. This request should be
       sent only when VHOST_USER_PROTOCOL_F_MQ is set in queried protocol
       features by VHOST_USER_GET_PROTOCOL_FEATURES.
 
-- 
2.14.3
