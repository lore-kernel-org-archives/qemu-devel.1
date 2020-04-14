Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC9C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83BC12076A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 20:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgfGVdkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83BC12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38603 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORzh-000591-IQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 16:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpf-0006Eu-4b
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jORpe-000627-3a
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:44212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jORpd-00060K-Rk
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 16:06:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id d17so9089172wrg.11
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y41oariPSirC8NfMhDAA8Vm62k5I1+y4ZRfI3cHl76k=;
 b=YgfGVdkf//l7U+mJ+B5Z6iAPJUBTw6O2mNuPpXLZEA29xfYTZ+OcqUyigRwqEXLUAD
 YZRUmM9/fbl1DhPgfD+pYoX7x0TErvieLRGlVhJtOtj9HAmu7lDtILdp9Fh907bqD2wT
 11VaE4LcsxutGRAEp38Z1BooO4y9oky49ENLw8OuIaGPtwYdyCqGFVjXlIlsvvKCC/EG
 jHUZOTe1KPGA/3Z932uOpZ+wYNScmq40cDeIc5wBo/Q6fEE0gfzXhbV6+PSOdUD99p40
 E7fi9Yf5NwHkZs7TpneG5q6UWNuJKxSrounIi5KfAkhNMjC2xhJsVpNoLftZjJJZ5SJI
 jyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y41oariPSirC8NfMhDAA8Vm62k5I1+y4ZRfI3cHl76k=;
 b=hnTnRle6ADKvp5C5X+bDM3Lt3xBH99pv/vyEjLeWE9nBDFozrhD9tTv8oIhKeSVj5T
 a1RljSqVEeELlY8gFwUJ/6wxQQmNh1GOyEbCbgXRzHQkM7DeV/2oFL6eZeJ1TtrMtM8O
 VqEXP/zPijHQO52u1xeb3FDzaOaCheCeGHHtei31QpbUQmoAal1C9JPuPyDOihPIQaUu
 kCVSC6GJBFQ0TmvO1JF+FlBUyQOMC0HXW1gOOJfNxuN1HDyB78NLARlDlTgZNo6gxOiL
 2bDlu8ZvHfUNgtUAAIa/9ipIhfX0RH4fZ7XAABqjm9TXLIJh9pBQzls2vF4mgawJpk43
 6MtA==
X-Gm-Message-State: AGi0PuZtOMiEliouCXdHYd8QykeL0YalrB1L9ExRcLaPZfJD0tO9ebGZ
 K+DZ0JTiDPkVbg3uSMnP80hEZQ==
X-Google-Smtp-Source: APiQypLBaw01LLop1TDT5c0qnMI0OJY0cAm90MBqKOcrEawitZ0lNg8aHw82UCgVTA5KyTRke0m5XA==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr24248547wrs.333.1586894811402; 
 Tue, 14 Apr 2020 13:06:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm13394364wmt.15.2020.04.14.13.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 13:06:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AF3781FF7E;
 Tue, 14 Apr 2020 21:06:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/17] gdbstub: Introduce gdb_get_float32() to get 32-bit
 float registers
Date: Tue, 14 Apr 2020 21:06:27 +0100
Message-Id: <20200414200631.12799-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
References: <20200414200631.12799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since we now use a GByteArray, we can not use stfl_p() directly.
Introduce the gdb_get_float32() helper to load a float32 register.

Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200414163853.12164-2-philmd@redhat.com>
---
 include/exec/gdbstub.h | 9 +++++++++
 target/sh4/gdbstub.c   | 6 ++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 3c452fc50c0..20e10726929 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -125,6 +125,15 @@ static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
     return 16;
 }
 
+static inline int gdb_get_float32(GByteArray *array, float32 val)
+{
+    uint8_t buf[sizeof(CPU_FloatU)];
+
+    stfl_p(buf, val);
+    g_byte_array_append(array, buf, sizeof(buf));
+
+    return sizeof(buf);
+}
 static inline int gdb_get_zeroes(GByteArray *array, size_t len)
 {
     guint oldlen = array->len;
diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
index 49fc4a0cc69..34ad3ca0508 100644
--- a/target/sh4/gdbstub.c
+++ b/target/sh4/gdbstub.c
@@ -58,11 +58,9 @@ int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->fpscr);
     case 25 ... 40:
         if (env->fpscr & FPSCR_FR) {
-            stfl_p(mem_buf, env->fregs[n - 9]);
-        } else {
-            stfl_p(mem_buf, env->fregs[n - 25]);
+            return gdb_get_float32(mem_buf, env->fregs[n - 9]);
         }
-        return 4;
+        return gdb_get_float32(mem_buf, env->fregs[n - 25]);
     case 41:
         return gdb_get_regl(mem_buf, env->ssr);
     case 42:
-- 
2.20.1


