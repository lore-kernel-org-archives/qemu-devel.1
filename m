Received: from eggs.gnu.org ([2001:4830:134:3::10]:52370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdur-0004QP-Qr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtj-0006Xu-UR
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdtj-0006Wd-9d
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdth-00079k-QY
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:37 +0100
Message-Id: <20180814181815.23348-8-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/45] accel/tcg: Handle get_page_addr_code()
 returning -1 in tb_check_watchpoint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When we support execution from non-RAM MMIO regions, get_page_addr_code()
will return -1 to indicate that there is no RAM at the requested address.
Handle this in tb_check_watchpoint() -- if the exception happened for a
PC which doesn't correspond to RAM then there is no need to invalidate
any TBs, because the one-instruction TB will not have been cached.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180710160013.26559-4-peter.maydell@linaro.org
---
 accel/tcg/translate-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1571987113b..ff7d0145f46 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2121,7 +2121,9 @@ void tb_check_watchpoint(CPUState *cpu)
 
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         addr = get_page_addr_code(env, pc);
-        tb_invalidate_phys_range(addr, addr + 1);
+        if (addr != -1) {
+            tb_invalidate_phys_range(addr, addr + 1);
+        }
     }
 }
 
-- 
2.18.0
