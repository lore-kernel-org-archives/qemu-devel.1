Received: from eggs.gnu.org ([2001:4830:134:3::10]:56917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dv5uE-0005kP-PC
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dv5uD-0006JF-Kx
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:08:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dv5uD-0006Iv-Ej
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 14:08:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LI4OEa013816
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 14:08:52 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4fg59kth-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 14:08:52 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 19:08:50 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 20:08:40 +0200
In-Reply-To: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 4/5] 390x/css: introduce maximum data
 address checking
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

The architecture mandates the addresses to be accessed on the first
indirection level (that is, the data addresses without IDA, and the
(M)IDAW addresses with (M)IDA) to be checked against an CCW format
dependent limit maximum address.  If a violation is detected, the storage
access is not to be performed and a channel program check needs to be
generated. As of today, we fail to do this check.

Let us stick even closer to the architecture specification.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 10 ++++++++++
 include/hw/s390x/css.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e0d989829f..cd5580ebb8 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
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
@@ -804,6 +809,9 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
     if (ret <= 0) {
         return ret;
     }
+    if (!cds_ccw_addrs_ok(cds->cda, len, cds->flags & CDS_F_FMT)) {
+        return -EINVAL; /* channel program check */
+    }
     if (op == CDS_OP_A) {
         goto incr;
     }
@@ -828,7 +836,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
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
2.13.5
