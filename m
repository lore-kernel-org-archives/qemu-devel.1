Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A5C28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE342067C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 02:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wg3wk0tO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE342067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haA7b-0002Gx-9z
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 22:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53253)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eD-0006qO-1n
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ha9eA-0001ra-S7
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:56 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ha9eA-0001qy-IR
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 22:02:54 -0400
Received: by mail-pl1-x644.google.com with SMTP id bi6so2586640plb.12
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZuP9P/y2awmw4izu8Ta8VFFIgoiKI0vJso4eBOFOhZo=;
 b=wg3wk0tOo1E7X5mKkwYr/h6I0GvSS8QhhAAEoUOahxU+PcL2hUvQzGwQCsrPTrs3ZD
 D/Dnzf0uQPioO2Xu7iz7UWqHvjkXtMezqKAG3T0MPyZQKPeYgW8fqu+QHKxQr3GgKnIl
 cFfalEzXnpsDIzqw/tQcRvw9QEqmp86/j7306JkHteJbEolJ4YkIcnniZ/FooShHdAil
 aBlBr7CwL4osCpBtjfRQnVxQuKEy+sEo6rppVQGekLABCohPD0QMe02hWPjnkRvW6sEh
 +ZvnnhQwW7HMhcZ/Ye4ZMhzt/d5v7ukX9+7W33q4v8tbsN0jkdkgV9TfHLI+QIeUN1Qa
 l5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZuP9P/y2awmw4izu8Ta8VFFIgoiKI0vJso4eBOFOhZo=;
 b=JKd4oZBXRMrjKzmcaotcbOycbKOGly3xidNlvc3IsDahYeCocIqW8gTXkjuLpDUvZJ
 FfjZUtuU+cLvGgyvNiN+/EjycFmm/vBL+bNhLO2eKd7xOYTBY629pUyIwK98UR6RwsfE
 63c4cPkX1n+T50IHSoI1oWnytCpUsDSO0JcDjp2XdzsThOLD6hebXe5LeRpUKOu4PA0z
 8gvkP0f75QcBL1Y/0wlQlT2FbidbUezdlu/rRH0MgsPxwVh/PKNaQ9tDemTbTcWqrCFF
 LJXdEO30PiA1FRF50cQzosrENn1ROBH0wTrs4GtxWYLHhdpj5DX/62Bny1seiM+zH8WW
 TrNQ==
X-Gm-Message-State: APjAAAWoW8gE27TXWZSZbYyE9SsyLzatGyzP+J0BXphXxwOZP/p0UKMq
 MgycqyOP01/4BXO/33Po0t3z4hfSuBM=
X-Google-Smtp-Source: APXvYqx/6BIL7pmSoH+V4UG/MJGd2/SIj9Y2ZOHS0h5nnjrvXWbSUZm7aWCtoYfu87SoDNy22Pdejg==
X-Received: by 2002:a17:902:59da:: with SMTP id
 d26mr8651636plj.306.1560132173370; 
 Sun, 09 Jun 2019 19:02:53 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
 [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id l63sm9749013pfl.181.2019.06.09.19.02.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Jun 2019 19:02:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 19:02:06 -0700
Message-Id: <20190610020218.9228-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
References: <20190610020218.9228-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 27/39] target/tilegx: Use env_cpu
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
Replace tilegx_env_get_cpu with env_archcpu.  The combination
CPU(tilegx_env_get_cpu) should have used ENV_GET_CPU to begin;
use env_cpu now.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tilegx/cpu.h          | 5 -----
 linux-user/tilegx/cpu_loop.c | 2 +-
 target/tilegx/helper.c       | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 135df63523..7f8fe7c513 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -138,11 +138,6 @@ typedef struct TileGXCPU {
     CPUTLGState env;
 } TileGXCPU;
 
-static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
-{
-    return container_of(env, TileGXCPU, env);
-}
-
 #define ENV_OFFSET offsetof(TileGXCPU, env)
 
 /* TILE-Gx memory attributes */
diff --git a/linux-user/tilegx/cpu_loop.c b/linux-user/tilegx/cpu_loop.c
index 4f39eb9ad3..d4abe29dcd 100644
--- a/linux-user/tilegx/cpu_loop.c
+++ b/linux-user/tilegx/cpu_loop.c
@@ -206,7 +206,7 @@ static void do_fetch(CPUTLGState *env, int trapnr, bool quad)
 
 void cpu_loop(CPUTLGState *env)
 {
-    CPUState *cs = CPU(tilegx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
     int trapnr;
 
     while (1) {
diff --git a/target/tilegx/helper.c b/target/tilegx/helper.c
index 4964bb9111..a57a679825 100644
--- a/target/tilegx/helper.c
+++ b/target/tilegx/helper.c
@@ -28,7 +28,7 @@
 
 void helper_exception(CPUTLGState *env, uint32_t excp)
 {
-    CPUState *cs = CPU(tilegx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = excp;
     cpu_loop_exit(cs);
-- 
2.17.1


