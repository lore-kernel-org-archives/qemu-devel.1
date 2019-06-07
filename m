Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B3CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6927E20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbG7yfs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6927E20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZBe3-0006NS-NA
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvV-0002HY-Pn
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAvQ-0004zz-WD
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAvQ-0004lF-Lt
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:12:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id r18so1351564wrm.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R7hQv/k6BU4/ZnGK1cbG5kk+E/CvNF37llrzUvfKDoc=;
 b=XbG7yfs0OkAkZF/+fRCikzBlFe1VRQRbKYo/xU+YesBY5mjZ+F5kS/AhoAKAQEUHr7
 Sk9WfUbnXZpw0nYSruYTH+gtHuQs/3AwRxakncQY17Wat2GGtry6DFJnY9wfa55JlyDb
 BdGi2E4TQICaEH/4mdzjoiRMLRXuEb7ZmLolAJhKIfzuSWEowkY/rRoq0VfmeSiblyP3
 jS3jVvzQfTEqybNstzARnTAwkUjaqwAN67nmlsV7LVt0lOBfwIuKSBS/wSWIzYEs6zCd
 G+HNU0xjhwGP8ucLHAWiTuWfTrryGP6PAqOl1dxaQwMuOgsg6FIYo7WJzP2nj4kzjKUh
 aEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7hQv/k6BU4/ZnGK1cbG5kk+E/CvNF37llrzUvfKDoc=;
 b=bL1etqZMgE58MwjV9X4IQP+3UpuHVpwBAiOKAqUmbBzgwTQY2T4+k/dJRwwiIAHJIR
 Z5/sP8KJMAp+tGkfsHccRaRMhbiH2hlY7lqkV9XTk4cl7Imq9zu1O6R+3e5y+6Osgzai
 Dp3jdNnZ3SqUd5wUQ2AVyjMoCDPJUQqoW9WDP9bjH5YJUGCUv/RgfUhKyK5ET8KFYj8Y
 nfmCjUMJIfiFFms+FK6jYMIVnYaBoLwhbx/LKbwt2GkUdO7ZghjWc2oWT6xhpki+HgU7
 djQ3lbUuIF5gcPwACqaL7PUV1meQ4IWMs+4OP38l1BbdxbFZ27ORuwc8hEewmirplXG/
 wenw==
X-Gm-Message-State: APjAAAW0isrZUUmast92Ur4hn39ilRZBBSULbV1r4d0rcX4zLT36kLii
 6+EkusbTS/YX5vruKqJtFfTXbw==
X-Google-Smtp-Source: APXvYqzql7i3XnQU1dE6IOqwKLd500ddLu5D21U8yg/n4PKdbsChfOZ/Xatfg9V1bCgszkUnpBId4w==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr3506792wrv.268.1559898753629; 
 Fri, 07 Jun 2019 02:12:33 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b2sm1567719wrp.72.2019.06.07.02.12.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:12:30 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EC991FFAF;
 Fri,  7 Jun 2019 10:05:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:25 +0100
Message-Id: <20190607090552.12434-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL 26/52] semihosting: split console_out into
 string and char versions
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM" <qemu-arm@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is ostensibly to avoid the weirdness of len looking like it might
come from a guest and sometimes being used. While we are at it fix up
the error checking for the arm-linux-user implementation of the API
which got flagged up by Coverity (CID 1401700).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 466ea6dade..4a5758972d 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -36,26 +36,24 @@ int qemu_semihosting_log_out(const char *s, int len)
 /*
  * A re-implementation of lock_user_string that we can use locally
  * instead of relying on softmmu-semi. Hopefully we can deprecate that
- * in time. We either copy len bytes if specified or until we find a NULL.
+ * in time. Copy string until we find a 0 or address error.
  */
-static GString *copy_user_string(CPUArchState *env, target_ulong addr, int len)
+static GString *copy_user_string(CPUArchState *env, target_ulong addr)
 {
     CPUState *cpu = ENV_GET_CPU(env);
-    GString *s = g_string_sized_new(len ? len : 128);
+    GString *s = g_string_sized_new(128);
     uint8_t c;
-    bool done;
 
     do {
         if (cpu_memory_rw_debug(cpu, addr++, &c, 1, 0) == 0) {
             s = g_string_append_c(s, c);
-            done = len ? s->len == len : c == 0;
         } else {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: passed inaccessible address " TARGET_FMT_lx,
                           __func__, addr);
-            done = true;
+            break;
         }
-    } while (!done);
+    } while (c!=0);
 
     return s;
 }
@@ -68,9 +66,9 @@ static void semihosting_cb(CPUState *cs, target_ulong ret, target_ulong err)
     }
 }
 
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
 {
-    GString *s = copy_user_string(env, addr, len);
+    GString *s = copy_user_string(env, addr);
     int out = s->len;
 
     if (use_gdb_syscalls()) {
@@ -82,3 +80,21 @@ int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
     g_string_free(s, true);
     return out;
 }
+
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
+{
+    CPUState *cpu = ENV_GET_CPU(env);
+    uint8_t c;
+
+    if (cpu_memory_rw_debug(cpu, addr, &c, 1, 0) == 0) {
+        if (use_gdb_syscalls()) {
+            gdb_do_syscall(semihosting_cb, "write,2,%x,%x", addr, 1);
+        } else {
+            qemu_semihosting_log_out((const char *) &c, 1);
+        }
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: passed inaccessible address " TARGET_FMT_lx,
+                      __func__, addr);
+    }
+}
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/console.h
index 30e66ae20a..3a4fba7590 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -10,17 +10,30 @@
 #define _SEMIHOST_CONSOLE_H_
 
 /**
- * qemu_semihosting_console_out:
+ * qemu_semihosting_console_outs:
  * @env: CPUArchState
- * @s: host address of guest string
- * @len: length of string or 0 (string is null terminated)
+ * @s: host address of null terminated guest string
  *
- * Send a guest string to the debug console. This may be the remote
- * gdb session if a softmmu guest is currently being debugged.
+ * Send a null terminated guest string to the debug console. This may
+ * be the remote gdb session if a softmmu guest is currently being
+ * debugged.
  *
  * Returns: number of bytes written.
  */
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong s, int len);
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong s);
+
+/**
+ * qemu_semihosting_console_outc:
+ * @env: CPUArchState
+ * @s: host address of null terminated guest string
+ *
+ * Send single character from guest memory to the debug console. This
+ * may be the remote gdb session if a softmmu guest is currently being
+ * debugged.
+ *
+ * Returns: nothing
+ */
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong c);
 
 /**
  * qemu_semihosting_log_out:
diff --git a/linux-user/arm/semihost.c b/linux-user/arm/semihost.c
index 9554102a85..a16b525eec 100644
--- a/linux-user/arm/semihost.c
+++ b/linux-user/arm/semihost.c
@@ -15,10 +15,35 @@
 #include "hw/semihosting/console.h"
 #include "qemu.h"
 
-int qemu_semihosting_console_out(CPUArchState *env, target_ulong addr, int len)
+int qemu_semihosting_console_outs(CPUArchState *env, target_ulong addr)
 {
-    void *s = lock_user_string(addr);
-    len = write(STDERR_FILENO, s, len ? len : strlen(s));
+    int len = target_strlen(addr);
+    void *s;
+    if (len < 0){
+       qemu_log_mask(LOG_GUEST_ERROR,
+                     "%s: passed inaccessible address " TARGET_FMT_lx,
+                     __func__, addr);
+       return 0;
+    }
+    s = lock_user(VERIFY_READ, addr, (long)(len + 1), 1);
+    g_assert(s);  /* target_strlen has already verified this will work */
+    len = write(STDERR_FILENO, s, len);
     unlock_user(s, addr, 0);
     return len;
 }
+
+void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
+{
+    char c;
+
+    if (get_user_u8(c, addr)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: passed inaccessible address " TARGET_FMT_lx,
+                      __func__, addr);
+    } else {
+        if (write(STDERR_FILENO, &c, 1) != 1) {
+            qemu_log_mask(LOG_UNIMP, "%s: unexpected write to stdout failure",
+                          __func__);
+        }
+    }
+}
diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 53e807ab72..8844da8da3 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -315,10 +315,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return set_swi_errno(ts, close(arg0));
         }
     case TARGET_SYS_WRITEC:
-        qemu_semihosting_console_out(env, args, 1);
+        qemu_semihosting_console_outc(env, args);
         return 0xdeadbeef;
     case TARGET_SYS_WRITE0:
-        return qemu_semihosting_console_out(env, args, 0);
+        return qemu_semihosting_console_outs(env, args);
     case TARGET_SYS_WRITE:
         GET_ARG(0);
         GET_ARG(1);
-- 
2.20.1


