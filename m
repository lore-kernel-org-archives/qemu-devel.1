Received: from eggs.gnu.org ([2001:4830:134:3::10]:47794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUF-0002RR-4V
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUA-0001W3-KS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUA-0001Vg-FW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:06 -0400
Message-Id: <20180608174733.4936-4-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 03/30] ahci: don't schedule unnecessary BH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

The comment gives us a hint. *Maybe* we still have something to
process. Well, why not check?

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180531004323.4611-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index b11640ddbb..ac4bc1738b 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1427,8 +1427,7 @@ static void ahci_cmd_done(IDEDMA *dma)
     /* update d2h status */
     ahci_write_fis_d2h(ad);
 
-    if (!ad->check_bh) {
-        /* maybe we still have something to process, check later */
+    if (ad->port_regs.cmd_issue && !ad->check_bh) {
         ad->check_bh = qemu_bh_new(ahci_check_cmd_bh, ad);
         qemu_bh_schedule(ad->check_bh);
     }
-- 
2.14.3
