Received: from eggs.gnu.org ([2001:4830:134:3::10]:37170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEwz-0004mD-TI
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1flEww-0001LR-QE
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:51:37 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  2 Aug 2018 17:50:23 +0300
Message-Id: <7b219a0844e8eefdb170eaf3e670cdb65383361b.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
In-Reply-To: <cover.1533219143.git.berto@igalia.com>
References: <cover.1533219143.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 1/4] qemu-iotests: Test removing a throttle
 group member with a pending timer
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

A throttle group can have several members, and each one of them can
have several pending requests in the queue.

The requests are processed in a round-robin fashion, so the algorithm
decides the drive that is going to run the next request and sets a
timer in it. Once the timer fires and the throttled request is run
then the next drive from the group is selected and a new timer is set.

If the user tried to remove a drive from a group and that drive had a
timer set then the code was not taking care of setting up a new timer
in one of the remaining members of the group, freezing their I/O.

This problem was fixed in 6fccbb475bc6effc313ee9481726a1748b6dae57,
and this patch adds a new test case that reproduces this exact
scenario.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/093     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/093.out |  4 ++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 68e344f8c1..b26cd34e32 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -208,6 +208,58 @@ class ThrottleTestCase(iotests.QMPTestCase):
             limits[tk] = rate
             self.do_test_throttle(ndrives, 5, limits)
 
+    # Test that removing a drive from a throttle group should not
+    # affect the remaining members of the group.
+    # https://bugzilla.redhat.com/show_bug.cgi?id=1535914
+    def test_remove_group_member(self):
+        # Create a throttle group with two drives
+        # and set a 4 KB/s read limit.
+        params = {"bps": 0,
+                  "bps_rd": 4096,
+                  "bps_wr": 0,
+                  "iops": 0,
+                  "iops_rd": 0,
+                  "iops_wr": 0 }
+        self.configure_throttle(2, params)
+
+        # Read 4KB from drive0. This is performed immediately.
+        self.vm.hmp_qemu_io("drive0", "aio_read 0 4096")
+
+        # Read 4KB again. The I/O limit has been exceeded so this
+        # request is throttled and a timer is set to wake it up.
+        self.vm.hmp_qemu_io("drive0", "aio_read 0 4096")
+
+        # Read from drive1. We're still over the I/O limit so this
+        # request is also throttled. There's no timer set in drive1
+        # because there's already one in drive0. Once the timer in
+        # drive0 fires and its throttled request is processed then the
+        # next request in the queue will be scheduled: this one.
+        self.vm.hmp_qemu_io("drive1", "aio_read 0 4096")
+
+        # At this point only the first 4KB have been read from drive0.
+        # The other requests are throttled.
+        self.assertEqual(self.blockstats('drive0')[0], 4096)
+        self.assertEqual(self.blockstats('drive1')[0], 0)
+
+        # Remove drive0 from the throttle group and disable its I/O limits.
+        # drive1 remains in the group with a throttled request.
+        params['bps_rd'] = 0
+        params['device'] = 'drive0'
+        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
+        self.assert_qmp(result, 'return', {})
+
+        # Removing the I/O limits from drive0 drains its pending request.
+        # The read request in drive1 is still throttled.
+        self.assertEqual(self.blockstats('drive0')[0], 8192)
+        self.assertEqual(self.blockstats('drive1')[0], 0)
+
+        # Advance the clock 5 seconds. This completes the request in drive1
+        self.vm.qtest("clock_step %d" % (5 * nsec_per_sec))
+
+        # Now all requests have been processed.
+        self.assertEqual(self.blockstats('drive0')[0], 8192)
+        self.assertEqual(self.blockstats('drive1')[0], 4096)
+
 class ThrottleTestCoroutine(ThrottleTestCase):
     test_img = "null-co://"
 
diff --git a/tests/qemu-iotests/093.out b/tests/qemu-iotests/093.out
index 594c16f49f..36376bed87 100644
--- a/tests/qemu-iotests/093.out
+++ b/tests/qemu-iotests/093.out
@@ -1,5 +1,5 @@
-........
+..........
 ----------------------------------------------------------------------
-Ran 8 tests
+Ran 10 tests
 
 OK
-- 
2.11.0
