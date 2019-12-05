Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66714C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307CD21823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GITKPgtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307CD21823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icryo-0003pC-Ml
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icret-0002Sg-HN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icres-0000Gv-77
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:07 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:33008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrer-0000A8-Re
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:06 -0500
Received: by mail-lf1-x12a.google.com with SMTP id n25so2606890lfl.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AwS6rtyEJKyLkwzf8eig7lEH4N3AqTO23sBKCr3rUB4=;
 b=GITKPgtuLZtNwgUUIhehuyF0ahpDGuPSz0cQmbKFCVOXRMdjSlFOyyAfSX4/UzDFob
 NpoQRzy86EHaeywxWcKxQYH24mHynOyXcm7VF3Y/B6JvANnxFSo3x5Mu21yKW7uEpygH
 VYsaWvR7+WjV+QBel0CUGZ3ozbBAeUpKpBdWLe1/SQXCBZ7tO6DUS5ZU+EFeVRXze8oh
 41CQeNvxCScQaMznoPHB9YMVY6oukYaKIfNZnCYJ2eUcN5/P4uzCn8LThp/I9a0WwIU3
 K7P/PVgr0qcwbJRfuPWohIHAowL4cR6dvryjFIbEK47XOqd1MoDz6h0e/hL5FipJ9K8l
 F3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AwS6rtyEJKyLkwzf8eig7lEH4N3AqTO23sBKCr3rUB4=;
 b=r9DA9WL6W+iJVFvMSh+r0auIYdsPPjvHh03rSpS1Y5sftjasoKE5qK9mINyv6cXbvt
 EAHRv7PGNVbwvryhc/lqJVWh8hPnYeqNqcVMXV3zaxNBDh2S8VnJTZd/WxoJNRZ+VI8D
 WmVBQKcVmveHzRdziZm+VEciG3tUxzEMcUCd05SVfOUXVqRbo40RqSKOyGd/FPIBPmBr
 EC3ptcVtQPIDUuIzkdwS5r1J7Xo33tFbCLT1oRzriWnKs+KfNN8qiuVKqUBjFT+i/BTk
 ZKdEACmyabWMMdBxBHVewvGQtEAJLZy1NvlhTSjUKpUjREPHbADRtS6PqO8yz9fhiJjL
 pFuA==
X-Gm-Message-State: APjAAAXKM30mxpb8redoTJiUt3kJUdIovNGdaPe1JFsGhYmSJfLb5a1m
 wAagjhSbmeX8ve/x9HIlVR3vFucNpyY=
X-Google-Smtp-Source: APXvYqxdZQiBR/wTXpkxm7aGqIElK/gMI6of//oXsbN9ZEzJh3oZ9pqYMfwlwJFuNI4BsWc8BTYk1g==
X-Received: by 2002:adf:afc2:: with SMTP id y2mr9867264wrd.254.1575548722558; 
 Thu, 05 Dec 2019 04:25:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm5054986wma.39.2019.12.05.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:18 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 255881FF8C;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] linux-user: convert target_mprotect debug to tracepoint
Date: Thu,  5 Dec 2019 12:25:12 +0000
Message-Id: <20191205122518.10010-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205122518.10010-1-alex.bennee@linaro.org>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12a
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
v2
  - don't both with ascii conversion
---
 linux-user/mmap.c       | 10 ++--------
 linux-user/trace-events |  3 +++
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 46a6e3a761a..26a83e74069 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-
+#include "trace.h"
 #include "qemu.h"
 
 //#define DEBUG_MMAP
@@ -66,13 +66,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
     abi_ulong end, host_start, host_end, addr;
     int prot1, ret;
 
-#ifdef DEBUG_MMAP
-    printf("mprotect: start=0x" TARGET_ABI_FMT_lx
-           "len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
-           prot & PROT_READ ? 'r' : '-',
-           prot & PROT_WRITE ? 'w' : '-',
-           prot & PROT_EXEC ? 'x' : '-');
-#endif
+    trace_target_mprotect(start, len, prot);
 
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -TARGET_EINVAL;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index 6df234bbb67..8419243de4e 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -11,3 +11,6 @@ user_handle_signal(void *env, int target_sig) "env=%p signal %d"
 user_host_signal(void *env, int host_sig, int target_sig) "env=%p signal %d (target %d("
 user_queue_signal(void *env, int target_sig) "env=%p signal %d"
 user_s390x_restore_sigregs(void *env, uint64_t sc_psw_addr, uint64_t env_psw_addr) "env=%p frame psw.addr 0x%"PRIx64 " current psw.addr 0x%"PRIx64
+
+# mmap.c
+target_mprotect(uint64_t start, uint64_t len, int flags) "start=0x%"PRIx64 " len=0x%"PRIx64 " prot=0x%x"
-- 
2.20.1


