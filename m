Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0007sD-Kr
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZt-0000lz-Hn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZt-0000ls-Dl
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:13 -0500
Received: by mail-ot0-x242.google.com with SMTP id p16so12206718otf.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:13 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:55 -0600
Message-Id: <1516064279-14816-4-git-send-email-minyard@acm.org>
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/7] ipmi: Don't set the timestamp on add
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

According to the spec, from section "32.3 OEM SEL Record - Type
E0h-FFh", event types from 0x0e to 0xff do not have a timestamp.
So don't set it when adding those types.  This required putting
the timestamp in a temporary buffer, since it's still required
to set the last addition time.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index cc068f2..a0bbfd5 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -443,16 +443,21 @@ static void sel_inc_reservation(IPMISel *sel)
 /* Returns 1 if the SEL is full and can't hold the event. */
 static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
 {
+    uint8_t ts[4];
+
     event[0] = 0xff;
     event[1] = 0xff;
-    set_timestamp(ibs, event + 3);
+    set_timestamp(ibs, ts);
+    if (event[2] < 0xe0) { /* Don't set timestamps for type 0xe0-0xff. */
+        memcpy(event + 3, ts, 4);
+    }
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
