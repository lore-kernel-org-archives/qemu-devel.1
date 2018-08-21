Received: from eggs.gnu.org ([2001:4830:134:3::10]:37237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hk-0008Fj-0W
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs2hd-0000e2-4y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs2hc-0000cH-SE
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 05:11:52 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 11:11:43 +0200
Message-Id: <20180821091148.32220-3-kraxel@redhat.com>
In-Reply-To: <20180821091148.32220-1-kraxel@redhat.com>
References: <20180821091148.32220-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] ohci: Clear the interrupt counter for
 erroneous transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Sebastian Bauer <mail@sebastianbauer.info>

From: Sebastian Bauer <mail@sebastianbauer.info>

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
Message-id: 20180729191928.11254-1-mail@sebastianbauer.info
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
