Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD570C76196
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833BD21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833BD21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho51h-0002FJ-Mj
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58923)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho50A-0005P9-IJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho509-0001tF-B6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:10 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:48415)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho509-0001pW-4G
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:09 -0400
Received: from player778.ha.ovh.net (unknown [10.109.160.230])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8BF73FC9F0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:07 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id E297F801F36C;
 Thu, 18 Jul 2019 11:55:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:09 +0200
Message-Id: <20190718115420.19919-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6781013666426162150
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.61.98
Subject: [Qemu-devel] [PATCH v2 06/17] ppc/xive: Provide unconditional
 escalation support
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

When the 'u' bit is set the escalation is said to be 'unconditional'
which means that the ESe PQ bits are not used. Introduce a
xive_router_end_es_notify() routine to share code with the ESn
notification.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |  2 ++
 hw/intc/xive.c             | 44 ++++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a8c5b5e64f0..5d02ccfeff16 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -207,6 +207,8 @@ typedef struct XiveEND {
 #define xive_end_is_notify(end)   (be32_to_cpu((end)->w0) & END_W0_UCOND=
_NOTIFY)
 #define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
+#define xive_end_is_uncond_escalation(end)              \
+    (be32_to_cpu((end)->w0) & END_W0_UNCOND_ESCALATE)
=20
 static inline uint64_t xive_end_qaddr(XiveEND *end)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 89a09dde060b..c2e7e2d4c9a9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1407,6 +1407,27 @@ static bool xive_presenter_notify(XiveRouter *xrtr=
, uint8_t format,
     return found;
 }
=20
+/*
+ * Notification using the END ESe/ESn bit (Event State Buffer for
+ * escalation and notification). Profide futher coalescing in the
+ * Router.
+ */
+static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
+                                      uint32_t end_idx, XiveEND *end,
+                                      uint32_t end_esmask)
+{
+    uint8_t pq =3D xive_get_field32(end_esmask, end->w1);
+    bool notify =3D xive_esb_trigger(&pq);
+
+    if (pq !=3D xive_get_field32(end_esmask, end->w1)) {
+        end->w1 =3D xive_set_field32(end_esmask, end->w1, pq);
+        xive_router_write_end(xrtr, end_blk, end_idx, end, 1);
+    }
+
+    /* ESe/n[Q]=3D1 : end of notification */
+    return notify;
+}
+
 /*
  * An END trigger can come from an event trigger (IPI or HW) or from
  * another chip. We don't model the PowerBus but the END trigger
@@ -1463,16 +1484,9 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
      * even futher coalescing in the Router
      */
     if (!xive_end_is_notify(&end)) {
-        uint8_t pq =3D xive_get_field32(END_W1_ESn, end.w1);
-        bool notify =3D xive_esb_trigger(&pq);
-
-        if (pq !=3D xive_get_field32(END_W1_ESn, end.w1)) {
-            end.w1 =3D xive_set_field32(END_W1_ESn, end.w1, pq);
-            xive_router_write_end(xrtr, end_blk, end_idx, &end, 1);
-        }
-
         /* ESn[Q]=3D1 : end of notification */
-        if (!notify) {
+        if (!xive_router_end_es_notify(xrtr, end_blk, end_idx,
+                                       &end, END_W1_ESn)) {
             return;
         }
     }
@@ -1536,6 +1550,18 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
         return;
     }
=20
+    /*
+     * Check the END ESe (Event State Buffer for escalation) for even
+     * futher coalescing in the Router
+     */
+    if (!xive_end_is_uncond_escalation(&end)) {
+        /* ESe[Q]=3D1 : end of notification */
+        if (!xive_router_end_es_notify(xrtr, end_blk, end_idx,
+                                       &end, END_W1_ESe)) {
+            return;
+        }
+    }
+
     /*
      * The END trigger becomes an Escalation trigger
      */
--=20
2.21.0


