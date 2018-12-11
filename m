Received: from eggs.gnu.org ([2001:4830:134:3::10]:41432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmMS-0005e9-CP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWmML-00058M-Te
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWmMJ-0004uy-Us
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:02:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 11 Dec 2018 16:01:17 -0200
Message-Id: <20181211180129.7661-13-ehabkost@redhat.com>
In-Reply-To: <20181211180129.7661-1-ehabkost@redhat.com>
References: <20181211180129.7661-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/24] hostmem: Validate host-nodes before
 setting bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

host_memory_backend_set_host_nodes() was not validating
host-nodes before writing to backend->host_nodes, making QEMU
write beyond the end of the bitmap.

Fix the crash and add a simple regression test for the fix.

While at it, fix memory leak of the list returned by
visit_type_uint16List().

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20181130122844.29103-1-ehabkost@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
[ehabkost: removed test case code]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1a89342039..af800284e0 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -103,14 +103,23 @@ host_memory_backend_set_host_nodes(Object *obj, Visitor *v, const char *name,
 {
 #ifdef CONFIG_NUMA
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    uint16List *l = NULL;
+    uint16List *l, *host_nodes = NULL;
 
-    visit_type_uint16List(v, name, &l, errp);
+    visit_type_uint16List(v, name, &host_nodes, errp);
 
-    while (l) {
+    for (l = host_nodes; l; l = l->next) {
+        if (l->value >= MAX_NODES) {
+            error_setg(errp, "Invalid host-nodes value: %d", l->value);
+            goto out;
+        }
+    }
+
+    for (l = host_nodes; l; l = l->next) {
         bitmap_set(backend->host_nodes, l->value, 1);
-        l = l->next;
     }
+
+out:
+    qapi_free_uint16List(host_nodes);
 #else
     error_setg(errp, "NUMA node binding are not supported by this QEMU");
 #endif
-- 
2.18.0.rc1.1.g3f1ff2140
