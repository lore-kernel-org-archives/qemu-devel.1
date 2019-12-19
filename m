Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFCBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAAC206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h6IhQVxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAAC206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwSJ-0000rI-Ka
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYq-0001ZE-0S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1ihvYk-0006M3-H4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1ihvYj-0006GY-QB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:09:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20191219130940euoutp02a9c58bb8fa58a88fc57142631cc94eb7~hx8H3QEpe0729207292euoutp02n
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 13:09:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20191219130940euoutp02a9c58bb8fa58a88fc57142631cc94eb7~hx8H3QEpe0729207292euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576760980;
 bh=/udWAF5+K1DbSYjeVakspEVrNJzRWgme4+n05lR93yE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=h6IhQVxzRbBCDroKcu2nZGZtje2FrAaCWRYwEBBc949xZzF8XlKZP4LO3SMSNqsh7
 erXVhQ2M22SzH//WmLqZMnW9cc5vOa8gd2qmP/HyVXFcaOzjPkkgYuwYTNh5XDmQSk
 hh2USqfbnlDE7YCE73nK4/ck3udUvyvMz3DbLB8Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20191219130940eucas1p1ea31c0c64956e6c426e179712ab9644e~hx8Hv4pZ41797517975eucas1p1Y;
 Thu, 19 Dec 2019 13:09:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 85.05.60679.4967BFD5; Thu, 19
 Dec 2019 13:09:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20191219130939eucas1p1faaa8a7ebfd3fc40ca8cd72dca1a6682~hx8HZaGWx1459314593eucas1p1E;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20191219130939eusmtrp26b896a195516087d591bac3b9f883b8c~hx8HY18DW3097130971eusmtrp2C;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-d5-5dfb76945c29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 73.4D.08375.3967BFD5; Thu, 19
 Dec 2019 13:09:39 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191219130939eusmtip22fe7a40cd03c9f9509b6b3eae9465245~hx8HMyuUi2680126801eusmtip2S;
 Thu, 19 Dec 2019 13:09:39 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Thu, 19 Dec 2019 13:09:39 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Thu, 19 Dec 2019 13:09:38 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v4 08/24] nvme: refactor device realization
Date: Thu, 19 Dec 2019 14:09:05 +0100
Message-ID: <20191219130921.309264-9-k.jensen@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219130921.309264-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djPc7pTyn7HGvz4wmexub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ4rJJSc3JLEst
 0rdL4MrY1NvEVHDWs+LBnIQGxn6LLkZODgkBE4mJv26wdTFycQgJrGCU6HrWzA7hfGGU2LJy
 JyNIlZDAZ0aJr30pMB0Htu5jgihazijR9vA0K4QDVHT63VVGCOcMo8Syn5OZIZxdjBIntl1k
 B+lnE9CU2P7nPwuILSIgLdF+dRJYO7PAdUaJQ78hioQFrCWWPXoHVsQioCrxddEGMJtXwEri
 7o2XjBCHyEts/faJFcTmBKrf0nubEaJGUOLkzCdg9cxANc1bZzND2BISB1+8ALtIQmARu8TB
 nj4WiEEuEv2PT7JD2MISr45vgbJlJP7vnM8E0dDNKNH34StU9wxGienLvgNDjQPIsZboO5MD
 0eAosePUTyaIMJ/EjbeCEIv5JCZtm84MEeaV6GgTgqhWk9jRtJVxAqPyLCRnz0Jy9iwkZy9g
 ZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmFxO/zv+ZQfjrj9JhxgFOBiVeHhfJP+O
 FWJNLCuuzD3EKMHBrCTCe7vjZ6wQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1Kz
 U1MLUotgskwcnFINjGli3qbZR+aaaW891SWw+1LA4637sy+mT1i5ebXx+XBZ9rMXU6+eYpTZ
 9+fOltUJCZenfLDmrVpdmfXcQ7FfsKJ0yYpDR/Sm3xes7zt+jOVyUuSk9Sw+VxcKfV+ftyhT
 85Pr1rrs1vQIiy8eKvJPUrsWsm3VOrbxgHaHwvZdngd57pqxTmG/sEGJpTgj0VCLuag4EQAo
 Az6gKgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7qTy37HGjx5ZGSxub+d0WLSoWuM
 FksuplrMu6VsMetdO5vF8d4dLA5sHptWdbJ53Lm2h83jybXNTB7v911lC2CJ0rMpyi8tSVXI
 yC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY1NvEVHDWs+LBnIQG
 xn6LLkZODgkBE4kDW/cxdTFycQgJLGWUWHvhBhNEQkbi05WP7BC2sMSfa11sEEUfGSU29K9m
 hnDOMErcOPmSHcLZxShx/sR/FpAWNgFNie1/IGwRAWmJ9quTWEGKmAWuM0oc+n0RbK6wgLXE
 skfvwIpYBFQlvi7aAGbzClhJ3L3xkhFit7zE1m+fWEFsTqD6Lb23weJCQDWPf36EqheUODnz
 CZjNDFTfvHU2M4QtIXHwxQvmCYzCs5CUzUJSNgtJ2QJG5lWMIqmlxbnpucWGesWJucWleel6
 yfm5mxiBMbbt2M/NOxgvbQw+xCjAwajEw/sy+XesEGtiWXFl7iFGCQ5mJRHe2x0/Y4V4UxIr
 q1KL8uOLSnNSiw8xmgI9N5FZSjQ5Hxj/eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
 U1MLUotg+pg4OKUaGNMWcK3/zRm3KK/4T0D65i2+kRHSxw7zBWZJZNRM+1IpFrA6W5bnBd9j
 jeJbPxltAyUcjL/JHWy73d6pdMay7OZF32MNZ6QfJ3o+W2Qd7pSnevzgcbZvRrMFaixUzXbu
 qYyUOsLv8nSy44O0DcmTjlq88+OYdin+xEJ7/tLbG5PF3Hdvk53DqcRSnJFoqMVcVJwIADn6
 YeDHAgAA
X-CMS-MailID: 20191219130939eucas1p1faaa8a7ebfd3fc40ca8cd72dca1a6682
X-Msg-Generator: CA
X-RootMTR: 20191219130939eucas1p1faaa8a7ebfd3fc40ca8cd72dca1a6682
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130939eucas1p1faaa8a7ebfd3fc40ca8cd72dca1a6682
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130939eucas1p1faaa8a7ebfd3fc40ca8cd72dca1a6682@eucas1p1.samsung.com>
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

This patch splits up nvme_realize into multiple individual functions,
each initializing a different subset of the device.

Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 175 +++++++++++++++++++++++++++++++-----------------
 hw/block/nvme.h |  21 ++++++
 2 files changed, 133 insertions(+), 63 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d41ea5beab08..f9b9344f1376 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -44,6 +44,7 @@
 #include "nvme.h"
=20
 #define NVME_SPEC_VER 0x00010201
+#define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
=20
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -1325,67 +1326,106 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
     },
 };
=20
-static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+static int nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
-    NvmeCtrl *n =3D NVME(pci_dev);
-    NvmeIdCtrl *id =3D &n->id_ctrl;
-
-    int i;
-    int64_t bs_size;
-    uint8_t *pci_conf;
-
-    if (!n->params.num_queues) {
-        error_setg(errp, "num_queues can't be zero");
-        return;
-    }
+    NvmeParams *params =3D &n->params;
=20
     if (!n->conf.blk) {
-        error_setg(errp, "drive property not set");
-        return;
+        error_setg(errp, "nvme: block backend not configured");
+        return 1;
     }
=20
-    bs_size =3D blk_getlength(n->conf.blk);
-    if (bs_size < 0) {
-        error_setg(errp, "could not get backing file size");
-        return;
+    if (!params->serial) {
+        error_setg(errp, "nvme: serial not configured");
+        return 1;
     }
=20
-    if (!n->params.serial) {
-        error_setg(errp, "serial property not set");
-        return;
+    if ((params->num_queues < 1 || params->num_queues > NVME_MAX_QS)) {
+        error_setg(errp, "nvme: invalid queue configuration");
+        return 1;
     }
+
+    return 0;
+}
+
+static int nvme_init_blk(NvmeCtrl *n, Error **errp)
+{
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->con=
f.blk),
-                                       false, errp)) {
-        return;
+        false, errp)) {
+        return 1;
     }
=20
-    pci_conf =3D pci_dev->config;
-    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
-    pci_config_set_prog_interface(pci_dev->config, 0x2);
-    pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS);
-    pcie_endpoint_cap_init(pci_dev, 0x80);
+    return 0;
+}
=20
+static void nvme_init_state(NvmeCtrl *n)
+{
     n->num_namespaces =3D 1;
     n->reg_size =3D pow2ceil(0x1004 + 2 * (n->params.num_queues + 1) * 4=
);
-    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
-
     n->namespaces =3D g_new0(NvmeNamespace, n->num_namespaces);
     n->sq =3D g_new0(NvmeSQueue *, n->params.num_queues);
     n->cq =3D g_new0(NvmeCQueue *, n->params.num_queues);
+}
+
+static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
+    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2);
+    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+
+    n->cmbloc =3D n->bar.cmbloc;
+    n->cmbsz =3D n->bar.cmbsz;
+
+    n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                            "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz)=
);
+    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+        PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+}
+
+static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev)
+{
+    uint8_t *pci_conf =3D pci_dev->config;
=20
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n,
-                          "nvme", n->reg_size);
+    pci_conf[PCI_INTERRUPT_PIN] =3D 1;
+    pci_config_set_prog_interface(pci_conf, 0x2);
+    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+    pci_config_set_device_id(pci_conf, 0x5845);
+    pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+
+    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme=
",
+        n->reg_size);
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
     msix_init_exclusive_bar(pci_dev, n->params.num_queues, 4, NULL);
=20
+    if (n->params.cmb_size_mb) {
+        nvme_init_cmb(n, pci_dev);
+    }
+}
+
+static void nvme_init_ctrl(NvmeCtrl *n)
+{
+    NvmeIdCtrl *id =3D &n->id_ctrl;
+    NvmeParams *params =3D &n->params;
+    uint8_t *pci_conf =3D n->parent_obj.config;
+
     id->vid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid =3D cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VEND=
OR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn), "QEMU NVMe Ctrl", ' ');
     strpadcpy((char *)id->fr, sizeof(id->fr), "1.0", ' ');
-    strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
+    strpadcpy((char *)id->sn, sizeof(id->sn), params->serial, ' ');
     id->rab =3D 6;
     id->ieee[0] =3D 0x00;
     id->ieee[1] =3D 0x02;
@@ -1431,46 +1471,55 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
=20
     n->bar.vs =3D NVME_SPEC_VER;
     n->bar.intmc =3D n->bar.intms =3D 0;
+}
=20
-    if (n->params.cmb_size_mb) {
+static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
+{
+    int64_t bs_size;
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+
+    bs_size =3D blk_getlength(n->conf.blk);
+    if (bs_size < 0) {
+        error_setg_errno(errp, -bs_size, "blk_getlength");
+        return 1;
+    }
+
+    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
+    n->ns_size =3D bs_size;
+
+    id_ns->ncap =3D id_ns->nuse =3D id_ns->nsze =3D
+        cpu_to_le64(nvme_ns_nlbas(n, ns));
=20
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+    return 0;
+}
=20
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
+{
+    NvmeCtrl *n =3D NVME(pci_dev);
+    Error *local_err =3D NULL;
+    int i;
=20
-        n->cmbloc =3D n->bar.cmbloc;
-        n->cmbsz =3D n->bar.cmbsz;
+    if (nvme_check_constraints(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_check_constraints=
: ");
+        return;
+    }
=20
-        n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbs=
z));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64=
 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+    nvme_init_state(n);
=20
+    if (nvme_init_blk(n, &local_err)) {
+        error_propagate_prepend(errp, local_err, "nvme_init_blk: ");
+        return;
     }
=20
     for (i =3D 0; i < n->num_namespaces; i++) {
-        NvmeNamespace *ns =3D &n->namespaces[i];
-        NvmeIdNs *id_ns =3D &ns->id_ns;
-        id_ns->nsfeat =3D 0;
-        id_ns->nlbaf =3D 0;
-        id_ns->flbas =3D 0;
-        id_ns->mc =3D 0;
-        id_ns->dpc =3D 0;
-        id_ns->dps =3D 0;
-        id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
-        id_ns->ncap  =3D id_ns->nuse =3D id_ns->nsze =3D
-            cpu_to_le64(n->ns_size >>
-                id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds)=
;
+        if (nvme_init_namespace(n, &n->namespaces[i], &local_err)) {
+            error_propagate_prepend(errp, local_err, "nvme_init_namespac=
e: ");
+            return;
+        }
     }
+
+    nvme_init_pci(n, pci_dev);
+    nvme_init_ctrl(n);
 }
=20
 static void nvme_exit(PCIDevice *pci_dev)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 9957c4a200e2..a867bdfabafd 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -65,6 +65,22 @@ typedef struct NvmeNamespace {
     NvmeIdNs        id_ns;
 } NvmeNamespace;
=20
+static inline NvmeLBAF nvme_ns_lbaf(NvmeNamespace *ns)
+{
+    NvmeIdNs *id_ns =3D &ns->id_ns;
+    return id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
+}
+
+static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
+{
+    return nvme_ns_lbaf(ns).ds;
+}
+
+static inline size_t nvme_ns_lbads_bytes(NvmeNamespace *ns)
+{
+    return 1 << nvme_ns_lbads(ns);
+}
+
 #define TYPE_NVME "nvme"
 #define NVME(obj) \
         OBJECT_CHECK(NvmeCtrl, (obj), TYPE_NVME)
@@ -101,4 +117,9 @@ typedef struct NvmeCtrl {
     NvmeIdCtrl      id_ctrl;
 } NvmeCtrl;
=20
+static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
+{
+    return n->ns_size >> nvme_ns_lbads(ns);
+}
+
 #endif /* HW_NVME_H */
--=20
2.24.1


