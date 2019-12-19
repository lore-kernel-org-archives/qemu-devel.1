Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1459121D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LSMyQNI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1459121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwPu-0005d1-I9
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYo-0001XH-S4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYl-0006P0-EP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:46 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55863)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYk-0006It-Vv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130941euoutp02765f9b765b4a79e09a1fdc76fb382510~hx8IqVB1V0697606976euoutp02I
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130941euoutp02765f9b765b4a79e09a1fdc76fb382510~hx8IqVB1V0697606976euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760981;
 bh=1Vx5l5dqYuHG6gTUMzpASbOeY3/CxjIqdBbYMM6xbJ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=LSMyQNI/VUoVPm1B1xLwv8Qz9RRQaoT6WMo6VknX2VNwYJLoScgeeg9GGO6MIoLDe
 a0q/ZwieofMpE+yDVwFxvq6h815o2aWt9BerZKiTcQ/ACP3dEjwGNz+IZLKdOGH+ka
 Ws9xJcr6b2ChE1edRw8xk5xQrdTl4gA+lxB+BS9w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191219130941eucas1p23830aae141acacc13f90d65ae6687895~hx8Ia0jC93066830668eucas1p2g;
 Thu, 19 Dec 2019 13:09:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.5F.60698.4967BFD5; Thu, 19
 Dec 2019 13:09:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130940eucas1p2ed4053766595fbef6b5ddee13565f22f~hx8IDHK820341303413eucas1p2x;
 Thu, 19 Dec 2019 13:09:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130940eusmtrp26e9a9b2d56c946cd2043559e7df8a8ba~hx8ICkKAQ3097130971eusmtrp2G;
 Thu, 19 Dec 2019 13:09:40 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-5d-5dfb76942c74
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.4D.08375.4967BFD5; Thu, 19
 Dec 2019 13:09:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130940eusmtip1e706f12adce089f511e2dccfd9d85b21~hx8H5I9dP2511425114eusmtip1h;
 Thu, 19 Dec 2019 13:09:40 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:39 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:39 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 09/24] nvme: add temperature threshold feature
Date: Thu, 19 Dec 2019 14:09:06 +0100
Message-ID: <20191219130921.309264-10-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTcRjG+e+cnR1Hk9MUfFNDmmgYZYkShxylILHLbgyJhk096mqbY0ct
 u0mm+YlWZswmfiTmbBHR5pZlGo3IIhGtNMtgjKRm2fIjnUtxbR4N7573fZ7n/f8u/iQmNvAj
 SaWmmNFpFCoJIcTtr3yjh26VrsmPGK2Itl6rRnSTYxLR3eMM3f45ljZ6qgl6uKEfTyNkFnMt
 Ifsy+YyQzUxaebLfQxPEKfyMUJrHqJSljO7w8XPCwrHuB7jWGn+pzXODV46ao+tQCAlUCrge
 mVAdEpJiqheB3rLE44Y/CD4sDuDcsITg3tde/nbFduf+lmFC0O7yYf9TCxtuATeMIOjx3dxy
 niL46fTygn2CSoDH6348qMOpKKieaOIHQxj1EYFjbVwQNMKodLBbVgNcJIlTcWA0KoJrEZUK
 c852jOOIAdvK4iZTSGDf1zCNuMxueHN7ZvM+FshU2FoxTgO8cLs3gYAyC2B+8DvBHcqASu8c
 4nQY/BjuE3A6GvxPOnhcoR5B4/zyVrsFgaHHSwTpIPB044iKk+nw3JvFyVCY+rWbezcUmuwG
 jFuLoKZKzF2Ph369DV1HscYd1MYd1MYd1J0IM6MIpoRVFzBssoa5mMgq1GyJpiAxt0htQYHv
 8nZjeLkfDa3nOBBFIskuUVr+mlzMV5SyZWoHAhKThIuma3xysShPUXaZ0RVl60pUDOtAUSQu
 iRAld83KxVSBopi5wDBaRrft8siQyHKk7hB3vZy92tX6Or/hbptUcl55YuVKdnEm7dqLPSyL
 S8pV6t9p9dHuo/565+zYuJKeapa6UpNM0o33RdNVWTl7Kvd5eirnTw+uns2oT/hr8H86ZvbY
 nZ0Gcj9/6GBLMy/vJDJV6HrTRyMXhI4UIlXKZkZpY2r98YMxA99atRKcLVQkHcB0rOIfJ2qU
 lioDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7pTyn7HGkydpmSxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mu4sGQtS8FmtYq57yYy
 NTBOkeli5OSQEDCR2LpwNUsXIxeHkMBSRok3P16wQiRkJD5d+cgOYQtL/LnWxQZR9JFRYtqH
 NijnDKPEjZMv2SGcXYwSs5pWM4K0sAloSmz/858FxBYRkJZovzqJFaSIWeA6o8Sh3xfB5goL
 OEps2/QDqIGDg0VAVWLWrESQMK+AtcSb+/OYIVbLS2z99gnsJE6g+Jbe22DzhQSsJB7//MgC
 US8ocXLmEzCbGai+eetsZghbQuLgixfMExiFZyEpm4WkbBaSsgWMzKsYRVJLi3PTc4sN9YoT
 c4tL89L1kvNzNzECY2zbsZ+bdzBe2hh8iFGAg1GJh/dl8u9YIdbEsuLK3EOMEhzMSiK8tzt+
 xgrxpiRWVqUW5ccXleakFh9iNAX6bSKzlGhyPjD+80riDU0NzS0sDc2NzY3NLJTEeTsEDsYI
 CaQnlqRmp6YWpBbB9DFxcEo1MC7SvTbl0Zd/fI3pnxUzqjzOhxxKnRwVeP7Y49tPBOrDCt+X
 XtjxcMWl/gS9gqudF73t/W5slNwWv9svNe20x4HkX/aexeaJK1cZcQvKfexa5X9d/zmT51ov
 u9pam+ZzG5hEi4Q5cheu+zlHvnAHr+uBtUuTztvoxZzx9xVwZA+qkBGPP+XtocRSnJFoqMVc
 VJwIADCn7z3HAgAA
X-CMS-MailID: 20191219130940eucas1p2ed4053766595fbef6b5ddee13565f22f
X-Msg-Generator: CA
X-RootMTR: 20191219130940eucas1p2ed4053766595fbef6b5ddee13565f22f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130940eucas1p2ed4053766595fbef6b5ddee13565f22f
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130940eucas1p2ed4053766595fbef6b5ddee13565f22f@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
X-Mailman-Approved-At: Thu, 19 Dec 2019 08:56:47 -0500
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It might seem wierd to implement this feature for an emulated device,
but it is mandatory to support and the feature is useful for testing
asynchronous event request support, which will be added in a later
patch.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c      | 47 ++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h      |  2 ++
 include/block/nvme.h |  7 ++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f9b9344f1376..13d412d76c8e 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -45,6 +45,7 @@
=20
 #define NVME_SPEC_VER 0x00010201
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
+#define NVME_TEMPERATURE 0x143
=20
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -801,6 +802,27 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
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
+        if (NVME_TEMP_TMPSEL(dw10)) {
+            break;
+        }
+
+        switch (NVME_TEMP_THSEL(dw10)) {
+        case 0x0:
+            result =3D cpu_to_le16(n->features.temp_thresh_hi);
+            break;
+        case 0x1:
+            result =3D cpu_to_le16(n->features.temp_thresh_low);
+            break;
+        }
+
+        break;
     case NVME_VOLATILE_WRITE_CACHE:
         result =3D blk_enable_write_cache(n->conf.blk);
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
@@ -845,6 +867,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
     uint32_t dw11 =3D le32_to_cpu(cmd->cdw11);
=20
     switch (dw10) {
+    case NVME_TEMPERATURE_THRESHOLD:
+        if (NVME_TEMP_TMPSEL(dw11)) {
+            break;
+        }
+
+        switch (NVME_TEMP_THSEL(dw11)) {
+        case 0x0:
+            n->features.temp_thresh_hi =3D NVME_TEMP_TMPTH(dw11);
+            break;
+        case 0x1:
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
@@ -1366,6 +1405,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+
+    n->temperature =3D NVME_TEMPERATURE;
+    n->features.temp_thresh_hi =3D le16_to_cpu(n->id_ctrl.wctemp);
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1447,6 +1489,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     id->acl =3D 3;
     id->frmw =3D 7 << 1;
     id->lpa =3D 1 << 0;
+
+    /* recommended default value (~70 C) */
+    id->wctemp =3D cpu_to_le16(0x157);
+    id->cctemp =3D cpu_to_le16(0x175);
+
     id->sqes =3D (0x6 << 4) | 0x6;
     id->cqes =3D (0x4 << 4) | 0x4;
     id->nn =3D cpu_to_le32(n->num_namespaces);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index a867bdfabafd..1518f32557a3 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -108,6 +108,7 @@ typedef struct NvmeCtrl {
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
+    uint16_t    temperature;
=20
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
@@ -115,6 +116,7 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+    NvmeFeatureVal  features;
 } NvmeCtrl;
=20
 static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index d2f65e8fe496..ff31cb32117c 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -616,7 +616,8 @@ enum NvmeIdCtrlOncs {
 typedef struct NvmeFeatureVal {
     uint32_t    arbitration;
     uint32_t    power_mgmt;
-    uint32_t    temp_thresh;
+    uint16_t    temp_thresh_hi;
+    uint16_t    temp_thresh_low;
     uint32_t    err_rec;
     uint32_t    volatile_wc;
     uint32_t    num_queues;
@@ -635,6 +636,10 @@ typedef struct NvmeFeatureVal {
 #define NVME_INTC_THR(intc)     (intc & 0xff)
 #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
=20
+#define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
+#define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
+#define NVME_TEMP_TMPTH(temp)  (temp & 0xffff)
+
 enum NvmeFeatureIds {
     NVME_ARBITRATION                =3D 0x1,
     NVME_POWER_MANAGEMENT           =3D 0x2,
--=20
2.24.1


