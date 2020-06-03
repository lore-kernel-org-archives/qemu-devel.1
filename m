Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75691C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EA72145D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 23:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EA72145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgcOC-0004Ag-He
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcMk-0002aM-8T; Wed, 03 Jun 2020 19:00:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:40154)
 by eggs.gnu.org with esmtps (TLS1.1:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <joe.slater@windriver.com>)
 id 1jgcMh-0005bh-Oi; Wed, 03 Jun 2020 19:00:09 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 053MnQZl008733
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
 Wed, 3 Jun 2020 15:49:27 -0700 (PDT)
Received: from ala-lpggp3.wrs.com (147.11.105.124) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 3 Jun 2020 15:49:26 -0700
From: Joe Slater <joe.slater@windriver.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] lockable: do not rely on optimization for null lockables
Date: Wed, 3 Jun 2020 15:49:03 -0700
Message-ID: <20200603224903.26268-3-joe.slater@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603224903.26268-1-joe.slater@windriver.com>
References: <20200603224903.26268-1-joe.slater@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=147.11.1.11;
 envelope-from=joe.slater@windriver.com; helo=mail.windriver.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 18:49:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we use QLNULL for null lockables, we can always
use referencing unknown_lock_type as a link time
error indicator.

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 include/qemu/lockable.h | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
index 7f7aebb..7fc5750 100644
--- a/include/qemu/lockable.h
+++ b/include/qemu/lockable.h
@@ -24,21 +24,14 @@ struct QemuLockable {
     QemuLockUnlockFunc *unlock;
 };
 
-#define QLNULL ((QemuLockable *)0)
-
-
-/* This function gives an error if an invalid, non-NULL pointer type is passed
- * to QEMU_MAKE_LOCKABLE.  For optimized builds, we can rely on dead-code elimination
- * from the compiler, and give the errors already at link time.
+/*
+ *  If unknown_lock_type() is referenced, it means we have tried to passed something
+ *  not recognized as lockable to the macros below.  Use QLNULL to intentionally pass
+ *  a null lockable.
  */
-#if defined(__OPTIMIZE__) && !defined(__SANITIZE_ADDRESS__)
+#define QLNULL ((QemuLockable *)0)
 void unknown_lock_type(void *);
-#else
-static inline void unknown_lock_type(void *unused)
-{
-    abort();
-}
-#endif
+
 
 static inline __attribute__((__always_inline__)) QemuLockable *
 qemu_make_lockable(void *x, QemuLockable *lockable)
-- 
2.7.4


