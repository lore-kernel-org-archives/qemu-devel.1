Received: from eggs.gnu.org ([2001:4830:134:3::10]:42402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG96-0002Lk-Cl
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG92-0001FZ-2y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:32 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:12 -0500
Message-Id: <20181213015013.15350-7-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-1-jsnow@redhat.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/7] iotests: allow pretty-print for qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

If iotests have lines exceeding >998 characters long, git doesn't
want to send it plaintext to the list. We can solve this by allowing
the iotests to use pretty printed QMP output that we can match against
instead.

As a bonus, it's much nicer for human eyes, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9595429fea..dbbef4bad3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -447,12 +447,12 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
 
-    def qmp_log(self, cmd, filters=[filter_testfiles], **kwargs):
+    def qmp_log(self, cmd, indent=None, filters=[filter_testfiles], **kwargs):
         logmsg = '{"execute": "%s", "arguments": %s}' % \
             (cmd, json.dumps(kwargs, sort_keys=True))
         log(logmsg, filters)
         result = self.qmp(cmd, **kwargs)
-        log(json.dumps(result, sort_keys=True), filters)
+        log(json.dumps(result, indent=indent, sort_keys=True), filters)
         return result
 
     def run_job(self, job, auto_finalize=True, auto_dismiss=False):
-- 
2.17.2
