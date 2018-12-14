Received: from eggs.gnu.org ([2001:4830:134:3::10]:39916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgV-0000xX-76
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXwgU-0003He-8v
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 18:15:55 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 14 Dec 2018 18:15:11 -0500
Message-Id: <20181214231512.5295-7-jsnow@redhat.com>
In-Reply-To: <20181214231512.5295-1-jsnow@redhat.com>
References: <20181214231512.5295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] iotests: allow pretty-print for qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

If iotests have lines exceeding >998 characters long, git doesn't
want to send it plaintext to the list. We can solve this by allowing
the iotests to use pretty printed QMP output that we can match against
instead.

As a bonus, it's much nicer for human eyes, too.

Note that this changes the sort order for "command" and "arguments",
so I restrict this reordering to occur only when the indent is specified.
---
 tests/qemu-iotests/iotests.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9595429fea..ab5823c011 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -447,12 +447,21 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
-        logmsg = '{"execute": "%s", "arguments": %s}' % \
-            (cmd, json.dumps(kwargs, sort_keys=True))
+    def qmp_log(self, cmd, indent=None, filters=[filter_testfiles], **kwargs):
+        # Python < 3.4 needs to know not to add whitespace when pretty-printing:
+        separators = (',', ': ') if indent is not None else (',', ': ')
+        if indent is not None:
+            fullcmd = { "execute": cmd,
+                        "arguments": kwargs }
+            logmsg = json.dumps(fullcmd, indent=indent, separators=separators,
+                                sort_keys=True)
+        else:
+            logmsg = '{"execute": "%s", "arguments": %s}' % \
+                (cmd, json.dumps(kwargs, sort_keys=True))
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
-        log(json.dumps(result, sort_keys=True), filters)
+        log(json.dumps(result, indent=indent, separators=separators,
+                       sort_keys=True), filters)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.2
