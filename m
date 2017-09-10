Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N2-0007dS-PM
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dr3N0-0000VH-JD
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 10:38:00 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 10 Sep 2017 15:37:35 +0100
Message-Id: <1505054255-2990-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/4] ppc: ensure we update the decrementer
 value during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, aik@ozlabs.ru, lvivier@redhat.com

During local testing with TCG, intermittent errors were found when trying to
migrate Darwin OS images.

The underlying cause was that Darwin resets the decrementer value to fairly
small values on each interrupt. cpu_ppc_set_tb_clk() sets the default value
of the decrementer to 0xffffffff during initialisation which typically
corresponds to several seconds. Hence when restoring the image, the guest
would effectively "lose" decrementer interrupts during this time causing
confusion in the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/machine.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 10b3c41..a16a856 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -176,6 +176,7 @@ static void cpu_pre_save(void *opaque)
     env->spr[SPR_CFAR] = env->cfar;
 #endif
     env->spr[SPR_BOOKE_SPEFSCR] = env->spe_fscr;
+    env->spr[SPR_DECR] = cpu_ppc_load_decr(env);
 
     for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
         env->spr[SPR_DBAT0U + 2*i] = env->DBAT[0][i];
@@ -280,6 +281,7 @@ static int cpu_post_load(void *opaque, int version_id)
     env->cfar = env->spr[SPR_CFAR];
 #endif
     env->spe_fscr = env->spr[SPR_BOOKE_SPEFSCR];
+    cpu_ppc_store_decr(env, env->spr[SPR_DECR]);
 
     for (i = 0; (i < 4) && (i < env->nb_BATs); i++) {
         env->DBAT[0][i] = env->spr[SPR_DBAT0U + 2*i];
-- 
1.7.10.4
