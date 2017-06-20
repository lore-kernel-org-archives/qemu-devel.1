Received: from eggs.gnu.org ([2001:4830:134:3::10]:43688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO5-0000Wi-Rg
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIO3-0000eL-9s
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNIO3-0000e5-4X
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:36:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 20 Jun 2017 14:35:51 +0200
Message-Id: <20170620123553.16186-2-david@redhat.com>
In-Reply-To: <20170620123553.16186-1-david@redhat.com>
References: <20170620123553.16186-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/3] target/s390x: Indicate and check for
 local tlb clearing
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

Let's allow to enable it for the qemu cpu model and correctly emulate
it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c |  1 +
 target/s390x/mem_helper.c | 13 ++++---------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 478bcc6..8fce957 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -685,6 +685,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
         S390_FEAT_GENERAL_INSTRUCTIONS_EXT,
         S390_FEAT_EXECUTE_EXT,
         S390_FEAT_STFLE_45,
+        S390_FEAT_LOCAL_TLB_CLEARING,
     };
     int i;
 
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 80caab9..1de0494 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1558,18 +1558,13 @@ void HELPER(ipte)(CPUS390XState *env, uint64_t pto, uint64_t vaddr,
 
     /* XXX we exploit the fact that Linux passes the exact virtual
        address here - it's not obliged to! */
-    /* XXX: the LC bit should be considered as 0 if the local-TLB-clearing
-       facility is not installed.  */
-    if (m4 & 1) {
+    if (s390_has_feat(S390_FEAT_LOCAL_TLB_CLEARING) && (m4 & 1)) {
         tlb_flush_page(cs, page);
-    } else {
-        tlb_flush_page_all_cpus_synced(cs, page);
-    }
-
-    /* XXX 31-bit hack */
-    if (m4 & 1) {
+        /* 31 bit hack */
         tlb_flush_page(cs, page ^ 0x80000000);
     } else {
+        tlb_flush_page_all_cpus_synced(cs, page);
+        /* 31 bit hack */
         tlb_flush_page_all_cpus_synced(cs, page ^ 0x80000000);
     }
 }
-- 
2.9.4
