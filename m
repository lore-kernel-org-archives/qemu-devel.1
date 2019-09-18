Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334E8C4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1AD208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1AD208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdoA-0002TG-8j
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcV6-0004Sn-D5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcV5-0003WH-5Z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:16 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:47391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcV5-0003VM-0W
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:08:15 -0400
Received: from player799.ha.ovh.net (unknown [10.108.54.74])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id A442D793D6
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:08:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 1B65C9F0E7A3;
 Wed, 18 Sep 2019 16:08:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:34 +0200
Message-Id: <20190918160645.25126-15-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6227633862887771110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.53.132
Subject: [Qemu-devel] [PATCH v4 14/25] ppc/xive: Introduce helpers for the
 NVT id
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NVT space is 19 bits wide, giving a maximum of 512K per chip. When
dispatched on a HW thread, the NVT identifier of a vCPU is pushed/stored
in the CAM line (word2) of the thread interrupt context.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  5 -----
 include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a461753f5da5..794dfcaae0f8 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -469,11 +469,6 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monito=
r *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
=20
-static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
-{
-    return (nvt_blk << 19) | nvt_idx;
-}
-
 /*
  * KVM XIVE device helpers
  */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 08c8bf7172e2..3d7b6fd09664 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -251,4 +251,25 @@ typedef struct XiveNVT {
=20
 #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID=
)
=20
+/*
+ * The VP number space in a block is defined by the END_W6_NVT_INDEX
+ * field of the XIVE END
+ */
+#define XIVE_NVT_SHIFT                19
+
+static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
+}
+
+static inline uint32_t xive_nvt_idx(uint32_t cam_line)
+{
+    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
+}
+
+static inline uint32_t xive_nvt_blk(uint32_t cam_line)
+{
+    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
+}
+
 #endif /* PPC_XIVE_REGS_H */
--=20
2.21.0


