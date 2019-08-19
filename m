Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4407EC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6FF2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUNWfg2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6FF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpQY-0007jY-Q3
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLn-0001AI-Bi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLl-0005yB-Lf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:47035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLl-0005xa-G0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id m3so1914663pgv.13
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Lk8BfvHlK27e0gTYQ9ZvQ9xJX5SjXjlYlXz2Xz9pa/E=;
 b=jUNWfg2JTViv2fix6PZzGp0t1W7scoz+UR0bxYVGWrHznfKiCzy2XwTqvKrR6YQh4j
 gi/Lex9NfNxyOzHOUQMPpVIcgXdcOuLFJ0o9ul2/MzrK4rXJq6VqYZYdPBiMb00gpiZM
 JCDbQEgRPoMKxs5QYoB1GdDdl4QNwttpoJ6rzwP47jitpJki0PX50lUaLjLBY6z+t44I
 qwF6DPhEcmIVqV5YDBAm3Wtl2ouHW6wekL9UsRtEGPK9eThdMaq9XuCVLWhvdZVmzXwv
 jgtdOa2K7nEhcXsvOJkyWEdzWJEFcx/qfqImcjMn00dq21LeR4HFMiWfQX0n5A8J8qCk
 +8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Lk8BfvHlK27e0gTYQ9ZvQ9xJX5SjXjlYlXz2Xz9pa/E=;
 b=sL+09IAPl0MWffsiHJBSd+eaC/5816SCaFcEikdpRu3TS7/87NzLh2xxhwj8Mk1eTL
 j4S8y0bKfEFArCX6nSfgF2WNKdDv2LrkrmqtPdkX52BStE0eGUIR9m3gvo2b9KkuLgkd
 VRhA8/CVOV6vjMeuII8eFn0RcNx5q5R3zog/Kaku8z9DwPIIw4CC2O96vlhgYdbKCBSt
 QJN8oWud2GMFxzV50FWacw9mxLUTqAngCa2+w7C39yGkohrLdZq8dWN/hdWWhak+CNuU
 lX3Sp3pk3yXQ+YzRNCRe2e3A6T4kJhIYa5wi9inmlnBcXPUOm8gVl1sl8n1v4US0iEZ8
 lvkQ==
X-Gm-Message-State: APjAAAXepAhBEJfgheeKRP7BjHvxNPsPVL47FeiC90eiXkEL44+yo86N
 ysqDwxRpvNO5hcPcAYiLHZgqOp4h+FM=
X-Google-Smtp-Source: APXvYqwYTOrYgJfeqSSXZKA8jkQpd8+4/oaIhN9TVyKIknWIa7I7JvWd9deYzoUwsWQBWPl1sJuzpw==
X-Received: by 2002:a63:2252:: with SMTP id t18mr21883402pgm.5.1566250680149; 
 Mon, 19 Aug 2019 14:38:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:37:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:49 -0700
Message-Id: <20190819213755.26175-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 02/68] target/arm: Add stubs for aa32
 decodetree
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the infrastructure that will become the new decoder.
No instructions adjusted so far.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 31 ++++++++++++++++++++++++++++++-
 target/arm/Makefile.objs     | 18 ++++++++++++++++++
 target/arm/a32-uncond.decode | 23 +++++++++++++++++++++++
 target/arm/a32.decode        | 23 +++++++++++++++++++++++
 target/arm/t32.decode        | 20 ++++++++++++++++++++
 5 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/a32-uncond.decode
 create mode 100644 target/arm/a32.decode
 create mode 100644 target/arm/t32.decode

diff --git a/target/arm/translate.c b/target/arm/translate.c
index db69d998eb..c759fe0797 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7661,6 +7661,18 @@ static void arm_skip_unless(DisasContext *s, uint32_t cond)
     arm_gen_test_cc(cond ^ 1, s->condlabel);
 }
 
+/*
+ * Include the generated decoders.
+ */
+
+#include "decode-a32.inc.c"
+#include "decode-a32-uncond.inc.c"
+#include "decode-t32.inc.c"
+
+/*
+ * Legacy decoder.
+ */
+
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
     unsigned int cond, val, op1, i, shift, rm, rs, rn, rd, sh;
@@ -7679,7 +7691,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
     cond = insn >> 28;
-    if (cond == 0xf){
+
+    if (cond == 0xf) {
         /* In ARMv3 and v4 the NV condition is UNPREDICTABLE; we
          * choose to UNDEF. In ARMv5 and above the space is used
          * for miscellaneous unconditional instructions.
@@ -7687,6 +7700,11 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -7901,6 +7919,12 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
            next instruction */
         arm_skip_unless(s, cond);
     }
+
+    if (disas_a32(s, insn)) {
+        return;
+    }
+    /* fall back to legacy decoder */
+
     if ((insn & 0x0f900000) == 0x03000000) {
         if ((insn & (1 << 21)) == 0) {
             ARCH(6T2);
@@ -9386,6 +9410,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
index 0000000000..a3e6e8c1c2
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
+# All insns that have 0xf in insn[31:28] are in a32-uncond.decode.
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


