Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DBC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F85207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHqQcKcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F85207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwNg-0005fi-L7
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 15:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5r-0003Q9-Sh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDw5p-0006X1-8f
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDw5o-0006V1-N4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 15:39:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id q7so2129405pfh.8
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vJYZZP2e9BNSzbbwHk+HhznESdz192Yke+3plcKoZ6o=;
 b=dHqQcKcS5KBF6O77Plq4rDj88JAbk5pu6LwtBQU8M0h8gG5Xw8hAxzb6qIuHHkqLF2
 cDkV41xYHWCRAQ1Cx7DvZcHOwJPNMUyUtumdCXb1Y6MoyYPAyglmn3b/eCL3M+S+tq6o
 PeoYDRYs+2Xi17wO9jh4HL7QcmAFuzB3i+A1Gu2F46/9Z4Pf5FMkpGRGfC01kYxrv/F5
 vzk4KJZ3IgilHkyH773copXHutd+QW6ynYY+kZHjFGd93yQUK/IurGINa/TeXeJvJFwT
 lpYpKkMCHqR7FAJOrpIN4iw4WDbs3CV0WXaliZ0ZigeNhAUIXQ52iznTxTQz1D/zxjOY
 +Kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vJYZZP2e9BNSzbbwHk+HhznESdz192Yke+3plcKoZ6o=;
 b=L8Twkh8vHCaeX2vyyXwxztibMvRr3l+EBN5Lh5X0ZsC0pCcE2926LEUC8GTyJShml7
 BVk3iRyoNVInq0dXK1jPENNahyWbxjQoYa0AeRMCIBPTwhPqivZ2XGw8gGT48MaSEFTZ
 0QK/dDKLf6Sl60Z/PGfc3Gdm9XQPBzPPrmc6G5GtoTuoUB31eeG/uL/F0+PUJVx48Uzc
 se5Jcd6CgFPnvvjsIQQb7bB+z2+OnIbRnHVZ0pMTBPbqPbtCBjZ5QG4L+Go0G80aUKF5
 DOpWpz5IIHSeYzdl3/uxkFWiZ4S+m74HZb2ng/hIS5OSGQfInS4SXtfDHKtbAJfmqTIp
 hudw==
X-Gm-Message-State: APjAAAUt7MuptgXlJFF/It9yoOdK/8UCF0l1wWM3WuMiuugSQHoszMye
 AAKLWeZq7yD20tJRgUNtgiEWctPY19s=
X-Google-Smtp-Source: APXvYqwmt2EGMGUa/8ndt/R4eNJMdH/aAOGqbHlMWLYFNgVmNvspgMU8TDyDkdVMavUt74tsamtwbw==
X-Received: by 2002:a63:eb18:: with SMTP id t24mr10939654pgh.214.1569613190764; 
 Fri, 27 Sep 2019 12:39:50 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.62])
 by smtp.gmail.com with ESMTPSA id 192sm3676403pfb.110.2019.09.27.12.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 12:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/18] target/s390x: Simplify helper_lra
Date: Fri, 27 Sep 2019 12:39:19 -0700
Message-Id: <20190927193925.23567-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190927193925.23567-1-richard.henderson@linaro.org>
References: <20190927193925.23567-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-s390x@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We currently call trigger_pgm_exception to set cs->exception_index
and env->int_pgm_code and then read the values back and then
reset cs->exception_index so that the exception is not delivered.

Instead, use the exception type that we already have directly
without ever triggering an exception that must be suppressed.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e15aa296dd..4254548935 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2361,34 +2361,23 @@ void HELPER(sturg)(CPUS390XState *env, uint64_t addr, uint64_t v1)
 /* load real address */
 uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
-    CPUState *cs = env_cpu(env);
-    uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
-    int old_exc, flags, exc;
+    int flags, exc, cc;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
         tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
     }
 
-    old_exc = cs->exception_index;
     exc = mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
     if (exc) {
-        /*
-         * We don't care about ILEN or TEC, as we're not going to
-         * deliver the exception -- thus resetting exception_index below.
-         * TODO: clean this up.
-         */
-        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc = 3;
-    }
-    if (cs->exception_index == EXCP_PGM) {
-        ret = env->int_pgm_code | 0x80000000;
+        ret = exc | 0x80000000;
     } else {
+        cc = 0;
         ret |= addr & ~TARGET_PAGE_MASK;
     }
-    cs->exception_index = old_exc;
 
     env->cc_op = cc;
     return ret;
-- 
2.17.1


