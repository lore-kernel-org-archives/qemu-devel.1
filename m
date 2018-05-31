Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9q-00041j-G0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9n-0008P5-RD
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:46 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:50272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9n-0008OE-KL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:43 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:36 +0200
Message-Id: <20180531192237.3994-9-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] slirp/ncsi: add a "Get Parameters" response
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Command 0x17 'Get Parameters' is used to get configuration parameter
values currently in effect on the controller and it is mandatory in
the NS-CI specification.

Provide a minimum response to exercise the kernel.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ncsi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/slirp/ncsi.c b/slirp/ncsi.c
index 02d0e9def3..7b3fff207a 100644
--- a/slirp/ncsi.c
+++ b/slirp/ncsi.c
@@ -35,6 +35,20 @@ static int ncsi_rsp_handler_gls(struct ncsi_rsp_pkt_hd=
r *rnh)
     return 0;
 }
=20
+/* Get Parameters */
+static int ncsi_rsp_handler_gp(struct ncsi_rsp_pkt_hdr *rnh)
+{
+    struct ncsi_rsp_gp_pkt *rsp =3D (struct ncsi_rsp_gp_pkt *) rnh;
+
+    /* no MAC address filters or VLAN filters on the channel */
+    rsp->mac_cnt =3D 0;
+    rsp->mac_enable =3D 0;
+    rsp->vlan_cnt =3D 0;
+    rsp->vlan_enable =3D 0;
+
+    return 0;
+}
+
 static const struct ncsi_rsp_handler {
         unsigned char   type;
         int             payload;
@@ -62,7 +76,7 @@ static const struct ncsi_rsp_handler {
         { NCSI_PKT_RSP_SNFC,    4, NULL },
         { NCSI_PKT_RSP_GVI,    40, NULL },
         { NCSI_PKT_RSP_GC,     32, ncsi_rsp_handler_gc },
-        { NCSI_PKT_RSP_GP,     -1, NULL },
+        { NCSI_PKT_RSP_GP,     40, ncsi_rsp_handler_gp },
         { NCSI_PKT_RSP_GCPS,  172, NULL },
         { NCSI_PKT_RSP_GNS,   172, NULL },
         { NCSI_PKT_RSP_GNPTS, 172, NULL },
--=20
2.17.0
