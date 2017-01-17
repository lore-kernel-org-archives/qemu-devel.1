Received: from eggs.gnu.org ([2001:4830:134:3::10]:50387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1cTZ0i-0004uK-Q2
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1cTZ0f-0002N5-4n
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:36 -0500
Received: from mx1.riseup.net ([198.252.153.129]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anonym@riseup.net>) id 1cTZ0e-0002MD-VP
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:33 -0500
Received: from piha.riseup.net (unknown [10.0.1.163])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net",
	Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id CFC951A247A
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:01:31 +0000 (UTC)
From: anonym@riseup.net
Date: Tue, 17 Jan 2017 20:00:56 +0100
Message-Id: <20170117190056.1195-2-anonym@riseup.net>
In-Reply-To: <20170117190056.1195-1-anonym@riseup.net>
References: <20170117190056.1195-1-anonym@riseup.net>
Subject: [Qemu-devel] [PATCH] xhci: bump the link TRB cycle detection limit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anonym <anonym@riseup.net>

From: anonym <anonym@riseup.net>

While formatting partitions (on virtual USB drives and the nec-xhci
virtual USB controller) to EXT4, I have observed errors like these:

    kernel: sd 8:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_ABORT
    driverbyte=DRIVER_OK
    kernel: sd 8:0:0:0: [sda] tag#0 CDB: Write(10) 2a 00 00 66 49 86
    00 08 00 00
    kernel: blk_update_request: I/O error, dev sda, sector 6703494
    kernel: Buffer I/O error on dev dm-0, logical block 1573254, lost
    async page write

Raising TRB_LINK_LIMIT fixes the limit, but the new value was
admittedly arbitrarily chosen.

Regarding cycle detection in general, allowing at most 4 levels of
links seems pretty low. This bump should be safe: a high number only
means that we get a performance hit when encountering cycles but then
we should have a fatal error any way; a low number instead means that
we'll incorrectly identify cycles and abort operations that otherwise
would succeed, like in the case above.

Signed-off-by: anonym <anonym@riseup.net>
---
 hw/usb/hcd-xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4acf0c6dd8..d14ce126a2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -53,7 +53,7 @@
  * to the specs when it gets them */
 #define ER_FULL_HACK
 
-#define TRB_LINK_LIMIT  4
+#define TRB_LINK_LIMIT  32
 
 #define LEN_CAP         0x40
 #define LEN_OPER        (0x400 + 0x10 * MAXPORTS)
-- 
2.11.0
