Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yZ-4L
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4ga-000880-MH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4ga-000878-GW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:32 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:17 +0100
Message-Id: <1487661385-7720-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] usb: ohci: limit the number of link eds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>

From: Li Qiang <liqiang6-s@360.cn>

The guest may builds an infinite loop with link eds. This patch
limit the number of linked ed to avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 5899a02e.45ca240a.6c373.93c1@mx.google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 2cba3e3..21c93e0 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -42,6 +42,8 @@
 
 #define OHCI_MAX_PORTS 15
 
+#define ED_LINK_LIMIT 4
+
 static int64_t usb_frame_time;
 static int64_t usb_bit_time;
 
@@ -1184,7 +1186,7 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head, int completion)
     uint32_t next_ed;
     uint32_t cur;
     int active;
-
+    uint32_t link_cnt = 0;
     active = 0;
 
     if (head == 0)
@@ -1199,6 +1201,11 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head, int completion)
 
         next_ed = ed.next & OHCI_DPTR_MASK;
 
+        if (++link_cnt > ED_LINK_LIMIT) {
+            ohci_die(ohci);
+            return 0;
+        }
+
         if ((ed.head & OHCI_ED_H) || (ed.flags & OHCI_ED_K)) {
             uint32_t addr;
             /* Cancel pending packets for ED that have been paused.  */
-- 
1.8.3.1
