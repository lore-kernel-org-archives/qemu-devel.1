Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5915FC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A815218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKS7nzsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A815218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4as-000150-VN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59465)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0007DG-Ib
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nn-0001Dz-KX
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:47016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mk-0007dp-IT
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:53 -0400
Received: by mail-pf1-x442.google.com with SMTP id c3so1719837pfa.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sBwbqU4X+hNE91dFDdhNVeb0wgaIhMrDk27NuEJee50=;
 b=KKS7nzsLDVSNc1VvbWRcglwTfyMTZEEnYUte/KDEWGqNeypXRZCXi1Dtie8xRm3mZF
 qh/mWdgvddeWWyGwhkf3086WYUK0u23Tb5sb3tyAxdZLnUB310agADpJVgVq/Fgsiflp
 niYozs+Qo6EGdY4n9T3uk82z2B2K01L3LjGYUqwVt+CCk0tgYJ+Kp9lFGnVh1vO/g920
 JYKsXJ0KbM6lDHmR1zICJrVUejvqArz/dEDBp8HLokInn3uxP0BspjK8pPkirhkXy7fu
 Vnz467al7dYqUppYkJGdH1ofy2YeDDIX764PRJA7X8mm/uhXbFcTTQZzq/y3hvcz4KFc
 WMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sBwbqU4X+hNE91dFDdhNVeb0wgaIhMrDk27NuEJee50=;
 b=dqJBqXjhmU53GuhFtdWP8Ljor5Yps5h0B02GOPEd4GnXRKQu/olL4Z7PpLBAvnhbcF
 jZupEJqkMY3qy7UbjUuifjHXvBKRja8FAko+IGKswQjt/QwBv2LjY5/8NPrgmU8/K/C0
 6Pr3yba5CTEHKyOPqS+btlFpSC3+3NjxQj7Y33aab7gQXzvNNeV6SG5d0aXEQ88gxJ0o
 +blZ8tZyVLKyQJmLzj+m84dSxWmfDfy50LUj5j9qWsQdmuIexQd28lQ1Hwr1cjfui2L1
 HR5AEbPA4O94e4j9JCh7r/ZZgdBJZgrUHLbwIEunqVGP+UgFu+d/ZebMJYJ839vTJP78
 OaSw==
X-Gm-Message-State: APjAAAV/lsQQn0cloKZrC0CGL5deaq/XZvDS3VO0XAO6roBR116MtVHL
 j+U2N4dbhJFDzNXNaZYlqY4nsbEgLlQ=
X-Google-Smtp-Source: APXvYqwfAj7jNE7A1tUSHlSV+Fl/GcN3L2pLyWFK6+Idq2kWBgm74ODlPlrZyUiqUyFKdB1Q57AxHw==
X-Received: by 2002:a17:90a:c68c:: with SMTP id
 n12mr99655403pjt.33.1564163447257; 
 Fri, 26 Jul 2019 10:50:47 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:36 -0700
Message-Id: <20190726175032.6769-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32 decodetree
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the infrastructure that will become the new decoder.
No instructions adjusted so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 45 +++++++++++++++++++++++++++++++++++-
 target/arm/Makefile.objs     | 18 +++++++++++++++
 target/arm/a32-uncond.decode | 23 ++++++++++++++++++
 target/arm/a32.decode        | 23 ++++++++++++++++++
 target/arm/t32.decode        | 20 ++++++++++++++++
 5 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t32.decode

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 36419025db..4738b91957 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7715,6 +7715,33 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     }
 }
 
+/*
+ * Include the generated decoders.
+ * Note that the T32 decoder reuses some of the trans_* functions
+ * initially declared by the A32 decoder, which results in duplicate
+ * declaration warnings.  Suppress them.
+ */
+
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Wredundant-decls"
+# ifdef __clang__
+#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
+# endif
+#endif
+
+#include "decode-a32.inc.c"
+#include "decode-a32-uncond.inc.c"
+#include "decode-t32.inc.c"
+
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic pop
+#endif
+
+/*
+ * Legacy decoder.
+ */
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -7733,7 +7760,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
     cond = insn >> 28;
-    if (cond == 0xf){
+
+    if (cond == 0xf) {
         /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
          * choose to UNDEF. In ARMv5 and above the space is used
          * for miscellaneous unconditional instructions.
@@ -7741,6 +7769,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         ARCH(5);
 
         /* Unconditional instructions.  */
+        if (disas_a32_uncond(s, insn)) {
+            return;
+        }
+        /* fall back to legacy decoder */
+
         if (((insn >> 25) & 7) == 1) {
             /* NEON Data processing.  */
             if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
@@ -7953,6 +7986,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
 
     arm_skip_unless(s, cond);
 
+    if (disas_a32(s, insn)) {
+        return;
+    }
+    /* fall back to legacy decoder */
+
     if ((insn & 0x0f900000) == 0x03000000) {
         if ((insn & (1 << 21)) == 0) {
             ARCH(6T2);
@@ -9440,6 +9478,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ARCH(6T2);
     }
 
+    if (disas_t32(s, insn)) {
+        return;
+    }
+    /* fall back to legacy decoder */
+
     rn = (insn >> 16) & 0xf;
     rs = (insn >> 12) & 0xf;
     rd = (insn >> 8) & 0xf;
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 5cafc1eb6c..7806b4dac0 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -28,9 +28,27 @@ target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.decode $(D
 	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
+target/arm/decode-a32.inc.c: $(SRC_PATH)/target/arm/a32.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_a32 -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/decode-a32-uncond.inc.c: $(SRC_PATH)/target/arm/a32-uncond.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_a32_uncond -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
+target/arm/translate.o: target/arm/decode-a32.inc.c
+target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
+target/arm/translate.o: target/arm/decode-t32.inc.c
 
 obj-y += tlb_helper.o debug_helper.o
 obj-y += translate.o op_helper.o
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
new file mode 100644
index 0000000000..8dee26d3b6
--- /dev/null
+++ b/target/arm/a32-uncond.decode
@@ -0,0 +1,23 @@
+# A32 unconditional instructions
+#
+#  Copyright (c) 2019 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
+# All insns that have 0xf in insn[31:28] are decoded here.
+# All of those that have a COND field in insn[31:28] are in a32.decode
+#
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
new file mode 100644
index 0000000000..2d84a02861
--- /dev/null
+++ b/target/arm/a32.decode
@@ -0,0 +1,23 @@
+# A32 conditional instructions
+#
+#  Copyright (c) 2019 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
+# All of the insn that have a COND field in insn[31:28] are here.
+# All insns that have 0xf in insn[31:28] are in a32u.decode.
+#
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
new file mode 100644
index 0000000000..ac01fb6958
--- /dev/null
+++ b/target/arm/t32.decode
@@ -0,0 +1,20 @@
+# Thumb2 instructions
+#
+#  Copyright (c) 2019 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
-- 
2.17.1


