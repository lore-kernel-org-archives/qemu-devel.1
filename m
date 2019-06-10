Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F68C468BD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182FB2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN5FDcDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182FB2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA7d-0002Mm-CC
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53292)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eF-0006sl-Kb
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eD-0001v9-6o
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:44314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eD-0001rn-1I
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t7so372545plr.11
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YQXS0805f11aCOQVinsy2uv+bSnryD5T76PFwhCiklU=;
 b=eN5FDcDVgf6mxJQJUqysPNNNmR+XC1LnCHiKl8yQqhNO1fMtcmFLNR2bzW17aMBoE2
 P4GQGY4w310j2EqRHq82RbQ3m/v+AWGbWXrl79neCaTuq1jshppOa1VIkQZKpi7oVRsb
 VAJFqWnWn8GDrh/ZJkuow6FP1ev7KeopbtiPtnwCrTw0L60QNO6ok2zcafC/PN1eHkF5
 OA5CT32+JSiVQJEqAb7GKT6cmXmrLkjP9U1kkvGCQHSX/aHZA4KDYVNtRnDVHihmllnZ
 52Bby8/aNoajlEnXQnzhHEJU/a9INcq730qlKBgpwG5s3J2EzE7MfZbS1eckCpflKcpc
 g/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YQXS0805f11aCOQVinsy2uv+bSnryD5T76PFwhCiklU=;
 b=lDJFhtzdmv29LwXHBUsP8C7RKMm0jOqajAqEn9UULw/lPoiLrw2mPZepwloQofu7B0
 zcMY1NPiYgp8/yXBi4xRyX7uBTB7BB/fPzUhHq/Gi/03gQaBv9+eaELsp4cc1XTBjXQD
 bNAhisGdwdKQ9fwUSyHXq9qrXZYMDIXcSGq6Z/Z+cRzXMYosh8mDx5LQsoPNFp46tjZL
 WohG/GcKBQ86pzSgj1aNeVRtskkIHBUTDOVY72yhuGNALdmQNWljHq7JjglMz1LT4NGH
 YpSnFKHRgjzaTIwY02EgCGIplc12BSaRHpizi1vO9mClOFEbnvykFzgM6FJPMqUK6BjJ
 BKsw==
X-Gm-Message-State: APjAAAXlXjNj2WKSOANMUs2Eb3CLAYuqdxz0zll+tqjYt5dfI4kbr5NP
 +u4BAZL0PbyzfHwwFIH13oDjSLJRvSU=
X-Google-Smtp-Source: APXvYqxtakNJVs4FZcRj9smWVwXAlcy0kgei/1RVa7DWEsgtZnIA33ibDfwl0xBDIQj9P/Y5YcPQaw==
X-Received: by 2002:a17:902:8d91:: with SMTP id
 v17mr49280681plo.91.1560132174413; 
 Sun, 09 Jun 2019 19:02:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:07 -0700
Message-Id: <20190610020218.9228-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PULL 28/39] target/tricore: Use env_cpu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cleanup in the boilerplate that each target must define.
Replace tricore_env_get_cpu with env_archcpu.  The combination
CPU(tricore_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/cpu.h       | 5 -----
 target/tricore/op_helper.c | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 4a2a955cc5..6a40d37362 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -208,11 +208,6 @@ struct TriCoreCPU {
     CPUTriCoreState env;
 };
 
-static inline TriCoreCPU *tricore_env_get_cpu(CPUTriCoreState *env)
-{
-    return TRICORE_CPU(container_of(env, TriCoreCPU, env));
-}
-
 #define ENV_OFFSET offsetof(TriCoreCPU, env)
 
 hwaddr tricore_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 601e92f92a..9476d10d00 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -29,7 +29,7 @@ static void QEMU_NORETURN
 raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin,
                               uintptr_t pc, uint32_t fcd_pc)
 {
-    CPUState *cs = CPU(tricore_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     /* in case we come from a helper-call we need to restore the PC */
     cpu_restore_state(cs, pc, true);
 
-- 
2.17.1


