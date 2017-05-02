Received: from eggs.gnu.org ([2001:4830:134:3::10]:58925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5Xyc-0001Ls-Fc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5XyZ-0001q5-7s
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54881
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5XyZ-0001px-2k
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:36:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42DYGY9069985
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 09:36:22 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6tn91m4p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:36:22 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 14:36:20 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue,  2 May 2017 15:36:00 +0200
In-Reply-To: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
References: <20170502133604.17735-1-cornelia.huck@de.ibm.com>
Message-Id: <20170502133604.17735-9-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 08/12] pc-bios/s390-ccw: provide entry selection
 on LOADPARM for SCSI disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Farhan Ali <alifm@linux.vnet.ibm.com>, Eugene Dvurechenski <jno@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Fix SCSI bootmap interpreter to make use of any specified entry of the
Program Table using the leftmost numeric value from the LOADPARM, if specified.

Initial patch from Eugene (jno) Dvurechenski.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/bootmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index b21c877b53..e39e67e07b 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -444,7 +444,8 @@ static void ipl_scsi(void)
     uint8_t *ns, *ns_end;
     int program_table_entries = 0;
     const int pte_len = sizeof(ScsiBlockPtr);
-    ScsiBlockPtr *prog_table_entry;
+    ScsiBlockPtr *prog_table_entry = NULL;
+    unsigned int loadparm = get_loadparm_index();
 
     /* Grab the MBR */
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -467,6 +468,7 @@ static void ipl_scsi(void)
 
     IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
 
+    debug_print_int("loadparm index", loadparm);
     ns_end = sec + virtio_get_block_size();
     for (ns = (sec + pte_len); (ns + pte_len) < ns_end; ns += pte_len) {
         prog_table_entry = (ScsiBlockPtr *)ns;
@@ -475,16 +477,15 @@ static void ipl_scsi(void)
         }
 
         program_table_entries++;
+        if (program_table_entries == loadparm + 1) {
+            break; /* selected entry found */
+        }
     }
 
     debug_print_int("program table entries", program_table_entries);
 
     IPL_assert(program_table_entries != 0, "Empty Program Table");
 
-    /* Run the default entry */
-
-    prog_table_entry = (ScsiBlockPtr *)(sec + pte_len);
-
     zipl_run(prog_table_entry); /* no return */
 }
 
-- 
2.11.0
