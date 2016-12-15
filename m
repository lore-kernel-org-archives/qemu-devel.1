Received: from eggs.gnu.org ([2001:4830:134:3::10]:42731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC0-0003R4-QW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBx-0001Nc-Nk
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54530
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBx-0001NL-II
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hagv084789
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:37 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdme91b8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:36 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:36 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:32 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-39-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 38/67] qemu-iotests: Test I/O in a single drive
 from a throttling group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

From: Alberto Garcia <berto@igalia.com>

iotest 093 contains a test that creates a throttling group with
several drives and performs I/O in all of them. This patch adds a new
test that creates a similar setup but only performs I/O in one of the
drives at the same time.

This is useful to test that the round robin algorithm is behaving
properly in these scenarios, and is specifically written using the
regression introduced in 27ccdd52598290f0f8b58be56e as an example.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a26ddb43963e77aeebc2a4f011d27b2d9c017f21)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/093     | 33 ++++++++++++++++++++++++++++-----
 tests/qemu-iotests/093.out |  4 ++--
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index ffcb271..2ed393a 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -53,7 +53,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
             result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
             self.assert_qmp(result, 'return', {})
 
-    def do_test_throttle(self, ndrives, seconds, params):
+    def do_test_throttle(self, ndrives, seconds, params, first_drive = 0):
         def check_limit(limit, num):
             # IO throttling algorithm is discrete, allow 10% error so the test
             # is more robust
@@ -85,12 +85,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
         # Send I/O requests to all drives
         for i in range(rd_nr):
             for drive in range(0, ndrives):
-                self.vm.hmp_qemu_io("drive%d" % drive, "aio_read %d %d" %
+                idx = first_drive + drive
+                self.vm.hmp_qemu_io("drive%d" % idx, "aio_read %d %d" %
                                     (i * rq_size, rq_size))
 
         for i in range(wr_nr):
             for drive in range(0, ndrives):
-                self.vm.hmp_qemu_io("drive%d" % drive, "aio_write %d %d" %
+                idx = first_drive + drive
+                self.vm.hmp_qemu_io("drive%d" % idx, "aio_write %d %d" %
                                     (i * rq_size, rq_size))
 
         # We'll store the I/O stats for each drive in these arrays
@@ -105,15 +107,17 @@ class ThrottleTestCase(iotests.QMPTestCase):
 
         # Read the stats before advancing the clock
         for i in range(0, ndrives):
+            idx = first_drive + i
             start_rd_bytes[i], start_rd_iops[i], start_wr_bytes[i], \
-                start_wr_iops[i] = self.blockstats('drive%d' % i)
+                start_wr_iops[i] = self.blockstats('drive%d' % idx)
 
         self.vm.qtest("clock_step %d" % ns)
 
         # Read the stats after advancing the clock
         for i in range(0, ndrives):
+            idx = first_drive + i
             end_rd_bytes[i], end_rd_iops[i], end_wr_bytes[i], \
-                end_wr_iops[i] = self.blockstats('drive%d' % i)
+                end_wr_iops[i] = self.blockstats('drive%d' % idx)
 
         # Check that the I/O is within the limits and evenly distributed
         for i in range(0, ndrives):
@@ -129,6 +133,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
             self.assertTrue(check_limit(params['iops_rd'], rd_iops))
             self.assertTrue(check_limit(params['iops_wr'], wr_iops))
 
+    # Connect N drives to a VM and test I/O in all of them
     def test_all(self):
         params = {"bps": 4096,
                   "bps_rd": 4096,
@@ -146,6 +151,24 @@ class ThrottleTestCase(iotests.QMPTestCase):
                 self.configure_throttle(ndrives, limits)
                 self.do_test_throttle(ndrives, 5, limits)
 
+    # Connect N drives to a VM and test I/O in just one of them a time
+    def test_one(self):
+        params = {"bps": 4096,
+                  "bps_rd": 4096,
+                  "bps_wr": 4096,
+                  "iops": 10,
+                  "iops_rd": 10,
+                  "iops_wr": 10,
+                 }
+        # Repeat the test for each one of the drives
+        for drive in range(0, self.max_drives):
+            # Pick each out of all possible params and test
+            for tk in params:
+                limits = dict([(k, 0) for k in params])
+                limits[tk] = params[tk] * self.max_drives
+                self.configure_throttle(self.max_drives, limits)
+                self.do_test_throttle(1, 5, limits, drive)
+
     def test_burst(self):
         params = {"bps": 4096,
                   "bps_rd": 4096,
diff --git a/tests/qemu-iotests/093.out b/tests/qemu-iotests/093.out
index 914e373..2f7d390 100644
--- a/tests/qemu-iotests/093.out
+++ b/tests/qemu-iotests/093.out
@@ -1,5 +1,5 @@
-.....
+.......
 ----------------------------------------------------------------------
-Ran 5 tests
+Ran 7 tests
 
 OK
-- 
1.9.1
