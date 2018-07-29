Received: from eggs.gnu.org ([2001:4830:134:3::10]:49505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fjrET-0000AV-N5
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 15:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fjrEQ-0006i3-IZ
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 15:19:57 -0400
Received: from relay2.mail.vrmd.de ([81.28.224.28]:47036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mail@sebastianbauer.info>)
	id 1fjrEQ-0006hS-BI
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 15:19:54 -0400
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Sun, 29 Jul 2018 21:19:28 +0200
Message-Id: <20180729191928.11254-1-mail@sebastianbauer.info>
Subject: [Qemu-devel] [PATCH] ohci: Clear the interrupt counter for
 erroneous transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mail@sebastianbauer.info
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

This is mandated by the ohci specification. It tells at 6.4.4 on page 104
that for transfer descriptors that are retired with an error the done
queue interrupt counter is cleared as if the interrupt delay field of the
descriptions were zero.

Before this change, error conditions were handled similarly to the
successful condition which is especially troublesome for control transfers.
Some drivers (e.g., the AmigaOS-one) as well as the example code in the
spec, set the setup stage with an interrupt delay of seven (which means no
interrupt). This is fine under normal conditions, because one usually
doesn't want to be notified about the completion of this stage. However, if
an error occurs in this stage, these drivers will not get notified with the
current implementation. The fix addresses this by following the spec more
closely. Also, otherwise, the ability to set interrupt delay to seven would
be useless.

Note that Linux drivers that I looked at don't seem to be affected as they
set six as the interrupt delay presumably for the reason that they won't
get notified otherwise.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
---
 hw/usb/hcd-ohci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index d4c0293db5..98da5f0f04 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1156,6 +1156,9 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
                 OHCI_SET_BM(td.flags, TD_EC, 3);
                 break;
             }
+            /* An error occured so we have to clear the interrupt counter. See
+             * spec at 6.4.4 on page 104 */
+            ohci->done_count = 0;
         }
         ed->head |= OHCI_ED_H;
     }
-- 
2.18.0
