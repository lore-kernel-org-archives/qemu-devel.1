Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C977AC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F543217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plFeN00E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F543217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIth-0002kn-T8
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl7-0006RM-MT
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl6-0004Uy-MP
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl6-0004Ug-I3
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so134537806otq.6
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q6DnEc89TW6Qa3yBPyPdGyYM9ThqGiR5er7hiKTRvYk=;
 b=plFeN00E7BakXWolWbIbmFul1Y1cUzH3nLVldl4Gv0GC7IuTBExcxA+rkUXuK0BQU/
 Q2R/n0EZ1J7NvicGbAid0tZWAM3gSku0OJ8ich3L+ULRUquZAS6ZXv7A/xPIXErkAI1v
 8vFWZ9IbG7PCP54WBpw8807b5gixtV292IwKggMHSpV4H8o0uKJB8m9dw6L1vfMl1UIV
 5yMojFhjbCSkZsVe/v6cDqFLRrgdnWjQqKWKnInMLRsQXvcxKOGBKBO5c9s39ZwJQjzl
 sI4Pq6YaKEvEhk899YiXjGR7eEuSJTj288qx3opuho9TG/9oSKlZQnGr+VLhWbIOCHsL
 32Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q6DnEc89TW6Qa3yBPyPdGyYM9ThqGiR5er7hiKTRvYk=;
 b=qPX5rzqHASbolvGJw1J2rrt+6oZ6r1Qef+GBSCN6QiKgPToo1S8GZGML++IuBCF6aL
 bTe0ULqu7w9EiqSJIoNc79b/+GX9ti4QiefaktDkzXLaB6oECaHFK1aqHTq/hc+bcG3y
 oY80ff6UQVCGuYpyLdHYGxXSydoO8AnWneObIo0isCUDGJYmhBBUAnP9EOTrN1jVSu6d
 8L6/nNcGlhuuTI70u0bZno3MunrnU0jq7kyM86fQRQAaIWqAO7ojODMeKev+erpmPgdG
 /+ZskyeZCSRAtchYpa6FaI7QdgIGhUWcoHrJlS0/RWEnIbmW0NtCWm382vbxVI7Bhnfi
 H46A==
X-Gm-Message-State: APjAAAVjcJu5zhF9yVOjOBhiiYf0HsUbjPsQUNavONHUUdeSQCu92sCO
 1GB7wpefvBuBdnHNM/I7OkjkIz67
X-Google-Smtp-Source: APXvYqyhIVoyEwW7HIbJu7Tv+YhEtve77qAsqPI+JK3qhNMPlrsQKiHKkz3JTi/ISyLnm9OIYSz/tQ==
X-Received: by 2002:aca:420b:: with SMTP id p11mr7863554oia.124.1565410415791; 
 Fri, 09 Aug 2019 21:13:35 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:35 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:45 -0400
Message-Id: <20190810041255.6820-30-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RFC PATCH v2 29/39] target/i386: introduce
 helper-based code generator macros
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

Code generators defined using these macros rely on a helper function
(as emitted by gen_helper_*).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 19b92d61f6..d721bb5142 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4856,6 +4856,32 @@ INSNOP_LDST_UNIFY(Qq, Nq, NqMq)
 #define gen_insn_wrrr(mnem, opW1, opR1, opR2, opR3)     \
     gen_ ## mnem ## _ ## opW1 ## opR1 ## opR2 ## opR3
 
+#define GEN_INSN_HELPER(mnem, helper)           \
+    static void gen_insn(mnem)(                 \
+        CPUX86State *env, DisasContext *s)      \
+    {                                           \
+        gen_helper_ ## helper(cpu_env);         \
+    }
+#define GEN_INSN_WR_HELPER(mnem, helper, opW1, opR1)            \
+    static void gen_insn_wr(mnem, opW1, opR1)(                  \
+        CPUX86State *env, DisasContext *s, insnop_t(opW1) ret,  \
+        insnop_t(opR1) arg1)                                    \
+    {                                                           \
+        tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);                \
+        tcg_gen_addi_ptr(s->ptr1, cpu_env, arg1);               \
+        gen_helper_ ## helper(cpu_env, s->ptr0, s->ptr1);       \
+    }
+#define GEN_INSN_WRR_HELPER(mnem, helper, opW1, opR1, opR2)     \
+    static void gen_insn_wrr(mnem, opW1, opR1, opR2)(           \
+        CPUX86State *env, DisasContext *s, insnop_t(opW1) ret,  \
+        insnop_t(opR1) arg1, insnop_t(opR2) arg2)               \
+    {                                                           \
+        assert(ret == arg1);                                    \
+        tcg_gen_addi_ptr(s->ptr0, cpu_env, ret);                \
+        tcg_gen_addi_ptr(s->ptr1, cpu_env, arg2);               \
+        gen_helper_ ## helper(cpu_env, s->ptr0, s->ptr1);       \
+    }
+
 /*
  * Instruction translators
  */
-- 
2.20.1


