Received: from eggs.gnu.org ([2001:4830:134:3::10]:58662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQs-0005mi-NX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQm-0007Qj-TR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQm-0007Q3-Mg
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:30 +0200
Message-Id: <20171006095956.27534-8-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/33] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Replace direct access which implicitly assumes no IDA
or MIDA with the new ccw data stream interface which should
cope with these transparently in the future.

Note that checking the return code for ccw_dstream_* will be
done in a follow-on patch.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-3-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 248e9d47e5..390c78f7d0 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -894,6 +894,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     }
 
     /* Look at the command. */
+    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
     switch (ccw.cmd_code) {
     case CCW_CMD_NOOP:
         /* Nothing to do. */
@@ -907,8 +908,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
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
@@ -934,8 +935,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
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
2.13.6
