Received: from eggs.gnu.org ([2001:4830:134:3::10]:38739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAeeD-0005lw-Pb
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gAeeD-00030h-3T
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:21:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 18:20:57 +0100
Message-Id: <20181011172057.9466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Initialize ARMMMUFaultInfo in
 v7m_stack_read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The get_phys_addr() functions take a pointer to an ARMMMUFaultInfo
struct, which they fill in only if a fault occurs. This means that
the caller must always zero-initialize the struct before passing
it in. We forgot to do this in v7m_stack_read() and v7m_stack_write().
Correct the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Noticed this in passing while I was working in the file on
an entirely different issue.

 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c83f7c1109c..e3368e7edc5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6469,7 +6469,7 @@ static bool v7m_stack_write(ARMCPU *cpu, uint32_t addr, uint32_t value,
     target_ulong page_size;
     hwaddr physaddr;
     int prot;
-    ARMMMUFaultInfo fi;
+    ARMMMUFaultInfo fi = {};
     bool secure = mmu_idx & ARM_MMU_IDX_M_S;
     int exc;
     bool exc_secure;
@@ -6531,7 +6531,7 @@ static bool v7m_stack_read(ARMCPU *cpu, uint32_t *dest, uint32_t addr,
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
