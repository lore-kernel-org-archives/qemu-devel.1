Received: from eggs.gnu.org ([2001:4830:134:3::10]:45306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6l-0004QY-Lh
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6h-000803-JW
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:43 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:48 -0500
Message-Id: <20181220022952.20493-8-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 07/11] iotests: add qmp recursive sorting
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
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

Python before 3.6 does not sort dictionaries (including kwargs).
Therefore, printing QMP objects involves sorting the keys to have
a predictable ordering in the iotests output.

However, if we want to pretty-print QMP objects being sent to the
QEMU process, we need to build the entire command before logging it.
Ordinarily, this would then involve "arguments" being sorted above
"execute", which would necessitate a rather ugly and harder-to-read
change to many iotests outputs.

To facilitate pretty-printing AND maintaining predictable output AND
having "arguments" sort before "execute", add a custom sort function
that takes a dictionary and recursively builds an OrderedDict that
maintains the specific key order we wish to see in iotests output.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9595429fea..565eebb1ab 100644
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
+    for k, v in sorted(kwargs.items()):
+        if isinstance(v, dict):
+            od[k] = ordered_kwargs(v)
+        else:
+            od[k] = v
+    return od
+
 def qemu_img_create(*args):
     args = list(args)
 
@@ -257,8 +268,10 @@ def filter_img_info(output, filename):
 def log(msg, filters=[]):
     for flt in filters:
         msg = flt(msg)
-    if type(msg) is dict or type(msg) is list:
-        print(json.dumps(msg, sort_keys=True))
+    if isinstance(msg, dict) or isinstance(msg, list):
+        # Don't sort if it's already sorted
+        do_sort = not isinstance(msg, OrderedDict)
+        print(json.dumps(msg, sort_keys=do_sort))
     else:
         print(msg)
 
@@ -448,8 +461,11 @@ class VM(qtest.QEMUQtestMachine):
         return result
 
     def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
-        logmsg = '{"execute": "%s", "arguments": %s}' % \
-            (cmd, json.dumps(kwargs, sort_keys=True))
+        full_cmd = OrderedDict((
+            ("execute", cmd),
+            ("arguments", ordered_kwargs(kwargs))
+        ))
+        logmsg = json.dumps(full_cmd)
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
         log(json.dumps(result, sort_keys=True), filters)
-- 
2.17.2
