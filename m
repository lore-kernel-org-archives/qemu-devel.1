Received: from eggs.gnu.org ([2001:4830:134:3::10]:45504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJe-0000vL-N2
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJd-00065e-QV
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58844 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJd-00065I-MR
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B2FF401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:36:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:23 -0500
Message-Id: <20180312183628.394722-33-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 32/36] qmp: add command "x-oob-test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Peter Xu <peterx@redhat.com>

This command is only used to test OOB functionality.  It should not be
used for any other purposes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-22-peterx@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: grammar tweak]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/misc.json | 18 ++++++++++++++++++
 qmp.c          | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index b6ebf210ba8..fc3550f3acc 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3279,3 +3279,21 @@
 ##
 { 'event': 'COMMAND_DROPPED' ,
   'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
+
+##
+# @x-oob-test:
+#
+# Test OOB functionality.  When sending this command with lock=true,
+# it'll try to hang the dispatcher.  When sending it with lock=false,
+# it'll try to notify the locked thread to continue.  Note: it should
+# only be used by QMP test program rather than anything else.
+#
+# Since: 2.12
+#
+# Example:
+#
+# { "execute": "x-oob-test",
+#   "arguments": { "lock": true } }
+##
+{ 'command': 'x-oob-test', 'data' : { 'lock': 'bool' },
+  'allow-oob': true }
diff --git a/qmp.c b/qmp.c
index 7e606d84867..ea3760acb12 100644
--- a/qmp.c
+++ b/qmp.c
@@ -770,3 +770,19 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)

     return mem_info;
 }
+
+static QemuSemaphore x_oob_test_sem;
+
+static void __attribute__((constructor)) x_oob_test_init(void)
+{
+    qemu_sem_init(&x_oob_test_sem, 0);
+}
+
+void qmp_x_oob_test(bool lock, Error **errp)
+{
+    if (lock) {
+        qemu_sem_wait(&x_oob_test_sem);
+    } else {
+        qemu_sem_post(&x_oob_test_sem);
+    }
+}
-- 
2.14.3
