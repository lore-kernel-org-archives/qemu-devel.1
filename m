Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E00C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB16820873
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB16820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho516-0000WC-7x
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho501-0004p7-Ii
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho500-0001j5-Ab
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:01 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:50118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho500-0001i0-4z
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:00 -0400
Received: from player778.ha.ovh.net (unknown [10.108.35.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id A664C183803
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:54:56 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id E27FB801F2EC;
 Thu, 18 Jul 2019 11:54:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:07 +0200
Message-Id: <20190718115420.19919-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6777917443433335782
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.110.239
Subject: [Qemu-devel] [PATCH v2 04/17] ppc/xive: Provide backlog support
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

If backlog is activated ('b' bit) on the END, the pending priority of
a missed event is recorded in the IPB field of the NVT for a later
resend.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 77 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 592c0b70f197..1ee5c1fe4534 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1389,46 +1389,22 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
  *
  * The parameters represent what is sent on the PowerBus
  */
-static void xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
                                   uint8_t nvt_blk, uint32_t nvt_idx,
                                   bool cam_ignore, uint8_t priority,
                                   uint32_t logic_serv)
 {
-    XiveNVT nvt;
     XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
     bool found;
=20
-    /* NVT cache lookup */
-    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
-                      nvt_blk, nvt_idx);
-        return;
-    }
-
-    if (!xive_nvt_is_valid(&nvt)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is invalid\n",
-                      nvt_blk, nvt_idx);
-        return;
-    }
-
     found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
                                  priority, logic_serv, &match);
     if (found) {
         ipb_update(&match.tctx->regs[match.ring], priority);
         xive_tctx_notify(match.tctx, match.ring);
-        return;
     }
=20
-    /* Record the IPB in the associated NVT structure */
-    ipb_update((uint8_t *) &nvt.w4, priority);
-    xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
-
-    /*
-     * If no matching NVT is dispatched on a HW thread :
-     * - update the NVT structure if backlog is activated
-     * - escalate (ESe PQ bits and EAS in w4-5) if escalation is
-     *   activated
-     */
+    return found;
 }
=20
 /*
@@ -1442,6 +1418,10 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
     XiveEND end;
     uint8_t priority;
     uint8_t format;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    XiveNVT nvt;
+    bool found;
=20
     /* END cache lookup */
     if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
@@ -1500,14 +1480,53 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
-    xive_presenter_notify(xrtr, format,
-                          xive_get_field32(END_W6_NVT_BLOCK, end.w6),
-                          xive_get_field32(END_W6_NVT_INDEX, end.w6),
+    nvt_blk =3D xive_get_field32(END_W6_NVT_BLOCK, end.w6);
+    nvt_idx =3D xive_get_field32(END_W6_NVT_INDEX, end.w6);
+
+    /* NVT cache lookup */
+    if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
+                      nvt_blk, nvt_idx);
+        return;
+    }
+
+    if (!xive_nvt_is_valid(&nvt)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is invalid\n",
+                      nvt_blk, nvt_idx);
+        return;
+    }
+
+    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
=20
     /* TODO: Auto EOI. */
+
+    if (found) {
+        return;
+    }
+
+    /*
+     * If no matching NVT is dispatched on a HW thread :
+     * - specific VP: update the NVT structure if backlog is activated
+     * - logical server : forward request to IVPE (not supported)
+     */
+    if (xive_end_is_backlog(&end)) {
+        if (format =3D=3D 1) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
+                          end_blk, end_idx);
+            return;
+        }
+        /* Record the IPB in the associated NVT structure */
+        ipb_update((uint8_t *) &nvt.w4, priority);
+        xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
+
+        /*
+         * On HW, follows a "Broadcast Backlog" to IVPEs
+         */
+    }
 }
=20
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
--=20
2.21.0


