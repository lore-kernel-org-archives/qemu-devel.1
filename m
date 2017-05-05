Received: from eggs.gnu.org ([2001:4830:134:3::10]:48875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6aN8-0000zU-6p
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6aN7-0008Tp-Bt
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:22:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 18:21:53 +0800
Message-Id: <20170505102153.758-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 147: Don't test inet6 if not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is the case in our docker tests, as we use --net=none there. Skip
this method.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.3
