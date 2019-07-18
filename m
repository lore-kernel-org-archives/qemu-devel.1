Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A902C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EB721019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho51v-00037X-A5
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho50G-0005oD-0P
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho50E-0001yy-Vi
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:15 -0400
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:59243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho50E-0001xd-QH
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:14 -0400
Received: from player778.ha.ovh.net (unknown [10.109.143.216])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 01B1A1D81DA
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 5ED45801F3B0;
 Thu, 18 Jul 2019 11:55:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:10 +0200
Message-Id: <20190718115420.19919-8-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6782421039645887462
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.139.208
Subject: [Qemu-devel] [PATCH v2 07/17] ppc/xive: Provide silent escalation
 support
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the 's' bit is set the escalation is said to be 'silent' or
'silent/gather'. In such configuration, the notification sequence is
skipped and only the escalation sequence is performed. This is used to
configure all the EQs of a vCPU to escalate on a single EQ which will
then target the hypervisor.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h | 2 ++
 hw/intc/xive.c             | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 5d02ccfeff16..69af326ebf2c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -209,6 +209,8 @@ typedef struct XiveEND {
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
 #define xive_end_is_uncond_escalation(end)              \
     (be32_to_cpu((end)->w0) & END_W0_UNCOND_ESCALATE)
+#define xive_end_is_silent_escalation(end)              \
+    (be32_to_cpu((end)->w0) & END_W0_SILENT_ESCALATE)
=20
 static inline uint64_t xive_end_qaddr(XiveEND *end)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c2e7e2d4c9a9..8ea97ac231a4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1463,6 +1463,13 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
         xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
     }
=20
+    /*
+     * When the END is silent, we skip the notification part.
+     */
+    if (xive_end_is_silent_escalation(&end)) {
+        goto do_escalation;
+    }
+
     /*
      * The W7 format depends on the F bit in W6. It defines the type
      * of the notification :
@@ -1542,6 +1549,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
          */
     }
=20
+do_escalation:
     /*
      * If activated, escalate notification using the ESe PQ bits and
      * the EAS in w4-5
--=20
2.21.0


