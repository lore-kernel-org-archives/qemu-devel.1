Received: from eggs.gnu.org ([2001:4830:134:3::10]:46527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W6D-0001iY-DZ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5v-0007OW-B6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1g9W5l-0006uy-D8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:01:03 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1g9W5P-0003l4-Kp
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 15:00:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  8 Oct 2018 15:00:00 +0100
Message-Id: <20181008140004.12612-30-peter.maydell@linaro.org>
In-Reply-To: <20181008140004.12612-1-peter.maydell@linaro.org>
References: <20181008140004.12612-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/33] target/arm: Add v8M stack checks for T32
 load/store single
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add v8M stack checks for the instructions in the T32
"load/store single" encoding class: these are the
"immediate pre-indexed" and "immediate, post-indexed"
LDR and STR instructions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181002163556.10279-11-peter.maydell@linaro.org
---
 target/arm/translate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3fb378a492d..65df8d6975c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11624,7 +11624,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     imm = -imm;
                     /* Fall through.  */
                 case 0xf: /* Pre-increment.  */
-                    tcg_gen_addi_i32(addr, addr, imm);
                     writeback = 1;
                     break;
                 default:
@@ -11636,6 +11635,28 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
         issinfo = writeback ? ISSInvalid : rs;
 
+        if (s->v8m_stackcheck && rn == 13 && writeback) {
+            /*
+             * Stackcheck. Here we know 'addr' is the current SP;
+             * if imm is +ve we're moving SP up, else down. It is
+             * UNKNOWN whether the limit check triggers when SP starts
+             * below the limit and ends up above it; we chose to do so.
+             */
+            if ((int32_t)imm < 0) {
+                TCGv_i32 newsp = tcg_temp_new_i32();
+
+                tcg_gen_addi_i32(newsp, addr, imm);
+                gen_helper_v8m_stackcheck(cpu_env, newsp);
+                tcg_temp_free_i32(newsp);
+            } else {
+                gen_helper_v8m_stackcheck(cpu_env, addr);
+            }
+        }
+
+        if (writeback && !postinc) {
+            tcg_gen_addi_i32(addr, addr, imm);
+        }
+
         if (insn & (1 << 20)) {
             /* Load.  */
             tmp = tcg_temp_new_i32();
-- 
2.19.0
