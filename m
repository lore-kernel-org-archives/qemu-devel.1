Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F3C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FE721D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h1AZnbyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FE721D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwMc-00020R-1c
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYl-0001PF-0u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYi-0006Ew-BL
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:42 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYi-000609-0t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:40 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130936euoutp026c24701c93a6d1b00cf2669f59c4d446~hx8Ek1CT_0697606976euoutp02-
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130936euoutp026c24701c93a6d1b00cf2669f59c4d446~hx8Ek1CT_0697606976euoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760976;
 bh=F4I810NYfj9dY+sOtZ5F3YfokPRztm7Az/X9KGCd4j0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=h1AZnbyhf3WzgC3aB/YM8VkVJN6DoxIhX2L8EwaUtXgi8L/agA03zKE6gRFJCNGeU
 /F5EzFVaT2Yf7JyF6cT7ZmjLvJzRvXK2GSUgptFKZeFN+JBhJaadL5Y/V+Yoctt+CC
 ZHH3O9hg4lJeCE5MjMKETdNZA8jDXpuDOdhrR0FA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130936eucas1p1115dee2118d8f1716a1a7fcbc0a3b95a~hx8EbJLgC1260812608eucas1p1S;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 97.FF.61286.0967BFD5; Thu, 19
 Dec 2019 13:09:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130936eucas1p20ba8d3d8df30caad0fea8f2a7001f031~hx8EIoWNf3066830668eucas1p2a;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20191219130936eusmtrp103e6ad4322c6c5942f84e3c41458886b~hx8EIAS672186021860eusmtrp12;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4d-5dfb76908483
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.4D.08375.0967BFD5; Thu, 19
 Dec 2019 13:09:36 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130936eusmtip260c42d34ce65dae8a57dd43825aaecdc~hx8D74E412997729977eusmtip2G;
 Thu, 19 Dec 2019 13:09:36 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:35 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:35 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 03/24] nvme: move device parameters to separate struct
Date: Thu, 19 Dec 2019 14:09:00 +0100
Message-ID: <20191219130921.309264-4-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87oTyn7HGmy9pWOxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4Mr48jKm4KBDxaWP61kaGI8adDFyckgImEicfvyEpYuRi0NIYAWjxNXPXVDOF0aJ5ntP
 2SCcz4wSc19+ZIJpubF7NytEYjmjxIuZa1ngqlpnXGaCcM4wShzc/BKqbBejxObL21hA+tkE
 NCW2//kPZosISEu0X50EVsQscJ1R4tDvi+xdjBwcwgKeEkc6s0BqWARUJRb2nmMHsXkFrCS2
 fu1hhbhDXmLrt09gNqeAtcSW3tuMEDWCEidnPgGbzwxU07x1NjOELSFx8MULZpBdEgLL2CXe
 bjzBArJLQsBFon2bK8RMYYlXx7ewQ9gyEqcn97BA1HczSvR9+ArVPINRYvqy72wQzdYSfWdy
 IBocJZYsXsEKEeaTuPFWEGIvn8SkbdOZIcK8Eh1tQhDVahI7mrYyTmBUnoXk6llIrp6F5OoF
 jMyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAlPL6X/HP+1g/Hop6RCjAAejEg+vQ9rv
 WCHWxLLiytxDjBIczEoivLc7fsYK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
 OzW1ILUIJsvEwSnVwLilQfcHw9pv23T45s3xDN47y7dQme3mhNAnO/m8tdf/EVxxz35X0juZ
 q5P1Qxg0U/UPmH9e+9Fw4r66E/w15Qt3pivlsIk63rYScWepCTxTZv/d479uijmTd+Ad5p7D
 NlvDhDV4Eo5N28pVv23rhMvR+4qDZct+/HiT/i1e+7/NmRA3I92765RYijMSDbWYi4oTAXgT
 A5QpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xe7oTyn7HGjy8L2yxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv48jKm4KBDxaWP61ka
 GI8adDFyckgImEjc2L2btYuRi0NIYCmjxO5DmxkhEjISn658ZIewhSX+XOtigyj6yChxrGUr
 I4RzhlHi7cR1UO27GCUO7TsE1sImoCmx/c9/FhBbREBaov3qJLAiZoHrQEW/LwIVcXAIC3hK
 HOnMAqlhEVCVWNh7DqyXV8BKYuvXHlaI1fISW799ArM5BawltvTeBjtPCKjm8c+PLBD1ghIn
 Zz4Bs5mB6pu3zmaGsCUkDr54wTyBUXgWkrJZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQv
 XS85P3cTIzDCth37uXkH46WNwYcYBTgYlXh4Xyb/jhViTSwrrsw9xCjBwawkwnu742esEG9K
 YmVValF+fFFpTmrxIUZToOcmMkuJJucDoz+vJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
 anZqakFqEUwfEwenVAMjY+Ls8wxFzneDPNb2rpz+QPb3/VtLbKOLHdwSF/9cO9Vrx8+LRvyS
 1+r7Hzv+mmof+PaB6tKnF7ZmlLXsTvneOX+inWyHu/eLpJ8lW7rmbZRmvmq+6m2nzWcfRYZ5
 ncXr5Z6qt546/qgz3Gg675QHVb71xfNUq7mnf91m5LuqxqZQqPLa29nCSizFGYmGWsxFxYkA
 6I2sq8YCAAA=
X-CMS-MailID: 20191219130936eucas1p20ba8d3d8df30caad0fea8f2a7001f031
X-Msg-Generator: CA
X-RootMTR: 20191219130936eucas1p20ba8d3d8df30caad0fea8f2a7001f031
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130936eucas1p20ba8d3d8df30caad0fea8f2a7001f031
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130936eucas1p20ba8d3d8df30caad0fea8f2a7001f031@eucas1p2.samsung.com>
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

Move device configuration parameters to separate struct to make it
explicit what is configurable and what is set internally.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 44 ++++++++++++++++++++++----------------------
 hw/block/nvme.h | 16 +++++++++++++---
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 10666a3115c7..e458b8292ac0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -64,12 +64,12 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, =
void *buf, int size)
=20
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
 {
-    return sqid < n->num_queues && n->sq[sqid] !=3D NULL ? 0 : -1;
+    return sqid < n->params.num_queues && n->sq[sqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static int nvme_check_cqid(NvmeCtrl *n, uint16_t cqid)
 {
-    return cqid < n->num_queues && n->cq[cqid] !=3D NULL ? 0 : -1;
+    return cqid < n->params.num_queues && n->cq[cqid] !=3D NULL ? 0 : -1=
;
 }
=20
 static void nvme_inc_cq_tail(NvmeCQueue *cq)
@@ -631,7 +631,7 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *=
cmd)
         trace_nvme_dev_err_invalid_create_cq_addr(prp1);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-    if (unlikely(vector > n->num_queues)) {
+    if (unlikely(vector > n->params.num_queues)) {
         trace_nvme_dev_err_invalid_create_cq_vector(vector);
         return NVME_INVALID_IRQ_VECTOR | NVME_DNR;
     }
@@ -783,7 +783,8 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
         trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
         break;
     case NVME_NUMBER_OF_QUEUES:
-        result =3D cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2=
) << 16));
+        result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         trace_nvme_dev_getfeat_numq(result);
         break;
     case NVME_TIMESTAMP:
@@ -826,9 +827,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
         break;
     case NVME_NUMBER_OF_QUEUES:
         trace_nvme_dev_setfeat_numq((dw11 & 0xFFFF) + 1,
-            ((dw11 >> 16) & 0xFFFF) + 1, n->num_queues - 1, n->num_queue=
s - 1);
-        req->cqe.result =3D
-            cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 16=
));
+            ((dw11 >> 16) & 0xFFFF) + 1, n->params.num_queues - 1,
+            n->params.num_queues - 1);
+        req->cqe.result =3D cpu_to_le32((n->params.num_queues - 2) |
+            ((n->params.num_queues - 2) << 16));
         break;
     case NVME_TIMESTAMP:
         return nvme_set_feature_timestamp(n, cmd);
@@ -899,12 +901,12 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
=20
     blk_drain(n->conf.blk);
=20
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->sq[i] !=3D NULL) {
             nvme_free_sq(n->sq[i], n);
         }
     }
-    for (i =3D 0; i < n->num_queues; i++) {
+    for (i =3D 0; i < n->params.num_queues; i++) {
         if (n->cq[i] !=3D NULL) {
             nvme_free_cq(n->cq[i], n);
         }
@@ -1307,7 +1309,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     int64_t bs_size;
     uint8_t *pci_conf;
=20
-    if (!n->num_queues) {
+    if (!n->params.num_queues) {
         error_setg(errp, "num_queues can't be zero");
         return;
     }
@@ -1323,7 +1325,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         return;
     }
=20
-    if (!n->serial) {
+    if (!n->params.serial) {
         error_setg(errp, "serial property not set");
         return;
     }
@@ -1340,25 +1342,25 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
     n->num_namespaces =3D 1;
-    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
+    n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
     n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
=20
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
-    n->sq =3D g_new0(NvmeSQueue *, n->num_queues);
-    n->cq =3D g_new0(NvmeCQueue *, n->num_queues);
+    n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
+    n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
=20
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
                           "nvme", n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
+    msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
@@ -1387,7 +1389,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
     n->bar.vs =3D 0x00010200;
     n->bar.intmc =3D n->bar.intms =3D 0;
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
=20
         NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
         NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
@@ -1398,7 +1400,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
         NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
         NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
=20
         n->cmbloc =3D n->bar.cmbloc;
         n->cmbsz =3D n->bar.cmbsz;
@@ -1437,7 +1439,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->cq);
     g_free(n->sq);
=20
-    if (n->cmb_size_mb) {
+    if (n->params.cmb_size_mb) {
         g_free(n->cmbuf);
     }
     msix_uninit_exclusive_bar(pci_dev);
@@ -1445,9 +1447,7 @@ static void nvme_exit(PCIDevice *pci_dev)
=20
 static Property nvme_props[] =3D {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
-    DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
-    DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
-    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
+    DEFINE_NVME_PROPERTIES(NvmeCtrl, params),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 557194ee1954..9957c4a200e2 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -1,7 +1,19 @@
 #ifndef HW_NVME_H
 #define HW_NVME_H
+
 #include "block/nvme.h"
=20
+#define DEFINE_NVME_PROPERTIES(_state, _props) \
+    DEFINE_PROP_STRING("serial", _state, _props.serial), \
+    DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
+    DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64)
+
+typedef struct NvmeParams {
+    char     *serial;
+    uint32_t num_queues;
+    uint32_t cmb_size_mb;
+} NvmeParams;
+
 typedef struct NvmeAsyncEvent {
     QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
     NvmeAerResult result;
@@ -63,6 +75,7 @@ typedef struct NvmeCtrl {
     MemoryRegion ctrl_mem;
     NvmeBar      bar;
     BlockConf    conf;
+    NvmeParams   params;
=20
     uint32_t    page_size;
     uint16_t    page_bits;
@@ -71,10 +84,8 @@ typedef struct NvmeCtrl {
     uint16_t    sqe_size;
     uint32_t    reg_size;
     uint32_t    num_namespaces;
-    uint32_t    num_queues;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
-    uint32_t    cmb_size_mb;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
     uint8_t     *cmbuf;
@@ -82,7 +93,6 @@ typedef struct NvmeCtrl {
     uint64_t    host_timestamp;                 /* Timestamp sent by the=
 host */
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
=20
-    char            *serial;
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
--=20
2.24.1


