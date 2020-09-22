Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7DEC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5CC20756
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5CC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhHJ-0005W8-2y
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhD7-0000wU-A6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:15:53 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47460)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhD5-0006NE-It
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:15:52 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8044141B1032;
 Tue, 22 Sep 2020 12:15:49 +0000 (UTC)
Subject: [PATCH v5 02/15] replay: provide an accessor for rr filename
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 22 Sep 2020 15:15:49 +0300
Message-ID: <160077694915.10249.14893037100345813692.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 08:15:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds an accessor function for the name of the record/replay
log file. Adding an accessor instead of making variable global,
prevents accidental modification of this variable by other modules.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/sysemu/replay.h |    2 ++
 replay/replay.c         |    5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 5471bb514d..c9c896ae8d 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -72,6 +72,8 @@ void replay_start(void);
 void replay_finish(void);
 /*! Adds replay blocker with the specified error description */
 void replay_add_blocker(Error *reason);
+/* Returns name of the replay log file */
+const char *replay_get_filename(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay.c b/replay/replay.c
index 83ed9e0e24..42e82f7bc7 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -399,3 +399,8 @@ void replay_add_blocker(Error *reason)
 {
     replay_blockers = g_slist_prepend(replay_blockers, reason);
 }
+
+const char *replay_get_filename(void)
+{
+    return replay_filename;
+}


