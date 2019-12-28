Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774AFC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E3F20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3dkP/VL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E3F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLb6-0007Mt-UN
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGQ-000639-C0
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGP-0001eh-6e
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:54 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLGO-0001Zm-Nc
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:53 -0500
Received: by mail-pj1-x1043.google.com with SMTP id j11so6314056pjs.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SEzpAukoAQn83lsfCzdS88MYe9lG7G86695cNY7gsMY=;
 b=s3dkP/VLX154ub2oVFcY1BumUMIENcyb7ivyYPRbHlGSEOBXr2M2HGbG3tB8kRdJQy
 BxHLD4t04VzGFawFz4765/5i4+sGeClLVK+M/M96HW3NpRV+83tNiWRkeN7d7sUQySmW
 pxr8PCDCZTjalhKZeHGnGLHyv817VP3lYZEm8Q+lYaMAeFz0bLGKjmhWeM9GfRFnVGB1
 T4sVMl19ClaAb9tCfIgc0X4COlwgN5LAWdfuNBTIiMmAB3oxDvubEUdtYdF/mcJEl7hd
 uCXjCAqiaSQ6AkvxXmYavLSLlm+UTG6WOTs4X9MpL4S1+bg/CkqGeXX+BvP5SIaEp9jr
 NRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SEzpAukoAQn83lsfCzdS88MYe9lG7G86695cNY7gsMY=;
 b=FraUW4THu3iEFg7x7HUS61/zgGrdqSq6Njfwq+yOzPzGQz8KJyQBFNMGO97urHBShI
 5/0SzfbqDyvkihRYra5IcxqmYkTE9iCoaw3MeaoZkTiRxg+lqIDIRS0LJxARdSVH8Unx
 aWpddj8FjMHRAi3nOZo/hnCkRykRa4vA3VzkidJ7l6m0Hi1fSVxGgzSw/ge5LMH5kNBh
 Q/xrGq9t9izbZXEE/TQSmg7cioLb5ELr1VTr3tRz3pJisTjs74SMauekmXD5nzlUl0S3
 MFAGJmFuLfgZ51QALl9fQNbGfH0USC+O6Oa+qzz5FkXd4w2MrdbFawCb6A307lRDEe2p
 5KmA==
X-Gm-Message-State: APjAAAV7LVi5XRJN6DN8989FTOKeKaf/gbkwOZgRQxvdbYVpdS3IHW05
 DBAdRfj3KwuJrDUDGOtfJmUnTEqriiU=
X-Google-Smtp-Source: APXvYqwJEzawqqregaKhZjTyke8TuONWp/X4GrWZfiI+pRJuefBF4ftzLjghvvNi8S/4lfWyyNK4cQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr35286932pjg.111.1577574771414; 
 Sat, 28 Dec 2019 15:12:51 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/29] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
Date: Sun, 29 Dec 2019 10:11:22 +1100
Message-Id: <20191228231124.18307-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two uses.  Within dcbz_common, the local variable
mmu_idx already contains the epid computation, and we can avoid
repeating it for the store.  Within helper_icbiep, the usage is
trivially expanded using PPC_TLB_EPID_LOAD.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h        |  2 --
 target/ppc/mem_helper.c | 11 ++---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 103bfe9dc2..8ebeaba649 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -951,8 +951,6 @@ struct ppc_radix_page_info {
  * + real/paged mode combinations. The other two modes are for
  * external PID load/store.
  */
-#define MMU_MODE8_SUFFIX _epl
-#define MMU_MODE9_SUFFIX _eps
 #define PPC_TLB_EPID_LOAD 8
 #define PPC_TLB_EPID_STORE 9
 
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 1351b53f28..56855f2381 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     } else {
         /* Slow path */
         for (i = 0; i < dcbz_size; i += 8) {
-            if (epid) {
-#if !defined(CONFIG_USER_ONLY)
-                /* Does not make sense on USER_ONLY config */
-                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
-#endif
-            } else {
-                cpu_stq_data_ra(env, addr + i, 0, retaddr);
-            }
+            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
         }
     }
 }
@@ -216,7 +209,7 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
 #if !defined(CONFIG_USER_ONLY)
     /* See comments above */
     addr &= ~(env->dcache_line_size - 1);
-    cpu_ldl_epl_ra(env, addr, GETPC());
+    cpu_ldl_mmuidx_ra(env, addr, PPC_TLB_EPID_LOAD, GETPC());
 #endif
 }
 
-- 
2.20.1


