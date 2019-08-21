Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22683C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE6022D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="P1MhiYgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE6022D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LWk-0002nA-M1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1D-0005aY-5H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1B-0000GD-Tk
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:55 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:54227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1B-0008SO-6e; Wed, 21 Aug 2019 03:26:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG4F0wz9sQt; Wed, 21 Aug 2019 17:25:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=wU5H61CwJkmgDFkNVITD7MVdyA45DnpLl8N5eMfxsL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P1MhiYgzTY68Yc0YWoCozd/KAgNwuf/8Fx4YjP7JR0shhFZ6QoEUhaCsWenpUwc/j
 R8hMx6524AkcVZtP+Uztg6W9jFm0HcEBVE1nD+yMWO7aiSbTzKzT0ykwWHa5gK20kj
 74/4OUEjgug0EysJQ/BlTCjEzHx6fvwXTimRbzgQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:24 +1000
Message-Id: <20190821072542.23090-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 24/42] ppc/xive: Provide backlog support
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
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

If backlog is activated ('b' bit) on the END, the pending priority of
a missed event is recorded in the IPB field of the NVT for a later
resend.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190718115420.19919-5-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 77 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 29 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ab7ce64a83..f27b4e3328 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1411,46 +1411,22 @@ static bool xive_presenter_match(XiveRouter *xrtr=
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
@@ -1464,6 +1440,10 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
@@ -1522,14 +1502,53 @@ static void xive_router_end_notify(XiveRouter *xr=
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


