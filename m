Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B233CC41514
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5A0233FC
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Rtxyf0s/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A0233FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LUe-00008U-GB
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1C-0005a3-RG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1B-0000Fz-O2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:54 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1B-0008SS-6Q; Wed, 21 Aug 2019 03:26:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG4wxZz9sQx; Wed, 21 Aug 2019 17:25:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=w8jJ4HioXwrN0ISowEXNExCB5N6zlcEr6dihcQPI6D0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rtxyf0s/tsHX4/mTTvBBggoE/aBraVGmqVs81Wl/AMAXuOxrH0zBpbLuM1RA79XuW
 Em/SomeCtHyFwgPbn/5VJzZhTpjacz+/9dBwyscafe3EGx1AFuosmetbUaG/sFc2jc
 6KKE9MS5cv1gq5z5CRVvr4m1wE5ORIbQxNY8TWQ8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:27 +1000
Message-Id: <20190821072542.23090-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 27/42] ppc/xive: Provide silent escalation
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

When the 's' bit is set the escalation is said to be 'silent' or
'silent/gather'. In such configuration, the notification sequence is
skipped and only the escalation sequence is performed. This is used to
configure all the EQs of a vCPU to escalate on a single EQ which will
then target the hypervisor.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190718115420.19919-8-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c             | 8 ++++++++
 include/hw/ppc/xive_regs.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3fe84f3e76..dd7d02dfdf 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1485,6 +1485,13 @@ static void xive_router_end_notify(XiveRouter *xrt=
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
@@ -1564,6 +1571,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
          */
     }
=20
+do_escalation:
     /*
      * If activated, escalate notification using the ESe PQ bits and
      * the EAS in w4-5
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 4378d7259c..fed019516f 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -212,6 +212,8 @@ typedef struct XiveEND {
 #define xive_end_is_escalate(end) (be32_to_cpu((end)->w0) & END_W0_ESCAL=
ATE_CTL)
 #define xive_end_is_uncond_escalation(end)              \
     (be32_to_cpu((end)->w0) & END_W0_UNCOND_ESCALATE)
+#define xive_end_is_silent_escalation(end)              \
+    (be32_to_cpu((end)->w0) & END_W0_SILENT_ESCALATE)
=20
 static inline uint64_t xive_end_qaddr(XiveEND *end)
 {
--=20
2.21.0


