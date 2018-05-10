Received: from eggs.gnu.org ([2001:4830:134:3::10]:45439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ8j-0000gD-5u
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ8f-0006h5-LA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fGZ8f-0006gn-CS
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4A04UN5114761
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 20:08:52 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hv643m4nk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:08:52 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 10 May 2018 01:08:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 10 May 2018 02:07:12 +0200
In-Reply-To: <20180510000712.6472-1-pasic@linux.ibm.com>
References: <20180510000712.6472-1-pasic@linux.ibm.com>
Message-Id: <20180510000712.6472-3-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] vfio-ccw: remove orb.c64 (64 bit data
 addresses) check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

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
index 32f1b2820d..1554b4c2f5 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1191,17 +1191,6 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
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
