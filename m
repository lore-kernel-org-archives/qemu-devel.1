Received: from eggs.gnu.org ([2001:4830:134:3::10]:49232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCL-0000br-M3
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eMfCI-0000Ve-GI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eMfCI-0000UU-7d
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:17:34 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6JFjhV143508
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 14:17:33 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epmh3e36f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 14:17:32 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 12:17:31 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed,  6 Dec 2017 13:16:21 -0600
In-Reply-To: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
References: <20171206191648.18208-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171206191648.18208-29-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 28/55] hw/sd: fix out-of-bounds check for multi
 block reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Olbrich <m.olbrich@pengutronix.de>, Peter Maydell <peter.maydell@linaro.org>

From: Michael Olbrich <m.olbrich@pengutronix.de>

The current code checks if the next block exceeds the size of the card.
This generates an error while reading the last block of the card.
Do the out-of-bounds check when starting to read a new block to fix this.

This issue became visible with increased error checking in Linux 4.13.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Olbrich <m.olbrich@pengutronix.de>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20170916091611.10241-1-m.olbrich@pengutronix.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 8573378e62d19e25a2434e23462ec99ef4d065ac)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ba47bff4db..35347a5bbc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1797,8 +1797,13 @@ uint8_t sd_read_data(SDState *sd)
         break;
 
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
-        if (sd->data_offset == 0)
+        if (sd->data_offset == 0) {
+            if (sd->data_start + io_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return 0x00;
+            }
             BLK_READ_BLOCK(sd->data_start, io_len);
+        }
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len) {
@@ -1812,11 +1817,6 @@ uint8_t sd_read_data(SDState *sd)
                     break;
                 }
             }
-
-            if (sd->data_start + io_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-                break;
-            }
         }
         break;
 
-- 
2.11.0
