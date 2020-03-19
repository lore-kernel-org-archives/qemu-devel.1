Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A9C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132FB2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZnbEhEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132FB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0yf-0000tz-6X
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v6-0004HE-Ik
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v5-0005tq-Fn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38576)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v5-0005rq-9N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id l20so3745410wmi.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QFHCsQgndAIVNPG9R5oLtcytKTpUJCNgdX7D4zaqb8o=;
 b=HZnbEhEtprEyZe0hBcXSwd2zypShGKy/o2KJ7qX8RFxFFPm9J4TQUDWw8dMz3q5zzQ
 KIPF9hMnZ9LXAM3ficXklUI5hwr6pgV/MzW/EurzvosxdcBJ5k9JnFL/dnvUwzU6W7k3
 M7xkP1rlCGjgJrC6d3QU3xbdw51HTlMEalbnpbt3sc00lNYN46FQkbAWT9E5obIbMSxL
 y+wT33rQ+gB3GSO/62cQ82Vpg6CGomvGlUCJvlRqt0jK6MdNw/HVJjagpQtFj2i2/2vM
 Yx8Ooi4MOg0Xw83i1w0dlrCoQ3y5rtPM4XueUwla5ZEwhl0x5ANOMUDbCWXfT8m2Nu06
 CxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QFHCsQgndAIVNPG9R5oLtcytKTpUJCNgdX7D4zaqb8o=;
 b=AkgGdm734BTb2pKLlD9q45Mp+B6kicPbKNu0Tp7JP25xzoskCLIGQrPgPzVgN/ZcWg
 vA1mvnZ4PBh64uJ1j96/Hy96Y7fm3v4Nlsan2PLJ1aLCLbUGfQnnXIMglJAZxTn1ezNO
 Od6zKKASs+MvnqpQUIXVqfWGJP8I3CdJ9Jg6WEBoDnfHtxy6+PQQbYQbRCzWlqs+88u8
 W9yy41nYv+qPa/r6tEunwakStOIzods2DrmBzRKxIprhjVjNPmfEA0pOJHtiPCaNJ67f
 V9OC+3NDELVnwMrFvpDg6Oja+XUP6M3Mdh1HXSKldZzTWBYUhuq0GhEL9GcpgozqRSHE
 +rnw==
X-Gm-Message-State: ANhLgQ01KBefv1oYYUv0BBZDYzfR/uPexKp7HTgRx0Lf+ZGW3S69MtNQ
 BxZ9XEM8ILAvj6H2TzmdBRqD8gxlzN+Y9Q==
X-Google-Smtp-Source: ADFU+vuP/DX/gp+0h9M+1yc77gZin4zYtQgLMjbqMfASwatydd7SEs99QqWpYR3Oy1CykuO8p+I/cQ==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr5674694wmt.137.1584646408916; 
 Thu, 19 Mar 2020 12:33:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] thread.h: Remove trailing semicolons from Coverity
 qemu_mutex_lock() etc
Date: Thu, 19 Mar 2020 19:33:20 +0000
Message-Id: <20200319193323.2038-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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


