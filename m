Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE5A21872
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE5A21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAHL-0002Y3-VK
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADG-0002hU-06
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADE-0004mN-Vy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:5552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iOADE-0004k9-NS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 17:45:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="204705117"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 17:45:47 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH v2 5/6] migration/multifd: use boolean for pending_job is
 enough
Date: Sat, 26 Oct 2019 08:45:19 +0800
Message-Id: <20191026004520.5515-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026004520.5515-1-richardw.yang@linux.intel.com>
References: <20191026004520.5515-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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

After synchronization request is handled in another case, there only
could be one pending_job for one send thread at most.

This is fine to use boolean to represent this behavior.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 12c270e86d..fccdbfabc5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -646,7 +646,7 @@ typedef struct {
     /* should this thread finish */
     bool quit;
     /* thread has work to do */
-    int pending_job;
+    bool pending_job;
     /* array of pages to sent */
     MultiFDPages_t *pages;
     /* packet allocated len */
@@ -933,7 +933,7 @@ static int multifd_send_pages(RAMState *rs)
             return -1;
         }
         if (!p->pending_job) {
-            p->pending_job++;
+            p->pending_job = true;
             next_channel = (i + 1) % migrate_multifd_channels();
             break;
         }
@@ -1140,7 +1140,7 @@ static void *multifd_send_thread(void *opaque)
             }
 
             qemu_mutex_lock(&p->mutex);
-            p->pending_job--;
+            p->pending_job = false;
             qemu_mutex_unlock(&p->mutex);
 
             qemu_sem_post(&multifd_send_state->channels_ready);
@@ -1238,8 +1238,7 @@ int multifd_save_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = p->sync = false;
-        p->pending_job = 0;
+        p->quit = p->sync = p->pending_job = false;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
         p->packet_len = sizeof(MultiFDPacket_t)
-- 
2.17.1


