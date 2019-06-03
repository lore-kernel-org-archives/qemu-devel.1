Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB4C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B662278E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B662278E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoXP-0002IL-3a
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:06:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUw-0000gc-VA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXoUv-0007s6-B5
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:03:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXoUq-0007jW-Kq; Mon, 03 Jun 2019 11:03:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35D783107B2E;
	Mon,  3 Jun 2019 15:03:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-129.ams2.redhat.com
	[10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C209767279;
	Mon,  3 Jun 2019 15:03:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  3 Jun 2019 17:02:14 +0200
Message-Id: <20190603150233.6614-10-kwolf@redhat.com>
In-Reply-To: <20190603150233.6614-1-kwolf@redhat.com>
References: <20190603150233.6614-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 15:03:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/28] nvme: add Get/Set Feature Timestamp
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kenneth Heitke <kenneth.heitke@intel.com>

Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
Reviewed-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.h       |   2 +
 include/block/nvme.h  |   2 +
 hw/block/nvme.c       | 106 +++++++++++++++++++++++++++++++++++++++++-
 hw/block/trace-events |   2 +
 4 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 56c9d4b4b1..557194ee19 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -79,6 +79,8 @@ typedef struct NvmeCtrl {
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
+    uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
+    uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
=20
     char            *serial;
     NvmeNamespace   *namespaces;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 849a6f3fa3..3ec8efcc43 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -581,6 +581,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_WRITE_ZEROS   =3D 1 << 3,
     NVME_ONCS_FEATURES      =3D 1 << 4,
     NVME_ONCS_RESRVATIONS   =3D 1 << 5,
+    NVME_ONCS_TIMESTAMP     =3D 1 << 6,
 };
=20
 #define NVME_CTRL_SQES_MIN(sqes) ((sqes) & 0xf)
@@ -622,6 +623,7 @@ enum NvmeFeatureIds {
     NVME_INTERRUPT_VECTOR_CONF      =3D 0x9,
     NVME_WRITE_ATOMICITY            =3D 0xa,
     NVME_ASYNCHRONOUS_EVENT_CONF    =3D 0xb,
+    NVME_TIMESTAMP                  =3D 0xe,
     NVME_SOFTWARE_PROGRESS_MARKER   =3D 0x80
 };
=20
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63a5b58849..ea409da76e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -219,6 +219,30 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIO=
Vector *iov, uint64_t prp1,
     return NVME_INVALID_FIELD | NVME_DNR;
 }
=20
+static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
+                                   uint64_t prp1, uint64_t prp2)
+{
+    QEMUSGList qsg;
+    QEMUIOVector iov;
+    uint16_t status =3D NVME_SUCCESS;
+
+    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+    if (qsg.nsg > 0) {
+        if (dma_buf_write(ptr, len, &qsg)) {
+            status =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_sglist_destroy(&qsg);
+    } else {
+        if (qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len) {
+            status =3D NVME_INVALID_FIELD | NVME_DNR;
+        }
+        qemu_iovec_destroy(&iov);
+    }
+    return status;
+}
+
 static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
     uint64_t prp1, uint64_t prp2)
 {
@@ -678,7 +702,6 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nvm=
eIdentify *c)
     return ret;
 }
=20
-
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
@@ -696,6 +719,57 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *=
cmd)
     }
 }
=20
+static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
+{
+    trace_nvme_setfeat_timestamp(ts);
+
+    n->host_timestamp =3D le64_to_cpu(ts);
+    n->timestamp_set_qemu_clock_ms =3D qemu_clock_get_ms(QEMU_CLOCK_REAL=
TIME);
+}
+
+static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
+{
+    uint64_t current_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    uint64_t elapsed_time =3D current_time - n->timestamp_set_qemu_clock=
_ms;
+
+    union nvme_timestamp {
+        struct {
+            uint64_t timestamp:48;
+            uint64_t sync:1;
+            uint64_t origin:3;
+            uint64_t rsvd1:12;
+        };
+        uint64_t all;
+    };
+
+    union nvme_timestamp ts;
+    ts.all =3D 0;
+
+    /*
+     * If the sum of the Timestamp value set by the host and the elapsed
+     * time exceeds 2^48, the value returned should be reduced modulo 2^=
48.
+     */
+    ts.timestamp =3D (n->host_timestamp + elapsed_time) & 0xffffffffffff=
;
+
+    /* If the host timestamp is non-zero, set the timestamp origin */
+    ts.origin =3D n->host_timestamp ? 0x01 : 0x00;
+
+    trace_nvme_getfeat_timestamp(ts.all);
+
+    return cpu_to_le64(ts.all);
+}
+
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    uint64_t timestamp =3D nvme_get_timestamp(n);
+
+    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
+                                 sizeof(timestamp), prp1, prp2);
+}
+
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
@@ -710,6 +784,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
         trace_nvme_getfeat_numq(result);
         break;
+    case NVME_TIMESTAMP:
+        return nvme_get_feature_timestamp(n, cmd);
+        break;
     default:
         trace_nvme_err_invalid_getfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -719,6 +796,24 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
=20
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+{
+    uint16_t ret;
+    uint64_t timestamp;
+    uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
+    uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
+
+    ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
+                                sizeof(timestamp), prp1, prp2);
+    if (ret !=3D NVME_SUCCESS) {
+        return ret;
+    }
+
+    nvme_set_timestamp(n, timestamp);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
@@ -735,6 +830,11 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         req->cqe.result =3D
             cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
         break;
+
+    case NVME_TIMESTAMP:
+        return nvme_set_feature_timestamp(n, cmd);
+        break;
+
     default:
         trace_nvme_err_invalid_setfeat(dw10);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -907,6 +1007,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
         NVME_AQA_ASQS(n->bar.aqa) + 1);
=20
+    nvme_set_timestamp(n, 0ULL);
+
     return 0;
 }
=20
@@ -1270,7 +1372,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
-    id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS);
+    id->oncs =3D cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP=
);
     id->psd[0].mp =3D cpu_to_le16(0x9c4);
     id->psd[0].enlat =3D cpu_to_le32(0x10);
     id->psd[0].exlat =3D cpu_to_le32(0x4);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index b92039a573..97a17838ed 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,6 +46,8 @@ nvme_identify_nslist(uint16_t ns) "identify namespace l=
ist, nsid=3D%"PRIu16""
 nvme_getfeat_vwcache(const char* result) "get feature volatile write cac=
he, result=3D%s"
 nvme_getfeat_numq(int result) "get feature number of queues, result=3D%d=
"
 nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested=
 cq_count=3D%d sq_count=3D%d, responding with cq_count=3D%d sq_count=3D%d=
"
+nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp =3D 0x%"PRIx6=
4""
+nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp =3D 0x%"PRIx6=
4""
 nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask set, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interr=
upt mask clr, data=3D0x%"PRIx64", new_mask=3D0x%"PRIx64""
 nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=3D0x%=
"PRIx64""
--=20
2.20.1


