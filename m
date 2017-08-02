Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRD-0003JQ-Ns
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRC-0002cG-4N
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:35 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:23078)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRB-0002aN-Uf
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:34 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 2 Aug 2017 10:59:17 +0100
Message-ID: <248e7141b59e3cce8768f8210ade7f19108c92fa.1501667615.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 3/3] target/mips: Fix RDHWR CC with
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

RDHWR CC reads the CPU timer like MFC0 CP0_Count, so with icount enabled
it must set can_do_io while it calls the helper to avoid the "Bad icount
read" error. It should also break out of the translation loop to ensure
that timer interrupts are immediately handled.

Fixes: 2e70f6efa8b9 ("Add instruction counter.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
---
I've based this on MFC0 Count, but this instruction is also available to
usermode (e.g. CONFIG_USER_ONLY), which I presume is still fine.
---
 target/mips/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+), 0 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6e724ac71dcd..f29092f6d4ac 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10759,8 +10759,19 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
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
git-series 0.8.10
