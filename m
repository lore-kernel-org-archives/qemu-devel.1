Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AD1ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46702089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2ptiFRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46702089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIxqP-0002tJ-5W
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 12:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH3-0002nz-Aj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIxH2-0007tg-5B
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:13 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIxH2-0007tP-1Z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 11:56:12 -0400
Received: by mail-yb1-xb41.google.com with SMTP id z2so217309ybn.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5TK2BjuSMMDdIP7qbR+6sWroGlmanOV91VZR8RZQmXE=;
 b=a2ptiFRhsf7+BU+L02eLqokAt4Qi1y0BibWRYxGi/ZF+3m3nbc4NmXIl/R3aDr7ok5
 nqTnu4S6Gl9V0/LxPeY+FI6M0M82BVKHVTIWCUnGhi+p+V82kc6Tq0GijY+h65EWCeHY
 eXeFxPatzoEQe/rbsaFMNviY/nYdUVwPYEUIgahuzhJIVPszMcycLBsLhIjsXSBC/tZ9
 nRX/Af09keUd5vo5cotY7UXkAP969d/zgNvxqbR/pzVayxQDRuN7cyh8tNCkH0Yqgzwu
 lAA6Wl+N4I8fb9S0tIArdmHANmciHVXB3pd076tTQNTY+gAMNNseDkq/6DV6E6qxYYD1
 J63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5TK2BjuSMMDdIP7qbR+6sWroGlmanOV91VZR8RZQmXE=;
 b=kbUtMGsnxoT1pSxYRof53WO+PpRV82ZP0oX/gFu982djZJ55DUXTnfsPeWfvaozfIA
 Dnhq/+6nDmrHVNAOK95MDSeyF52tGjHql1wK/yTqG6PKyI52U/o7Umqxsk2i10lt9nWp
 es6tNAd3mTQA64ENyavj9iZPbF9KJrFuB+DmAoz+i5smC3QE0+8dPDCKVy3g51+d25CC
 24TKeFnIlI3avZfs3UgFynMaoYt39RyWSI07RnbGEPkq3eh8qhy2QSaGSVrUlo97rxtR
 xO7qUWbQxG18OVqs5VihTw4jgW2AI//hVIVLhxv1abHd/EsbDu4HtToLcdKZXpg4MtxE
 BR2g==
X-Gm-Message-State: APjAAAVENVxQOIRu1Yz7O17EqoUOgwcq6BAqOYjQSrUFPuwn1mZk1hHq
 gC7ZIsANS2Bd/f/GvaOKbVp/f1Q+klc=
X-Google-Smtp-Source: APXvYqweBV+yD6HZdgabysivNxaLQJBEu1VqZZ2q1kzbxKVXm+/i4fWgIfwJ7oZFb89rxyiWPDq6JQ==
X-Received: by 2002:a5b:d:: with SMTP id a13mr10962807ybp.187.1570809371167;
 Fri, 11 Oct 2019 08:56:11 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id d17sm2473139ywb.95.2019.10.11.08.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:56:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 20/20] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
Date: Fri, 11 Oct 2019 11:55:46 -0400
Message-Id: <20191011155546.14342-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
References: <20191011155546.14342-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the payoff.

From perf record -g data of ubuntu 18 boot and shutdown:

BEFORE:

-   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 20.22% helper_lookup_tb_ptr
      + 10.05% tb_htable_lookup
      - 9.13% cpu_get_tb_cpu_state
           3.20% aa64_va_parameters_both
           0.55% fp_exception_el

-   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
   - 6.96% cpu_get_tb_cpu_state
        3.63% aa64_va_parameters_both
        0.60% fp_exception_el
        0.53% sve_exception_el

AFTER:

-   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 13.03% helper_lookup_tb_ptr
      + 11.19% tb_htable_lookup
        0.55% cpu_get_tb_cpu_state

     0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state

     0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64

Before, helper_lookup_tb_ptr is the second hottest function in the
application, consuming almost a quarter of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state consumes about 12%.

After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
with consumption dropping to a sixth of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
supporting function to rebuild hflags also consumes about 1%.

Assertions are retained for --enable-debug-tcg.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Retain asserts for future debugging.
---
 target/arm/helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae7b62458..c3e3dd2c41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11249,12 +11249,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    uint32_t flags, pstate_for_ss;
+    uint32_t flags = env->hflags;
+    uint32_t pstate_for_ss;
 
     *cs_base = 0;
-    flags = rebuild_hflags_internal(env);
+#ifdef CONFIG_DEBUG_TCG
+    assert(flags == rebuild_hflags_internal(env));
+#endif
 
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
         if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
             flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
-- 
2.17.1


