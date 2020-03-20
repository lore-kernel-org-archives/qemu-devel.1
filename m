Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1CFC4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29ACB20732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi92YvEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ACB20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGQF-0001Hc-AT
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPI-0000D8-TX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGPH-0008IC-Rj
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jFGPH-0008Hv-M4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:05:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id h11so2393355plr.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DFZU6y1FUNjWETl8iut0I7iFRsUd4Hl2jMI8hhwl6Dk=;
 b=fi92YvEC+iVIjYMk98K6HFHp7Ya4ixOFNxSnctpca9nAhsvynJIjiN0jQ5h7o7xrdz
 V42g2bADwIomER2cjeHbXuYcdIzTMXdk0Uy6QhF2xnlXoqVKM7qCQHCVVWw6K2sr7Qqw
 q1TaaQoVynBxQo5sxfIBod7zpENErvKVtb913LdgPD+bZ4+uPHdo5bMB5RXQR80A5ejP
 ih/aG7x1ShagTdYjEKlcrrHUCVydP3otNrAKDz8/Oe5xB6fdvqruSmCugMj6RHJCYzXW
 VxkvyqCggJUTVXoDETikxnT6RY9qKuHAfSlHLLDidu7ECcH3JnjOWepgcgObPp6YoSjV
 r6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DFZU6y1FUNjWETl8iut0I7iFRsUd4Hl2jMI8hhwl6Dk=;
 b=IICkqt1qDNB+5lefi0Y53x+/V262WrwXPiMrrcXA3Xj7CeAF7reErAeuURoZ+bWu/K
 aDa5lApscV8qo3UpB+4QVorVgxf5WFNu+QkozIhGz4ff3uffsvm1/Id+j/ZZrQc2DavS
 07p7moN4EP85R5rOlRXYCbuGX2GqQbgHimxiOSdi10xZNFxlwnXIHrHB5lz6igtVqsj+
 L6gMnpaFjtVlfJ+IDjtQC7lKTjfZeFsriIkNPwvzottAyqDEMdDHqNdO/MdqglsdTy5v
 7rfxB0aH0TdT3B0nXpb1ALTgy//yb6Suslq/Xvde0E44MzFuQZTT/e3xAeYyrPwUTCt3
 AbBQ==
X-Gm-Message-State: ANhLgQ1A4URDij9oVCdy7d+3TUAjqiskeLEfPMu2QT2yvidLfsF0bs6Z
 wrmGmRhOkK8G5uqYHNiR1Sw=
X-Google-Smtp-Source: ADFU+vsyXycinhV60/ilCb3UrmJ7JHzUin5FTcxLCK9hBgz4UAK3Zjl/ox1fBppolWZPfTSlo09Vmw==
X-Received: by 2002:a17:90a:5d16:: with SMTP id
 s22mr3605160pji.184.1584705942649; 
 Fri, 20 Mar 2020 05:05:42 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id z125sm5617660pfz.92.2020.03.20.05.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 05:05:42 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v3 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
Date: Fri, 20 Mar 2020 05:04:55 -0700
Message-Id: <20200320120456.1931482-2-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320120456.1931482-1-dnbrdsky@gmail.com>
References: <20200320120456.1931482-1-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::631
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
Cc: qemu-devel@nongnu.org
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


