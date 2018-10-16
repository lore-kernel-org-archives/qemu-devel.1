Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCX-0000z7-CQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCW-0000Aj-Lx
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRCW-000803-DL
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:24:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCG-0003qV-1y
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:24 +0100
Message-Id: <20181016152325.31367-19-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/19] target/arm: Initialize ARMMMUFaultInfo in
 v7m_stack_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The get_phys_addr() functions take a pointer to an ARMMMUFaultInfo
struct, which they fill in only if a fault occurs. This means that
the caller must always zero-initialize the struct before passing
it in. We forgot to do this in v7m_stack_read() and v7m_stack_write().
Correct the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181011172057.9466-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7a53098888d..e3946562aa1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6472,7 +6472,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     target_ulong page_size;
     hwaddr physaddr;
     int prot;
-    ARMMMUFaultInfo fi;
+    ARMMMUFaultInfo fi = {};
     bool secure = mmu_idx & ARM_MMU_IDX_M_S;
     int exc;
     bool exc_secure;
@@ -6534,7 +6534,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
     target_ulong page_size;
     hwaddr physaddr;
     int prot;
-    ARMMMUFaultInfo fi;
+    ARMMMUFaultInfo fi = {};
     bool secure = mmu_idx & ARM_MMU_IDX_M_S;
     int exc;
     bool exc_secure;
-- 
2.19.0
