Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Bt-0000SI-Sw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Bo-0005Tu-CB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds6Bn-0005T5-T5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DBn5kT089335
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:41 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cy1r8f5qa-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:41 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 12:50:39 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 13:50:27 +0200
In-Reply-To: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170913115029.47626-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/4] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

Replace direct access which implicitly assumes no IDA
or MIDA with the new ccw data stream interface which should
cope with these transparently in the future.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e8d2016563..6b0cd8861b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -890,6 +890,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     }
 
     /* Look at the command. */
+    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
     switch (ccw.cmd_code) {
     case CCW_CMD_NOOP:
         /* Nothing to do. */
@@ -903,8 +904,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
             }
         }
         len = MIN(ccw.count, sizeof(sch->sense_data));
-        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
-        sch->curr_status.scsw.count = ccw.count - len;
+        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);
+        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
         memset(sch->sense_data, 0, sizeof(sch->sense_data));
         ret = 0;
         break;
@@ -930,8 +931,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
         } else {
             sense_id.reserved = 0;
         }
-        cpu_physical_memory_write(ccw.cda, &sense_id, len);
-        sch->curr_status.scsw.count = ccw.count - len;
+        ccw_dstream_write_buf(&sch->cds, &sense_id, len);
+        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
         ret = 0;
         break;
     }
-- 
2.13.5
