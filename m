Received: from eggs.gnu.org ([2001:4830:134:3::10]:59865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVy-00079K-8f
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVt-0006i1-BM
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:59:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLuVt-0006hX-1j
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OHs3uX021640
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:55 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j61p9sd2b-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 24 May 2018 18:58:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 24 May 2018 19:58:28 +0200
In-Reply-To: <20180524175828.3143-1-pasic@linux.ibm.com>
References: <20180524175828.3143-1-pasic@linux.ibm.com>
Message-Id: <20180524175828.3143-3-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/2] vfio-ccw: remove orb.c64 (64 bit data
 addresses) check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

The vfio-ccw module does the check too, and there is actually no
technical obstacle for supporting fmt 1 idaws. Let us be ready for the
beautiful day when fmt 1 idaws become supported by the vfio-ccw kernel
module. QEMU does not have to do a thing for that, except not insisting
on this check.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 hw/s390x/css.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 39ae5bbf7e..5424ea4562 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1199,17 +1199,6 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
         assert(orb != NULL);
         p->intparm = orb->intparm;
     }
-
-    /*
-     * Only support prefetch enable mode.
-     * Only support 64bit addressing idal.
-     */
-    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
-        warn_report("vfio-ccw requires PFCH and C64 flags set");
-        sch_gen_unit_exception(sch);
-        css_inject_io_interrupt(sch);
-        return IOINST_CC_EXPECTED;
-    }
     return s390_ccw_cmd_request(sch);
 }
 
-- 
2.16.3
