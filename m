Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15B8C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21FD2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF0QR8BN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21FD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGqA-00042Q-Rp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGoh-0002Wo-8W
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGog-0000cg-9x
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:31:59 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:37340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jFGog-0000cO-4c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:31:58 -0400
Received: by mail-pf1-x434.google.com with SMTP id h72so940481pfe.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DFZU6y1FUNjWETl8iut0I7iFRsUd4Hl2jMI8hhwl6Dk=;
 b=BF0QR8BNJf7jCMvjwD2Hb75duT2OBpKxIE03GwIVDIe9dU/Vhvq0iayysCCNXKWOun
 NjQq0NaP/EsyWwJxTJ3FMem2wxJwdxqRziSI/a8Rku0Ciauqw4wWo4RSlYRwgU7VNvTC
 ESYP15AIzwhc23TI23FCBDCG7dymakibVqcZCG9GbFLWuN0X/QBCpizFHJBOxGhyLIT/
 6dFIrCDBat7Y5APtX6QevIGcAH/NO+E3Q+xn/yn7IZQ5gZUzmS9vt7QVRBsk71y/Tt35
 fL21IwCAWxu1YvqAWbRuJxKi70bXKzd0zNW2nmrnpHEaLCan8oU9E0a1W6qBTZQxodDV
 2baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DFZU6y1FUNjWETl8iut0I7iFRsUd4Hl2jMI8hhwl6Dk=;
 b=prD/oEUAmcvwJQmz0UkND9SEGoftorOQ31U0OuXzTBZPKvvCyK2Dhmna4accBnQyb/
 HUucOAzMMmWckg42PaTnQiUnODRIpMM7n/HvfPsqyhqPh/X1pwLIS4Fsci/PcaAs0yMd
 n17Y0FMnK5r+85iHWKIUFCAF8y6Ly2UgrEDbX7VEb0z3ZQvqpWQhdFXF8pj68Gte7CQj
 CbcXt3OItO68t0oqqp2N2cbeLrPGTWr/UIp06i2VLo4bZfBTMhy5H3O4LuBa1j2jX2U+
 yrNhVvg+2aWnv2KZVAxNBl4haw9CynwC42Yee0l3AxUJcoe+GOIpa/kBvePLf4e3gWNT
 Meag==
X-Gm-Message-State: ANhLgQ35DT3zqbXlsNN59dLLudqLuaMVjrYHTcQUtNimQaJiCj+l6FvJ
 NaWUGlN6VFEgWFhpmOYL3gjU1PzlmSPZfw==
X-Google-Smtp-Source: ADFU+vs+69zZJRKphVeb4MDXoIl+XNoC0Q5QxOT3IEUjBs4XCa6pFJHpnhQTnqJjxD1quHWgpMW/cg==
X-Received: by 2002:aa7:87ca:: with SMTP id i10mr9452119pfo.169.1584707517179; 
 Fri, 20 Mar 2020 05:31:57 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id 1sm4766550pjo.10.2020.03.20.05.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 05:31:56 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v4 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
Date: Fri, 20 Mar 2020 05:31:36 -0700
Message-Id: <20200320123137.1937091-2-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320123137.1937091-1-dnbrdsky@gmail.com>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Brodsky <dnbrdsky@gmail.com>

- __COUNTER__ doesn't work with ## concat
- replaced ## with glue() macro so __COUNTER__ is evaluated

Fixes: 3284c3ddc4

Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
---
 include/qemu/lockable.h | 4 ++--
 include/qemu/rcu.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 1aeb2cb1a6..71cda060e4 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -152,7 +152,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
  *   }
  */
 #define WITH_QEMU_LOCK_GUARD(x) \
-    WITH_QEMU_LOCK_GUARD_((x), qemu_lockable_auto##__COUNTER__)
+    WITH_QEMU_LOCK_GUARD_((x), glue(qemu_lockable_auto, __COUNTER__))
 
 /**
  * QEMU_LOCK_GUARD - Lock an object until the end of the scope
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


