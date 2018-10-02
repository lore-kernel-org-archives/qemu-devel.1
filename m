Received: from eggs.gnu.org ([2001:4830:134:3::10]:34948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nek-0006oQ-20
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g7Nef-00059j-Vn
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:36:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  2 Oct 2018 17:35:54 +0100
Message-Id: <20181002163556.10279-12-peter.maydell@linaro.org>
In-Reply-To: <20181002163556.10279-1-peter.maydell@linaro.org>
References: <20181002163556.10279-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 11/13] target/arm: Add v8M stack checks for
 Thumb push/pop
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

Add v8M stack checks for the 16-bit Thumb push/pop
encodings: STMDB, STMFD, LDM, LDMIA, LDMFD.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 65df8d6975c..ef64d2559de 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12251,7 +12251,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
             break;
         case 4: case 5: case 0xc: case 0xd:
-            /* push/pop */
+            /*
+             * 0b1011_x10x_xxxx_xxxx
+             *  - push/pop
+             */
             addr = load_reg(s, 13);
             if (insn & (1 << 8))
                 offset = 4;
@@ -12264,6 +12267,17 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             if ((insn & (1 << 11)) == 0) {
                 tcg_gen_addi_i32(addr, addr, -offset);
             }
+
+            if (s->v8m_stackcheck) {
+                /*
+                 * Here 'addr' is the lower of "old SP" and "new SP";
+                 * if this is a pop that starts below the limit and ends
+                 * above it, it is UNKNOWN whether the limit check triggers;
+                 * we choose to trigger.
+                 */
+                gen_helper_v8m_stackcheck(cpu_env, addr);
+            }
+
             for (i = 0; i < 8; i++) {
                 if (insn & (1 << i)) {
                     if (insn & (1 << 11)) {
-- 
2.19.0
