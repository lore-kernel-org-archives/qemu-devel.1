Received: from eggs.gnu.org ([2001:4830:134:3::10]:34867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbtI-0002WU-Sg
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbtH-0003Nb-GO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:12 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbtH-0003Ks-AV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:07:11 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:05:47 +0100
Message-ID: <20180620120620.12806-3-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 02/35] target/mips: Fix microMIPS on reset
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

From: Yongbok Kim <yongbok.kim@imgtec.com>

Fix to activate microMIPS (and nanoMIPS) on reset when Config3.ISA == {1, 3}

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e57d71e..bfbc300 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20713,6 +20713,11 @@ void cpu_state_reset(CPUMIPSState *env)
         env->CP0_Status |= (1 << CP0St_FR);
     }
 
+    if (env->CP0_Config3 & (1 << CP0C3_ISA)) {
+        /*  microMIPS/nanoMIPS on reset when Config3.ISA == {1, 3} */
+        env->hflags |= MIPS_HFLAG_M16;
+    }
+
     /* MSA */
     if (env->CP0_Config3 & (1 << CP0C3_MSAP)) {
         msa_reset(env);
-- 
1.9.1
