Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d1C1q-00031U-Un
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d1C1m-0007C7-Lg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:21:46 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d1C1m-00079y-FV
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:21:42 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 07BF55FA97
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 15:21:33 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 20 Apr 2017 15:21:15 +0200
Message-Id: <1492694475-18198-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: add checksum support to NC-SI backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The checksum field of a NC-SI packet contains a value that may be
included in each command and response. The verification is optional
but the Linux driver does so when a non-zero value is provided. Let's
extend the model to compute the checksum value and exercise a little
more the Linux driver.

See section "8.2.2.3 - 2's Complement Checksum Compensation" in the
Network Controller Sideband Interface (NC-SI) Specification for more
details.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 slirp/ncsi.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index d12ba3e494b0..81c6bc5576d3 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -8,9 +8,23 @@
  */
 #include "qemu/osdep.h"
 #include "slirp.h"
+#include "net/checksum.h"
=20
 #include "ncsi-pkt.h"
=20
+static uint32_t ncsi_calculate_checksum(unsigned char *data, int len)
+{
+    uint32_t checksum =3D 0;
+    int i;
+
+    for (i =3D 0; i < len; i +=3D 2) {
+        checksum +=3D (((uint32_t)data[i] << 8) | data[i + 1]);
+    }
+
+    checksum =3D (~checksum + 1);
+    return checksum;
+}
+
 /* Get Capabilities */
 static int ncsi_rsp_handler_gc(struct ncsi_rsp_pkt_hdr *rnh)
 {
@@ -87,6 +101,9 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int =
pkt_len)
         (ncsi_reply + ETH_HLEN);
     const struct ncsi_rsp_handler *handler =3D NULL;
     int i;
+    int ncsi_rsp_len =3D sizeof(*nh);
+    uint32_t checksum;
+    uint32_t *pchecksum;
=20
     memset(ncsi_reply, 0, sizeof(ncsi_reply));
=20
@@ -116,15 +133,19 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, i=
nt pkt_len)
             /* TODO: handle errors */
             handler->handler(rnh);
         }
+        ncsi_rsp_len +=3D handler->payload;
     } else {
         rnh->common.length =3D 0;
         rnh->code          =3D htons(NCSI_PKT_RSP_C_UNAVAILABLE);
         rnh->reason        =3D htons(NCSI_PKT_RSP_R_UNKNOWN);
     }
=20
-    /* TODO: add a checksum at the end of the frame but the specs
-     * allows it to be zero */
+    /* add a checksum at the end of the frame (the specs allows it to
+     * be zero */
+    checksum =3D ncsi_calculate_checksum((unsigned char *) rnh, ncsi_rsp=
_len);
+    pchecksum =3D (uint32_t *)((void *) rnh + ncsi_rsp_len);
+    *pchecksum =3D htonl(checksum);
+    ncsi_rsp_len +=3D 4;
=20
-    slirp_output(slirp->opaque, ncsi_reply, ETH_HLEN + sizeof(*nh) +
-                 (handler ? handler->payload : 0) + 4);
+    slirp_output(slirp->opaque, ncsi_reply, ETH_HLEN + ncsi_rsp_len);
 }
--=20
2.7.4
