Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3970C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E27206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E27206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOb5g-00070e-DU
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayf-0001kq-8K
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayb-0002bB-St
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayY-0002PG-UQ; Wed, 15 Apr 2020 01:52:43 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id B02B4BFD37;
 Wed, 15 Apr 2020 05:52:21 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 12/48] nvme: add temperature threshold feature
Date: Wed, 15 Apr 2020 07:51:04 +0200
Message-Id: <20200415055140.466900-13-its@irrelevant.dk>
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

It might seem wierd to implement this feature for an emulated device,
but it is mandatory to support and the feature is useful for testing
asynchronous event request support, which will be added in a later
patch.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h      |  1 +
 include/block/nvme.h |  8 +++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d1c42ee4765c..e777cc9075c1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -45,6 +45,9 @@
 #include "nvme.h"
=20
 #define NVME_CMB_BIR 2
+#define NVME_TEMPERATURE 0x143
+#define NVME_TEMPERATURE_WARNING 0x157
+#define NVME_TEMPERATURE_CRITICAL 0x175
=20
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -798,9 +801,31 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl =
*n, NvmeCmd *cmd)
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest =
*req)
 {
     uint32_t dw10 =3D le32_to_cpu(cmd->cdw10);
+    uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
     uint32_t result;
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        result =3D 0;
+
+        /*
+         * The controller only implements the Composite Temperature sens=
or, so
+         * return 0 for all other sensors.
+         */
+        if (NVME_TEMP_TMPSEL(dw11) !=3D NVME_TEMP_TMPSEL_COMPOSITE) {
+            break;
+        }
+
+        switch (NVME_TEMP_THSEL(dw11)) {
+        case NVME_TEMP_THSEL_OVER:
+            result =3D cpu_to_le16(n->features.temp_thresh_hi);
+            break;
+        case NVME_TEMP_THSEL_UNDER:
+            result =3D cpu_to_le16(n->features.temp_thresh_low);
+            break;
+        }
+
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -845,6 +870,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        if (NVME_TEMP_TMPSEL(dw11) !=3D NVME_TEMP_TMPSEL_COMPOSITE) {
+            break;
+        }
+
+        switch (NVME_TEMP_THSEL(dw11)) {
+        case NVME_TEMP_THSEL_OVER:
+            n->features.temp_thresh_hi =3D NVME_TEMP_TMPTH(dw11);
+            break;
+        case NVME_TEMP_THSEL_UNDER:
+            n->features.temp_thresh_low =3D NVME_TEMP_TMPTH(dw11);
+            break;
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
         break;
@@ -1373,6 +1415,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.max_ioqpairs + 1);
     n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
+    n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1450,6 +1493,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
+
+    /* recommended default value (~70 C) */
+    id->wctemp =3D cpu_to_le16(NVME_TEMPERATURE_WARNING);
+    id->cctemp =3D cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
+
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b7c465560eea..807c4ad19dcc 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -115,6 +115,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    NvmeFeatureVal  features;
 } NvmeCtrl;
=20
 static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index b30744068d46..a0519814ecec 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -688,7 +688,13 @@ enum NvmeIdCtrlOncs {
 typedef struct NvmeFeatureVal {
     uint32_t    arbitration;
     uint32_t    power_mgmt;
-    uint32_t    temp_thresh;
+    union {
+        struct {
+            uint16_t temp_thresh_hi;
+            uint16_t temp_thresh_low;
+        };
+        uint32_t temp_thresh;
+    };
     uint32_t    err_rec;
     uint32_t    volatile_wc;
     uint32_t    num_queues;
--=20
2.26.0


