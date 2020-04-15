Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE104C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9359B206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9359B206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObJx-0000D2-Mb
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOaz1-0002sb-HB
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayy-0002qR-Sq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:53:11 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayu-0002Zd-QU; Wed, 15 Apr 2020 01:53:05 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E45D0BFD79;
 Wed, 15 Apr 2020 05:52:27 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 27/48] nvme: refactor dma read/write
Date: Wed, 15 Apr 2020 07:51:19 +0200
Message-Id: <20200415055140.466900-28-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Refactor the nvme_dma_{read,write}_prp functions into a common function
taking a DMADirection parameter.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 88 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3e41b1337bf7..2ff7dd695cd7 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -307,55 +307,50 @@ unmap:
     return status;
 }
=20
-static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t l=
en,
-                                   uint64_t prp1, uint64_t prp2)
+static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+                             uint64_t prp1, uint64_t prp2, DMADirection =
dir)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status =3D NVME_SUCCESS;
=20
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status =3D nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
+    if (status) {
+        return status;
     }
+
     if (qsg.nsg > 0) {
-        if (dma_buf_write(ptr, len, &qsg)) {
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
+        uint64_t residual;
+
+        if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
+            residual =3D dma_buf_write(ptr, len, &qsg);
+        } else {
+            residual =3D dma_buf_read(ptr, len, &qsg);
         }
-        qemu_sglist_destroy(&qsg);
-    } else {
-        if (qemu_iovec_to_buf(&iov, 0, ptr, len) !=3D len) {
-            status =3D NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_iovec_destroy(&iov);
-    }
-    return status;
-}
=20
-static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t le=
n,
-    uint64_t prp1, uint64_t prp2)
-{
-    QEMUSGList qsg;
-    QEMUIOVector iov;
-    uint16_t status =3D NVME_SUCCESS;
-
-    trace_nvme_dev_dma_read(prp1, prp2);
-
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-    if (qsg.nsg > 0) {
-        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        if (unlikely(residual)) {
             trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_sglist_destroy(&qsg);
     } else {
-        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) !=3D len)) {
+        size_t bytes;
+
+        if (dir =3D=3D DMA_DIRECTION_TO_DEVICE) {
+            bytes =3D qemu_iovec_to_buf(&iov, 0, ptr, len);
+        } else {
+            bytes =3D qemu_iovec_from_buf(&iov, 0, ptr, len);
+        }
+
+        if (unlikely(bytes !=3D len)) {
             trace_nvme_dev_err_invalid_dma();
             status =3D NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_iovec_destroy(&iov);
     }
+
     return status;
 }
=20
@@ -788,8 +783,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp=
1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, pr=
p2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf=
_len,
@@ -808,8 +803,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd=
 *cmd, uint32_t buf_len,
=20
     trans_len =3D MIN(sizeof(fw_log) - off, buf_len);
=20
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, pr=
p1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, p=
rp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -833,7 +828,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd =
*cmd, uint8_t rae,
=20
     trans_len =3D MIN(sizeof(errlog) - off, buf_len);
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp=
2);
+    return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req=
)
@@ -981,8 +977,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeI=
dentify *c)
=20
     trace_nvme_dev_identify_ctrl();
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctr=
l),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), p=
rp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
@@ -1001,8 +997,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeId=
entify *c)
=20
     ns =3D &n->namespaces[nsid - 1];
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns)=
,
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp=
1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
@@ -1027,7 +1023,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, N=
vmeIdentify *c)
             break;
         }
     }
-    ret =3D nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    ret =3D nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+                       DMA_DIRECTION_FROM_DEVICE);
     g_free(list);
     return ret;
 }
@@ -1066,7 +1063,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtr=
l *n, NvmeIdentify *c)
     ns_descrs->uuid.hdr.nidl =3D NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
=20
-    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp=
2);
+    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
@@ -1147,8 +1145,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
=20
     uint64_t timestamp =3D nvme_get_timestamp(n);
=20
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
-                                 sizeof(timestamp), prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp=
1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
=20
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
@@ -1233,8 +1231,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl=
 *n, NvmeCmd *cmd)
     uint64_t prp1 =3D le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->dptr.prp2);
=20
-    ret =3D nvme_dma_write_prp(n, (uint8_t *)&timestamp,
-                                sizeof(timestamp), prp1, prp2);
+    ret =3D nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), pr=
p1,
+                       prp2, DMA_DIRECTION_TO_DEVICE);
     if (ret !=3D NVME_SUCCESS) {
         return ret;
     }
--=20
2.26.0


