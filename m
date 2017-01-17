Received: from eggs.gnu.org ([2001:4830:134:3::10]:36863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAM-0004te-7g
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAL-0001cy-KM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAL-0001bi-FG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:25 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87FBD8553F
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:02:00 -0200
Message-Id: <20170117010204.4909-6-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/9] qtest.py: Support QTEST_LOG environment
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qtest logs everything to stderr by default, but we don't want it
to be the default behavior on test cases.

Implement the same behavior of libqtest.c, and redirect the qtest
log to /dev/null by default unless the QTEST_LOG environment
variable is set.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Patch originally submitted as part of series:
* [RFC v2 00/20] qmp: Report bus information on 'query-machines'
---
 scripts/qtest.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index d5aecb5f49..5ac2c69ba8 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -88,8 +88,14 @@ class QEMUQtestMachine(qemu.QEMUMachine):
         self._qtest_path = os.path.join(test_dir, name + "-qtest.sock")
 
     def _base_args(self):
+        if os.getenv('QTEST_LOG'):
+            qtest_log = '/dev/fd/2'
+        else:
+            qtest_log = '/dev/null'
+
         args = super(QEMUQtestMachine, self)._base_args()
         args.extend(['-qtest', 'unix:path=' + self._qtest_path,
+                     '-qtest-log', qtest_log,
                      '-machine', 'accel=qtest'])
         return args
 
-- 
2.11.0.259.g40922b1
