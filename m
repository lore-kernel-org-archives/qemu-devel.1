Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB19DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9330322D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dBNLcH2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9330322D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LTZ-0006uO-JG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 03:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1B-0005YD-Po
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i0L1A-0000FD-LW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:26:53 -0400
Received: from ozlabs.org ([203.11.71.1]:43093)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i0L1A-0008SK-AH; Wed, 21 Aug 2019 03:26:52 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46CzjG33Flz9sR8; Wed, 21 Aug 2019 17:25:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566372354;
 bh=7bWUvyvMwDHcXO2wfGBuWkd301O7ASe0z8ehsRSbHj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dBNLcH2SHDkqn2SNejGDkpomBX1R8x9a12OXRDyQmD6eFmcf62NCeM5wFDmgL6y6t
 iZ/pEc1WjZ+Um97RFm2MLwmiEVYOQkwh6fZSxHkRFQ9t7ToTNzCPbgrE0519fPrff7
 sA7qeRaF2W4XcYiFwLd9f3nNXte3ZQAT+Iev8O1I=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 21 Aug 2019 17:25:22 +1000
Message-Id: <20190821072542.23090-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 22/42] ppc/xive: use an abstract type for
 XiveNotifier
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190718115420.19919-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xive.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 9399c77d2d..ea6ae34375 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -148,13 +148,11 @@
  * XIVE Notifier (Interface between Source and Router)
  */
=20
-typedef struct XiveNotifier {
-    Object parent;
-} XiveNotifier;
+typedef struct XiveNotifier XiveNotifier;
=20
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
 #define XIVE_NOTIFIER(obj)                                     \
-    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
 #define XIVE_NOTIFIER_CLASS(klass)                                     \
     OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
 #define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
--=20
2.21.0


