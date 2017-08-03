Received: from eggs.gnu.org ([2001:4830:134:3::10]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNT-00017l-Tu
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-0002YF-Iv
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:51454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-0002Xu-CE
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:15 +0100
Message-ID: <1501771515-22847-9-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 8/8] target/mips: Fix RDHWR CC with icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

RDHWR CC reads the CPU timer like MFC0 CP0_Count, so with icount enabled
it must set can_do_io while it calls the helper to avoid the "Bad icount
read" error. It should also break out of the translation loop to ensure
that timer interrupts are immediately handled.

Fixes: 2e70f6efa8b9 ("Add instruction counter.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index bcea2a1..c78d272 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10755,8 +10755,19 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_store_gpr(t0, rt);
         break;
     case 2:
+        if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
         gen_helper_rdhwr_cc(t0, cpu_env);
+        if (ctx->tb->cflags & CF_USE_ICOUNT) {
+            gen_io_end();
+        }
         gen_store_gpr(t0, rt);
+        /* Break the TB to be able to take timer interrupts immediately
+           after reading count. BS_STOP isn't sufficient, we need to ensure
+           we break completely out of translated code.  */
+        gen_save_pc(ctx->pc + 4);
+        ctx->bstate = BS_EXCP;
         break;
     case 3:
         gen_helper_rdhwr_ccres(t0, cpu_env);
-- 
2.7.4
