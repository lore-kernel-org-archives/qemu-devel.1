Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC3C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBB12075E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBB12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqE0V-0007Oh-0I
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53956)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqDzt-0004zO-V3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqDzs-0004O8-MM
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqDzr-0004M7-7S
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 302C859465;
 Wed, 24 Jul 2019 09:55:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEC0160BEC;
 Wed, 24 Jul 2019 09:55:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 11:55:20 +0200
Message-Id: <20190724095523.1527-2-quintela@redhat.com>
In-Reply-To: <20190724095523.1527-1-quintela@redhat.com>
References: <20190724095523.1527-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 24 Jul 2019 09:55:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] migration: fix migrate_cancel leads
 live_migration thread endless loop
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
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ivan Ren <renyime@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ivan Ren <ivanren@tencent.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <renyime@gmail.com>

When we 'migrate_cancel' a multifd migration, live_migration thread may
go into endless loop in multifd_send_pages functions.

Reproduce steps:

(qemu) migrate_set_capability multifd on
(qemu) migrate -d url
(qemu) [wait a while]
(qemu) migrate_cancel

Then may get live_migration 100% cpu usage in following stack:

pthread_mutex_lock
qemu_mutex_lock_impl
multifd_send_pages
multifd_queue_page
ram_save_multifd_page
ram_save_target_page
ram_save_host_page
ram_find_and_save_block
ram_find_and_save_block
ram_save_iterate
qemu_savevm_state_iterate
migration_iteration_run
migration_thread
qemu_thread_start
start_thread
clone

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Message-Id: <1561468699-9819-2-git-send-email-ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2b0774c2bf..52a2d498e4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -920,7 +920,7 @@ struct {
  * false.
  */
=20
-static void multifd_send_pages(void)
+static int multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -933,6 +933,11 @@ static void multifd_send_pages(void)
         p =3D &multifd_send_state->params[i];
=20
         qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            error_report("%s: channel %d has already quit!", __func__, i=
);
+            qemu_mutex_unlock(&p->mutex);
+            return -1;
+        }
         if (!p->pending_job) {
             p->pending_job++;
             next_channel =3D (i + 1) % migrate_multifd_channels();
@@ -951,9 +956,11 @@ static void multifd_send_pages(void)
     ram_counters.transferred +=3D transferred;;
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
+
+    return 1;
 }
=20
-static void multifd_queue_page(RAMBlock *block, ram_addr_t offset)
+static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
 {
     MultiFDPages_t *pages =3D multifd_send_state->pages;
=20
@@ -968,15 +975,19 @@ static void multifd_queue_page(RAMBlock *block, ram=
_addr_t offset)
         pages->used++;
=20
         if (pages->used < pages->allocated) {
-            return;
+            return 1;
         }
     }
=20
-    multifd_send_pages();
+    if (multifd_send_pages() < 0) {
+        return -1;
+    }
=20
     if (pages->block !=3D block) {
-        multifd_queue_page(block, offset);
+        return  multifd_queue_page(block, offset);
     }
+
+    return 1;
 }
=20
 static void multifd_send_terminate_threads(Error *err)
@@ -1049,7 +1060,10 @@ static void multifd_send_sync_main(void)
         return;
     }
     if (multifd_send_state->pages->used) {
-        multifd_send_pages();
+        if (multifd_send_pages() < 0) {
+            error_report("%s: multifd_send_pages fail", __func__);
+            return;
+        }
     }
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
@@ -1058,6 +1072,12 @@ static void multifd_send_sync_main(void)
=20
         qemu_mutex_lock(&p->mutex);
=20
+        if (p->quit) {
+            error_report("%s: channel %d has already quit", __func__, i)=
;
+            qemu_mutex_unlock(&p->mutex);
+            return;
+        }
+
         p->packet_num =3D multifd_send_state->packet_num++;
         p->flags |=3D MULTIFD_FLAG_SYNC;
         p->pending_job++;
@@ -2033,7 +2053,9 @@ static int ram_save_page(RAMState *rs, PageSearchSt=
atus *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    multifd_queue_page(block, offset);
+    if (multifd_queue_page(block, offset) < 0) {
+        return -1;
+    }
     ram_counters.normal++;
=20
     return 1;
--=20
2.21.0


