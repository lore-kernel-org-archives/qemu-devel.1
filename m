Received: from eggs.gnu.org ([2001:4830:134:3::10]:45725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdB0-00065W-Mi
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dtdAy-0006DI-9e
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 13:16:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 17 Sep 2017 18:15:47 +0100
Message-Id: <1505668548-16616-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 7/8] openpic: add missing timer fields to
 vmstate_openpic_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, benh@kernel.crashing.org

Observation of the code shows indicates that several timer fields are
missing from the migration stream.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/intc/openpic.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 10d6e87..debfcbf 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1570,11 +1570,14 @@ static const VMStateDescription vmstate_openpic_irqsource = {
 
 static const VMStateDescription vmstate_openpic_timer = {
     .name = "openpic_timer",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(tccr, OpenPICTimer),
         VMSTATE_UINT32(tbcr, OpenPICTimer),
+        VMSTATE_BOOL(qemu_timer_active, OpenPICTimer),
+        VMSTATE_TIMER_PTR(qemu_timer, OpenPICTimer),
+        VMSTATE_UINT64(origin_time, OpenPICTimer),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -1620,7 +1623,7 @@ static const VMStateDescription vmstate_openpic = {
         VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState, NULL),
         VMSTATE_STRUCT_VARRAY_UINT32(dst, OpenPICState, nb_cpus, 0,
                                      vmstate_openpic_irqdest, IRQDest),
-        VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 0,
+        VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 1,
                              vmstate_openpic_timer, OpenPICTimer),
         VMSTATE_STRUCT_ARRAY(msi, OpenPICState, MAX_MSI, 0,
                              vmstate_openpic_msi, OpenPICMSI),
-- 
1.7.10.4
