Received: from eggs.gnu.org ([2001:4830:134:3::10]:34907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqihP-0002eu-H8
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqihK-0006u3-10
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cqihJ-0006tf-Rg
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C76AF6E77A
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 16:01:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Mar 2017 13:00:51 -0300
Message-Id: <20170322160052.2820-3-ehabkost@redhat.com>
In-Reply-To: <20170322160052.2820-1-ehabkost@redhat.com>
References: <20170322160052.2820-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qtest.py: Support QTEST_LOG environment
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

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
