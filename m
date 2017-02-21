Received: from eggs.gnu.org ([2001:4830:134:3::10]:59258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yh-5U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4ga-00087q-Ks
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4ga-000877-FZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:32 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:16 +0100
Message-Id: <1487661385-7720-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] usb: ohci: fix error return code in
 servicing iso td
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

It should return 1 if an error occurs when reading iso td.
This will avoid an infinite loop issue in ohci_service_ed_list.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-id: 5899ac3e.1033240a.944d5.9a2d@mx.google.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c82a92f..2cba3e3 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -725,7 +725,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
     if (ohci_read_iso_td(ohci, addr, &iso_td)) {
         trace_usb_ohci_iso_td_read_failed(addr);
         ohci_die(ohci);
-        return 0;
+        return 1;
     }
 
     starting_frame = OHCI_BM(iso_td.flags, TD_SF);
-- 
1.8.3.1
