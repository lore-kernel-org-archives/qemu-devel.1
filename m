Received: from eggs.gnu.org ([209.51.188.92]:45581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOV-0004vw-Gb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOT-00079Z-De
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOS-000745-Jd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:44 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:22 +0100
Message-Id: <20190130073426.11525-5-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] usb: XHCI shall not halt isochronous
 endpoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Yuri Benditovich <yuri.benditovich@janustech.com>

From: Yuri Benditovich <yuri.benditovich@janustech.com>

According to the XHCI spec (4.10.2) the controller
never halts isochronous endpoints. This commit prevent
stop of isochronous streaming when sporadic errors
status received from backends.

Signed-off-by: Yuri Benditovich <yuri.benditovich@janustech.com>
Message-id: 20190128200444.5128-2-yuri.benditovich@janustech.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 8f1a01a405..1a8fd9644e 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1571,6 +1571,11 @@ static void xhci_stall_ep(XHCITransfer *xfer)
     uint32_t err;
     XHCIStreamContext *sctx;
 
+    if (epctx->type == ET_ISO_IN || epctx->type == ET_ISO_OUT) {
+        /* never halt isoch endpoints, 4.10.2 */
+        return;
+    }
+
     if (epctx->nr_pstreams) {
         sctx = xhci_find_stream(epctx, xfer->streamid, &err);
         if (sctx == NULL) {
-- 
2.9.3
