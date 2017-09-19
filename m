Received: from eggs.gnu.org ([2001:4830:134:3::10]:53049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duNFY-0003no-VP
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duNFX-0002PY-RU
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:28:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43830
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duNFX-0002Oj-M8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:27:59 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JIOH0A010652
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:27:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d374nn5gv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:27:59 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 19:27:57 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 20:27:45 +0200
In-Reply-To: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170919182745.90280-6-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 5/5] s390x/css: support ccw IDA
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

Let's add indirect data addressing support for our virtual channel
subsystem. This implementation does not bother with any kind of
prefetching. We simply step through the IDAL on demand.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 2d37a9ddde..a3ce6d89b6 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -827,6 +827,121 @@ incr:
     return 0;
 }
 
+/* returns values between 1 and bsz, where bsz is a power of 2 */
+static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
+{
+    return bsz - (cda & (bsz - 1));
+}
+
+static inline uint64_t ccw_ida_block_size(uint8_t flags)
+{
+    if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
+        return 1ULL << 12;
+    }
+    return 1ULL << 11;
+}
+
+static inline int ida_read_next_idaw(CcwDataStream *cds, bool ccw_fmt1,
+                                     bool idaw_fmt_2)
+{
+    union {uint64_t fmt2; uint32_t fmt1; } idaw;
+    int ret;
+    hwaddr idaw_addr;
+
+    if (idaw_fmt_2) {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
+        if (idaw_addr & 0x07 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
+            return -EINVAL; /* channel program check */
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
+                               sizeof(idaw.fmt2), false);
+        cds->cda = be64_to_cpu(idaw.fmt2);
+    } else {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
+        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
+            return -EINVAL; /* channel program check */
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
+                               sizeof(idaw.fmt1), false);
+        cds->cda = be64_to_cpu(idaw.fmt1);
+    }
+    ++(cds->at_idaw);
+    if (ret != MEMTX_OK) {
+        /* assume inaccessible address */
+        return -EINVAL; /* channel program check */
+
+    }
+    return 0;
+}
+
+static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
+                              CcwDataStreamOp op)
+{
+    uint64_t bsz = ccw_ida_block_size(cds->flags);
+    int ret = 0;
+    uint16_t cont_left, iter_len;
+    const bool idaw_fmt2 = cds->flags & CDS_F_C64;
+    bool ccw_fmt1 = cds->flags & CDS_F_FMT;
+
+    ret = cds_check_len(cds, len);
+    if (ret <= 0) {
+        return ret;
+    }
+    if (!cds->at_idaw) {
+        /* read first idaw */
+        ret = ida_read_next_idaw(cds, ccw_fmt1, idaw_fmt2);
+        if (ret) {
+            goto err;
+        }
+        cont_left = ida_continuous_left(cds->cda, bsz);
+    } else {
+        cont_left = ida_continuous_left(cds->cda, bsz);
+        if (cont_left == bsz) {
+            ret = ida_read_next_idaw(cds, ccw_fmt1, idaw_fmt2);
+            if (ret) {
+                goto err;
+            }
+            if (cds->cda & (bsz - 1)) {
+                ret = -EINVAL; /* channel program check */
+                goto err;
+            }
+        }
+    }
+    do {
+        iter_len = MIN(len, cont_left);
+        if (!idaw_fmt2 && (cds->cda + iter_len) >= (1ULL << 31)) {
+                ret = -EINVAL; /* channel program check */
+                goto err;
+        }
+        if (op != CDS_OP_A) {
+            ret = address_space_rw(&address_space_memory, cds->cda,
+                                   MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);
+            if (ret != MEMTX_OK) {
+                /* assume inaccessible address */
+                ret = -EINVAL; /* channel program check */
+                goto err;
+            }
+        }
+        cds->at_byte += iter_len;
+        cds->cda += iter_len;
+        len -= iter_len;
+        if (!len) {
+            break;
+        }
+        ret = ida_read_next_idaw(cds, ccw_fmt1, idaw_fmt2);
+        if (ret) {
+            goto err;
+        }
+        cont_left = bsz;
+    } while (true);
+    return ret;
+err:
+    cds->flags |= CDS_F_STREAM_BROKEN;
+    return ret;
+}
+
 void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
 {
     /*
@@ -845,7 +960,7 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
     if (!(cds->flags & CDS_F_IDA)) {
         cds->op_handler = ccw_dstream_rw_noflags;
     } else {
-        assert(false);
+        cds->op_handler = ccw_dstream_rw_ida;
     }
 }
 
-- 
2.13.5
