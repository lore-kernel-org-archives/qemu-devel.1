Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88657C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574EB204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bJsaCkPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574EB204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzm65-0002M6-J6
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54564)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3pOVaXQMKCss9tDx55x2v.t537v3B-uvCv2454x4B.58x@flex--scw.bounces.google.com>)
 id 1hzm59-0001oD-R6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3pOVaXQMKCss9tDx55x2v.t537v3B-uvCv2454x4B.58x@flex--scw.bounces.google.com>)
 id 1hzm58-00038K-NF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:08:39 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a]:33104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3pOVaXQMKCss9tDx55x2v.t537v3B-uvCv2454x4B.58x@flex--scw.bounces.google.com>)
 id 1hzm58-00037V-F4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:08:38 -0400
Received: by mail-pg1-x54a.google.com with SMTP id a21so3040880pgv.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=7RKduOP1Zy0Z6W4TdqYEUSnkCMOqjh++D/cBNOzwUMM=;
 b=bJsaCkPz+GyTMhxxLkCZxnBLEuTL9CFNoyE/Mdr7zsrTiwgatqsNs0SIe5SbhMyo07
 wJGyRi9N+LHzPKExX6NB96m5sy/SsWds8ls7VlV+ns2ZvCaUUv/iBs738UctNVFHYFS/
 aCn5JL2Bgs52rpT3hpQwy/6GuFxaoElaBm2R8I/x0mcmZrFYeW/t2sM4+b00rj+AiV/u
 ryC6Fn9la+TdOnJoFtRtwHFb16LjbkDikGyQS+uLi+eboncknM7tA4/unmSxBtlvd0SH
 pFSL8nJjxtjITFXT8LTclwpvKdzcnV2278HqJ02K/R/zihbQ4cB4G1tEefrBx/2RSZ9t
 0j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=7RKduOP1Zy0Z6W4TdqYEUSnkCMOqjh++D/cBNOzwUMM=;
 b=SnDw+kCVM/bL13WA2yhB+Rd5zi96zHKrtJDT54/us0XEheiuPpif961FDZLqiu7jPu
 Y7QKoU20pr1r9CamTYcdHc1q8VdKhLj02FH8lWdE3g9gvh6HzIBglQofTtXxti+tFoXl
 i+KiG9IWbbsPNW0Bz6KeoZ22rNJvhXc/lAGuuZJh3XZlwBuYR3hA4WdXzhVG90HSHkr3
 HmhYHlIK+GHjfRGkLPf+sHH9Pgggzh2l+INNPEoWF4I+oqzM2lE2XMq3vswCVuL8i6Hq
 Y5MPWU7ZoH1rSVU4VWwAnNPXfw6zS6DxN+EKTPAjOFXtn1H+DLmJ2KEarbV7ZwJyNs9o
 xfUQ==
X-Gm-Message-State: APjAAAVQk3V/1q28qwgEYr7TTSzyv/0pSmxRXYWLf/b583zQoGpHp4o/
 3ZN2D7iMOq0pNpuShOZHRr9m70A=
X-Google-Smtp-Source: APXvYqzj35y0uBKX4JkvHCG8VKQB6OG5fN5fE+cniAWPjSiFqJhYWafl1hcaLWwex5VnVUFhEGhsZZA=
X-Received: by 2002:a63:62c6:: with SMTP id
 w189mr21001075pgb.312.1566238116012; 
 Mon, 19 Aug 2019 11:08:36 -0700 (PDT)
Date: Mon, 19 Aug 2019 11:08:31 -0700
In-Reply-To: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
Message-Id: <20190819180831.179075-1-scw@google.com>
Mime-Version: 1.0
References: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: marcandre.lureau@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::54a
Subject: [Qemu-devel] [PATCH v2] linux-user: add memfd_create
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
From: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Shu-Chun Weng <scw@google.com>
Cc: arunkaly@google.com, Shu-Chun Weng <scw@google.com>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for the memfd_create syscall. If the host does not have the
libc wrapper, translate to a direct syscall with NC-macro.

Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 include/qemu/memfd.h |  4 ++++
 linux-user/syscall.c | 11 +++++++++++
 util/memfd.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
index d551c28b68..975b6bdb77 100644
--- a/include/qemu/memfd.h
+++ b/include/qemu/memfd.h
@@ -32,6 +32,10 @@
 #define MFD_HUGE_SHIFT 26
 #endif
 
+#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
+int memfd_create(const char *name, unsigned int flags);
+#endif
+
 int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
                       uint64_t hugetlbsize, unsigned int seals, Error **errp);
 bool qemu_memfd_alloc_check(void);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8367cb138d..b506c1f40e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/path.h"
+#include "qemu/memfd.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
@@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         /* PowerPC specific.  */
         return do_swapcontext(cpu_env, arg1, arg2, arg3);
 #endif
+#ifdef TARGET_NR_memfd_create
+    case TARGET_NR_memfd_create:
+        p = lock_user_string(arg1);
+        if (!p) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(memfd_create(p, arg2));
+        unlock_user(p, arg1, 0);
+        return ret;
+#endif
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
diff --git a/util/memfd.c b/util/memfd.c
index 00334e5b21..4a3c07e0be 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -35,7 +35,7 @@
 #include <sys/syscall.h>
 #include <asm/unistd.h>
 
-static int memfd_create(const char *name, unsigned int flags)
+int memfd_create(const char *name, unsigned int flags)
 {
 #ifdef __NR_memfd_create
     return syscall(__NR_memfd_create, name, flags);
-- 
2.23.0.rc1.153.gdeed80330f-goog


