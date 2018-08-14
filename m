Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpduq-0004PP-M1
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdti-0006X8-Lc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fpdti-0006Ug-6z
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:26 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fpdtg-00079C-PM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Aug 2018 19:17:36 +0100
Message-Id: <20180814181815.23348-7-peter.maydell@linaro.org>
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/45] accel/tcg: Handle get_page_addr_code()
 returning -1 in hashtable lookups
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
Handle this in the cpu-exec TB hashtable lookup code, treating it as
"no match found".

Note that the call to get_page_addr_code() in tb_lookup_cmp() needs
no changes -- a return of -1 will already correctly result in the
function returning false.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180710160013.26559-3-peter.maydell@linaro.org
---
 accel/tcg/cpu-exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c738b7f7d6e..6bcb6d99bd7 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -332,6 +332,9 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.trace_vcpu_dstate = *cpu->trace_dstate;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
+    if (phys_pc == -1) {
+        return NULL;
+    }
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
     h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
-- 
2.18.0
