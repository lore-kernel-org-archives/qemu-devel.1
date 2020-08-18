Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3807C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADD920706
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Pi1OH+lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADD920706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tBN-00088y-Qi
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t68-0007MW-Cg; Tue, 18 Aug 2020 00:19:44 -0400
Received: from ozlabs.org ([203.11.71.1]:35485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t65-0006L1-Bi; Tue, 18 Aug 2020 00:19:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNZ0lRFz9sTs; Tue, 18 Aug 2020 14:19:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724366;
 bh=ZcLWJRCfe42jLOzZWBdTOkvTNEMdWVGD+cDNWo3TWFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pi1OH+lo9LxEZvoVkZnjHK75V+AscdcrLs7BK3woiCKIhJnvlEe2g+tXqmMqOfDEQ
 WEHykNhlUjkQkTVCef/8hXuGyGzYj8erfOZ39aza3qCH62zJ17CbkLS7Q89Psv25Pk
 UN4c9mh+FB8zwobalNdxcUSwsXVwbgy3TqBdJOQ8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 05/40] target/ppc: convert vmuluwm to tcg_gen_gvec_mul
Date: Tue, 18 Aug 2020 14:18:47 +1000
Message-Id: <20200818041922.251708-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Lijun Pan <ljp@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lijun Pan <ljp@linux.ibm.com>

Convert the original implementation of vmuluwm to the more generic
tcg_gen_gvec_mul.

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
Message-Id: <20200701234344.91843-5-ljp@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/helper.h                 |  1 -
 target/ppc/int_helper.c             | 13 -------------
 target/ppc/translate/vmx-impl.inc.c |  2 +-
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 90166cbabd..032da717f7 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -184,7 +184,6 @@ DEF_HELPER_3(vmulosw, void, avr, avr, avr)
 DEF_HELPER_3(vmuloub, void, avr, avr, avr)
 DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
-DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d8bd3c234a..263e899fe0 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -523,19 +523,6 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
     r->VsrD(0) = 0;
 }
 
-#define VARITH_DO(name, op, element)                                    \
-    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            r->element[i] = a->element[i] op b->element[i];             \
-        }                                                               \
-    }
-VARITH_DO(muluwm, *, u32)
-#undef VARITH_DO
-#undef VARITH
-
 #define VARITHFP(suffix, func)                                          \
     void helper_v##suffix(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a, \
                           ppc_avr_t *b)                                 \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index de2fd136ff..b6c9290707 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -801,7 +801,7 @@ static void trans_vclzd(DisasContext *ctx)
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
-GEN_VXFORM(vmuluwm, 4, 2);
+GEN_VXFORM_V(vmuluwm, MO_32, tcg_gen_gvec_mul, 4, 2);
 GEN_VXFORM_DUAL(vmulouw, PPC_ALTIVEC, PPC_NONE,
                 vmuluwm, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM(vmulosb, 4, 4);
-- 
2.26.2


