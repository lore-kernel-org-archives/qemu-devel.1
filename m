Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Tc-00008h-8s
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fG6Ta-0005Xs-Je
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:36 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fG6Ta-0005Xc-C1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 13:32:34 -0400
Received: by mail-lf0-x242.google.com with SMTP id t129-v6so7740827lff.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 10:32:34 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue,  8 May 2018 19:31:41 +0200
Message-Id: <20180508173152.29327-26-edgar.iglesias@gmail.com>
In-Reply-To: <20180508173152.29327-1-edgar.iglesias@gmail.com>
References: <20180508173152.29327-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 25/36] target-microblaze: mmu: Remove unused
 register state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add explicit handling for MMU_R_TLBX and log accesses to
invalid MMU registers. We can now remove the state for
all regs but PID, ZPR and TLBX (0 - 2).

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/mmu.c | 7 +++++--
 target/microblaze/mmu.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index f4a4c339c9..231803ceea 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -211,11 +211,14 @@ uint32_t mmu_read(CPUMBState *env, uint32_t rn)
             }
             r = env->mmu.regs[rn];
             break;
+        case MMU_R_TLBX:
+            r = env->mmu.regs[rn];
+            break;
         case MMU_R_TLBSX:
             qemu_log_mask(LOG_GUEST_ERROR, "TLBSX is write-only.\n");
             break;
         default:
-            r = env->mmu.regs[rn];
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid MMU register %d.\n", rn);
             break;
     }
     D(qemu_log("%s rn=%d=%x\n", __func__, rn, r));
@@ -298,7 +301,7 @@ void mmu_write(CPUMBState *env, uint32_t rn, uint32_t v)
             break;
         }
         default:
-            env->mmu.regs[rn] = v;
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid MMU register %d.\n", rn);
             break;
    }
 }
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 113539c6e9..624becfded 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -67,7 +67,7 @@ struct microblaze_mmu
     /* We keep a separate ram for the tids to avoid the 48 bit tag width.  */
     uint8_t tids[TLB_ENTRIES];
     /* Control flops.  */
-    uint32_t regs[8];
+    uint32_t regs[3];
 
     int c_mmu;
     int c_mmu_tlb_access;
-- 
2.14.1
