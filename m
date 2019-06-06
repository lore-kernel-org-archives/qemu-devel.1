Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB51C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:48:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41B520684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41B520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo4C-0008DD-2i
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:48:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYnyf-0003mZ-6q
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hYnsJ-0003W5-Ie
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:35:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:4990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hYnsJ-0003TJ-Ap
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:35:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	06 Jun 2019 01:35:55 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2019 01:35:54 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 16:34:58 +0800
Message-Id: <20190606083501.2087-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190606083501.2087-1-richardw.yang@linux.intel.com>
References: <20190606083501.2087-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [PATCH 3/6] migration/multifd: use sync field to
 synchronize send threads
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	quintela@redhat.com
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
index f9e53ac413..9982930392 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -640,6 +640,8 @@ typedef struct {
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
+    /* should sync this channel */
+    bool sync;
     /* should this thread finish */
     bool quit;
     /* thread has work to do */
@@ -1065,8 +1067,7 @@ static void multifd_send_sync_main(void)
         qemu_mutex_lock(&p->mutex);
 
         p->packet_num = multifd_send_state->packet_num++;
-        p->flags |= MULTIFD_FLAG_SYNC;
-        p->pending_job++;
+        p->sync = true;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
@@ -1129,10 +1130,27 @@ static void *multifd_send_thread(void *opaque)
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
 
-            if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&multifd_send_state->sem_sync);
-            }
             qemu_sem_post(&multifd_send_state->channels_ready);
+        } else if (p->sync) {
+            uint64_t packet_num = p->packet_num;
+            uint32_t flags = p->flags;
+            assert(!p->pages->used);
+
+            p->flags |= MULTIFD_FLAG_SYNC;
+            multifd_send_fill_packet(p);
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
+            qemu_sem_post(&multifd_send_state->sem_sync);
         } else if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
@@ -1196,7 +1214,7 @@ int multifd_save_setup(void)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
-        p->quit = false;
+        p->sync = p->quit = false;
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
-- 
2.19.1


