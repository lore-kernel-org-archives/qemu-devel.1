Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A560C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 04:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494D62051A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 04:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfc9HIrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494D62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKaJv-0007Kk-F0
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 00:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ5-0006B3-AV
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ4-0005Dy-1r
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:19 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ3-0005DN-Sw
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:18 -0400
Received: by mail-pg1-x543.google.com with SMTP id o26so4595479pgc.12
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nWeGXS7WL3l3NDU7ev51tis49vFdTNvDe5Ybx9a0DK0=;
 b=mfc9HIrbNt+JDuoYq2MH4Y3M58z/4lPaPmTpCC9j43fe1j7jtSY/ELWYwJrkweOzyU
 kRpwq3fGXlzxs3uH8AFp3T1BJmZU5/ELoQc7CbnhbgOSk8lwDTQQaBwC318rYFp439nh
 H88ranldIMhUlc+BH9Ybnr2X3P+gXIGsqO6+zHcp0xeN2F/dUvPV49kKufUQi1nNoGUc
 55KXhrGsMJZrhb+mrCrq2QGGtEwRWsHsmGVNiHqDCHGM40GqYY7pcD8+nSCL7X7vabBd
 NZrB9BobPkopPTHukNMozg6AqwttQLFMWvEn25gct4wJw69ikH7PlruEbFiCJu9xgxYi
 r5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nWeGXS7WL3l3NDU7ev51tis49vFdTNvDe5Ybx9a0DK0=;
 b=TyBFCyp9JWsTzf64vcYEzOxjI0sZgeRy97MwnsymPNm9mbil4TTq7O60amAU9AFeab
 VX087o8lrdSGK7O9TTfMt2qb1yK/T++wSVKnFm3g8sibXh4w8HqxoishU25Zd9MW6yVj
 y40FL3awP8nk0Vlggc4la33MzkU37FIJ9eMppe34UweLJhFLUezdCQXSqWB0+KUXTMyc
 YiF6+AIQBKlP4D7LG7DZjXE53Gnho9ePKoiuDYxMPC79LiJ8hc1cAHEfopLvl0NSDV1k
 NLwKyKq8KMDHUn1+gONNLqYGZvcp0vKR9tohSMEhmKLxABW2t+ZEaOPyh0gTq/SDkaH6
 M/7Q==
X-Gm-Message-State: AGi0PuZwPalrJwGeX/jSlKhkLBcXpZ/uwbatGTNvF8QXWN8zXsb+fup/
 E4nPtEbwHJXqzq7e9lxhUj3TU73OVSw=
X-Google-Smtp-Source: APiQypJWgImXZzUXebK1tWyOBrW40g8R3Sx0qZY086n55S93OBWY6iV/yCyhAQJ5ayw6EhmTX1Cu/w==
X-Received: by 2002:a62:5187:: with SMTP id
 f129mr11953775pfb.144.1585974076814; 
 Fri, 03 Apr 2020 21:21:16 -0700 (PDT)
Received: from esc.telus (d216-232-186-112.bchsia.telus.net. [216.232.186.112])
 by smtp.gmail.com with ESMTPSA id 189sm6746048pfg.170.2020.04.03.21.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 21:21:16 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v5 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
Date: Fri,  3 Apr 2020 21:21:07 -0700
Message-Id: <20200404042108.389635-2-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200404042108.389635-1-dnbrdsky@gmail.com>
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
 include/qemu/lockable.h | 7 ++++---
 include/qemu/rcu.h      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 1aeb2cb1a6..b620023141 100644
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
@@ -169,8 +169,9 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuLockable, qemu_lockable_auto_unlock)
  *       return; <-- mutex is automatically unlocked
  *   }
  */
-#define QEMU_LOCK_GUARD(x) \
-    g_autoptr(QemuLockable) qemu_lockable_auto##__COUNTER__ = \
+#define QEMU_LOCK_GUARD(x)                                       \
+    g_autoptr(QemuLockable)                                      \
+    glue(qemu_lockable_auto, __COUNTER__) G_GNUC_UNUSED =        \
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
2.26.0


