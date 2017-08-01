Received: from eggs.gnu.org ([2001:4830:134:3::10]:54596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRc-0000Bw-ES
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dcYRb-0005PF-N4
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:46:48 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  1 Aug 2017 16:46:21 +0200
Message-Id: <20170801144632.3831-5-kwolf@redhat.com>
In-Reply-To: <20170801144632.3831-1-kwolf@redhat.com>
References: <20170801144632.3831-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] iotests: Check dirty bitmap statistics in
 124
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

We had a bug for multiple releases where dirty-bitmap count was
documented in bytes but reported in sectors; enhance the testsuite
to add coverage of DirtyBitmapInfo to ensure we do not regress again.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/124 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index d0d2c2bfb0..8e76e62f93 100644
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -336,7 +336,12 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                            (('0xab', 0, 512),
                             ('0xfe', '16M', '256k'),
                             ('0x64', '32736k', '64k')))
-
+        # Check the dirty bitmap stats
+        result = self.vm.qmp('query-block')
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/name', 'bitmap0')
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/count', 458752)
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/granularity', 65536)
+        self.assert_qmp(result, 'return[0]/dirty-bitmaps[0]/status', 'active')
 
         # Prepare a cluster_size=128k backup target without a backing file.
         (target, _) = bitmap0.new_target()
-- 
2.13.3
