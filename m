Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C082C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13204206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zoFDSf2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13204206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkIb-0003hU-4r
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD5-0005Ol-7A; Wed, 30 Sep 2020 18:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD3-0007vT-3r; Wed, 30 Sep 2020 18:04:26 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0BACB20BED;
 Wed, 30 Sep 2020 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503463;
 bh=bAD+jfXU6J1t0RBHkb7mu5AtcCOwQGtCOjdgO5scJiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zoFDSf2/QzPlDaQqWjiJZeYZ9N9AKz+H0mrNFJoVnWaJ3VUsGNafyImMVlXKg7RUt
 4EYird2YhaHAvNJ9d1Tbk570HhQ5qOv7VI36h7Lz1Da970jCpVtmJzUYxTFVLc5+SN
 XTHkzYzWs3ts2N4/RZN5EUMWP41g2kInm9FTXlVw=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 3/9] hw/block/nvme: support per-namespace smart log
Date: Wed, 30 Sep 2020 15:04:08 -0700
Message-Id: <20200930220414.562527-4-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the user specify a specific namespace if they want to get access
stats for a specific namespace.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c      | 66 +++++++++++++++++++++++++++-----------------
 include/block/nvme.h |  1 +
 2 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8d2b5be567..41389b2b09 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1164,48 +1164,62 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+struct nvme_stats {
+    uint64_t units_read;
+    uint64_t units_written;
+    uint64_t read_commands;
+    uint64_t write_commands;
+};
+
+static void nvme_set_blk_stats(NvmeNamespace *ns, struct nvme_stats *stats)
+{
+    BlockAcctStats *s = blk_get_stats(ns->blkconf.blk);
+
+    stats->units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
+    stats->units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
+    stats->read_commands += s->nr_ops[BLOCK_ACCT_READ];
+    stats->write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
+}
+
 static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                 uint64_t off, NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(req->cmd.nsid);
-
+    struct nvme_stats stats = { 0 };
+    NvmeSmartLog smart = { 0 };
     uint32_t trans_len;
+    NvmeNamespace *ns;
     time_t current_ms;
-    uint64_t units_read = 0, units_written = 0;
-    uint64_t read_commands = 0, write_commands = 0;
-    NvmeSmartLog smart;
-
-    if (nsid && nsid != 0xffffffff) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
 
     if (off >= sizeof(smart)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    for (int i = 1; i <= n->num_namespaces; i++) {
-        NvmeNamespace *ns = nvme_ns(n, i);
-        if (!ns) {
-            continue;
-        }
-
-        BlockAcctStats *s = blk_get_stats(ns->blkconf.blk);
+    if (nsid != 0xffffffff) {
+        ns = nvme_ns(n, nsid);
+        if (!ns)
+            return NVME_INVALID_NSID | NVME_DNR;
+        nvme_set_blk_stats(ns, &stats);
+    } else {
+        int i;
 
-        units_read += s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
-        units_written += s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
-        read_commands += s->nr_ops[BLOCK_ACCT_READ];
-        write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
+        for (i = 1; i <= n->num_namespaces; i++) {
+            ns = nvme_ns(n, i);
+            if (!ns) {
+                continue;
+            }
+            nvme_set_blk_stats(ns, &stats);
+        }
     }
 
     trans_len = MIN(sizeof(smart) - off, buf_len);
 
-    memset(&smart, 0x0, sizeof(smart));
-
-    smart.data_units_read[0] = cpu_to_le64(DIV_ROUND_UP(units_read, 1000));
-    smart.data_units_written[0] = cpu_to_le64(DIV_ROUND_UP(units_written,
+    smart.data_units_read[0] = cpu_to_le64(DIV_ROUND_UP(stats.units_read,
+                                                        1000));
+    smart.data_units_written[0] = cpu_to_le64(DIV_ROUND_UP(stats.units_written,
                                                            1000));
-    smart.host_read_commands[0] = cpu_to_le64(read_commands);
-    smart.host_write_commands[0] = cpu_to_le64(write_commands);
+    smart.host_read_commands[0] = cpu_to_le64(stats.read_commands);
+    smart.host_write_commands[0] = cpu_to_le64(stats.write_commands);
 
     smart.temperature = cpu_to_le16(n->temperature);
 
@@ -2708,7 +2722,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->acl = 3;
     id->aerl = n->params.aerl;
     id->frmw = (NVME_NUM_FW_SLOTS << 1) | NVME_FRMW_SLOT1_RO;
-    id->lpa = NVME_LPA_EXTENDED;
+    id->lpa = NVME_LPA_NS_SMART | NVME_LPA_EXTENDED;
 
     /* recommended default value (~70 C) */
     id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 58647bcdad..868cf53f0b 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -849,6 +849,7 @@ enum NvmeIdCtrlFrmw {
 };
 
 enum NvmeIdCtrlLpa {
+    NVME_LPA_NS_SMART = 1 << 0,
     NVME_LPA_EXTENDED = 1 << 2,
 };
 
-- 
2.24.1


