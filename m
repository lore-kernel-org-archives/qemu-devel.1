Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ghFie-0003AB-6P
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1ghFid-0007GD-Hh
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:24:36 -0500
From: Alexander Graf <agraf@suse.de>
Date: Wed,  9 Jan 2019 16:24:30 +0100
Message-Id: <20190109152430.32359-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] target/arm: Allow to switch from MON->HYP on
 AArch32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@xilinx.com>

In U-boot, we switch from S-SVC -> MON -> HYP when we want to enter
HYP mode. This dance seems to work ok (hence it's there in the code
base), but breaks with current QEMU.

The reason seems to be that we try to see whether we are entering
HYP mode from the NS side. However, MON is always considered secure,
so we always fall into an error case when going MON->HYP and never
manage to actually do the switch.

Fix this by not using a different helper function that does not bork
when we're in MON state, as that switch is supposed to work.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f00c141ef9..9bf8fbd8f9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6297,7 +6297,7 @@ static int bad_mode_switch(CPUARMState *env, int mode, CPSRWriteType write_type)
         return 0;
     case ARM_CPU_MODE_HYP:
         return !arm_feature(env, ARM_FEATURE_EL2)
-            || arm_current_el(env) < 2 || arm_is_secure(env);
+            || arm_current_el(env) < 2 || arm_is_secure_below_el3(env);
     case ARM_CPU_MODE_MON:
         return arm_current_el(env) < 3;
     default:
-- 
2.12.3
