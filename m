Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13301C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF336206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDyVX+eG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF336206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORzz-0005ta-2f
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyi-00040S-Lm
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORyh-0001iV-BM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORyh-0001hw-4e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:16:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id a81so15773847wmf.5
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U0GHkMxjV1uSRYh2+mG4n9m1cHTJmvyky0OeonmCsaU=;
 b=zDyVX+eGLidywceNh4TJT/ZYZU5Sl8GDbcntFEUGG5+KT3G5Rp02Ky9cQbxUpfbefN
 MQq8fa1MP/TzuzOq3BesyNCGzQIhS1w01JPNnmjJZ/gaYLiYfTrDiDdrK0zEwNjNzbKb
 UWLiqqrX9WVcYop2mp08FcL3LqKt04r69IWfcx+5UyhTWHbU1PSdLKNBg5cV58rW5N6B
 lZiInQtKv7errpITUoT5XmBZwzKMx+hVVn1pQMCzYjD4ephmZUvxx6tTy6ZBbWWA/d+b
 GyB3HSD+M4CHp9CyN9p5hIUpNRTjp1d5mBC63geazmVR/BvS0Vb+v3pJh4yHWRKz4Air
 nnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U0GHkMxjV1uSRYh2+mG4n9m1cHTJmvyky0OeonmCsaU=;
 b=UYOR36MEIJvFMh20UINTjdzggLfCzNc2Z+7P7gpyrfkB03o7TevlTjbID1KSEgkzjE
 IVbN+7bGd4OadXLRmshO4IT5YS464YwoG5FiMQdWzVxYulI6sNJBP3psOg8YWQ4H/HhW
 JPIykLsLoAssmttOwsYMAFipNRdn5twRct2nq24wlhBlOgzVxM+998PQraQshT5Pi0gw
 QCNnVd4rCqoTQLnIYzhX2PXhuAVU88nv1N2kDif+SVZFQSd0Q7P3MJtg00gcytR0jsKI
 prxI6NmbyK9ZkvFMym07DPlFdPxwA6Q5RYIwm7XbSUxp3lc369NLq4WNGYR64hREL5Wk
 88Pg==
X-Gm-Message-State: AGi0PubOnOG75oH9iKQRsIGqzOTCZabA10n2/VgFgC9EdhllundIqlkI
 +fVcvg21OK3SQ4FrBEBmnhdoYs64EUA=
X-Google-Smtp-Source: APiQypKU7B+SAR0tD9up2nLR7I6A6sBWx864DeYzBvGVPvRy0iyNS2uU9KguBdQT8LI6gu1pgz73JQ==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr1587510wmd.131.1586895374113; 
 Tue, 14 Apr 2020 13:16:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm5778068wrk.56.2020.04.14.13.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:16:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09FA11FF9D;
 Tue, 14 Apr 2020 21:06:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/17] target/m68k: hack around the FPU register support
 (HACK!)
Date: Tue, 14 Apr 2020 21:06:29 +0100
Message-Id: <20200414200631.12799-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Attempting to attach to the gdbstub causes GDB to complain:

  warning: Register "fp0" has an unsupported size (80 bits)
  warning: Register "fp1" has an unsupported size (80 bits)
  warning: Register "fp2" has an unsupported size (80 bits)
  warning: Register "fp3" has an unsupported size (80 bits)
  warning: Register "fp4" has an unsupported size (80 bits)
  warning: Register "fp5" has an unsupported size (80 bits)
  warning: Register "fp6" has an unsupported size (80 bits)
  warning: Register "fp7" has an unsupported size (80 bits)
  Remote 'g' packet reply is too long (expected 148 bytes, got 164 bytes): 000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000$
  00000000000000000000408009f000000000800003407fffffffffffffffffff7fffffffffffffffffff7fffffffffffffffffff7fffffffffffffffffff7fffffffffffffffffff7fffffffffffffffffff7fffffff$
  fffffffffff7fffffffffffffffffff000000000000000000000000

and then subsequently fail. The root problem seems to be this is an
undefined size register for the target description. There does exist a
floatformats_m68881_ext in GDB but setting "m68881_ext" also fails as
the only "weird" tdesc types gdb seems to understand are:

  { "arm_fpa_ext", TDESC_TYPE_ARM_FPA_EXT },
  { "i387_ext", TDESC_TYPE_I387_EXT }

So present the register as a i386_ext as some sort of hack. The values
are garbage but at least we can continue to connect. Perhaps we should
just delete the code because I don't think this ever worked with
upstream tools.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.c | 11 +++++------
 gdb-xml/m68k-fp.xml  | 16 ++++++++--------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 79b0b10ea9b..80069adb8cc 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -109,9 +109,8 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
-        int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len += gdb_get_reg16(mem_buf, 0);
-        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
+        int len = gdb_get_reg64(mem_buf, cpu_to_le64(env->fregs[n].l.lower));
+        len += gdb_get_reg16(mem_buf, cpu_to_le16(env->fregs[n].l.upper));
         return len;
     }
     switch (n) {
@@ -128,9 +127,9 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
 {
     if (n < 8) {
-        env->fregs[n].l.upper = lduw_be_p(mem_buf);
-        env->fregs[n].l.lower = ldq_be_p(mem_buf + 4);
-        return 12;
+        env->fregs[n].l.lower = le64_to_cpu(* (uint64_t *) mem_buf);
+        env->fregs[n].l.upper = le16_to_cpu(* (uint16_t *) (mem_buf + 8));
+        return 10;
     }
     switch (n) {
     case 8: /* fpcontrol */
diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
index 64290d16306..8eb55af2860 100644
--- a/gdb-xml/m68k-fp.xml
+++ b/gdb-xml/m68k-fp.xml
@@ -6,14 +6,14 @@
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.coldfire.fp">
-  <reg name="fp0" bitsize="96" type="float" group="float"/>
-  <reg name="fp1" bitsize="96" type="float" group="float"/>
-  <reg name="fp2" bitsize="96" type="float" group="float"/>
-  <reg name="fp3" bitsize="96" type="float" group="float"/>
-  <reg name="fp4" bitsize="96" type="float" group="float"/>
-  <reg name="fp5" bitsize="96" type="float" group="float"/>
-  <reg name="fp6" bitsize="96" type="float" group="float"/>
-  <reg name="fp7" bitsize="96" type="float" group="float"/>
+  <reg name="fp0" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp1" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp2" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp3" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp4" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp5" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp6" bitsize="80" type="i387_ext" group="float"/>
+  <reg name="fp7" bitsize="80" type="i387_ext" group="float"/>
 
   <reg name="fpcontrol" bitsize="32" group="float"/>
   <reg name="fpstatus" bitsize="32" group="float"/>,
-- 
2.20.1


