Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86BDC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD872076C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 23:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSC/DKI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD872076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF4hn-0006DB-Qw
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 19:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF4h8-0005ck-Mn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jF4h7-000114-NE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:35:22 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:38622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jF4h7-00010M-Dl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 19:35:21 -0400
Received: by mail-pf1-x434.google.com with SMTP id z5so2277300pfn.5
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d2UD8j39Lf4ruMvckqg0Ru5cH8tMHf9SGNhhMuPrAKQ=;
 b=kSC/DKI2VAPO3wyDHblTA1UfvNCZMcjkgXTJNgo8JxmjD6OKiiNrd8X9/p2zw7pGY+
 OZ6Y3Yemn6wXz7TFMqHM90/6jRbOvXg501iv0DsNBCuoXXlqKdJGHMLZWXI2hfINDXxW
 a7bcLy0G3ophP2UZdQHlX0FPlHc27AavtP+vV+jMKlNwIVjNlazXu8xXl8ivrxIgKmfd
 +f0joG6o7J+uXkrnfD5OXHPxrsmq56aTlKYACax8X6DYrWSOIjBc9cEAjbhOCCHUPIlH
 7mRktCvKOtrvPutfapswGijSZi4P1/4FlIu2sTXqVYpI6GLvKyHQn72r5AuDv1U/8bAM
 h4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d2UD8j39Lf4ruMvckqg0Ru5cH8tMHf9SGNhhMuPrAKQ=;
 b=IlhMeIqWSwAXwoR7qIs2k2pFLAuPxb2cOcHCEaNZk6FqLc41B0zUpK6M/3SREEjr3g
 JUGYl/8eBjCour/xpXeukCIfnVJILGl279WStsGOKcESM2CYS7H99yRmIZQCTBqIiL5B
 aFff+GIkCoUe+NDpW45wwCGGS3UaGEPqKLWPwhfl2/Vb4ZWfPJftEYoIeu0hocW2k1UK
 oIXqUQXYqotJbKeSvdzPNWKRKeeKr/huZxpLzUpYwLLMbmgod19O8CNiuke4MRHPbHVh
 krrvK7rvy+PoNGH2f8MuYZ9/5vAirWsw8gTge0W6vmotZH9FIVIA80t8bkstzqrE8/jf
 xTEg==
X-Gm-Message-State: ANhLgQ1js7N6uLDKswh6AobAhO0pGxKx96ux9Yxn7HtnzYWozPQfM8T5
 YSQyc3LBci8ybDSJp0U+xBI=
X-Google-Smtp-Source: ADFU+vt5RweXI40S0rJfeSQETmcI8ImJlJECBuIDCAH3iXEXd/povBpeuBB984n0PjjNDqHX1P9x9w==
X-Received: by 2002:a62:2f46:: with SMTP id v67mr3322315pfv.7.1584660920526;
 Thu, 19 Mar 2020 16:35:20 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id w205sm3500404pfc.75.2020.03.19.16.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 16:35:20 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v2 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
Date: Thu, 19 Mar 2020 16:34:53 -0700
Message-Id: <20200319233454.1856568-2-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319233454.1856568-1-dnbrdsky@gmail.com>
References: <20200319233454.1856568-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Brodsky <dnbrdsky@gmail.com>

- __COUNTER__ doesn't work with ## concat
- replaced ## with glue() macro so __COUNTER__ is evaluated

Fixes: 3284c3ddc4

Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
---
 include/qemu/lockable.h | 2 +-
 include/qemu/rcu.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 1aeb2cb1a6..a9258f2c2c 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -170,7 +170,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
  *   }
  */
 #define QEMU_LOCK_GUARD(x) \
-    g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ = \
+    g_autoptr(QemuLockable) glue(qemu_lockable_auto, __COUNTER__) = \
             qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE((x)))
 
 #endif
diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 9c82683e37..570aa603eb 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -170,7 +170,7 @@ static inline void rcu_read_auto_unlock(RCUReadAuto *r)
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
 
 #define WITH_RCU_READ_LOCK_GUARD() \
-    WITH_RCU_READ_LOCK_GUARD_(_rcu_read_auto##__COUNTER__)
+    WITH_RCU_READ_LOCK_GUARD_(glue(_rcu_read_auto, __COUNTER__))
 
 #define WITH_RCU_READ_LOCK_GUARD_(var) \
     for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock(); \
-- 
2.25.1


