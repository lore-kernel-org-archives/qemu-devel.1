Received: from eggs.gnu.org ([2001:4830:134:3::10]:43265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2W-000061-4q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2V-0004SG-0t
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:48 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Dec 2018 20:52:26 -0500
Message-Id: <20181219015230.18652-2-jsnow@redhat.com>
In-Reply-To: <20181219015230.18652-1-jsnow@redhat.com>
References: <20181219015230.18652-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/5] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Python before 3.6 does not sort kwargs by default.
If we want to print out pretty-printed QMP objects while
preserving the "exec" > "arguments" ordering, we need a custom sort.

We can accomplish this by sorting **kwargs into an OrderedDict,
which does preserve addition order.
---
 tests/qemu-iotests/iotests.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9595429fea..9aec03c7a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -30,6 +30,7 @@ import signal
 import logging
 import atexit
 import io
+from collections import OrderedDict
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
 import qtest
@@ -75,6 +76,16 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
 
+def ordered_kwargs(kwargs):
+    # kwargs prior to 3.6 are not ordered, so:
+    od = OrderedDict()
+    for k in sorted(kwargs.keys()):
+        if isinstance(kwargs[k], dict):
+            od[k] = ordered_kwargs(kwargs[k])
+        else:
+            od[k] = kwargs[k]
+    return od
+
 def qemu_img_create(*args):
     args = list(args)
 
@@ -257,8 +268,9 @@ def filter_img_info(output, filename):
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-    if type(msg) is dict or type(msg) is list:
-        print(json.dumps(msg, sort_keys=True))
+    if isinstance(msg, dict) or isinstance(msg, list):
+        sort_keys = not isinstance(msg, OrderedDict)
+        print(json.dumps(msg, sort_keys=sort_keys))
     else:
         print(msg)
 
@@ -448,8 +460,9 @@ class VM(qtest.QEMUQtestMachine):
         return result
 
     def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
-        logmsg = '{"execute": "%s", "arguments": %s}' % \
-            (cmd, json.dumps(kwargs, sort_keys=True))
+        full_cmd = OrderedDict({"execute": cmd,
+                                "arguments": ordered_kwargs(kwargs)})
+        logmsg = json.dumps(full_cmd)
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
         log(json.dumps(result, sort_keys=True), filters)
-- 
2.17.2
