Received: from eggs.gnu.org ([2001:4830:134:3::10]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Bq-0000Rv-BX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ds6Bl-0005Rz-C2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ds6Bk-0005Ra-Vi
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:50:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8DBn7hh033160
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cy2qsmdyw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:50:39 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 13 Sep 2017 12:50:38 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 13 Sep 2017 13:50:26 +0200
In-Reply-To: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170913115029.47626-2-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
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

This is a preparation for introducing handling for indirect data
addressing and modified indirect data addressing (CCW). Here we introduce
an interface which should make the addressing scheme transparent for the
client code. Here we implement only the basic scheme (no IDA or MIDA).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 901dc6a0f3..e8d2016563 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -783,6 +783,61 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
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
index 0653d3c9be..79acaf99b7 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -75,6 +75,29 @@ typedef struct CMBE {
     uint32_t reserved[7];
 } QEMU_PACKED CMBE;
 
+typedef enum CcwDataStreamOp {
+    CDS_OP_R = 0,
+    CDS_OP_W = 1,
+    CDS_OP_A = 2
+} CcwDataStreamOp;
+
+/** normal usage is via SuchchDev.cds instead of instantiating */
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
+    return ccw_dstream_good(cds) ?  ccw_dstream_residual_count(cds) : 0;
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
2.13.5
