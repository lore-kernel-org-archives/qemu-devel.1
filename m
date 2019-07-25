Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2535C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5818218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5818218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbRf-00007c-Ns
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqbRJ-0007Jh-Fn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqbRI-0006Fz-H1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52496)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqbRI-0006E8-BS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E2DE30C133C;
 Thu, 25 Jul 2019 10:57:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-190.ams2.redhat.com
 [10.36.117.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 522C619C7F;
 Thu, 25 Jul 2019 10:57:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 12:57:22 +0200
Message-Id: <20190725105724.2562-3-quintela@redhat.com>
In-Reply-To: <20190725105724.2562-1-quintela@redhat.com>
References: <20190725105724.2562-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 25 Jul 2019 10:57:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/4] migration: fix migrate_cancel leads
 live_migration thread hung forever
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
hung forever at some points, because of multifd_send_thread has already
exit for socket error:
1. multifd_send_pages may hung at qemu_sem_wait(&multifd_send_state->
   channels_ready)
2. multifd_send_sync_main my hung at qemu_sem_wait(&multifd_send_state->
   sem_sync)

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Message-Id: <1561468699-9819-3-git-send-email-ivanren@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>

---

Remove spurious not needed bits
---
 migration/ram.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52a2d498e4..87bb7da8e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1097,7 +1097,8 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
     Error *local_err =3D NULL;
-    int ret;
+    int ret =3D 0;
+    uint32_t flags =3D 0;
=20
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
@@ -1115,7 +1116,7 @@ static void *multifd_send_thread(void *opaque)
         if (p->pending_job) {
             uint32_t used =3D p->pages->used;
             uint64_t packet_num =3D p->packet_num;
-            uint32_t flags =3D p->flags;
+            flags =3D p->flags;
=20
             p->next_packet_size =3D used * qemu_target_page_size();
             multifd_send_fill_packet(p);
@@ -1164,6 +1165,17 @@ out:
         multifd_send_terminate_threads(local_err);
     }
=20
+    /*
+     * Error happen, I will exit, but I can't just leave, tell
+     * who pay attention to me.
+     */
+    if (ret !=3D 0) {
+        if (flags & MULTIFD_FLAG_SYNC) {
+            qemu_sem_post(&multifd_send_state->sem_sync);
+        }
+        qemu_sem_post(&multifd_send_state->channels_ready);
+    }
+
     qemu_mutex_lock(&p->mutex);
     p->running =3D false;
     qemu_mutex_unlock(&p->mutex);
--=20
2.21.0


