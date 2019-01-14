Received: from eggs.gnu.org ([209.51.188.92]:57652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54W-0003p8-0l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54V-0005Og-5d
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:44 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:52 -0600
Message-Id: <20190114162605.5330-8-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/20] iotests: add qmp recursive sorting
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

Python before 3.6 does not sort dictionaries (including kwargs).
Therefore, printing QMP objects involves sorting the keys to have
a predictable ordering in the iotests output. This means that
iotests output will sometimes show arguments in an order not
specified by the test author.

Presently, we accomplish this by using json.dumps' sort_keys argument,
where we only serialize the arguments dictionary, but not the command.

However, if we want to pretty-print QMP objects being sent to the
QEMU process, we need to build the entire command before logging it.
Ordinarily, this would then involve "arguments" being sorted above
"execute", which would necessitate a rather ugly and harder-to-read
change to many iotests outputs.

To facilitate pretty-printing AND maintaining predictable output AND
having "arguments" sort after "execute", add a custom sort function
that takes a dictionary and recursively builds an OrderedDict that
maintains the specific key order we wish to see in iotests output.

The qmp_log function uses this to build a QMP object that keeps
"execute" above "arguments", but sorts all keys and keys in any
subdicts in "arguments" lexicographically to maintain consistent
iotests output, with no incompatible changes to any current test.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-8-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/iotests.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 9595429fea2..565eebb1ab5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -30,6 +30,7 @@ import signal
 import logging
 import atexit
 import io
+from collections import OrderedDict

 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scr=
ipts'))
 import qtest
@@ -75,6 +76,16 @@ def qemu_img(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
     return exitcode

+def ordered_kwargs(kwargs):
+    # kwargs prior to 3.6 are not ordered, so:
+    od =3D OrderedDict()
+    for k, v in sorted(kwargs.items()):
+        if isinstance(v, dict):
+            od[k] =3D ordered_kwargs(v)
+        else:
+            od[k] =3D v
+    return od
+
 def qemu_img_create(*args):
     args =3D list(args)

@@ -257,8 +268,10 @@ def filter_img_info(output, filename):
 def log(msg, filters=3D[]):
     for flt in filters:
         msg =3D flt(msg)
-    if type(msg) is dict or type(msg) is list:
-        print(json.dumps(msg, sort_keys=3DTrue))
+    if isinstance(msg, dict) or isinstance(msg, list):
+        # Don't sort if it's already sorted
+        do_sort =3D not isinstance(msg, OrderedDict)
+        print(json.dumps(msg, sort_keys=3Ddo_sort))
     else:
         print(msg)

@@ -448,8 +461,11 @@ class VM(qtest.QEMUQtestMachine):
         return result

     def qmp_log(self, cmd, filters=3D[filter_testfiles], **kwargs):
-        logmsg =3D '{"execute": "%s", "arguments": %s}' % \
-            (cmd, json.dumps(kwargs, sort_keys=3DTrue))
+        full_cmd =3D OrderedDict((
+            ("execute", cmd),
+            ("arguments", ordered_kwargs(kwargs))
+        ))
+        logmsg =3D json.dumps(full_cmd)
         log(logmsg, filters)
         result =3D self.qmp(cmd, **kwargs)
         log(json.dumps(result, sort_keys=3DTrue), filters)
--=20
2.20.1
