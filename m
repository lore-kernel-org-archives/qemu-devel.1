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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C7C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC822072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEZLO5R9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC822072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzJE-0002ix-A3
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jExtR-0000UQ-Sw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:19:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jExtQ-0004BL-RO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:19:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jExtQ-0004B9-Jo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 12:19:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id a32so1531221pga.4
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BAEUxQ7rRU51jZ5YssMQdXfJ3giCUEq60r8fzA4c57c=;
 b=qEZLO5R9IxxBbHOmkv6IxvzqHrVXDwmKXH/l1b3lR89OWH6TsTUm2833xCNhL84wlk
 nsMmBVGYFibRwzftK/JZrxiKunc7FPh0guRKPlHr6+taFStGzoYmk/h0kogT3Z0zA7me
 OW4Qxo5kJQnXBG4jMtP7yI4s50MtqFDdPn0xow7FNdn/p1lxTjucghyhubdX7kONQfH9
 SqV1l2TAYSsKwBHOenGa1Y0E48J6EKDNHcyN8WG4AJPlD9QKPLxK+xqJFmlzw6BFEDyF
 7/FSZeP11C5RqA0Zx5Pdcvm19MMp3SJwY3hB4IW3UGbFWdk9Hg4K0ZH5RsGktL+YrQ35
 aSSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BAEUxQ7rRU51jZ5YssMQdXfJ3giCUEq60r8fzA4c57c=;
 b=H4gMm+y5RB2Tnz+kWzlXnkXkO1Qg3Hs4FoeDk2hzSgvYQHDxf+m/UY3vR6pez6Zkvc
 tHaVCEYX3c8DeHS+h1FCGWXgio6xefY6hcpLICP+GS51T3EzsF5IypZRRv3cIizByaY0
 pfJkpdcM95AoKmIsKsPHWjbTuIMFX2CS4ewrkXNjlCEBRD9fHE1On0dN1bCwdrhcDTpG
 f9DMMsL8XOlYXgxna4x/efNduGnWSjAsFVRK/B8oHpT1G/E3X0fG7/2x5dnx/4MNVWyr
 oCuG1N6sCdMMcuSrqodj7b5eU8iQYa8mb91oOOFKxKUbLf2Lf5tSYut1sjUBxksVsp7Z
 PPmg==
X-Gm-Message-State: ANhLgQ3GpRwlRNurFrapl777SClxulouH6Z/HwZancyGKWlk5CKitaEm
 +TUSelK2PO44+guSNLkyaw3+9W9KbacZwg==
X-Google-Smtp-Source: ADFU+vtFieKyGNJ9KqnN3EoCxQgsVBEmvfaOunccLZ1q8zCqOqETx65ETyKQrf42+chQDK1+tHk1iw==
X-Received: by 2002:a62:fc07:: with SMTP id e7mr4906771pfh.299.1584634775181; 
 Thu, 19 Mar 2020 09:19:35 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id e9sm2978894pfl.179.2020.03.19.09.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 09:19:34 -0700 (PDT)
From: dnbrdsky@gmail.com
To: stefanha@gmail.com
Subject: [PATCH] misc: fix __COUNTER__ macro to be referenced properly
Date: Thu, 19 Mar 2020 09:19:24 -0700
Message-Id: <20200319161925.1818377-1-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
X-Mailman-Approved-At: Thu, 19 Mar 2020 13:49:29 -0400
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
Cc: danbrodsky <dnbrdsky@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: danbrodsky <dnbrdsky@gmail.com>

- __COUNTER__ doesn't work with ## concat
- replaced ## with glue() macro so __COUNTER__ is evaluated

Signed-off-by: danbrodsky <dnbrdsky@gmail.com>
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


