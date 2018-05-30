Received: from eggs.gnu.org ([2001:4830:134:3::10]:55498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3TA-0007aE-Fp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fO3T9-0006s8-Nd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:57:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 30 May 2018 17:56:37 +0200
Message-Id: <20180530155647.14090-8-kwolf@redhat.com>
In-Reply-To: <20180530155647.14090-1-kwolf@redhat.com>
References: <20180530155647.14090-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 07/17] qemu-iotests: Add VM.qmp_log()
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

This adds a helper function that logs both the QMP request and the
received response before returning it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 17aa7c88dc..2f54823db6 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -206,6 +206,10 @@ def filter_qmp_event(event):
         event['timestamp']['microseconds'] = 'USECS'
     return event
 
+def filter_testfiles(msg):
+    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
+    return msg.replace(prefix, 'TEST_DIR/PID-')
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
@@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
+    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
+        log(logmsg, filters)
+        result = self.qmp(cmd, **kwargs)
+        log(str(result), filters)
+        return result
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.13.6
