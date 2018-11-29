Received: from eggs.gnu.org ([2001:4830:134:3::10]:48315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSRVj-00034f-Nr
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:58:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSRVg-0007gY-Vb
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:58:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSRVg-0007gL-Ob
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 13:58:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7449EA04B3
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 18:57:59 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Nov 2018 16:57:54 -0200
Message-Id: <20181129185754.7009-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] hostmem: Validate host-nodes before setting
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>

host_memory_backend_set_host_nodes() was not validating
host-nodes before writing to backend->host_nodes, making QEMU
write beyond the end of the bitmap.

Fix the crash and add a simple regression test for the fix.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem.c                   | 13 +++++++---
 tests/acceptance/host-nodes-limit.py | 36 ++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 tests/acceptance/host-nodes-limit.py

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a89342039..ef199d32fd 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -103,11 +103,18 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
 {
 #ifdef CONFIG_NUMA
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    uint16List *l = NULL;
+    uint16List *l, *host_nodes = NULL;
 
-    visit_type_uint16List(v, name, &l, errp);
+    visit_type_uint16List(v, name, &host_nodes, errp);
+
+    for (l = host_nodes; l; l = l->next) {
+        if (l->value >= MAX_NODES) {
+            error_setg(errp, "Invalid host-nodes value: %d", l->value);
+            return;
+        }
+    }
 
-    while (l) {
+    for (l = host_nodes; l; l = l->next) {
         bitmap_set(backend->host_nodes, l->value, 1);
         l = l->next;
     }
diff --git a/tests/acceptance/host-nodes-limit.py b/tests/acceptance/host-nodes-limit.py
new file mode 100644
index 0000000000..e803e10104
--- /dev/null
+++ b/tests/acceptance/host-nodes-limit.py
@@ -0,0 +1,36 @@
+# Regression test for host-nodes limit validation
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+from subprocess import Popen, PIPE
+
+MAX_NODES = 128
+
+class HostNodesValidation(Test):
+    def test_large_host_nodes(self):
+        p = Popen([self.qemu_bin, '-display', 'none', '-nodefaults',
+                   '-object', 'memory-backend-ram,id=m0,'
+                              'size=4096,host-nodes=%d' % (MAX_NODES)],
+                  stderr=PIPE, stdout=PIPE)
+        stdout,stderr = p.communicate()
+
+        self.assertIn(b'Invalid host-nodes', stderr)
+        self.assertEquals(stdout, b'')
+        self.assertEquals(p.returncode, 1)
+
+    def test_valid_host_nodes(self):
+        p = Popen([self.qemu_bin, '-display', 'none', '-nodefaults',
+                   '-object', 'memory-backend-ram,id=m0,'
+                              'size=4096,host-nodes=%d' % (MAX_NODES - 1)],
+                  stderr=PIPE, stdout=PIPE)
+        stdout,stderr = p.communicate()
+
+        self.assertIn(b'host-nodes must be empty', stderr)
+        self.assertEquals(p.returncode, 1)
-- 
2.18.0.rc1.1.g3f1ff2140
