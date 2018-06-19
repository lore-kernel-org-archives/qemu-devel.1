Received: from eggs.gnu.org ([2001:4830:134:3::10]:44373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gQ-0008Op-Uy
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5gP-0007YX-KU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:43:47 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:43:05 -0500
Message-Id: <20180619014319.28272-100-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 099/113] ahci: fix PxCI register race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>

From: John Snow <jsnow@redhat.com>

Fixes: https://bugs.launchpad.net/qemu/+bug/1769189

AHCI presently signals completion prior to the PxCI register being
cleared to indicate completion. If a guest driver attempts to issue
a new command in its IRQ handler, it might be surprised to learn there
is still a command pending.

In the case of Windows 10's boot driver, it will actually poll the IRQ
register hoping to find out when the command is done running -- which
will never happen, as there isn't a command running.

Fix this: clear PxCI in ahci_cmd_done and not in the asynchronous BH.
Because it now runs synchronously, we don't need to check if the command
is actually done by spying on the ATA registers. We know it's done.

CC: qemu-stable <qemu-stable@nongnu.org>
Reported-by: François Guerraz <kubrick@fgv6.net>
Tested-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180531004323.4611-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit 5694c7eacce6b263ad7497cc1bb76aad746cfd4e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ide/ahci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 373311f91a..0741f3405e 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -533,13 +533,6 @@ static void ahci_check_cmd_bh(void *opaque)
     qemu_bh_delete(ad->check_bh);
     ad->check_bh = NULL;
 
-    if ((ad->busy_slot != -1) &&
-        !(ad->port.ifs[0].status & (BUSY_STAT|DRQ_STAT))) {
-        /* no longer busy */
-        ad->port_regs.cmd_issue &= ~(1 << ad->busy_slot);
-        ad->busy_slot = -1;
-    }
-
     check_cmd(ad->hba, ad->port_no);
 }
 
@@ -1426,6 +1419,12 @@ static void ahci_cmd_done(IDEDMA *dma)
 
     trace_ahci_cmd_done(ad->hba, ad->port_no);
 
+    /* no longer busy */
+    if (ad->busy_slot != -1) {
+        ad->port_regs.cmd_issue &= ~(1 << ad->busy_slot);
+        ad->busy_slot = -1;
+    }
+
     /* update d2h status */
     ahci_write_fis_d2h(ad);
 
-- 
2.11.0
