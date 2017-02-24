Received: from eggs.gnu.org ([2001:4830:134:3::10]:49976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQs-0006PR-7g
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1chKQr-0002nI-Hh
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 13:17:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 24 Feb 2017 19:16:59 +0100
Message-Id: <1487960230-18054-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
References: <1487960230-18054-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/19] iotests: Fix another race in 030
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

From: John Snow <jsnow@redhat.com>

We can't rely on a non-paused job to be present and running for us.
Assume that if the job is not present that it completed already.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/030 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 54db54a..0d472d5 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -547,11 +547,14 @@ class TestEIO(TestErrors):
         while not completed:
             for event in self.vm.get_qmp_events(wait=True):
                 if event['event'] == 'BLOCK_JOB_ERROR':
+                    error = True
                     self.assert_qmp(event, 'data/device', 'drive0')
                     self.assert_qmp(event, 'data/operation', 'read')
                     result = self.vm.qmp('query-block-jobs')
+                    if result == {'return': []}:
+                        # Job finished too quickly
+                        continue
                     self.assert_qmp(result, 'return[0]/paused', False)
-                    error = True
                 elif event['event'] == 'BLOCK_JOB_COMPLETED':
                     self.assertTrue(error, 'job completed unexpectedly')
                     self.assert_qmp(event, 'data/type', 'stream')
-- 
1.8.3.1
