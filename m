Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F6EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C506E2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7iku8HT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C506E2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKRrJ-0005WC-Vz
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 15:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRja-0003QP-Co
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jKRjY-0002PD-8h
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jKRjY-0002NB-2D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 15:12:04 -0400
Received: by mail-wm1-x344.google.com with SMTP id z14so2825266wmf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jGuKGm7KMOs2UN9ivTUYCq92gardKrGXU32VGXhYNDc=;
 b=O7iku8HTg3uKAe/7dfvlzcFGD08ng6bKMt4MS8drysmkTsZl/4npYNDV61AApVDTj6
 6CTljDUwfUB5MRyKOXBzGRfnLAAz3Nejn9KiiFTybxx+72uR2UkTtHhW5k969/6ytgne
 h824DPW6+d3EXrNMdxVnSNrgTtQ+6tAzTQnT+dfBxfWeSWtR/XcxdtIBwK5PGcm7sh9D
 ubeL7kShk9qqGbDPUM9tZagn6EFXqIAqSvX/c/s64m4jSlf6DAAyo06D+KUEO9488zgv
 ibnRnlUXi8M0cMYCMR+ONqdyD9/EJTnfhfr/kh9P2ijvXys1McSZgWL667DsKnMPhUvd
 EiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jGuKGm7KMOs2UN9ivTUYCq92gardKrGXU32VGXhYNDc=;
 b=JdLyk5jaxX5Spc2Gi1JT5fdCgjKCj2FcDgFy/sJdRkvCTPl2PD03xt9Jrjrt8YdNrw
 o+7foC+auPTSkC2X3rluIJcI5zIBjT+wlzIMAYBiW8PnRoBPXruRhMwp5rzQJBtgOUxK
 eWvQ8xuIw8UCRfjWO4aqGJY+KrhBi6gEk5VithyNlQeDMM+1xAw/SdQeHWPTnyUWacug
 TPJxTCesY4jk7h7ewrkP+n97BCzMeFW8QQ4u8rvqeBVXJWy9s5OM7ltEtPDCVo/xXg/9
 Vi8MVqv+6k0Gdjeq2xG7C/PQTOTh6Rhv5Kr4yflbO4QVEjvwNeXUvA0agqNo16ZXH3o7
 xxPQ==
X-Gm-Message-State: AGi0PuYzphuNDz0QY4lfvQubz1hA+Ve1zK5kOLwTl7W53yJmBHDyDpZ1
 BnZN9xfSfftGJ4awdKblxOtOhoGkSHc=
X-Google-Smtp-Source: APiQypKDZoIF/BoXfWRzAPWz4jlgHdxVnhxFL1eyJ+jvQvCWI1q1q49TFnMofuGyTwI1iMnd5FhZBQ==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr10557949wmf.10.1585941123000; 
 Fri, 03 Apr 2020 12:12:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k84sm12680120wmk.2.2020.04.03.12.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:11:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 79F271FF98;
 Fri,  3 Apr 2020 20:11:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 09/12] linux-user: clean-up padding on /proc/self/maps
Date: Fri,  3 Apr 2020 20:11:47 +0100
Message-Id: <20200403191150.863-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200403191150.863-1-alex.bennee@linaro.org>
References: <20200403191150.863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't use magic spaces, calculate the justification for the file
field like the kernel does with seq_pad.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - change for unsigned long update
---
 linux-user/syscall.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 666be20f3ff..8a610b91402 100644
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
-                    " %c%c%c%c %08" PRIx64 " %s %d %s%s\n",
-                    h2g(min), h2g(max - 1) + 1,
-                    e->is_read ? 'r' : '-',
-                    e->is_write ? 'w' : '-',
-                    e->is_exec ? 'x' : '-',
-                    e->is_priv ? 'p' : '-',
-                    (uint64_t) e->offset, e->dev, e->inode,
-                    path ? "         " : "", path ? path : "");
+            count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
+                            " %c%c%c%c %08" PRIx64 " %s %d",
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


