Received: from eggs.gnu.org ([2001:4830:134:3::10]:49313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cb3ju-0008KV-TK
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cb3jr-0002uW-Ps
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:15:14 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cb3jr-0002uN-LA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:15:11 -0500
Received: by mail-io0-x242.google.com with SMTP id m98so12484407iod.2
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:15:11 -0800 (PST)
Message-ID: <5899ac3e.1033240a.944d5.9a2d@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue,  7 Feb 2017 03:15:03 -0800
Subject: [Qemu-devel] [PATCH] usb: ohci: fix error return code in servicing
 iso td
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

It should return 1 if an error occurs when reading iso td.
This will avoid an infinite loop issue in ohci_service_ed_list.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 4a63f3b..21c93e0 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -727,7 +727,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
     if (ohci_read_iso_td(ohci, addr, &iso_td)) {
         trace_usb_ohci_iso_td_read_failed(addr);
         ohci_die(ohci);
-        return 0;
+        return 1;
     }
 
     starting_frame = OHCI_BM(iso_td.flags, TD_SF);
-- 
1.8.3.1
