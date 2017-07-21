Received: from eggs.gnu.org ([2001:4830:134:3::10]:40014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNok-0003sa-R7
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0007UQ-TE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:24655)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0007UI-Mz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:25 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:04 +0100
Message-ID: <1500604635-15027-4-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 03/14] target/mips: Weaken TLB flush on UX, SX,
 KX, ASID changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

There is no need to invalidate any shadow TLB entries when the ASID
changes or when access to one of the 64-bit segments has been disabled,
since doing so doesn't reveal to software whether any TLB entries have
been evicted into the shadow half of the TLB.

Therefore weaken the tlb flushes in these cases to only flush the QEMU
TLB.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/helper.c    | 2 +-
 target/mips/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 166f0d1..11d6a86 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -290,7 +290,7 @@ void cpu_mips_store_status(CPUMIPSState *env, target_ulong val)
 #if defined(TARGET_MIPS64)
     if ((env->CP0_Status ^ old) & (old & (7 << CP0St_UX))) {
         /* Access to at least one of the 64-bit segments has been disabled */
-        cpu_mips_tlb_flush(env);
+        tlb_flush(CPU(mips_env_get_cpu(env)));
     }
 #endif
     if (env->CP0_Config3 & (1 << CP0C3_MT)) {
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 6393eff..091afd5 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1416,7 +1416,7 @@ void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
     /* If the ASID changes, flush qemu's TLB.  */
     if ((old & env->CP0_EntryHi_ASID_mask) !=
         (val & env->CP0_EntryHi_ASID_mask)) {
-        cpu_mips_tlb_flush(env);
+        tlb_flush(CPU(mips_env_get_cpu(env)));
     }
 }
 
-- 
2.7.4
