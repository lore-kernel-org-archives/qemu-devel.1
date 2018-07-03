Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgF-0000a0-L1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1faGgD-0001W2-0J
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1faGgC-0001Vf-PC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:28:56 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  3 Jul 2018 10:28:50 +0200
Message-Id: <20180703082851.17959-2-kraxel@redhat.com>
In-Reply-To: <20180703082851.17959-1-kraxel@redhat.com>
References: <20180703082851.17959-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] ehci: Don't fetch a NULL current qtd but
 advance the queue instead.
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

Fetching qtd with the NULL address most likely makes no sense so from now
on, we handle it this case similarly as if the terminate (T) bit is not
set, which is already an exception as according to section 3.6 of the EHCI
spec there is no T bit defined for the current_qtd field.

The spec is a bit vague on how an EHCI driver should initialize these
fields: "The general operational model is that the host controller can
detect whether the overlay area contains a description of an active
transfer" (p. 49). QEMU primarily uses the QTD_TOKEN_ACTIVE bit of the
queue header to infer the activity state but there are other ways
conceivable.

This change allows QEMU to boot further into AmigaOS. The public available
version of the EHCI driver recycles queue heads in some rare conditions but
only clears the current_qtd field but not the status field. This works with
many available EHCI PCI cards but e.g., not with the Freescale USB
controller's found on the P5040. On the emulated EHCI controller of QEMU
the consequence is that some garbage was read in, which resulted in a
reset of the controller. This change fixes the problem.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20180625222718.4488-1-mail@sebastianbauer.info
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ehci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 0134232627..e5acfc5ba5 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1672,7 +1672,8 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci, int async)
         ehci_set_state(ehci, async, EST_HORIZONTALQH);
 
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&
-               (NLPTR_TBIT(q->qh.current_qtd) == 0)) {
+               (NLPTR_TBIT(q->qh.current_qtd) == 0) &&
+               (q->qh.current_qtd != 0)) {
         q->qtdaddr = q->qh.current_qtd;
         ehci_set_state(ehci, async, EST_FETCHQTD);
 
-- 
2.9.3
