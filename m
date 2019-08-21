Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE7BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6012332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ODHF3SkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6012332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0L7Y-0003MR-1O
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0V-0004h2-Gz
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L0T-000896-22
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:11 -0400
Received: from ozlabs.org ([203.11.71.1]:55445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L0S-00086W-CK; Wed, 21 Aug 2019 03:26:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjC6Wb4z9sQr; Wed, 21 Aug 2019 17:25:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372351;
 bh=nD2L+SiGYUChIjp0CrLusuaG7viZyrANK72wGdiR5tM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ODHF3SkAlwP8ouTlUkWwoGY0k6opY/REiHpmhLEfACYd8iXEN7I4OA1aFFZY6SyUk
 09OpoC5beumS3dR+W/Pf6lfzSMyUSG8xdgvqdkLaEg6gBQMBWELEJWs/OXX+2nSKut
 EqvwxdyppYXfarlOHB+XG6p9Qy3IGKSdfOYz/NvY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:26 +1000
Message-Id: <20190821072542.23090-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 26/42] ppc/xive: Provide unconditional
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the 'u' bit is set the escalation is said to be 'unconditional'
which means that the ESe PQ bits are not used. Introduce a
xive_router_end_es_notify() routine to share code with the ESn
notification.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190718115420.19919-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c             | 44 ++++++++++++++++++++++++++++++--------
 include/hw/ppc/xive_regs.h |  2 ++
 2 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 12f0d09df6..3fe84f3e76 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1429,6 +1429,27 @@ static bool xive_presenter_notify(XiveRouter *xrtr=
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
@@ -1485,16 +1506,9 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
@@ -1558,6 +1572,18 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b0c68ab5f7..4378d7259c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -210,6 +210,8 @@ typedef struct XiveEND {
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
--=20
2.21.0


