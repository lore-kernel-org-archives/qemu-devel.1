Received: from eggs.gnu.org ([2001:4830:134:3::10]:60358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMQ-0001jm-0E
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMP-0007zV-6m
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:05 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMP-0007zF-2p
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:05 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so969772qkq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:23:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:40 -0700
Message-Id: <20170623162241.8964-15-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 14/15] target/s390x: Improve heuristic for ipte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

If only the page index is set, most likely we don't have a valid
virtual address. Let's do a full tlb flush for that case.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170622094151.28633-3-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 182c46f..20cef9a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1630,16 +1630,23 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
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
