Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A0C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126F0208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vxm792M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126F0208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsda-0003AN-4z
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:04:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsQ0-0008Dz-Ov
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVsPz-0002YT-N6
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:50:36 -0400
Received: from ozlabs.org ([203.11.71.1]:56715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hVsPz-0002Wf-Ci; Wed, 29 May 2019 02:50:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DLv25Pvxz9sNw; Wed, 29 May 2019 16:50:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559112622;
	bh=6umsziP45kqLQbkhjysqubHMINrd6dPk0OGV7I94jHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vxm792M3Oxxq7aJN0Az+D7wgNohp5fRdae5mqcVSgNPY7f87jmGqe0evITq1+93zS
	v9DadtxT2l/v0njho7OnBY9pKzJ4j0oDjLQ+jrIliwMEc5XLT/XkmIMOLzN1IPz+mj
	024b5iJgv3MA68nPqs5YAi4ALA4l3hPwgDaus3XE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 29 May 2019 16:49:43 +1000
Message-Id: <20190529065017.15149-11-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529065017.15149-1-david@gibson.dropbear.id.au>
References: <20190529065017.15149-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 10/44] target/ppc: Fix xxbrq, xxbrw
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@ozlabs.org>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Blanchard <anton@ozlabs.org>

Fix a typo in xxbrq and xxbrw where we put both results into the lower
doubleword.

Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()=
 helpers for VSR register access")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
Message-Id: <20190507004811.29968-3-anton@ozlabs.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate/vsx-impl.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 4d8ca7cf32..d29f60e2f9 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1192,7 +1192,7 @@ static void gen_xxbrq(DisasContext *ctx)
     tcg_gen_bswap64_i64(xtl, xbh);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
     tcg_gen_mov_i64(xth, t0);
-    set_cpu_vsrl(xT(ctx->opcode), xth);
+    set_cpu_vsrh(xT(ctx->opcode), xth);
=20
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(xth);
@@ -1220,7 +1220,7 @@ static void gen_xxbrw(DisasContext *ctx)
     get_cpu_vsrl(xbl, xB(ctx->opcode));
=20
     gen_bswap32x4(xth, xtl, xbh, xbl);
-    set_cpu_vsrl(xT(ctx->opcode), xth);
+    set_cpu_vsrh(xT(ctx->opcode), xth);
     set_cpu_vsrl(xT(ctx->opcode), xtl);
=20
     tcg_temp_free_i64(xth);
--=20
2.21.0


