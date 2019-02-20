Received: from eggs.gnu.org ([209.51.188.92]:56285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpO-0008LA-8x
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwPpN-0008Nv-CP
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwPpM-0007V1-1B
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 06:14:12 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 20 Feb 2019 12:13:42 +0100
Message-Id: <20190220111346.13669-6-kraxel@redhat.com>
In-Reply-To: <20190220111346.13669-1-kraxel@redhat.com>
References: <20190220111346.13669-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] ohci: check device is not NULL before
 calling usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Liam Merwick <liam.merwick@oracle.com>

From: Liam Merwick <liam.merwick@oracle.com>

A call to ohci_find_device() can return NULL if it doesn't find a
device matching 'addr' so for the two callers, explicitly check
the return value before passing it to usb_ep_get().

Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
Message-id: 1549460216-25808-6-git-send-email-liam.merwick@oracle.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c34cf5b73a..196a9f7200 100644
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
2.9.3
