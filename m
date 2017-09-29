Received: from eggs.gnu.org ([2001:4830:134:3::10]:43803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dy1hy-0002cO-T4
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dy1hu-0005Bj-L4
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:16:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:38982)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dy1hu-00058q-EY
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:16:22 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Fri, 29 Sep 2017 21:15:56 +0100
Message-ID: <0cadfe03c2cd47171767e374764c4641a00c841f.1506716058.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target/mips: Preserve read-only CP0_WatchHi
 bits
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>
List-ID: <qemu-devel.nongnu.org>

Currently all read-only bits of the CP0_WatchHi registers are cleared by
MTC0, including the M bit which indicates whether more watch registers
exist, and the IRW bits which would be set when a watch is hit (if
watchpoints were actually fully supported by QEMU) and are only cleared
when 1 is written to them. Fix it so that the read-only bits are
properly preserved.

Reported-by: Tam Robb <tam.robb@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org
---
 target/mips/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 320f2b0dc473..f7d740118f8b 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -1662,7 +1662,7 @@ void helper_mtc0_watchlo(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 void helper_mtc0_watchhi(CPUMIPSState *env, target_ulong arg1, uint32_t sel)
 {
     int mask = 0x40000FF8 | (env->CP0_EntryHi_ASID_mask << CP0WH_ASID);
-    env->CP0_WatchHi[sel] = arg1 & mask;
+    env->CP0_WatchHi[sel] ^= (env->CP0_WatchHi[sel] ^ arg1) & mask;
     env->CP0_WatchHi[sel] &= ~(env->CP0_WatchHi[sel] & arg1 & 0x7);
 }
 
-- 
git-series 0.8.10
