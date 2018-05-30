Received: from eggs.gnu.org ([2001:4830:134:3::10]:57207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuK7-0007G6-8K
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNuK2-00068n-9t
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:11:01 -0400
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:41297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNuK2-000683-40
	for qemu-devel@nongnu.org; Wed, 30 May 2018 02:10:58 -0400
Received: from player168.ha.ovh.net (unknown [10.109.122.102])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5864CC0DC2
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 08:10:56 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 30 May 2018 08:10:35 +0200
Message-Id: <20180530061035.22592-4-clg@kaod.org>
In-Reply-To: <20180530061035.22592-1-clg@kaod.org>
References: <20180530061035.22592-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] slirp/ncsi: add checksum support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The checksum field of a NC-SI packet contains a value that may be
included in each command and response. The verification is optional
but the Linux driver does so when a non-zero value is provided. Let's
extend the model to compute the checksum value and exercise a little
more the Linux driver.

See section "8.2.2.3 - 2's Complement Checksum Compensation" in the
Network Controller Sideband Interface (NC-SI) Specification for more
details.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

 Changes since v1:

 - updated Copyright
 - used uint16_t instead of chars to compute the checksum
=20
 slirp/ncsi.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 7b3fff207ab3..7116034afc20 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -1,7 +1,7 @@
 /*
  * NC-SI (Network Controller Sideband Interface) "echo" model
  *
- * Copyright (C) 2016 IBM Corp.
+ * Copyright (C) 2016-2018 IBM Corp.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -11,6 +11,23 @@
=20
 #include "ncsi-pkt.h"
=20
+static uint32_t ncsi_calculate_checksum(uint16_t *data, int len)
+{
+    uint32_t checksum =3D 0;
+    int i;
+
+    /*
+     * 32-bit unsigned sum of the NC-SI packet header and NC-SI packet
+     * payload interpreted as a series of 16-bit unsigned integer values=
.
+     */
+    for (i =3D 0; i < len; i++) {
+        checksum +=3D htons(data[i]);
+    }
+
+    checksum =3D (~checksum + 1);
+    return checksum;
+}
+
 /* Get Capabilities */
 static int ncsi_rsp_handler_gc(struct ncsi_rsp_pkt_hdr *rnh)
 {
@@ -101,6 +118,9 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int=
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
@@ -130,15 +150,18 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, i=
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
+    /* Add the optional checksum at the end of the frame. */
+    checksum =3D ncsi_calculate_checksum((uint16_t *) rnh, ncsi_rsp_len)=
;
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
