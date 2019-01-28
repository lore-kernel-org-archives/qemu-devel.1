Received: from eggs.gnu.org ([209.51.188.92]:46101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@janustech.com>) id 1goD9q-0003Xi-3q
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@janustech.com>) id 1goD9c-0005DN-17
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:16 -0500
Received: from mail-eopbgr800129.outbound.protection.outlook.com
	([40.107.80.129]:58944
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuri.benditovich@janustech.com>)
	id 1goD9b-0005CQ-Ex
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:05:11 -0500
From: Yuri Benditovich <yuri.benditovich@janustech.com>
Date: Mon, 28 Jan 2019 20:05:07 +0000
Message-ID: <20190128200444.5128-2-yuri.benditovich@janustech.com>
References: <20190128200444.5128-1-yuri.benditovich@janustech.com>
In-Reply-To: <20190128200444.5128-1-yuri.benditovich@janustech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 1/2] usb: XHCI shall not halt isochronous
 endpoints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Dmitry Fleytman <dmitry.fleytman@janustech.com>

According to the XHCI spec (4.10.2) the controller
never halts isochronous endpoints. This commit prevent
stop of isochronous streaming when sporadic errors
status received from backends.

Signed-off-by: Yuri Benditovich <yuri.benditovich@janustech.com>
---
 hw/usb/hcd-xhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 8f1a01a..1a8fd96 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -1571,6 +1571,11 @@ static void xhci_stall_ep(XHCITransfer *xfer)
     uint32_t err;
     XHCIStreamContext *sctx;
=20
+    if (epctx->type =3D=3D ET_ISO_IN || epctx->type =3D=3D ET_ISO_OUT) {
+        /* never halt isoch endpoints, 4.10.2 */
+        return;
+    }
+
     if (epctx->nr_pstreams) {
         sctx =3D xhci_find_stream(epctx, xfer->streamid, &err);
         if (sctx =3D=3D NULL) {
--=20
2.9.5
