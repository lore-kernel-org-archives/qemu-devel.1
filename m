Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ABEC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7E120578
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="PDFacoS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7E120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOT25-0003Sj-28
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 16:19:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOT0q-0002sF-RT
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOT0p-0007z5-4j
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:18:00 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54875 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hOT0o-0007iJ-I9; Wed, 08 May 2019 16:17:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 44znp62Wxhz9s9T;
	Thu,  9 May 2019 06:17:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557346656; bh=1ZUozj+aqczDyPmG/j2bjCpGDLuHpAdkAJnlA7qalhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDFacoS2X0UZL4tT67LxdOeBFcBpEZYoLmKq8wLgO5Rg9etUPBbwzqdvNsoP38hNp
	9IrL0U7xhw6LjUeSGJfc0VtH5UhdTMEA+o6WFVNEhwe7ZQ6E3locAxIyh8xfLFytfx
	uLMSzW52JbxinJmypPxb097E9KOH3ieSTwtYrZN150YCCSljGGLADiUwoKF9/4KrN/
	VKnic537XwO9wsEZmMBLgioo9n0MJQB/o3OftAwnAfYJwlSjBs+VCuqYdRrxQRmGcJ
	61ATKkob7gi3e1oCJf1ABf1tqQ4fu+F6eMacVhwTNa0vSeAxd/T40b+YbTXKiRpU7B
	n302R/OSLbZqQ==
Date: Thu, 9 May 2019 06:17:33 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190509061713.69490488@kryten>
In-Reply-To: <20190507052039.GF7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-2-anton@ozlabs.org>
	<20190507052039.GF7073@umbus.fritz.box>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v2] target/ppc: Fix xxspltib
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
	mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

xxspltib raises a VMX or a VSX exception depending on the register
set it is operating on. We had a check, but it was backwards.

Fixes: f113283525a4 ("target-ppc: add xxspltib instruction")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/translate/vsx-impl.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index 4d8ca7cf32..4812a374aa 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1355,13 +1355,13 @@ static void gen_xxspltib(DisasContext *ctx)
     int rt = xT(ctx->opcode);
 
     if (rt < 32) {
-        if (unlikely(!ctx->altivec_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VPU);
+        if (unlikely(!ctx->vsx_enabled)) {
+            gen_exception(ctx, POWERPC_EXCP_VSXU);
             return;
         }
     } else {
-        if (unlikely(!ctx->vsx_enabled)) {
-            gen_exception(ctx, POWERPC_EXCP_VSXU);
+        if (unlikely(!ctx->altivec_enabled)) {
+            gen_exception(ctx, POWERPC_EXCP_VPU);
             return;
         }
     }
-- 
2.20.1


