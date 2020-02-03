Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B95C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D72F120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="aTBOB54R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72F120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVGg-00061k-3i
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUyF-0003ud-Cc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUyE-0003tf-FV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:31 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:40175 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUyE-0003RP-58; Mon, 03 Feb 2020 01:12:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBt5yFkz9sT8; Mon,  3 Feb 2020 17:11:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710294;
 bh=GTRX/VXafls1IkkTyR5sNPeyfSuUBHNUp5JrIKViYwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aTBOB54RU+YdwYgVxOVAiD51JZyY1jt8OGqMBUWUeEBFCTnrXPNdvl6f8FEcqUuB1
 wB0jpCN3uPCXAs9spTcHTuMIPHugakiitDXqk+e47QKdDq1+tFOK2Fe1iaeGK8kdZR
 zv9z6aOpgES85LJuXJeWo7x9ouX68W4SKeWI8drQ=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 33/35] target/ppc: Remove redundant mask in DCBZ
Date: Mon,  3 Feb 2020 17:11:21 +1100
Message-Id: <20200203061123.59150-34-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The value of addr has already been masked, just above.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200129235040.24022-4-richard.henderson@linaro.org>
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mem_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index e7d3a79d96..0cb78777e7 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -293,7 +293,7 @@ static void dcbz_common(CPUPPCState *env, target_ulon=
g addr,
     addr &=3D mask;
=20
     /* Check reservation */
-    if ((env->reserve_addr & mask) =3D=3D (addr & mask))  {
+    if ((env->reserve_addr & mask) =3D=3D addr)  {
         env->reserve_addr =3D (target_ulong)-1ULL;
     }
=20
--=20
2.24.1


