Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588F2C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A574B22262
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 02:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YPGGX+Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A574B22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMj8l-0007M1-Cy
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 22:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj10-0006Vu-Gh; Sun, 27 Sep 2020 22:35:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5334b480d=dmitry.fomichev@wdc.com>)
 id 1kMj0y-0003Li-Lh; Sun, 27 Sep 2020 22:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601260544; x=1632796544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5V4B9jY8gojQYVX7Dhb77g+hxKORtiI2eNVWciSPRBI=;
 b=YPGGX+EmY3tQgI7gAdruzZmnH4PPEINPNm/ykYlDUON4ZUOWHgrJRJYf
 XJIoHU+8+di6wedXUR9w8SD2xTGmk/sNeWlXrbQULFFqiC5skgFdo9zEH
 o3wRsplvsc0IIIlTBpdqlnnFxI2RW+VMl3k8s2OxgR7RMuE4T1oJPaU5A
 iQbI8v9iCauf8s9O7xf1DXM6RczodX5/5yNBXV5RATr17JJlYyxlVJzCa
 diEvLsVAevuuybOXVbR3sAJveRa2nuco/atoiFXmPxKBjQ6xyTw6XYyOq
 JlJ1nR4ShhSG1dw8g/Hx03tFeDu9OmYORKMNypVXqerkMyqS8piHBuNRQ Q==;
IronPort-SDR: mRjRIqj5l+iXDGKKSJ2koRnMypOPfUY3cjdgoDmndabgJ4QLhTTDZqn4PKZcbi2nU4gdORjDx8
 NIpGpi1RY5EBppEpeMQ9XHelNZ9ag3Mqd+15GOrAeMiUhVQVuLMvJCP0SgEdV22tq6z4hIJ/I1
 KniIzrYleIntLKAlW3IytSYlpasozUkrqDDxy5Tj6yog+uxtrKCf1ONsPvrK45iEZGNAN6TTCk
 f56HII0B1HNj9LN95TmcPKmW4m8guOb4eUp7LE3ZgwQHMl0a362pOneGMpEvtNa9rlFv/pmlv9
 rTA=
X-IronPort-AV: E=Sophos;i="5.77,312,1596470400"; d="scan'208";a="258125234"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 10:35:43 +0800
IronPort-SDR: ToH3UbitqD50S8zEoZxt7DREzsE+azPHcsfd9l4dCjZT4ZignN+xbAppMQtBp6m28l5neR1EkG
 pV+Y4bjRE+mg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 19:22:39 -0700
IronPort-SDR: iYoxKqfW/L9SXmjdSvgSDfy7iiWKDLvxCYbrYGw78I5eR0reF2eKuuVco6SkpstL/7MjT/aqka
 gyVPF6HWlaHw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2020 19:35:41 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v5 04/14] hw/block/nvme: Define trace events related to NS
 Types
Date: Mon, 28 Sep 2020 11:35:18 +0900
Message-Id: <20200928023528.15260-5-dmitry.fomichev@wdc.com>
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

A few trace events are defined that are relevant to implementing
Namespace Types (NVMe TP 4056).

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/trace-events | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/block/trace-events b/hw/block/trace-events
index 2929a8df11..b93429b04c 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -49,8 +49,12 @@ pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
+pci_nvme_identify_ctrl_csi(uint8_t csi) "identify controller, csi=0x%"PRIx8""
 pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_ns_csi(uint32_t ns, uint8_t csi) "nsid=%"PRIu32", csi=0x%"PRIx8""
 pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_nslist_csi(uint16_t ns, uint8_t csi) "nsid=%"PRIu16", csi=0x%"PRIx8""
+pci_nvme_identify_cmd_set(void) "identify i/o command set"
 pci_nvme_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
 pci_nvme_getfeat(uint16_t cid, uint8_t fid, uint8_t sel, uint32_t cdw11) "cid %"PRIu16" fid 0x%"PRIx8" sel 0x%"PRIx8" cdw11 0x%"PRIx32""
@@ -87,6 +91,8 @@ pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
+pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
+pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -106,6 +112,9 @@ pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
+pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
+pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
@@ -161,6 +170,7 @@ pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for
 pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.21.0


