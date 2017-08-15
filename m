Received: from eggs.gnu.org ([2001:4830:134:3::10]:58226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhbXO-0006V3-KX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhbXK-0005MW-7S
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:05:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 15 Aug 2017 14:05:02 +0100
Message-Id: <20170815130502.8736-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] qemu-iotests: step clock after each
 test iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The 093 throttling test submits twice as many requests as the throttle
limit in order to ensure that we reach the limit.  The remaining
requests are left in-flight at the end of each test iteration.

Commit 452589b6b47e8dc6353df257fc803dfc1383bed8 ("vl.c/exit: pause cpus
before closing block devices") exposed a hang in 093.  This happens
because requests are still in flight when QEMU terminates but
QEMU_CLOCK_VIRTUAL time is frozen.  bdrv_drain_all() hangs forever since
throttled requests cannot complete.

Step the clock at the end of each test iteration so in-flight requests
actually finish.  This solves the hang and is cleaner than leaving tests
in-flight.

Note that this could also be "fixed" by disabling throttling when drives
are closed in QEMU.  That approach has two issues:

1. We must drain requests before disabling throttling, so the hang
   cannot be easily avoided!

2. Any time QEMU disables throttling internally there is a chance that
   malicious users can abuse the code path to bypass throttling limits.

Therefore it makes more sense to fix the test case than to modify QEMU.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/093 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 2ed393a548..ef3997206b 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -133,6 +133,10 @@ class ThrottleTestCase(iotests.QMPTestCase):
             self.assertTrue(check_limit(params['iops_rd'], rd_iops))
             self.assertTrue(check_limit(params['iops_wr'], wr_iops))
 
+        # Allow remaining requests to finish.  We submitted twice as many to
+        # ensure the throttle limit is reached.
+        self.vm.qtest("clock_step %d" % ns)
+
     # Connect N drives to a VM and test I/O in all of them
     def test_all(self):
         params = {"bps": 4096,
-- 
2.13.4
