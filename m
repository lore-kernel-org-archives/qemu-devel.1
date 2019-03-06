Received: from eggs.gnu.org ([209.51.188.92]:39102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1bag-0005jo-BH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1baf-0003jn-HM
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h1baf-0003hX-B2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:29 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  6 Mar 2019 15:40:58 -0300
Message-Id: <20190306184101.9974-3-ehabkost@redhat.com>
In-Reply-To: <20190306184101.9974-1-ehabkost@redhat.com>
References: <20190306184101.9974-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] hostmem: fix crash when querying empty
 host-nodes property via QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

QEMU will crashes with
 qapi/qobject-output-visitor.c:210: qobject_output_complete: Assertion `qov->root && ((&qov->stack)->slh_first == ((void *)0))' failed
when trying to get value of not set hostmem's "host-nodes"
property, HostMemoryBackend::host_nodes bitmap doesn't have
any bits set in it, which leads to find_first_bit() returning
MAX_NODES and consequently to an early return from
host_memory_backend_get_host_nodes() without calling visitor.

Fix it by calling visitor even if "host-nodes" property wasn't
set before exiting from property getter to return valid empty
list.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190214105733.25643-1-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/hostmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 87b19d2111..04baf479a1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -88,7 +88,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
 
     value = find_first_bit(backend->host_nodes, MAX_NODES);
     if (value == MAX_NODES) {
-        return;
+        goto ret;
     }
 
     *node = g_malloc0(sizeof(**node));
@@ -106,6 +106,7 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
         node = &(*node)->next;
     } while (true);
 
+ret:
     visit_type_uint16List(v, name, &host_nodes, errp);
 }
 
-- 
2.18.0.rc1.1.g3f1ff2140
