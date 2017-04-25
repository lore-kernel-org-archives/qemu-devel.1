Received: from eggs.gnu.org ([2001:4830:134:3::10]:44402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKc-0003yO-Ue
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1d2uKZ-0006KW-TK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:15 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:48319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1d2uKZ-0006JA-Mw
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:52:11 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 4BEA54DB79
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:52:10 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 25 Apr 2017 08:51:41 +0200
Message-Id: <1493103101-25165-3-git-send-email-clg@kaod.org>
In-Reply-To: <1493103101-25165-1-git-send-email-clg@kaod.org>
References: <1493103101-25165-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] ipmi: don't try to open a NULL filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <cminyard@mvista.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Currenlty, the code relies on the fact that open() handles NULL
filenames but that can cause an error with new clang:

  hw/core/loader.c:67:15: runtime error: null pointer passed as argument =
1,
  which is declared to never be null

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ipmi/ipmi_bmc_sim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 155561d06614..277c28cb40ed 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1899,6 +1899,10 @@ static void ipmi_fru_init(IPMIFru *fru)
     int fsize;
     int size =3D 0;
=20
+    if (!fru->filename) {
+        goto out;
+    }
+
     fsize =3D get_image_size(fru->filename);
     if (fsize > 0) {
         size =3D QEMU_ALIGN_UP(fsize, fru->areasize);
@@ -1910,6 +1914,7 @@ static void ipmi_fru_init(IPMIFru *fru)
         }
     }
=20
+out:
     if (!fru->data) {
         /* give one default FRU */
         size =3D fru->areasize;
--=20
2.7.4
