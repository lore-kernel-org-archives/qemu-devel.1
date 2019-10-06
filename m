Return-Path: <SRS0=2u83=X7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0187C4740A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9671F222C0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2019 00:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9671F222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGu3H-0007s9-Cr
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 20:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGu1C-0006I8-Ji
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iGu1B-0001l3-Ic
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:03:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:11793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iGu1B-0001kY-AT
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 20:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Oct 2019 17:03:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; d="scan'208";a="191929247"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 05 Oct 2019 17:03:20 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 3/3] migration/postcopy: replace have_listen_thread check with
 PostcopyState check
Date: Sun,  6 Oct 2019 08:02:49 +0800
Message-Id: <20191006000249.29926-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191006000249.29926-1-richardw.yang@linux.intel.com>
References: <20191006000249.29926-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After previous cleanup, postcopy thread is running only when
PostcopyState is LISTENNING or RUNNING. This means it is not necessary
to spare a variable have_listen_thread to represent the state.

Replace the check on have_listen_thread with PostcopyState and remove
the variable.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.h | 1 -
 migration/ram.c       | 2 +-
 migration/ram.h       | 1 +
 migration/savevm.c    | 4 +---
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 4f2fe193dc..a4d639663d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -63,7 +63,6 @@ struct MigrationIncomingState {
     /* Set this when we want the fault thread to quit */
     bool           fault_thread_quit;
 
-    bool           have_listen_thread;
     QemuThread     listen_thread;
     QemuSemaphore  listen_thread_sem;
 
diff --git a/migration/ram.c b/migration/ram.c
index 769d3f6454..dfc50d57d5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4188,7 +4188,7 @@ static bool postcopy_is_advised(void)
     return ps >= POSTCOPY_INCOMING_ADVISE && ps < POSTCOPY_INCOMING_END;
 }
 
-static bool postcopy_is_running(void)
+bool postcopy_is_running(void)
 {
     PostcopyState ps = postcopy_state_get();
     return ps >= POSTCOPY_INCOMING_LISTENING && ps < POSTCOPY_INCOMING_END;
diff --git a/migration/ram.h b/migration/ram.h
index bd0eee79b6..44fe4753ad 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -59,6 +59,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
 /* For incoming postcopy discard */
 int ram_discard_range(const char *block_name, uint64_t start, size_t length);
 int ram_postcopy_incoming_init(MigrationIncomingState *mis);
+bool postcopy_is_running(void);
 
 void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index dcad8897a3..2a0e0b94df 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1836,7 +1836,6 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_loadvm_state_cleanup();
 
     rcu_unregister_thread();
-    mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END, NULL);
 
     return NULL;
@@ -1880,7 +1879,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
         return -1;
     }
 
-    mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
@@ -2518,7 +2516,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     trace_qemu_loadvm_state_post_main(ret);
 
-    if (mis->have_listen_thread) {
+    if (postcopy_is_running()) {
         /* Listen thread still going, can't clean up yet */
         return ret;
     }
-- 
2.17.1


