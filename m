Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN8-0007tg-Jt
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqkN7-0001Lr-3Y
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cqkN6-0001KV-Rk
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:48:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Mar 2017 18:48:24 +0100
Message-Id: <1490204908-26567-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1490204908-26567-1-git-send-email-armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 for-2.9 13/17] Revert "hostmem: fix QEMU
 crash by 'info memdev'"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>

This reverts commit 1454d33f0507cb54d62ed80f494884157c9e7130.

The string input visitor regression fixed in the previous commit made
visit_type_uint16List() fail on empty input.  query_memdev() calls it
via object_property_get_uint16List().  Because it doesn't expect it to
fail, it passes &error_abort, and duly crashes.

Commit 1454d33 "fixes" this crash by making
host_memory_backend_get_host_nodes() return a list containing just
MAX_NODES instead of the empty list.  Papers over the regression, and
leads to bogus "info memdev" output, as shown below; revert.

I suspect that if we had bisected the crash back then, we would have
found and fixed the actual bug instead of papering over it.

To reproduce, run HMP command "info memdev" with

    $ qemu-system-x86_64 --nodefaults -S -display none -monitor stdio -object memory-backend-ram,id=mem1,size=4k

With this commit, "info memdev" prints

    memory backend: mem1
      size:  4096
      merge: true
      dump: true
      prealloc: false
      policy: default
      host nodes:

exactly like before commit 74f24cb.

Between commit 1454d33 and this commit, it prints

    memory backend: mem1
      size:  4096
      merge: true
      dump: true
      prealloc: false
      policy: default
      host nodes: 128

The last line is bogus.

Between commit 74f24cb and 1454d33, it crashes like this:

    Unexpected error in parse_str() at /work/armbru/tmp/qemu/qapi/string-input-visitor.c:126:
    Parameter 'null' expects an int64 value or range
    Aborted (core dumped)

Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1490026424-11330-3-git-send-email-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 backends/hostmem.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 162c218..89feb9e 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -64,14 +64,6 @@ out:
     error_propagate(errp, local_err);
 }
 
-static uint16List **host_memory_append_node(uint16List **node,
-                                            unsigned long value)
-{
-     *node = g_malloc0(sizeof(**node));
-     (*node)->value = value;
-     return &(*node)->next;
-}
-
 static void
 host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
@@ -82,23 +74,25 @@ host_memory_backend_get_host_nodes(Object *obj, Visitor *v, const char *name,
     unsigned long value;
 
     value = find_first_bit(backend->host_nodes, MAX_NODES);
-
-    node = host_memory_append_node(node, value);
-
     if (value == MAX_NODES) {
-        goto out;
+        return;
     }
 
+    *node = g_malloc0(sizeof(**node));
+    (*node)->value = value;
+    node = &(*node)->next;
+
     do {
         value = find_next_bit(backend->host_nodes, MAX_NODES, value + 1);
         if (value == MAX_NODES) {
             break;
         }
 
-        node = host_memory_append_node(node, value);
+        *node = g_malloc0(sizeof(**node));
+        (*node)->value = value;
+        node = &(*node)->next;
     } while (true);
 
-out:
     visit_type_uint16List(v, name, &host_nodes, errp);
 }
 
-- 
2.7.4
