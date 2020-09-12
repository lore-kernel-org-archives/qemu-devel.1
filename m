Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E5AC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B250F20770
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rm8kh8e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B250F20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEXr-00036i-Tm
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEPz-0003vq-Ti; Sat, 12 Sep 2020 18:54:51 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=517336518=dmitry.fomichev@wdc.com>)
 id 1kHEPx-0005R7-Pe; Sat, 12 Sep 2020 18:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599951289; x=1631487289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zxe81MuX4urUutIHEtJFE6J8nCgNhHUrmEj1y7p0mBw=;
 b=Rm8kh8e0OLV0mWx6lzhlB7NDHgq1SEdT1DONXzqXJcRaPD1pFkUAR24F
 r9DvIcNvyq3P3K0l5VYwItjHRs3lGlmVp06th18zJQNus4Dx3++egU5Vy
 E7jan7HhCByU3UV4biDV9UFMTcyi+bBOew1EjeyFZddUhKhBsSYUsZ4ie
 lE5kqkvRG2qgZcF8OeSX954eTtkaP+gDUlwGRwBm9ukJGIQ4I+sBAU1lo
 7Ip6cCiEbaRMkx8kFS80NHRm8Qc4ecgWShrpysZIRBBepENHyic+6LFvt
 X0mzfy9DAL8ZP35GJYw5f3NCQ6X/61BizIA/wDCgtxw/HaRfrW77cWTCd g==;
IronPort-SDR: Omeotocw6yOjQheq3wNJnm8eW+PBrBrdDW57eJqQzuOxlULmrofN2yoGo9j7LjjXxcBQedqlZG
 ixdUPtavgxvWuKbmzL2tnSgdxSh/uH04/tE7Q43YMsWi+C9I/sdQWj3VWbRbjQB9VW4gpc0tci
 QENTm1A54pCUjFRFjbBF4dfhposku7pfUsm8CN4uomadCEV7QHsdIm0Cjnog+7bM8ImH0Ol6B+
 3DiTzlizQ8L4iAuou7gIMK2fsyjXBaQ4q2o9EsthLUC8yw3Vyxhbi5dZXVjnvcBSGWC3KqW1d3
 FrY=
X-IronPort-AV: E=Sophos;i="5.76,420,1592841600"; d="scan'208";a="256834844"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2020 06:54:48 +0800
IronPort-SDR: fvEiqaCauq2J8sp7Bt4pqv7GzrJB5dWnH4hiaX4m+wKKYFd58d4wL/RaxGc/2QfgVRarEoB5l2
 hfCvWJO+/Hig==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2020 15:41:08 -0700
IronPort-SDR: SV0QDCDHVHLv04t4jcrRsErooydDBp2z/OQC5iGkgo7QaM0u8iYckrFJqXHv8IsqcNA8ImNWQZ
 dQLtCtwgTfAw==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Sep 2020 15:54:47 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 05/15] hw/block/nvme: Define trace events related to NS
 Types
Date: Sun, 13 Sep 2020 07:54:20 +0900
Message-Id: <20200912225430.1772-6-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
References: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=517336518=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 18:54:38
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
index 79c9da652d..2414dcbc79 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -46,8 +46,12 @@ pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size,
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
@@ -84,6 +88,8 @@ pci_nvme_mmio_stopped(void) "cleared controller enable bit"
 pci_nvme_mmio_shutdown_set(void) "shutdown bit set"
 pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 pci_nvme_cmd_supp_and_effects_log_read(void) "commands supported and effects log read"
+pci_nvme_css_nvm_cset_selected_by_host(uint32_t cc) "NVM command set selected by host, bar.cc=0x%"PRIx32""
+pci_nvme_css_all_csets_sel_by_host(uint32_t cc) "all supported command sets selected by host, bar.cc=0x%"PRIx32""
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
@@ -97,6 +103,9 @@ pci_nvme_err_invalid_opc(uint8_t opc) "invalid opcode 0x%"PRIx8""
 pci_nvme_err_invalid_admin_opc(uint8_t opc) "invalid admin opcode 0x%"PRIx8""
 pci_nvme_err_invalid_lba_range(uint64_t start, uint64_t len, uint64_t limit) "Invalid LBA start=%"PRIu64" len=%"PRIu64" limit=%"PRIu64""
 pci_nvme_err_invalid_effects_log_offset(uint64_t ofs) "commands supported and effects log offset must be 0, got %"PRIu64""
+pci_nvme_err_change_css_when_enabled(void) "changing CC.CSS while controller is enabled"
+pci_nvme_err_only_nvm_cmd_set_avail(void) "setting 110b CC.CSS, but only NVM command set is enabled"
+pci_nvme_err_invalid_iocsci(uint32_t idx) "unsupported command set combination index %"PRIu32""
 pci_nvme_err_invalid_del_sq(uint16_t qid) "invalid submission queue deletion, sid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_cqid(uint16_t cqid) "failed creating submission queue, invalid cqid=%"PRIu16""
 pci_nvme_err_invalid_create_sq_sqid(uint16_t sqid) "failed creating submission queue, invalid sqid=%"PRIu16""
@@ -152,6 +161,7 @@ pci_nvme_ub_db_wr_invalid_cq(uint32_t qid) "completion queue doorbell write for
 pci_nvme_ub_db_wr_invalid_cqhead(uint32_t qid, uint16_t new_head) "completion queue doorbell write value beyond queue size, cqid=%"PRIu32", new_head=%"PRIu16", ignoring"
 pci_nvme_ub_db_wr_invalid_sq(uint32_t qid) "submission queue doorbell write for nonexistent queue, sqid=%"PRIu32", ignoring"
 pci_nvme_ub_db_wr_invalid_sqtail(uint32_t qid, uint16_t new_tail) "submission queue doorbell write value beyond queue size, sqid=%"PRIu32", new_head=%"PRIu16", ignoring"
+pci_nvme_ub_unknown_css_value(void) "unknown value in cc.css field"
 
 # xen-block.c
 xen_block_realize(const char *type, uint32_t disk, uint32_t partition) "%s d%up%u"
-- 
2.21.0


