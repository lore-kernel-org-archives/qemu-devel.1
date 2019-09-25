Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8089C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3932217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 06:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OmTOq1hG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3932217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD188-0002Fh-2c
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 02:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13g-0008H0-PH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13f-0003Rg-El
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:45:52 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13e-0003Ox-W0; Wed, 25 Sep 2019 02:45:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8m58Lsz9sPc; Wed, 25 Sep 2019 16:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393944;
 bh=YoZ6nDBhhOntdGlFmN4sT1V55L3hT1F130IYLZSQyK8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OmTOq1hGfCdnWA/LtKZHz9ejWuZ5UxQQRETwGrOHEdS7RHmc53aA4dGNEPTD9bUsC
 Me0ErMku2l/SOrBwdXpXjCizhWphn8w/envuDL81ANGnyyRYGMm86jhvcwGuobifO6
 VKlzdnar4qi7LVJzRJLy8M7FunLzVRG7E/KMuS3o=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/20] xics: Use incomplete type for XICSFabric
Date: Wed, 25 Sep 2019 16:45:15 +1000
Message-Id: <20190925064534.19155-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Interface instances should never be directly dereferenced.  So, the commo=
n
practice is to make them incomplete types to make sure no-one does that.
XICSFrabric, however, had a dummy type which is less safe.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/xics.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 64a2c8862a..1ae34ce9cd 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -147,9 +147,7 @@ struct ICSIRQState {
     uint8_t flags;
 };
=20
-struct XICSFabric {
-    Object parent;
-};
+typedef struct XICSFabric XICSFabric;
=20
 #define TYPE_XICS_FABRIC "xics-fabric"
 #define XICS_FABRIC(obj)                                     \
--=20
2.21.0


