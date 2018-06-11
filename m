Received: from eggs.gnu.org ([2001:4830:134:3::10]:53319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNme-0004ow-2Y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmd-0001wH-9l
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:00 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:04 +0200
Message-Id: <20180611142611.6609-23-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 22/29] iotests: improve pause_job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

It's possible, that job was finished during waiting. In this case we
will see error message "Timeout waiting for job to pause" which is not
very informative. So, let's check during waiting iteration that the job
exists.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180601115923.17159-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 0b204dc220..2f22fab2a7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -590,9 +590,14 @@ class QMPTestCase(unittest.TestCase):
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
2.17.1
