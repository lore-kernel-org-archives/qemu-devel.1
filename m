Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF6C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46FD62086C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8c3a5kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhIa-0007TX-Dm
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbI-0003AT-BZ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-0007Gu-Ff
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-0007Ag-77
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id z11so8491379wrt.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/WEOVn0E5tlWU6uEHoRqS8TQRZlLAWac8kcBhgCdsZk=;
 b=B8c3a5kbjbqkLP2XZlBMvvRodD5gN8mbbCYAC5d6zt3JliBuv8WtrRzqlIp0aUdC0G
 pbJNh5ucGvBFl/An1KLh19PbmuajSb8PNyYKusfuiPoRZRNhSnHtPM+AW++se5l34avC
 ry/YACT43GRwqx3upNS2o3rIPpqmbX0fxd1UAuBvwTOPecdJ8LzxnBykx0CS7EBSIu1U
 VN0E4GuMlMqCiUrgmZYsw4s+0B4Xpp0JvB8Dm+qTJ4NHKUc/l+l72/1p1VV/v+XYLc4l
 3xkOSPOo403+awbGy4n+Bhaq2T/qZP2LQ6r7T91O1TI02yVa37XgT+icMgjI2vKbphFD
 NdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/WEOVn0E5tlWU6uEHoRqS8TQRZlLAWac8kcBhgCdsZk=;
 b=KooPeGja8SjaHYoXaQoCXbxDl6ejT4XY9vWuln4GZhEVyGiBh9b2wjCuNRc/PAzaDs
 GfuDOt0dTVONvOdDGMt3nT1JY7HPaaONuRwW8SWdW8dqnHiVYLo6KOGNjgvMCN+He0Sp
 0jDzn9VKoPEwAXp0GZ+qrQPCKvRU5obOwRMxI1dlTdMnefyBZWvxk7kgLJXrLm2g0uBo
 eEfK2VIXMittqP5LSOyAvHD9HIEzEP56yFkNOdo3QAUXsj/A20ydZ0tDW1CCL2VhxgqB
 xvpy4AxiOS47slhIMejRB1lzRQxRDym5b0OJaBskMoTD6iBUAz6AKY4meG1x2gpgc2Mv
 fJ4w==
X-Gm-Message-State: APjAAAVN0yzgJ3bc1oKYMY1gML+0nwLznh9hxloWIqjoHG6Rj2RIkuV7
 LORcOfeQ/8y2yDyeui+u1IlbhA==
X-Google-Smtp-Source: APXvYqzjEAW8M9B4DX1HYHzN9eQJ+LOLsrZq/sS9iKKVnmGE94vE4ygizIAnPSD8/QG25SeLuG3VbQ==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr14221669wrp.150.1566217037538; 
 Mon, 19 Aug 2019 05:17:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k9sm12142532wrq.15.2019.08.19.05.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:15 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C604D1FF9A;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:07 +0100
Message-Id: <20190819121709.31597-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 10/12] target/mips: rationalise softfloat
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
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
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
index d5aa5490d3c..ae29b578a47 100644
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


