Received: from eggs.gnu.org ([2001:4830:134:3::10]:58713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQz-0005sY-Vz
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQw-0007al-46
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQv-0007Zw-R9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:42 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:32 +0200
Message-Id: <20171006095956.27534-10-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 09/33] 390x/css: introduce maximum data address
 checking
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

The architecture mandates the addresses to be accessed on the first
indirection level (that is, the data addresses without IDA, and the
(M)IDAW addresses with (M)IDA) to be checked against an CCW format
dependent limit maximum address.  If a violation is detected, the storage
access is not to be performed and a channel program check needs to be
generated. As of today, we fail to do this check.

Let us stick even closer to the architecture specification.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-5-pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 10 ++++++++++
 include/hw/s390x/css.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 390c78f7d0..ab7333fde8 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -799,6 +799,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
     return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
 }
 
+static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt1)
+{
+    return (addr + len) < (ccw_fmt1 ? (1UL << 31) : (1UL << 24));
+}
+
 static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
                                   CcwDataStreamOp op)
 {
@@ -808,6 +813,9 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
     if (ret <= 0) {
         return ret;
     }
+    if (!cds_ccw_addrs_ok(cds->cda, len, cds->flags & CDS_F_FMT)) {
+        return -EINVAL; /* channel program check */
+    }
     if (op == CDS_OP_A) {
         goto incr;
     }
@@ -832,7 +840,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
     g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
     cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
                  (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
+                 (orb->ctrl0 & ORB_CTRL0_MASK_FMT ? CDS_F_FMT : 0) |
                  (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
+
     cds->count = ccw->count;
     cds->cda_orig = ccw->cda;
     ccw_dstream_rewind(cds);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 078356e94c..69b374730e 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -87,6 +87,7 @@ typedef struct CcwDataStream {
 #define CDS_F_MIDA  0x02
 #define CDS_F_I2K   0x04
 #define CDS_F_C64   0x08
+#define CDS_F_FMT   0x10 /* CCW format-1 */
 #define CDS_F_STREAM_BROKEN  0x80
     uint8_t flags;
     uint8_t at_idaw;
-- 
2.13.6
