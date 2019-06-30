Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE90C5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC889208E3
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC889208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgrk-0002D7-8E
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgj5-00006M-TY
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgj2-0002Mg-BN
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:06 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:60776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgix-0002GZ-6p
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:00 -0400
Received: from player157.ha.ovh.net (unknown [10.108.57.141])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id B8F2312CFF2
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:46:54 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id DA4067575AC1;
 Sun, 30 Jun 2019 20:46:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:57 +0200
Message-Id: <20190630204601.30574-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2287265664829524966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.146
Subject: [Qemu-devel] [PATCH 06/10] ppc/xive: Provide escalation support
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
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the XIVE presenter can not find the NVT dispatched on any of the HW
threads, it can not deliver the interrupt. XIVE offers a mechanism to
handle such scenarios and inform the hypervisor that an action should
be taken.

The first action is to keep track of the pending priority of the
missed event. It is recorded in the IPB field of the NVT for a later
resend if backlog is activated ('b' bit) on the END.

An END can also escalate if configured: 'e' bit and setting of the EAS
in word 4 & 5 to let the HW look for the escalation END on which to
trigger a new event. Escalation has its own options to program
different behaviors :

 - unconditional escalation ('u' bit) with which the ESe PQ bits are
   not used.
 - silent/gather escalation ('s' bit), the sequence skips the
   notification process and jumps directly to the escalation.

KVM uses a combination of these. The first level END is configured to
enqueue, unconditionally notify, backlog and escalate and points to an
escalation END which is configured to escalate silently.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h |   4 ++
 hw/intc/xive.c             | 130 +++++++++++++++++++++++++++++++------
 2 files changed, 115 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 1a8c5b5e64f0..69af326ebf2c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -207,6 +207,10 @@ typedef struct XiveEND {
 #define xive_end_is_notify(end)   (be32_to_cpu((end)->w0) & END_W0_UCOND=
_NOTIFY)
 #define xive_end_is_backlog(end)  (be32_to_cpu((end)->w0) & END_W0_BACKL=
OG)
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
+#define xive_end_is_uncond_escalation(end)              \
+    (be32_to_cpu((end)->w0) & END_W0_UNCOND_ESCALATE)
+#define xive_end_is_silent_escalation(end)              \
+    (be32_to_cpu((end)->w0) & END_W0_SILENT_ESCALATE)
=20
 static inline uint64_t xive_end_qaddr(XiveEND *end)
 {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 592c0b70f197..3970999f4837 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1389,7 +1389,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
  *
  * The parameters represent what is sent on the PowerBus
  */
-static void xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
                                   uint8_t nvt_blk, uint32_t nvt_idx,
                                   bool cam_ignore, uint8_t priority,
                                   uint32_t logic_serv)
@@ -1402,13 +1402,13 @@ static void xive_presenter_notify(XiveRouter *xrt=
r, uint8_t format,
     if (xive_router_get_nvt(xrtr, nvt_blk, nvt_idx, &nvt)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVT %x/%x\n",
                       nvt_blk, nvt_idx);
-        return;
+        return false;
     }
=20
     if (!xive_nvt_is_valid(&nvt)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is invalid\n",
                       nvt_blk, nvt_idx);
-        return;
+        return false;
     }
=20
     found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
@@ -1416,19 +1416,55 @@ static void xive_presenter_notify(XiveRouter *xrt=
r, uint8_t format,
     if (found) {
         ipb_update(&match.tctx->regs[match.ring], priority);
         xive_tctx_notify(match.tctx, match.ring);
+    }
+
+    return found;
+}
+
+static void xive_router_end_backlog(XiveRouter *xrtr,
+                                    uint8_t nvt_blk, uint32_t nvt_idx,
+                                    uint8_t priority)
+{
+    XiveNVT nvt;
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
         return;
     }
=20
     /* Record the IPB in the associated NVT structure */
     ipb_update((uint8_t *) &nvt.w4, priority);
     xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
+}
=20
-    /*
-     * If no matching NVT is dispatched on a HW thread :
-     * - update the NVT structure if backlog is activated
-     * - escalate (ESe PQ bits and EAS in w4-5) if escalation is
-     *   activated
-     */
+
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
 }
=20
 /*
@@ -1442,6 +1478,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
     XiveEND end;
     uint8_t priority;
     uint8_t format;
+    bool found;
=20
     /* END cache lookup */
     if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
@@ -1462,6 +1499,13 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
@@ -1483,16 +1527,9 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
@@ -1500,7 +1537,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
-    xive_presenter_notify(xrtr, format,
+    found =3D xive_presenter_notify(xrtr, format,
                           xive_get_field32(END_W6_NVT_BLOCK, end.w6),
                           xive_get_field32(END_W6_NVT_INDEX, end.w6),
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
@@ -1508,6 +1545,61 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
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
+        xive_router_end_backlog(xrtr,
+                                xive_get_field32(END_W6_NVT_BLOCK, end.w=
6),
+                                xive_get_field32(END_W6_NVT_INDEX, end.w=
6),
+                                priority);
+
+        /*
+         * On HW, follows a "Broadcast Backlog" to IVPEs
+         */
+    }
+
+do_escalation:
+    /*
+     * If activated, escalate notification using the ESe PQ bits and
+     * the EAS in w4-5
+     */
+    if (!xive_end_is_escalate(&end)) {
+        return;
+    }
+
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
+    /*
+     * The END trigger becomes an Escalation trigger
+     */
+    xive_router_end_notify(xrtr,
+                           xive_get_field32(END_W4_ESC_END_BLOCK, end.w4=
),
+                           xive_get_field32(END_W4_ESC_END_INDEX, end.w4=
),
+                           xive_get_field32(END_W5_ESC_END_DATA,  end.w5=
));
 }
=20
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
--=20
2.21.0


