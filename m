Received: from eggs.gnu.org ([2001:4830:134:3::10]:55545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3TE-0007eq-5R
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3TD-0006ta-Dl
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 30 May 2018 17:56:39 +0200
Message-Id: <20180530155647.14090-10-kwolf@redhat.com>
In-Reply-To: <20180530155647.14090-1-kwolf@redhat.com>
References: <20180530155647.14090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/17] qemu-iotests: Add VM.run_job()
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

Add an iotests.py function that runs a job and only returns when it is
destroyed. An error is logged when the job failed and job-finalize and
job-dismiss commands are issued if necessary.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/iotests.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index edcd2bb701..8b612cb891 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -418,6 +418,25 @@ class VM(qtest.QEMUQtestMachine):
         log(str(result), filters)
         return result
 
+    def run_job(self, job, auto_finalize=True, auto_dismiss=False):
+        while True:
+            for ev in self.get_qmp_events_filtered(wait=True):
+                if ev['event'] == 'JOB_STATUS_CHANGE':
+                    status = ev['data']['status']
+                    if status == 'aborting':
+                        result = self.qmp('query-jobs')
+                        for j in result['return']:
+                            if j['id'] == job:
+                                log('Job failed: %s' % (j['error']))
+                    elif status == 'pending' and not auto_finalize:
+                        self.qmp_log('job-finalize', id=job)
+                    elif status == 'concluded' and not auto_dismiss:
+                        self.qmp_log('job-dismiss', id=job)
+                    elif status == 'null':
+                        return
+                else:
+                    iotests.log(ev)
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.13.6
