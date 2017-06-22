Received: from eggs.gnu.org ([2001:4830:134:3::10]:33078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNycn-0000H8-Vq
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNycn-0000Z3-7M
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNycn-0000Yh-1T
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:42:05 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 22 Jun 2017 11:41:50 +0200
Message-Id: <20170622094151.28633-3-david@redhat.com>
In-Reply-To: <20170622094151.28633-1-david@redhat.com>
References: <20170622094151.28633-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] target/s390x: Improve heuristic for ipte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

If only the page index is set, most likely we don't have a valid
virtual address. Let's do a full tlb flush for that case.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/mem_helper.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 41e5a1d..1507175 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1559,16 +1559,23 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
     if (m4 & 1) {
-        tlb_flush_page(cs, page);
-    } else {
-        tlb_flush_page_all_cpus_synced(cs, page);
-    }
-
-    /* XXX 31-bit hack */
-    if (m4 & 1) {
-        tlb_flush_page(cs, page ^ 0x80000000);
+        if (vaddr & ~VADDR_PX) {
+            tlb_flush_page(cs, page);
+            /* XXX 31-bit hack */
+            tlb_flush_page(cs, page ^ 0x80000000);
+        } else {
+            /* looks like we don't have a valid virtual address */
+            tlb_flush(cs);
+        }
     } else {
-        tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
+        if (vaddr & ~VADDR_PX) {
+            tlb_flush_page_all_cpus_synced(cs, page);
+            /* XXX 31-bit hack */
+            tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
+        } else {
+            /* looks like we don't have a valid virtual address */
+            tlb_flush_all_cpus_synced(cs);
+        }
     }
 }
 
-- 
2.9.4
