Received: from eggs.gnu.org ([2001:4830:134:3::10]:55716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZJ-0000QM-Em
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZI-0006sP-Jd
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:49 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZI-0006sG-FI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:48 -0500
Received: by mail-qt0-x243.google.com with SMTP id a29so842319qtb.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:48 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:56:01 -0800
Message-Id: <20170112025606.27332-26-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 25/30] target-sparc: implement UA2005 ASI_MMU
 (0x21)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <6f546cf963e03ed253e16701ba6e30dcc5d00073.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 57b3b97..d34795a 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1394,6 +1394,18 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = env->scratch[i];
             break;
         }
+    case ASI_MMU: /* UA2005 Context ID registers */
+        switch ((addr >> 3) & 0x3) {
+        case 1:
+            ret = env->dmmu.mmu_primary_context;
+            break;
+        case 2:
+            ret = env->dmmu.mmu_secondary_context;
+            break;
+        default:
+          cpu_unassigned_access(cs, addr, true, false, 1, size);
+        }
+        break;
     case ASI_DCACHE_DATA:     /* D-cache data */
     case ASI_DCACHE_TAG:      /* D-cache tag access */
     case ASI_ESTATE_ERROR_EN: /* E-cache error enable */
@@ -1712,6 +1724,25 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             env->scratch[i] = val;
             return;
         }
+    case ASI_MMU: /* UA2005 Context ID registers */
+        {
+          switch ((addr >> 3) & 0x3) {
+          case 1:
+              env->dmmu.mmu_primary_context = val;
+              env->immu.mmu_primary_context = val;
+              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_IDX, MMU_KERNEL_IDX, -1);
+              break;
+          case 2:
+              env->dmmu.mmu_secondary_context = val;
+              env->immu.mmu_secondary_context = val;
+              tlb_flush_by_mmuidx(CPU(cpu), MMU_USER_SECONDARY_IDX,
+                                  MMU_KERNEL_SECONDARY_IDX, -1);
+              break;
+          default:
+              cpu_unassigned_access(cs, addr, true, false, 1, size);
+          }
+        }
+        return;
     case ASI_QUEUE: /* UA2005 CPU mondo queue */
     case ASI_DCACHE_DATA: /* D-cache data */
     case ASI_DCACHE_TAG: /* D-cache tag access */
-- 
2.9.3
