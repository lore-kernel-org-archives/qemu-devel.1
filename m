Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41376C04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D686208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="BpXtFMix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D686208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOXGR-0004kU-AW
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 20:50:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOXFS-0004NV-4D
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOXFR-0003S6-1f
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:49:22 -0400
Received: from ozlabs.org ([203.11.71.1]:39499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hOXFO-0003ON-Rm; Wed, 08 May 2019 20:49:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 44zvqY3WzCz9s9T;
	Thu,  9 May 2019 10:49:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557362953; bh=MEd9dxcvskEBkQaRIX15D4PtNkNhpfkqi3tnAZCafUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BpXtFMixNCabcKmFElL1FDF3Uga06txtQAxmF3ih3Ask4Tq+28ruwQomiSiFxhp71
	T6WzlIbyBnOV3VpCsnU/82SIs/Y8hesuWEj83N/5Ky0DBLBkpZVURNdbeQN3b5NiCu
	WirhJH3xhZe6fQi85HWKTpNJRTXODT6CFhSZaAulVlwhBVEv+gupH01YxtSU7n9PDb
	huxG4zecLoi9QhU1NMP1gsIEsR4vnuHMQs4dYt/SqPfgbiXz+HjFN+EfSeLNK8qr7Q
	+QlpHAsfS90csQA/u8U2nN+9dUjlrdwbcGnxSovFxPI/7SBXeKLcPE0+in3jFut27X
	jGXbMh8WyJdMQ==
Date: Thu, 9 May 2019 10:49:12 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190509104912.6b754dff@kryten>
In-Reply-To: <20190507052243.GH7073@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-5-anton@ozlabs.org>
	<20190507052243.GH7073@umbus.fritz.box>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PATCH v2] target/ppc: Fix xvabs[sd]p, xvnabs[sd]p,
 xvneg[sd]p, xvcpsgn[sd]p
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

We were using set_cpu_vsr*() when we should have used get_cpu_vsr*().

Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}() helpers for VSR register access")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/translate/vsx-impl.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
index b487136d52..4b7627f53b 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -859,8 +859,8 @@ static void glue(gen_, name)(DisasContext *ctx)                  \
         xbh = tcg_temp_new_i64();                                \
         xbl = tcg_temp_new_i64();                                \
         sgm = tcg_temp_new_i64();                                \
-        set_cpu_vsrh(xB(ctx->opcode), xbh);                      \
-        set_cpu_vsrl(xB(ctx->opcode), xbl);                      \
+        get_cpu_vsrh(xbh, xB(ctx->opcode));                      \
+        get_cpu_vsrl(xbl, xB(ctx->opcode));                      \
         tcg_gen_movi_i64(sgm, sgn_mask);                         \
         switch (op) {                                            \
             case OP_ABS: {                                       \
-- 
2.20.1


