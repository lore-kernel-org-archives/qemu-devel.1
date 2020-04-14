Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81989C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA12206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHCviFKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA12206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOS5g-0004Af-GP
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyj-00042g-IN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyi-0001jM-Bh
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORyi-0001ik-4v
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id o81so8958236wmo.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3UWknvv+wdPtsXv26OjYUAVxV8/wuy9nynu7HohmC0w=;
 b=PHCviFKd1hV0AsvNdCAwXWgDWrWM8XIaHkCpvzTa5wp7ih6mgcaiHoPqewJfOuTfZ6
 hEaLhALhRKBTz7k7/fUtV0M9spzMOFsZX7Z99FZqjk8MXz2BLEmlxXsiOkG4zZ92PE19
 9BAnhPz+Gl7JQzcvpN+L130pii2DI3n+650ZBJuQNs0c5NMh27xx+NyFyRHqjbF3qCqT
 dPESQiY4+5DSxxYXxrz20457bN+wmGMFLTCMv+jIKc9uB61Xb5bGHrZXcnMv0ULw9Oir
 7yH/LpSYiVNr/Inl2leKT6137CRB9VSP2HmXOylEpsDwyN1IONMI8MNRPtjw4/OWGf5Z
 bapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3UWknvv+wdPtsXv26OjYUAVxV8/wuy9nynu7HohmC0w=;
 b=rlxYTXdqmNucbYGxyvVouLUaLkNC1LSeG4MNGTg+EdrBzGhZp78JmSGq4W++wJoUSr
 jQ2bLQdl3z1oFfNJWIvmgMQTES3K0Ez9X0+QKeDqvle0orn1he3FTZST/o6SS5qLwU6+
 QDTCPNLW0834cbXY0rRUeOgh6dh2GpCWaHT23f/x8tRzqXEID+91BywMLir+lSm2v0ZX
 WBEJELo3PWotsnkZ65zmS5zCEXzbZD2hQHgaZy6CkdMBLWloCjThfY4OHxSKOdu7a3rJ
 yyjXo8uurfIPczzNnzDlYE239hGKYib59FYR+ACpN/zUS8P7LmaVBZ6IDogfbp4+7ob9
 SLUg==
X-Gm-Message-State: AGi0PuZWmzedRMOVpYLDD8Iv0+7dZfrWOoqgeX+nFlZwtvK7Bc1oIzKa
 qISV3eU9qkVpvn6DrfV6fQra5w==
X-Google-Smtp-Source: APiQypKds5eoCFqOquXQCPI4q19JvTqtESrBQKB4hPpDuygqNFQggIaDC33aw78B+WQpHaQZl1WX/g==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr1627424wml.112.1586895375103; 
 Tue, 14 Apr 2020 13:16:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i17sm20105226wml.23.2020.04.14.13.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:16:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DACC01FF9C;
 Tue, 14 Apr 2020 21:06:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] gdbstub: Introduce gdb_get_float64() to get 64-bit
 float registers
Date: Tue, 14 Apr 2020 21:06:28 +0100
Message-Id: <20200414200631.12799-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When converted to use GByteArray in commits 462474d760c and
a010bdbe719, the call to stfq_p() was removed. This call
serialize a float.
Since we now use a GByteArray, we can not use stfq_p() directly.
Introduce the gdb_get_float64() helper to load a float64 register.

Fixes: 462474d760c ("target/m68k: use gdb_get_reg helpers")
Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200414163853.12164-3-philmd@redhat.com>
---
 include/exec/gdbstub.h          | 11 +++++++++++
 target/m68k/helper.c            |  3 ++-
 target/ppc/gdbstub.c            |  4 ++--
 target/ppc/translate_init.inc.c |  2 +-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 20e10726929..4a2b8e30893 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -134,6 +134,17 @@ static inline int gdb_get_float32(GByteArray *array, float32 val)
 
     return sizeof(buf);
 }
+
+static inline int gdb_get_float64(GByteArray *array, float64 val)
+{
+    uint8_t buf[sizeof(CPU_DoubleU)];
+
+    stfq_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
+
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     guint oldlen = array->len;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index cad40838956..79b0b10ea9b 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -72,7 +72,8 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         float_status s;
-        return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
+        return gdb_get_float64(mem_buf,
+                               floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
     case 8: /* fpcontrol */
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index eb362dd9aec..5c11c88b2a8 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -130,7 +130,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
         gdb_get_regl(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else {
         switch (n) {
         case 64:
@@ -184,7 +184,7 @@ int ppc_cpu_gdb_read_register_apple(CPUState *cs, GByteArray *buf, int n)
         gdb_get_reg64(buf, env->gpr[n]);
     } else if (n < 64) {
         /* fprs */
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n - 32));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n - 32));
     } else if (n < 96) {
         /* Altivec */
         gdb_get_reg64(buf, n - 64);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index e853164a865..d825cb59758 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9881,7 +9881,7 @@ static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
 {
     uint8_t *mem_buf;
     if (n < 32) {
-        gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
+        gdb_get_float64(buf, *cpu_fpr_ptr(env, n));
         mem_buf = gdb_get_reg_ptr(buf, 8);
         ppc_maybe_bswap_register(env, mem_buf, 8);
         return 8;
-- 
2.20.1


