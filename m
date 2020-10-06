Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB02EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6D720760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQPyvdHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6D720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhZ7-0006WE-Dg
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQQ-0003HN-Mh
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQO-0001Vt-T3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id v12so1934062wmh.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8fO4ARDu3GrDHWVTHIrUO17gWnruMRRKlI1vc8EA18k=;
 b=EQPyvdHlKqvgLsyLZq4GsMkMFz5Fp2bdZyKHdHFrAdcfDU817HHtJxubLzCNkn9jWM
 UnQ5SKg3kT49FT32VYlWlb63XUWqkgZ27yzuP1voCuFjR85e52oenvXdcUoam1hOG8/R
 4BmReNe5v1xeleICdNLbTlSJiTFparWq0WTMoWD3OGxUqTqP/ChEUo/mUAlLbwtCPCpk
 6q5O9F5J4XHi1LpM6oxMHmP/QrFWMGgzZPLFZQ8/bf4Wq0+Vk7m5HBtKWHB+A+UUULya
 k9MNkuTmOpTHteVWMlkomf1D5Pwt/bulrpAH/2Nbzn05WU5lp/6YWHDqxXHusfL36kUJ
 zArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8fO4ARDu3GrDHWVTHIrUO17gWnruMRRKlI1vc8EA18k=;
 b=HWAzCmgDgmYtegEqYi6j+TgXdNSHsAwRlX/o3/5N9ucYcNhxf5pAz3W5A6Jfr64OCc
 iU0EgO8bVoA9yoqFYnrv4bgVJlg8eX0Z6iTy6RBVI5zdcrajpLm9mha6/Bo5uvScIpm1
 W+WljLkSHxi5taQVtC1H4sWDW7ZmY56fdji8neb/wcvPf0W39/w2Bv8ejwhSygZmC/1m
 O8ZMaf8LSKV7h80576g75w+KHoV15vcibBuAy3Xl7m/1SYstDOYNAuAo8U/W0/CgUEqY
 D2GufpCptVHKkUrSbiHHzNYYc2Lrqb6yyaoozAwI12WjkhnP0DS7abbXP2vvMikTFkVJ
 TSLg==
X-Gm-Message-State: AOAM5315MGT+Zh508j48K0OIvViXfUTlsYSTqikg+StSFsXY/b/w+IYV
 Wv175jSeSQ059OA25TtQlTrGpiNYm1c=
X-Google-Smtp-Source: ABdhPJwRU6Pa+K/WBLxcuEdoAVNKb00M1JtebAkuzUGoc60SoQwLtZSXQOM8BGzwM+EiS7b3Lj3A9Q==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr3259932wmk.87.1601969415222;
 Tue, 06 Oct 2020 00:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/37] replay: flush rr queue before loading the vmstate
Date: Tue,  6 Oct 2020 09:29:42 +0200
Message-Id: <20201006072947.487729-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Non-empty record/replay queue prevents saving and loading the VM state,
because it includes pending bottom halves and block coroutines.
But when the new VM state is loaded, we don't have to preserve the consistency
of the current state anymore. Therefore this patch just flushes the queue
allowing the coroutines to finish and removes checking for empty rr queue
for load_snapshot function.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <160174521762.12451.15752448887893855757.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/replay.h  |  2 ++
 migration/savevm.c       | 12 ++++++------
 replay/replay-events.c   |  4 ++++
 replay/replay-internal.h |  2 --
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index d6026ed8e5..c486c3afb2 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -149,6 +149,8 @@ void replay_disable_events(void);
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
 bool replay_events_enabled(void);
+/* Flushes events queue */
+void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /* Adds oneshot bottom half event to the queue */
diff --git a/migration/savevm.c b/migration/savevm.c
index 0e8dc78684..d2e141f7b1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2881,12 +2881,6 @@ int load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!replay_can_snapshot()) {
-        error_setg(errp, "Record/replay does not allow loading snapshot "
-                   "right now. Try once more later.");
-        return -EINVAL;
-    }
-
     if (!bdrv_all_can_snapshot(&bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
@@ -2920,6 +2914,12 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
+    /*
+     * Flush the record/replay queue. Now the VM state is going
+     * to change. Therefore we don't need to preserve its consistency
+     */
+    replay_flush_events();
+
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
diff --git a/replay/replay-events.c b/replay/replay-events.c
index 302b84043a..a1c6bb934e 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -77,6 +77,10 @@ bool replay_has_events(void)
 
 void replay_flush_events(void)
 {
+    if (replay_mode == REPLAY_MODE_NONE) {
+        return;
+    }
+
     g_assert(replay_mutex_locked());
 
     while (!QTAILQ_EMPTY(&events_list)) {
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 2f6145ec7c..97649ed8d7 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -149,8 +149,6 @@ void replay_read_next_clock(unsigned int kind);
 void replay_init_events(void);
 /*! Clears internal data structures for events handling */
 void replay_finish_events(void);
-/*! Flushes events queue */
-void replay_flush_events(void);
 /*! Returns true if there are any unsaved events in the queue */
 bool replay_has_events(void);
 /*! Saves events from queue into the file */
-- 
2.26.2



