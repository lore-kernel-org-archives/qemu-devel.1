Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF7C04AB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AF620823
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 01:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVRH2-0003l6-Te
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 21:51:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hVRDZ-00017E-6i
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hVRDX-0003hm-5S
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:47:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:31236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hVRDW-0003YP-RC
	for qemu-devel@nongnu.org; Mon, 27 May 2019 21:47:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 May 2019 18:47:53 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga006.jf.intel.com with ESMTP; 27 May 2019 18:47:52 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 09:47:03 +0800
Message-Id: <20190528014703.21030-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190528014703.21030-1-richardw.yang@linux.intel.com>
References: <20190528014703.21030-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH 4/4] migration/ram.c: multifd_send_state->count
 is not really used
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

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5d31f7bd4c..c9a9f7489b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -892,8 +892,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
 
 struct {
     MultiFDSendParams *params;
-    /* number of created threads */
-    int count;
     /* array of pages to sent */
     MultiFDPages_t *pages;
     /* syncs main thread and channels */
@@ -1171,8 +1169,6 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->running = true;
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                            QEMU_THREAD_JOINABLE);
-
-        atomic_inc(&multifd_send_state->count);
     }
 }
 
@@ -1188,7 +1184,6 @@ int multifd_save_setup(void)
     thread_count = migrate_multifd_channels();
     multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
-    atomic_set(&multifd_send_state->count, 0);
     multifd_send_state->pages = multifd_pages_init(page_count);
     qemu_sem_init(&multifd_send_state->sem_sync, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
-- 
2.19.1


