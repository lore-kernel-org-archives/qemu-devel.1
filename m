Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB2C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E551E20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cM2m+FkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4wb-0003LU-Ko
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4i0-00088Z-FH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hz-0005QE-AD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:44 -0500
Received: from ozlabs.org ([203.11.71.1]:51113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4hy-0005Ij-Uw; Mon, 16 Dec 2019 23:43:43 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWQ1vdjz9sSf; Tue, 17 Dec 2019 15:43:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557810;
 bh=YLyu+TvN7QrUe5KSxjn+8t7hVOL9DOYECayzY0UoxQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cM2m+FkKSmhv6a6eeLH7PuMRwGE16qJRzFbL486Gr6EKFK/kSj73KfyHvBQJJoWmU
 9+PE7q7Fql3zqyGZO5VLtJCb91/R/8naMGS/I1D0AgMacD/NqQtWQ9tlPKlWXGTcK6
 ZiVjs80xns3Wnan2xL+lDbCglW8OHy2WbJ4aflEg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 18/88] ppc/xive: Introduce helpers for the NVT id
Date: Tue, 17 Dec 2019 15:42:12 +1100
Message-Id: <20191217044322.351838-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Each vCPU in the system is identified with an NVT identifier which is
pushed in the OS CAM line (QW1W2) of the HW thread interrupt context
register when the vCPU is dispatched on a HW thread. This identifier
is used by the presenter subengine to find a matching target to notify
of an event. It is also used to fetch the associate NVT structure
which may contain pending interrupts that need a resend.

Add a couple of helpers for the NVT ids. The NVT space is 19 bits
wide, giving a maximum of 512K per chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191115162436.30548-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xive.h      |  5 -----
 include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8fd439ec9b..fa7adf87fe 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -418,11 +418,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
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
index 530f232b04..1a5622f8de 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -272,4 +272,25 @@ typedef struct XiveNVT {
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
2.23.0


