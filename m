Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F068C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E215F20735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7v3m7Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E215F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGay-0004Is-12
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN9-0000uq-No
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGN7-0003uw-MM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:23 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46439)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGN7-0003pr-Dw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id w16so10474003wrv.13
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0LurhQOzs6U/ZvFoMmo+r48W1bsv6y+gXlCttu3J7Bc=;
 b=o7v3m7EsuzvyFIhhKoiL7J5MWwwfNigJd9ZkrUa3i3U/OkXXHVz5zu4lyebHyhWQ0X
 MthBOq8RAWwGnTG8CkW6lLLIYNc90rPwF8xK/QG8r2av8HTem3NODdT+mtz3pg4/mrER
 TdyD/Xyhnt4Aj1MvWXNkt0lC65IjodvZ2+kDeHjmVk2MXwpSI7CEMyp6mK8ftyewHa1D
 RsjeaN6EGAQ9sE7HxETNRhrojGqSj3M3vYxY79FRSmaavwcuN92PIHPOlMAIaCBq7axX
 xNiMRhUsfm1hHVPRSfY74RyCtSMnEqY0UR19eMv3iS5TFrHJMLEDYv+RO+SbwIgauGm9
 6LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0LurhQOzs6U/ZvFoMmo+r48W1bsv6y+gXlCttu3J7Bc=;
 b=ip+GU7YqwmNnFn34bhHhwdpuCpixQ7ZDDcp8DAyRapju6gWs+p3ee1T8o3fLj/Spf6
 4uDIh3IRcIcNuMZNKXiWUl2TC/K8JorYPpEjFIjlYHgXa2+SxI6O9vEhpjCPVLPvnzDb
 b3Bctsx4AWuuQy2/P9LyTXhuxYmSTk5sYHMVR9swHtSNxp7VLDgntD48qr/6Y8btRF6p
 5papU8bb+IAaMtMUYdxu3m815o/MpBImfruLGbntsb7AM6s2BhPybO3ANv9hBVYqJIpL
 TLBlccXLyD3RvC/zwqx3mDHnqrj0Sk1aMUHqXDsnQwxvIqFtFnQhQC5Bv3iL+YhnMd0R
 qj7w==
X-Gm-Message-State: ANhLgQ2ZjmsIUUxR3QKuBdfAPipotMyBBELFxhQ1OqkHYp/M511yZlqs
 ciP/Y7Gy0SaGufzCLdCkSYnDfFqWPp0=
X-Google-Smtp-Source: ADFU+vueLJQy18AyAHNoaJ0z7uNFr7uDowuXiLc9flmNFVtRB8CugmoO+4QmkvviP0PBVTGgDb51Dw==
X-Received: by 2002:adf:f510:: with SMTP id q16mr149860wro.43.1584467480343;
 Tue, 17 Mar 2020 10:51:20 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t22sm921219wra.27.2020.03.17.10.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:51:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FED61FF9C;
 Tue, 17 Mar 2020 17:50:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/28] target/i386: use gdb_get_reg helpers
Date: Tue, 17 Mar 2020 17:50:38 +0000
Message-Id: <20200317175053.5278-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200316172155.971-14-alex.bennee@linaro.org>

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


