Received: from eggs.gnu.org ([2001:4830:134:3::10]:58776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR7-0005za-Te
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR0-0007dX-2e
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQz-0007cw-QY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:33 +0200
Message-Id: <20171006095956.27534-11-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 10/33] s390x/css: support ccw IDA
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

Let's add indirect data addressing support for our virtual channel
subsystem. This implementation does not bother with any kind of
prefetching. We simply step through the IDAL on demand.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-6-pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ab7333fde8..35683d7954 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -831,6 +831,118 @@ incr:
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
+static inline int ida_read_next_idaw(CcwDataStream *cds)
+{
+    union {uint64_t fmt2; uint32_t fmt1; } idaw;
+    int ret;
+    hwaddr idaw_addr;
+    bool idaw_fmt2 = cds->flags & CDS_F_C64;
+    bool ccw_fmt1 = cds->flags & CDS_F_FMT;
+
+    if (idaw_fmt2) {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
+        if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
+            return -EINVAL; /* channel program check */
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
+                               sizeof(idaw.fmt2), false);
+        cds->cda = be64_to_cpu(idaw.fmt2);
+    } else {
+        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
+        if (idaw_addr & 0x03 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
+            return -EINVAL; /* channel program check */
+        }
+        ret = address_space_rw(&address_space_memory, idaw_addr,
+                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
+                               sizeof(idaw.fmt1), false);
+        cds->cda = be64_to_cpu(idaw.fmt1);
+        if (cds->cda & 0x80000000) {
+            return -EINVAL; /* channel program check */
+        }
+    }
+    ++(cds->at_idaw);
+    if (ret != MEMTX_OK) {
+        /* assume inaccessible address */
+        return -EINVAL; /* channel program check */
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
+        cont_left = ida_continuous_left(cds->cda, bsz);
+    } else {
+        cont_left = ida_continuous_left(cds->cda, bsz);
+        if (cont_left == bsz) {
+            ret = ida_read_next_idaw(cds);
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
+        ret = ida_read_next_idaw(cds);
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
@@ -849,7 +961,7 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
     if (!(cds->flags & CDS_F_IDA)) {
         cds->op_handler = ccw_dstream_rw_noflags;
     } else {
-        assert(false);
+        cds->op_handler = ccw_dstream_rw_ida;
     }
 }
 
-- 
2.13.6
