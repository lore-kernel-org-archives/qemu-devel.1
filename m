Received: from eggs.gnu.org ([2001:4830:134:3::10]:46090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cgUbG-0007xS-Uw
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cgUbC-0007LO-0g
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:47 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cgUbB-0007Kv-Pp
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:56:41 -0500
Received: by mail-wr0-x244.google.com with SMTP id s27so1005372wrb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 02:56:40 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 22 Feb 2017 02:56:30 -0800
Message-Id: <1487760990-115925-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH] usb: ohci: fix error return code in servicing
 td
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: ppandit@redhat.com, Li Qiang <liqiang6-s@360.cn>

It should return 1 if an error occurs when reading td.
This will avoid an infinite loop issue in ohci_service_ed_list.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/usb/hcd-ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 21c93e0..fe8406a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1001,7 +1001,7 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
     if (ohci_read_td(ohci, addr, &td)) {
         trace_usb_ohci_td_read_error(addr);
         ohci_die(ohci);
-        return 0;
+        return 1;
     }
 
     dir = OHCI_BM(ed->flags, ED_D);
-- 
1.8.3.1
