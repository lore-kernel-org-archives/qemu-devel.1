Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C53C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A468F20739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 06:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A468F20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsKUE-0004jB-UB
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 02:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNv-0001mC-Cx; Mon, 06 Jul 2020 02:13:47 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jsKNt-0000x3-DY; Mon, 06 Jul 2020 02:13:47 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 31A72BF867;
 Mon,  6 Jul 2020 06:13:18 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v3 14/18] hw/block/nvme: support identify namespace descriptor
 list
Date: Mon,  6 Jul 2020 08:12:59 +0200
Message-Id: <20200706061303.246057-15-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706061303.246057-1-its@irrelevant.dk>
References: <20200706061303.246057-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 02:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Since we are not providing the NGUID or EUI64 fields, we must support
the Namespace UUID. We do not have any way of storing a persistent
unique identifier, so conjure up a UUID that is just the namespace id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 37e4fd8dfce1..fc58f3d76530 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1007,6 +1007,45 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
     return ret;
 }
 
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
+{
+    uint32_t nsid = le32_to_cpu(c->nsid);
+    uint64_t prp1 = le64_to_cpu(c->prp1);
+    uint64_t prp2 = le64_to_cpu(c->prp2);
+
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
+
+    struct data {
+        struct {
+            NvmeIdNsDescr hdr;
+            uint8_t v[16];
+        } uuid;
+    };
+
+    struct data *ns_descrs = (struct data *)list;
+
+    trace_pci_nvme_identify_ns_descr_list(nsid);
+
+    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
+        trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    memset(list, 0x0, sizeof(list));
+
+    /*
+     * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
+     * structure, a Namespace UUID (nidt = 0x3) must be reported in the
+     * Namespace Identification Descriptor. Add a very basic Namespace UUID
+     * here.
+     */
+    ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
+    ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
+    stl_be_p(&ns_descrs->uuid.v, nsid);
+
+    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2);
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c = (NvmeIdentify *)cmd;
@@ -1018,6 +1057,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
         return nvme_identify_ctrl(n, c);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
         return nvme_identify_nslist(n, c);
+    case NVME_ID_CNS_NS_DESCR_LIST:
+        return nvme_identify_ns_descr_list(n, c);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 4a4ef34071df..7b7303cab1dd 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -45,6 +45,7 @@ pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
 pci_nvme_setfeat(uint16_t cid, uint8_t fid, uint8_t save, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" save 0x%"PRIx8" cdw11 0x%"PRIx32""
-- 
2.27.0


