Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAD5C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B09208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCzTHbuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B09208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5k9-0005eq-CG
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0006JB-41
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0000F2-2z
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:25 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dc-0000Dn-VA
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:25 -0400
Received: by mail-yb1-xb41.google.com with SMTP id u32so388462ybi.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ChWMIPl+dab6o+BediH5d8eY5VFridF7PbVi1UCCf4c=;
 b=GCzTHbuKq1+/cvJUsDndSXsF3DN/oieM/iQMqcOYe6zJ0vg82U8rKh73x9RCwVEe5a
 g6/s9NMO5m0XP83sVn/GucTZjWTfxCSKgoYM/cq9zj3kqLMr67fxOlF3rexX9Svtll8j
 4wVGMKbL/ApADJtx+BmtK/W64gmNmw5v1HhydwWtKvnh7nN7MrEpP+wktemKt8Muk0cw
 EKG/InFa6CZUhIGYCTbZmYpyWQKh8ijRMoZCQ4x7kcnPF+/XKaKY4W0e3xYCng1/TaTC
 H1BP+6Hixyf8ALXQFf3PgS8H1CRkSWJWiT7AwJVYD6bCXmnwJ0dxDlgGXq6LmXDxG0u2
 WZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ChWMIPl+dab6o+BediH5d8eY5VFridF7PbVi1UCCf4c=;
 b=YhwLLdri6onUUmIz7/Um0eIq2p3gVObIR5/+RqlbluF5djIUHaGgQHClFQbsHl0ySH
 ZfXE4lHdOXZ4ayH9q8SwZzBlBFKgFTvJ1IcmGZTD9cmigq9x9O8S+XxdETv9rRZaM/vC
 3SIdiDJmh2HxfqbH7bnLFqJFrPvzfHvszOvnc6Ei1cH/1poNX/I3LU60mL6oMh1aVc87
 a80wS5ag/XyjeCisNVcu61mKOtOt9tzg/XTUOzhs1KiM2uoAPSIjp/GCBL4KdRxgw4LH
 mL+c+0Mudk4GVr/rt8dDW+naMUWEjHHd4+dxuhnlIfpqv91or2DzlFroPwO/1L/i32o+
 RjUQ==
X-Gm-Message-State: APjAAAWu6QDawEnf/N79Vckao+25d/A4qT6zPbzKg9aNlIfqDduS8xnf
 GO1pr11JH9tOiwX966ZIuGpaPvWP
X-Google-Smtp-Source: APXvYqxcijV8iwBOtSQjefYwFM2icUCZISZhudJLROLl40sksa8//EinJQXSeFDlkWuC6FiOk6CxDQ==
X-Received: by 2002:a25:2f42:: with SMTP id v63mr1956098ybv.228.1565835023859; 
 Wed, 14 Aug 2019 19:10:23 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:23 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:14 -0400
Message-Id: <20190815020928.9679-33-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RFC PATCH v3 32/46] target/i386: introduce gvec-based
 code generator macros
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

Code generators defined using these macros rely on a gvec operation
(i.e. tcg_gen_gvec_*).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b28d651b82..75652afb45 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -23,6 +23,7 @@
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg-op.h"
+#include "tcg-op-gvec.h"
 #include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 
@@ -5351,6 +5352,18 @@ INSNOP_LDST(xmm_t0, Mhq)
         tcg_temp_free_i32(arg4_r32);                                    \
     }
 
+#define DEF_GEN_INSN2_GVEC(mnem, gvec, opT1, opT2, vece, oprsz, maxsz)  \
+    GEN_INSN2(mnem, opT1, opT2)                                         \
+    {                                                                   \
+        tcg_gen_gvec_ ## gvec(vece, arg1, arg2, oprsz, maxsz);          \
+    }
+
+#define DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece, oprsz, maxsz) \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        tcg_gen_gvec_ ## gvec(vece, arg1, arg2, arg3, oprsz, maxsz);    \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


