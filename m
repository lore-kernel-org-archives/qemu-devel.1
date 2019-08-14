Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C20C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DF620844
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 02:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DF620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxidt-0002oR-8r
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 22:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1hxicQ-0001Ew-JJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hxicP-0005Gb-Gf
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hxicO-0005Fa-LU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 22:02:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F515811BF
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-78.ams2.redhat.com
 [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D0167AB43;
 Wed, 14 Aug 2019 02:02:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 04:02:14 +0200
Message-Id: <20190814020218.1868-3-quintela@redhat.com>
In-Reply-To: <20190814020218.1868-1-quintela@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 14 Aug 2019 02:02:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] migration: Make global sem_sync semaphore
 by channel
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

This makes easy to debug things because when you want for all threads
to arrive at that semaphore, you know which one your are waiting for.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ca11d43e30..4bdd201a4e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -661,6 +661,8 @@ typedef struct {
     uint64_t num_packets;
     /* pages sent through this channel */
     uint64_t num_pages;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
 }  MultiFDSendParams;
=20
 typedef struct {
@@ -896,8 +898,6 @@ struct {
     MultiFDSendParams *params;
     /* array of pages to sent */
     MultiFDPages_t *pages;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
     /* global number of generated multifd packets */
     uint64_t packet_num;
     /* send channels ready */
@@ -1038,6 +1038,7 @@ void multifd_save_cleanup(void)
         p->c =3D NULL;
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name =3D NULL;
         multifd_pages_clear(p->pages);
@@ -1047,7 +1048,6 @@ void multifd_save_cleanup(void)
         p->packet =3D NULL;
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
-    qemu_sem_destroy(&multifd_send_state->sem_sync);
     g_free(multifd_send_state->params);
     multifd_send_state->params =3D NULL;
     multifd_pages_clear(multifd_send_state->pages);
@@ -1092,7 +1092,7 @@ static void multifd_send_sync_main(void)
         MultiFDSendParams *p =3D &multifd_send_state->params[i];
=20
         trace_multifd_send_sync_main_wait(p->id);
-        qemu_sem_wait(&multifd_send_state->sem_sync);
+        qemu_sem_wait(&p->sem_sync);
     }
     trace_multifd_send_sync_main(multifd_send_state->packet_num);
 }
@@ -1152,7 +1152,7 @@ static void *multifd_send_thread(void *opaque)
             qemu_mutex_unlock(&p->mutex);
=20
             if (flags & MULTIFD_FLAG_SYNC) {
-                qemu_sem_post(&multifd_send_state->sem_sync);
+                qemu_sem_post(&p->sem_sync);
             }
             qemu_sem_post(&multifd_send_state->channels_ready);
         } else if (p->quit) {
@@ -1175,7 +1175,7 @@ out:
      */
     if (ret !=3D 0) {
         if (flags & MULTIFD_FLAG_SYNC) {
-            qemu_sem_post(&multifd_send_state->sem_sync);
+            qemu_sem_post(&p->sem_sync);
         }
         qemu_sem_post(&multifd_send_state->channels_ready);
     }
@@ -1221,7 +1221,6 @@ int multifd_save_setup(void)
     multifd_send_state =3D g_malloc0(sizeof(*multifd_send_state));
     multifd_send_state->params =3D g_new0(MultiFDSendParams, thread_coun=
t);
     multifd_send_state->pages =3D multifd_pages_init(page_count);
-    qemu_sem_init(&multifd_send_state->sem_sync, 0);
     qemu_sem_init(&multifd_send_state->channels_ready, 0);
=20
     for (i =3D 0; i < thread_count; i++) {
@@ -1229,6 +1228,7 @@ int multifd_save_setup(void)
=20
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->sem_sync, 0);
         p->quit =3D false;
         p->pending_job =3D 0;
         p->id =3D i;
--=20
2.21.0


