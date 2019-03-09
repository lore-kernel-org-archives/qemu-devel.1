Received: from eggs.gnu.org ([209.51.188.92]:47334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wih-0003t9-4b
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000Wh-C1
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wig-0000Tc-3n
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id f3so14573501wmj.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:04 +0100
Message-Id: <1552117698-12355-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 11/25] lsi: check if SIGP bit is already set in
 Wait reselect
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
