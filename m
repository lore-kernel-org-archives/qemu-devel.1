Received: from eggs.gnu.org ([2001:4830:134:3::10]:42736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKJoo-0005N3-Qw
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 03:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKJoj-00060Y-To
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 03:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKJoj-00060I-Nw
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 03:31:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0AD95D68D
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 07:31:15 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Jun 2017 09:31:09 +0200
Message-Id: <20170612073109.25930-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] ehci: stop recursive calls to ehci_work_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Can happen with usb-storage devices: ehci_work_bh calls usb-storage,
usb-storage calls into block layer, block layer may run BHs.

Add a simple bool and just do nothing in case we figure ehci_work_bh is
active.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.h | 1 +
 hw/usb/hcd-ehci.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 938d8aa284..821f1ded43 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -297,6 +297,7 @@ struct EHCIState {
      */
     QEMUTimer *frame_timer;
     QEMUBH *async_bh;
+    bool working;
     uint32_t astate;         /* Current state in asynchronous schedule */
     uint32_t pstate;         /* Current state in periodic schedule     */
     USBPort ports[NB_PORTS];
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 17c572c55f..73090e01ad 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2241,6 +2241,11 @@ static void ehci_work_bh(void *opaque)
     uint64_t uframes, skipped_uframes;
     int i;
 
+    if (ehci->working) {
+        return;
+    }
+    ehci->working = true;
+
     t_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ns_elapsed = t_now - ehci->last_run_ns;
     uframes = ns_elapsed / UFRAME_TIMER_NS;
@@ -2322,6 +2327,8 @@ static void ehci_work_bh(void *opaque)
         }
         timer_mod(ehci->frame_timer, expire_time);
     }
+
+    ehci->working = false;
 }
 
 static void ehci_work_timer(void *opaque)
-- 
2.9.3
