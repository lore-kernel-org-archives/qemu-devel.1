Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46310C32750
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208D920844
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208D920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxifv-0005Ya-D7
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hxicV-0001K0-Nw
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hxicU-0005J3-ML
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hxicU-0005Id-Ec
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF9ED3082E0F
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:02:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 188FD7AB44;
 Wed, 14 Aug 2019 02:02:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 04:02:16 +0200
Message-Id: <20190814020218.1868-5-quintela@redhat.com>
In-Reply-To: <20190814020218.1868-1-quintela@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 14 Aug 2019 02:02:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/6] migration: Make multifd threads wait until
 all have been created
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it clear that no thread handles any incoming message until
all threads have been created.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 24 ++++++++++++++++++++++--
 migration/trace-events |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4a6ae677a9..f1aec95f83 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -702,6 +702,8 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* thread can continue */
+    QemuSemaphore can_start;
 } MultiFDRecvParams;
=20
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **err=
p)
@@ -1313,6 +1315,7 @@ int multifd_load_cleanup(Error **errp)
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->can_start);
         g_free(p->name);
         p->name =3D NULL;
         multifd_pages_clear(p->pages);
@@ -1366,6 +1369,9 @@ static void *multifd_recv_thread(void *opaque)
     trace_multifd_recv_thread_start(p->id);
     rcu_register_thread();
=20
+    qemu_sem_wait(&p->can_start);
+    trace_multifd_recv_thread_can_start(p->id);
+
     while (true) {
         uint32_t used;
         uint32_t flags;
@@ -1445,6 +1451,7 @@ int multifd_load_setup(void)
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->can_start, 0);
         p->quit =3D false;
         p->id =3D i;
         p->pages =3D multifd_pages_init(page_count);
@@ -1477,6 +1484,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
 {
     MultiFDRecvParams *p;
     Error *local_err =3D NULL;
+    bool last_one;
     int id;
=20
     id =3D multifd_recv_initial_packet(ioc, &local_err);
@@ -1506,8 +1514,20 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Err=
or **errp)
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
                        QEMU_THREAD_JOINABLE);
     atomic_inc(&multifd_recv_state->count);
-    return atomic_read(&multifd_recv_state->count) =3D=3D
-           migrate_multifd_channels();
+
+    last_one =3D  atomic_read(&multifd_recv_state->count)
+        =3D=3D migrate_multifd_channels();
+
+    if (last_one) {
+        int i;
+
+        for (i =3D 0; i < migrate_multifd_channels(); i++) {
+            MultiFDRecvParams *p =3D &multifd_recv_state->params[i];
+
+            qemu_sem_post(&p->can_start);
+        }
+    }
+    return last_one;
 }
=20
 /**
diff --git a/migration/trace-events b/migration/trace-events
index dd13a5c4b1..9fbef614ab 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -86,6 +86,7 @@ multifd_recv_sync_main(long packet_num) "packet num %ld=
"
 multifd_recv_sync_main_signal(uint8_t id) "channel %d"
 multifd_recv_sync_main_wait(uint8_t id) "channel %d"
 multifd_recv_terminate_threads(bool error) "error %d"
+multifd_recv_thread_can_start(uint8_t id) "channel %d"
 multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %" PRIu64
 multifd_recv_thread_start(uint8_t id) "%d"
 multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t fl=
ags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages =
%d flags 0x%x next packet size %d"
--=20
2.21.0


