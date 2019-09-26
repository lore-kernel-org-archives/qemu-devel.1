Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F229C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9CC21A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlwvgVBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9CC21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDX2g-000639-Of
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 12:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcJ-0002mP-59
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDWcH-0004rr-Dp
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDWcH-0004rK-7c
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 12:27:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so2111639pfo.10
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jrvKbjfU1dFIu8+98+zhi34QV271t8gxz4iMHGKRMxY=;
 b=DlwvgVBMjYyJV7gzhvmmTzrKx50D0/XPtcd/euRD4gb25N/dXLiE53+IXVaKki187z
 Y8J2+MTS7X6HmB4m5BWCacNzPNs6ph2AmFdDgZA16jIzBKGg0zw9EeS7NF3jnZmD0OTz
 T5pwB0P6rsge989Cfi3l55cBlvptjIjWeYvSne9fL7uLG5CTCCbApRUyAvQZ9cS7rkVe
 HqXVZQxq3ZCJVvLET3gHD8RPqOUX2Hgc3z6fLPgLfirJSnJZcsbuj2sMf2sA/HUSk1TB
 6TMqVcUGKL2tgEXzpiHuW/nyEYKg5UNQpmrJDLWnRCVlaNo3z28tzGEWIbhCFfgeFvb+
 VaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jrvKbjfU1dFIu8+98+zhi34QV271t8gxz4iMHGKRMxY=;
 b=EbMgeR2KITaztSa/r/0hqMeiiGmqkv8u/BjnWFz7xBzHx5Uum/8dQreV1dVHQP9/Jn
 KQWURRcze/44leF4VaN3RZ4WnrYEAUa0R8LfYKrwNDQeUMOEcSp32Y7apjEgMhutCN96
 iURTrRViH8sCYINQj7kMabN5sDKy8uoiPsM7MP40kwzmF9KpZD11Jf8xs0pMLkEvyZTS
 +HJ9y1rxMBDo603jbBjlA2dk3a7ziR/1U1bdSTlQnFBQsDwIX2DBHOyt1og3PjPbgaGP
 uOebHsuLYqhMWCu1PLJJ8ZpNJdF187esmlMrS/XvifrTJvIKuK13iHlmD6BktrldW82w
 bDDA==
X-Gm-Message-State: APjAAAX3tAReYKlZoYgabEWjYoRKzX4gCC0BEXF1losYEcEL2M+GRjhg
 5RSPblxo/qJSHiddccmBu/i0ijGWDM0=
X-Google-Smtp-Source: APXvYqw1+Zf8tr9uvm298CxH2wAH1YLP8gS1cRbHbj4n6m41eFw8f+T6ZtGaVofhJ4ppq1gZw7FK6A==
X-Received: by 2002:a62:5441:: with SMTP id i62mr4779630pfb.49.1569515199840; 
 Thu, 26 Sep 2019 09:26:39 -0700 (PDT)
Received: from localhost.localdomain ([12.157.10.114])
 by smtp.gmail.com with ESMTPSA id 64sm4453169pfx.31.2019.09.26.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 09:26:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/18] target/s390x: Remove ILEN_AUTO
Date: Thu, 26 Sep 2019 09:26:13 -0700
Message-Id: <20190926162615.31168-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926162615.31168-1-richard.henderson@linaro.org>
References: <20190926162615.31168-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.196
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

This setting is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h         | 2 --
 target/s390x/excp_helper.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a5eab491cd..fc941c7d76 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -816,8 +816,6 @@ void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
 /* instruction length set by unwind info */
 #define ILEN_UNWIND                 0
-/* automatically detect the instruction length */
-#define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, uintptr_t ra);
 /* service interrupts are floating therefore we must not pass an cpustate */
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 8ce992e639..c252e9a7d8 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -196,9 +196,6 @@ static void do_program_interrupt(CPUS390XState *env)
     LowCore *lowcore;
     int ilen = env->int_pgm_ilen;
 
-    if (ilen == ILEN_AUTO) {
-        ilen = get_ilen(cpu_ldub_code(env, env->psw.addr));
-    }
     assert(ilen == 2 || ilen == 4 || ilen == 6);
 
     switch (env->int_pgm_code) {
-- 
2.17.1


