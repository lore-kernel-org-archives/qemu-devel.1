Received: from eggs.gnu.org ([2001:4830:134:3::10]:37726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fzXXY-0000bC-HN
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fzXXX-00087e-IQ
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:32:28 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 10 Sep 2018 18:32:11 -0700
Message-Id: <20180911013211.27340-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix s32c1i TCGMemOp flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

s32c1i must load and store value with target endianness, not host.
This results in an infinite loop in atomic cmpxchg sequences when target
endianness doesn't match host endianness.

Fixes: 9fb40342d4b3 ("target/xtensa: support MTTCG")
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 25399058a0db..c626583cd952 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2288,7 +2288,7 @@ static void translate_s32c1i(DisasContext *dc, const uint32_t arg[],
         gen_load_store_alignment(dc, 2, addr, true);
         gen_check_atomctl(dc, addr);
         tcg_gen_atomic_cmpxchg_i32(cpu_R[arg[0]], addr, cpu_SR[SCOMPARE1],
-                                   tmp, dc->cring, MO_32);
+                                   tmp, dc->cring, MO_TEUL);
         tcg_temp_free(addr);
         tcg_temp_free(tmp);
     }
-- 
2.11.0
