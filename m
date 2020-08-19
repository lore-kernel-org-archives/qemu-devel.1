Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC9FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E3A206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 13:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E3A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Nqu-0007EA-Ly
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 09:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npp-0004zW-Oo; Wed, 19 Aug 2020 09:08:57 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:42605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8Npm-0006MC-JD; Wed, 19 Aug 2020 09:08:57 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.52])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 1416658A0B90;
 Wed, 19 Aug 2020 15:08:53 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 15:08:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002bc53b74f-525f-4d1f-82f7-eb4efdbd18b4,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/8] spapr/xive: Enforce the load-after-store ordering
Date: Wed, 19 Aug 2020 15:08:40 +0200
Message-ID: <20200819130843.2230799-6-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819130843.2230799-1-clg@kaod.org>
References: <20200819130843.2230799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9a811dae-fe7a-4c1a-8e37-e9cbf6abbc66
X-Ovh-Tracer-Id: 2622220883518982950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 09:08:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XIVE_ESB_SET_PQ_10 load operation is used to disable temporarily
an interrupt source. If StoreEOI is active, a source could be left
enabled if the load and store operations come out of order.

QEMU makes use of this offset to quiesce the sources before a
migration. Enforce the load-after-store ordering always when doing so
without querying the characteristics of the sources on the host. The
performance penalty will be very small for QEMU.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h    |  8 ++++++++
 hw/intc/spapr_xive_kvm.c | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2c42ae92d287..c061230ea802 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -279,6 +279,14 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
 #define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
 #define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
 
+/*
+ * Load-after-store ordering
+ *
+ * Adding this offset to the load address will enforce
+ * load-after-store ordering. This is required to use with StoreEOI.
+ */
+#define XIVE_ESB_LD_ST_MO       0x40 /* Load-after-store ordering */
+
 uint8_t xive_source_esb_get(XiveSource *xsrc, uint32_t srcno);
 uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq);
 
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 90f4509e6959..3eea4cb1c49f 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -317,6 +317,18 @@ static uint64_t xive_esb_rw(XiveSource *xsrc, int srcno, uint32_t offset,
 
 static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offset)
 {
+    /*
+     * The XIVE_ESB_SET_PQ_10 load operation is used to disable
+     * temporarily an interrupt source. If StoreEOI is active, a
+     * source could be left enabled if the load and store operations
+     * come out of order.
+     *
+     * Enforce the load-after-store ordering always.
+     */
+    if (offset == XIVE_ESB_SET_PQ_10) {
+        offset |= XIVE_ESB_LD_ST_MO;
+    }
+
     return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
 }
 
-- 
2.25.4


