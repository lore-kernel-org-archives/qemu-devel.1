Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1034C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE073206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 18:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qDiriZ+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE073206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzm72-0003LD-Uk
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 14:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54726)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <38OVaXQMKChkH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com>)
 id 1hzm6N-0002lP-G1
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <38OVaXQMKChkH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com>)
 id 1hzm6M-0003q8-47
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:09:55 -0400
Received: from mail-ua1-x94a.google.com ([2607:f8b0:4864:20::94a]:35485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <38OVaXQMKChkH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com>)
 id 1hzm6M-0003pb-0V
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:09:54 -0400
Received: by mail-ua1-x94a.google.com with SMTP id s1so442068uao.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=T7he1QDEJio2Ie6GPQrqlVylHc1mwsd0spBdAQSpsEk=;
 b=qDiriZ+1sWLdYyF3/vSYvm6gbkv9GxiR21+FFFJxat1oPDujsp4Qy9F6gdEmvh4cng
 Z1xl91YtqVvgBzMeUT2mrXy/CPTFy2VGyVfjNBJJu3epmKRkHcjko2+dGTTu6pmF/HCR
 68x0hIsSwsLTgZKaEb/FZwBHMcPgj36dI2iPKwzQ2+jHkkI0lOziMpIgABSDgvlNWR1D
 gfrHgQf3+ta9zkm00dxW3urH1YdH+xZJelvxkHsE/FGCgsbA/UP2HVzkrlhzhmho7l0w
 qMrvlRw+KjAxnbZkEzlQfMeOC2trXtDpM74+AKJsyuFp3/0smoBkZEhG24dVSLF+s+fw
 wqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=T7he1QDEJio2Ie6GPQrqlVylHc1mwsd0spBdAQSpsEk=;
 b=dju4wBbu1icwNa2bKw4BNhc6Hp0KikTpZe3K0v83KUC7C68XEP1I1h4hUysTvjsou6
 fqUt1y6+vLbUG2LljgWD0bIDSX0ePp7sfCWHsztu6dFkEB7dwJiMFYhSH57uN5TiOU5t
 3rUuUCMjs3BbSTKSmFri4+HrLoL4pcYx++ART8D8BB2uuR00UxIBtc91EhLJk2BbDPAs
 6vDPiAWAW0Q29WKLNiI7Xx9DO3wyXqzSflJDNTyzAlTIZAqtVP/UEyqUSjS3Aiip15fH
 tXwkdkWDskqdCppqG7fMtbPiVuCZbRr9sh6X4VNeIsqm4glqS8fU36rHu/vQziL9hEI5
 zfdQ==
X-Gm-Message-State: APjAAAXoOzLJ5es+l5s5XTVmy9HLyWVffsg2KFUPQdYvwjLo/v/VYTWu
 zOoPdXbqwWDYavMSeI9x7ubsqJk=
X-Google-Smtp-Source: APXvYqw50AMNQZcvBuY5d5UrVqs930I161XpFYFFum63XJqefCQ5uPpzu19FdofnMdSTynGRjik1N7Y=
X-Received: by 2002:a1f:144:: with SMTP id 65mr8480438vkb.51.1566238192492;
 Mon, 19 Aug 2019 11:09:52 -0700 (PDT)
Date: Mon, 19 Aug 2019 11:09:47 -0700
In-Reply-To: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
Message-Id: <20190819180947.180725-1-scw@google.com>
Mime-Version: 1.0
References: <CAFEAcA-GWR6_wGCMWkMHttU3ARJPqfADvNTnqQUU_OzcWgHHuQ@mail.gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: marcandre.lureau@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::94a
Subject: [Qemu-devel] [PATCH v3] linux-user: add memfd_create
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
 linux-user/syscall.c | 12 ++++++++++++
 util/memfd.c         |  2 +-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 8367cb138d..f3f9311e9c 100644
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
@@ -11938,6 +11939,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
+        fd_trans_unregister(ret);
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


