Received: from eggs.gnu.org ([209.51.188.92]:58977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09x-0007AD-Cz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09w-0007ry-Ik
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:54 +1100
Message-Id: <20190108224600.23125-24-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/29] spapr: return from post_load method when
 RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The error value can be squashed by the section handling radix migration.
Simply bail out if an error occurs when the RTC offset is imported.

This fixes the Coverity issue CID 1398591.

Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8576c1c6f7..59faeccf4b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1747,12 +1747,17 @@ static int spapr_post_load(void *opaque, int vers=
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
