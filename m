Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC73C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4399C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4399C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFF5l-0006MD-C9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEzs-0001PE-Vc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iFEzq-00062d-Lo
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:10068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iFEzq-00060e-BF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:03:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 03:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; d="scan'208";a="195599679"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga006.jf.intel.com with ESMTP; 01 Oct 2019 03:03:03 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH 3/3] migration/postcopy: handle POSTCOPY_INCOMING_RUNNING
 corner case properly
Date: Tue,  1 Oct 2019 18:01:22 +0800
Message-Id: <20191001100122.17730-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001100122.17730-1-richardw.yang@linux.intel.com>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
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

Currently, we set PostcopyState blindly to RUNNING, even we found the
previous state is not LISTENING. This will lead to a corner case.

First let's look at the code flow:

qemu_loadvm_state_main()
    ret = loadvm_process_command()
        loadvm_postcopy_handle_run()
            return -1;
    if (ret < 0) {
        if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING)
            ...
    }

From above snippet, the corner case is loadvm_postcopy_handle_run()
always sets state to RUNNING. And then it checks the previous state. If
the previous state is not LISTENING, it will return -1. But at this
moment, PostcopyState is already been set to RUNNING.

Then ret is checked in qemu_loadvm_state_main(), when it is -1
PostcopyState is checked. Current logic would pause postcopy and retry
if PostcopyState is RUNNING. This is not what we expect, because
postcopy is not active yet.

This patch makes sure state is set to RUNNING only previous state is
LISTENING by introducing an old_state parameter in postcopy_state_set().
New state only would be set when current state equals to old_state.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/migration.c    |  2 +-
 migration/postcopy-ram.c | 13 +++++++++----
 migration/postcopy-ram.h |  3 ++-
 migration/savevm.c       | 11 ++++++-----
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 34d5e66f06..369cf3826e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -447,7 +447,7 @@ static void process_incoming_migration_co(void *opaque)
     assert(mis->from_src_file);
     mis->migration_incoming_co = qemu_coroutine_self();
     mis->largest_page_size = qemu_ram_pagesize_largest();
-    postcopy_state_set(POSTCOPY_INCOMING_NONE);
+    postcopy_state_set(POSTCOPY_INCOMING_NONE, NULL);
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_ACTIVE);
     ret = qemu_loadvm_state(mis->from_src_file);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index b24c4a10c2..8f741d636d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -577,7 +577,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         }
     }
 
-    postcopy_state_set(POSTCOPY_INCOMING_END);
+    postcopy_state_set(POSTCOPY_INCOMING_END, NULL);
 
     if (mis->postcopy_tmp_page) {
         munmap(mis->postcopy_tmp_page, mis->largest_page_size);
@@ -626,7 +626,7 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
         return -1;
     }
 
-    postcopy_state_set(POSTCOPY_INCOMING_DISCARD);
+    postcopy_state_set(POSTCOPY_INCOMING_DISCARD, NULL);
 
     return 0;
 }
@@ -1457,9 +1457,14 @@ PostcopyState  postcopy_state_get(void)
 }
 
 /* Set the state and return the old state */
-PostcopyState postcopy_state_set(PostcopyState new_state)
+PostcopyState postcopy_state_set(PostcopyState new_state,
+                                 const PostcopyState *old_state)
 {
-    return atomic_xchg(&incoming_postcopy_state, new_state);
+    if (!old_state) {
+        return atomic_xchg(&incoming_postcopy_state, new_state);
+    } else {
+        return atomic_cmpxchg(&incoming_postcopy_state, *old_state, new_state);
+    }
 }
 
 /* Register a handler for external shared memory postcopy
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index d2668cc820..e3dde32155 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -109,7 +109,8 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis);
 
 PostcopyState postcopy_state_get(void);
 /* Set the state and return the old state */
-PostcopyState postcopy_state_set(PostcopyState new_state);
+PostcopyState postcopy_state_set(PostcopyState new_state,
+                                 const PostcopyState *old_state);
 
 void postcopy_fault_thread_notify(MigrationIncomingState *mis);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f3292eb003..45474d9c95 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1599,7 +1599,7 @@ enum LoadVMExitCodes {
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
                                          uint16_t len)
 {
-    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
+    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE, NULL);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
     Error *local_err = NULL;
 
@@ -1628,7 +1628,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
     }
 
     if (!postcopy_ram_supported_by_host(mis)) {
-        postcopy_state_set(POSTCOPY_INCOMING_NONE);
+        postcopy_state_set(POSTCOPY_INCOMING_NONE, NULL);
         return -1;
     }
 
@@ -1841,7 +1841,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 /* After this message we must be able to immediately receive postcopy data */
 static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
 {
-    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
+    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING, NULL);
     trace_loadvm_postcopy_handle_listen();
     Error *local_err = NULL;
 
@@ -1929,10 +1929,11 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 /* After all discards we can start running and asking for pages */
 static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 {
-    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
+    PostcopyState old_ps = POSTCOPY_INCOMING_LISTENING;
+    PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING, &old_ps);
 
     trace_loadvm_postcopy_handle_run();
-    if (ps != POSTCOPY_INCOMING_LISTENING) {
+    if (ps != old_ps) {
         error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
-- 
2.17.1


