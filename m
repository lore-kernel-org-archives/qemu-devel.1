Received: from eggs.gnu.org ([2001:4830:134:3::10]:59453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVp0-0002dn-1I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dIVow-0001Kr-4v
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dIVov-0001K1-Nk
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:56:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v577sTtX131722
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 03:56:00 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ax6nyxe45-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 03:56:00 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:55:58 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed,  7 Jun 2017 13:24:52 +0530
In-Reply-To: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1496822093-5700-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1496822093-5700-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 1/2] spapr: Add a "no HPT" encoding to HTAB
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Add a "no HPT" encoding (using value -1) to the HTAB migration
stream (in the place of HPT size) when the guest doesn't allocate HPT.
This will help the target side to match target HPT with the source HPT
and thus enable successful migration.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 86e6228..df27c5c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1557,13 +1557,19 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
     sPAPRMachineState *spapr = opaque;
 
     /* "Iteration" header */
-    qemu_put_be32(f, spapr->htab_shift);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+    } else {
+        qemu_put_be32(f, spapr->htab_shift);
+    }
 
     if (spapr->htab) {
         spapr->htab_save_index = 0;
         spapr->htab_first_pass = true;
     } else {
-        assert(kvm_enabled());
+        if (spapr->htab_shift) {
+            assert(kvm_enabled());
+        }
     }
 
 
@@ -1709,7 +1715,12 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
     int rc = 0;
 
     /* Iteration header */
-    qemu_put_be32(f, 0);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+        return 0;
+    } else {
+        qemu_put_be32(f, 0);
+    }
 
     if (!spapr->htab) {
         assert(kvm_enabled());
@@ -1743,7 +1754,12 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
     int fd;
 
     /* Iteration header */
-    qemu_put_be32(f, 0);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+        return 0;
+    } else {
+        qemu_put_be32(f, 0);
+    }
 
     if (!spapr->htab) {
         int rc;
@@ -1787,6 +1803,10 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
     section_hdr = qemu_get_be32(f);
 
+    if (section_hdr == -1) {
+        return 0;
+    }
+
     if (section_hdr) {
         Error *local_err = NULL;
 
-- 
2.7.4
