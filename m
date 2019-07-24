Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BB9C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8454204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8454204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqE0T-0007Mg-QR
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqE07-0005wp-D8
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqE05-0004SY-9T
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqE05-0004SN-4B
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:55:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CB268CB4B;
 Wed, 24 Jul 2019 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C18360BEC;
 Wed, 24 Jul 2019 09:55:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 11:55:23 +0200
Message-Id: <20190724095523.1527-5-quintela@redhat.com>
In-Reply-To: <20190724095523.1527-1-quintela@redhat.com>
References: <20190724095523.1527-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 24 Jul 2019 09:55:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] migration: fix migrate_cancel multifd
 migration leads destination hung forever
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

When migrate_cancel a multifd migration, if run sequence like this:

        [source]                              [destination]

multifd_send_sync_main[finish]
                                    multifd_recv_thread wait &p->sem_sync
shutdown to_dst_file
                                    detect error from_src_file
send  RAM_SAVE_FLAG_EOS[fail]       [no chance to run multifd_recv_sync_m=
ain]
                                    multifd_load_cleanup
                                    join multifd receive thread forever

will lead destination qemu hung at following stack:

pthread_join
qemu_thread_join
multifd_load_cleanup
process_incoming_migration_co
coroutine_trampoline

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <1561468699-9819-4-git-send-email-ivanren@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index eb6716710e..889148dd84 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1292,6 +1292,11 @@ int multifd_load_cleanup(Error **errp)
=20
         if (p->running) {
             p->quit =3D true;
+            /*
+             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle =
code,
+             * however try to wakeup it without harm in cleanup phase.
+             */
+            qemu_sem_post(&p->sem_sync);
             qemu_thread_join(&p->thread);
         }
         object_unref(OBJECT(p->c));
--=20
2.21.0


