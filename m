Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EBC3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A20B217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s1yP255P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A20B217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55367 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuyq-0000B5-I0
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusk-0004IU-73
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusi-0007Sj-Rb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:34 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35262)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusi-00076Q-MH
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:32 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095221euoutp01acdbb5d7de14f0eb6be6bf6aacdedf13~wKkRAMVCh3121331213euoutp01F
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095221euoutp01acdbb5d7de14f0eb6be6bf6aacdedf13~wKkRAMVCh3121331213euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809941;
 bh=4EpvFdU+DeuFJOnaiiYBi64NIK48yKS7IlLLSOYemBo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=s1yP255Py13HDMwFS5md3PnyLw1TCUw5buC+n8G3mt8hIDQkEbTaDFn//K6sULO4k
 WMY5cHv0UGe5gjwJJvcF2FMzsZ9y/mUImz2sToBtGa3dqOnwwlD9D9+/haexhllL6x
 5eX+IGG1t+/0EA4ZzrVXoXkyKDKi4x/SU0nUIKKE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095221eucas1p236037c6f6caa110e837d0bdcb18de0d8~wKkQupVGb1140011400eucas1p2q;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.9E.61286.5DE393E5; Tue,  4
 Feb 2020 09:52:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11~wKkQYQZdT1889018890eucas1p1B;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095221eusmtrp2f9e7052466e56d9637be3154c61d0a73~wKkQW_oZb0485704857eusmtrp2j;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-f5-5e393ed51a7d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.CC.08375.5DE393E5; Tue,  4
 Feb 2020 09:52:21 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095221eusmtip1937652f2dcd47bc3fa0e3d5c74d39457~wKkQPeRKm3103431034eusmtip1q;
 Tue,  4 Feb 2020 09:52:21 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:20 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:20 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 09/26] nvme: add temperature threshold feature
Date: Tue, 4 Feb 2020 10:51:51 +0100
Message-ID: <20200204095208.269131-10-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87pX7SzjDC7MlrTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFFcNimpOZllqUX6dglcGT9WNbEVXNSomHTiHmsDY49cFyMHh4SAicSZT5VdjFwcQgIrGCUW
 Lj/DBOF8YZRYv6eBDcL5zCjx5sgk5i5GTrCOe3tmM0IkljNKbP69lAWu6vzVRVAtpxklFt14
 xArh7GSU2HPrJhtIP5uApsT2P/9ZQGwRAWmJ9quTwIqYBX4zSsxtnAhWJCzgKHGo4zDYQhYB
 FYn3m4+xg5zLK2AtcfJeIsQd8hKzG0+DlXMChfevOsEEYvMKCEqcnPkEbD4zUE3z1tnMELaE
 xMEXL5hBdkkI7GKX+LH+KxPEIBeJ7z9/s0HYwhKvjm9hh7BlJP7vnM8E0dDNKNH34StU9wxG
 ienLvrNBAtBaou9MDkSDo8SeWRugwnwSN94KQizmk5i0bTozRJhXoqNNCKJaTWJH01bGCYzK
 s5CcPQvJ2bOQnL2AkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMI5/e/4px2MXy8l
 HWIU4GBU4uG9YGcRJ8SaWFZcmXuIUYKDWUmE97y+ZZwQb0piZVVqUX58UWlOavEhRmkOFiVx
 XuNFL2OFBNITS1KzU1MLUotgskwcnFINjC3e9+Mf3Vibe+qS0aswnr8i/O9DHhqfYt8cPvVZ
 pOS0I9/2H9z9W09u4+Vq7vlv5nVVfEv2VZ69c9J9y9mzMzrY+k8syjWN8OlKkjXZZl92iGtt
 W5xKkty0b26mE2fOSvE6c6/Wfh3L43UGS0S3hRZ90J9XJNfwyCz0q8O9YknJ344dq1t+VCmx
 FGckGmoxFxUnAgCreOB+NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7pX7SzjDLqeslps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jB+r
 mtgKLmpUTDpxj7WBsUeui5GTQ0LAROLentmMXYxcHEICSxkldi3+xgqRkJH4dOUjO4QtLPHn
 WhcbRNFHRokXL55DdZxmlHj95ARUZiejxLHLuxlBWtgENCW2//nPAmKLCEhLtF+dBDaWWeA3
 o8SfvkAQW1jAUeJQx2FmEJtFQEXi/eZjQOs4OHgFrCVO3kuE2CwvMbvxNBuIzQkU3r/qBBNI
 iZCAlUTrUW6QMK+AoMTJmU9YIKbLSzRvnc0MYUtIHHzxgnkCo/AsJGWzkJTNQlK2gJF5FaNI
 amlxbnpusaFecWJucWleul5yfu4mRmDMbTv2c/MOxksbgw8xCnAwKvHwXrCziBNiTSwrrsw9
 xCjBwawkwnte3zJOiDclsbIqtSg/vqg0J7X4EKMp0GsTmaVEk/OB6SCvJN7Q1NDcwtLQ3Njc
 2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAMjf3rYPPGtfC92uyza9P/6z8jrle++vFmU
 yWPTHPerYbO78c4fi/aK32mTTF9g/H2nbtu/mQsVm+6ua2S7uPrjIU1PrRU9BVW7PHyWWjxy
 WdxdFLVrptS9ODHvXIbMdJP/MR4ZReefWG8JfL7xzpziuv2JmYwHa1LnfPnU28U87ULq/01f
 hOM/K7EUZyQaajEXFScCANxXMjnPAgAA
X-CMS-MailID: 20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11
X-Msg-Generator: CA
X-RootMTR: 20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It might seem wierd to implement this feature for an emulated device,
but it is mandatory to support and the feature is useful for testing
asynchronous event request support, which will be added in a later
patch.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++
 hw/block/nvme.h      |  2 ++
 include/block/nvme.h |  7 ++++++-
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 81514eaef63a..f72348344832 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -45,6 +45,9 @@
=20
 #define NVME_SPEC_VER 0x00010201
 #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
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
+        if (NVME_TEMP_TMPSEL(dw11)) {
+            break;
+        }
+
+        switch (NVME_TEMP_THSEL(dw11)) {
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
@@ -845,6 +870,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
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
@@ -1366,6 +1408,9 @@ static void nvme_init_state(NvmeCtrl *n)
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+
+    n->temperature =3D NVME_TEMPERATURE;
+    n->features.temp_thresh_hi =3D NVME_TEMPERATURE_WARNING;
 }
=20
 static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
@@ -1447,6 +1492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
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
2.25.0


