Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C680AC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7C3206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tVSGFQGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C3206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWLV-0003vR-QZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFR-0002WU-UG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFQ-0000lv-OF
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFQ-0000ko-Hx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id 10so1391999wmp.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYZVLqPYl6pnjsRFn6Oub/1aC6o37OYgX2iWEIUf99Q=;
 b=tVSGFQGaX31gEKO+DBKtac0OsOJXHy5F9emp+Ybh7KcyOCccP6XI03hWvQwr10lPKo
 pQsVJIO2MstEi31kOADGRFYH93/cwz8eyVnmKN+i64KItdrtVR407VNwEmTMDLRkJiFN
 nAZkH/PXXOXzs3AyMmzGTZ1tiiZ4HFdGIzJbAa5DY0CayjaCDBZVRqtchbV9x38onTCJ
 SxvoWZkG61LAbf7dV8DA3JEaKqtc8I3C6TjUbiyYDrjIFNQg2BUjiq/UrCwz/gjCODKn
 5E3XATgfxhWyGmRpyTCK+V67CPkR6Tuiuy3hvZ1g9yUx+x6vF6WAoBUxSAVbQTxu4hbl
 9Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYZVLqPYl6pnjsRFn6Oub/1aC6o37OYgX2iWEIUf99Q=;
 b=JUnx79SpyQfL5peveCkBLOfT/qAHhI/649Tf1NhKQTLKmp5cjRSvv3t1xNfeW+QrW3
 B5fPl7cee87XCtbSDHFRcZStQo8ikbpQ4HjRypI+DMJnCyIoMArLNpgzVRPCVLW8bjW9
 7V5t0HCagZ4NCdt5kmDIjCucBSaJbkFtcGmHG8MRERZi8SBXzY1y3Z/4eUkcVrDJppes
 gEeMizm/SsByZ/MXS0DW1G2RtnUiehHINidWYByBC3Zr4kZXp1fC2LJVom+5LsPsmG59
 BACzyiC9CLlU176fBR3uF/3m/r562dgLYT1T9TRlP+TUvLGPJOttco25101OG/hY8u4Z
 AANA==
X-Gm-Message-State: APjAAAU08wyqwk5h+t4QjAsRi9c3c9f9QAkyguMkertxkpiJaD4X8U2W
 4dO4e0/4daYFyux1GZQ8ptkVcA==
X-Google-Smtp-Source: APXvYqxNskKYKEpjuVsAJI6toWq2madBvPs7y+7mwaX15asHugdbJJh8sA5b9C+wMI1nvKt82krogQ==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr2987418wmh.100.1565700595383; 
 Tue, 13 Aug 2019 05:49:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p7sm1440391wmh.38.2019.08.13.05.49.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E23181FF87;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:44 +0100
Message-Id: <20190813124946.25322-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3 11/13] target/mips: rationalise softfloat
 includes
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, armbru@redhat.com,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should avoid including the whole of softfloat headers in cpu.h and
explicitly include it only where we will be calling softfloat
functions. We can use the -types.h in cpu.h for the few bits that are
global. We also move the restore_snan_bit_mode into internal.h and
include -helpers.h there.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
v2
  - move restore_snan_bit_mode to internal.h
---
 linux-user/mips/cpu_loop.c | 1 +
 target/mips/cpu.h          | 8 +-------
 target/mips/internal.h     | 7 +++++++
 target/mips/msa_helper.c   | 1 +
 target/mips/op_helper.c    | 1 +
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 0ba894fa7aa..39915b3fde2 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "cpu_loop-common.h"
 #include "elf.h"
+#include "internal.h"
 
 # ifdef TARGET_ABI_MIPSO32
 #  define MIPS_SYS(name, args) args,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 21c0615e020..d235117dab3 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -5,7 +5,7 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 #include "mips-defs.h"
 
 #define TCG_GUEST_DEFAULT_MO (0)
@@ -1195,12 +1195,6 @@ void itc_reconfigure(struct MIPSITUState *tag);
 /* helper.c */
 target_ulong exception_resume_pc(CPUMIPSState *env);
 
-static inline void restore_snan_bit_mode(CPUMIPSState *env)
-{
-    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0,
-                        &env->active_fpu.fp_status);
-}
-
 static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
diff --git a/target/mips/internal.h b/target/mips/internal.h
index b2b41a51ab4..49a7a7d8f56 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -7,6 +7,7 @@
 #ifndef MIPS_INTERNAL_H
 #define MIPS_INTERNAL_H
 
+#include "fpu/softfloat-helpers.h"
 
 /* MMU types, the first four entries have the same layout as the
    CP0C0_MT field.  */
@@ -226,6 +227,12 @@ static inline void restore_flush_mode(CPUMIPSState *env)
                       &env->active_fpu.fp_status);
 }
 
+static inline void restore_snan_bit_mode(CPUMIPSState *env)
+{
+    set_snan_bit_is_one((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) == 0,
+                        &env->active_fpu.fp_status);
+}
+
 static inline void restore_fp_status(CPUMIPSState *env)
 {
     restore_rounding_mode(env);
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a5a86572b4a..f24061e2af7 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 /* Data format min and max values */
 #define DF_BITS(df) (1 << ((df) + 3))
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9e2e02f8586..f88a3ab9043 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "sysemu/kvm.h"
+#include "fpu/softfloat.h"
 
 /*****************************************************************************/
 /* Exceptions processing helpers */
-- 
2.20.1


