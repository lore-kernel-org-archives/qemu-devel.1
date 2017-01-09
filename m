Received: from eggs.gnu.org ([2001:4830:134:3::10]:59129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQY3p-0002Kz-DW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1cQY3l-0000ns-GJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:24:21 -0500
Received: from mail.sysgo.com ([176.9.12.79]:43934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rka@sysgo.com>) id 1cQY3l-0000na-9B
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:24:17 -0500
From: Roman Kapl <rka@sysgo.com>
Date: Mon,  9 Jan 2017 12:23:38 +0100
Message-Id: <20170109112338.5629-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH] ppc: Prevent inifnite loop in decrementer
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
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Roman Kapl <rka@sysgo.com>

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
index ab8d026..f8d5c28 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -198,8 +198,12 @@ static void booke_decr_cb(void *opaque)
     booke_update_irq(cpu);
 
     if (env->spr[SPR_BOOKE_TCR] & TCR_ARE) {
-        /* Auto Reload */
-        cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
+        /* Do not reload 0, it is already there. It would just trigger
+         * the timer again and lead to infinite loop */
+        if(env->spr[SPR_BOOKE_DECAR] != 0) {
+            /* Auto Reload */
+            cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
+        }
     }
 }
 
-- 
2.10.1
