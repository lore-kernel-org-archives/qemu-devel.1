Received: from eggs.gnu.org ([208.118.235.92]:40177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfLQw-0003Tz-SU
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:06:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gfLQr-0006wn-MW
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:06:25 -0500
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:41813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gfLQr-0006w1-Fg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:06:21 -0500
Received: from player789.ha.ovh.net (unknown [10.109.159.132])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id B304F1EF7C2
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 10:06:18 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri,  4 Jan 2019 10:06:10 +0100
Message-Id: <20190104090610.652-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: return from post_load method when RTC
 import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The error value can be squashed by the section handling radix migration.
Simply bail out if an error occurs when the RTC offset is imported.

Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f1725313e979..64397ee91ef0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1748,12 +1748,17 @@ static int spapr_post_load(void *opaque, int vers=
ion_id)
         return err;
     }
=20
-    /* In earlier versions, there was no separate qdev for the PAPR
+    /*
+     * In earlier versions, there was no separate qdev for the PAPR
      * RTC, so the RTC offset was stored directly in sPAPREnvironment.
      * So when migrating from those versions, poke the incoming offset
-     * value into the RTC device */
+     * value into the RTC device
+     */
     if (version_id < 3) {
         err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
+        if (err) {
+            return err;
+        }
     }
=20
     if (kvm_enabled() && spapr->patb_entry) {
--=20
2.20.1
