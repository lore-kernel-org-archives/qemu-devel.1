Received: from eggs.gnu.org ([2001:4830:134:3::10]:58940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xye-0001N0-2d
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xya-0001qf-QR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50900
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5Xya-0001qY-K0
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYIFa119383
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6t1mufrp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:23 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:21 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:36:02 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-11-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 10/12] pc-bios/s390-ccw: add boot entry
 selection to El Torito routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

If there is no LOADPARM given or '0' specified, then IPL the first
matched entry. Otherwise IPL the matching entry of that number.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index e974350b6f..523fa78c5f 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -655,6 +655,7 @@ static IsoBcSection *find_iso_bc_entry(void)
     IsoBcEntry *e = (IsoBcEntry *)sec;
     uint32_t offset = find_iso_bc();
     int i;
+    unsigned int loadparm = get_loadparm_index();
 
     if (!offset) {
         return NULL;
@@ -675,7 +676,11 @@ static IsoBcSection *find_iso_bc_entry(void)
     for (i = 1; i < ISO_BC_ENTRY_PER_SECTOR; i++) {
         if (e[i].id == ISO_BC_BOOTABLE_SECTION) {
             if (is_iso_bc_entry_compatible(&e[i].body.sect)) {
-                return &e[i].body.sect;
+                if (loadparm <= 1) {
+                    /* found, default, or unspecified */
+                    return &e[i].body.sect;
+                }
+                loadparm--;
             }
         }
     }
-- 
2.11.0
