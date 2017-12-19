Received: from eggs.gnu.org ([2001:4830:134:3::10]:39358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDbj-0003mI-A2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eRDbe-0002ps-CV
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eRDbe-0002oF-6d
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:50:34 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Dec 2017 16:45:54 +0800
Message-Id: <20171219084557.9801-25-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-1-peterx@redhat.com>
References: <20171219084557.9801-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v6 24/27] qmp: add command "x-oob-test"
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi-schema.json | 18 ++++++++++++++++++
 qmp.c            | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 447ab25572..a63cd42cdd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3259,3 +3259,21 @@
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
index e8c303116a..ca2968aad2 100644
--- a/qmp.c
+++ b/qmp.c
@@ -722,3 +722,19 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 
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
