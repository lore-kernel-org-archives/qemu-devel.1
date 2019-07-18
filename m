Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45914C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC9821019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC9821019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho51N-0000bw-QR
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho506-00059A-DX
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho504-0001lu-4e
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:06 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:33750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho503-0001kk-VV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:55:04 -0400
Received: from player778.ha.ovh.net (unknown [10.109.160.93])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E01391FE504
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:55:01 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 5E10F801F328;
 Thu, 18 Jul 2019 11:54:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:08 +0200
Message-Id: <20190718115420.19919-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6779324815084456934
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.54.143
Subject: [Qemu-devel] [PATCH v2 05/17] ppc/xive: Provide escalation support
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

If the XIVE presenter can not find the NVT dispatched on any of the HW
threads, it can not deliver the interrupt. XIVE offers an escalation
mechanism to handle such scenarios and inform the hypervisor that an
action should be taken.

Escalation is configured by setting the 'e' bit and the EAS in word 4
& 5 to let the HW look for the escalation END on which to trigger a
new event.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1ee5c1fe4534..89a09dde060b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1527,6 +1527,22 @@ static void xive_router_end_notify(XiveRouter *xrt=
r, uint8_t end_blk,
          * On HW, follows a "Broadcast Backlog" to IVPEs
          */
     }
+
+    /*
+     * If activated, escalate notification using the ESe PQ bits and
+     * the EAS in w4-5
+     */
+    if (!xive_end_is_escalate(&end)) {
+        return;
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


