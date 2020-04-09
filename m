Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E252C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1334D2074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvkleqK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1334D2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMedH-0004fF-6A
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWY-0002CU-6t
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWX-0005qF-2y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWW-0005pW-T2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id f13so7119751wrm.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UOHKfqIKF1jCjy8KTE3gn1Ffb6t6apDQDsVpcDQdBmM=;
 b=zvkleqK54b0q8+MePDP5WrH3YP8Drad0R5SwOyaUvXPWXJhLxfw6gqYrwoC5QPyBKY
 bP0RqyDQg1pjNqAOgTVKjJPFk/mnkD+8HJe296Kj3Ak4/3iMBh2eiY643dDWMKNQ3zzG
 CLoOvVAyz/9LRGM4RNX0nv3LNL3dzs/RONV7nlcjbMcpkhCMYYJKQP0oDeYErzfIlsFi
 WtFblGD5dH/qhcdpD3YKHZAMndOiQa6xDCBxNeQv6xaiL5bUJKxw7ZNXk7qzfo7SOUdn
 cvH1kK5WS7N/Siy18w3nszXNoJEfl3i5P+r/DFRqe07+nV0SK+/ixNbHXbrL9XTAr3Nh
 q/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UOHKfqIKF1jCjy8KTE3gn1Ffb6t6apDQDsVpcDQdBmM=;
 b=L6RSb5i2Dn0cGMojWMbEMsJ50XloHPO+AIav1yJZH+Qa6CcESB6UcvoxYrzgNv7vZU
 J/G/fC5JMWevujOPKnxU0WehaZT+XZ25CGzQQ7Pa/wZKfdrliXthfN6rTSjXdKP0/fLl
 kAPSNT9Nxubu95ywbuy2NtbV2eoEDG+tj7WD8jya7offrqFO4CbMpiwGeZ07fTErqY7q
 DFy3bmV0nx27GdgUm0A8xplpMdaZrjvQPPBPkOsDDhtnB3IUMf1FhhitXaqWou9JNdf1
 g2mkCZsdubv47YHc+5vPWdFB22liL28upQid8pKE/QhpVhT/GIo6uIlRDtvxqhvB8VUy
 le7A==
X-Gm-Message-State: AGi0PuZ23H6uTwB+kzwq/cvC0EU/P8Cr7zaNG5Wld1rGDo7cdg/jb6qf
 CUr6MpWuoTr38DvoJ1yxn8hrCw==
X-Google-Smtp-Source: APiQypIEQomNRFsdOZgmEZSmQIyxW+r//0e4NHXz7N+YtI+mfg8pXIHkVgvDLNHLHbirZGE62wDCKg==
X-Received: by 2002:adf:d851:: with SMTP id k17mr1214694wrl.157.1586466943892; 
 Thu, 09 Apr 2020 14:15:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x18sm5045661wmi.29.2020.04.09.14.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE4091FF99;
 Thu,  9 Apr 2020 22:15:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 10/11] linux-user: fix /proc/self/stat handling
Date: Thu,  9 Apr 2020 22:15:28 +0100
Message-Id: <20200409211529.5269-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Philippe=5FMathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brice Goglin <Brice.Goglin@inria.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the original bug report long files names in Guix caused
/proc/self/stat be truncated without the trailing ") " as specified in
proc manpage which says:
    (2) comm  %s
           The  filename of the executable, in parentheses.  This
           is visible whether or not the  executable  is  swapped
           out.

Additionally it should only be reporting the executable name rather
than the full path. Fix both these failings while cleaning up the code
to use GString to build up the reported values. As the whole function
is cleaned up also adjust the white space to the current coding style.

Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
Cc: Philippe_Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6495ddc4cda..674f70e70a5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env, int fd)
 {
     CPUState *cpu = env_cpu((CPUArchState *)cpu_env);
     TaskState *ts = cpu->opaque;
-    abi_ulong start_stack = ts->info->start_stack;
+    g_autoptr(GString) buf = g_string_new(NULL);
     int i;
 
     for (i = 0; i < 44; i++) {
-      char buf[128];
-      int len;
-      uint64_t val = 0;
-
-      if (i == 0) {
-        /* pid */
-        val = getpid();
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else if (i == 1) {
-        /* app name */
-        snprintf(buf, sizeof(buf), "(%s) ", ts->bprm->argv[0]);
-      } else if (i == 27) {
-        /* stack bottom */
-        val = start_stack;
-        snprintf(buf, sizeof(buf), "%"PRId64 " ", val);
-      } else {
-        /* for the rest, there is MasterCard */
-        snprintf(buf, sizeof(buf), "0%c", i == 43 ? '\n' : ' ');
-      }
+        if (i == 0) {
+            /* pid */
+            g_string_printf(buf, FMT_pid " ", getpid());
+        } else if (i == 1) {
+            /* app name */
+            gchar *bin = g_strrstr(ts->bprm->argv[0], "/");
+            bin = bin ? bin + 1 : ts->bprm->argv[0];
+            g_string_printf(buf, "(%.15s) ", bin);
+        } else if (i == 27) {
+            /* stack bottom */
+            g_string_printf(buf, TARGET_ABI_FMT_ld " ", ts->info->start_stack);
+        } else {
+            /* for the rest, there is MasterCard */
+            g_string_printf(buf, "0%c", i == 43 ? '\n' : ' ');
+        }
 
-      len = strlen(buf);
-      if (write(fd, buf, len) != len) {
-          return -1;
-      }
+        if (write(fd, buf->str, buf->len) != buf->len) {
+            return -1;
+        }
     }
 
     return 0;
-- 
2.20.1


