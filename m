Received: from eggs.gnu.org ([2001:4830:134:3::10]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eCAlu-0006TJ-O8
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eCAlt-0002zx-T1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 15:46:58 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  7 Nov 2017 15:46:51 -0500
Message-Id: <1510087611-1851-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] arm/translate-a64: mark path as unreachable to
 eliminate warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Fixes the following warning when compiling with gcc 5.4.0 with -O1
optimizations and --enable-debug:

target/arm/translate-a64.c: In function ‘aarch64_tr_translate_insn’:
target/arm/translate-a64.c:2361:8: error: ‘post_index’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     if (!post_index) {
        ^
target/arm/translate-a64.c:2307:10: note: ‘post_index’ was declared here
     bool post_index;
          ^
target/arm/translate-a64.c:2386:8: error: ‘writeback’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     if (writeback) {
        ^
target/arm/translate-a64.c:2308:10: note: ‘writeback’ was declared here
     bool writeback;
          ^

Note that idx comes from selecting 2 bits, and therefore its value
can be at most 3.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index caca05a..625ef2d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2340,28 +2340,30 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     switch (idx) {
     case 0:
     case 2:
         post_index = false;
         writeback = false;
         break;
     case 1:
         post_index = true;
         writeback = true;
         break;
     case 3:
         post_index = false;
         writeback = true;
         break;
+    default:
+        g_assert_not_reached();
     }
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
     tcg_addr = read_cpu_reg_sp(s, rn, 1);
 
     if (!post_index) {
         tcg_gen_addi_i64(tcg_addr, tcg_addr, imm9);
     }
 
     if (is_vector) {
         if (is_store) {
             do_fp_st(s, rt, tcg_addr, size);
-- 
2.7.4
