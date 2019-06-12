Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146FEC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B6220874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oG3N/8tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B6220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hawEh-0003aL-4B
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 01:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8j-0004Ow-By
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1haw8i-000710-48
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:49:41 -0400
Received: from ozlabs.org ([203.11.71.1]:60519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1haw8g-0006ze-Rs; Wed, 12 Jun 2019 01:49:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45NwtQ41vPz9s6w; Wed, 12 Jun 2019 15:49:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560318574;
 bh=Ouz+QarirwIM17ifHbWbbOGb+G6yD8tl0/FYe436hdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oG3N/8tRf+GT5p3oBxK8qXkna7P0Z8TMCev1QFr5J1Tu+QrCenYPQT/OWMDpQ6bhx
 8f4XFNA/fsqEnP3vt0CSmtydbf7SRmjJ+KkHY95jLrCL4/u2Xt7yCgdFA8fkUk4UhF
 vDvKhLC4FV72D0r6T7O7VXMCtXfC0oIM6DQHpOXE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 12 Jun 2019 15:49:17 +1000
Message-Id: <20190612054929.21136-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 01/13] spapr_pci: Improve error message
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Every PHB must have a unique index. This is checked at realize but when
a duplicate index is detected, an error message mentioning BUIDs is
printed. This doesn't help much, especially since BUID is an internal
concept that is no longer exposed to the user.

Fix the message to mention the index property instead of BUID. As a bonus
print a list of indexes already in use.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155915010892.2061314.10485622810149098411.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 9cf2c41b8c..483639b107 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1677,7 +1677,14 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
     }
=20
     if (spapr_pci_find_phb(spapr, sphb->buid)) {
-        error_setg(errp, "PCI host bridges must have unique BUIDs");
+        SpaprPhbState *s;
+
+        error_setg(errp, "PCI host bridges must have unique indexes");
+        error_append_hint(errp, "The following indexes are already in us=
e:");
+        QLIST_FOREACH(s, &spapr->phbs, list) {
+            error_append_hint(errp, " %d", s->index);
+        }
+        error_append_hint(errp, "\nTry another value for the index prope=
rty\n");
         return;
     }
=20
--=20
2.21.0


