Received: from eggs.gnu.org ([2001:4830:134:3::10]:35268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZS-0001k3-RW
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZS-0001Bl-4o
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZR-0001BZ-Tm
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZR-0003rV-2f
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:57 +0000
Message-Id: <1482852077-19397-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 05/25] target-arm: Fix aarch64
 disas_ldst_single_struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <rth@twiddle.net>

We add s->be_data within do_vec_ld/st.  Adding it here means that
we have the wrong bits set in SIZE for a big-endian host, leading
to g_assert_not_reached in write_vec_element and read_vec_element.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-id: 1481085020-2614-3-git-send-email-rth@twiddle.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index ef7601b..f673d93 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2830,9 +2830,9 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
         } else {
             /* Load/store one element per register */
             if (is_load) {
-                do_vec_ld(s, rt, index, tcg_addr, s->be_data + scale);
+                do_vec_ld(s, rt, index, tcg_addr, scale);
             } else {
-                do_vec_st(s, rt, index, tcg_addr, s->be_data + scale);
+                do_vec_st(s, rt, index, tcg_addr, scale);
             }
         }
         tcg_gen_addi_i64(tcg_addr, tcg_addr, ebytes);
-- 
2.7.4
