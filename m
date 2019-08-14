Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E39BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3369720844
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3369720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxifv-0005YK-4v
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hxicS-0001FD-N5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hxicR-0005IK-MH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hxicR-0005I5-Dh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB0378E589
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B309E7AB44;
 Wed, 14 Aug 2019 02:02:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 04:02:15 +0200
Message-Id: <20190814020218.1868-4-quintela@redhat.com>
In-Reply-To: <20190814020218.1868-1-quintela@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 14 Aug 2019 02:02:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/6] migration: Make sure that all multifd
 channels have been created
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

If we start the migration before all have been created, we have to
handle the case that one channel still don't exist.  This way it is
easier.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c        | 14 ++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 15 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 4bdd201a4e..4a6ae677a9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -663,6 +663,8 @@ typedef struct {
     uint64_t num_pages;
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
+    /* thread has started and setup is done */
+    QemuSemaphore started;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -1039,6 +1041,7 @@ void multifd_save_cleanup(void)
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
         qemu_sem_destroy(&p->sem_sync);
+        qemu_sem_destroy(&p->started);
         g_free(p->name);
         p->name =3D NULL;
         multifd_pages_clear(p->pages);
@@ -1113,6 +1116,8 @@ static void *multifd_send_thread(void *opaque)
     /* initial packet */
     p->num_packets =3D 1;
=20
+    qemu_sem_post(&p->started);
+
     while (true) {
         qemu_sem_wait(&p->sem);
         qemu_mutex_lock(&p->mutex);
@@ -1229,6 +1234,7 @@ int multifd_save_setup(void)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
+        qemu_sem_init(&p->started, 0);
         p->quit =3D false;
         p->pending_job =3D 0;
         p->id =3D i;
@@ -3486,6 +3492,14 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
=20
+    /* We want to wait for all threads to have started before doing
+     * anything else */
+    for (int i =3D 0; i < migrate_multifd_channels(); i++) {
+        MultiFDSendParams *p =3D &multifd_send_state->params[i];
+
+        qemu_sem_wait(&p->started);
+        trace_multifd_send_thread_started(p->id);
+    }
     multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     qemu_fflush(f);
diff --git a/migration/trace-events b/migration/trace-events
index 886ce70ca0..dd13a5c4b1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -95,6 +95,7 @@ multifd_send_sync_main_wait(uint8_t id) "channel %d"
 multifd_send_terminate_threads(bool error) "error %d"
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "c=
hannel %d packets %" PRIu64 " pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%d"
+multifd_send_thread_started(uint8_t id) "channel %d"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: s=
tart: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) =
"%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
--=20
2.21.0


