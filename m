Received: from eggs.gnu.org ([209.51.188.92]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44X-0001K0-3X
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44V-0003Nc-8d
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44U-0003AO-Sa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1r12122331
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:01:56 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8phq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:01:55 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:46 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:52 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-19-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 18/97] mirror: Fail gracefully for source ==
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>

From: Kevin Wolf <kwolf@redhat.com>

blockdev-mirror with the same node for source and target segfaults
today: A node is in its own backing chain, so mirror_start_job() decides
that this is an active commit. When adding the intermediate nodes with
block_job_add_bdrv(), it starts the iteration through the subchain with
the backing file of source, though, so it never reaches target and
instead runs into NULL at the base.

While we could fix that by starting with source itself, there is no
point in allowing mirroring a node into itself and I wouldn't be
surprised if this caused more problems later.

So just check for this scenario and error out.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 86fae10c64d642256cf019e6829929fa0d259c7a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/mirror.c             | 5 +++++
 tests/qemu-iotests/041     | 6 ++++++
 tests/qemu-iotests/041.out | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b48c3f8cf5..dd5ca02b09 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1499,6 +1499,11 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
+    if (bs == target) {
+        error_setg(errp, "Can't mirror node into itself");
+        return;
+    }
+
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes, and make
      * the backing chain writable. */
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index c20ac7da87..9336ab6ff5 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -234,6 +234,12 @@ class TestSingleBlockdev(TestSingleDrive):
         result = self.vm.qmp("blockdev-add", **args)
         self.assert_qmp(result, 'return', {})
 
+    def test_mirror_to_self(self):
+        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
+                             device=self.qmp_target, sync='full',
+                             target=self.qmp_target)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
     test_large_cluster = None
     test_image_not_found = None
     test_small_buffer2 = None
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index c28b392b87..e071d0b261 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.....................................................................................
+........................................................................................
 ----------------------------------------------------------------------
-Ran 85 tests
+Ran 88 tests
 
 OK
-- 
2.17.1
