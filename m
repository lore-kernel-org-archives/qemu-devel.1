Received: from eggs.gnu.org ([2001:4830:134:3::10]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETtE-0005NC-Kc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cETt9-0006bA-Oj
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 23:31:32 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Dec 2016 20:30:20 -0800
Message-Id: <1481085020-2614-3-git-send-email-rth@twiddle.net>
In-Reply-To: <1481085020-2614-1-git-send-email-rth@twiddle.net>
References: <1481085020-2614-1-git-send-email-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 2/2] target-arm: Fix aarch64
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
Cc: qemu-arm@nongnu.org

We add s->be_data within do_vec_ld/st.  Adding it here means that
we have the wrong bits set in SIZE for a big-endian host, leading
to g_assert_not_reached in write_vec_element and read_vec_element.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target-arm/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target-arm/translate-a64.c b/target-arm/translate-a64.c
index ef7601b..f673d93 100644
--- a/target-arm/translate-a64.c
+++ b/target-arm/translate-a64.c
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
