Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EECC2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lKd4Mzcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EECC2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYMT-0007Sp-83
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKQ-0004b5-M8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKO-0004yG-T9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:42 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:34347 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKN-0004rk-Qt; Thu, 24 Oct 2019 04:18:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrX3hSFz9sQr; Thu, 24 Oct 2019 19:18:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905116;
 bh=ocrX3ncUYBFcZTW4CQsb4v8fYUjtodAeqwtBgAzm4yU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lKd4MzcnENckXJd3esl6QCug9Zc2gwb5zxoRqhg5YwZJevt14eFhqvPLDpp2IPYrw
 pNgpc4lHiBgN3YySoNlW+a7CTQX9CIqUNuIjWuhSKRgYMixh0rRAw+Yr5Y4EpFZbK9
 1Ywaf+B6LjM7E1sEYCmDHPmDhexsE1mi+8fuVxqg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/28] xics: Make some device types not user creatable
Date: Thu, 24 Oct 2019 19:17:47 +1100
Message-Id: <20191024081813.2115-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Some device types of the XICS model are exposed to the QEMU command
line:

$ ppc64-softmmu/qemu-system-ppc64 -device help | grep ic[sp]
name "icp"
name "ics"
name "ics-spapr"
name "pnv-icp", desc "PowerNV ICP"

These are internal devices that shouldn't be instantiable by the
user. By the way, they can't be because their respective realize
functions expect link properties that can't be set from the command
line:

qemu-system-ppc64: -device icp: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device ics: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device ics-spapr: required link 'xics' not found:
 Property '.xics' not found
qemu-system-ppc64: -device pnv-icp: required link 'xics' not found:
 Property '.xics' not found

Hide them by setting dc->user_creatable to false in the base class
"icp" and "ics" init functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157017826724.337875.14822177178282524024.stgit@bahia.lan>
Message-Id: <157045578962.865784.8551555523533955113.stgit@bahia.lan>
[dwg: Folded reason comment into base patch]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index dfe7dbd254..b5ac408f7b 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -369,6 +369,11 @@ static void icp_class_init(ObjectClass *klass, void =
*data)
=20
     dc->realize =3D icp_realize;
     dc->unrealize =3D icp_unrealize;
+    /*
+     * Reason: part of XICS interrupt controller, needs to be wired up
+     * by icp_create().
+     */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo icp_info =3D {
@@ -689,6 +694,11 @@ static void ics_class_init(ObjectClass *klass, void =
*data)
     dc->props =3D ics_properties;
     dc->reset =3D ics_reset;
     dc->vmsd =3D &vmstate_ics;
+    /*
+     * Reason: part of XICS interrupt controller, needs to be wired up,
+     * e.g. by spapr_irq_init().
+     */
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo ics_info =3D {
--=20
2.21.0


