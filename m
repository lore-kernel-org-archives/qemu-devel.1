Received: from eggs.gnu.org ([2001:4830:134:3::10]:45371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6o-0004S1-JP
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6n-000867-Nz
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:46 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:51 -0500
Message-Id: <20181220022952.20493-11-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/11] iotests: implement pretty-print for
 log and qmp_log
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

If iotests have lines exceeding >998 characters long, git doesn't
want to send it plaintext to the list. We can solve this by allowing
the iotests to use pretty printed QMP output that we can match against
instead.

As a bonus, it's much nicer for human eyes too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index dcd0c6f71d..d65bcaf953 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -284,13 +284,18 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
-def log(msg, filters=[]):
+def log(msg, filters=[], indent=None):
+    '''Logs either a string message or a JSON serializable message (like QMP).
+    If indent is provided, JSON serializable messages are pretty-printed.'''
     for flt in filters:
         msg = flt(msg)
     if isinstance(msg, dict) or isinstance(msg, list):
+        # Python < 3.4 needs to know not to add whitespace when pretty-printing:
+        separators = (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
         do_sort = not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=do_sort))
+        print(json.dumps(msg, sort_keys=do_sort,
+                         indent=indent, separators=separators))
     else:
         print(msg)
 
@@ -479,14 +484,14 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[], **kwargs):
+    def qmp_log(self, cmd, filters=[], indent=None, **kwargs):
         full_cmd = OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
         ))
-        log(full_cmd, filters)
+        log(full_cmd, filters, indent=indent)
         result = self.qmp(cmd, **kwargs)
-        log(result, filters)
+        log(result, filters, indent=indent)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.2
