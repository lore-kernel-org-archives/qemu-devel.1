Received: from eggs.gnu.org ([2001:4830:134:3::10]:43687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO5-0000Wh-R0
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO4-0000ec-Bp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNIO4-0000eR-5v
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 20 Jun 2017 14:35:52 +0200
Message-Id: <20170620123553.16186-3-david@redhat.com>
In-Reply-To: <20170620123553.16186-1-david@redhat.com>
References: <20170620123553.16186-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/3] target/s390x: Improve heuristic for ipte
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
 target/s390x/mem_helper.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 1de0494..bce7750 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1559,13 +1559,23 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
     if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING) && (m4 & 1)) {
-        tlb_flush_page(cs, page);
-        /* 31 bit hack */
-        tlb_flush_page(cs, page ^ 0x80000000);
+        if (vaddr & ~VADDR_PX) {
+            tlb_flush_page(cs, page);
+            /* 31 bit hack */
+            tlb_flush_page(cs, page ^ 0x80000000);
+        } else {
+            /* looks like we don't have a valid virtual address */
+            tlb_flush(cs);
+        }
     } else {
-        tlb_flush_page_all_cpus_synced(cs, page);
-        /* 31 bit hack */
-        tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
+        if (vaddr & ~VADDR_PX) {
+            tlb_flush_page_all_cpus_synced(cs, page);
+            /* 31 bit hack */
+            tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
+        } else {
+            /* looks like we don't have a valid virtual address */
+            tlb_flush_all_cpus_synced(cs);
+        }
     }
 }
 
-- 
2.9.4
