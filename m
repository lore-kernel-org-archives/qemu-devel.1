Received: from eggs.gnu.org ([2001:4830:134:3::10]:45440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG8-0000qR-UP
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMG7-0006ML-Pc
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:42 +0200
Message-Id: <1496070414-6744-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/15] iotests: 147: Don't test inet6 if not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

This is the case in our docker tests, as we use --net=none there. Skip
this method.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/147 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 32afea6..db34838 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -147,6 +147,13 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self._server_down()
 
     def test_inet6(self):
+        try:
+            socket.getaddrinfo("::0", "0", socket.AF_INET6,
+                               socket.SOCK_STREAM, socket.IPPROTO_TCP,
+                               socket.AI_ADDRCONFIG | socket.AI_CANONNAME)
+        except socket.gaierror:
+            # IPv6 not available, skip
+            return
         address = { 'type': 'inet',
                     'data': {
                         'host': '::1',
-- 
1.8.3.1
