Received: from eggs.gnu.org ([209.51.188.92]:60710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODW-00072C-Bl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h3ODU-00031c-DF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h3ODS-0002yb-HJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:55:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id t124so551299wma.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:55:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2019 17:55:17 +0100
Message-Id: <1552323335-46779-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL v2 13/31] lsi: check if SIGP bit is already set
 in Wait reselect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

If SIGP is set, the 'Wait for Reselection' command should jump
immediately to the address stored in the second DWORD of the
instruction. This fixes spurious hangs in the HP-UX 11.11
installer when the SIGP bit gets set by the kernel before the
'Wait for Reselection' command is executed by SCRIPTS.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Message-Id: <20190217113717.7077-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 8ba07f8..bcff859 100644
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
1.8.3.1
