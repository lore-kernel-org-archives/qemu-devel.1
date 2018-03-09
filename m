Received: from eggs.gnu.org ([2001:4830:134:3::10]:42031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDuq-0000Rc-CO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDup-0000MM-Dh
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDup-0000MD-8U
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:02:15 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 17:00:04 +0800
Message-Id: <20180309090006.10018-22-peterx@redhat.com>
In-Reply-To: <20180309090006.10018-1-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 21/23] qmp: add command "x-oob-test"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This command is only used to test OOB functionality.  It should not be
used for any other purposes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/misc.json | 18 ++++++++++++++++++
 qmp.c          | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8c7e736681..07932bdacf 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3264,3 +3264,21 @@
 ##
 { 'event': 'COMMAND_DROPPED' ,
   'data': { 'id': 'any', 'reason': 'CommandDropReason' } }
+
+##
+# @x-oob-test:
+#
+# Test OOB functionality.  When send this command with lock=true,
+# it'll try to hang the dispatcher.  When send it with lock=false,
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
index 8c7d1cc479..d95d132448 100644
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
