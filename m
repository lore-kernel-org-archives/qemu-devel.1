Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C1C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D6D2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0tDhS99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D6D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0w9-0005TG-2J
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v4-0004GD-A9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v3-0005pT-8B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v3-0005oW-2N
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:29 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so4659235wrl.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=smsrtU5x+Ww0fA4g+LeGtvF6EpGiUdbtArUTIrJNIQ0=;
 b=Q0tDhS990sj6uzNWIfGFwU92SMl8u3+aXG+LEXxgAuKb9PRbbSaj39Qgx436xD7Xqc
 Qc0ZXYx3I1H2suQ1xYvAUdqm9CkjrzaHGLb14LzIvvufALlqyOtknqVA1wp4z3x5MNf5
 S7TXvyZZmONJSPtbLXWR7xyfhp4hxQaeKO8KfG/ZAcpz24mcoYRfhtudpc2laRs8Dcpo
 aXqHX52CeZLfOxldUZrlYlSlnFDaOUooSY2AIfZOdd/acnBbjzxMHLrShItq7JN7ffXI
 vUj+yrJ0baVZFj16rrgKcYVC3l2RWVMvCt7i/v0a3O29nfwCwwKeKb1skNDp6S5jXEqU
 9/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=smsrtU5x+Ww0fA4g+LeGtvF6EpGiUdbtArUTIrJNIQ0=;
 b=ijqGu1V411pQhkLK7dNpxYaF1lIVzE5iHT2o8aWdoRSeRZmUqUMeXJrPdvmW3Gao9z
 EfJrQjZ7wvMAKV/HPRIeXnDdtqVnEOVdhaOgUZUotvNeazACqXGUtb+q8kK5IoIQD65R
 n9eR93QUUXGPrFn1OJim1Ia4gfzIeS/bV8jiNrNrv4KXLZ5QTHsLHilC0AUAFbnvnddm
 2nUan2aYnjlO4YPMkDCUMC+/PoAzbIAB9alpLZJT+OAYZHI6fqq/7itFygoshc/7qTUk
 LpQ0AqxxRab/1nhWTgGjKWpUv8DNcfUwpfoMyAfBulhocjsEg4T8d6raqkvwBZWFtfBk
 lC4Q==
X-Gm-Message-State: ANhLgQ1FvqGBRyocT0xWYYTCVEFcIV6K7o0uPFWNqbUxnCRbo1dJ+Yxs
 s0vFGYmQsrT4kcnUAglo/RjgZZdlWLWIIQ==
X-Google-Smtp-Source: ADFU+vszgXzNSOUsYqAOa8ppQFJ5p802TxhWT5U+rdHXN/WsN04xjECQYIpIZz+Kfdy8xrKU2PixQw==
X-Received: by 2002:a5d:5290:: with SMTP id c16mr5922034wrv.235.1584646407864; 
 Thu, 19 Mar 2020 12:33:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] thread.h: Fix Coverity version of qemu_cond_timedwait()
Date: Thu, 19 Mar 2020 19:33:19 +0000
Message-Id: <20200319193323.2038-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Coverity's benefit, we provide simpler versions of functions like
qemu_mutex_lock(), qemu_cond_wait() and qemu_cond_timedwait().  When
we added qemu_cond_timedwait() in commit 3dcc9c6ec4ea, a cut and
paste error meant that the Coverity version of qemu_cond_timedwait()
was using the wrong _impl function, which makes the Coverity parser
complain:

"/qemu/include/qemu/thread.h", line 159: warning #140: too many arguments in
          function call
      return qemu_cond_timedwait(cond, mutex, ms);
             ^

"/qemu/include/qemu/thread.h", line 159: warning #120: return value type does
          not match the function type
      return qemu_cond_timedwait(cond, mutex, ms);
             ^

"/qemu/include/qemu/thread.h", line 156: warning #1563: function
          "qemu_cond_timedwait" not emitted, consider modeling it or review
          parse diagnostics to improve fidelity
  static inline bool (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mutex,
                      ^

These aren't fatal, but reduce the scope of the analysis. Fix the error.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/thread.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 047db0307e7..10262c63f58 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -67,7 +67,7 @@ extern QemuCondTimedWaitFunc qemu_cond_timedwait_func;
 #define qemu_cond_wait(c, m)                                            \
             qemu_cond_wait_impl(c, m, __FILE__, __LINE__);
 #define qemu_cond_timedwait(c, m, ms)                                   \
-            qemu_cond_wait_impl(c, m, ms, __FILE__, __LINE__);
+            qemu_cond_timedwait_impl(c, m, ms, __FILE__, __LINE__);
 #else
 #define qemu_mutex_lock(m) ({                                           \
             QemuMutexLockFunc _f = atomic_read(&qemu_mutex_lock_func);  \
-- 
2.20.1


