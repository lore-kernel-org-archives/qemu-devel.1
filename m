Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20421C04A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7E6206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="x/pnkGej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7E6206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNoPu-0005y4-6d
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHa-0006tX-Fc
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hNoHZ-0002zw-KR
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:48:34 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hNoHZ-0002xc-7I; Mon, 06 May 2019 20:48:33 -0400
Received: by ozlabs.org (Postfix, from userid 1010)
	id 44ygvf62S5z9sNT; Tue,  7 May 2019 10:48:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557190110; bh=XRP6A0gzPVAj+xbze5JppSbAWJ2Cu6Fjd84LzxEGbrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/pnkGejMhiiYEQ9XOjPZ2F6kH1tPMIldFPGpi9kXensG9pX53LwFddSDHSYMYV2l
	LYFu5R+VdVp5RCB0IsmIlWH18VR2V8/mFJrfltMkTSbV/Iu0zgP+mgfsUUb4sxqD2+
	G+fngy9mjssnJ1FGbPBHEhO7UK0qP2tUditNXpK5Z/zIl2l9+9CKVHHfOpvD5M9mnG
	cNTnEqtaPkEHJHcSmiu7PKKrBVL8DVwqW6la2CJh2mQAOo8L4nvtFytxhe3ierpX8O
	vlsInP7xiD3GqfG1QlBCwcQOirg/SxCzAMZkktP98G/q73MQVVKXcWM/kwTCxPWfIP
	i76EOPeZChBZA==
From: Anton Blanchard <anton@ozlabs.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:48:10 +1000
Message-Id: <20190507004811.29968-8-anton@ozlabs.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507004811.29968-1-anton@ozlabs.org>
References: <20190507004811.29968-1-anton@ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PATCH 8/9] target/ppc: Fix dtstsfi and dtstsfiq
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

The immediate field is 6 bits, not 5.

Fixes: 217f6b88058f ("target-ppc: add dtstsfi[q] instructions")
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
---
 target/ppc/internal.h               | 2 ++
 target/ppc/translate/dfp-impl.inc.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index fb6f64ed1e..4719369cc5 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -123,6 +123,8 @@ static inline uint32_t SPR(uint32_t opcode)
 EXTRACT_SHELPER(SIMM, 0, 16);
 /* 16 bits unsigned immediate value */
 EXTRACT_HELPER(UIMM, 0, 16);
+/* 6 bits unsigned immediate value */
+EXTRACT_HELPER(UIMM6, 16, 6);
 /* 5 bits signed immediate value */
 EXTRACT_SHELPER(SIMM5, 16, 5);
 /* 5 bits signed immediate value */
diff --git a/target/ppc/translate/dfp-impl.inc.c b/target/ppc/translate/d=
fp-impl.inc.c
index 6c556dc2e1..5b01c9239d 100644
--- a/target/ppc/translate/dfp-impl.inc.c
+++ b/target/ppc/translate/dfp-impl.inc.c
@@ -55,7 +55,7 @@ static void gen_##name(DisasContext *ctx)         \
         return;                                   \
     }                                             \
     gen_update_nip(ctx, ctx->base.pc_next - 4);            \
-    uim =3D tcg_const_i32(UIMM5(ctx->opcode));      \
+    uim =3D tcg_const_i32(UIMM6(ctx->opcode));      \
     rb =3D gen_fprp_ptr(rB(ctx->opcode));           \
     gen_helper_##name(cpu_crf[crfD(ctx->opcode)], \
                       cpu_env, uim, rb);          \
--=20
2.20.1


