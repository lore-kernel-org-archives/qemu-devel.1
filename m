Received: from eggs.gnu.org ([2001:4830:134:3::10]:37174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEwz-0004mF-U2
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEww-0001LE-QD
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  2 Aug 2018 17:50:25 +0300
Message-Id: <8fb28f638bd31f509d0db800c3fd8e9874ef2caa.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 3/4] qemu-iotests: Update 093 to improve the
 draining test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The previous patch fixes a problem in which draining a block device
with more than one throttled request can make it wait first for the
completion of requests in other members of the same group.

This patch updates test_remove_group_member() in iotest 093 to
reproduce that scenario. This updated test would hang QEMU without the
fix from the previous patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/093 | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index b26cd34e32..9d1971a56c 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -225,15 +225,18 @@ class ThrottleTestCase(iotests.QMPTestCase):
         # Read 4KB from drive0. This is performed immediately.
         self.vm.hmp_qemu_io("drive0", "aio_read 0 4096")
 
-        # Read 4KB again. The I/O limit has been exceeded so this
+        # Read 2KB. The I/O limit has been exceeded so this
         # request is throttled and a timer is set to wake it up.
-        self.vm.hmp_qemu_io("drive0", "aio_read 0 4096")
+        self.vm.hmp_qemu_io("drive0", "aio_read 0 2048")
 
-        # Read from drive1. We're still over the I/O limit so this
-        # request is also throttled. There's no timer set in drive1
-        # because there's already one in drive0. Once the timer in
-        # drive0 fires and its throttled request is processed then the
-        # next request in the queue will be scheduled: this one.
+        # Read 2KB again. We're still over the I/O limit so this is
+        # request is also throttled, but no new timer is set since
+        # there's already one.
+        self.vm.hmp_qemu_io("drive0", "aio_read 0 2048")
+
+        # Read from drive1. This request is also throttled, and no
+        # timer is set in drive1 because there's already one in
+        # drive0.
         self.vm.hmp_qemu_io("drive1", "aio_read 0 4096")
 
         # At this point only the first 4KB have been read from drive0.
@@ -248,7 +251,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
         self.assert_qmp(result, 'return', {})
 
-        # Removing the I/O limits from drive0 drains its pending request.
+        # Removing the I/O limits from drive0 drains its two pending requests.
         # The read request in drive1 is still throttled.
         self.assertEqual(self.blockstats('drive0')[0], 8192)
         self.assertEqual(self.blockstats('drive1')[0], 0)
-- 
2.11.0
