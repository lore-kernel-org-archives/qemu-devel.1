Received: from eggs.gnu.org ([2001:4830:134:3::10]:36698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY8E-0001U9-AM
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNY8B-0001fA-7Y
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:18 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNY8B-0001eM-1O
	for qemu-devel@nongnu.org; Tue, 29 May 2018 02:29:15 -0400
Received: from player718.ha.ovh.net (unknown [10.109.108.14])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6C2DFC8A6D
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 08:29:13 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 29 May 2018 08:28:37 +0200
Message-Id: <20180529062838.20556-6-clg@kaod.org>
In-Reply-To: <20180529062838.20556-1-clg@kaod.org>
References: <20180529062838.20556-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] slirp/ncsi: add a "Get Parameter" response
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

This is a minimum response to exercise the kernel.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 slirp/ncsi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 02d0e9def3e8..f00253641ea4 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -35,6 +35,27 @@ static int ncsi_rsp_handler_gls(struct ncsi_rsp_pkt_hd=
r *rnh)
     return 0;
 }
=20
+/* Get Parameter */
+static int ncsi_rsp_handler_gp(struct ncsi_rsp_pkt_hdr *rnh)
+{
+    struct ncsi_rsp_gp_pkt *rsp =3D (struct ncsi_rsp_gp_pkt *) rnh;
+
+    rsp->mac_cnt =3D 0x0;
+    rsp->mac_enable =3D 0x0;
+
+    /* TODO: provide the guest configured MAC */
+    rsp->mac[0] =3D 0xaa;
+    rsp->mac[1] =3D 0xbb;
+    rsp->mac[2] =3D 0xcc;
+    rsp->mac[3] =3D 0xdd;
+    rsp->mac[4] =3D 0xee;
+    rsp->mac[5] =3D 0xff;
+
+    /* more data follows */
+
+    return 0;
+}
+
 static const struct ncsi_rsp_handler {
         unsigned char   type;
         int             payload;
@@ -62,7 +83,7 @@ static const struct ncsi_rsp_handler {
         { NCSI_PKT_RSP_SNFC,    4, NULL },
         { NCSI_PKT_RSP_GVI,    40, NULL },
         { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
-        { NCSI_PKT_RSP_GP,     -1, NULL },
+        { NCSI_PKT_RSP_GP,     40, ncsi_rsp_handler_gp },
         { NCSI_PKT_RSP_GCPS,  172, NULL },
         { NCSI_PKT_RSP_GNS,   172, NULL },
         { NCSI_PKT_RSP_GNPTS, 172, NULL },
--=20
2.13.6
