Received: from eggs.gnu.org ([2001:4830:134:3::10]:47925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNez-0007fr-94
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNew-0006pZ-Rj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:58 +0200
Message-Id: <20180608200558.386-14-laurent@vivier.eu>
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
References: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 13/13] dp8393x: fix receiving buffer exhaustion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>

The card is not able to exit from exhaustion state, because
while the drive consumes the buffers, the RRP is incremented
(when the driver clears the ISR RBE bit), so it stays equal
to RWP, and while RRP == RWP, the card thinks it is always
in exhaustion state. So the driver consumes all the buffers,
but the card cannot receive new ones.

This patch fixes the problem by not incrementing RRP when
the driver clears the ISR RBE bit.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 40e5f8257b..fd0f6cf2a0 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -314,7 +314,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     dp8393x_update_irq(s);
 }
 
-static void dp8393x_do_read_rra(dp8393xState *s)
+static void dp8393x_do_read_rra(dp8393xState *s, int next)
 {
     int width, size;
 
@@ -333,19 +333,20 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
 
-    /* Go to next entry */
-    s->regs[SONIC_RRP] += size;
+    if (next) {
+        /* Go to next entry */
+        s->regs[SONIC_RRP] += size;
 
-    /* Handle wrap */
-    if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
-        s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
-    }
+        /* Handle wrap */
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_REA]) {
+            s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
+        }
 
-    /* Check resource exhaustion */
-    if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP])
-    {
-        s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
-        dp8393x_update_irq(s);
+        /* Check resource exhaustion */
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP]) {
+            s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
+            dp8393x_update_irq(s);
+        }
     }
 
     /* Done */
@@ -559,7 +560,7 @@ static void dp8393x_do_command(dp8393xState *s, uint16_t command)
     if (command & SONIC_CR_RST)
         dp8393x_do_software_reset(s);
     if (command & SONIC_CR_RRRA)
-        dp8393x_do_read_rra(s);
+        dp8393x_do_read_rra(s, 1);
     if (command & SONIC_CR_LCAM)
         dp8393x_do_load_cam(s);
 }
@@ -650,7 +651,7 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
             data &= s->regs[reg];
             s->regs[reg] &= ~data;
             if (data & SONIC_ISR_RBE) {
-                dp8393x_do_read_rra(s);
+                dp8393x_do_read_rra(s, 0);
             }
             dp8393x_update_irq(s);
             if (dp8393x_can_receive(s->nic->ncs)) {
@@ -852,7 +853,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
         if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
             /* Read next RRA */
-            dp8393x_do_read_rra(s);
+            dp8393x_do_read_rra(s, 1);
         }
     }
 
-- 
2.14.4
