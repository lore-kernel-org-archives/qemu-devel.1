Received: from eggs.gnu.org ([2001:4830:134:3::10]:58899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQR-00008p-36
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQQ-0001rx-6s
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:55 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQP-0001pa-UL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:54 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQG-0008Re-3C
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:44 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:10 +0100
Message-Id: <20180816133438.17061-3-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/30] target/arm: Fix sign-extension in sve
 do_ldr/do_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

The expression (int) imm + (uint32_t) len_align turns into uint32_t
and thus with negative imm produces a memory operation at the wrong
offset.  None of the numbers involved are particularly large, so
change everything to use int.

Cc: qemu-stable@nongnu.org (3.0.1)
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 89efc80ee70..9e63b5f8e55 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4372,12 +4372,11 @@ static bool trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
  * The load should begin at the address Rn + IMM.
  */
 
-static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
-                   int rn, int imm)
+static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 {
-    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
-    uint32_t len_remain = len % 8;
-    uint32_t nparts = len / 8 + ctpop8(len_remain);
+    int len_align = QEMU_ALIGN_DOWN(len, 8);
+    int len_remain = len % 8;
+    int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
     TCGv_i64 addr, t0, t1;
 
@@ -4458,12 +4457,11 @@ static void do_ldr(DisasContext *s, uint32_t vofs, uint32_t len,
 }
 
 /* Similarly for stores.  */
-static void do_str(DisasContext *s, uint32_t vofs, uint32_t len,
-                   int rn, int imm)
+static void do_str(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
 {
-    uint32_t len_align = QEMU_ALIGN_DOWN(len, 8);
-    uint32_t len_remain = len % 8;
-    uint32_t nparts = len / 8 + ctpop8(len_remain);
+    int len_align = QEMU_ALIGN_DOWN(len, 8);
+    int len_remain = len % 8;
+    int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
     TCGv_i64 addr, t0;
 
-- 
2.18.0
