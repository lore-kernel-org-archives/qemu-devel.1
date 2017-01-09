Received: from eggs.gnu.org ([2001:4830:134:3::10]:54022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQZg9-0003us-88
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:08:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQZg6-0007o1-0c
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:08:01 -0500
Received: from mail.sysgo.com ([176.9.12.79]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rka@sysgo.com>) id 1cQZg5-0007ng-PT
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:07:57 -0500
From: Roman Kapl <rka@sysgo.com>
Date: Mon,  9 Jan 2017 14:07:49 +0100
Message-Id: <20170109130749.9795-1-rka@sysgo.com>
In-Reply-To: <148396120962.205.623546213408864755@790289a7ca88>
References: <148396120962.205.623546213408864755@790289a7ca88>
Subject: [Qemu-devel] [PATCH v2] ppc: Prevent inifnite loop in decrementer
 auto-reload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kapl <rka@sysgo.com>

If the DECAR register is set to 0, QEMU tries to reload the decrementer with
zero in an inifinite loop. According to PPC documentation, the decrementer is
triggered on 1->0 transition, so avoid reloading the decrementer if if is
already zero.

The problem does not manifest under Linux, but it is valid to set DECAR to zero
(and may make sense as part of decrementer initialization when interrupts are
disabled).

Signed-off-by: Roman Kapl <rka@sysgo.com>
---
 hw/ppc/ppc_booke.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ab8d026..60baffa 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -198,8 +198,12 @@ static void booke_decr_cb(void *opaque)
     booke_update_irq(cpu);
 
     if (env->spr[SPR_BOOKE_TCR] & TCR_ARE) {
-        /* Auto Reload */
-        cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
+        /* Do not reload 0, it is already there. It would just trigger
+         * the timer again and lead to infinite loop */
+        if (env->spr[SPR_BOOKE_DECAR] != 0) {
+            /* Auto Reload */
+            cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
+        }
     }
 }
 
-- 
2.10.1
