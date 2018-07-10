Received: from eggs.gnu.org ([2001:4830:134:3::10]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv41-0003UD-Tp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv41-0002JS-1j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:30 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:00:09 +0100
Message-Id: <20180710160013.26559-3-peter.maydell@linaro.org>
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] accel/tcg: Handle get_page_addr_code()
 returning -1 in hashtable lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

When we support execution from non-RAM MMIO regions, get_page_addr_code()
will return -1 to indicate that there is no RAM at the requested address.
Handle this in the cpu-exec TB hashtable lookup code, treating it as
"no match found".

Note that the call to get_page_addr_code() in tb_lookup_cmp() needs
no changes -- a return of -1 will already correctly result in the
function returning false.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.17.1
