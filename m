Received: from eggs.gnu.org ([2001:4830:134:3::10]:58617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQj-0005g2-RV
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PQi-0007MT-NZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PQi-0007Lx-Ef
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:29 +0200
Message-Id: <20171006095956.27534-7-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 06/33] s390x/css: introduce css data stream
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

This is a preparation for introducing handling for indirect data
addressing and modified indirect data addressing (CCW). Here we introduce
an interface which should make the addressing scheme transparent for the
client code. Here we implement only the basic scheme (no IDA or MIDA).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Message-Id: <20170921180841.24490-2-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c59be1aad1..248e9d47e5 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -787,6 +787,61 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
     }
     return ret;
 }
+/**
+ * If out of bounds marks the stream broken. If broken returns -EINVAL,
+ * otherwise the requested length (may be zero)
+ */
+static inline int cds_check_len(CcwDataStream *cds, int len)
+{
+    if (cds->at_byte + len > cds->count) {
+        cds->flags |= CDS_F_STREAM_BROKEN;
+    }
+    return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
+}
+
+static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
+                                  CcwDataStreamOp op)
+{
+    int ret;
+
+    ret = cds_check_len(cds, len);
+    if (ret <= 0) {
+        return ret;
+    }
+    if (op == CDS_OP_A) {
+        goto incr;
+    }
+    ret = address_space_rw(&address_space_memory, cds->cda,
+                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
+    if (ret != MEMTX_OK) {
+        cds->flags |= CDS_F_STREAM_BROKEN;
+        return -EINVAL;
+    }
+incr:
+    cds->at_byte += len;
+    cds->cda += len;
+    return 0;
+}
+
+void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
+{
+    /*
+     * We don't support MIDA (an optional facility) yet and we
+     * catch this earlier. Just for expressing the precondition.
+     */
+    g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
+    cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
+                 (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
+                 (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
+    cds->count = ccw->count;
+    cds->cda_orig = ccw->cda;
+    ccw_dstream_rewind(cds);
+    if (!(cds->flags & CDS_F_IDA)) {
+        cds->op_handler = ccw_dstream_rw_noflags;
+    } else {
+        assert(false);
+    }
+}
 
 static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
                              bool suspend_allowed)
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 0653d3c9be..078356e94c 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -75,6 +75,29 @@ typedef struct CMBE {
     uint32_t reserved[7];
 } QEMU_PACKED CMBE;
 
+typedef enum CcwDataStreamOp {
+    CDS_OP_R = 0, /* read, false when used as is_write */
+    CDS_OP_W = 1, /* write, true when used as is_write */
+    CDS_OP_A = 2  /* advance, should not be used as is_write */
+} CcwDataStreamOp;
+
+/* normal usage is via SuchchDev.cds instead of instantiating */
+typedef struct CcwDataStream {
+#define CDS_F_IDA   0x01
+#define CDS_F_MIDA  0x02
+#define CDS_F_I2K   0x04
+#define CDS_F_C64   0x08
+#define CDS_F_STREAM_BROKEN  0x80
+    uint8_t flags;
+    uint8_t at_idaw;
+    uint16_t at_byte;
+    uint16_t count;
+    uint32_t cda_orig;
+    int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
+                      CcwDataStreamOp op);
+    hwaddr cda;
+} CcwDataStream;
+
 typedef struct SubchDev SubchDev;
 struct SubchDev {
     /* channel-subsystem related things: */
@@ -92,6 +115,7 @@ struct SubchDev {
     uint8_t ccw_no_data_cnt;
     uint16_t migrated_schid; /* used for missmatch detection */
     ORB orb;
+    CcwDataStream cds;
     /* transport-provided data: */
     int (*ccw_cb) (SubchDev *, CCW1);
     void (*disable_cb)(SubchDev *);
@@ -240,4 +264,47 @@ SubchDev *css_create_sch(CssDevId bus_id, bool is_virtual, bool squash_mcss,
 /** Turn on css migration */
 void css_register_vmstate(void);
 
+
+void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb);
+
+static inline void ccw_dstream_rewind(CcwDataStream *cds)
+{
+    cds->at_byte = 0;
+    cds->at_idaw = 0;
+    cds->cda = cds->cda_orig;
+}
+
+static inline bool ccw_dstream_good(CcwDataStream *cds)
+{
+    return !(cds->flags & CDS_F_STREAM_BROKEN);
+}
+
+static inline uint16_t ccw_dstream_residual_count(CcwDataStream *cds)
+{
+    return cds->count - cds->at_byte;
+}
+
+static inline uint16_t ccw_dstream_avail(CcwDataStream *cds)
+{
+    return ccw_dstream_good(cds) ? ccw_dstream_residual_count(cds) : 0;
+}
+
+static inline int ccw_dstream_advance(CcwDataStream *cds, int len)
+{
+    return cds->op_handler(cds, NULL, len, CDS_OP_A);
+}
+
+static inline int ccw_dstream_write_buf(CcwDataStream *cds, void *buff, int len)
+{
+    return cds->op_handler(cds, buff, len, CDS_OP_W);
+}
+
+static inline int ccw_dstream_read_buf(CcwDataStream *cds, void *buff, int len)
+{
+    return cds->op_handler(cds, buff, len, CDS_OP_R);
+}
+
+#define ccw_dstream_read(cds, v) ccw_dstream_read_buf((cds), &(v), sizeof(v))
+#define ccw_dstream_write(cds, v) ccw_dstream_write_buf((cds), &(v), sizeof(v))
+
 #endif
-- 
2.13.6
