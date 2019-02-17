Received: from eggs.gnu.org ([209.51.188.92]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvKlf-0000HQ-Tu
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 06:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gvKlW-00059Y-EV
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 06:37:48 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:54559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gvKlT-000583-7r
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 06:37:44 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Sun, 17 Feb 2019 12:37:17 +0100
Message-Id: <20190217113717.7077-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] lsi: check if SIGP bit is already set in Wait
 reselect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

If SIGP is set, the 'Wait for Reselection' command should jump
immediately to the address stored in the second DWORD of the
instruction. This fixes spurious hangs in the HP-UX 11.11
installer when the SIGP bit gets set by the kernel before the
'Wait for Reselection' command is executed by SCRIPTS.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lsi53c895a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 8ba07f8756..bcff859bac 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1297,8 +1297,10 @@ again:
                 }
                 break;
             case 2: /* Wait Reselect */
-                if (!lsi_irq_on_rsl(s)) {
-                    lsi_wait_reselect(s);
+                if (s->istat0 & LSI_ISTAT0_SIGP) {
+                    s->dsp = s->dnad;
+                } else if (!lsi_irq_on_rsl(s)) {
+                        lsi_wait_reselect(s);
                 }
                 break;
             case 3: /* Set */
-- 
2.20.1
