Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fOiiU-0002Qs-5P
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fOiiP-0003i1-5M
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:59:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  1 Jun 2018 14:59:23 +0300
Message-Id: <20180601115923.17159-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] iotests: improve pause_job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

It's possible, that job was finished during waiting. In this case we
will see error message "Timeout waiting for job to pause" which is not
very informative. So, let's check during waiting iteration that the job
exists.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 28159d837a..fa16f7b4f0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -513,9 +513,14 @@ class QMPTestCase(unittest.TestCase):
         with Timeout(1, "Timeout waiting for job to pause"):
             while True:
                 result = self.vm.qmp('query-block-jobs')
+                found = False
                 for job in result['return']:
-                    if job['device'] == job_id and job['paused'] == True and job['busy'] == False:
-                        return job
+                    if job['device'] == job_id:
+                        found = True
+                        if job['paused'] == True and job['busy'] == False:
+                            return job
+                        break
+                assert found
 
     def pause_job(self, job_id='job0', wait=True):
         result = self.vm.qmp('block-job-pause', device=job_id)
-- 
2.11.1
