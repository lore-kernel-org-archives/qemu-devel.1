Received: from eggs.gnu.org ([2001:4830:134:3::10]:54400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfI-0000tm-T1
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fMFfI-0002qh-4l
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:34:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 25 May 2018 18:33:19 +0200
Message-Id: <20180525163327.23097-7-kwolf@redhat.com>
In-Reply-To: <20180525163327.23097-1-kwolf@redhat.com>
References: <20180525163327.23097-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 06/14] qemu-iotests: Add VM.qmp_log()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

This adds a helper function that logs both the QMP request and the
received response before returning it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 17aa7c88dc..319d898172 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -206,6 +206,10 @@ def filter_qmp_event(event):
         event['timestamp']['microseconds'] = 'USECS'
     return event
 
+def filter_testfiles(msg):
+    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
+    return msg.replace(prefix, 'TEST_DIR/')
+
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
@@ -389,6 +393,13 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
+    def qmp_log(self, cmd, **kwargs):
+        logmsg = "{'execute': '%s', 'arguments': %s}" % (cmd, kwargs)
+        log(filter_testfiles(logmsg))
+        result = self.qmp(cmd, **kwargs)
+        log(result)
+        return result
+
 
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
-- 
2.13.6
