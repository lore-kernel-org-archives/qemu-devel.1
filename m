Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE88C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E4C206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 11:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E4C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIX5C-0004IQ-3B
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 07:25:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0U-0000fd-RR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0T-0002DX-Tb
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:06 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47162)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX0T-0002DJ-Mg
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:21:05 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id C403E5400A9;
	Mon, 22 Apr 2019 14:21:04 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 14:21:04 +0300
Message-ID:
 <155593206457.21079.15944638671484581822.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.1 15/24] replay: flush rr queue before
 loading the vmstate
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	pavel.dovgaluk@ispras.ru, pbonzini@redhat.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, armbru@redhat.com,
	mreitz@redhat.com, alex.bennee@linaro.org,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	boost.lists@gmail.com, thomas.dullien@googlemail.com,
	dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
	dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422112104.pw1qnHkp2nRo9FskYJ8TysZeRdeAHU8IZ7fEwmdVtLI@z>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Non-empty record/replay queue prevents saving and loading the VM state,
because it includes pending bottom halves and block coroutines.
But when the new VM state is loaded, we don't have to preserve the consistency
of the current state anymore. Therefore this patch just flushes the queue
allowing the coroutines to finish.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 include/sysemu/replay.h  |    2 ++
 migration/savevm.c       |    6 ++++++
 replay/replay-internal.h |    2 --
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 3fe14b5f57..d7e859d915 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -140,6 +140,8 @@ void replay_disable_events(void);
 void replay_enable_events(void);
 /*! Returns true when saving events is enabled */
 bool replay_events_enabled(void);
+/* Flushes events queue */
+void replay_flush_events(void);
 /*! Adds bottom half event to the queue */
 void replay_bh_schedule_event(QEMUBH *bh);
 /*! Adds input event to the queue */
diff --git a/migration/savevm.c b/migration/savevm.c
index 51ab224d25..2198d61b81 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2788,6 +2788,12 @@ int load_snapshot(const char *name, Error **errp)
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
 
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 8c15a41350..945802361b 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -146,8 +146,6 @@ void replay_read_next_clock(unsigned int kind);
 void replay_init_events(void);
 /*! Clears internal data structures for events handling */
 void replay_finish_events(void);
-/*! Flushes events queue */
-void replay_flush_events(void);
 /*! Returns true if there are any unsaved events in the queue */
 bool replay_has_events(void);
 /*! Saves events from queue into the file */


