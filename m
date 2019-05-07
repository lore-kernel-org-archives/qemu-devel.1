Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F1C04AAB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCC720835
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="nNYu8Uu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCC720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36025 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNoJE-0007rY-FQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:50:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHW-0006qa-60
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHV-0002vm-9Y
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45431 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hNoHU-0002sD-Jz; Mon, 06 May 2019 20:48:29 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 44ygvV4mqwz9s9y; Tue,  7 May 2019 10:48:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557190102; bh=q5sp7WeWR3PXwMbF0c2pYs8WTUVcBh+XZBdmTr5+9RQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nNYu8Uu2PdioPSVrzg5Xud1NJM7t+d8JkUXJHGEqRDxE+70vuvRsd9/WInVHxJYAJ
	PDfaeDrPggwhfiv0ZQ/4JK4fBhY7OdETB/F3Lqc9LMlNLiMQ5jvWsUF+ZgFYeZiolU
	iCLJaJd1j5+LsXpXNedqJFMLduxHhDWCT810iWaB8DGldzKY2pkrTogOrjmYZD3Cut
	T8lJDYDkwiRrMzrQhD+CtIt2xFmujBc1QY8ghMNQpeMP2gIfWuGtk6W6QybvCCeST8
	PvjN0bNdO777SaoRQRYK2QZwlzyDTMt/MhEHJ7qTu3fRdQzdhDZoi71wR/JdcG62kC
	IXXX5J/2Hmrcg==
From: Anton Blanchard <anton@ozlabs.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:48:03 +1000
Message-Id: <20190507004811.29968-1-anton@ozlabs.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH 1/9] target/ppc: Fix xvxsigdp
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, mark.cave-ayland@ilande.co.uk,
	f4bug@amsat.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a typo in xvxsigdp where we put both results into the lower
doubleword.

Fixes: dd977e4f45cb ("target/ppc: Optimize x[sv]xsigdp using deposit_i64(=
)")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/translate/vsx-impl.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 11d9b75d01..4d8ca7cf32 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1820,7 +1820,7 @@ static void gen_xvxsigdp(DisasContext *ctx)
     tcg_gen_movi_i64(t0, 0x0010000000000000);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
     tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
-    tcg_gen_deposit_i64(xth, t0, xbl, 0, 52);
+    tcg_gen_deposit_i64(xtl, t0, xbl, 0, 52);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
=20
     tcg_temp_free_i64(t0);
--=20
2.20.1


