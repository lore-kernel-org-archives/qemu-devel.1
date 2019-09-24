Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC49C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289C020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pKPeRsF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289C020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCs6v-00045J-4V
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002Zv-K1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0004Ux-Nb
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvy-0004Sx-Nk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id n14so3613631wrw.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpjzxuCVbEO2kl81iU00jC8CtR9OdcVESI3+fE5EiS0=;
 b=pKPeRsF/oGKSNDTR34gOEPv2+ulkAyGB0bnajyyGqYscVH+DrRsMorWiOrR3ZfnQ7h
 LC+RCn3sXVaqzmUcImoWYFqs2UVYcusj9Sf9e60bVipgIYSWFzsTbf2sS8h2WhieTx46
 K/X0N+s1kHb1X+Aq4BdpnuV3W3hrM2U+pewTuLrafZzKZTXaT/t2nFQDJ/nRW8fi7PR4
 T+QJhooXdb1GzRDTF6hR7UXZf4srjw9kexP+L0KK4gatIL/6g2P/ZtLlRc2puk6/efNV
 VCLHm8lgtnTvFxUqrLExW3VkH6g9P4U6iOSMONiJ8A5y+po5Rde8c3JXYG6FjeK4KapS
 NVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpjzxuCVbEO2kl81iU00jC8CtR9OdcVESI3+fE5EiS0=;
 b=Eq5xM6FWt3PjqTKpb/l5hFwVM31XPymiNpP8QruVz956IKxTqO79TlF3+hPCRInnB4
 GTVRICe49ch9rtJz3UnTaWiKLVZOScVaiZSncYgH6HhiL1Ea7m43dVfv0ahyIU/o8Yf9
 nOappNwjJH8MhbdAP1tUXjhuwu/DlMTo1yxm42+3XJ8If3tpcRG0PV+f3fAniULSQ+rt
 MGu6W4YxYx3548jjpPqjXS4nEaLjc+N99nZZPGUUwA1bDzIxaBgmlnjMrE0M6HAJuZsx
 gfVPI0lWh/XtGiIxtn72RFz+TMHg6unbAYFNTSEDfTy+XgbuNqbGRZe1Rt+zjFArsGlU
 eGmw==
X-Gm-Message-State: APjAAAUzDKY2AqDaEWQD+92wgH8halgXrDNLCh9bTE7+pFvmS5qieGXc
 oycY2ssEEjDg/oXk+TWQT6mnEw==
X-Google-Smtp-Source: APXvYqzJ0+Kptgtx/JiJfBV5wIvbPP563fbIS/GNxnoxq4hz2ZUhXut5b5NDY2CyvGqxMPLCTskKSw==
X-Received: by 2002:adf:a50d:: with SMTP id i13mr4561123wrb.152.1569358874310; 
 Tue, 24 Sep 2019 14:01:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l10sm4654530wrh.20.2019.09.24.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 892C01FF98;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/33] tests/migration: Fail on unexpected migration states
Date: Tue, 24 Sep 2019 22:00:41 +0100
Message-Id: <20190924210106.27117-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, jsnow@redhat.com, f4bug@amsat.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've got various places where we wait for a migration to enter
a given state; but if we enter an unexpected state we tend to fail
in odd ways; add a mechanism for explicitly testing for any state
which we shouldn't be in.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190923131022.15498-2-dgilbert@redhat.com>
---
 tests/migration-test.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 258aa064d48..9c62ee5331b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -255,15 +255,19 @@ static void read_blocktime(QTestState *who)
 }
 
 static void wait_for_migration_status(QTestState *who,
-                                      const char *goal)
+                                      const char *goal,
+                                      const char **ungoals)
 {
     while (true) {
         bool completed;
         char *status;
+        const char **ungoal;
 
         status = migrate_query_status(who);
         completed = strcmp(status, goal) == 0;
-        g_assert_cmpstr(status, !=,  "failed");
+        for (ungoal = ungoals; *ungoal; ungoal++) {
+            g_assert_cmpstr(status, !=,  *ungoal);
+        }
         g_free(status);
         if (completed) {
             return;
@@ -274,7 +278,8 @@ static void wait_for_migration_status(QTestState *who,
 
 static void wait_for_migration_complete(QTestState *who)
 {
-    wait_for_migration_status(who, "completed");
+    wait_for_migration_status(who, "completed",
+                              (const char * []) { "failed", NULL });
 }
 
 static void wait_for_migration_pass(QTestState *who)
@@ -809,7 +814,9 @@ static void test_postcopy_recovery(void)
      * Wait until postcopy is really started; we can only run the
      * migrate-pause command during a postcopy
      */
-    wait_for_migration_status(from, "postcopy-active");
+    wait_for_migration_status(from, "postcopy-active",
+                              (const char * []) { "failed",
+                                                  "completed", NULL });
 
     /*
      * Manually stop the postcopy migration. This emulates a network
@@ -822,7 +829,9 @@ static void test_postcopy_recovery(void)
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused");
+    wait_for_migration_status(to, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -836,7 +845,9 @@ static void test_postcopy_recovery(void)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused");
+    wait_for_migration_status(from, "postcopy-paused",
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
     migrate(from, uri, "{'resume': true}");
     g_free(uri);
 
-- 
2.20.1


