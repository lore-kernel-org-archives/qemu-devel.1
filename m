Received: from eggs.gnu.org ([2001:4830:134:3::10]:41819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUD-0000DY-BF
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djBUA-0007Fl-VE
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:53 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djBUA-00078d-P7
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 17:40:50 -0400
Received: by mail-pf0-x244.google.com with SMTP id t83so3486688pfj.3
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 14:40:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Sat, 19 Aug 2017 16:40:39 -0500
Message-Id: <1503178840-21512-3-git-send-email-minyard@acm.org>
In-Reply-To: <1503178840-21512-1-git-send-email-minyard@acm.org>
References: <1503178840-21512-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 2/3] ipmi: Don't set the timestamp on add
 events that don't have it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

According to the spec, event types from 0x0e to 0xff do not have a
timestamp.  So don't set it when adding those types.  This required
putting the timestamp in a temporary buffer, since it's still required
to set the last addition time.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 1c732aa..0f191e8 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -443,16 +443,20 @@ static void sel_inc_reservation(IPMISel *sel)
 /* Returns 1 if the SEL is full and can't hold the event. */
 static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
 {
+    uint8_t ts[4];
+
     event[0] = 0xff;
     event[1] = 0xff;
-    set_timestamp(ibs, event + 3);
+    set_timestamp(ibs, ts);
+    if (event[2] < 0xe0) /* Don't set timestamps for these, per the spec. */
+        memcpy(event + 3, ts, 4);
     if (ibs->sel.next_free == MAX_SEL_SIZE) {
         ibs->sel.overflow = 1;
         return 1;
     }
     event[0] = ibs->sel.next_free & 0xff;
     event[1] = (ibs->sel.next_free >> 8) & 0xff;
-    memcpy(ibs->sel.last_addition, event + 3, 4);
+    memcpy(ibs->sel.last_addition, ts, 4);
     memcpy(ibs->sel.sel[ibs->sel.next_free], event, 16);
     ibs->sel.next_free++;
     sel_inc_reservation(&ibs->sel);
-- 
2.7.4
