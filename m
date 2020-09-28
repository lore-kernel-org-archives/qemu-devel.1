Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD3C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5963422207
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cJMipVga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5963422207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj77-0004y3-He
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj15-0006i2-Qr; Sun, 27 Sep 2020 22:35:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj13-0003Me-20; Sun, 27 Sep 2020 22:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260548; x=1632796548;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UDuLJS8ivD9CXbE+11TI2ORdz66TvhIrpaAfBRSi47o=;
 b=cJMipVgaU+JKNTq1hBeUD8po5rLbrIWInUQ2YwbRH98jEmefWswnBB+3
 jUFoa6yy1oTLdivhAzqJfM56D0KSbo7cD28ZFX9J3/3Y/9NQ1KSRcIK/l
 TW01iKdY2OuY603w7hb5VyNNWEHO6VrMbqMRb4ELCYxg4Tj2yBk/61y0C
 nyKXWjliitJEIA8xX4UTcN+A01Bk7QMfRfEpm7z3+PuUIKmaTNiKvH6ef
 EkDORBorVqxbv0TFQWaoZXf0FMFvTFV+MiFE+XZlRhH89EACNhVLsy1NN
 jEOPqJCeXQ7gG0gKzOdpORyQmdTsj0oZfUPw5p7ErE3OfEGJaRYCqWJ/F A==;
IronPort-SDR: +fDfnpunvuiv21PHQZyYaMJJHvaTKdTOAu6EqJLchOiHnrLTALbfNDBK6dkKa5KJ1iBxbSr1fh
 BX084xf7e/JPIeKEqdfKucu/SyK55ByGfuoLQW3xWOL+O0KCKH7qPmVc78flPFeHbgg+W4coGn
 f46BciReZvVpjEXtYiZrDWWf8U6SnaHRNuqKXLb5G6HpPyn21fOpuF/FVdFdR5Eg29rT1TuRGh
 9ZGuFzGJg/FWqrYJzeG+KmoSocmr+oS0X07KR7IU3Cigb90t38wIVbm1I9ER17iWjzIvCdGRgC
 Eck=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125238"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:47 +0800
IronPort-SDR: 420OFxD41w2DRShhWUs22zq9moxhasx01CDMslf1cqBolP7JtfWHHJWQZ2hGdLbsgjeDnfMKOz
 z8cEmxVyiyrg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:43 -0700
IronPort-SDR: zU4B6l/MF/it5oRIUc4lVhffLLtZw5557RX5U0cvp2GqHtXe92Xz3tnnBbXLcBA/K3CtCToUV2
 KcGXANpT74tg==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:46 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 06/14] hw/block/nvme: Add support for active/inactive
 namespaces
Date: Mon, 28 Sep 2020 11:35:20 +0900
Message-Id: <20200928023528.15260-7-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=5334b480d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 22:35:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Niklas Cassel <niklas.cassel@wdc.com>

In NVMe, a namespace is active if it exists and is attached to the
controller.

CAP.CSS (together with the I/O Command Set data structure) defines what
command sets are supported by the controller.

CC.CSS (together with Set Profile) can be set to enable a subset of the
available command sets. The namespaces belonging to a disabled command set
will not be able to attach to the controller, and will thus be inactive.

E.g., if the user sets CC.CSS to Admin Only, NVM namespaces should be
marked as inactive.

The identify namespace, the identify namespace CSI specific, and the namespace
list commands have two different versions, one that only shows active
namespaces, and the other version that shows existing namespaces, regardless
of whether the namespace is attached or not.

Add an attached member to struct NvmeNamespace, and implement the missing CNS
commands.

The added functionality will also simplify the implementation of namespace
management in the future, since namespace management can also attach and
detach namespaces.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme-ns.h   |  1 +
 hw/block/nvme.c      | 60 ++++++++++++++++++++++++++++++++++++++------
 include/block/nvme.h | 20 +++++++++------
 3 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index cca23bc0b3..acdb76f058 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -22,6 +22,7 @@
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
     uint8_t  csi;
+    bool     attached;
     QemuUUID uuid;
 } NvmeNamespaceParams;
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4ec1ddc90a..63ad03d6d6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1523,7 +1523,8 @@ static uint16_t nvme_identify_ctrl_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req,
+                                 bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1540,11 +1541,16 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->params.attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     return nvme_dma(n, (uint8_t *)&ns->id_ns, sizeof(NvmeIdNs),
                     DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1561,6 +1567,10 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
         return nvme_rpt_empty_id_struct(n, req);
     }
 
+    if (only_active && !ns->params.attached) {
+        return nvme_rpt_empty_id_struct(n, req);
+    }
+
     if (c->csi == NVME_CSI_NVM) {
         return nvme_rpt_empty_id_struct(n, req);
     }
@@ -1568,7 +1578,8 @@ static uint16_t nvme_identify_ns_csi(NvmeCtrl *n, NvmeRequest *req)
     return NVME_INVALID_FIELD | NVME_DNR;
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req,
+                                     bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1598,6 +1609,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid < min_nsid) {
             continue;
         }
+        if (only_active && !ns->params.attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1607,7 +1621,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
     return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
+static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
+                                         bool only_active)
 {
     NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
@@ -1631,6 +1646,9 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req)
         if (ns->params.nsid < min_nsid) {
             continue;
         }
+        if (only_active && !ns->params.attached) {
+            continue;
+        }
         list_ptr[j++] = cpu_to_le32(ns->params.nsid);
         if (j == data_len / sizeof(uint32_t)) {
             break;
@@ -1700,17 +1718,25 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, req);
+        return nvme_identify_ns(n, req, true);
     case NVME_ID_CNS_CS_NS:
-        return nvme_identify_ns_csi(n, req);
+        return nvme_identify_ns_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT:
+        return nvme_identify_ns(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT:
+        return nvme_identify_ns_csi(n, req, false);
     case NVME_ID_CNS_CTRL:
         return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_CS_CTRL:
         return nvme_identify_ctrl_csi(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, req);
+        return nvme_identify_nslist(n, req, true);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist_csi(n, req);
+        return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_NS_PRESENT_LIST:
+        return nvme_identify_nslist(n, req, false);
+    case NVME_ID_CNS_CS_NS_PRESENT_LIST:
+        return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
         return nvme_identify_ns_descr_list(n, req);
     case NVME_ID_CNS_IO_COMMAND_SET:
@@ -2188,8 +2214,10 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
 
 static int nvme_start_ctrl(NvmeCtrl *n)
 {
+    NvmeNamespace *ns;
     uint32_t page_bits = NVME_CC_MPS(n->bar.cc) + 12;
     uint32_t page_size = 1 << page_bits;
+    int i;
 
     if (unlikely(n->cq[0])) {
         trace_pci_nvme_err_startfail_cq();
@@ -2276,6 +2304,22 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     nvme_init_sq(&n->admin_sq, n, n->bar.asq, 0, 0,
                  NVME_AQA_ASQS(n->bar.aqa) + 1);
 
+    for (i = 1; i <= n->num_namespaces; i++) {
+        ns = nvme_ns(n, i);
+        if (!ns) {
+            continue;
+        }
+        ns->params.attached = false;
+        switch (ns->params.csi) {
+        case NVME_CSI_NVM:
+            if (NVME_CC_CSS(n->bar.cc) == CSS_NVM_ONLY ||
+                NVME_CC_CSS(n->bar.cc) == CSS_CSI) {
+                ns->params.attached = true;
+            }
+            break;
+        }
+    }
+
     nvme_set_timestamp(n, 0ULL);
 
     QTAILQ_INIT(&n->aer_queue);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 4587311783..b182fe40b2 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -804,14 +804,18 @@ typedef struct QEMU_PACKED NvmePSD {
 #define NVME_IDENTIFY_DATA_SIZE 4096
 
 enum NvmeIdCns {
-    NVME_ID_CNS_NS                = 0x00,
-    NVME_ID_CNS_CTRL              = 0x01,
-    NVME_ID_CNS_NS_ACTIVE_LIST    = 0x02,
-    NVME_ID_CNS_NS_DESCR_LIST     = 0x03,
-    NVME_ID_CNS_CS_NS             = 0x05,
-    NVME_ID_CNS_CS_CTRL           = 0x06,
-    NVME_ID_CNS_CS_NS_ACTIVE_LIST = 0x07,
-    NVME_ID_CNS_IO_COMMAND_SET    = 0x1c,
+    NVME_ID_CNS_NS                    = 0x00,
+    NVME_ID_CNS_CTRL                  = 0x01,
+    NVME_ID_CNS_NS_ACTIVE_LIST        = 0x02,
+    NVME_ID_CNS_NS_DESCR_LIST         = 0x03,
+    NVME_ID_CNS_CS_NS                 = 0x05,
+    NVME_ID_CNS_CS_CTRL               = 0x06,
+    NVME_ID_CNS_CS_NS_ACTIVE_LIST     = 0x07,
+    NVME_ID_CNS_NS_PRESENT_LIST       = 0x10,
+    NVME_ID_CNS_NS_PRESENT            = 0x11,
+    NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
+    NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
+    NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
 };
 
 typedef struct QEMU_PACKED NvmeIdCtrl {
-- 
2.21.0


