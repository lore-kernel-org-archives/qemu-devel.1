Received: from eggs.gnu.org ([2001:4830:134:3::10]:40243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1eneny-0002VG-98
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:20:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1enenv-0007cc-5J
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:20:02 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:46959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1enenu-0007an-RS
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:19:59 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Mon, 19 Feb 2018 07:18:27 +0100
Message-Id: <20180219061827.2112-6-david.brenken@efs-auto.org>
In-Reply-To: <20180219061827.2112-1-david.brenken@efs-auto.org>
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 5/5] tricore: fixed wrong shifting of PCXI PIE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>, Florian Artmeier <florian.artmeier@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Florian Artmeier <florian.artmeier@efs-auto.de>
---
 target/tricore/op_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 7af202c..491f97d 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2605,7 +2605,8 @@ void helper_rfe(CPUTriCoreState *env)
     }
     env->PC = env->gpr_a[11] & ~0x1;
     /* ICR.IE = PCXI.PIE; */
-    env->ICR = (env->ICR & ~MASK_ICR_IE) + ((env->PCXI & MASK_PCXI_PIE) >> 15);
+    env->ICR = (env->ICR & ~MASK_ICR_IE)
+            | ((env->PCXI & MASK_PCXI_PIE) >> (21 - 15));
     /* ICR.CCPN = PCXI.PCPN; */
     env->ICR = (env->ICR & ~MASK_ICR_CCPN) +
                ((env->PCXI & MASK_PCXI_PCPN) >> 24);
-- 
2.7.4
