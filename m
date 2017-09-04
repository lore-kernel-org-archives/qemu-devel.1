Received: from eggs.gnu.org ([2001:4830:134:3::10]:52956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSk-0005Fs-Bx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSY-00052l-2m
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSX-000503-PL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSW-0005ej-IT
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:26:07 +0100
Message-Id: <1504527967-29248-37-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/36] arm_gicv3_kvm: Fix compile warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pranith Kumar <bobby.prani@gmail.com>

Fix the following warning:

/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: warning: logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^             ~
/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses after the '!' to evaluate the bitwise operator first
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^
/home/pranith/qemu/hw/intc/arm_gicv3_kvm.c:296:17: note: add parentheses around left hand side expression to silence this warning
            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
                ^

This logic error meant we were not setting the PTZ
bit when we should -- luckily as the comment suggests
this wouldn't have had any effects beyond making GIC
initialization take a little longer.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-id: 20170829173226.7625-1-bobby.prani@gmail.com
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6051c77..481fe54 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -293,7 +293,7 @@ static void kvm_arm_gicv3_put(GICv3State *s)
             kvm_gicr_access(s, GICR_PROPBASER + 4, ncpu, &regh, true);
 
             reg64 = c->gicr_pendbaser;
-            if (!c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS) {
+            if (!(c->gicr_ctlr & GICR_CTLR_ENABLE_LPIS)) {
                 /* Setting PTZ is advised if LPIs are disabled, to reduce
                  * GIC initialization time.
                  */
-- 
2.7.4
