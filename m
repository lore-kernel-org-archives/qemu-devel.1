Received: from eggs.gnu.org ([2001:4830:134:3::10]:43352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2d-0000E2-Cm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZR2c-0004YS-Fr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 20:52:55 -0500
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Dec 2018 20:52:29 -0500
Message-Id: <20181219015230.18652-5-jsnow@redhat.com>
In-Reply-To: <20181219015230.18652-1-jsnow@redhat.com>
References: <20181219015230.18652-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/5] iotests: implement pretty-print for log
 and qmp_log
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

If iotests have lines exceeding >998 characters long, git doesn't
want to send it plaintext to the list. We can solve this by allowing
the iotests to use pretty printed QMP output that we can match against
instead.

As a bonus, it's much nicer for human eyes too.
---
 tests/qemu-iotests/iotests.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 812302538d..d3c57e266f 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -284,12 +284,18 @@ def filter_img_info(output, filename):
         lines.append(line)
     return '\n'.join(lines)
 
-def log(msg, filters=[]):
+def log(msg, filters=[], indent=None):
+    '''Logs either a string message or a JSON serializable message (like QMP).
+    If indent is provided, JSON serializable messages are pretty-printed.'''
     for flt in filters:
         msg = flt(msg)
     if isinstance(msg, dict) or isinstance(msg, list):
-        sort_keys = not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=sort_keys))
+        # Python < 3.4 needs to know not to add whitespace when pretty-printing:
+        separators = (', ', ': ') if indent is None else (',', ': ')
+        # Don't sort if it's already sorted
+        do_sort = not isinstance(msg, OrderedDict)
+        print(json.dumps(msg, sort_keys=do_sort,
+                         indent=indent, separators=separators))
     else:
         print(msg)
 
@@ -478,12 +484,12 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[], **kwargs):
+    def qmp_log(self, cmd, filters=[], indent=None, **kwargs):
         full_cmd = OrderedDict({"execute": cmd,
                                 "arguments": ordered_kwargs(kwargs)})
-        log(full_cmd, filters)
+        log(full_cmd, filters, indent=indent)
         result = self.qmp(cmd, **kwargs)
-        log(result, filters)
+        log(result, filters, indent=indent)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.2
