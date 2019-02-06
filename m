Received: from eggs.gnu.org ([209.51.188.92]:58582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNO9-00050V-Up
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1grNO9-0003mC-5x
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:17 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1grNO8-0003lu-U2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:37:17 -0500
From: Liam Merwick <liam.merwick@oracle.com>
Date: Wed,  6 Feb 2019 13:36:52 +0000
Message-Id: <1549460216-25808-6-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v2 5/9] ohci: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: liam.merwick@oracle.com, darren.kenny@oracle.com

A call to ohci_find_device() can return NULL if it doesn't find a
device matching 'addr' so for the two callers, explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/usb/hcd-ohci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c34cf5b73a3a..196a9f72002d 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -848,6 +848,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
         bool int_req = relative_frame_number == frame_count &&
                        OHCI_BM(iso_td.flags, TD_DI) == 0;
         dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
+        if (dev == NULL) {
+            trace_usb_ohci_td_dev_error();
+            return 1;
+        }
         ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
         usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, false, int_req);
         usb_packet_addbuf(&ohci->usb_packet, ohci->usb_buf, len);
@@ -1071,6 +1075,10 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
             return 1;
         }
         dev = ohci_find_device(ohci, OHCI_BM(ed->flags, ED_FA));
+        if (dev == NULL) {
+            trace_usb_ohci_td_dev_error();
+            return 1;
+        }
         ep = usb_ep_get(dev, pid, OHCI_BM(ed->flags, ED_EN));
         usb_packet_setup(&ohci->usb_packet, pid, ep, 0, addr, !flag_r,
                          OHCI_BM(td.flags, TD_DI) == 0);
-- 
1.8.3.1
