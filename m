Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F32CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C981F21872
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C981F21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAFQ-000550-AQ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADD-0002cd-BN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iOADC-0004lS-7D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:5552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iOADB-0004k9-WE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 20:45:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 17:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="204705111"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 17:45:44 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Subject: [PATCH v2 3/6] migration/multifd: use sync field to synchronize send
 threads
Date: Sat, 26 Oct 2019 08:45:17 +0800
Message-Id: <20191026004520.5515-4-richardw.yang@linux.intel.com>
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

Add a field in MultiFDSendParams to indicate there is a request to
synchronize send threads.

By doing so, send_thread will just post sem_sync on synchronization
request and channels_ready will not *overflow*.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 25d477796e..62072b7a35 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -641,6 +641,8 @@ typedef struct {
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
+    /* should sync this channel */
+    bool sync;
     /* should this thread finish */
     bool quit;
     /* thread has work to do */
@@ -1074,8 +1076,7 @@ static void multifd_send_sync_main(RAMState *rs)
         }
 
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
+        p->sync = true;
         qemu_file_update_transfer(rs->f, p->packet_len);
         ram_counters.multifd_bytes += p->packet_len;
         ram_counters.transferred += p->packet_len;
@@ -1143,10 +1144,27 @@ static void *multifd_send_thread(void *opaque)
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&p->sem_sync);
-            }
             qemu_sem_post(&multifd_send_state->channels_ready);
+        } else if (p->sync) {
+            uint64_t packet_num = p->packet_num;
+            uint32_t flags = p->flags;
+            assert(!p->pages->used);
+
+            p->flags |= MULTIFD_FLAG_SYNC;
+            multifd_send_fill_packet(p, 0);
+            p->sync = false;
+            qemu_mutex_unlock(&p->mutex);
+
+            trace_multifd_send(p->id, packet_num, 0, flags | MULTIFD_FLAG_SYNC,
+                               p->next_packet_size);
+
+            ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                        p->packet_len, &local_err);
+            if (ret != 0) {
+                break;
+            }
+
+            qemu_sem_post(&p->sem_sync);
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
@@ -1221,7 +1239,7 @@ int multifd_save_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
+        p->quit = p->sync = false;
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
-- 
2.17.1


