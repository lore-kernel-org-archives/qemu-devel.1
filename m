Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A07C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC3F20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 02:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rcaC8qU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC3F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYKGa-0000l6-87
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 22:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDo-0005dv-N1; Thu, 29 Oct 2020 22:32:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56530b5a8=dmitry.fomichev@wdc.com>)
 id 1kYKDm-0006dF-M3; Thu, 29 Oct 2020 22:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604025174; x=1635561174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vaHsQrbzTnR4ns1fW2MjJ4Z6RM4+LbcIywqdOEdAqqg=;
 b=rcaC8qU5rgQoKc8QQjlEbljarTtcDTrji/LRiz5ZUdbFXDN7MjrvtwU9
 zdrQ1/b5unUzbPPN4SryKpXERRi8YZ3VWBymRTDNjK7FyOPQSFmhZxuFh
 dzkakkJZVzfhJmLAu+9vAA4KycX63g4cKsIjb57plB2ASAXVyWUYtKnK5
 Ro/xqnSX2JMopHajAXJW2FroFPOW6CSWw8Lth00+6rPXvatK2erclLZqi
 uhvmI+Ds7iEclOF+r5Ib+q+DD0mlsQZidfUKPvXPxWP/O99nf12Zu+v+d
 IeyHoWNbMQuGxxcPGDjTgOQpvd9w2HFCi8Cvk2Ndv1ks9eVU3GE1xVjBN A==;
IronPort-SDR: yPX86ATQes2vRuBX6W884rG5r64OJB03Q4gcx0HlyzMYa5u9dSJHoGhoHIZBI+H34W2vdB2Evj
 kmWNwnWvWh3Tor2sDR16aSpdhbgpTu49LG1I4BddSjdLNMQFL/90gy5tmbZ5bpeW8yD6NNX07z
 /RyxbPgzkA/KeyxDqxtg4cF/ahcJIO3PcGe3KRPju8T1TzWne8TIoGv/skahJI9rVXnGX/Tczw
 IEEW509z2mFqKaxoJSpFxGTpXN1XntgfO8pMfD8k2I8qMZX3p4/giCZCnoIOyB5/TNzPFO923S
 lrA=
X-IronPort-AV: E=Sophos;i="5.77,431,1596470400"; d="scan'208";a="155748054"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 10:32:52 +0800
IronPort-SDR: IBRKlva+jUYvwyLJplQp6CwAPBjSIVm0cARVmrAFw9Ku9ffcOgGc5TDFeHkmRGriIWv6kN9bT5
 N4qW8N0ufyjkoUJoDNomxx2iEQGq1RTTU7NPplwO2RDEnXvFu2hj2eUtRs+2e04fLSUPFTWUoq
 7IhibtVM6dcsiH0f0rAihBmS+i9o/DM/e0VijBTL2KzqjnXv3PQ5zXET3wfjEqxfuoMHXq8uDP
 TCXcm2yHrDOApFqEmWds76DMKkXYSTLeAeQVjAsGBxbQLGwoGgAAuyoizacx4LSScCBoJa2zGv
 4AsFRMQlTThcd7wfuYwVLkJn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:17:57 -0700
IronPort-SDR: Y8dCoky6bjV++GDOR8wphz+MIGlJmNVp3In5uMbrrNnJkxWJVss9wy7uWjwyY+LCu6C/lsWEKn
 X59fK9Z9z8oPZIjr7hl4+bBASPLCsOIsjOXlIB/FpHnQsdiVLJhv4U0hstK8s3bPXMy8rIRFZL
 5H5PR+7iLoYcC4xn4NEQssj3g5f6VMG90yPZXqW1+XnJUU4sC81Q4SszJZIg6jLHF3SBUn1Yqz
 TBIfgic5irOtXSwp2oHKrqPvAj0gzXkkP0vSKsoOrbFvZB1cukMr9sFJlm92z0luWT64613V1y
 WWE=
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 19:32:52 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v8 02/11] hw/block/nvme: Generate namespace UUIDs
Date: Fri, 30 Oct 2020 11:32:33 +0900
Message-Id: <20201030023242.5204-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
References: <20201030023242.5204-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=56530b5a8=dmitry.fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 22:32:49
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

In NVMe 1.4, a namespace must report an ID descriptor of UUID type
if it doesn't support EUI64 or NGUID. Add a new namespace property,
"uuid", that provides the user the option to either specify the UUID
explicitly or have a UUID generated automatically every time a
namespace is initialized.

Suggested-by: Klaus Jensen <its@irrelevant.dk>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <its@irrelevant.dk>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
---
 hw/block/nvme-ns.c | 1 +
 hw/block/nvme-ns.h | 1 +
 hw/block/nvme.c    | 9 +++++----
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
index b69cdaf27e..de735eb9f3 100644
--- a/hw/block/nvme-ns.c
+++ b/hw/block/nvme-ns.c
@@ -129,6 +129,7 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 static Property nvme_ns_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeNamespace, blkconf),
     DEFINE_PROP_UINT32("nsid", NvmeNamespace, params.nsid, 0),
+    DEFINE_PROP_UUID("uuid", NvmeNamespace, params.uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
index ea8c2f785d..a38071884a 100644
--- a/hw/block/nvme-ns.h
+++ b/hw/block/nvme-ns.h
@@ -21,6 +21,7 @@
 
 typedef struct NvmeNamespaceParams {
     uint32_t nsid;
+    QemuUUID uuid;
 } NvmeNamespaceParams;
 
 typedef struct NvmeNamespace {
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9fed061a9d..1ec8ccb3e6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1572,6 +1572,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeNamespace *ns;
     NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint8_t list[NVME_IDENTIFY_DATA_SIZE];
@@ -1591,7 +1592,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    if (unlikely(!nvme_ns(n, nsid))) {
+    ns = nvme_ns(n, nsid);
+    if (unlikely(!ns)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
@@ -1600,12 +1602,11 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     /*
      * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
      * structure, a Namespace UUID (nidt = 0x3) must be reported in the
-     * Namespace Identification Descriptor. Add a very basic Namespace UUID
-     * here.
+     * Namespace Identification Descriptor. Add the namespace UUID here.
      */
     ns_descrs->uuid.hdr.nidt = NVME_NIDT_UUID;
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
-    stl_be_p(&ns_descrs->uuid.v, nsid);
+    memcpy(&ns_descrs->uuid.v, ns->params.uuid.data, NVME_NIDT_UUID_LEN);
 
     return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
                     DMA_DIRECTION_FROM_DEVICE, req);
-- 
2.21.0


