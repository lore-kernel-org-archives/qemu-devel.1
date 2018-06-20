Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzy-0008TF-87
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbzv-0007y1-0I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:06 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:59138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbzu-0007tv-NI
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:02 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:12 +0100
Message-ID: <20180620120620.12806-28-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 27/35] target/mips: Fix nanoMIPS
 set_hflags_for_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: James Hogan <james.hogan@imgtec.com>

We shouldn't clear M16 mode when entering an interrupt on nanoMIPS,
otherwise we'll start interpreting the code as normal MIPS code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 20a81aa..efc3f25 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -671,6 +671,9 @@ target_ulong exception_resume_pc (CPUMIPSState *env)
 #if !defined(CONFIG_USER_ONLY)
 static void set_hflags_for_handler (CPUMIPSState *env)
 {
+    if (env->insn_flags & ISA_NANOMIPS32) {
+        return;
+    }
     /* Exception handlers are entered in 32-bit mode.  */
     env->hflags &= ~(MIPS_HFLAG_M16);
     /* ...except that microMIPS lets you choose.  */
-- 
1.9.1
