Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Tq-0007WA-HH
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gZ1Tm-0007UV-Kg
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:18 -0500
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:39021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gZ1Tl-0007SH-35
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:35:13 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.152])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id AAB3320B1DF
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:35:11 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 17 Dec 2018 23:34:41 +0100
Message-Id: <20181217223445.28594-4-clg@kaod.org>
In-Reply-To: <20181217223445.28594-1-clg@kaod.org>
References: <20181217223445.28594-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 3/7] spapr/xive: fix compilation breakage on
 windows
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 46 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index aaa5865c4080..3ceabe668b16 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -589,12 +589,14 @@ static target_ulong h_int_get_source_info(PowerPCCP=
U *cpu,
     }
=20
     if (lisn >=3D xive->nr_irqs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
     if (!xive_eas_is_valid(&xive->eat[lisn])) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
@@ -701,13 +703,15 @@ static target_ulong h_int_set_source_config(PowerPC=
CPU *cpu,
     }
=20
     if (lisn >=3D xive->nr_irqs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
     eas =3D xive->eat[lisn];
     if (!xive_eas_is_valid(&eas)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
@@ -724,8 +728,8 @@ static target_ulong h_int_set_source_config(PowerPCCP=
U *cpu,
     }
=20
     if (spapr_xive_priority_is_reserved(priority)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
-                      priority);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
+                      " is reserved\n", priority);
         return H_P4;
     }
=20
@@ -793,13 +797,15 @@ static target_ulong h_int_get_source_config(PowerPC=
CPU *cpu,
     }
=20
     if (lisn >=3D xive->nr_irqs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
     eas =3D xive->eat[lisn];
     if (!xive_eas_is_valid(&eas)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
@@ -870,8 +876,8 @@ static target_ulong h_int_get_queue_info(PowerPCCPU *=
cpu,
      */
=20
     if (spapr_xive_priority_is_reserved(priority)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
-                      priority);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
+                      " is reserved\n", priority);
         return H_P3;
     }
=20
@@ -956,8 +962,8 @@ static target_ulong h_int_set_queue_config(PowerPCCPU=
 *cpu,
      */
=20
     if (spapr_xive_priority_is_reserved(priority)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
-                      priority);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
+                      " is reserved\n", priority);
         return H_P3;
     }
=20
@@ -1102,8 +1108,8 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
      */
=20
     if (spapr_xive_priority_is_reserved(priority)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority %ld is reserved\n=
",
-                      priority);
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: priority " TARGET_FMT_ld
+                      " is reserved\n", priority);
         return H_P3;
     }
=20
@@ -1268,13 +1274,15 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
     }
=20
     if (lisn >=3D xive->nr_irqs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
     eas =3D xive->eat[lisn];
     if (!xive_eas_is_valid(&eas)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
@@ -1330,13 +1338,15 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
     }
=20
     if (lisn >=3D xive->nr_irqs) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Unknown LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
     eas =3D xive->eat[lisn];
     if (!xive_eas_is_valid(&eas)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN %lx\n", lisn)=
;
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid LISN " TARGET_FMT_=
lx "\n",
+                      lisn);
         return H_P2;
     }
=20
--=20
2.17.2
