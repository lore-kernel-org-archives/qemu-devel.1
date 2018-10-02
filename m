Received: from eggs.gnu.org ([2001:4830:134:3::10]:35055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nf9-00079R-9Z
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nf8-0005Jq-Ge
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:43 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:55 +0100
Message-Id: <20181002163556.10279-13-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/13] target/arm: Add v8M stack checks for
 VLDM/VSTM
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

Add the v8M stack checks for the VLDM/VSTM
(aka VPUSH/VPOP) instructions. This code is currently
unreachable because we haven't yet implemented M profile
floating point support, but since the change is simple,
we add it now because otherwise we're likely to forget to
do it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ef64d2559de..2d3a1be518b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4229,6 +4229,18 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 if (insn & (1 << 24)) /* pre-decrement */
                     tcg_gen_addi_i32(addr, addr, -((insn & 0xff) << 2));
 
+                if (rn == 13 && w && s->v8m_stackcheck) {
+                    /*
+                     * Here 'addr' is the lowest address we will store to,
+                     * and is either the old SP (if post-increment) or
+                     * the new SP (if pre-decrement). For post-increment
+                     * where the old value is below the limit and the new
+                     * value is above, it is UNKNOWN whether the limit check
+                     * triggers; we choose to trigger.
+                     */
+                    gen_helper_v8m_stackcheck(cpu_env, addr);
+                }
+
                 if (dp)
                     offset = 8;
                 else
-- 
2.19.0
