Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0AC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD0F206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dsCYQ8Fp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD0F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOR6-00027v-5H
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOI-00057I-0W
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOC-00079x-Cd
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOOC-00079Y-6e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id g12so6879148wmh.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yvyxieRgXTgnaYpRAHFSnkQCJYL7gwucJ9BQHEnE72U=;
 b=dsCYQ8FpR5f1yzZHJovafOOVrGN+hbeQLjaxs5CckGpDvnvr5tvobIlieI1LGou891
 3lWmb1/4L+0TtDr/zrt1ZIX1nhfegha2HgujbwnS+GXCIShHtkH0ioThszOtAiDZzC6O
 hv5Esu+UaX2INjPxGvvs9vbJMgt0AafIpzhQGGx004KUv6eDQ/gPVpa0zdxtPYYPKT1p
 k2fKI+UQLj5VShL7IZZx7rxT8HGgQ+g48Uq5OXYKQpEglxM3LvJ+aIu68MYElAhUF6Vy
 n/PeMXXKosGCsGULv8qVGmrThjpAbwSg/3Z29TzNsyNnnKgVBeBdW3knvW7lsJ+NlyIl
 D6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yvyxieRgXTgnaYpRAHFSnkQCJYL7gwucJ9BQHEnE72U=;
 b=m254sfJSsdtmhe6eg7CTZlU+cNgeWvv70ehH0+5QjrSOceVM3M7hCRATl9ftagxeVH
 JlCLvY0q7DLJlO9gEAo2/zAQu8IOe0SEYnTNEJsM3OClw4TYA4PVCrZmLxWb5Is0oF4K
 aCs0HKtXXbTJAgR5oGatR3EJ8N9osOYbS7IrfzSOUQ0co9Eo/5tQpVnDcMy4bTJaN0v3
 S9qw1PAf0BE0XkVtaEK2F1ezVg9zdZ9NtPzotT1zeK5lkM8xj+V8+RYdK4Bjg3rAab6i
 bUC5m9+CdFeL4TMI84Dl1FB03zbhM8uJEqIo+Nz7t3HMBccHt+vtnXyGHxB2749GpZ+s
 qoUA==
X-Gm-Message-State: AGi0PubzLqWIlinFPJrwTkq2F41bDGE1fQ32GM7an5kKHaigep7ENf0x
 A4fcOdRVSXv+LnMd7ElcIeTZaKCrbhpsXQ==
X-Google-Smtp-Source: APiQypKmQn1sNH2HqX6XhycvF6ValpgAe9rxmZkXPRZa5z+mGnMJd46fq0KBWhij1xS3h8BY7jNpLA==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr633636wmh.96.1586881578930;
 Tue, 14 Apr 2020 09:26:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] thread.h: Remove trailing semicolons from Coverity
 qemu_mutex_lock() etc
Date: Tue, 14 Apr 2020 17:26:04 +0100
Message-Id: <20200414162613.4479-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
References: <20200414162613.4479-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the Coverity-specific definitions of qemu_mutex_lock() and friends
have a trailing semicolon. This works fine almost everywhere because
of QEMU's mandatory-braces coding style and because most callsites are
simple, but target/s390x/sigp.c has a use of qemu_mutex_trylock() as
an if() statement, which makes the ';' a syntax error:
"../target/s390x/sigp.c", line 461: warning #18: expected a ")"
      if (qemu_mutex_trylock(&qemu_sigp_mutex)) {
          ^

Remove the bogus semicolons from the macro definitions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200319193323.2038-4-peter.maydell@linaro.org
---
 include/qemu/thread.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 10262c63f58..d22848138ea 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -57,17 +57,17 @@ extern QemuCondTimedWaitFunc qemu_cond_timedwait_func;
  * hide them.
  */
 #define qemu_mutex_lock(m)                                              \
-            qemu_mutex_lock_impl(m, __FILE__, __LINE__);
+            qemu_mutex_lock_impl(m, __FILE__, __LINE__)
 #define qemu_mutex_trylock(m)                                           \
-            qemu_mutex_trylock_impl(m, __FILE__, __LINE__);
+            qemu_mutex_trylock_impl(m, __FILE__, __LINE__)
 #define qemu_rec_mutex_lock(m)                                          \
-            qemu_rec_mutex_lock_impl(m, __FILE__, __LINE__);
+            qemu_rec_mutex_lock_impl(m, __FILE__, __LINE__)
 #define qemu_rec_mutex_trylock(m)                                       \
-            qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__);
+            qemu_rec_mutex_trylock_impl(m, __FILE__, __LINE__)
 #define qemu_cond_wait(c, m)                                            \
-            qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
+            qemu_cond_wait_impl(c, m, __FILE__, __LINE__)
 #define qemu_cond_timedwait(c, m, ms)                                   \
-            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__);
+            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__)
 #else
 #define qemu_mutex_lock(m) ({                                           \
             QemuMutexLockFunc _f = atomic_read(&qemu_mutex_lock_func);  \
-- 
2.20.1


