Received: from eggs.gnu.org ([2001:4830:134:3::10]:37254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytW-0006uZ-4m
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytU-00030c-U0
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:54 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytU-000309-OV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:52 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so7541123wmr.3
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:52 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:38 +0100
Message-Id: <1484779123-18968-26-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
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
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/ldst_helper.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4f55388..c69167e 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1396,6 +1396,18 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
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
@@ -1714,6 +1726,25 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
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
2.7.2
