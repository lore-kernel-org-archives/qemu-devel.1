Received: from eggs.gnu.org ([2001:4830:134:3::10]:56735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7MCq-0008HF-Uv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7MCq-0004AW-3E
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:03:24 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 16:03:04 +0100
Message-Id: <20181002150304.2287-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Don't read r4 from v8M exception
 stackframe twice
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

A cut-and-paste error meant we were reading r4 from the v8M
callee-saves exception stack frame twice. This is harmless
since it just meant we did two memory accesses to the same
location, but it's unnecessary. Delete it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 073fb3c5cb0..5e721a65272 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7303,7 +7303,6 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             }
 
             pop_ok = pop_ok &&
-                v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
                 v7m_stack_read(cpu, &env->regs[4], frameptr + 0x8, mmu_idx) &&
                 v7m_stack_read(cpu, &env->regs[5], frameptr + 0xc, mmu_idx) &&
                 v7m_stack_read(cpu, &env->regs[6], frameptr + 0x10, mmu_idx) &&
-- 
2.19.0
