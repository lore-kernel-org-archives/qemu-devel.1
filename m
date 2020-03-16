Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51C4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBE720674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohAtQFEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBE720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45433 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDuDy-0007B1-I6
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRe-00019q-TL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRa-0001ZO-OE
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRa-0001S0-CU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id a132so18581313wme.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Iavl1t+1hLO1HhNMpopBwo5UBi82XsMo5friXiEmqcA=;
 b=ohAtQFEbqBJOfQLMC2YL9mpAkl10cKUrKnnCI5uxbDY5KZKAwUDW7GCxTvRnbRnfSZ
 7osy9E5PzJCLe2zTKZ/wpNpsvkmA4c27o5TrAXDeKdTgUizvbbvDoRwiTDtwb4MROzjk
 siGc11OnvgUCBWYBDo5VzPkCXiRVwObkSa0xNm4pV7KkxfnfyTrnn5lJk/ArtZd1PLow
 Kehy3iuwG/ueAAmffaw+Js0juiyyfKHVgBRpIm85uIdI5WTqEvwDFvO8jkl3YW7ZGEgX
 fT5Wj1r+hKc0ampZE1YIg93ys+wJ5ymnJo5lL3OpLWu+B7+R/YoIzFqlldKsIcHjHAnx
 p62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Iavl1t+1hLO1HhNMpopBwo5UBi82XsMo5friXiEmqcA=;
 b=ZehOWhGLSOVRfwuh6pjQKZ9YgfsK0AZwyxlvLcHzNOEufYFgvHA6tTmSOYlS7je3K2
 sYXWBB8m2uTJeJmBcxs/ckDHgrbIs92g95sSbTv0TGlwsuYJJzt78w8bqXovMuRWtNoy
 bgPxSaPQchx/LL1/rhDAlSamqvKfbHLsK08d3e9ysvSxn5gZBkq2nF32xQqJeX8cQKgH
 eoQwh1gexFcSP8Ut1JfqXi5Lsmm16iBFkAe3w7vGaO6AyugqVLsC1WweIJbTLQv1DkSB
 XWeVOnI5TdIHt9txh+ERfBUhuY1rAFVEAIdBHzMXOpFaSIY/zOGY2kymWk/+ZdfBZDUi
 sbGA==
X-Gm-Message-State: ANhLgQ23dZR4QO3YH28CuuajS4PfW7W7+uQUzx+G+o47Fb9qYgIyuPtR
 tUunDaUb0yUpjmdZABm+a/tImw==
X-Google-Smtp-Source: ADFU+vv7TxjPh5K/iMTQDvoIqhsOLvWaB0jr/IrO94OHJ72eIHncksqJWT7V+6oNkXqncOpT5PCLsg==
X-Received: by 2002:a1c:9815:: with SMTP id a21mr154919wme.11.1584379345135;
 Mon, 16 Mar 2020 10:22:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y200sm447043wmc.20.2020.03.16.10.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4EA8E1FF9C;
 Mon, 16 Mar 2020 17:21:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/28] target/i386: use gdb_get_reg helpers
Date: Mon, 16 Mar 2020 17:21:40 +0000
Message-Id: <20200316172155.971-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v7
  - remove stray space
  - fixup the floatx80 set/get routines
---
 target/i386/gdbstub.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 572ead641ca..e4d8cb66c00 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -98,26 +98,22 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
                 return gdb_get_reg64(mem_buf,
                                      env->regs[gpr_map[n]] & 0xffffffffUL);
             } else {
-                memset(mem_buf, 0, sizeof(target_ulong));
-                return sizeof(target_ulong);
+                return gdb_get_regl(mem_buf, 0);
             }
         } else {
             return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
-#ifdef USE_X86LDOUBLE
-        /* FIXME: byteswap float values - after fixing fpregs layout. */
-        memcpy(mem_buf, &env->fpregs[n - IDX_FP_REGS], 10);
-#else
-        memset(mem_buf, 0, 10);
-#endif
-        return 10;
+        floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
+        int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
+        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        return len;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
         if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            stq_p(mem_buf, env->xmm_regs[n].ZMM_Q(0));
-            stq_p(mem_buf + 8, env->xmm_regs[n].ZMM_Q(1));
-            return 16;
+            return gdb_get_reg128(mem_buf,
+                                  env->xmm_regs[n].ZMM_Q(0),
+                                  env->xmm_regs[n].ZMM_Q(1));
         }
     } else {
         switch (n) {
@@ -290,10 +286,9 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
-#ifdef USE_X86LDOUBLE
-        /* FIXME: byteswap float values - after fixing fpregs layout. */
-        memcpy(&env->fpregs[n - IDX_FP_REGS], mem_buf, 10);
-#endif
+        floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
+        fp->low = le64_to_cpu(* (uint64_t *) mem_buf);
+        fp->high = le16_to_cpu(* (uint16_t *) (mem_buf + 8));
         return 10;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-- 
2.20.1


