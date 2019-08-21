Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C06C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A6722D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAX5yKI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A6722D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0UjV-0000Io-7w
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URD-00013C-Hx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URC-0007Lz-Hg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:23 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:35833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URC-0007LC-Df
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:22 -0400
Received: by mail-yw1-xc42.google.com with SMTP id g19so1247176ywe.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iDDKKkIsqc5vcwy+TY7VAlm2HY42sA6+LGzneYmglI8=;
 b=UAX5yKI+RA4KqLkVkxerCxJuJZg3JYm2iJx/OEg04OTyGx1uB4zRQqge6A2COGPbBX
 ADLg1+0HwdqtuXee+MK1KdkNiZrVbufG2iVV+4THnlDJsh/N03h9EH9SJEJMfsjsch+7
 eG/TsLIv1fRWoB79aonXWpac0Skdxn0fSpW3r0IGb2pB56M6aIZjzm4fapq0K1sRW3TC
 XFk4loHjKibTKvRhG8HgH7EIh+NK7Tu80732Kyod+IVsZ2BbRu94O7D6XCdSHEwaQuQl
 PZ8egdU0I7wNpUQ5JuTmfKyjI1mYqbDWlYIs5rFS0ajkzZZQTi6kzDXtuSFKHZKz7Kdj
 4CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iDDKKkIsqc5vcwy+TY7VAlm2HY42sA6+LGzneYmglI8=;
 b=HKfuwxnUxqj6hgDdI5yowEqaotMw9KlbbVATiVjzphZC0c74EOLIHJak2i1vIjeYiw
 DNrt8WXpcbUARAqbDbXeqK7GiQdtVSYNJTk7w/q+Xg7Ch1+8wIBtaHgL8PBVSuMrqi0g
 ADaIAz8hda7Hm5GNBC+9vjyFSiJVGdoSe9otRIRtkto4xVDSKJ+EzHKBdCuVExAOMAeM
 aheyVupIbElwrzbKwjJohfgt4FTtwUU/Ww6VZeRPyyHqVXNzXzzJsDOk6ck3cibMMIA+
 ix1ZzHbqJF1TtRz25IuEb8vuh6SKYmT5AW44VmiQzCWStDBlUropUiiBJUUmAFxCTz1P
 MQ0Q==
X-Gm-Message-State: APjAAAVkY4cnvYodaa8RDI+GK7FvMF8/VnzWMKF1QmeoOpI+qNpxJCq2
 4cpuLe8n64JSnT8IZ4M0qZG6oXaZ
X-Google-Smtp-Source: APXvYqy0qumOobhp63Wtn1kLDwOnTWQ7f/SFiUWXPEWFDUqRhLWx8bEX4IxHJUI29XCtyv0dOouBUQ==
X-Received: by 2002:a81:7914:: with SMTP id u20mr25352685ywc.230.1566408621648; 
 Wed, 21 Aug 2019 10:30:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:21 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:57 -0400
Message-Id: <20190821172951.15333-22-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v4 21/75] target/i386: introduce tcg
 register operands
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG operands allocate a 32-bit or 64-bit TCG temporary and later
automatically free it.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1be6176934..80cfb59978 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4727,6 +4727,50 @@ static bool check_cpuid(CPUX86State *env, DisasContext *s, CheckCpuidFeat feat)
                                 env, s, modrm, is_write, arg);          \
     }
 
+/*
+ * tcg_i32
+ *
+ * Operand which allocates a 32-bit TCG temporary and frees it
+ * automatically after use.
+ */
+typedef TCGv_i32 insnop_arg_t(tcg_i32);
+typedef struct {} insnop_ctxt_t(tcg_i32);
+
+INSNOP_INIT(tcg_i32)
+{
+    return true;
+}
+INSNOP_PREPARE(tcg_i32)
+{
+    return tcg_temp_new_i32();
+}
+INSNOP_FINALIZE(tcg_i32)
+{
+    tcg_temp_free_i32(arg);
+}
+
+/*
+ * tcg_i64
+ *
+ * Operand which allocates a 64-bit TCG temporary and frees it
+ * automatically after use.
+ */
+typedef TCGv_i64 insnop_arg_t(tcg_i64);
+typedef struct {} insnop_ctxt_t(tcg_i64);
+
+INSNOP_INIT(tcg_i64)
+{
+    return true;
+}
+INSNOP_PREPARE(tcg_i64)
+{
+    return tcg_temp_new_i64();
+}
+INSNOP_FINALIZE(tcg_i64)
+{
+    tcg_temp_free_i64(arg);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


