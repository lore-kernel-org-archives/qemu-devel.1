Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9332C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803072072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLYCntdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803072072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqaF-00030C-Ow
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVi-0003da-CC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLqVh-0004PD-9D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38488)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLqVh-0004Ob-3D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:51:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id f20so2364532wmh.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D8BK29LzMjfBeG1Gt0CmPdKAbN7O2k2vjO3bs9Akqc4=;
 b=KLYCntdYS8lGIH4zoDHxDdbiGfUzjbKpOXcTQgZMZXxbSYn+5NTyVuTiQ4qJHZiZZY
 GEzz4pGB+eFcaLkTnAIgn4QCmRLDY7NlKMWDhvf2D2YJUgw49yrjLWpxS82/h12YPY8u
 pe+OtxvA/DJnn4TjXuKw6QzzedoLQCzbas7RNI0dJBlaAPhEAigaYbbGX4q0XFNEdaTQ
 wdFh+hR7a8ZN8zg5HqHmHJ2x9fl0SzxesrkTTKAcXFLnWGEh0IVumDOeBkbGxRa4ZH6y
 13E/W9FkPnaYjReWXM2NvH35VX2LzzuhE4sE+IgQHIM8G1ftj0IVvqtqKU0qF1d2DKlq
 nrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D8BK29LzMjfBeG1Gt0CmPdKAbN7O2k2vjO3bs9Akqc4=;
 b=EPUq0bsjnKhJDyRa2UopPyiORdOGVeIvm/8ypZNp32ExeJe7K5a/jQFr/J0hBfkrOs
 CemOiN0s2Zxqt975w7KNoA+IdqRcq+XzMmuFm+k4716r1rGaJXj57TKO5JlSuxR5yI2p
 puqEz62gIYMxgmGLYV4y+RwZJkv3ijgI3r9EF0//5mfaqDoKeefp4ygsm4infkphae3k
 7YSdDoacHBe2y+yS8LHuCA0qCa22FkWyQ13Eq5Y3Joyg8zHDGpgfuIOej9BPVmRgC0S1
 vbPpC+BAyg0NJbnMRzoV5H9M5RaItGsOt5LmNwNnYnC+pD6y1EQh+6XhZmyFuXg5Mo/j
 ACkA==
X-Gm-Message-State: AGi0PuYTtZRY4vSkoFEF8OygjWgLDQBaalCDC7eDBCDvz/UQKEsRpCrK
 OvwcdK9k+uMC4rQEfAgcDGU4lg==
X-Google-Smtp-Source: APiQypLt/biP26tTODJ/G7r5pNbtWkk4dr0TSakLMyyW51PqwrMDNE4sCI69cCEkm5irVujlSRAerQ==
X-Received: by 2002:a05:600c:a:: with SMTP id
 g10mr3043304wmc.153.1586274692008; 
 Tue, 07 Apr 2020 08:51:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j6sm32369851wrb.4.2020.04.07.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 08:51:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2BCA01FF99;
 Tue,  7 Apr 2020 16:51:19 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/13] linux-user: clean-up padding on /proc/self/maps
Date: Tue,  7 Apr 2020 16:51:15 +0100
Message-Id: <20200407155118.20139-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155118.20139-1-alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't use magic spaces, calculate the justification for the file
field like the kernel does with seq_pad.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200403191150.863-10-alex.bennee@linaro.org>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5f117872947..6495ddc4cda 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7235,6 +7235,7 @@ static int open_self_maps(void *cpu_env, int fd)
     TaskState *ts = cpu->opaque;
     GSList *map_info = read_self_maps();
     GSList *s;
+    int count;
 
     for (s = map_info; s; s = g_slist_next(s)) {
         MapInfo *e = (MapInfo *) s->data;
@@ -7253,20 +7254,24 @@ static int open_self_maps(void *cpu_env, int fd)
             }
 
             if (h2g(min) == ts->info->stack_limit) {
-                path = "      [stack]";
+                path = "[stack]";
             } else {
                 path = e->path;
             }
 
-            dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                    " %c%c%c%c %08" PRIx64 " %s %"PRId64" %s%s\n",
-                    h2g(min), h2g(max - 1) + 1,
-                    e->is_read ? 'r' : '-',
-                    e->is_write ? 'w' : '-',
-                    e->is_exec ? 'x' : '-',
-                    e->is_priv ? 'p' : '-',
-                    (uint64_t) e->offset, e->dev, e->inode,
-                    path ? "         " : "", path ? path : "");
+            count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+                            " %c%c%c%c %08" PRIx64 " %s %"PRId64,
+                            h2g(min), h2g(max - 1) + 1,
+                            e->is_read ? 'r' : '-',
+                            e->is_write ? 'w' : '-',
+                            e->is_exec ? 'x' : '-',
+                            e->is_priv ? 'p' : '-',
+                            (uint64_t) e->offset, e->dev, e->inode);
+            if (path) {
+                dprintf(fd, "%*s%s\n", 73 - count, "", path);
+            } else {
+                dprintf(fd, "\n");
+            }
         }
     }
 
@@ -7277,9 +7282,10 @@ static int open_self_maps(void *cpu_env, int fd)
      * We only support execution from the vsyscall page.
      * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
      */
-    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
-            " --xp 00000000 00:00 0 [vsyscall]\n",
-            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+    count = dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
+                    " --xp 00000000 00:00 0",
+                    TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+    dprintf(fd, "%*s%s\n", 73 - count, "",  "[vsyscall]");
 #endif
 
     return 0;
-- 
2.20.1


