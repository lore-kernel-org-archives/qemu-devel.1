Received: from eggs.gnu.org ([2001:4830:134:3::10]:51881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jy-0007Yt-Fc
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jt-0003xK-Me
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:26 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:04 +1100
Message-Id: <20170202051445.5735-67-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 066/107] ppc: Prevent inifnite loop in
 decrementer auto-reload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Roman Kapl <rka@sysgo.com>, David Gibson <david@gibson.dropbear.id.au>

From: Roman Kapl <rka@sysgo.com>

If the DECAR register is set to 0, QEMU tries to reload the decrementer with
zero in an inifinite loop. According to PPC documentation, the decrementer is
triggered on 1->0 transition, so avoid reloading the decrementer if if is
already zero.

The problem does not manifest under Linux, but it is valid to set DECAR to zero
(and may make sense as part of decrementer initialization when interrupts are
disabled).

Signed-off-by: Roman Kapl <rka@sysgo.com>
[dwg: Fixed style nit]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.9.3
