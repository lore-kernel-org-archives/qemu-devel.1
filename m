Received: from eggs.gnu.org ([209.51.188.92]:49493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvydf-0005Mw-Gw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gvyda-00075D-9S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:16 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gvyda-000754-2J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:12:14 -0500
Received: by mail-lf1-x142.google.com with SMTP id n15so14019057lfe.5
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 22:12:13 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Feb 2019 22:10:57 -0800
Message-Id: <20190219061111.10231-10-jcmvbkbc@gmail.com>
In-Reply-To: <20190219061111.10231-1-jcmvbkbc@gmail.com>
References: <20190219061111.10231-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 09/23] tests/tcg/xtensa: conditionalize cache
 option tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Make data/instruction tests conditional on the presence of
data/instruction cache, whether they're lockable and whether data cache
is writeback.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_cache.S | 62 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/tests/tcg/xtensa/test_cache.S b/tests/tcg/xtensa/test_cache.S
index 6b2df9734b2e..7e6ba4c18a2b 100644
--- a/tests/tcg/xtensa/test_cache.S
+++ b/tests/tcg/xtensa/test_cache.S
@@ -7,6 +7,8 @@
 
 test_suite cache
 
+#if XCHAL_HAVE_PTP_MMU
+
 .macro      pf_op op
     \op     a2, 0
     \op     a3, 0
@@ -18,14 +20,23 @@ test prefetch
     movi    a3, 0xd8000000 /* non-cacheable */
     movi    a4, 0x00001235 /* unmapped */
 
+#if XCHAL_DCACHE_SIZE
     pf_op   dpfr
     pf_op   dpfro
     pf_op   dpfw
     pf_op   dpfwo
+#endif
+#ifdef XCHAL_ICACHE_SIZE
     pf_op   ipf
-
+#endif
+#if XCHAL_HAVE_PTP_MMU && !XCHAL_HAVE_SPANNING_WAY
+#if XCHAL_DCACHE_LINE_LOCKABLE
     dpfl    a2, 0
+#endif
+#if XCHAL_ICACHE_LINE_LOCKABLE
     ipfl    a2, 0
+#endif
+#endif
 test_end
 
 .macro cache_fault op, addr, exc_code
@@ -46,10 +57,16 @@ test_end
     assert  eq, a2, a3
 .endm
 
+#if XCHAL_HAVE_PTP_MMU && !XCHAL_HAVE_SPANNING_WAY
+
+#if XCHAL_DCACHE_LINE_LOCKABLE
 test dpfl_tlb_miss
     cache_fault dpfl, 0x00002345, 24
 test_end
+#endif
 
+#if XCHAL_DCACHE_SIZE
+#if XCHAL_DCACHE_IS_WRITEBACK
 test dhwb_tlb_miss
     cache_fault dhwb, 0x00002345, 24
 test_end
@@ -57,16 +74,21 @@ test_end
 test dhwbi_tlb_miss
     cache_fault dhwbi, 0x00002345, 24
 test_end
+#endif
 
 test dhi_tlb_miss
     cache_fault dhi, 0x00002345, 24
 test_end
 
+#if XCHAL_DCACHE_LINE_LOCKABLE
 test dhu_tlb_miss
     cache_fault dhu, 0x00002345, 24
 test_end
+#endif
+#endif
 
-
+#if XCHAL_ICACHE_SIZE
+#if XCHAL_ICACHE_LINE_LOCKABLE
 test ipfl_tlb_miss
     cache_fault ipfl, 0x00002345, 16
 test_end
@@ -74,24 +96,40 @@ test_end
 test ihu_tlb_miss
     cache_fault ihu, 0x00002345, 16
 test_end
+#endif
 
 test ihi_tlb_miss
     cache_fault ihi, 0x00002345, 16
 test_end
+#endif
+
+#endif
+
+#endif
 
 test_suite_end
 
-.macro cache_all op1, op2, size, linesize
+cache_unlock_invalidate:
+#if XCHAL_DCACHE_SIZE
     movi    a2, 0
-    movi    a3, \size
+    movi    a3, XCHAL_DCACHE_SIZE
 1:
-    \op1    a2, 0
-    \op2    a2, 0
-    addi    a2, a2, \linesize
+#if XCHAL_DCACHE_LINE_LOCKABLE
+    diu     a2, 0
+#endif
+    dii     a2, 0
+    addi    a2, a2, XCHAL_DCACHE_LINESIZE
     bltu    a2, a3, 1b
-.endm
-
-cache_unlock_invalidate:
-    cache_all diu, dii, XCHAL_DCACHE_SIZE, XCHAL_DCACHE_LINESIZE
-    cache_all iiu, iii, XCHAL_ICACHE_SIZE, XCHAL_ICACHE_LINESIZE
+#endif
+#if XCHAL_ICACHE_SIZE
+    movi    a2, 0
+    movi    a3, XCHAL_ICACHE_SIZE
+1:
+#if XCHAL_ICACHE_LINE_LOCKABLE
+    iiu     a2, 0
+#endif
+    iii     a2, 0
+    addi    a2, a2, XCHAL_ICACHE_LINESIZE
+    bltu    a2, a3, 1b
+#endif
     ret
-- 
2.11.0
