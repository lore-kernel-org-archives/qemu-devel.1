Received: from eggs.gnu.org ([2001:4830:134:3::10]:39630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d97hB-000527-R8
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d97h8-00065a-Pf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d97h8-000641-JO
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:21:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B71F448D82
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 10:21:09 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 12 May 2017 12:21:00 +0200
Message-Id: <20170512102100.22675-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] xhci: relax link check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

The strict td link limit added by commit "05f43d4 xhci: limit the
number of link trbs we are willing to process" causes problems with
Windows guests. Let's raise the limit.

This change is analogous to:

  commit ab6b1105a2259c7072905887f71caa850ce63190
  Author: Gerd Hoffmann <kraxel@redhat.com>
  Date:   Tue Mar 7 09:40:18 2017 +0100

      ohci: relax link check

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/usb/hcd-xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d3d47bf..77d8e11 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -50,7 +50,7 @@
 /* Very pessimistic, let's hope it's enough for all cases */
 #define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
 
-#define TRB_LINK_LIMIT  4
+#define TRB_LINK_LIMIT  32
 #define COMMAND_LIMIT   256
 #define TRANSFER_LIMIT  256
 
-- 
2.9.3
