Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNP-000731-H5
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNO-0001ml-OQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:25 +0200
Message-Id: <20180619120434.25062-4-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/12] vfio-ccw: remove orb.c64 (64 bit data
 addresses) check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.ibm.com>

The vfio-ccw module does the check too, and there is actually no
technical obstacle for supporting fmt 1 idaws. Let us be ready for the
beautiful day when fmt 1 idaws become supported by the vfio-ccw kernel
module. QEMU does not have to do a thing for that, except not insisting
on this check.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
Message-Id: <20180524175828.3143-3-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.14.4
