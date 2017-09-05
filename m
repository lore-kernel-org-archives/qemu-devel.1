Received: from eggs.gnu.org ([2001:4830:134:3::10]:46454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpBr9-0005DI-6y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpBr1-00084H-Cc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:17:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpBr1-00083k-3s
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:17:15 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85BG3Oo119517
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 07:17:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csqchvjcn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 07:17:13 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 12:17:11 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue,  5 Sep 2017 13:16:44 +0200
In-Reply-To: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170905111645.18068-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/5] s390x/css: support ccw IDA
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
subsystem. This implementation does no prefetching, but steps
trough the idal as we go.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c1bc9944e6..9d8f9fd7ea 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -819,6 +819,114 @@ incr:
     return 0;
 }
 
+/* retuns values between 1 and bs, where bs is a power of 2 */
+static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bs)
+{
+    return bs - (cda & (bs - 1));
+}
+
+static inline uint64_t ccw_ida_block_size(uint8_t flags)
+{
+    return 1ULL << (((flags ^ CDS_F_C64) & (CDS_F_C64 | CDS_F_I2K)) ? 11 : 12);
+}
+
+static inline int ida_read_next_idaw(CcwDataStream *cds)
+{
+    union {uint64_t fmt2; uint32_t fmt1; } idaw;
+    bool is_fmt2 = cds->flags & CDS_F_C64;
+    int ret;
+    hwaddr idaw_addr;
+
+    if (is_fmt2) {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
+        if (idaw_addr & 0x07) {
+            return -EINVAL; /* chanel program check */
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
+                               sizeof(idaw.fmt2), false);
+        cds->cda = be64_to_cpu(idaw.fmt2);
+    } else {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
+        if (idaw_addr & 0x03) {
+            return -EINVAL; /* chanel program check */
+
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
+                               sizeof(idaw.fmt1), false);
+        cds->cda = be64_to_cpu(idaw.fmt1);
+    }
+    ++(cds->at_idaw);
+    if (ret != MEMTX_OK) {
+        /* assume inaccessible address */
+        return -EINVAL; /* chanel program check */
+
+    }
+    return 0;
+}
+
+static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
+                              CcwDataStreamOp op)
+{
+    uint64_t bs = ccw_ida_block_size(cds->flags);
+    int ret = 0;
+    uint16_t cont_left, iter_len;
+
+    ret = cds_check_len(cds, len);
+    if (ret <= 0) {
+        return ret;
+    }
+    if (!cds->at_idaw) {
+        /* read first idaw */
+        ret = ida_read_next_idaw(cds);
+        if (ret) {
+            goto err;
+        }
+        cont_left = ida_continuous_left(cds->cda, bs);
+    } else {
+        cont_left = ida_continuous_left(cds->cda, bs);
+        if (cont_left == bs) {
+            ret = ida_read_next_idaw(cds);
+            if (ret) {
+                goto err;
+            }
+            if (cds->cda & (bs - 1)) {
+                ret = -EINVAL; /* chanel program check */
+                goto err;
+            }
+        }
+    }
+do_iter_len:
+    iter_len = MIN(len, cont_left);
+    if (op == CDS_OP_A) {
+        goto incr;
+    }
+    ret = address_space_rw(&address_space_memory, cds->cda,
+                           MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);
+    if (ret != MEMTX_OK) {
+        /* assume inaccessible address */
+        ret = -EINVAL; /* chanel program check */
+        goto err;
+    }
+incr:
+    cds->at_byte += iter_len;
+    cds->cda += iter_len;
+    len -= iter_len;
+    if (len) {
+        ret = ida_read_next_idaw(cds);
+        if (ret) {
+            goto err;
+        }
+        cont_left = bs;
+        goto do_iter_len;
+    }
+    return ret;
+err:
+    cds->flags |= CDS_F_STREAM_BROKEN;
+    return ret;
+}
+
 void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
 {
     /*
@@ -835,7 +943,7 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
     if (!(cds->flags & CDS_F_IDA)) {
         cds->op_handler = ccw_dstream_rw_noflags;
     } else {
-        assert(false);
+        cds->op_handler = ccw_dstream_rw_ida;
     }
 }
 
-- 
2.13.5
