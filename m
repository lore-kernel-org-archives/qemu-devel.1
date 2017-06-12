Received: from eggs.gnu.org ([2001:4830:134:3::10]:55334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKHyE-00040y-9P
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dKHy9-0008Ct-DV
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47569
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dKHy9-0008CY-7u
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 01:32:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5C5TU1X137464
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 01:32:52 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b19fkdame-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 01:32:51 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 12 Jun 2017 15:32:49 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 12 Jun 2017 11:02:34 +0530
In-Reply-To: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1497245555-32472-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v6 1/2] spapr: Add a "no HPT" encoding to HTAB
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
 hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8b541d9..c425499 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1558,13 +1558,19 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
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
 
 
@@ -1710,7 +1716,12 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
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
@@ -1744,7 +1755,12 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
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
@@ -1788,6 +1804,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
     section_hdr = qemu_get_be32(f);
 
+    if (section_hdr == -1) {
+        spapr_free_hpt(spapr);
+        return 0;
+    }
+
     if (section_hdr) {
         Error *local_err = NULL;
 
-- 
2.7.4
