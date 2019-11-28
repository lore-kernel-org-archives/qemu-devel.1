Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409C2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089CE2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xk19NKkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089CE2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRk4-00077J-5A
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPpR-0005iK-NP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaPk0-0005Dh-J0
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaPjz-00050w-AD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 14:46:15 -0500
Received: by mail-wm1-x343.google.com with SMTP id s14so5983685wmh.4
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MNn7wi779g5wDhZisTPTovBof5tUb05aT8JmY/Sn4ZM=;
 b=Xk19NKkJuv3ddzTRqZvOv6E+lh6JikLWMvvdvU2iUdCCS1BT4SPGudnI9KaiktsVE9
 NCp8jG7Yo7tdnd5Q9WjhlS4SRw5byo8p/mWuoYeymXyo2uTdwi88hWSx2zj+28uWdXHg
 Low/RnLOYJ0kWZNbQQQnh9w9v0xaoNtvLLlBcogdVK5dZONbPA02QylYT93pPbw6xJFp
 xoLLDkxqKT8dGPA89pZsZ/b310zLOVGXlG+zDXhYWPVFsv3UZNx3tzfak4gSqvZNf2ir
 5/0zZu4K6jAiWm/mPOgsQLgTeta0eXVrCRQ+6FGym3wbxGtLZk4wc/C5smM6jv98Jjuv
 XCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MNn7wi779g5wDhZisTPTovBof5tUb05aT8JmY/Sn4ZM=;
 b=EPYd9im8AC/zOBGSoCw897WdrstZpZsPTXnn7sqw305hTQflS4VM9Qq2/iwxoN7TEk
 AYXq0NuWs8KNVAnm5G8Ades5Ue1Z1PutuYlAL+mzJWcwsrXyTZg/nR07b5Ch+DGbfsVJ
 8J9HAZCZfqZmmehj5QENRW3GB63CGvO7MyVZLudFcdcPjt5fj7btaJYDFnfOLGLN0Rv9
 KLsiPdl6yXv/F7HkT6Z9DDKYGHZAU/QA+rZ0gEM3VYRDhF3fnW3c1V3xHpQmUU7/TPtv
 WNJ4hEmi6JCEFWEsQx/eVVF6K+gqeTCbjGpiTGywfQVAZntA64WP7RVct5VT2HQNb2wg
 jrrA==
X-Gm-Message-State: APjAAAU2LD3HcyOjf2nVsbaEopEE9HhWJUl2+2SAR1yMEqyCZRhqEDIR
 0vtYgdVp2Y/emXi0t/6WRSXmPdXrK64=
X-Google-Smtp-Source: APXvYqza2m5Rq4xbgsu5S6cOGsn728vrFXE+VcLGsMrZRv3tVmTbP5tqc8bXYq7zfQvYrHoVExSJ3A==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr5439956wmf.105.1574970368433; 
 Thu, 28 Nov 2019 11:46:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d20sm25667791wra.4.2019.11.28.11.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 11:46:04 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A36471FF8F;
 Thu, 28 Nov 2019 19:46:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] linux-user: convert target_mmap debug to tracepoint
Date: Thu, 28 Nov 2019 19:46:00 +0000
Message-Id: <20191128194603.24818-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128194603.24818-1-alex.bennee@linaro.org>
References: <20191128194603.24818-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is a pain to re-compile when you need to debug and tracepoints are
a fairly low impact way to instrument QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/mmap.c       | 51 +++++++++++++++++++++++------------------
 linux-user/trace-events |  1 +
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 66868762519..c81fd85fbd2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -60,6 +60,15 @@ void mmap_fork_end(int child)
         pthread_mutex_unlock(&mmap_mutex);
 }
 
+/* mmap prot pretty printer */
+static void pp_prot(char (*str)[4], int prot)
+{
+    (*str)[0] = prot & PROT_READ ? 'r' : '-';
+    (*str)[1] = prot & PROT_WRITE ? 'w' : '-';
+    (*str)[2] = prot & PROT_EXEC ? 'x' : '-';
+    (*str)[3] = 0;
+}
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int prot)
 {
@@ -68,10 +77,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
 
     if (TRACE_TARGET_MPROTECT_ENABLED) {
         char prot_str[4];
-        prot_str[0] = prot & PROT_READ ? 'r' : '-';
-        prot_str[1] = prot & PROT_WRITE ? 'w' : '-';
-        prot_str[2] = prot & PROT_EXEC ? 'x' : '-';
-        prot_str[3] = 0;
+        pp_prot(&prot_str, prot);
         trace_target_mprotect(start, len, prot_str);
     }
 
@@ -370,32 +376,33 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len;
 
     mmap_lock();
-#ifdef DEBUG_MMAP
-    {
-        printf("mmap: start=0x" TARGET_ABI_FMT_lx
-               " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c flags=",
-               start, len,
-               prot & PROT_READ ? 'r' : '-',
-               prot & PROT_WRITE ? 'w' : '-',
-               prot & PROT_EXEC ? 'x' : '-');
-        if (flags & MAP_FIXED)
-            printf("MAP_FIXED ");
-        if (flags & MAP_ANONYMOUS)
-            printf("MAP_ANON ");
-        switch(flags & MAP_TYPE) {
+    if (TRACE_TARGET_MMAP_ENABLED) {
+        char prot_str[4];
+        g_autoptr(GString) flag_str = g_string_new(NULL);
+
+        pp_prot(&prot_str, prot);
+
+        if (flags & MAP_FIXED) {
+            g_string_append(flag_str, "MAP_FIXED ");
+        }
+        if (flags & MAP_ANONYMOUS) {
+            g_string_append(flag_str, "MAP_ANON ");
+        }
+
+        switch (flags & MAP_TYPE) {
         case MAP_PRIVATE:
-            printf("MAP_PRIVATE ");
+            g_string_append(flag_str, "MAP_PRIVATE ");
             break;
         case MAP_SHARED:
-            printf("MAP_SHARED ");
+            g_string_append(flag_str, "MAP_SHARED ");
             break;
         default:
-            printf("[MAP_TYPE=0x%x] ", flags & MAP_TYPE);
+            g_string_append_printf(flag_str, "[MAP_TYPE=0x%x] ",
+                                   flags & MAP_TYPE);
             break;
         }
-        printf("fd=%d offset=" TARGET_ABI_FMT_lx "\n", fd, offset);
+        trace_target_mmap(start, len, prot_str, flag_str->str, fd, offset);
     }
-#endif
 
     if (!len) {
         errno = EINVAL;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 41d72e61abb..9411ab357c9 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -14,3 +14,4 @@ user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_add
 
 # mmap.c
 target_mprotect(uint64_t start, uint64_t len, char *flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s"
+target_mmap(uint64_t start, uint64_t len, char *pflags, char *mflags, int fd, uint64_t offset) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=%s flags=%s fd=%d offset=0x%"PRIx64
-- 
2.20.1


