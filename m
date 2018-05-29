Received: from eggs.gnu.org ([2001:4830:134:3::10]:36778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY8K-0001cF-57
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY8H-0001it-1A
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:24 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:59573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNY8G-0001hw-RM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:20 -0400
Received: from player718.ha.ovh.net (unknown [10.109.120.102])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id EFC8215ED2C
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:29:18 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 29 May 2018 08:28:38 +0200
Message-Id: <20180529062838.20556-7-clg@kaod.org>
In-Reply-To: <20180529062838.20556-1-clg@kaod.org>
References: <20180529062838.20556-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] slirp/ncsi: add checksum support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
index f00253641ea4..fbfb79713f23 100644
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
@@ -108,6 +122,9 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
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
@@ -137,15 +154,19 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, i=
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
2.13.6
